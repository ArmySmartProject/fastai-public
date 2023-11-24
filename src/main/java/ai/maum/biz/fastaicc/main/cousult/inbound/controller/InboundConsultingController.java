package ai.maum.biz.fastaicc.main.cousult.inbound.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.util.MailUtill;
import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCampaignInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonMonitoringService;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.cousult.common.service.ConsultingService;
import ai.maum.biz.fastaicc.main.cousult.inbound.domain.SipAccountVO;
import ai.maum.biz.fastaicc.main.cousult.inbound.service.InboundMonitoringService;
import ai.maum.biz.fastaicc.main.cousult.outbound.service.OutboundMonitoringService;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import ai.maum.biz.fastaicc.main.user.service.AuthService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class InboundConsultingController {
	
	@Autowired
	MailUtill mailUtill;
	
	/* 공통서비스 */
	@Autowired
	CommonService commonService;

	/* 권한 서비스 */
	@Autowired
	AuthService authService;

	/* 인바운드 모니터 서비스 */
	@Autowired
	InboundMonitoringService inboundMonitoringService;

	/* 상담서비스 */
	@Autowired
	ConsultingService consultingService;

	@Autowired
	CustomProperties customProperties;
	
	@Autowired
    CommonMonitoringService commonMonitoringService;

	@Autowired
    OutboundMonitoringService outboundMonitoringService;
	
	/* 설정값 */
	@Inject
	VariablesMng variablesMng;
	
	@Autowired
    PasswordEncoder passwordEncoder;

	/* 인바운드 상담 main화면 */
	@RequestMapping(value = "/ibCsMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String ibCsMain(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		frontMntVO.setCall_type_code("Y");//콜타입 (IB & OB)
		
		if("".equals(frontMntVO.getSessId()) || frontMntVO.getSessId() == null) {
			frontMntVO.setSessId(userId);
		}
		
		FrontMntVO forOutBotData = new FrontMntVO();//아웃바운드폰 조회
		forOutBotData.setCall_type_code("N");//아웃바운드폰 조회
		forOutBotData.setSessId(userId);
		
		String locale = req.getParameter("lang");
		
		// 음성 봇 리스트 조회
		List<SipAccountVO> phoneListResult = inboundMonitoringService.getPhoneList(frontMntVO);
		List<SipAccountVO> outPhoneListResult = inboundMonitoringService.getPhoneList(forOutBotData);
		// 상담 상단 상태바 조회 IB
		List<Map> opIbStateTotal = consultingService.getOpIbStateList(frontMntVO);
		//공통코드 조회
		Map map = new HashMap();
		map.put("FIRST_CD", "12"); // 긴급도 12
		map.put("locale", locale);
		List<Map> cmmCd12List = commonService.getCmmCdList(map);
		model.addAttribute("cmmCd12List", cmmCd12List); // 상공통코드 (긴급도12)
		
		
		//콜백 요청 cnt (사이드)
		map.put("sessId", userId);
		map.put("inboundYn", "Y");
		List<Map> callbackList = consultingService.getCallbackList(map);
		
		//상담사 recall list (사이드)
		List<Map> recallList = consultingService.getRecallList(map);
		//model.addAttribute("recallList", recallList); // 상담사 recallList (사이드)
		
		/////////////////////////////////////////////
		model.addAttribute("csType","IB"); // 인바운드 체크
		model.addAttribute("opIbStateTotal", new Gson().toJson(opIbStateTotal)); // 상담 상단 상태바 total
		model.addAttribute("phoneListResult", phoneListResult); // 음성봇리스트
		model.addAttribute("websocketUrl", customProperties.getWebsocketProtocol() + "://"
				+ customProperties.getWebsocketIp() + customProperties.getWebsocketPort()); // 웹소켓URL
		model.addAttribute("voiceUrl", customProperties.getWebsocketProtocol() + "://"
				+ customProperties.getVoiceIp() + customProperties.getVoicePort()); // 웹소켓URL
		model.addAttribute("proxyUrl", customProperties.getProxyProtocol() + "://"
				+ customProperties.getProxyIp() + customProperties.getProxyPort()); // 웹소켓 proxy URL
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		model.addAttribute("callbackReqCnt", callbackList.size()); // 콜백요청 카운트
		model.addAttribute("recallReqCnt", recallList.size()); // 리콜요청 카운트
		//model.addAttribute("obPhone", outPhoneListResult.get(0).getSipUser()); // 콜백요청 카운트 > autocall 사용
		model.addAttribute("sessId", userId); // 콜백요청 카운트 > autocall 사용
		return "/consulting/inboundConsulting";
	}

	/***
	 * ibUserInfo 인바운드 상담 사용자 조회
	 * 
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/ibUserInfo", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> ibUserInfo(@RequestBody String jsonStr, FrontMntVO frontMntVO)
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
		
		
		// 채팅정보
		List<Map> userChatList = consultingService.getUserChatList(map);
		// 구간 탐지
		List<Map> userCampSList = consultingService.getUserCampSList(map);
		// 고객 상담내용 정보
		List<Map> userCsDtlList = consultingService.getUserCsDtlList(map);
		// 캠페인 탐지정보
		List<CmCampaignInfoVO> mntResult = null;
		mntResult = commonMonitoringService.getCallPopMonitoringResultList(frontMntVO); 
		
		
		/*
		if (userCsDtlList.size() > 0) {
				//카테고리 메뉴 조회
				HashMap<String, Object> cateMap = new HashMap<>();
				
				//cateMap.put("CAMPAIGN_ID", userCsDtlList.get(0).get("CAMPAIGN_ID"));
				cateMap.put("CAMPAIGN_ID", map.get("CAMPAIGN_ID"));
				
			//	cateMap.put("UPCODE", userCsDtlList.get(0).get("CAMPAIGN_ID"));
				List<Map> consultingTypeList = commonService.getCustCategoryCdList(cateMap);
				//map.put("consultingTypeTolList", new Gson().toJson(consultingTypeList)); // 상담유형
				map.put("consultingTypeList", new Gson().toJson(consultingTypeList)); // 상담유형
		}
		*/
		//기존 : 고객상담내용 있는 경우에만 카테고리 조회함 > 변경 : 고객상담내용 없어도 카테고리 조회함
		//카테고리 메뉴 조회
		HashMap<String, Object> cateMap = new HashMap<>();
		
		//cateMap.put("CAMPAIGN_ID", userCsDtlList.get(0).get("CAMPAIGN_ID"));
		cateMap.put("CAMPAIGN_ID", map.get("CAMPAIGN_ID"));
		//cateMap.put("UPCODE", userCsDtlList.get(0).get("CAMPAIGN_ID"));
		List<Map> consultingTypeList = commonService.getCustCategoryCdList(cateMap);
		//map.put("consultingTypeTolList", new Gson().toJson(consultingTypeList)); // 상담유형
		map.put("consultingTypeList", new Gson().toJson(consultingTypeList)); // 상담유형
		
		// 고객정보
		List<Map> userInfoList = consultingService.getUserInfoList(map);
		if (userInfoList.size() > 0) {
			// 고객 결제 정보
			List<Map> userPaymentList = consultingService.getUserPaymentList(userInfoList.get(0));
			map.put("userPaymentList", new Gson().toJson(userPaymentList)); // 고객 결제 정보

			// 고객 상담이력정보 정보(사이드 리스트 ) -- 추가 조건 필요 할것이라 느껴짐 켐페인값이라던지..
			//List<Map> csHisList = consultingService.getCsHisList(map);
			//map.put("csHisList", new Gson().toJson(csHisList)); // 고객 상담이력정보 정보
		}
		
		// 고객 상담이력정보 정보(사이드 리스트 ) > 고객정보 없더라도 핸드폰번호만으로 조회
		map.put("inboundYn", "Y");
		map.put("userId", userId);
		List<Map> csHisList = consultingService.getCsHisList(map);
		map.put("csHisList", new Gson().toJson(csHisList)); // 고객 상담이력정보 정보
		
		// 고객 채팅(탐지정보)
		List<Map> csContList = consultingService.getCsContList(map);
		map.put("csContList", new Gson().toJson(csContList)); // 고객 채팅(탐지정보)


		// 리턴 값
		map.put("csContList", new Gson().toJson(csContList)); // 고객 채팅(탐지정보)
		map.put("userCsDtlList", new Gson().toJson(userCsDtlList)); // 고객 상담내용 정보
		map.put("userChatList", new Gson().toJson(userChatList)); // 채팅정보
		map.put("userCampSList", new Gson().toJson(userCampSList)); // 구간 탐지
		map.put("userInfoList", new Gson().toJson(userInfoList)); // 사용자
		map.put("mntResult", new Gson().toJson(mntResult)); // 사용자
		return map;
	}

	/***
	 * cheCateList 카테고리변경시 조회
	 * 
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/cheCateList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> cheCateList(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		//카테고리 메뉴 조회
		List<Map> consultingTypeList = commonService.getCustCategoryCdList(map);
		// 리턴 값
		map.put("consultingTypeList", new Gson().toJson(consultingTypeList)); // 상담유형
		map.put("ReqParam", jsonStr); // 상담유형
		return map;
	}
	
	/***
	 * cm_contract CustId 등록
	 * 
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/updateCustId", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> updateCustId(@RequestBody String jsonStr)
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
		// agent Click 시 cm_contract에 cust_id 등록
		int updateCustId = consultingService.updateCustId(map);
		
		return null;
	}
	
	/***
	 * checkCustInfo 고객정보 체크하기 
	 * 
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/checkCustTelNo", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> checkCustTelNo(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
//		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		Map<String, Object> map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		
		// 고객전화번호 체크하기
		map = consultingService.getCheckCustTelNo(map.get("custTelNo").toString());
		
		return map;
	}
	
	/***
	 * setUserCsDtl 상담내용 저장 ( 상담유형 메모 = CallHistory  /  재통화 =RecallHistory / 이관 = CallTranSferHistory /  상태  = OpInfo/
	 * 
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/setUserCsDtl", method = { RequestMethod.GET, RequestMethod.POST })
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
		//상담내용
		Map<String, Object> CsDtlContMap = new ObjectMapper().readValue(jsonObj.get("CsDtlCont").toString(), Map.class);
		CsDtlContMap.put("CUST_OP_ID", userId);
		consultingService.updateCallHistory(CsDtlContMap);
		
		//재통화
		Map<String, Object> CsDtlReCallMap = new ObjectMapper().readValue(jsonObj.get("CsDtlReCall").toString(), Map.class);
		CsDtlReCallMap.put("CUST_OP_ID", userId);
		for (Entry<String, Object> entry: CsDtlReCallMap.entrySet()) {
		    if(entry.getValue().equals(""))entry.setValue(null);
		}
		consultingService.mergeRecallHistory(CsDtlReCallMap);
		
		//이관
		Map<String, Object> CsDtlEsCalationMap = new ObjectMapper().readValue(jsonObj.get("CsDtlEsCalation").toString(), Map.class);
		CsDtlEsCalationMap.put("CUST_OP_ID", userId);
		consultingService.mergeCallTranSferHistory(CsDtlEsCalationMap);
		
		if(!"".equals(CsDtlEsCalationMap.get("NEW_CUST_OP_EMAIL")) && CsDtlEsCalationMap.get("NEW_CUST_OP_EMAIL") != null) {
			
			try {
				mailUtill.sendMail(CsDtlContMap,CsDtlReCallMap,CsDtlEsCalationMap);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		//상담사 상태 업데이트
		Map<String, Object> CsDtlOpStatusMap = new ObjectMapper().readValue(jsonObj.get("CsDtlOpStatus").toString(), Map.class);
		CsDtlOpStatusMap.put("CUST_OP_ID", userId);
		consultingService.updateCmOpInfo(CsDtlOpStatusMap);

		return null;
	}
	
	/***
	 * setUserInsert 고객정보 신규등록 ( 고객정보 =RecallHistory / 결재정보 = CallTranSferHistory /  )
	 * 
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/setUserInsert", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> setUserInsert(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		//고객정보 
		Map<String, Object> userMap = new ObjectMapper().readValue(jsonObj.get("user").toString(), Map.class);
		consultingService.insertCustBaseInfo(userMap);
		
		//금액정보 
		Map<String, Object> payMap = new ObjectMapper().readValue(jsonObj.get("pay").toString(), Map.class);
		consultingService.insertCustPaymentInfo(payMap);
		
		map.put("setUserInsert", true);
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
	@RequestMapping(value = "/setUserEdt", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> setUserEdt(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		//고객정보 
		Map<String, Object> userMap = new ObjectMapper().readValue(jsonObj.get("user").toString(), Map.class);
		//CsDtlContMap.put("CUST_OP_ID", userId);
		for (Entry<String, Object> entry: userMap.entrySet()) {
		    if(entry.getValue().equals(""))entry.setValue(null);
		}
		consultingService.updateCustBaseInfo(userMap);
		
		//금액정보 
		Map<String, Object> payMap = new ObjectMapper().readValue(jsonObj.get("pay").toString(), Map.class);
		//CsDtlContMap.put("CUST_OP_ID", userId);
		for (Entry<String, Object> entry: payMap.entrySet()) {
		    if(entry.getValue().equals(""))entry.setValue(null);
		}
		consultingService.mergeCustPaymentInfo(payMap);
		
		// 고객정보
		List<Map> userInfoList = consultingService.getUserInfoList(userMap);
		if (userInfoList.size() > 0) {
			// 고객 결제 정보
			List<Map> userPaymentList = consultingService.getUserPaymentList(userInfoList.get(0));
			map.put("userPaymentList", new Gson().toJson(userPaymentList)); // 고객 결제 정보
		}
		// 리턴 값
		map.put("userInfoList", new Gson().toJson(userInfoList)); // 사용자
		map.put("setUserEdt", true);
		return map;
	}
	
	
	
	/***
	 * getOpUserState IB상단 조회
	 * 
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getOpIbState", method = { RequestMethod.GET, RequestMethod.POST })
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
		 
		// 상담 상단 상태바 조회 IB
		List<Map> opIbStateTotal = consultingService.getOpIbStateList(frontMntVO);
		// 리턴 값
		map.put("opIbStateTotal", new Gson().toJson(opIbStateTotal)); // 고객 상담내용 정보
		return map;
	}
	
	/***
	 * getCallbackList (사이드 콜백리스트 조회)
	 * 
	 * @param jsonStr(sessionId, inboundYn)
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getCallbackList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> getCallbackList(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		map.put("sessId", userId);
		//카테고리 메뉴 조회
		List<Map> callbackList = consultingService.getCallbackList(map);
		// 리턴 값
		map.put("ret", new Gson().toJson(callbackList)); //콜백 요청 리스트
		map.put("ReqParam", jsonStr);
		return map;
	}
	
	/***
	 * getRecallList (사이드 리콜리스트 조회)
	 * 
	 * @param jsonStr(sessionId, inboundYn)
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getRecallList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> getRecallList(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		map.put("sessId", userId);
		//카테고리 메뉴 조회
		List<Map> getRecallList = consultingService.getRecallList(map);
		// 리턴 값
		map.put("ret", new Gson().toJson(getRecallList)); //콜백 요청 리스트
		map.put("ReqParam", jsonStr);
		return map;
	}
	
	@RequestMapping(value = "/getEditPw", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> getEditPw(@RequestBody String jsonStr)
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
		
		//비밀번호 변경
		if("Y".equals(map.get("chUserPwYn"))) {
			Map<String, Object> ChUserPwMap = new ObjectMapper().readValue(jsonObj.get("chUserPw").toString(), Map.class);
			
			String originPw = passwordEncoder.encode(ChUserPwMap.get("originPw").toString());
			String chPw = passwordEncoder.encode(ChUserPwMap.get("pw1").toString());
			UserVO user = authService.getAccount(userId);
			
			ChUserPwMap.put("CUST_OP_ID", userId);
			ChUserPwMap.put("CUST_OP_ORIGIN_PW", originPw);
			ChUserPwMap.put("CUST_OP_CH_PW", chPw);
			ChUserPwMap.put("CUST_OP_USER_ID", user.getUserNo());
			ChUserPwMap.put("ENABLED_YN", ChUserPwMap.get("enabledYn").toString());
			
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

		return map;
	}


	@RequestMapping(value = "/getModifPW", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> getModifPW(@RequestBody String jsonStr)
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

		Map<String,Object> checkPWQueryMap = new HashMap<>();
		checkPWQueryMap.put("USER_ID",userId);
		Map<String, Object> outputQueryMap = consultingService.getPwDate(checkPWQueryMap).get(0);

		Date nowDate = new Date();
		int monthDiff = -1;
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String recentPWDate = "";
		try{
			Date date = (Date) outputQueryMap.get("PASSWORD_CHANGE_DE");
			int timeDiff = (int) ((date.getTime() - nowDate.getTime())/(24*60*60*1000*30));
			monthDiff = timeDiff;
			recentPWDate = simpleDateFormat.format(date);
		}catch(Exception e){ //PW 날짜가 null일 경우

		}
		if(monthDiff==-1){
			try{
				Date date = (Date) outputQueryMap.get("REGIST_DT");
				int timeDiff = (int) ((date.getTime() - nowDate.getTime())/(24*60*60*1000*30));
				monthDiff = timeDiff;
				recentPWDate = simpleDateFormat.format(date);
			}catch (Exception e){

			}
		}
		if(monthDiff>=customProperties.getPwMonth()){
			map.put("nowChange",true);
		}else{
			map.put("nowChange",false);
		}
//		map.put("userID",userId);
		map.put("recentPWDate", recentPWDate);
		map.put("pwInterval", customProperties.getPwMonth());

		return map;
	}
	
}
