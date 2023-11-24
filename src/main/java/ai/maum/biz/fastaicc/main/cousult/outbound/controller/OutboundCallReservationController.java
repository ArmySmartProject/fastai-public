package ai.maum.biz.fastaicc.main.cousult.outbound.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.main.api.service.CallReservationApiService;
import ai.maum.biz.fastaicc.main.common.domain.PagingVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCampaignInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmOpInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.CampaignService;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.cousult.inbound.domain.SipAccountVO;
import ai.maum.biz.fastaicc.main.cousult.outbound.domain.CallReservationVO;
import ai.maum.biz.fastaicc.main.cousult.outbound.service.OutBoundCallReservationService;
import ai.maum.biz.fastaicc.main.statistic.domain.StatisticVO;
import ai.maum.biz.fastaicc.main.user.domain.AuthenticaionVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class OutboundCallReservationController {

	/* 공통서비스 */
	@Autowired
	CommonService commonService;

	@Autowired
    CampaignService campaignService;

	@Autowired
	OutBoundCallReservationService outBoundCallReservationService;
	
	@Autowired
	CallReservationApiService callReservationApiService;

	/* ob 예약콜 관리 메인 */
	@RequestMapping(value = "/obCallReservationMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String obCsMain(FrontMntVO frontMntVO, HttpServletRequest req, Model model) throws ParseException {

		return "/callReservation/ob_callReservation";
	}

	/***
	 *  CampaignList
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getObReservationCampaignList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<CmCampaignInfoVO> getCampaignList(StatisticVO statisticVO, @RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		// consultant는 자신의 campaign만 조회한다.
		CmOpInfoVO cmOpInfoVO = new CmOpInfoVO();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=((AuthenticaionVO)auth);
			UserVO userVo = userDto.getUser();
			//cmOpInfoVo에 권한 셋팅
			if(userVo != null && userVo.getUserAuthTy().equals("N")){
				cmOpInfoVO.setUserAuthTy(userVo.getUserAuthTy());
			}else if(userVo != null && userVo.getUserAuthTy().equals("A")){
				cmOpInfoVO.setUserAuthTy(userVo.getUserAuthTy());
			}else if(userVo != null && userVo.getUserAuthTy().equals("S")){
				cmOpInfoVO.setUserAuthTy(userVo.getUserAuthTy());
			}

			if(userVo != null && !userVo.getUserAuthTy().equals("S") && !userVo.getUserAuthTy().equals("A")) { // consultant
				cmOpInfoVO.setCustOpId(userVo.getUserId());
			}
			if(userVo != null && !userVo.getUserAuthTy().equals("S")){
				cmOpInfoVO.setCompanyId(userVo.getCompanyId());
			}
		}
		cmOpInfoVO.setIsInbound("N");
		List<CmCampaignInfoVO> campaignList = campaignService.getCampaignList(cmOpInfoVO);

		return campaignList;
	}

	/***
	 *  callReservation List
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getCallReservationList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<CallReservationVO> getCallReservationList(CallReservationVO callReservationVO, @RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		callReservationVO.setCampaignId(Integer.parseInt(map.get("campaignId").toString()));

		callReservationVO.setOffset(Integer.parseInt(map.get("offset").toString()));
		callReservationVO.setRowNum(Integer.parseInt(map.get("rowNum").toString()));

		List<CallReservationVO> callReservationList = outBoundCallReservationService.getCallReservationList(callReservationVO);

		int totalCount = outBoundCallReservationService.callReservationListCount(callReservationVO);

		String rowNum = map.get("rowNum") == null ? "1" : map.get("rowNum").toString();
		int page = map.get("page") == null ? 1 : Integer.parseInt(map.get("page").toString());

		JsonObject jsonReTurnObj =  new JsonObject();
		jsonReTurnObj.add("rows",new Gson().toJsonTree(callReservationList));
		jsonReTurnObj.add("total",new Gson().toJsonTree(Math.round(Math.ceil(totalCount/Double.parseDouble(rowNum)))));
		jsonReTurnObj.add("page",new Gson().toJsonTree(page));
		jsonReTurnObj.add("records",new Gson().toJsonTree(totalCount));
		jqGirdWriter(response, jsonReTurnObj);

		//카운트 겟수( 페이징)

		return null;
	}

	/***
	 *  callReservation List
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getObReservationDetail", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> getObReservationDetail(CallReservationVO callReservationVO, @RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		Map<String, Object> reservationMap = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		callReservationVO.setAutoCallConditionId(Integer.parseInt(map.get("id").toString()));
		callReservationVO.setCampaignId(Integer.parseInt(map.get("campaignId").toString()));
		//발송기관 관련
		List<CallReservationVO> callReservationDetail = outBoundCallReservationService.getObReservationDetail(callReservationVO);

		List<CallReservationVO> callReservationCustData = outBoundCallReservationService.getObReservationCustData(callReservationVO);

		List<CallReservationVO> obReservationValue = outBoundCallReservationService.checkObReservationValue(callReservationVO);

		reservationMap.put("callReservationDetail", callReservationDetail);
		reservationMap.put("callReservationCustData", callReservationCustData);
		reservationMap.put("obReservationValue", obReservationValue);
		return reservationMap;
	}

	/***
	 *  callReservation List
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getObReservationInsForm", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> getObReservationInsForm(CallReservationVO callReservationVO, @RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		Map<String, Object> reservationMap = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		callReservationVO.setCampaignId(Integer.parseInt(map.get("campaignId").toString()));
		//발송기관 관련

		List<CallReservationVO> callReservationCustData = outBoundCallReservationService.getObReservationCustData(callReservationVO);


		reservationMap.put("callReservationCustData", callReservationCustData);
		return reservationMap;
	}
	/***
	 *  callReservation List
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */

	@RequestMapping(value = "/obReservationSearch", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> obReservationSearch(CallReservationVO callReservationVO, @RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		Map<String, Object> reservationMap = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		callReservationVO.setCampaignId(Integer.parseInt(map.get("campaignId").toString()));
		//발송기관 관련

		List<CallReservationVO> callReservationCustData = outBoundCallReservationService.getObReservationCustData(callReservationVO);

		reservationMap.put("callReservationCustData", callReservationCustData);

		return reservationMap;
	}

	/***
	 *  callReservation List
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getReservationCustList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<CallReservationVO> getReservationCustList(CallReservationVO callReservationVO, @RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		log.info("JSONSTR======" + jsonStr);

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		List<Map<String, Object>> custDataList = new ArrayList<>();
		List<Map<String, Object>> custDataList1 = new ArrayList<>();
		List<Map<String, Object>> callTryCountList = new ArrayList<>();
		List<Map<String, Object>> objectStatusList = new ArrayList<>();
		List<Map<String, Object>> custInfoList = new ArrayList<>();
		JsonArray custJsonObj = jsonObj.getAsJsonArray("custDataArray");

		//시도횟수 조회
		int idx = 0;
		for (int i = 0; i < map.get("callTryCount").toString().split(",").length; i++) {
			Map<String, Object> callCountMap = new HashMap<>();
			callCountMap.put("callTryCount", map.get("callTryCount").toString().split(",")[i]);
			if(i == 0) {
				callCountMap.put("status", "and");
			}else {
				callCountMap.put("status", "or");
			}
			if(map.get("callTryCount").toString().split(",").length == i+1) {
				callCountMap.put("operate", ')');
			}
			callTryCountList.add(idx++, callCountMap);
		}
		//대상상태 조회
		int statusIdx = 0;
		for (int i = 0; i < map.get("objectStatus").toString().split(",").length; i++) {
			Map<String,Object> objectStatusMap = new HashMap<>();
			objectStatusMap.put("objectStatus", map.get("objectStatus").toString().split(",")[i]);
			if(i == 0) {
				objectStatusMap.put("status", "and");
			}else {
				objectStatusMap.put("status", "or");
			}
			if(map.get("objectStatus").toString().split(",").length == i+1) {
				objectStatusMap.put("operate", ')');
			}
			objectStatusList.add(statusIdx++, objectStatusMap);
		}

		int index = 0;
		int custIndex = 0;
		for(int i = 0; i < jsonObj.getAsJsonArray("custDataArray").size(); i++) {
			Map<String, Object> custDataMap = new ObjectMapper().readValue(custJsonObj.get(i).toString(), Map.class);

			if(!custDataMap.get("keyName").equals("이름") && !custDataMap.get("keyName").equals("전화번호")
					&& !custDataMap.get("keyName").equals("시도횟수") && !custDataMap.get("keyName").equals("대상상태")) {
				if (!custDataMap.containsKey("keyValue")) {
					custDataMap.put("keyValue","");
				}
				String[] keyValue = custDataMap.get("keyValue").toString().split(",");
				for(int j=0; j < keyValue.length; j++) {
					Map<String, Object> custDataMap2 = new HashMap<>();
					custDataMap2.put("keyName", custDataMap.get("keyName"));
					custDataMap2.put("keyValue", keyValue[j]);
					if(j == 0) {
						custDataMap2.put("status", "and");
					}else {
						custDataMap2.put("status", "or");
					}

					if(keyValue.length == j+1){
						custDataMap2.put("operate", ')');
					}
					custDataList.add(index++, custDataMap2);
				}
				custDataList1.add(custDataMap);
			}else {
				Map<String, Object> custInfo = new HashMap<>();
				if(custDataMap.get("keyName").equals("이름")) {
					custInfo.put("custNm", custDataMap.get("keyValue"));
					custInfoList.add(custIndex++,custInfo);
				}else if(custDataMap.get("keyName").equals("전화번호")){
					custInfo.put("custTelNo", custDataMap.get("keyValue"));
					custInfoList.add(custIndex++,custInfo);
				}
			}
		}

		Map<String, Object> searchMap = new HashMap<>();
		searchMap.put("campaignId", Integer.parseInt(map.get("campaignId").toString()));
		searchMap.put("custDataArrayList", custDataList);
		searchMap.put("custDataList1", custDataList1);
		searchMap.put("callCountArrayList", callTryCountList);
		searchMap.put("custInfoList", custInfoList);
		searchMap.put("objectStatusArrayList", objectStatusList);

		searchMap.put("offset",Integer.parseInt(map.get("offset").toString()));
		searchMap.put("rowNum",Integer.parseInt(map.get("rowNum").toString()));

		List<Map<String, Object>> reservationCustList = callReservationApiService.getCustContractNos(searchMap);
		
		int totalCount = callReservationApiService.getReservationCustListCount(searchMap);
		
		String rowNum = map.get("rowNum") == null ? "1" : map.get("rowNum").toString();
		int page = map.get("page") == null ? 1 : Integer.parseInt(map.get("page").toString());

		//카운트 겟수( 페이징)
		JsonObject jsonReTurnObj =  new JsonObject();
		jsonReTurnObj.add("rows",new Gson().toJsonTree(reservationCustList));
		jsonReTurnObj.add("total",new Gson().toJsonTree(Math.round(Math.ceil(totalCount/Double.parseDouble(rowNum)))));
		jsonReTurnObj.add("page",new Gson().toJsonTree(page));
		jsonReTurnObj.add("records",new Gson().toJsonTree(totalCount));
		jqGirdWriter(response, jsonReTurnObj);

		return null;
	}

	@RequestMapping(value = "/insertObReservation", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> insertObReservation(CallReservationVO callReservationVO, @RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr======" + jsonStr);
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();

		// json -> map
		Map<String, Object> map = null;

		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		callReservationVO.setCampaignId(Integer.parseInt(map.get("campaignId").toString()));
		List<Map<String, Object>> custDataList = new ArrayList<>();
		JsonArray custJsonObj = (JsonArray) jp.parse(map.get("custData").toString());

		int index = 0;
		for(int i = 0; i < custJsonObj.size(); i++) {
			Map<String, Object> custDataMap = new ObjectMapper().readValue(custJsonObj.get(i).toString(), Map.class);

			if (!custDataMap.containsKey("keyValue")) {
				custDataMap.put("keyValue","");
			}

			String[] keyValue = custDataMap.get("keyValue").toString().split(",");
			for(int j=0; j < keyValue.length; j++) {
				Map<String, Object> custDataMap2 = new HashMap<>();
				custDataMap2.put("keyName", custDataMap.get("keyName"));
				custDataMap2.put("keyValue", keyValue[j]);

				custDataList.add(index++, custDataMap2);
			}
		}

		Map<String, Object> insertMap = new HashMap<>();

		insertMap.put("startDtm", map.get("startDtm").toString());
		insertMap.put("endDtm", map.get("endDtm").toString());
		insertMap.put("dispatchTime", map.get("dispatchTime").toString());
		insertMap.put("creator", userId);
		insertMap.put("campaignId", map.get("campaignId").toString());
		insertMap.put("weekDay", map.get("weekDay").toString());
		insertMap.put("cdDesc", map.get("cdDesc").toString());
		insertMap.put("cdName", map.get("cdName").toString());

		int insertReservationDate = outBoundCallReservationService.insertReservationDate(insertMap);

		Map<String, Object> insertCustData = new HashMap<>();

		for (int k = 0; k < custDataList.size(); k++) {
			insertCustData.put("custDataId", custDataList.get(k).get("keyName"));
			insertCustData.put("dataValue", custDataList.get(k).get("keyValue"));

			int insertReservationCust = outBoundCallReservationService.insertReservationCust(insertCustData);
		}

		return null;
	}

	@RequestMapping(value = "/updateObReservation", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> updateObReservation(CallReservationVO callReservationVO, @RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr======" + jsonStr);
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();

		// json -> map
		Map<String, Object> map = null;

		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		callReservationVO.setCampaignId(Integer.parseInt(map.get("campaignId").toString()));
		List<Map<String, Object>> custDataList = new ArrayList<>();
		JsonArray custJsonObj = (JsonArray) jp.parse(map.get("custData").toString());

		int index = 0;
		for(int i = 0; i < custJsonObj.size(); i++) {
			Map<String, Object> custDataMap = new ObjectMapper().readValue(custJsonObj.get(i).toString(), Map.class);
			if (!custDataMap.containsKey("keyValue")) {
				custDataMap.put("keyValue","");
			}
			String[] keyValue = custDataMap.get("keyValue").toString().split(",");
			for(int j=0; j < keyValue.length; j++) {
				Map<String, Object> custDataMap2 = new HashMap<>();
				custDataMap2.put("keyName", custDataMap.get("keyName"));
				custDataMap2.put("keyValue", keyValue[j]);

				custDataList.add(index++, custDataMap2);

			}
		}

		Map<String, Object> updateMap = new HashMap<>();

		updateMap.put("id", map.get("id").toString());
		updateMap.put("startDtm", map.get("startDtm").toString());
		updateMap.put("endDtm", map.get("endDtm").toString());
		updateMap.put("dispatchTime", map.get("dispatchTime").toString());
		updateMap.put("campaignId", map.get("campaignId").toString());
		updateMap.put("weekDay", map.get("weekDay").toString());
		updateMap.put("cdDesc", map.get("cdDesc").toString());
		updateMap.put("cdName", map.get("cdName").toString());
		updateMap.put("updater", userId);

		int updateReservationDate = outBoundCallReservationService.updateReservationDate(updateMap);

		String id = map.get("id").toString();
//		int deleteConditionCustom = outBoundCallReservationService.deleteConditionCustom(id);
		// Auto_call_condition_custom USE_YN => N 으로 변경
		int updateReservationCustUse = outBoundCallReservationService.updateReservationCustUse(id);

		Map<String, Object> updateCustData = new HashMap<>();

		for (int k = 0; k < custDataList.size(); k++) {
			updateCustData.put("id", map.get("id").toString());
			updateCustData.put("custDataId", custDataList.get(k).get("keyName"));
			updateCustData.put("dataValue", custDataList.get(k).get("keyValue"));

			int updateReservationCust = outBoundCallReservationService.updateReservationCust(updateCustData);
		}

		return null;
	}


	@RequestMapping(value = "/deleteObReservation", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> deleteObReservation(CallReservationVO callReservationVO, @RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr======" + jsonStr);
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();

		// json -> map
		Map<String, Object> map = null;

		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		List<Map<String, Object>> custDataList = new ArrayList<>();
		JsonArray idJsonObj = (JsonArray) jp.parse(map.get("idArr").toString());

		Map<String, Object> deleteIdMap = new HashMap<>();

		for (int i = 0; i < idJsonObj.size(); i++) {

			deleteIdMap.put("id", idJsonObj.get(i).getAsString());

			int deleteReservation = outBoundCallReservationService.delteReservation(deleteIdMap);
		}

		return null;
	}


	/* ob 예약콜 이력 메인 */
	@RequestMapping(value = "/obCallReservationRecordMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String obReservationRecordMain(FrontMntVO frontMntVO, HttpServletRequest req, Model model) throws ParseException {

		return "/callReservation/ob_callReservation_record";
	}

	/***
	 *  callReservation List
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getCallReservationRecordList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<CallReservationVO> getCallReservationRecordList(CallReservationVO callReservationVO, @RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr=======" + jsonStr);
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		callReservationVO.setCampaignId(Integer.parseInt(map.get("campaignId").toString()));
		callReservationVO.setCdName(map.get("cdName").toString());
		callReservationVO.setToDate(map.get("toDate").toString());
		callReservationVO.setFromDate(map.get("fromDate").toString());
		callReservationVO.setCallStatus(map.get("callStatus").toString());


		callReservationVO.setOffset(Integer.parseInt(map.get("offset").toString()));
		callReservationVO.setRowNum(Integer.parseInt(map.get("rowNum").toString()));

		List<CallReservationVO> callReservationRecordList = outBoundCallReservationService.getCallReservationRecordList(callReservationVO);

		int totalCount = outBoundCallReservationService.callReservationRecordListCount(callReservationVO);

		String rowNum = map.get("rowNum") == null ? "1" : map.get("rowNum").toString();
		int page = map.get("page") == null ? 1 : Integer.parseInt(map.get("page").toString());

		JsonObject jsonReTurnObj =  new JsonObject();
		jsonReTurnObj.add("rows",new Gson().toJsonTree(callReservationRecordList));
		jsonReTurnObj.add("total",new Gson().toJsonTree(Math.round(Math.ceil(totalCount/Double.parseDouble(rowNum)))));
		jsonReTurnObj.add("page",new Gson().toJsonTree(page));
		jsonReTurnObj.add("records",new Gson().toJsonTree(totalCount));
		jqGirdWriter(response, jsonReTurnObj);

		//카운트 겟수( 페이징)

		return null;
	}

	/***
	 *  callReservation List
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */

	@RequestMapping(value = "/getStatusReservationDetail", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String,Object> getStatusReservationDetail(CallReservationVO callReservationVO, @RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr=======" + jsonStr);

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		Map<String, Object> reservationMap = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		callReservationVO.setId(Integer.parseInt(map.get("id").toString()));
		callReservationVO.setCampaignId(Integer.parseInt(map.get("campaignId").toString()));
//		callReservationVO.setAutoCallConditionId(Integer.parseInt(map.get("autoCallCdCustomIds").toString()));
		List<String> autoCallConditionCustomIds = new ArrayList<>();
		for (int i = 0; i < map.get("autoCallConditionCustomIds").toString().split(",").length; i++) {
			autoCallConditionCustomIds.add(map.get("autoCallConditionCustomIds").toString().split(",")[i]);
		}
		callReservationVO.setAutoCallConditionCustomIds(autoCallConditionCustomIds);

		List<CallReservationVO> custDataValue = outBoundCallReservationService.getCustDataValue(callReservationVO);

		List<CallReservationVO> statusReservationInfo = outBoundCallReservationService.getStatusReservationInfo(callReservationVO);
//
		Map<String, Object> statusInfoMap = new HashMap<>();

		statusInfoMap.put("statusReservationInfo", statusReservationInfo);
		statusInfoMap.put("custDataValue", custDataValue);
		return statusInfoMap;
	}

	/***
	 *  callReservation List
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getReservationStatsCust", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<CallReservationVO> getReservationStatsCust(CallReservationVO callReservationVO, @RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		callReservationVO.setCampaignId(Integer.parseInt(map.get("campaignId").toString()));
		callReservationVO.setCdHistoryId(map.get("cdHistoryId").toString());

		callReservationVO.setOffset(Integer.parseInt(map.get("offset").toString()));
		callReservationVO.setRowNum(Integer.parseInt(map.get("rowNum").toString()));

		List<CallReservationVO> ReservationStatsCust = outBoundCallReservationService.getReservationStatsCust(callReservationVO);

		int totalCount = outBoundCallReservationService.getReservationStatsCustCount(callReservationVO);

		String rowNum = map.get("rowNum") == null ? "1" : map.get("rowNum").toString();
		int page = map.get("page") == null ? 1 : Integer.parseInt(map.get("page").toString());

		JsonObject jsonReTurnObj =  new JsonObject();
		jsonReTurnObj.add("rows",new Gson().toJsonTree(ReservationStatsCust));
		jsonReTurnObj.add("total",new Gson().toJsonTree(Math.round(Math.ceil(totalCount/Double.parseDouble(rowNum)))));
		jsonReTurnObj.add("page",new Gson().toJsonTree(page));
		jsonReTurnObj.add("records",new Gson().toJsonTree(totalCount));
		jqGirdWriter(response, jsonReTurnObj);

		//카운트 겟수( 페이징)

		return null;
	}



	/***
	 *
	 * @param response
	 * @param jsonReTurnObj
	 * @throws IOException
	 */
	public static void jqGirdWriter(HttpServletResponse response, JsonObject jsonReTurnObj) throws IOException {
	    response.setContentType("text/html");
	    response.setCharacterEncoding("UTF-8");
	    PrintWriter out = response.getWriter();
	    out.println(jsonReTurnObj);
	    out.close();
	  }
}
