package ai.maum.biz.fastaicc.main.cousult.outbound.controller;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCommonCdVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CustDataClassVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CustInfoVO;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Map.Entry;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.ClientAnchor;
import org.apache.poi.ss.usermodel.Comment;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.DataValidation;
import org.apache.poi.ss.usermodel.DataValidationConstraint;
import org.apache.poi.ss.usermodel.DataValidationConstraint.OperatorType;
import org.apache.poi.ss.usermodel.DataValidationHelper;
import org.apache.poi.ss.usermodel.Drawing;
import org.apache.poi.ss.usermodel.RichTextString;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFDataValidation;
import org.apache.poi.xssf.usermodel.XSSFDataValidationConstraint;
import org.apache.poi.xssf.usermodel.XSSFDataValidationHelper;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.WebUtils;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.common.domain.PagingVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCampaignInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonMonitoringService;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.cousult.common.service.ConsultingService;
import ai.maum.biz.fastaicc.main.cousult.inbound.domain.SipAccountVO;
import ai.maum.biz.fastaicc.main.cousult.inbound.service.InboundMonitoringService;
import ai.maum.biz.fastaicc.main.cousult.outbound.domain.CallHistoryVO;
import ai.maum.biz.fastaicc.main.cousult.outbound.service.OutboundMonitoringService;
import ai.maum.biz.fastaicc.main.user.domain.AuthenticaionVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import ai.maum.biz.fastaicc.main.user.service.AuthService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class OutboundConsultingController {
	/* 공통서비스 */
	@Autowired
	CommonService commonService;

	/* 권한 서비스 */
	@Autowired
	AuthService authService;
	/* 상담서비스 */
	@Autowired
	ConsultingService consultingService;
	/* 아웃바운드 이전서비스 */
    @Autowired
    OutboundMonitoringService outboundMonitoringService;
	/* 인바운드 모니터 서비스 */
	@Autowired
	InboundMonitoringService inboundMonitoringService;
	/*설정값 */
	@Inject
	VariablesMng variablesMng;

	@Autowired
	CustomProperties customProperties;

	@Autowired
    PasswordEncoder passwordEncoder;

	@Autowired
    CommonMonitoringService commonMonitoringService;

	/* 인바운드 모니터링 main화면 */
	@RequestMapping(value = "/userDataManagement", method = { RequestMethod.GET, RequestMethod.POST })
	public String userDataManagement(FrontMntVO frontMntVO, HttpServletRequest req, Model model)
      throws ParseException, IOException {

		frontMntVO.setPageInitPerPage("20");
//		obCsMain(frontMntVO, req, model);
		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
	    String companyId = "";
		String custOpType = outboundMonitoringService.getCustOpType(userId);
		Map<String,Object> companyMap = new HashMap<>();
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=(AuthenticaionVO)auth;
			UserVO userVo = userDto.getUser();
			if(userVo!=null) {
				if(!userVo.getUserAuthTy().equals("S")){
					companyId = userVo.getCompanyId();
				}
				frontMntVO.setSchCompanyId(companyId);
				companyMap.put("userAuthTy", userVo.getUserAuthTy().toString());
				if(userVo != null && !userVo.getUserAuthTy().equals("S") && !userVo.getUserAuthTy().equals("A")) { // consultant
					companyMap.put("userId",userVo.getUserId().toString());
				}

			}
		}
		companyMap.put("companyId", companyId);
		companyMap.put("pageType", "");
		frontMntVO.setSessId(userId);

		List<Map<String, Object>> campaignList = outboundMonitoringService.getCampaignList(companyMap);

		if (campaignList.size() > 0) {
			frontMntVO.setCampaignId(String.valueOf(campaignList.get(0).get("CAMPAIGN_ID")));
		}
		Map<String, Object> custClassMap = new HashMap<>();
		if (frontMntVO.getPageInitPerPage() == null) {
			custClassMap.put("displayYn", "y");
		}
	    //페이징을 위해서 쿼리 포함 전체 카운팅
	    PagingVO pagingVO = new PagingVO();
		pagingVO.setCOUNT_PER_PAGE(frontMntVO.getPageInitPerPage());
		pagingVO.setTotalCount(outboundMonitoringService.getOutboundCallMntCount(frontMntVO));
	    pagingVO.setCurrentPage(frontMntVO.getCurrentPage());
	    frontMntVO.setStartRow(pagingVO.getStartRow());
	    frontMntVO.setLastRow(pagingVO.getLastRow());

		PagingVO queuePagingVO = new PagingVO();
		queuePagingVO.setCOUNT_PER_PAGE("15");
		queuePagingVO.setTotalCount(outboundMonitoringService.getCallQueueCount(frontMntVO));
		queuePagingVO.setCurrentPage(frontMntVO.getCurrentPage());

	    // 음성 봇 리스트
	    frontMntVO.setCall_type_code("N");//콜타입 (IB & OB)
	    List<SipAccountVO> phoneListResult = inboundMonitoringService.getPhoneList(frontMntVO);
	    // 캠페인 name 조회
	    for (int i = 0; i < phoneListResult.size(); i++) {
	      phoneListResult.get(i).setCampaignNm(
	          outboundMonitoringService.getCampaignNm(phoneListResult.get(i).getCampaignId()));
	    }
	    List<CmCommonCdVO> commonList = outboundMonitoringService.getCommonList();

	    model.addAttribute("phoneListResult", phoneListResult);
	    //DB에서 전체 리스트 SELECT.
	    frontMntVO.setPageInitPerPage(String.valueOf(pagingVO.getCOUNT_PER_PAGE()));
			List<CmContractVO> list = new ArrayList<>();
			List<CustInfoVO> callQueueList = new ArrayList<>();
			if (campaignList.size() > 0) {
				list = outboundMonitoringService.getOutboundCallMntList(frontMntVO);
				frontMntVO.setPageInitPerPage("15");
				callQueueList = outboundMonitoringService.getCallQueueList(frontMntVO);
			}

			String locale = req.getParameter("lang");

			if(locale!=null) {
				req.setAttribute("locale",locale);
			} else {
				Cookie langCookie = WebUtils.getCookie(req,"lang");
				if(langCookie!=null){
					locale=langCookie.getValue();
					req.setAttribute("locale",langCookie.getValue());
				} else {
					locale="ko";
					req.setAttribute("locale","ko");
				}
			}

			if (campaignList.size() > 0) {
				custClassMap.put("campaignId", String.valueOf(campaignList.get(0).get("CAMPAIGN_ID")));
			}
		    List<CustDataClassVO> custDataClassList = outboundMonitoringService.getCustDataClass(custClassMap);

			List<CustDataClassVO> nameTelColType = outboundMonitoringService.getNameTelType(custClassMap);
		    // custData json 파싱
			for (int i = 0; i < list.size(); i++) {
				String custData = "";
				Map<String, Object> map = null;
				JsonParser jp = new JsonParser();
				if (list.get(i).getCustData() != null && !list.get(i).getCustData().equals("")) {
					JsonObject jsonObj = (JsonObject) jp.parse(list.get(i).getCustData());
					map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
					List<String> custDataList = new ArrayList<>();
					for (int j = 0; j < custDataClassList.size(); j++) {
						custData = (String) map.get(custDataClassList.get(j).getCustDataClassId() + "");
						custDataList.add(custData);
					}
					list.get(i).setCustDataList(custDataList);
				}
			}
			for (int i = 0; i < callQueueList.size(); i++) {
				String custData = "";
				Map<String, Object> map = null;
				JsonParser jp = new JsonParser();
				if (callQueueList.get(i).getCustData() != null) {
					JsonObject jsonObj = (JsonObject) jp.parse(callQueueList.get(i).getCustData());
					map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
					List<String> custDataList = new ArrayList<>();
					for (int j = 0; j < custDataClassList.size(); j++) {
						custData = (String) map.get(custDataClassList.get(j).getCustDataClassId() + "");
						custDataList.add(custData);
					}
					callQueueList.get(i).setCustDataList(custDataList);
				}
			}

			Map map = new HashMap();
			map.put("FIRST_CD", "24");
			map.put("locale", locale);
			List<Map> cmmCd24List = commonService.getCmmCdList(map);
			model.addAttribute("cmmCd24List", cmmCd24List); // 공통코드 (통화결과 24)
			map.put("FIRST_CD", "23");
			List<Map> cmmCd23List = commonService.getCmmCdList(map);
			model.addAttribute("cmmCd23List", cmmCd23List); // 공통코드 (시도결과 23)

		    //콜백 요청 cnt (사이드)
		    map.put("sessId", userId);
		    map.put("inboundYn", "N");
		    List<Map> callbackList = consultingService.getCallbackList(map);
		    //리콜요청 CNT (사이드)
		    List<Map> recallList = consultingService.getRecallList(map);

		    /////////////////////////////////////////////
		    // model.addAttribute("frontMntVO", frontMntVO);
		    model.addAttribute("colList", custDataClassList);
		    model.addAttribute("csType", "OB"); // 아웃바운드 체크
		    model.addAttribute("list",list);                                                        // 페이지 리스트.
		    model.addAttribute("websocketUrl", customProperties.getWebsocketProtocol() + "://"
		        + customProperties.getWebsocketIp() + customProperties.getWebsocketPort()); //웹소켓URL
		    model.addAttribute("voiceUrl", customProperties.getWebsocketProtocol() + "://"
		        + customProperties.getVoiceIp() + customProperties.getVoicePort()); // 웹소켓URL
		    model.addAttribute("proxyUrl", customProperties.getProxyProtocol() + "://"
		        + customProperties.getProxyIp() + customProperties.getProxyPort()); // 웹소켓 proxy URL
		    model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		    model.addAttribute("callbackReqCnt", callbackList.size()); // 콜백요청 카운트
		    model.addAttribute("recallReqCnt", recallList.size()); // 리콜요청 카운트
		    model.addAttribute("sessId", userId); // 리콜요청 카운트
		    model.addAttribute("paging", pagingVO);
			model.addAttribute("queuePagingVO", queuePagingVO);
		    model.addAttribute("campaignList", campaignList);
			model.addAttribute("commonList", commonList);
			model.addAttribute("nameTelColType", nameTelColType);
			model.addAttribute("callQueueList", callQueueList);
			model.addAttribute("custOpType", custOpType);

		return "system_manage/system_user_data_manage";
	}




  @RequestMapping(value = "/obCsMain", method = { RequestMethod.GET, RequestMethod.POST })
  public String obCsMain(FrontMntVO frontMntVO, HttpServletRequest req, Model model)
      throws ParseException, IOException {

		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
	    String companyId = "";
		String custOpType = outboundMonitoringService.getCustOpType(userId);

	  	Map<String,Object> companyMap = new HashMap<>();
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=(AuthenticaionVO)auth;
			UserVO userVo = userDto.getUser();
			if(userVo!=null) {
				companyId = userVo.getCompanyId();
				frontMntVO.setSchCompanyId(companyId);
				companyMap.put("userAuthTy", userVo.getUserAuthTy().toString());
				if(userVo != null && !userVo.getUserAuthTy().equals("S") && !userVo.getUserAuthTy().equals("A")) { // consultant
					companyMap.put("userId",userVo.getUserId().toString());
				}

			}
		}

		companyMap.put("companyId", companyId);
		companyMap.put("pageType", "outbound");
		
		frontMntVO.setSessId(userId);

		List<Map<String, Object>> campaignList = outboundMonitoringService.getCampaignList(companyMap);
		if (campaignList.size() > 0) {
			frontMntVO.setCampaignId(String.valueOf(campaignList.get(0).get("CAMPAIGN_ID")));
		}
		Map<String, Object> custClassMap = new HashMap<>();
		if (frontMntVO.getPageInitPerPage() == null) {
			custClassMap.put("displayYn", "y");
		}
    //페이징을 위해서 쿼리 포함 전체 카운팅
    PagingVO pagingVO = new PagingVO();
		pagingVO.setCOUNT_PER_PAGE(frontMntVO.getPageInitPerPage());
		pagingVO.setTotalCount(outboundMonitoringService.getOutboundCallMntCount(frontMntVO));
    pagingVO.setCurrentPage(frontMntVO.getCurrentPage());
    frontMntVO.setStartRow(pagingVO.getStartRow());
    frontMntVO.setLastRow(pagingVO.getLastRow());

		PagingVO queuePagingVO = new PagingVO();
		queuePagingVO.setCOUNT_PER_PAGE("15");
		queuePagingVO.setTotalCount(outboundMonitoringService.getCallQueueCount(frontMntVO));
		queuePagingVO.setCurrentPage(frontMntVO.getCurrentPage());

    // 음성 봇 리스트
    frontMntVO.setCall_type_code("N");//콜타입 (IB & OB)
    List<SipAccountVO> phoneListResult = inboundMonitoringService.getPhoneList(frontMntVO);
    // 캠페인 name 조회
    for (int i = 0; i < phoneListResult.size(); i++) {
      phoneListResult.get(i).setCampaignNm(
          outboundMonitoringService.getCampaignNm(phoneListResult.get(i).getCampaignId()));
    }
    // 상담 상단 상태바 조회 OB total
    List<Map> opTotalObStateList = consultingService.getOpTotalObStateList(frontMntVO);
    // 상담 상단 상태바 조회 OB user
    List<Map> opUserObStateList = consultingService.getOpUserObStateList(frontMntVO);
    //상담 상단 상태바 조회 수신대기, 업무, 휴게
    List<Map> opStatus = consultingService.getOpIbStateList(frontMntVO);
    List<CmCommonCdVO> commonList = outboundMonitoringService.getCommonList();

    model.addAttribute("phoneListResult", phoneListResult);
    //DB에서 전체 리스트 SELECT.
    frontMntVO.setPageInitPerPage(String.valueOf(pagingVO.getCOUNT_PER_PAGE()));
		List<CmContractVO> list = new ArrayList<>();
		List<CustInfoVO> callQueueList = new ArrayList<>();
		if (campaignList.size() > 0) {
			list = outboundMonitoringService.getOutboundCallMntList(frontMntVO);
			frontMntVO.setPageInitPerPage("15");
			callQueueList = outboundMonitoringService.getCallQueueList(frontMntVO);
		}

		String locale = req.getParameter("lang");

		if(locale!=null) {
			req.setAttribute("locale",locale);
		} else {
			Cookie langCookie = WebUtils.getCookie(req,"lang");
			if(langCookie!=null){
				locale=langCookie.getValue();
				req.setAttribute("locale",langCookie.getValue());
			} else {
				locale="ko";
				req.setAttribute("locale","ko");
			}
		}

		if (campaignList.size() > 0) {
			custClassMap.put("campaignId", String.valueOf(campaignList.get(0).get("CAMPAIGN_ID")));
		}
    List<CustDataClassVO> custDataClassList = outboundMonitoringService.getCustDataClass(custClassMap);

		List<CustDataClassVO> nameTelColType = outboundMonitoringService.getNameTelType(custClassMap);
    // custData json 파싱
		for (int i = 0; i < list.size(); i++) {
			String custData = "";
			Map<String, Object> map = null;
			JsonParser jp = new JsonParser();
			if (list.get(i).getCustData() != null && !list.get(i).getCustData().equals("")) {
				JsonObject jsonObj = (JsonObject) jp.parse(list.get(i).getCustData());
				map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
				List<String> custDataList = new ArrayList<>();
				for (int j = 0; j < custDataClassList.size(); j++) {
					custData = (String) map.get(custDataClassList.get(j).getCustDataClassId() + "");
					custDataList.add(custData);
				}
				list.get(i).setCustDataList(custDataList);
			}
		}
		for (int i = 0; i < callQueueList.size(); i++) {
			String custData = "";
			Map<String, Object> map = null;
			JsonParser jp = new JsonParser();
			if (callQueueList.get(i).getCustData() != null) {
				JsonObject jsonObj = (JsonObject) jp.parse(callQueueList.get(i).getCustData());
				map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
				List<String> custDataList = new ArrayList<>();
				for (int j = 0; j < custDataClassList.size(); j++) {
					custData = (String) map.get(custDataClassList.get(j).getCustDataClassId() + "");
					custDataList.add(custData);
				}
				callQueueList.get(i).setCustDataList(custDataList);
			}
		}

		Map map = new HashMap();
		map.put("FIRST_CD", "24");
		map.put("locale", locale);
		List<Map> cmmCd24List = commonService.getCmmCdList(map);
		model.addAttribute("cmmCd24List", cmmCd24List); // 공통코드 (통화결과 24)
		map.put("FIRST_CD", "23");
		List<Map> cmmCd23List = commonService.getCmmCdList(map);
		model.addAttribute("cmmCd23List", cmmCd23List); // 공통코드 (시도결과 23)

    //콜백 요청 cnt (사이드)
    map.put("sessId", userId);
    map.put("inboundYn", "N");
    List<Map> callbackList = consultingService.getCallbackList(map);
    //리콜요청 CNT (사이드)
    List<Map> recallList = consultingService.getRecallList(map);

    /////////////////////////////////////////////
    // model.addAttribute("frontMntVO", frontMntVO);
    model.addAttribute("colList", custDataClassList);
    model.addAttribute("csType", "OB"); // 아웃바운드 체크
    model.addAttribute("opTotalObStateList",
        new Gson().toJson(opTotalObStateList)); // 상담 상단 상태바 조회 OB total
    model.addAttribute("opUserObStateList",
        new Gson().toJson(opUserObStateList)); // 상담 상단 상태바 조회 OB user
    model.addAttribute("list",
        list);                                                        // 페이지 리스트.
    model.addAttribute("websocketUrl", customProperties.getWebsocketProtocol() + "://"
        + customProperties.getWebsocketIp() + customProperties.getWebsocketPort()); //웹소켓URL
    model.addAttribute("voiceUrl", customProperties.getWebsocketProtocol() + "://"
        + customProperties.getVoiceIp() + customProperties.getVoicePort()); // 웹소켓URL
    model.addAttribute("proxyUrl", customProperties.getProxyProtocol() + "://"
        + customProperties.getProxyIp() + customProperties.getProxyPort()); // 웹소켓 proxy URL
    model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
    model.addAttribute("opStatus", new Gson().toJson(opStatus));
    model.addAttribute("callbackReqCnt", callbackList.size()); // 콜백요청 카운트
    model.addAttribute("recallReqCnt", recallList.size()); // 리콜요청 카운트
    model.addAttribute("sessId", userId); // 리콜요청 카운트
    model.addAttribute("paging", pagingVO);
		model.addAttribute("queuePagingVO", queuePagingVO);
    model.addAttribute("campaignList", campaignList);
		model.addAttribute("commonList", commonList);
		model.addAttribute("nameTelColType", nameTelColType);
		model.addAttribute("callQueueList", callQueueList);
		model.addAttribute("custOpType", custOpType);

		return "/consulting/outboundConsulting";

  }

	/***
	 * obUserInfo 인바운드 상담 사용자 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/obUserInfo", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> ibUserInfo(@RequestBody String jsonStr,FrontMntVO frontMntVO)
			throws JsonParseException, JsonMappingException, IOException {
		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();

		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		frontMntVO.setCno(map.get("CONTRACT_NO").toString());

		//DB에서 전체 리스트 SELECT.
    CmContractVO topInfo = outboundMonitoringService.getOutboundCallMntData(frontMntVO);
    frontMntVO.setCampaignId(topInfo.getCampaignId());
    frontMntVO.setCallId(topInfo.getCallId());

    // OB고객정보 >> OB결과 & 재통화
    String callId = topInfo.getCallId();
		List<CallHistoryVO> userObResultRecall = null;
		// 채팅정보
		List<Map> userChatList = null;
		// 구간 탐지
		List<Map> userCampSList = null;
		// 고객 상담내용 정보
		List<Map> userCsDtlList = null;
		// 고객 채팅(탐지정보)
		List<Map> csContList = null;
		// 캠페인 탐지정보
		List<CmCampaignInfoVO> mntResult = null;

		//agentClick으로 접근
		if(!"Y".equals(map.get("singularYn"))) {
			// 채팅정보
			userChatList = consultingService.getUserChatList(map);
			// 구간 탐지
			userCampSList = consultingService.getUserCampSList(map);
			// 고객 상담내용 정보
			userCsDtlList = consultingService.getUserCsDtlList(map);
			// 고객 채팅(탐지정보)
			csContList = consultingService.getCsContList(map);
			// 캠페인탐지정보
			mntResult = commonMonitoringService.getCallPopMonitoringResultList(frontMntVO);
			// OB고객정보 >> OB결과 & 재통화
			userObResultRecall = consultingService.getUserObResultRecall(callId);
		}

		// 고객정보 > 단순 고객조회
		List<Map> userInfoList = consultingService.getUserInfoList(map);
		if (userInfoList.size() > 0) {
			// 고객 결제 정보
			List<Map> userPaymentList = consultingService.getUserPaymentList(userInfoList.get(0));
			map.put("userPaymentList", new Gson().toJson(userPaymentList)); // 고객 결제 정보

			// 고객 상담이력정보 정보(사이드 리스트 ) -- 추가 조건 필요 할것이라 느껴짐 켐페인값이라던지..
			map.put("inboundYn", "N");
			map.put("userId", userId);
			List<Map> csHisList = consultingService.getCsHisList(map);
			map.put("csHisList", new Gson().toJson(csHisList)); // 고객 상담이력정보 정보
		}


		// 리턴 값
		map.put("csContList", new Gson().toJson(csContList)); // 고객 채팅(탐지정보)
		map.put("userCsDtlList", new Gson().toJson(userCsDtlList)); // 고객 상담내용 정보
		map.put("userChatList", new Gson().toJson(userChatList)); // 채팅정보
		map.put("userCampSList", new Gson().toJson(userCampSList)); // 구간 탐지
		map.put("userInfoList", new Gson().toJson(userInfoList)); // 사용자
		map.put("mntResult", new Gson().toJson(mntResult)); // 사용자
		map.put("userObResultRecall", new Gson().toJson(userObResultRecall));//OB 고객정보 >> OB결과&재통화
		return map;
	}
	/***
	 * obUserInfo 인바운드 상담 사용자 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getObUserInfo", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> getObUserInfo(@RequestBody String jsonStr,FrontMntVO frontMntVO)
			throws JsonParseException, JsonMappingException, IOException, ParseException {
		log.debug("jsonStr====" + jsonStr);
		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		frontMntVO.setCampaignId(String.valueOf(map.get("CAMPAIGN_ID")));
		frontMntVO.setCustId(String.valueOf(map.get("CUST_ID")));
		frontMntVO.setStartRow(0);
		frontMntVO.setPageInitPerPage("1");
		Map<String, Object> custClassMap = new HashMap<>();
		custClassMap.put("campaignId", String.valueOf(map.get("CAMPAIGN_ID")));
		custClassMap.put("displayYn", "y");
		List<CustDataClassVO> custDataClassList = outboundMonitoringService.getCustDataClass(custClassMap);
		List<CmContractVO> custInfo = outboundMonitoringService.getOutboundCallMntList(frontMntVO);

		map.put("colList", custDataClassList);
		String custData = "";
		Map<String, Object> custMap = null;
		JsonObject custJsonObj = (JsonObject) jp.parse(custInfo.get(0).getCustData());
		custMap = new ObjectMapper().readValue(custJsonObj.toString(), Map.class);
		List<String> custDataList = new ArrayList<>();
		for (int j = 0; j < custDataClassList.size(); j++) {
			custData = (String) custMap.get(custDataClassList.get(j).getCustDataClassId() + "");
			custDataList.add(custData);
		}
		custInfo.get(0).setCustDataList(custDataList);
		map.put("custInfo", custInfo);

		return map;
	}


	/***
	 * setObUserCsDtl 상담내용 저장 ( 상담유형 메모 = CallHistory / 재통화 =RecallHistory / 상태  = OpInfo )
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/setObUserCsDtl", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> setUserCsDtl(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();

		//상담내용 > 쿼리 새로 생성해야 할듯.
		//OB결과 > 시도결과, 통화결과, 상담메모
		Map<String, Object> CsObResult = new ObjectMapper().readValue(jsonObj.get("CsObResult").toString(), Map.class);
		CsObResult.put("CUST_OP_ID", userId);
		CsObResult.put("inboundYn", "N");
		consultingService.updateCallHistory(CsObResult);

		//재통화 > 인바운드랑 같음
		Map<String, Object> CsDtlReCallMap = new ObjectMapper().readValue(jsonObj.get("CsDtlReCall").toString(), Map.class);
		CsDtlReCallMap.put("CUST_OP_ID", userId);
		for (Entry<String, Object> entry: CsDtlReCallMap.entrySet()) {
		    if(entry.getValue().equals(""))entry.setValue(null);
		}
		consultingService.mergeRecallHistory(CsDtlReCallMap);

		//상담이력 조회
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		map.put("userId", userId);
		map.put("inboundYn", "N");
		List<Map> csHisList = consultingService.getCsHisList(map);
		map.put("csHisList", new Gson().toJson(csHisList)); // 고객 상담이력정보 정보

		return map;
	}

	/***
	 * getOpUserState OB상단 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getOpObState", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> getOpUserState(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		// 로그인 사용자 ID 가져오기
		FrontMntVO frontMntVO = new FrontMntVO();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		frontMntVO.setSessId(userId); 
		String companyId = "";
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=(AuthenticaionVO)auth;
			UserVO userVo = userDto.getUser();
			if(userVo!=null) {
				companyId = userVo.getCompanyId();
				frontMntVO.setSchCompanyId(companyId);
			}
		}
		
		//상태변화 플래그
		if("Y".equals(map.get("updateYn"))) {
			Map<String, Object> CsDtlOpStatusMap = new ObjectMapper().readValue(jsonObj.get("CsDtlOpStatus").toString(), Map.class);
			CsDtlOpStatusMap.put("CUST_OP_ID", userId);
			consultingService.updateCmOpInfo(CsDtlOpStatusMap);
		}
		//비밀번호 변경
		if("Y".equals(map.get("chUserPwYn"))) {
			Map<String, Object> ChUserPwMap = new ObjectMapper().readValue(jsonObj.get("chUserPw").toString(), Map.class);

			String originPw = passwordEncoder.encode(ChUserPwMap.get("originPw").toString());
			String chPw = passwordEncoder.encode(ChUserPwMap.get("pw1").toString());
			UserVO user = authService.getAccount(userId);

			ChUserPwMap.put("CUST_OP_ID", userId);
			ChUserPwMap.put("CUST_OP_ORIGIN_PW", originPw);
			ChUserPwMap.put("CUST_OP_CH_PW", chPw);
			ChUserPwMap.put("CUST_OP_USER_ID", user.getUserId());

			//비밀번호 확인(기존비밀번호 확인(raw data), 암호화되어 저장되어 있는 비밀번호)
			if (passwordEncoder.matches(ChUserPwMap.get("originPw").toString(), user.getPassword())) {
				//비밀번호 변경
				consultingService.updateUserPw(ChUserPwMap);
				map.put("editPwYn", true);
	        }else {
	        	//실패플래그 내려줌
				map.put("editPwYn", false);
	        }
		}

		//상담 상단 상태바 조회 수신대기, 업무, 휴게
		List<Map> opStatus = consultingService.getOpIbStateList(frontMntVO);
		// 상담 상단 상태바 조회 OB
		// 상담 상단 상태바 조회 OB total
		List<Map> opTotalObStateList = consultingService.getOpTotalObStateList(frontMntVO);
				// 상담 상단 상태바 조회 OB user
		List<Map> opUserObStateList = consultingService.getOpUserObStateList(frontMntVO);
		// 리턴 값
		map.put("opTotalObStateList", new Gson().toJson(opTotalObStateList)); // 상담 상단 상태바 조회 OB total
		map.put("opUserObStateList", new Gson().toJson(opUserObStateList)); // 상담 상단 상태바 조회 OB user
		map.put("opStatus",  new Gson().toJson(opStatus));
		return map;
	}

	/***
	 * 아웃바운드 상담 DB LIST 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 * @throws ParseException
	 */
	@RequestMapping(value = "/getNextList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> getNextList(@RequestBody String jsonStr,FrontMntVO frontMntVO)
			throws JsonParseException, JsonMappingException, IOException, ParseException {

		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		frontMntVO = searchColumn(jsonStr);
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		frontMntVO.setSessId(userId);
		frontMntVO.setCampaignId(String.valueOf(map.get("CAMPAIGN_ID")));
		frontMntVO.setPageInitPerPage(map.get("pageInitPerPage").toString());

		//페이징을 위해서 쿼리 포함 전체 카운팅

		PagingVO pagingVO = new PagingVO();
		Map<String, Object> custClassMap = new HashMap<>();
		custClassMap.put("campaignId", String.valueOf(map.get("CAMPAIGN_ID")));
		if (map.get("PAGE_COUNT").equals("10")) {
			custClassMap.put("displayYn", "y");
		} else {
			pagingVO.setCOUNT_PER_PAGE("20");
		}
		pagingVO.setTotalCount(outboundMonitoringService.getOutboundCallMntCount(frontMntVO));
		pagingVO.setCurrentPage(Integer.parseInt(map.get("cp").toString()));
		frontMntVO.setStartRow(pagingVO.getStartRow());
		frontMntVO.setLastRow(pagingVO.getLastRow());

		List<CmContractVO> list = outboundMonitoringService.getOutboundCallMntList(frontMntVO);
		List<CustDataClassVO> custDataClassList = outboundMonitoringService.getCustDataClass(custClassMap);

		// custData json 파싱
		for (int i = 0; i < list.size(); i++) {
			String custData = "";
			Map<String, Object> custMap = null;
			if (list.get(i).getCustData() == null || list.get(i).getCustData().isEmpty()) {
				continue;
			}
			JsonObject custJsonObj = (JsonObject) jp.parse(list.get(i).getCustData());
			custMap = new ObjectMapper().readValue(custJsonObj.toString(), Map.class);
			List<String> custDataList = new ArrayList<>();
			for (int j = 0; j < custDataClassList.size(); j++) {
				custData = (String) custMap.get(custDataClassList.get(j).getCustDataClassId() + "");
				custDataList.add(custData);
			}
			list.get(i).setCustDataList(custDataList);
		}

		map.put("list", new Gson().toJson(list)); // 사용자
		map.put("paging", new Gson().toJson(pagingVO)); // 사용자

		return map;
	}

	/***
	 * 콜큐 LIST 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 * @throws ParseException
	 */
	@RequestMapping(value = "/getCallQueueList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> getCallQueueList(@RequestBody String jsonStr,FrontMntVO frontMntVO)
			throws JsonParseException, JsonMappingException, IOException, ParseException {

		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		String custOpType = outboundMonitoringService.getCustOpType(userId);
		frontMntVO = searchColumn(jsonStr);
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		frontMntVO.setCampaignId(String.valueOf(map.get("CAMPAIGN_ID")));
		frontMntVO.setPageInitPerPage("15");

		//페이징을 위해서 쿼리 포함 전체 카운팅

		PagingVO pagingVO = new PagingVO();
		pagingVO.setCOUNT_PER_PAGE("15");
		Map<String, Object> custClassMap = new HashMap<>();
		custClassMap.put("campaignId", String.valueOf(map.get("CAMPAIGN_ID")));
		custClassMap.put("displayYn", "y");
		pagingVO.setTotalCount(outboundMonitoringService.getCallQueueCount(frontMntVO));
		pagingVO.setCurrentPage(Integer.parseInt(map.get("cp").toString()));
		frontMntVO.setStartRow(pagingVO.getStartRow());
		frontMntVO.setLastRow(pagingVO.getLastRow());

		List<CustInfoVO> list = outboundMonitoringService.getCallQueueList(frontMntVO);
		if (list.size() == 0) {
			pagingVO.setCurrentPage(pagingVO.getTotalPage());
			frontMntVO.setStartRow(pagingVO.getStartRow());
			frontMntVO.setLastRow(pagingVO.getLastRow());
			list = outboundMonitoringService.getCallQueueList(frontMntVO);
		}
		List<CustDataClassVO> custDataClassList = outboundMonitoringService.getCustDataClass(custClassMap);

		// custData json 파싱
		for (int i = 0; i < list.size(); i++) {
			String custData = "";
			Map<String, Object> custMap = null;
			JsonObject custJsonObj = (JsonObject) jp.parse(list.get(i).getCustData());
			custMap = new ObjectMapper().readValue(custJsonObj.toString(), Map.class);
			List<String> custDataList = new ArrayList<>();
			for (int j = 0; j < custDataClassList.size(); j++) {
				custData = (String) custMap.get(custDataClassList.get(j).getCustDataClassId() + "");
				custDataList.add(custData);
			}
			list.get(i).setCustDataList(custDataList);
		}

		map.put("callQueueList", list);
		map.put("queuePagingVO", pagingVO);
		map.put("colList", custDataClassList);
		map.put("sessId", userId);
		map.put("custOpType", custOpType);

		return map;
	}

	/***
	 * setUserEdt 고객정보 저장 ( 고객정보 =RecallHistory / 결재정보 = CallTranSferHistory /  )
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/setObUserEdt", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> setObUserEdt(@RequestBody String jsonStr, HttpServletRequest request)
			throws JsonParseException, JsonMappingException, IOException, ParseException {
		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		String jsonStrParam = jsonStr;
		CustInfoVO custInfoVO = new CustInfoVO();
		FrontMntVO frontMntVO = new FrontMntVO();
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		custInfoVO.setCustNm(String.valueOf(jsonObj.get("CUST_NM")).replace("\"", ""));
//		custInfoVO.setCustTelNo(String.valueOf(jsonObj.get("CUST_TEL_NO")).replace("\"", ""));
		custInfoVO.setCustId(Integer.parseInt(String.valueOf(jsonObj.get("CUST_ID")).replace("\"", "")));
		custInfoVO.setCampaignId(Integer.parseInt(String.valueOf(jsonObj.get("CAMPAIGN_ID")).replace("\"", "")));
		jsonObj.remove("CUST_NM");
		jsonObj.remove("CUST_TEL_NO");
		jsonObj.remove("CUST_ID");
		jsonObj.remove("CAMPAIGN_ID");
		custInfoVO.setCustData(jsonObj.toString());

		outboundMonitoringService.updateCustInfo(custInfoVO);
		map = getObUserInfo(jsonStr, frontMntVO);


		return map;
	}

  /***
   * getCustInfoList Campaign 별 고객정보 조회
   *
   * @param jsonStr
   * @return
   * @throws IOException
   * @throws JsonMappingException
   * @throws JsonParseException
	 * @throws ParseException
   */
  @RequestMapping(value = "/getCustInfoList", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public Map<String, Object> getCustInfoList(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException, ParseException {
    System.out.println("jsonStr====" + jsonStr);
		FrontMntVO frontMntVO = new FrontMntVO();
    frontMntVO = searchColumn(jsonStr);
//		FrontMntVO frontMntVO = new FrontMntVO();
    Map<String, Object> map = null;
    // json파서
    JsonParser jp = new JsonParser();
    JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
    // json -> map
    map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		//페이징을 위해서 쿼리 포함 전체 카운팅
		PagingVO pagingVO = new PagingVO();
		Map<String, Object> custClassMap = new HashMap<>();
		custClassMap.put("campaignId", String.valueOf(map.get("CAMPAIGN_ID")));
		if (map.get("PAGE_COUNT").equals("10")) {
			custClassMap.put("displayYn", "y");
		} else {
			pagingVO.setCOUNT_PER_PAGE("20");
		}
		List<CustDataClassVO> nameTelColType = outboundMonitoringService.getNameTelType(custClassMap);
		pagingVO.setTotalCount(outboundMonitoringService.getOutboundCallMntCount(frontMntVO));
		pagingVO.setCurrentPage(frontMntVO.getCurrentPage());
		frontMntVO.setStartRow(pagingVO.getStartRow());
		frontMntVO.setLastRow(pagingVO.getLastRow());

		// 음성 봇 리스트
		frontMntVO.setCall_type_code("N");//콜타입 (IB & OB)

		//DB에서 전체 리스트 SELECT.
		frontMntVO.setPageInitPerPage(String.valueOf(map.get("PAGE_COUNT")));
		List<CmContractVO> list = outboundMonitoringService.getOutboundCallMntList(frontMntVO);
		List<CustDataClassVO> custDataClassList = outboundMonitoringService.getCustDataClass(custClassMap);
		List<CmCommonCdVO> commonList = outboundMonitoringService.getCommonList();

		map.put("colList", custDataClassList);
		// custData json 파싱
		for (int i=0; i<list.size(); i++) {
			String custData = "";
			Map<String, Object> custMap = null;
			String custDataOri = list.get(i).getCustData();

			if (custDataOri == null || "".equals(custDataOri)) {
				list.get(i).setCustData(custData);
				continue;
			}
			JsonObject custJsonObj = (JsonObject) jp.parse(list.get(i).getCustData());
			custMap = new ObjectMapper().readValue(custJsonObj.toString(), Map.class);
			List<String> custDataList = new ArrayList<>();
			for (int j=0; j<custDataClassList.size(); j++) {
				custData = (String) custMap.get(custDataClassList.get(j).getCustDataClassId()+"");
				custDataList.add(custData);
			}
			list.get(i).setCustDataList(custDataList);
		}

		map.put("colList", custDataClassList);
		map.put("list", list);                                                        // 페이지 리스트.
		map.put("paging", pagingVO);
		map.put("nameTelColType", nameTelColType);
		map.put("commonList", commonList);

    return map;
  }

	@RequestMapping(value = "/excelTemplateDown")
	public void excelDown(HttpServletResponse response) throws Exception {

		XSSFWorkbook workbook = new XSSFWorkbook();

		try {

			DataFormat textCellStyle = workbook.createDataFormat();
			CellStyle textStyle = workbook.createCellStyle();
			textStyle.setDataFormat(textCellStyle.getFormat("@"));

			/* (2) 새로운 Sheet 생성 */
			XSSFSheet sheet = workbook.createSheet("column");
			XSSFSheet sheet2 = workbook.createSheet("data");
//		Sheet sheet = wb.createSheet("First sheet");
			if( sheet == null ){
				System.out.println("Sheet1 is Null!");
				return;
			}

			Row row = null;
			Cell cell = null;
			int rowNo = 0;
			List<String> list = new ArrayList<>();
			list.add("나이");
			list.add("생년월일");
			list.add("연령대");

			addMyValidation(1, 2, 0, 1, new String[]{"Y"}, sheet);
			addMyValidation(3, 100, 0, 1, new String[]{"Y", "N"}, sheet);
			addMyValidation(1, 2, 2, 2, new String[]{"STRING"}, sheet);
			addMyValidation(3, 100, 2, 2, new String[]{"STRING", "INT", "DATE", "RADIOBOX", "SELECTBOX"}, sheet);
			addMyValidation(1, 1, 3, 3, new String[]{"이름"}, sheet);
			addMyValidation(2, 2, 3, 3, new String[]{"전화번호"}, sheet);
			addMyValidation(1, 1, 4, 4, new String[]{"name"}, sheet);
			addMyValidation(2, 2, 4, 4, new String[]{"telNo"}, sheet);

			Drawing drawing = sheet.createDrawingPatriarch();
			ClientAnchor anchor = drawing.createAnchor(0, 0, 0, 0, 7, 9, 13, 13);
			Comment columnComment = drawing.createCellComment(anchor);
			columnComment.setVisible(true);
			XSSFRichTextString textString = new XSSFRichTextString("컬럼명(한),(영)은 필수로 입력해야하며 데이터타입이 RADIOBOX, SELECTBOX일 경우 후보값은 반드시 입력해야합니다. 또한 이름,전화번호 컬럼은 필수 항목입니다.");//메모내용
			columnComment.setString(textString);

			anchor = drawing.createAnchor(0, 0, 0, 0, 7, 15, 13, 19);
			Comment caseComment = drawing.createCellComment(anchor);
			caseComment.setVisible(true);
			textString = new XSSFRichTextString("후보는 데이터 타입이 RADIOBOX,SELECTBOX인 경우에만 사용 가능하며, 쉼표(,) "
					+ "구분자로 나열해야합니다. ex) 10대,20대,30대");//메모내용
			caseComment.setString(textString);

			anchor = drawing.createAnchor(0, 0, 0, 0, 7, 4, 13, 7);
			Comment regComment = drawing.createCellComment(anchor);
			regComment.setVisible(true);
			textString = new XSSFRichTextString("발송여부, 노출여부, 데이터타입은 정해진 타입에 맞게 작성해주세요. (해당 항목클릭시 데이터타입 목록 표시)");//메모내용
			regComment.setString(textString);
			sheet2.setDefaultColumnStyle(1, textStyle);

			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("발송여부");
			cell = row.createCell(1);
			cell.setCellValue("노출여부");
			cell = row.createCell(2);
			cell.setCellValue("데이터 타입");
			cell.setCellComment(regComment);
			cell = row.createCell(3);
			cell.setCellValue("컬럼명(한)");
			cell = row.createCell(4);
			cell.setCellValue("컬럼명(영)");
			cell.setCellComment(columnComment);
			cell = row.createCell(5);
			cell.setCellValue("후보");
			cell.setCellComment(caseComment);
			cell = row.createCell(6);
			cell.setCellValue("설명");
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("Y");
			cell = row.createCell(1);
			cell.setCellValue("Y");
			cell = row.createCell(2);
			cell.setCellValue("STRING");
			cell = row.createCell(3);
			cell.setCellValue("이름");
			cell = row.createCell(4);
			cell.setCellValue("name");
			cell = row.createCell(6);
			cell.setCellValue("고객이름");
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellValue("Y");
			cell = row.createCell(1);
			cell.setCellValue("Y");
			cell = row.createCell(2);
			cell.setCellValue("STRING");
			cell = row.createCell(3);
			cell.setCellValue("전화번호");
			cell = row.createCell(4);
			cell.setCellValue("telNo");
			cell = row.createCell(6);
			cell.setCellValue("고객전화번호");


			drawing = sheet2.createDrawingPatriarch();
			anchor = drawing.createAnchor(0, 0, 0, 0, 7, 9, 14, 14);
			Comment dataComment = drawing.createCellComment(anchor);
			dataComment.setVisible(true);
			textString = new XSSFRichTextString("데이터 타입이 RADIOBOX, SELECTBOX인 경우 CASETYPE으로 지정된 데이터만 입력해야하고, "
					+ "단일 데이터만 입력 가능합니다. ex) CASETYPE = 10대, 20대, 30대 -> DATA : 20대   Date 타입 날짜형식은 YYYY-MM-DD 형식을 이용해주시기 바랍니다 ex) 2020-05-04");//메모내용
			dataComment.setString(textString);
			rowNo = 0;
			row = sheet2.createRow(rowNo++);
			for (int i = 0; i<100; i++) {
				cell = row.createCell(i);
				cell.setCellFormula("IF(column!D" + (2+i)+"=\"\",\"\",column!D" + (2+i)+")");
				if (i == 1) {
					cell.setCellComment(dataComment);
				}
			}

			/* (8) Excel 파일 생성 */

			response.setContentType("ms-vnd/excel");
			response.setHeader("Content-Disposition", "attachment;filename=Template.xlsx");

			workbook.write(response.getOutputStream());
			workbook.close();
		} catch (Exception e) {

			response.setHeader("Set-Cookie", "fileDownload=false; path=/");
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
			response.setHeader("Content-Type", "text/html; charset=utf-8");

			OutputStream out = null;
			try {
				out = response.getOutputStream();
				byte[] data = "fail..".getBytes();
				out.write(data, 0, data.length);
			} catch (Exception ignore) {
				ignore.printStackTrace();
			} finally {
				if (out != null) {
					try {
						out.close();
					} catch (Exception ignore) {
					}
				}
			}

		}

	}

//	@RequestMapping(value = "/excelExDataDown")
//	public void excelExDataDown(HttpServletResponse response) throws Exception {
//
//		XSSFWorkbook workbook = new XSSFWorkbook();
//
//		try {
//
//			DataFormat textCellStyle = workbook.createDataFormat();
//			CellStyle textStyle = workbook.createCellStyle();
//			textStyle.setDataFormat(textCellStyle.getFormat("@"));
//
//			/* (2) 새로운 Sheet 생성 */
//			XSSFSheet sheet = workbook.createSheet("column");
//			XSSFSheet sheet2 = workbook.createSheet("data");
////		Sheet sheet = wb.createSheet("First sheet");
//			if( sheet == null ){
//				System.out.println("Sheet1 is Null!");
//				return;
//			}
//
//			Row row = null;
//			Cell cell = null;
//			int rowNo = 0;
//			List<String> list = new ArrayList<>();
//			list.add("나이");
//			list.add("생년월일");
//			list.add("연령대");
//
//			addMyValidation(1, 2, 0, 1, new String[]{"Y"}, sheet);
//			addMyValidation(3, 100, 0, 1, new String[]{"Y", "N"}, sheet);
//			addMyValidation(1, 2, 2, 2, new String[]{"STRING"}, sheet);
//			addMyValidation(3, 100, 2, 2, new String[]{"STRING", "INT", "DATE", "RADIOBOX", "SELECTBOX"}, sheet);
//			addMyValidation(1, 1, 3, 3, new String[]{"이름"}, sheet);
//			addMyValidation(2, 2, 3, 3, new String[]{"전화번호"}, sheet);
//			addMyValidation(1, 1, 4, 4, new String[]{"name"}, sheet);
//			addMyValidation(2, 2, 4, 4, new String[]{"telNo"}, sheet);
//
//			Drawing drawing = sheet.createDrawingPatriarch();
//			ClientAnchor anchor = drawing.createAnchor(0, 0, 0, 0, 7, 9, 13, 13);
//			Comment columnComment = drawing.createCellComment(anchor);
//			columnComment.setVisible(true);
//			XSSFRichTextString textString = new XSSFRichTextString("컬럼명(한),(영)은 필수로 입력해야하며 데이터타입이 RADIOBOX, SELECTBOX일 경우 후보값은 반드시 입력해야합니다. 또한 이름,전화번호 컬럼은 필수 항목입니다.");//메모내용
//			columnComment.setString(textString);
//
//			anchor = drawing.createAnchor(0, 0, 0, 0, 7, 15, 13, 19);
//			Comment caseComment = drawing.createCellComment(anchor);
//			caseComment.setVisible(true);
//			textString = new XSSFRichTextString("후보는 데이터 타입이 RADIOBOX,SELECTBOX인 경우에만 사용 가능하며, 쉼표(,) "
//					+ "구분자로 나열해야합니다. ex) 10대,20대,30대");//메모내용
//			caseComment.setString(textString);
//
//			anchor = drawing.createAnchor(0, 0, 0, 0, 7, 4, 13, 7);
//			Comment regComment = drawing.createCellComment(anchor);
//			regComment.setVisible(true);
//			textString = new XSSFRichTextString("발송여부, 노출여부, 데이터타입은 정해진 타입에 맞게 작성해주세요. (해당 항목클릭시 데이터타입 목록 표시)");//메모내용
//			regComment.setString(textString);
//			sheet2.setDefaultColumnStyle(1, textStyle);
//
//			String callYn[] = {"발송여부", "Y", "Y", "Y", "N", "N", "Y", "N"};
//			String displayYn[] = {"노출여부", "Y", "Y", "N", "Y", "N", "Y", "Y"};
//			String dataType[] = {"데이터타입", "STRING", "STRING", "DATE", "INT", "RADIOBOX", "RADIOBOX", "SELECTBOX"};
//			String columnKor[] = {"컬럼명(한)", "이름", "전화번호", "생년월일", "나이", "성별", "연령대", "취미"};
//			String columnEng[] = {"컬럼명(영)", "name", "telNo", "dateOfBirth", "age", "gender", "ageGroup", "hobby"};
//			String caseType[] = {"후보", "", "", "", "", "남,여", "10대,20대,30대,40대", "스포츠,게임,요리,독서,여행"};
//			String description[] = {"설명", "고객의 이름", "고객의 전화번호", "고객의 생년월일", "고객의 나이", "고객의 성별", "고객의 연령대", "고객의 취미"};
//
//			for (int i=0; i<8; i++) {
//				row = sheet.createRow(rowNo++);
//				cell = row.createCell(0);
//				cell.setCellValue(callYn[i]);
//				cell = row.createCell(1);
//				cell.setCellValue(displayYn[i]);
//				cell = row.createCell(2);
//				cell.setCellValue(dataType[i]);
//				if (i == 0) {
//					cell.setCellComment(regComment);
//				}
//				cell = row.createCell(3);
//				cell.setCellValue(columnKor[i]);
//				cell = row.createCell(4);
//				cell.setCellValue(columnEng[i]);
//				if (i == 0) {
//					cell.setCellComment(columnComment);
//				}
//				cell = row.createCell(5);
//				cell.setCellValue(caseType[i]);
//				if (i == 0) {
//					cell.setCellComment(caseComment);
//				}
//				cell = row.createCell(6);
//				cell.setCellValue(description[i]);
//			}
//
//			drawing = sheet2.createDrawingPatriarch();
//			anchor = drawing.createAnchor(0, 0, 0, 0, 7, 9, 14, 14);
//			Comment dataComment = drawing.createCellComment(anchor);
//			dataComment.setVisible(true);
//			textString = new XSSFRichTextString("데이터 타입이 RADIOBOX, SELECTBOX인 경우 CASETYPE으로 지정된 데이터만 입력해야하고, "
//					+ "단일 데이터만 입력 가능합니다. ex) CASETYPE = 10대, 20대, 30대 -> DATA : 20대   Date 타입 날짜형식은 YYYY-MM-DD 형식을 이용해주시기 바랍니다 ex) 2020-05-04");//메모내용
//			dataComment.setString(textString);
//			String nameCol[] = {"홍길동", "김두한"};
//			String telCol[] = {"01012345678", "01031213124"};
//			String dateCol[] = {"1994-09-22", "1991-02-15"};
//			String ageCol[] = {"27", "30"};
//			String genderCol[] = {"남", "여"};
//			String ageGroupCol[] = {"20대", "30대"};
//			String hobbyCol[] = {"스포츠", "독서"};
//			rowNo = 0;
//			row = sheet2.createRow(rowNo++);
//			for (int i = 0; i<100; i++) {
//				cell = row.createCell(i);
//				cell.setCellFormula("IF(column!D" + (2+i)+"=\"\",\"\",column!D" + (2+i)+")");
//				if (i == 1) {
//					cell.setCellComment(dataComment);
//				}
//			}
//			for (int i=0; i<2; i++) {
//				row = sheet2.createRow(rowNo++);
//				cell = row.createCell(0);
//				cell.setCellValue(nameCol[i]);
//				cell = row.createCell(1);
//				cell.setCellValue(telCol[i]);
//				cell = row.createCell(2);
//				cell.setCellValue(dateCol[i]);
//				cell = row.createCell(3);
//				cell.setCellValue(ageCol[i]);
//				cell = row.createCell(4);
//				cell.setCellValue(genderCol[i]);
//				cell = row.createCell(5);
//				cell.setCellValue(ageGroupCol[i]);
//				cell = row.createCell(6);
//				cell.setCellValue(hobbyCol[i]);
//			}
//
//			/* (8) Excel 파일 생성 */
//
//			response.setContentType("ms-vnd/excel");
//			response.setHeader("Content-Disposition", "attachment;filename=SampleData.xlsx");
//
//			workbook.write(response.getOutputStream());
//			workbook.close();
//		} catch (Exception e) {
//
//			response.setHeader("Set-Cookie", "fileDownload=false; path=/");
//			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
//			response.setHeader("Content-Type", "text/html; charset=utf-8");
//
//			OutputStream out = null;
//			try {
//				out = response.getOutputStream();
//				byte[] data = "fail..".getBytes();
//				out.write(data, 0, data.length);
//			} catch (Exception ignore) {
//				ignore.printStackTrace();
//			} finally {
//				if (out != null) {
//					try {
//						out.close();
//					} catch (Exception ignore) {
//					}
//				}
//			}
//
//		}
//
//	}

	@RequestMapping(value = "/excelExDataDown")
	public void excelExDataDown(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String defaultfilepath = request.getSession().getServletContext().getRealPath("/");

		//defaultfilepath + realfilepath 부분을 실제 경로로만 변경해주면 됨
		File downloadfile = new File(customProperties.getExcelUploadPath() + "excelExData.xlsx");
		if (downloadfile.exists() && downloadfile.isFile()) {
			response.setContentType("application/octet-stream; charset=utf-8");
			response.setContentLength((int) downloadfile.length());
			OutputStream outputstream = null;
			FileInputStream inputstream = null;
			try {
				response.setHeader("Content-Disposition", getDisposition("excelExData.xlsx", check_browser(request)));
				response.setHeader("Content-Transfer-Encoding", "binary");
				outputstream = response.getOutputStream();
				inputstream = new FileInputStream(downloadfile);
				//Spring framework 사용할 경우
				//FileCopyUtils.copy(fis, out);

				//일반 자바/JSP 파일다운로드
				byte[] buffer = new byte[1024];
				int length = 0;
				while((length = inputstream.read(buffer)) > 0) {
					outputstream.write(buffer,0,length);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (inputstream != null){
						inputstream.close();
					}
					outputstream.flush();
					outputstream.close();
				} catch (Exception e2) {}
			}
		}else {
			System.out.println("파일존재하지 않음");
		}
	}

	private String check_browser(HttpServletRequest request) {
		String browser = "";
		String header = request.getHeader("User-Agent");
		//신규추가된 indexof : Trident(IE11) 일반 MSIE로는 체크 안됨
		if (header.indexOf("MSIE") > -1 || header.indexOf("Trident") > -1){
			browser = "ie";
		}
		//크롬일 경우
		else if (header.indexOf("Chrome") > -1){
			browser = "chrome";
		}
		//오페라일경우
		else if (header.indexOf("Opera") > -1){
			browser = "opera";
		}
		//사파리일 경우
		else if (header.indexOf("Apple") > -1){
			browser = "sarari";
		} else {
			browser = "firfox";
		}
		return browser;
	}

	private String getDisposition(String down_filename, String browser_check) throws UnsupportedEncodingException {
		String prefix = "attachment;filename=";
		String encodedfilename = null;
		System.out.println("browser_check:"+browser_check);
		if (browser_check.equals("ie")) {
			encodedfilename = URLEncoder.encode(down_filename, "UTF-8").replaceAll("\\+", "%20");
		}else if (browser_check.equals("chrome")) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < down_filename.length(); i++){
				char c = down_filename.charAt(i);
				if (c > '~') {
					sb.append(URLEncoder.encode("" + c, "UTF-8"));
				} else {
					sb.append(c);
				}
			}
			encodedfilename = sb.toString();
		}else {
			encodedfilename = "\"" + new String(down_filename.getBytes("UTF-8"), "8859_1") + "\"";
		}
		return prefix + encodedfilename;
	}

	@RequestMapping(value = "/deleteCallQueue", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> deleteCallQueue(@RequestBody List<Integer> callQueueList) {

		Map<String, Object> map = new HashMap<>();
  	int deleteCount = 0;
		deleteCount = outboundMonitoringService.deleteCallQueue(callQueueList);

		map.put("deleteCount", deleteCount);

		return map;
	}

	private boolean addMyValidation(int firstRow, int lastRow, int firstCol, int lastCol, String[] listOfValue, XSSFSheet sheet) {
		XSSFDataValidationHelper helper = new XSSFDataValidationHelper(sheet);
		XSSFDataValidationConstraint constraint;
		if (listOfValue == null || listOfValue.length == 0) {
			constraint = (XSSFDataValidationConstraint) helper.createIntegerConstraint(OperatorType.BETWEEN, "0", "99999999999");
		} else {
			constraint = (XSSFDataValidationConstraint) helper.createExplicitListConstraint(listOfValue);
		}
		CellRangeAddressList range = new CellRangeAddressList(firstRow, lastRow, firstCol, lastCol);
		XSSFDataValidation validation = (XSSFDataValidation) helper.createValidation(constraint, range);

		validation.setErrorStyle(DataValidation.ErrorStyle.STOP);
		validation.setSuppressDropDownArrow(true);
		validation.setEmptyCellAllowed(false);
		validation.setShowPromptBox(true);
		validation.setShowErrorBox(true);

		sheet.addValidationData(validation);

		return true;
	}

	private FrontMntVO searchColumn(String jsonStr) throws IOException {
		FrontMntVO frontMntVO = new FrontMntVO();
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		// 로그인 사용자 ID 가져오기

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		frontMntVO.setSessId(userId);
		frontMntVO.setCampaignId(String.valueOf(map.get("CAMPAIGN_ID")));
		CustDataClassVO custDataClassVO = new CustDataClassVO();
		custDataClassVO.setCampaignId(Integer.parseInt(String.valueOf(map.get("CAMPAIGN_ID"))));
		List<Map<String, Object>> commonList = new ArrayList<>();
		if (!"".equals(map.get("CUST_NM")) && map.get("CUST_NM") != null) {
			frontMntVO.setCustName(String.valueOf(map.get("CUST_NM")));
		}
		if (!"".equals(map.get("CUST_TEL_NO")) && map.get("CUST_TEL_NO") != null) {
			frontMntVO.setCustTelNo(String.valueOf(map.get("CUST_TEL_NO")));
		}
		if (!"".equals(map.get("callStatus")) && map.get("callStatus") != null) {
			String caseType[] = String.valueOf(map.get("callStatus")).split(",");
			for (int i=0; i<caseType.length; i++) {
				Map<String, Object> searchMap = new HashMap<>();
				searchMap.put("commonCode", caseType[i]);
				if (i == 0) {
					searchMap.put("operator", "AND");
					if (caseType.length == 1) {
						searchMap.put("separator", ")");
					}
				} else {
					searchMap.put("operator", "OR");
					if (i == caseType.length - 1) {
						searchMap.put("separator", ")");
					}
				}
				commonList.add(searchMap);
			}
			frontMntVO.setCallStatus(commonList);
		}
		if (!"".equals(map.get("COLUMN_MODEL")) && map.get("COLUMN_MODEL") != null) {
			if(String.valueOf(map.get("COLUMN_MODEL")).equals("이름")){
				frontMntVO.setSortingTarget("CUST_NM");
			} else if (String.valueOf(map.get("COLUMN_MODEL")).equals("전화번호")) {
				frontMntVO.setSortingTarget("CUST_TEL_NO");
			} else {
				custDataClassVO.setColumnKor(String.valueOf(map.get("COLUMN_MODEL")));
				int classId = outboundMonitoringService.getCustDataClassId(custDataClassVO);
				frontMntVO.setSortingTarget("$.\""+classId+"\"");
			}
		}
		if (!"".equals(map.get("SORT_TYPE")) && map.get("SORT_TYPE") != null) {
			frontMntVO.setDirection(String.valueOf(map.get("SORT_TYPE")));
		}
		List<Map<String, Object>> colList = new ArrayList<>();
		for (String key : map.keySet()) {
			if (!key.equals("CAMPAIGN_ID") && !key.equals("CUST_TEL_NO") && !key.equals("CUST_NM") &&
					!key.equals("PAGE_COUNT") && !key.equals("cp") && !key.equals("pageInitPerPage") &&
					!key.equals("countPerPage") && !key.equals("COLUMN_MODEL") && !key.equals("SORT_TYPE") &&
					!key.equals("callStatus") && !"".equals(map.get(key))) {
				custDataClassVO.setColumnKor(key);
				int classId = outboundMonitoringService.getCustDataClassId(custDataClassVO);
				String caseType[] = String.valueOf(map.get(key)).split(",");
				for (int i=0; i<caseType.length; i++) {
					Map<String, Object> searchMap = new HashMap<>();
					searchMap.put("custCol", "$.\""+classId+"\"");
					searchMap.put("search", caseType[i]);
					if (i == 0) {
						searchMap.put("operator", "AND");
						if (caseType.length == 1) {
							searchMap.put("separator", ")");
						}
					} else {
						searchMap.put("operator", "OR");
						if (i == caseType.length - 1) {
							searchMap.put("separator", ")");
						}
					}
					colList.add(searchMap);
				}
			}
		}
		frontMntVO.setCustData(colList);
		return frontMntVO;
	}
	
	@RequestMapping(value = "/updateObCustId", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> updateObCustId(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		
		map.put("custTelNo", map.get("TEL_NO").toString());
		map.put("contractNo", map.get("CONTRACT_NO").toString());

		Map<String, Object> checkIsInboundMap = consultingService.checkIsInbound(map);
		System.out.println("IS INBOUND :: " + checkIsInboundMap.get("isInbound").toString());
		map.put("campaignId", checkIsInboundMap.get("campaignId").toString());

		// agent Click 시 cm_contract에 cust_id 등록
		if(checkIsInboundMap.get("isInbound").toString().equals("N")){
			int updateCustId = consultingService.updateObCustId(map);
		}

		return null;
	}


	@RequestMapping(value = "/excelCustResultDown")
	public ResponseEntity excelCustResultDown(@RequestBody String jsonStr, HttpServletResponse response) throws Exception {
		JsonObject jsonObj = new JsonParser().parse(jsonStr).getAsJsonObject();
		Map<String, Object> map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		//CUST_INFO.ANSWER_RESULT 가 있는 고객 리스트 가져오기
		List<Map<String, Object>> custResultList = outboundMonitoringService.getCustResultList(map);

		if (custResultList.size() == 0) {
			return new ResponseEntity<>(HttpStatus.NO_CONTENT);
		}

  	XSSFWorkbook workbook = new XSSFWorkbook();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("_yyyyMMddHHmmss");
		Calendar calendar = Calendar.getInstance();
		String strToday = simpleDateFormat.format(calendar.getTime());

		//엑셀 만들기
		try {
			/* 새로운 Sheet 생성 */
			XSSFSheet sheet = workbook.createSheet("sheet1");

			Row row = null;
			Cell cell = null;
			int rowNo = 0;

			//엑셀 타이틀 데이터 추출
			JsonObject custResultJson = new JsonParser().parse(custResultList.get(0).get("ANSWER_RESULT").toString()).getAsJsonObject();
			Map<String, Object> custResultJsonMap = new ObjectMapper().readValue(custResultJson.toString(), Map.class);
			List<String> resultKeyList = new ArrayList();
			Iterator<String> resultKeys = custResultJsonMap.keySet().iterator();
			while(resultKeys.hasNext())
			{
				String b = resultKeys.next();
				resultKeyList.add(b); // 키 값 저장
			}

			//엑셀 타이틀 세팅
			row = sheet.createRow(rowNo++);
			for (int i=-2; i<resultKeyList.size(); i++) {
				int index = i+2;
				cell = row.createCell(index);

				if ( index == 0 ) {
					cell.setCellValue("이름");
				} else if ( index == 1 ) {
					cell.setCellValue("전화번호");
				} else {
					cell.setCellValue(resultKeyList.get(i));
				}
			}

			//엑셀 내용 세팅
			for (int j=0; j<custResultList.size(); j++) {
				int cellIndex = 0;
				Map<String, Object> custResultMap = custResultList.get(j);

				row = sheet.createRow(rowNo++);

				cell = row.createCell(cellIndex++);
				cell.setCellValue(custResultMap.get("CUST_NM").toString()); //이름

				cell = row.createCell(cellIndex++);
				cell.setCellValue(custResultMap.get("CUST_TEL_NO").toString()); //전화번호


				JSONObject resultMapJson = new JSONObject(custResultMap.get("ANSWER_RESULT").toString()); //그 외 정보
				Iterator<String> resultMapKeys = resultMapJson.keys();
				while(resultMapKeys.hasNext())
				{
					cell = row.createCell(cellIndex++);
					cell.setCellValue(resultMapJson.getString(resultMapKeys.next()));
				}
			}

			response.setContentType("ms-vnd/excel");
			response.setHeader("Set-Cookie", "fileDownload=true; path=/");
			response.setHeader("Content-Disposition", "attachment;filename=CUST_RESULT_DATA"+strToday+".xlsx");

			workbook.write(response.getOutputStream());
			workbook.close();

			return new ResponseEntity<>(HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			response.setHeader("Set-Cookie", "fileDownload=false; path=/");
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
			response.setHeader("Content-Type", "text/html; charset=utf-8");

			OutputStream out = null;
			try {
				out = response.getOutputStream();
				byte[] data = "fail..".getBytes();
				out.write(data, 0, data.length);
			} catch (Exception ignore) {
				ignore.printStackTrace();
			} finally {
				if (out != null) {
					try {
						out.close();
					} catch (Exception ignore) { ignore.printStackTrace();
					}
				}
			}
		}

		return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

}
