package ai.maum.biz.fastaicc.main.statistic.controller;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CustDataClassVO;
import ai.maum.biz.fastaicc.main.cousult.outbound.service.OutboundMonitoringService;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.*;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.util.ExcelUtill;
import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.cousult.ailvr.service.AiIVRService;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCampaignInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmOpInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.CampaignService;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.cousult.common.service.ConsultingService;
import ai.maum.biz.fastaicc.main.cousult.inbound.service.InboundMonitoringService;
import ai.maum.biz.fastaicc.main.statistic.domain.StatisticVO;
import ai.maum.biz.fastaicc.main.statistic.service.StatisticsService;
import ai.maum.biz.fastaicc.main.user.domain.AuthenticaionVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import ai.maum.biz.fastaicc.main.user.service.AuthService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class StatisticsController {
	/* 공통서비스 */
	@Autowired
	CommonService commonService;

	/* 권한 서비스 */
	@Autowired
	AuthService authService;

	/* 인바운드 모니터 서비스 */
	@Autowired
	InboundMonitoringService inboundMonitoringService;

	@Autowired
	OutboundMonitoringService outboundMonitoringService;

	/* 상담서비스 */
	@Autowired
	ConsultingService consultingService;

	@Autowired
	CustomProperties customProperties;
	/* 설정값 */
	@Inject
	VariablesMng variablesMng;

    /*통계서비스     */
    @Autowired
    StatisticsService statisticsService;

    @Autowired
    CampaignService campaignService;

    @Inject
    ExcelUtill excelUtill;

    @Autowired
    AiIVRService aiIVRService;

	/***
	 * 인바운드 콜 토탈 통계main
	 *
	 * @param frontMntVO
	 * @param req
	 * @param model
	 * @return
	 */
	/* 인바운드 콜 토탈 통계 main */
	@RequestMapping(value = "/ibStatsTotalMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String ibStatsTotalMain(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		Map map = new HashMap();
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		return "statistics/ib_stats_total";
	}

	/* 통합(IB/OB) 콜 통계 main */
	@RequestMapping(value = "/statsMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String statsMain(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		Map map = new HashMap();
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		return "statistics/stats_main";
	}

	/* 통합(IB/OB) 콜 통계 발송경과 sub */
	@RequestMapping(value = "/sendStatisSub", method = { RequestMethod.GET, RequestMethod.POST })
	public String sendStatisSub(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		Map map = new HashMap();
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		return "statistics/voicebot_statis_sub/send_statis_sub";
	}
	/* 통합(IB/OB) 콜 통계 통화경과 sub */
	@RequestMapping(value = "/dialStatisSub", method = { RequestMethod.GET, RequestMethod.POST })
	public String dialStatisSub(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		Map map = new HashMap();
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		return "statistics/voicebot_statis_sub/dial_statis_sub";
	}
	/* 통합(IB/OB) 콜 통계 캠페인결과 sub */
	@RequestMapping(value = "/campStatisSub", method = { RequestMethod.GET, RequestMethod.POST })
	public String campStatisSub(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		Map map = new HashMap();
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		return "statistics/voicebot_statis_sub/camp_statis_sub";
	}
	/* 통합(IB/OB) 콜 통계 task별 고객이탈 sub */
	@RequestMapping(value = "/taskStatisSub", method = { RequestMethod.GET, RequestMethod.POST })
	public String taskStatisSub(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		Map map = new HashMap();
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		return "statistics/voicebot_statis_sub/task_statis_sub";
	}

	/***
	 *  인바운드 콜 토탈 통계 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getIbStatsTotalJQList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String ibStatsTotalJQList(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		// consultant는 자신의 통계만 조회한다. 2020-09-09
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=((AuthenticaionVO)auth);
			UserVO userVo = userDto.getUser();
			if(userVo != null && !userVo.getUserAuthTy().equals("S") && !userVo.getUserAuthTy().equals("A")) { // consultant
				map.put("userId", userVo.getUserId());
			}
		}

		//인바운드 콜 토탈 통계 리스트
		List<Map> ibStatsTotalSList = statisticsService.getIbStatsTotalSList(map);
		//토탈카운트 겟수( 페이징)
		Map totalCount = statisticsService.getTotalCount(map);
		// 리턴 값
		JsonObject jsonReTurnObj =  new JsonObject();
		jsonReTurnObj.add("rows",new Gson().toJsonTree(ibStatsTotalSList));
		//jsonReTurnObj.add("total",new Gson().toJsonTree(Integer.parseInt(totalCount.get("totalCnt").toString())/Integer.parseInt(map.get("rowNum").toString())));

		String rowNum = "";
		if(map.get("rowNum") == null) {
			rowNum = totalCount.get("totalCnt").toString();
		} else {
			rowNum = map.get("rowNum").toString();
		}
		jsonReTurnObj.add("total",new Gson().toJsonTree(Math.round(Math.ceil(Integer.parseInt(totalCount.get("totalCnt").toString())/Double.parseDouble(rowNum)))));

		jsonReTurnObj.add("page",new Gson().toJsonTree(map.get("page")));
		jsonReTurnObj.add("records",new Gson().toJsonTree(totalCount.get("totalCnt")));
		log.info("return = ="+jsonReTurnObj.toString());
		jqGirdWriter(response, jsonReTurnObj);
		return null;
	}

	/***
	 * Call 이력 main
	 *
	 * @param frontMntVO
	 * @param req
	 * @param model
	 * @return
	 */
	/* 콜 히스토리 이력조회 */
	@RequestMapping(value = "/ibStatsRecordMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String ibStatsRecordMain(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		Map map = new HashMap();

		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		return "statistics/ib_stats_record";
	}

	/***
	 *  Call 이력 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getStatsRecordJQList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String statsRecordJQList(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr====" + jsonStr);

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);


		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		// consultant는 자신의 통계만 조회한다.
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=((AuthenticaionVO)auth);
			UserVO userVo = userDto.getUser();
			if(userVo != null && !userVo.getUserAuthTy().equals("S") && !userVo.getUserAuthTy().equals("A")) { // consultant
				map.put("userId", userVo.getUserId());
			}
		}
		if(map.get("pageType").toString().equals("outbound")) {
			List<String> callResultList = null;
			List<String> guideResultList= null;
			List<String> inspectResultList = null;

			String[] result = {"callResult", "guideResult", "inspectResult"};
			List<String>[] resultList = new List[]{callResultList, guideResultList, inspectResultList};

			for (int i = 0; i < 3; i++) {
				resultList[i] = (List<String>) map.get(result[i]);
				if (resultList[i].contains("success") && resultList[i].contains("fail") && resultList[i]
						.contains("null")) {
					map.put(result[i], "");
				} else if (resultList[i].contains("success") && resultList[i].contains("fail")) {
					map.put(result[i], "sucFail");
				} else if (resultList[i].contains("success") && resultList[i].contains("null")) {
					map.put(result[i], "sucNull");
				} else if (resultList[i].contains("fail") && resultList[i].contains("null")) {
					map.put(result[i], "failNull");
				} else if (resultList[i].contains("success")) {
					map.put(result[i], "success");
				} else if (resultList[i].contains("fail")) {
					map.put(result[i], "fail");
				} else if (resultList[i].contains("null")) {
					map.put(result[i], "null");
				} else {
					map.put(result[i], "");
				}
			}
	
			CustDataClassVO custDataClassVO = new CustDataClassVO();
			List<Map<String, Object>> colList = new ArrayList<>();
			List<String> campaignIdList = new ArrayList<>();
			campaignIdList = (List<String>) map.get("sipName");
			if (campaignIdList != null && campaignIdList.size() > 0) {
				map.put("campaignId",campaignIdList.get(0));
			}
			for (String key : map.keySet()) {
				if(key.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*")) {
					custDataClassVO.setColumnKor(key);
					custDataClassVO.setCampaignId(Integer.parseInt(campaignIdList.get(0)));
					List<Integer> classId = outboundMonitoringService.getCustDataClassIdList(custDataClassVO);
					String caseType[] = String.valueOf(map.get(key)).split(",");
					for (int i=0; i<caseType.length; i++) {
						for (int j=0; j<classId.size(); j++) {
							Map<String, Object> searchMap = new HashMap<>();
							searchMap.put("custCol", "$.\""+classId.get(j)+"\"");
							searchMap.put("search", caseType[i]);
							if (i == 0 && j == 0) {
								searchMap.put("operator", "AND");
								if (caseType.length == 1 && classId.size() == 1) {
									searchMap.put("separator", ")");
								}
							} else {
								searchMap.put("operator", "OR");
								if (i == caseType.length - 1 && j == classId.size() - 1) {
									searchMap.put("separator", ")");
								}
							}
							colList.add(searchMap);
						}
					}
				}
			}
			map.put("custData", colList);
			map.put("displayYn", "y");
		}
		
		int totalCount = Integer.parseInt(statisticsService.getRecordCount(map).get("totalCnt").toString());
		
		if(map.get("pageType").toString().equals("outbound")) {
			if(map.get("inspectYn").toString().equals("true")) {
				int listRnum = Integer.parseInt(map.get("listRnum").toString());
				int allRecords = Integer.parseInt(map.get("allRecords").toString());
				double changeRnum = listRnum + totalCount - allRecords;
				int rowNum = Integer.parseInt(map.get("rowNum").toString());
				int page =(int) Math.ceil((changeRnum/rowNum));
				int offset =(int) ((Math.ceil(page) * rowNum) - rowNum);
				map.put("page",	page);
				map.put("offset", offset);
			}
		}
		
		List<Map> list = statisticsService.getStatsRecordSList(map);	//인바운드 콜 통계 리스트
//		int totalCount = list.size(); //카운트 겟수( 페이징)
		if(map.get("pageType").toString().equals("outbound")) {
			List<CustDataClassVO> custDataClassList = outboundMonitoringService.getCustDataClass(map);
	
			for (int i=0; i<list.size(); i++) {
				String custData = "";
				Map<String, Object> custMap = null;
				String custDataOri = (String) list.get(i).get("CUST_DATA");
				if (custDataOri != null && !"".equals(custDataOri)) {
					JsonObject custJsonObj = (JsonObject) jp.parse(String.valueOf(list.get(i).get("CUST_DATA")));
					custMap = new ObjectMapper().readValue(custJsonObj.toString(), Map.class);
					for(Map.Entry<String,Object> entry : custMap.entrySet()){
						System.out.println("key : " + entry.getKey() + " , value : " + entry.getValue());
						String colName = statisticsService.getColumnName(entry.getKey());
						list.get(i).put(colName, entry.getValue());
					}
				}
			}
	
			for (Map listMap : list) {
				String isCallSucc = listMap.get("CALL_STATUS_VALUE").toString();
				if (isCallSucc.equals("-")){
					listMap.put("IS_CALL_SUCC", "-");
				} else {
					listMap.put("IS_CALL_SUCC", isCallSucc.equals("200") ? "SUCCESS" : "FAIL");
				}
	
				String isGuideSucc = listMap.get("IS_GUIDE_SUCC").toString();
				if (!isGuideSucc.equals("-")) {
					listMap.put("IS_GUIDE_SUCC", isGuideSucc.equals("Y") ? "SUCCESS" : "FAIL");
				}

				String isInspectSucc = listMap.get("IS_INSPECT_SUCC").toString();
				if (!isInspectSucc.equals("-")) {
					listMap.put("IS_INSPECT_SUCC", isInspectSucc.equals("Y") ? "SUCCESS" : "FAIL");
				}
			}
		}

		String rowNum = "";
		if(map.get("rowNum") == null) {
			rowNum = String.valueOf(totalCount);
		} else {
			rowNum = map.get("rowNum").toString();
		}

		// 리턴 값
		JsonObject jsonReTurnObj =  new JsonObject();
		jsonReTurnObj.add("rows",new Gson().toJsonTree(list));
		jsonReTurnObj.add("page",new Gson().toJsonTree(map.get("page")));
		jsonReTurnObj.add("total",new Gson().toJsonTree(Math.round(Math.ceil(totalCount/Double.parseDouble(rowNum)))));
		jsonReTurnObj.add("record",new Gson().toJsonTree(totalCount));
		jqGirdWriter(response, jsonReTurnObj);

		return null;
	}

	/***
	 *  Call 이력 detail 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getStatsRecordDetail", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String statsRecordDetail(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr====" + jsonStr);

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		//인바운드 콜 통계 리스트
		List<Map<String, Object>> intentList = new ArrayList<>();
		List<Map> getList = null;
		List<Map> botContentsList = aiIVRService.getIVRBotContentsList(map);

		if(map.get("callTypeCode").equals("CT0001")) {
			getList = aiIVRService.getIbIntentList(map);

		} else {
			getList = aiIVRService.getObIntentList(map);
		}

		if ( getList.size() > 0 ) {
			Map<String, Object> list = new HashMap<>();
			list.put("contractNo", Integer.parseInt(getList.get(0).get("CONTRACT_NO").toString()));
			list.put("list", getList);
			intentList.add(list);
		}

		Map<String, Object> inspectList = null;
		inspectList = statisticsService.getInspectList(map);

		String sslDomain = "http://";
		if (customProperties.getRestSsl()) {
			sslDomain = "https://";
		}
		String audioUrl = sslDomain + customProperties.getAudioIp() + customProperties.getAudioPort() + "/call/record/"; // 웹소켓  URL

		// 리턴 값
		JsonObject jsonReTurnObj =  new JsonObject();
		jsonReTurnObj.add("botContentsList",new Gson().toJsonTree(botContentsList));
		jsonReTurnObj.add("intentList",new Gson().toJsonTree(intentList));
		jsonReTurnObj.add("inspectList",new Gson().toJsonTree(inspectList));
		jsonReTurnObj.add("audioUrl",new Gson().toJsonTree(audioUrl));
		jqGirdWriter(response, jsonReTurnObj);

		return null;
	}

  /***
   *  Call 이력 Inspect 정보 업데이트
   *
   * @param jsonStr
   * @return
   * @throws IOException
   * @throws JsonMappingException
   * @throws JsonParseException
   */
  @RequestMapping(value = "/updateInspectInfo", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public Map<String, Object> updateInspectInfo(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
      throws JsonParseException, JsonMappingException, IOException {
    log.info("jsonStr====" + jsonStr);

    // json파서
    JsonParser jp = new JsonParser();
    JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

    // json -> map
    Map<String, Object> map = null;
    map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();

		if (map.get("inspectResult").toString().contains("미완료")) {
			map.put("inspectResult", "N");
		} else {
			map.put("inspectResult", "Y");
		}
		map.put("inspector", userId);

		statisticsService.updateInspectInfo(map);

    return null;
  }

	/***
	 *  Call 이력 Task Date 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getTaskDate", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String getTaskDate(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr====" + jsonStr);

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		//인바운드 콜 통계 리스트
		List<Map> intentList = null;
		if(map.get("callTypeCode").equals("CT0001")) {
			intentList = aiIVRService.getIbIntentList(map);
		} else {
			intentList = aiIVRService.getObIntentList(map);
		}

		// 리턴 값
		JsonObject jsonReTurnObj =  new JsonObject();
		jsonReTurnObj.add("intentList",new Gson().toJsonTree(intentList));
		jqGirdWriter(response, jsonReTurnObj);

		return null;
	}
	

	/* 상담원별 통계 main */
	@RequestMapping(value = "/ibStatsAdviserMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String ibStatsAdviserMain(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		return "statistics/ib_stats_adviser";
	}

	/* 상담원별 통계 main */
	@RequestMapping(value = "/getConsultantList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<CmOpInfoVO> consultantList(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		// json파서, json -> map
		JsonObject jsonObj = new JsonParser().parse(jsonStr).getAsJsonObject();
		Map<String, Object> map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		CmOpInfoVO cmOpInfoVO = new CmOpInfoVO();
		List<CmOpInfoVO> companyAdviserList = new ArrayList<CmOpInfoVO>();

		// superAdmin, admin은 회사의 해당 상담원 전체 조회
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();

		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=((AuthenticaionVO)auth);
			UserVO userVo = userDto.getUser();

			if(userVo != null && !userVo.getUserAuthTy().equals("S") && !userVo.getUserAuthTy().equals("A")) { // consultant
				cmOpInfoVO.setCustOpId(userVo.getUserId());
				cmOpInfoVO.setCustOpNm(userVo.getUserNm());
				companyAdviserList.add(0, cmOpInfoVO);
			} else {
				cmOpInfoVO.setCompanyId(map.get("companyId").toString());
				companyAdviserList = statisticsService.getCompanyAdviserList(cmOpInfoVO);
			}
		}

		return companyAdviserList;
	}

	/***
	 * 상담원별 통계 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/ibStatsAdviserJQList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String ibStatsAdviserJQList(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {


		log.info("jsonStr====" + jsonStr);

		Map<String, Object> map = null;

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();

		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		// consultant는 자신의 통계만 조회한다.
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=((AuthenticaionVO)auth);
			UserVO userVo = userDto.getUser();
			if(userVo != null && !userVo.getUserAuthTy().equals("S") && !userVo.getUserAuthTy().equals("A")) { // consultant
				map.put("consultant", "Y");
				map.put("custOpId", userVo.getUserId());
			} else {
				map.put("consultant", "N");
			}
		}

		List multiple_select = new ArrayList();
		String[] splitStr = map.get("temp_multiple_select").toString().split(",");

		for(int i=0;i<splitStr.length; i++) {
			multiple_select.add(splitStr[i]);
		}

		map.put("multiple_select", multiple_select) ;

		//상담원별 통계 리스트
		List<Map> ibStatsAdviserSList = statisticsService.getIbStatsAdviserSList(map);

		//카운트 겟수( 페이징)
		Map totalCount = statisticsService.getAdviserCount(map);

		String rowNum = "";
		if(map.get("rowNum") == null) {
			rowNum = totalCount.get("totalCnt").toString();
		} else {
			rowNum = map.get("rowNum").toString();
		}

		// 리턴 값
		JsonObject jsonReTurnObj =  new JsonObject();
		jsonReTurnObj.add("rows",new Gson().toJsonTree(ibStatsAdviserSList));
		jsonReTurnObj.add("total",new Gson().toJsonTree(Math.round(Math.ceil(Integer.parseInt(totalCount.get("totalCnt").toString())/Double.parseDouble(rowNum)))));
		jsonReTurnObj.add("page",new Gson().toJsonTree(map.get("page")));
		jsonReTurnObj.add("records",new Gson().toJsonTree(totalCount.get("totalCnt")));

		log.info("return = ="+jsonReTurnObj.toString());

		jqGirdWriter(response, jsonReTurnObj);
		return null;

	}

	/***
	 *문의유형 통계main
	 *
	 * @param frontMntVO
	 * @param req
	 * @param model
	 * @return
	 */
	/* 문의유형 통계main */
	@RequestMapping(value = "/ibStatsTypeMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String ibStatsTypeMain(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		Map map = new HashMap();
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		return "statistics/ib_stats_type";
	}

	/***
	 *  문의유형 통계 JQGrid조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getIbStatsTypeJQList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String getIbStatsTypeJQList(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		log.info("getIbStatsTypeJQList_jsonStr====" + jsonStr);

		Map<String, Object> map = null;

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();

		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		//////수정필요
		//문의유형 통계 리스트
		List<Map> ibStatsTypeSList = statisticsService.getIbStatsTypeSList(map);

		//토탈카운트 겟수( 페이징)
		Map totalCount = statisticsService.getIbStatsTypeCount(map);

		// 리턴 값
		JsonObject jsonReTurnObj =  new JsonObject();
		jsonReTurnObj.add("rows",new Gson().toJsonTree(ibStatsTypeSList));
		//jsonReTurnObj.add("total",new Gson().toJsonTree(Integer.parseInt(totalCount.get("totalCnt").toString())/Integer.parseInt(map.get("rowNum").toString())));
		jsonReTurnObj.add("total",new Gson().toJsonTree(Math.round(Math.ceil(Integer.parseInt(totalCount.get("totalCnt").toString())/Double.parseDouble(map.get("rowNum").toString())))));

		jsonReTurnObj.add("page",new Gson().toJsonTree(map.get("page")));
		jsonReTurnObj.add("records",new Gson().toJsonTree(totalCount.get("totalCnt")));

		log.info("return = ="+jsonReTurnObj.toString());

		jqGirdWriter(response, jsonReTurnObj);
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

	/***
	 * 아웃바운드 콜 이력 main
	 *
	 * @param frontMntVO
	 * @param req
	 * @param model
	 * @return
	 */
	/* 아웃바운드 콜 토탈 통계 main */
	@RequestMapping(value = "/obStatsTotalMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String obStatsTotalMain(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		Map map = new HashMap();
		model.addAttribute("username", Utils.getLogInAccount(authService).getName()); // 로그인한 사용자 이름

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();

		map.put("sessId", userId);
		String companyId = statisticsService.getBoardCompanyId(map);
		map.put("companyId", companyId);
		String companyName = statisticsService.getBoardCompanyName(map); //로그인한 사용자의 회사 명
		model.addAttribute("companyName", companyName);

		return "statistics/ob_stats_total";
	}

	/***
	 * Call 이력 main
	 *
	 * @param frontMntVO
	 * @param req
	 * @param model
	 * @return
	 */
	/* 콜 히스토리 이력조회 */
	@RequestMapping(value = "/obStatsRecordMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String obStatsRecordMain(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		Map map = new HashMap();

		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		return "statistics/ob_stats_record";
	}

	/***
	 * Company 별 Campaign 리스트 조회
	 *
	 * @param statisticVO
	 * @param req
	 * @param model
	 * @return
	 */
	/* 콜 히스토리 이력조회 */
	@RequestMapping(value = "/getRecordCampaignList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> getRecordCampaignList(StatisticVO statisticVO, @RequestBody String jsonStr, HttpServletRequest req, Model model)
			throws IOException {

		JsonObject jsonObj = new JsonParser().parse(jsonStr).getAsJsonObject();
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=((AuthenticaionVO)auth);
			UserVO userVo = userDto.getUser();

			map.put("userAuthTy", userVo.getUserAuthTy().toString());
			if(userVo != null && !userVo.getUserAuthTy().equals("S") && !userVo.getUserAuthTy().equals("A")) { // consultant
				map.put("userId",userVo.getUserId().toString());
			}
		}

		List<Map<String, Object>> campaignList = outboundMonitoringService.getCampaignList(map);
		map.put("campaignList", campaignList);

		return map;
	}

	/***
	 * Company 별 Campaign 리스트 조회
	 *
	 * @param statisticVO
	 * @param req
	 * @param model
	 * @return
	 */
	/* 콜 히스토리 이력조회 */
	@RequestMapping(value = "/getSearchColumn", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> aaa(StatisticVO statisticVO, @RequestBody String jsonStr, HttpServletRequest req, Model model)
			throws IOException {

		JsonObject jsonObj = new JsonParser().parse(jsonStr).getAsJsonObject();
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		Map<String, Object> custClassMap = new HashMap<>();
		custClassMap.put("campaignId", String.valueOf(map.get("CAMPAIGN_ID")));
		custClassMap.put("displayYn", "y");
		List<CustDataClassVO> custDataClassList = outboundMonitoringService.getCustDataClass(custClassMap);

		map.put("colList", custDataClassList);

		return map;
	}

	/***
	 *  아웃바운드 콜 토탈 통계 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getObStatsTotalJQList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String obStatsTotalJQList(StatisticVO statisticVO, @RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {

		// json파서
		JsonObject jsonObj = new JsonParser().parse(jsonStr).getAsJsonObject();

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		// consultant는 자신의 통계만 조회한다.
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=((AuthenticaionVO)auth);
			UserVO userVo = userDto.getUser();
			if(userVo != null && !userVo.getUserAuthTy().equals("S") && !userVo.getUserAuthTy().equals("A")) { // consultant
				statisticVO.setCustOpId(userVo.getUserId());
			}
		}

		statisticVO.setToDate(map.get("toDate").toString());
		statisticVO.setFromDate(map.get("fromDate").toString());
		statisticVO.setCampaignId(map.get("campaignId").toString());
		statisticVO.setMinuteUnit(map.get("minuteUnit").toString());
		statisticVO.setSortOrder(map.get("sortOrder").toString());
		statisticVO.setTimeSortOrder(map.get("timeSortOrder").toString());
		statisticVO.setCompanyId(map.get("companyId").toString());

		// excelDown은 paging처리 안함
		if(map.get("excelYn").toString().equals("N")) {
			statisticVO.setPage(Integer.parseInt(map.get("page").toString()));
			statisticVO.setEndPageCnt(Integer.parseInt(map.get("endPageCnt").toString()));
			statisticVO.setRowNum(Integer.parseInt(map.get("rowNum").toString()));
			statisticVO.setOffset(Integer.parseInt(map.get("offset").toString()));
			statisticVO.setLastpage(Integer.parseInt(map.get("lastpage").toString()));
		}

		// 캠페인 전체 검색 시
		String companyId = map.get("companyId").toString();
		if(map.get("campaignId").toString().equals("")) {
			List<String> campaignIdList = statisticsService.getCampaignIdList(statisticVO);
			statisticVO.setCampaignIdList(campaignIdList);
		}

		List<StatisticVO> obStatsTotalList = statisticsService.getObStatsTotalList(statisticVO);

		//카운트 겟수( 페이징)
		int totalCount = statisticsService.getObStatsCount(statisticVO);
		String rowNum = map.get("rowNum") == null ? "1" : map.get("rowNum").toString();
		int page = map.get("page") == null ? 1 : Integer.parseInt(map.get("page").toString());
		// 리턴 값
		JsonObject jsonReTurnObj =  new JsonObject();
		jsonReTurnObj.add("rows",new Gson().toJsonTree(obStatsTotalList));
		jsonReTurnObj.add("total",new Gson().toJsonTree(Math.round(Math.ceil(totalCount/Double.parseDouble(rowNum)))));
		jsonReTurnObj.add("page",new Gson().toJsonTree(page));
		jsonReTurnObj.add("records",new Gson().toJsonTree(totalCount));
		jqGirdWriter(response, jsonReTurnObj);

		return null;
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
	@RequestMapping(value = "/getCampaignList", method = { RequestMethod.GET, RequestMethod.POST })
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
			if(userVo != null && !userVo.getUserAuthTy().equals("S") && !userVo.getUserAuthTy().equals("A")) { // consultant
				cmOpInfoVO.setCustOpId(userVo.getUserId());
			}
		}

		cmOpInfoVO.setCompanyId(map.get("companyId").toString());
		List<CmCampaignInfoVO> campaignList = campaignService.getCampaignList(cmOpInfoVO);

		return campaignList;
	}


	/***
	 * 아웃바운드 콜 토탈 통계 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getObStatsTotalJQListMap", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> getObStatsTotalJQListMap(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException {

		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		// 로그인 사용자 ID 가져오기
		HttpClient hc = HttpClients.createDefault();

		String ip = customProperties.getObcalltotalIp();
		String port = customProperties.getObcalltotalPort();
		String protocol = customProperties.getObcalltotalProtocol();

		String callMngUrl = "http://" + ip + port + protocol;

        //String callMngUrl = "http://10.122.64.152:5002/call_stat";
        log.info("----------------------"+callMngUrl);

        List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(1);
		nameValuePairs.add(new BasicNameValuePair("minute_unit", map.get("minute_unit").toString()));
		nameValuePairs .add(new BasicNameValuePair("start_time", map.get("start_time").toString()));
		nameValuePairs.add(new BasicNameValuePair("end_time", map.get("end_time").toString()));
		nameValuePairs.add(new BasicNameValuePair("campaign_id", map.get("campaign_id").toString()));

		log.info("OB CALL STATISTICS API URL"+callMngUrl+"?"+URLEncodedUtils.format(nameValuePairs, "UTF-8"));

        HttpGet get = new HttpGet(callMngUrl+"?"+URLEncodedUtils.format(nameValuePairs, "UTF-8"));

        HttpResponse getRes;
        List<Map> listSender = new ArrayList<Map>();

        Map obStatsTotalSList = null;

        try {

        	getRes = hc.execute(get);
        	String json = EntityUtils.toString(getRes.getEntity(), "UTF-8");

        	JsonParser jp1 = new JsonParser();
        	Object ob = jp1.parse(json);
        	JsonArray info = (JsonArray) ob;

        	for(int i = 0; i<info.size(); i++) {

        		obStatsTotalSList = new HashMap<String, String>();

        		JsonObject Jo = (JsonObject) info.get(i);
        		obStatsTotalSList.put("start_date", Jo.get("start_date"));
        		obStatsTotalSList.put("start_time", Jo.get("start_time"));
        		obStatsTotalSList.put("call_total", Jo.get("call_total"));
        		obStatsTotalSList.put("call_ai", Jo.get("call_ai"));
        		obStatsTotalSList.put("call_agent", Jo.get("call_agent"));
        		obStatsTotalSList.put("call_stop", Jo.get("call_stop"));
        		obStatsTotalSList.put("call_noresp", Jo.get("call_noresp"));
        		obStatsTotalSList.put("avg_duration", Jo.get("avg_duration"));

        		listSender.add(i, obStatsTotalSList);

        	}

        } catch (Exception e) {
            //log.info("### sendCM : error Message : " + e.getMessage());
        }

        //토탈카운트 겟수( 페이징)
		int totalCount = listSender.size();

		String rowNum = "30";

		// 리턴 값
		JsonObject jsonReTurnObj =  new JsonObject();
		jsonReTurnObj.add("rows",new Gson().toJsonTree(listSender));

		//jsonReTurnObj.add("page",new Gson().toJsonTree(map.get("page")));
		jsonReTurnObj.add("total",new Gson().toJsonTree(new Gson().toJsonTree((int)Math.ceil(totalCount/Double.parseDouble(rowNum.toString())))));
		jsonReTurnObj.add("record",new Gson().toJsonTree(totalCount));
		jsonReTurnObj.add("rowum", new Gson().toJsonTree(Integer.parseInt(rowNum)));

		log.info("return = ="+jsonReTurnObj.toString());

		// 리턴 값
		//map.put("userInfoList", new Gson().toJson(userInfoList)); // 사용자
		map.put("jsonReTurnObj", new Gson().toJson(listSender));
		return map;
	}
	//채팅 상담 이력
	@RequestMapping(value = "/chatListMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String obStatsChatList(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		Map map = new HashMap();

		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		return "statistics/ob_stats_chatList";
	}

	//채팅 상담 이력
	@RequestMapping(value = "/getObStatsChatList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String getObStatsChatList(@RequestBody String jsonStr,StatisticVO statisticVO , HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException{
		log.info("getIbStatsTypeJQList_jsonStr====" + jsonStr);

		Map<String, Object> map = null;

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();

		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		List<String> botIdArr = new ArrayList<>();
		
		for (int i = 0; i < map.get("botIdArr").toString().split(",").length; i++) {
			botIdArr.add(map.get("botIdArr").toString().split(",")[i]);
		}

		statisticVO.setToDate(map.get("toDate").toString());
		statisticVO.setFromDate(map.get("fromDate").toString());
		statisticVO.setDailyChk(map.get("dailyChk").toString());
		statisticVO.setGroupSortOrder(map.get("groupSortOrder").toString());
		statisticVO.setSortOrder(map.get("sortOrder").toString());
		statisticVO.setSearchTime(map.get("searchTime").toString());
		if(map.get("totalChatCnt").toString() != "") {
			statisticVO.setTotalChatCnt(Integer.parseInt(map.get("totalChatCnt").toString()));
		}
		statisticVO.setConsultant(map.get("consultant").toString());
		statisticVO.setBotIdArr(botIdArr);
		
		if(map.get("excelYn").toString().equals("N")) {
			statisticVO.setPage(Integer.parseInt(map.get("page").toString()));
			statisticVO.setEndPageCnt(Integer.parseInt(map.get("endPageCnt").toString()));
			statisticVO.setRowNum(Integer.parseInt(map.get("rowNum").toString()));
			statisticVO.setOffset(Integer.parseInt(map.get("offset").toString()));
			statisticVO.setLastpage(Integer.parseInt(map.get("lastpage").toString()));
		}
		
		List<StatisticVO> obStatsChatList = statisticsService.getObStatsChatList(statisticVO);
		
		for (int i = 0; i < obStatsChatList.size(); i++) {
			obStatsChatList.get(i).setBotCsrCnt((obStatsChatList.get(i).getBotChatCnt()+"/"+obStatsChatList.get(i).getConsultantCnt()));
		}
		
		//카운트 겟수( 페이징)
		int totalCount = statisticsService.getObStatsChatListCount(statisticVO);
		String rowNum = map.get("rowNum") == null ? "1" : map.get("rowNum").toString();
		int page = map.get("page") == null ? 1 : Integer.parseInt(map.get("page").toString());
		// 리턴 값
		JsonObject jsonReTurnObj =  new JsonObject();
		jsonReTurnObj.add("rows",new Gson().toJsonTree(obStatsChatList));
		jsonReTurnObj.add("total",new Gson().toJsonTree(Math.round(Math.ceil(totalCount/Double.parseDouble(rowNum)))));
		jsonReTurnObj.add("page",new Gson().toJsonTree(page));
		jsonReTurnObj.add("records",new Gson().toJsonTree(totalCount));
		jqGirdWriter(response, jsonReTurnObj);

		return null;
	}

	//채팅 상담 이력
	@RequestMapping(value = "/getDetailChat", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String,Object> getDetailChat(@RequestBody String jsonStr,StatisticVO statisticVO , HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException{
		log.info("getIbStatsTypeJQList_jsonStr====" + jsonStr);

		Map<String, Object> map = null;

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();

		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		statisticVO.setSession(map.get("session").toString());
		statisticVO.setSessionId(map.get("sessionId").toString());
		statisticVO.setHost(Integer.parseInt(map.get("host").toString()));
		
		Map<String, Object> DetailDialog = new HashMap<>();
		
		List<StatisticVO> DetailChat = statisticsService.getDetailChat(statisticVO);
		List<StatisticVO> ConsultMemo = statisticsService.getConsultMemo(statisticVO);
		List<StatisticVO> ConsultDialog = statisticsService.getConsultDialog(statisticVO);
		
		DetailDialog.put("DetailChat", DetailChat);
		DetailDialog.put("ConsultMemo", ConsultMemo);
		DetailDialog.put("ConsultDialog", ConsultDialog);
		
		return DetailDialog;
	}
	
	/***
	 * 채널별 챗봇 통계 main
	 *
	 * @param frontMntVO
	 * @param req
	 * @param model
	 * @return
	 */
	/* 채널별 챗봇 통계 */
	@RequestMapping(value = "/chatStatsChannelMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String chatStatsChannelMain(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		Map map = new HashMap();
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름

		return "statistics/chat_stats_channel";
	}
	
	//채팅 상담 이력
		@RequestMapping(value = "/getChatStats", method = { RequestMethod.GET, RequestMethod.POST })
		@ResponseBody
		public Map<String, Object> getChatStats(@RequestBody String jsonStr,StatisticVO statisticVO , HttpServletRequest request, HttpServletResponse response)
				throws JsonParseException, JsonMappingException, IOException{
			log.info("jsonStr====" + jsonStr);

			Map<String, Object> map = null;

			// json파서
			JsonParser jp = new JsonParser();
			JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
			JsonArray jArray = new JsonArray();

			// json -> map
			map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			statisticVO.setStartDate(map.get("startDate").toString());
			statisticVO.setEndDate(map.get("endDate").toString());
			statisticVO.setHost(Integer.parseInt(map.get("host").toString()));
			statisticVO.setLang(Integer.parseInt(map.get("lang").toString()));
			
			List<StatisticVO> getTotalMessages = statisticsService.getTotalMessages(statisticVO);
			List<StatisticVO> getTotalUsers = statisticsService.getTotalUsers(statisticVO);
//			List<StatisticVO> getWeakProb = statisticsService.getWeakProb(statisticVO);
			List<StatisticVO> getTotalEmail = statisticsService.getTotalEmail(statisticVO);
//			List<StatisticVO> getMostIntents = statisticsService.getMostIntents(statisticVO);
//			List<StatisticVO> getMostIntentsAll = statisticsService.getMostIntentsAll(statisticVO);
//			List<StatisticVO> getTotalMsgPerHour = statisticsService.getTotalMsgPerHour(statisticVO);
			
			Map<String, Object> chatStatsMap = new HashMap<>();
			
			chatStatsMap.put("getTotalMessages", getTotalMessages);
			chatStatsMap.put("getTotalUsers", getTotalUsers);
//			chatStatsMap.put("getWeakProb", getWeakProb);
			chatStatsMap.put("getTotalEmail", getTotalEmail);
//			chatStatsMap.put("getMostIntents", getMostIntents);
//			chatStatsMap.put("getMostIntentsAll", getMostIntentsAll);
//			chatStatsMap.put("getTotalMsgPerHour", getTotalMsgPerHour);
			
			
			return chatStatsMap;
		}
		
		@RequestMapping(value = "/getMostIntents", method = { RequestMethod.GET, RequestMethod.POST })
		@ResponseBody
		public Map<String, Object> getMostIntents(@RequestBody String jsonStr,StatisticVO statisticVO , HttpServletRequest request, HttpServletResponse response)
				throws JsonParseException, JsonMappingException, IOException{
			log.info("jsonStr====" + jsonStr);
			
			Map<String, Object> map = null;
			
			// json파서
			JsonParser jp = new JsonParser();
			JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
			JsonArray jArray = new JsonArray();
			
			// json -> map
			map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			statisticVO.setStartDate(map.get("startDate").toString());
			statisticVO.setEndDate(map.get("endDate").toString());
			statisticVO.setHost(Integer.parseInt(map.get("host").toString()));
			statisticVO.setLang(Integer.parseInt(map.get("lang").toString()));
			
			List<StatisticVO> getMostIntents = null;
			
			if(map.get("selectView").toString().equals("10")) {
				getMostIntents = statisticsService.getMostIntents(statisticVO);
			}else {
				getMostIntents = statisticsService.getMostIntentsAll(statisticVO);
			}
			
			Map<String, Object> mostIntentsMap = new HashMap<>();
			
			mostIntentsMap.put("getMostIntents", getMostIntents);
			
			return mostIntentsMap;
		}
		
		@RequestMapping(value = "/getUttersFromIntent", method = { RequestMethod.GET, RequestMethod.POST })
		@ResponseBody
		public Map<String, Object> getUttersFromIntent(@RequestBody String jsonStr,StatisticVO statisticVO , HttpServletRequest request, HttpServletResponse response)
				throws JsonParseException, JsonMappingException, IOException{
			log.info("jsonStr====" + jsonStr);
			
			Map<String, Object> map = null;
			
			// json파서
			JsonParser jp = new JsonParser();
			JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
			JsonArray jArray = new JsonArray();
			
			// json -> map
			map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			statisticVO.setStartDate(map.get("startDate").toString());
			statisticVO.setEndDate(map.get("endDate").toString());
			statisticVO.setIntent(map.get("intent").toString());
			statisticVO.setHost(Integer.parseInt(map.get("host").toString()));
			statisticVO.setLang(Integer.parseInt(map.get("lang").toString()));
			
			List<StatisticVO> getUttersFromIntent = statisticsService.getUttersFromIntent(statisticVO);
			
			Map<String, Object> utterMap = new HashMap<>();
			
			utterMap.put("getUttersFromIntent", getUttersFromIntent);
			
			return utterMap;
		}
		
		@RequestMapping(value = "/getTotalLineChart", method = { RequestMethod.GET, RequestMethod.POST })
		@ResponseBody
		public Map<String, Object> getTotalLineChart(@RequestBody String jsonStr,StatisticVO statisticVO , HttpServletRequest request, HttpServletResponse response)
				throws JsonParseException, JsonMappingException, IOException{
			log.info("jsonStr====" + jsonStr);
			
			Map<String, Object> map = null;
			
			// json파서
			JsonParser jp = new JsonParser();
			JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
			JsonArray jArray = new JsonArray();
			
			// json -> map
			map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			statisticVO.setStartDate(map.get("startDate").toString());
			statisticVO.setEndDate(map.get("endDate").toString());
			statisticVO.setHost(Integer.parseInt(map.get("host").toString()));
			statisticVO.setLang(Integer.parseInt(map.get("lang").toString()));
			
//			List<StatisticVO> getTotalMsgPerHour = statisticsService.getTotalMsgPerHour(statisticVO);
//			List<StatisticVO> getTotalUserPerHour = statisticsService.getTotalUserPerHour(statisticVO);
			
			List<Integer> TotalMsgPerHourList = new ArrayList<>();
			int i = 0;
			for (StatisticVO users : statisticsService.getTotalMsgPerHour(statisticVO)) {
				while(users.getHour() > i) {
					TotalMsgPerHourList.add(0);
					i++;
				}
				TotalMsgPerHourList.add(users.getCount());
				i++;
			}
			for(; i <24; i++) {
				TotalMsgPerHourList.add(0);
			}
			List<Integer> TotalUserPerHourList = new ArrayList<>();
			i = 0;
			for (StatisticVO users : statisticsService.getTotalUserPerHour(statisticVO)) {
				while(users.getHour() > i) {
					TotalUserPerHourList.add(0);
					i++;
				}
				TotalUserPerHourList.add(users.getCount());
				i++;
			}
			for(; i <24; i++) {
				TotalUserPerHourList.add(0);
			}
			
			Map<String, Object> lineChartDataMap = new HashMap<>();
			
			lineChartDataMap.put("getTotalMsgPerHour", TotalMsgPerHourList);
			lineChartDataMap.put("getTotalUserPerHour", TotalUserPerHourList);
			
			return lineChartDataMap;
		}
		
		@RequestMapping(value = "/getdoughnutChart", method = { RequestMethod.GET, RequestMethod.POST })
		@ResponseBody
		public Map<String, Object> getdoughnutChart(@RequestBody String jsonStr,StatisticVO statisticVO , HttpServletRequest request, HttpServletResponse response)
				throws JsonParseException, JsonMappingException, IOException{
			log.info("jsonStr====" + jsonStr);
			
			Map<String, Object> map = null;
			Map<String, Object> devicePcMap = null;
			Map<String, Object> deviceMobileMap = null;
			Map<String, Object> channelHpMap = null;
			Map<String, Object> channelQrMap = null;
			Map<String, Object> channelKakaoMap = null;
			Map<String, Object> linkCountMap = null;
			
			// json파서
			JsonParser jp = new JsonParser();
			JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
			JsonArray jArray = new JsonArray();
			
			// json -> map
			map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			devicePcMap = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			deviceMobileMap = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			channelHpMap = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			channelQrMap = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			channelKakaoMap = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			linkCountMap = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			
			statisticVO.setStartDate(map.get("startDate").toString());
			statisticVO.setEndDate(map.get("endDate").toString());
			statisticVO.setHost(Integer.parseInt(map.get("host").toString()));
			statisticVO.setLang(Integer.parseInt(map.get("lang").toString()));
			
			devicePcMap.put("channel", "PC");
			deviceMobileMap.put("channel", "MOBILE");
			channelHpMap.put("channel", "HOMEPAGE");
			channelQrMap.put("channel", "QR");
			channelKakaoMap.put("channel", "KAKAOTALK");
			
			List<StatisticVO> getTotalUsers = statisticsService.getTotalUsers(statisticVO);
			List<StatisticVO> getTodayUsers = statisticsService.getTodayUsers(statisticVO);
			
			List<Map> getPcCount = statisticsService.getDeviceCount(devicePcMap);
			List<Map> getMobileCount = statisticsService.getDeviceCount(deviceMobileMap);
			List<Map> getHpCount = statisticsService.getDeviceCount(channelHpMap);
			List<Map> getQrCount = statisticsService.getDeviceCount(channelQrMap);
			List<Map> getKakaoCount = statisticsService.getDeviceCount(channelKakaoMap);
			List<Map> getLinkCount = statisticsService.getLinkCount(linkCountMap);
			
			Map<String, Object> doughnutChartDataMap = new HashMap<>();
			
			doughnutChartDataMap.put("getTotalUsers", getTotalUsers);
			doughnutChartDataMap.put("getTodayUsers", getTodayUsers);
			doughnutChartDataMap.put("getPcCount", getPcCount);
			doughnutChartDataMap.put("getMobileCount", getMobileCount);
			doughnutChartDataMap.put("getHpCount", getHpCount);
			doughnutChartDataMap.put("getQrCount", getQrCount);
			doughnutChartDataMap.put("getKakaoCount", getKakaoCount);
			doughnutChartDataMap.put("getLinkCount", getLinkCount);
			
			return doughnutChartDataMap;
		}
		
		@RequestMapping(value = "/getUserCountry", method = { RequestMethod.GET, RequestMethod.POST })
		@ResponseBody
		public Map<String, Object> getUserCountry(@RequestBody String jsonStr,StatisticVO statisticVO , HttpServletRequest request, HttpServletResponse response)
				throws JsonParseException, JsonMappingException, IOException{
			log.info("jsonStr====" + jsonStr);
			
			Map<String, Object> map = null;
			
			// json파서
			JsonParser jp = new JsonParser();
			JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
			JsonArray jArray = new JsonArray();
			
			// json -> map
			map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			
			statisticVO.setStartDate(map.get("startDate").toString());
			statisticVO.setEndDate(map.get("endDate").toString());
			statisticVO.setHost(Integer.parseInt(map.get("host").toString()));
			statisticVO.setLang(Integer.parseInt(map.get("lang").toString()));
			
			
			List<StatisticVO> getUserCountry = statisticsService.getUserCountry(statisticVO);
			
			Map<String, Object> userCountryMap = new HashMap<>();
			
			userCountryMap.put("getUserCountry", getUserCountry);
			
			return userCountryMap;
		}
		
		@RequestMapping(value = "/getChatBotList", method = { RequestMethod.GET, RequestMethod.POST })
		@ResponseBody
		public List<Map<String, Object>> getChatBotList(@RequestBody String jsonStr, StatisticVO statisticVO,HttpServletRequest request,
				HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
			
			// json파서
			JsonParser jp = new JsonParser();
			JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

			// json -> map
			Map<String, Object> map = null;
			map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			List<StatisticVO> chatBotList = new ArrayList<StatisticVO>();
			List<StatisticVO> accountList = statisticsService.getAccountList(statisticVO);
			
			if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
				AuthenticaionVO userDto=(AuthenticaionVO)auth;
				UserVO userVo = userDto.getUser();
				
				String companyId = "";
				if(map.get("companyId").toString() != "") {
					chatBotList = statisticsService.getChatBotList(map.get("companyId").toString());
				}else {
					if(userVo!=null) {
						if(!userVo.getUserAuthTy().equals("S")) {
							companyId = userVo.getCompanyId().toString();
						}
						chatBotList = statisticsService.getChatBotList(companyId);
					}
				}
			}
			List<Map<String, Object>> chatBotListMap = new ArrayList<>();
			int botCnt = 0; 
			for (int i = 0; i < chatBotList.size(); i++) {
				Map<String, Object> chatBotMap = new HashMap<>();
				for (int j = 0; j < accountList.size(); j++) {
					if(chatBotList.get(i).getBotId().toString().equals(accountList.get(j).getNo().toString())) {
						chatBotList.get(i).setName(accountList.get(j).getName());
						chatBotMap.put("name", chatBotList.get(i).getName());
						chatBotMap.put("botId", chatBotList.get(i).getBotId());
						chatBotListMap.add(botCnt++, chatBotMap);
					}
				}
			}			
			
			return chatBotListMap;
		}
		
		
		@RequestMapping(value = "/updateEmailInfo", method = { RequestMethod.GET, RequestMethod.POST })
		@ResponseBody
		public Map<String, Object> updateEmailInfo(@RequestBody String jsonStr,StatisticVO statisticVO , HttpServletRequest request, HttpServletResponse response)
				throws JsonParseException, JsonMappingException, IOException{
			log.info("jsonStr====" + jsonStr);
			
			Map<String, Object> map = null;
			
			// json파서
			JsonParser jp = new JsonParser();
			JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
			JsonArray jArray = new JsonArray();
			
			// json -> map
			map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			
			statisticsService.updateEmailInfo(map);
			
			return null;
		}
		
		@RequestMapping("/chatExcelDown")
		public void chatExcelDown(HttpServletResponse response, HttpServletRequest request,StatisticVO statisticVO) throws Exception{
			//사용자당 평균 대화수
			int AvgMsgUser = 0;
			
			int lang = Integer.parseInt(request.getParameter("langValue"));
			String countryLang = null;
			if(lang == 1) {
				countryLang = "한국어";
			}else if(lang == 2) {
				countryLang = "영어";
			}else if(lang == 3) {
				countryLang = "일본어";
			}else if(lang == 4) {
				countryLang = "중국어";
			}
						
			
			statisticVO.setStartDate(request.getParameter("fromDate"));
			statisticVO.setEndDate(request.getParameter("toDate"));
			statisticVO.setHost(Integer.parseInt(request.getParameter("hotelValue")));
			statisticVO.setLang(Integer.parseInt(request.getParameter("langValue")));
			
			//총 메세지수(총 사용수)
			List getTotalMessages = statisticsService.getTotalMessages(statisticVO);
			List<Map<String,Object>> getTotalMessagesList = getTotalMessages;
			//총 유저수
			List getTotalUsers = statisticsService.getTotalUsers(statisticVO);
			List<Map<String,Object>> getTotalUsersList = getTotalUsers;
			//사용자당 평균 대화수
			int totalMsg = Integer.parseInt(getTotalMessagesList.get(0).get("totalCnt").toString());
			int totalUser = Integer.parseInt(getTotalUsersList.get(0).get("totalCnt").toString());
			if(totalUser != 0) {
				AvgMsgUser = Math.round(totalMsg/totalUser);
			}
			//총 메일수
			List getTotalEmail = statisticsService.getTotalEmail(statisticVO);
			List<Map<String,Object>> getTotalEmailList = getTotalEmail;
			//시간당 사용자 수
			List getTotalUserPerHour = statisticsService.getTotalUserMaxAvgPerHour(statisticVO);
			List<Map<String,Object>> getTotalUserPerHourList = getTotalUserPerHour;
			//Today 사용자 유입 수
			List getTodayUser = statisticsService.getTodayUsers(statisticVO);
			List<Map<String, Object>> getTodayUserList = getTodayUser;
			
			//기존 사용자 수
			int existingUser = Integer.parseInt(getTotalUsersList.get(0).get("totalCnt").toString()) - Integer.parseInt(getTodayUserList.get(0).get("totalCnt").toString());
			
			Map<String, Object> devicePcMap = new HashMap<>();
			devicePcMap.put("channel", "PC");
			devicePcMap.put("startDate", request.getParameter("fromDate"));
			devicePcMap.put("endDate", request.getParameter("toDate"));
			devicePcMap.put("host", Integer.parseInt(request.getParameter("hotelValue")));
			devicePcMap.put("lang", Integer.parseInt(request.getParameter("langValue")));
			Map<String, Object> deviceMobileMap = new HashMap<>();
			deviceMobileMap.put("channel", "MOBILE");
			deviceMobileMap.put("startDate", request.getParameter("fromDate"));
			deviceMobileMap.put("endDate", request.getParameter("toDate"));
			deviceMobileMap.put("host", Integer.parseInt(request.getParameter("hotelValue")));
			deviceMobileMap.put("lang", Integer.parseInt(request.getParameter("langValue")));
			Map<String, Object> channelHpMap = new HashMap<>();
			channelHpMap.put("channel", "HOMEPAGE");
			channelHpMap.put("startDate", request.getParameter("fromDate"));
			channelHpMap.put("endDate", request.getParameter("toDate"));
			channelHpMap.put("host", Integer.parseInt(request.getParameter("hotelValue")));
			channelHpMap.put("lang", Integer.parseInt(request.getParameter("langValue")));
			Map<String, Object> channelQrMap = new HashMap<>();
			channelQrMap.put("channel", "QR");
			channelQrMap.put("startDate", request.getParameter("fromDate"));
			channelQrMap.put("endDate", request.getParameter("toDate"));
			channelQrMap.put("host", Integer.parseInt(request.getParameter("hotelValue")));
			channelQrMap.put("lang", Integer.parseInt(request.getParameter("langValue")));
			Map<String, Object> channelKakaoMap = new HashMap<>();
			channelKakaoMap.put("channel", "KAKAOTALK");
			channelKakaoMap.put("startDate", request.getParameter("fromDate"));
			channelKakaoMap.put("endDate", request.getParameter("toDate"));
			channelKakaoMap.put("host", Integer.parseInt(request.getParameter("hotelValue")));
			channelKakaoMap.put("lang", Integer.parseInt(request.getParameter("langValue")));
			
			Map<String, Object> linkCountMap = new HashMap<>();
			linkCountMap.put("startDate", request.getParameter("fromDate"));
			linkCountMap.put("endDate", request.getParameter("toDate"));
			linkCountMap.put("host", Integer.parseInt(request.getParameter("hotelValue")));
			linkCountMap.put("lang", Integer.parseInt(request.getParameter("langValue")));
			//유입 통계 (PC/모바일)
			List getPcCount = statisticsService.getDeviceCount(devicePcMap);
			List<Map<String,Object>> getPcCountList = getPcCount;
			List getMobileCount = statisticsService.getDeviceCount(deviceMobileMap);
			List<Map<String,Object>> getMobileCountList = getMobileCount;
			
			//유입경로 (홈페이지/QR코드/카카오톡)
			List getHpCount = statisticsService.getDeviceCount(channelHpMap);
			List<Map<String,Object>> getHpCountList = getHpCount;
			List getQrCount = statisticsService.getDeviceCount(channelQrMap);
			List<Map<String,Object>> getQrCountList = getQrCount;
			List getKakaoCount = statisticsService.getDeviceCount(channelKakaoMap);
			List<Map<String,Object>> getKakaoCountList = getKakaoCount;
			
			//a tag link count
			List getLinkCount = statisticsService.getLinkCount(linkCountMap);
			List<Map<String,Object>> getLinkCountList = getLinkCount;
			
			// 탑10 유저 질문
			List getMostIntentsAll = statisticsService.getMostIntentsAll(statisticVO);
			List<Map<String, Object>> getMostIntentAllList = getMostIntentsAll;
			
			//시트2 intent 유저 답변 및 count
			List getAllUttersFromIntent =  statisticsService.getAllUttersFromIntent(statisticVO);
			List<Map<String,Object>> getAllUttersFromIntentList = getAllUttersFromIntent;
			
			//파일을 읽기위해 엑셀파일을 가져온다
			String file =  request.getSession().getServletContext().getRealPath("/resources/template/excel") ;
			File filePath = new File(file +"/"+ "redtie_statistic.xlsx");
			
			
			InputStream is = new FileInputStream(filePath);
			XSSFWorkbook workbook = new XSSFWorkbook(is);
			try {

				
				XSSFSheet sheet = workbook.getSheetAt(0);
				XSSFSheet sheet2 = workbook.getSheetAt(1);
				XSSFSheet sheet3 = workbook.getSheetAt(2);
				if( sheet == null ){
					System.out.println("Sheet1 is Null!");
					return;
				}

				Row row = null;
				Cell cell = null;
				int rowNo = 0;

				row = sheet.getRow(rowNo++);
				cell = row.getCell(3);
				cell.setCellValue(request.getParameter("fromDate") + " ~ " + request.getParameter("toDate"));
				
				row = sheet.getRow(rowNo++);
				cell = row.getCell(1);
				cell.setCellValue(request.getParameter("hotelNm"));
				
				row = sheet.getRow(rowNo++);
				row = sheet.getRow(rowNo++);
				cell = row.getCell(2);
				cell.setCellValue(countryLang);
				row = sheet.getRow(rowNo++);
				cell= row.getCell(2);
				cell.setCellValue(getTotalMessagesList.get(0).get("totalCnt").toString());
				
				row = sheet.getRow(rowNo++);
				cell = row.getCell(2);
				cell.setCellValue(getTotalUsersList.get(0).get("totalCnt").toString());
				
				row = sheet.getRow(rowNo++);
				cell = row.getCell(2);
				cell.setCellValue(AvgMsgUser);
				
				row = sheet.getRow(rowNo++);
				cell = row.getCell(2);
				cell.setCellValue(getTotalEmailList.get(0).get("totalCnt").toString());
				
				row = sheet.getRow(rowNo++);
				row = sheet.getRow(rowNo++);
				
				row = sheet.getRow(rowNo++);
				cell = row.getCell(2);
				cell.setCellValue(getTotalUserPerHourList.get(0).get("maxCnt").toString());

				row = sheet.getRow(rowNo++);
				cell = row.getCell(2);
				cell.setCellValue(getTotalUserPerHourList.get(0).get("avgCnt").toString());
				
				row = sheet.getRow(rowNo++);
				row = sheet.getRow(rowNo++);
				cell = row.getCell(2);
				cell.setCellValue(countryLang);
				
				row = sheet.getRow(rowNo++);
				cell = row.getCell(2);
				cell.setCellValue(existingUser);
				row = sheet.getRow(rowNo++);
				cell = row.getCell(2);
				cell.setCellValue(getTodayUserList.get(0).get("totalCnt").toString());
				row = sheet.getRow(rowNo++);
				cell = row.getCell(2);
				cell.setCellValue(getPcCountList.get(0).get("totalCnt").toString());
				row = sheet.getRow(rowNo++);
				cell = row.getCell(2);
				cell.setCellValue(getMobileCountList.get(0).get("totalCnt").toString());
				
				row = sheet.getRow(rowNo++);
				row = sheet.getRow(rowNo++);
				cell = row.getCell(2);
				cell.setCellValue(countryLang);
				row = sheet.getRow(rowNo++);
				cell = row.getCell(2);
				cell.setCellValue(getHpCountList.get(0).get("totalCnt").toString());
				row = sheet.getRow(rowNo++);
				cell = row.getCell(2);
				cell.setCellValue(getQrCountList.get(0).get("totalCnt").toString());
				row = sheet.getRow(rowNo++);
				cell = row.getCell(2);
				cell.setCellValue(getKakaoCountList.get(0).get("totalCnt").toString());
				
				row = sheet.getRow(rowNo++);
				row = sheet.getRow(rowNo++);
				cell = row.getCell(2);
				cell.setCellValue(countryLang);
				
				int getMostIntentAllLength  = 0;
				if(getMostIntentAllList.size() < 10) {
					getMostIntentAllLength = getMostIntentAllList.size();
				}else {
					getMostIntentAllLength = 10;
				}
				
				for (int i = 0; i < getMostIntentAllLength; i++) {
					if(getMostIntentAllList.size() > 0) {
					row = sheet.getRow(rowNo++);
					cell = row.getCell(1);
					cell.setCellValue(getMostIntentAllList.get(i).get("content").toString());
					cell = row.getCell(2);
					cell.setCellValue(getMostIntentAllList.get(i).get("COUNT").toString());
					}
				}
				
				rowNo = 1;
				row = sheet2.getRow(rowNo++);
				int mergeFirstRow = 1;
				int mergeLastRow = 0;
				
				int idx = 0;
				int mergeCnt = 0;

				for (int i = 0; i < getAllUttersFromIntentList.size(); i++) {
					row = sheet2.createRow(i+1);
				}
				
				CellStyle style = workbook.createCellStyle();

				style.setAlignment(HorizontalAlignment.CENTER);
				style.setVerticalAlignment(VerticalAlignment.CENTER);
				
				
				for (int i = 0; i < getAllUttersFromIntentList.size(); i++) {
					
					if(i+1 == getAllUttersFromIntentList.size()) {
						idx = i;
					}else {
						idx = i+1;
					}
					Map<String, Object> getAllUttersFromIntentMap = getAllUttersFromIntentList.get(i);
					Map<String, Object> getAllUttersFromIntentMap2 = getAllUttersFromIntentList.get(idx);
					
					if(!getAllUttersFromIntentMap.get("intent").toString().equals(getAllUttersFromIntentMap2.get("intent").toString())) {
						mergeCnt = Integer.parseInt(getAllUttersFromIntentMap.get("mergeCnt").toString());
						
						if(mergeCnt == 1) {
							row = sheet2.getRow(mergeFirstRow);
							cell = row.createCell(0);
							cell.setCellStyle(style);
							cell.setCellValue(getAllUttersFromIntentMap.get("intent").toString());
							cell = row.createCell(1);
							cell.setCellStyle(style);
							cell.setCellValue(getAllUttersFromIntentMap.get("intentCnt").toString());
							cell = row.createCell(2);
							cell.setCellValue(getAllUttersFromIntentMap.get("utter").toString());
							cell = row.createCell(3);
							cell.setCellValue(getAllUttersFromIntentMap.get("utterCnt").toString());
							
							mergeFirstRow = mergeFirstRow + 1;
							mergeLastRow = mergeFirstRow - 1;
							
						}else {
							sheet2.addMergedRegion(new CellRangeAddress(mergeFirstRow, mergeLastRow + mergeCnt ,0,0));
							row = sheet2.getRow(mergeFirstRow);
							cell = row.createCell(0);
							cell.setCellStyle(style);
							cell.setCellValue(getAllUttersFromIntentMap.get("intent").toString());
							sheet2.addMergedRegion(new CellRangeAddress(mergeFirstRow, mergeLastRow + mergeCnt ,1,1));
							row = sheet2.getRow(mergeFirstRow);
							cell = row.createCell(1);
							cell.setCellStyle(style);
							cell.setCellValue(getAllUttersFromIntentMap.get("intentCnt").toString());
							cell = sheet2.getRow(mergeLastRow + mergeCnt).createCell(2);
							cell.setCellValue(getAllUttersFromIntentMap.get("utter").toString());
							cell = sheet2.getRow(mergeLastRow + mergeCnt).createCell(3);
							cell.setCellValue(getAllUttersFromIntentMap.get("utterCnt").toString());
							
							mergeLastRow = mergeLastRow + mergeCnt;
							mergeFirstRow = mergeLastRow + 1;
						}
					}else {
						row = sheet2.getRow(i+1);
						cell = row.createCell(2);
						cell.setCellValue(getAllUttersFromIntentMap.get("utter").toString());
						cell = row.createCell(3);
						cell.setCellValue(getAllUttersFromIntentMap.get("utterCnt").toString());
					}
					
					// 엑셀 마지막 로우 값
					if(i+1 == getAllUttersFromIntentList.size()) {
						row = sheet2.getRow(i+1);
						cell = row.createCell(0);
						cell.setCellStyle(style);
						cell.setCellValue(getAllUttersFromIntentMap.get("intent").toString());
						cell = row.createCell(1);
						cell.setCellStyle(style);
						cell.setCellValue(getAllUttersFromIntentMap.get("intentCnt").toString());
						cell = row.createCell(2);
						cell.setCellValue(getAllUttersFromIntentMap.get("utter").toString());
						cell = row.createCell(3);
						cell.setCellValue(getAllUttersFromIntentMap.get("utterCnt").toString());
						
						mergeFirstRow = mergeFirstRow + 1;
						mergeLastRow = mergeFirstRow - 1;
					}
				}
				
				rowNo = 1;
				
				for (int i = 0; i < getLinkCountList.size(); i++) {
					row = sheet3.createRow(rowNo++);
					cell = row.createCell(0);
					cell.setCellValue(getLinkCountList.get(i).get("href").toString());
					cell = row.createCell(1);
					cell.setCellValue(getLinkCountList.get(i).get("linkCnt").toString());
				}
				
				

				response.setContentType("ms-vnd/excel");
				response.setHeader("Content-Disposition", "attachment;filename=redtie_statistics.xlsx");
				
				workbook.write(response.getOutputStream());
				workbook.close();
				response.getOutputStream().flush();
				response.getOutputStream().close();
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
						} catch (Exception ignore) {
						}
					}
				}

			}
		}
	/***
	 *  Voice Statistics CampaignList
	 *  음성봇 통합 통계 캠페인 리스트
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getVoiceStatCampaignList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String,Object> getVoiceStatCampaignList(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
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
			// 권한 셋팅
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
		cmOpInfoVO.setCampaignNm(map.get("campaignNm").toString());
		List<Map<String,Object>> voiceStatCampaignList = campaignService.getVoiceStatCampaignList(cmOpInfoVO);

		Map<String, Object> voiceCampaignMap = new HashMap<>();

		voiceCampaignMap.put("data", voiceStatCampaignList);

		return voiceCampaignMap;
	}

	/***
	 *  Voice Statistics Main Contents
	 *  음성봇 통합 통계 메인 통계화면
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getVoiceBotInfo", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String,Object> getVoiceBotInfo(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		Map<String,Object> getVoiceBotInfoMap = new HashMap<>();
		//검색된 캠페인 이름
		String getCampaignNm = statisticsService.getCampaignNm(map.get("campaignId").toString());
		//검색된 캠페인에 연결된 현재 음성봇 수
		int getVoicebotCount = statisticsService.getVoicebotCount(map.get("campaignId").toString());

		Map<String, Object> sendDialResult = statisticsService.getVoiceSendStats(map);
		List<Map> sendResultList = new ArrayList<>();
		Map<String, Object> sendResult = new HashMap<>();

		List sendSuccList = new ArrayList();
		sendSuccList.add(sendDialResult.get("sendSuccessCount").toString());
		List sendFailList = new ArrayList();
		sendFailList.add(sendDialResult.get("sendFailCount").toString());

		sendResult.put("label", "발송 성공");
		sendResult.put("data", sendSuccList);
		sendResultList.add(sendResult);
		sendResult = new HashMap<>();
		sendResult.put("label", "발송 실패");
		sendResult.put("data", sendFailList);
		sendResultList.add(sendResult);

		//검색된 캠페인의 통화 결과
		List<Map> dialResultList = new ArrayList<>();
		Map<String, Object> dialResult = new HashMap<>();

		List dialSuccList = new ArrayList();
		dialSuccList.add(sendDialResult.get("dialSuccessCount").toString());
		List dialFailList = new ArrayList();
		dialFailList.add(sendDialResult.get("dialFailCount").toString());

		dialResult.put("label", "통화 성공");
		dialResult.put("data",dialSuccList);
		dialResultList.add(dialResult);
		dialResult = new HashMap<>();
		dialResult.put("label", "통화 실패");
		dialResult.put("data",dialFailList);
		dialResultList.add(dialResult);

		//검색된 캠페인의 캠페인 결과
		Map<String, Object> campaignResult = statisticsService.getCampaignResultCount(map);
		List<Map> campaignResultList = new ArrayList<>();
		Map<String, Object> campaignResultMap = new HashMap<>();

		List campSuccList = new ArrayList();
		campSuccList.add(campaignResult.get("campaignSuccessCount").toString());
		List campFailList = new ArrayList();
		campFailList.add(campaignResult.get("campaignFailCount").toString());

		campaignResultMap.put("label", "캠페인 성공");
		campaignResultMap.put("data", campSuccList);
		campaignResultList.add(campaignResultMap);
		campaignResultMap = new HashMap<>();
		campaignResultMap.put("label", "캠페인 실패");
		campaignResultMap.put("data", campFailList);
		campaignResultList.add(campaignResultMap);
		//검색된 캠페인의 음성봇 정보 (통화시간 관련)
		Map<String, Object> voiceBotInfo = statisticsService.getVoiceCallTimeInfo(map);

		//검색된 캠페인의 메인 컨텐츠 데이터
		getVoiceBotInfoMap.put("title", getCampaignNm);
		getVoiceBotInfoMap.put("voiceBotCount", getVoicebotCount);
		getVoiceBotInfoMap.put("voiceBotInfo", voiceBotInfo);
		getVoiceBotInfoMap.put("sendCount", sendDialResult.get("sendCount"));
		getVoiceBotInfoMap.put("sendSuccessCount", sendDialResult.get("sendSuccessCount"));
		getVoiceBotInfoMap.put("dialTargetCount", campaignResult.get("dialTargetCount"));
		getVoiceBotInfoMap.put("sendResult", sendResultList);
		getVoiceBotInfoMap.put("dialResult", dialResultList);
		getVoiceBotInfoMap.put("campaignResult", campaignResultList);


		return getVoiceBotInfoMap;
	}
	/***
	 *  Voice Statistics sendResultInfoChart
	 *  음성봇 발송결과 현황 차트
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getSendResultInfoChart", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String,Object> getSendResultInfoChart(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		map = statisticsService.getDateTypeAndHourMap(map);

		List<Map<String, Object>> sendResultInfoList = statisticsService.getSendResultInfoChart(map);

		List dateList = new ArrayList();
		List sendSuccessList = new ArrayList();
		List sendFailList = new ArrayList();
		List<Map<String, Object>> datasetsListMap = new ArrayList<>();

		if(sendResultInfoList != null){
			for (int i = 0; i < sendResultInfoList.size(); i++){
				dateList.add(sendResultInfoList.get(i).get("label").toString());
				sendSuccessList.add(sendResultInfoList.get(i).get("sendSuccessCount").toString());
				sendFailList.add(sendResultInfoList.get(i).get("sendFailCount").toString());
			}
		}

		Map<String, Object> sendSuccessMap = new HashMap<>();
		sendSuccessMap.put("label","발송 성공");
		sendSuccessMap.put("data", sendSuccessList);
		sendSuccessMap.put("backgroundColor", "#4FBFFF");
		sendSuccessMap.put("borderWidth", "3");
		sendSuccessMap.put("borderColor", "#4FBFFF");
		Map<String, Object> sendFailMap = new HashMap<>();
		sendFailMap.put("label","발송 실패");
		sendFailMap.put("data", sendFailList);
		sendFailMap.put("backgroundColor", "#FFC000");
		sendFailMap.put("borderWidth", "3");
		sendFailMap.put("borderColor", "#FFC000");

		datasetsListMap.add(sendSuccessMap);
		datasetsListMap.add(sendFailMap);

		//발송결과 현항 Map
		Map<String, Object> sendResultInfoMap = new HashMap<>();
		sendResultInfoMap.put("labels",dateList);
		sendResultInfoMap.put("datasets",datasetsListMap);
		return sendResultInfoMap;
	}

	/***
	 *  Voice Statistics dialResultInfoChart
	 *  음성봇 통화결과 현황 차트
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getDialResultInfoChart", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String,Object> getDialResultInfoChart(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		map = statisticsService.getDateTypeAndHourMap(map);

		List<Map<String, Object>> dialResultInfoList = statisticsService.getDialResultInfoChart(map);

		List dateList = new ArrayList();
		List dialSuccessList = new ArrayList();
		List dialFailList = new ArrayList();
		List dialSuccessPercentList = new ArrayList();
		List<Map<String, Object>> datasetsListMap = new ArrayList<>();

		if(dialResultInfoList != null){
			for (int i = 0; i < dialResultInfoList.size(); i++) {
				dateList.add(dialResultInfoList.get(i).get("label").toString());
				dialSuccessList.add(dialResultInfoList.get(i).get("dialSuccessCount").toString());
				dialFailList.add(dialResultInfoList.get(i).get("dialFailCount").toString());
				dialSuccessPercentList.add(dialResultInfoList.get(i).get("percent").toString());
			}
		}

		Map<String, Object> dialSuccessMap = new HashMap<>();
		dialSuccessMap.put("label","통화 성공");
		dialSuccessMap.put("data", dialSuccessList);
		dialSuccessMap.put("backgroundColor", "#4FBFFF");
		dialSuccessMap.put("borderWidth", "3");
		dialSuccessMap.put("borderColor", "#4FBFFF");
		Map<String, Object> dialFailMap = new HashMap<>();
		dialFailMap.put("label","통화 실패");
		dialFailMap.put("data", dialFailList);
		dialFailMap.put("backgroundColor", "#8497B0");
		dialFailMap.put("borderWidth", "3");
		dialFailMap.put("borderColor", "#8497B0");
		Map<String, Object> dialSuccessPercentMap = new HashMap<>();
		dialSuccessPercentMap.put("label","통화 성공률");
		dialSuccessPercentMap.put("data", dialSuccessPercentList);
		dialSuccessPercentMap.put("backgroundColor", "#FF0000");

		datasetsListMap.add(dialSuccessMap);
		datasetsListMap.add(dialFailMap);
		datasetsListMap.add(dialSuccessPercentMap);

		//발송결과 현항 Map
		Map<String, Object> sendResultInfoMap = new HashMap<>();
		sendResultInfoMap.put("labels",dateList);
		sendResultInfoMap.put("datasets",datasetsListMap);
		return sendResultInfoMap;
	}

	@RequestMapping(value = "/getCustomerAwayInfoPerTask", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String,Object> getCustomerAwayInfoPerTask(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		map = statisticsService.getDateTypeAndHourMap(map);

		List<Map<String,Object>> resultMapList = statisticsService.getCustomerAwayInfoPerTask(map);
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("data", resultMapList);

		return resultMap;
	}

	@RequestMapping(value = "/getCampaignResultInfoChart", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String,Object> getCampaignResultInfoChart(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		map = statisticsService.getDateTypeAndHourMap(map);
		List<Map<String,Object>> resultMapList = statisticsService.getCampaignResultInfoChart(map);
		Map<String,Object> resultMap = new HashMap<String,Object>();

		List<String> date = new ArrayList<>();

		List<String> campaignSuccess = new ArrayList<>();
		List<String> campaignFail = new ArrayList<>();
		List<String> successPer = new ArrayList<>();
		Map<String, Object> tmpMap = new HashMap<String,Object>();
		List<Map<String,Object>> tmpMapList = new ArrayList<>();

		for(int i = 0; resultMapList.size() > i; i++){
			date.add((String) resultMapList.get(i).get("label"));
			campaignSuccess.add(((BigDecimal)resultMapList.get(i).get("campaignSuccessCount")).toString());
			campaignFail.add(((BigDecimal)resultMapList.get(i).get("campaignFailCount")).toString());
			successPer.add(((BigDecimal)resultMapList.get(i).get("percent")).toString());
		}

		tmpMap.put("label","캠페인 성공");
		tmpMap.put("data", campaignSuccess);
		tmpMap.put("backgroundColor", "#4FBFFF");
		tmpMap.put("borderWidth", "3");
		tmpMap.put("borderColor", "#4FBFFF");
		tmpMapList.add(tmpMap);
		tmpMap = new HashMap<>();

		tmpMap.put("label","캠페인 실패");
		tmpMap.put("data", campaignFail);
		tmpMap.put("backgroundColor", "#9BBB59");
		tmpMap.put("borderWidth", "3");
		tmpMap.put("borderColor", "#9BBB59");
		tmpMapList.add(tmpMap);
		tmpMap = new HashMap<>();

		tmpMap.put("label","캠페인 성공률");
		tmpMap.put("data", successPer);
		tmpMap.put("backgroundColor", "#FF0000");
		tmpMapList.add(tmpMap);

		resultMap.put("labels",date);
		resultMap.put("datasets",tmpMapList);

		return resultMap;

	}

	@RequestMapping(value = "/getSendResultInfoDetailChart", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String,Object> getSendResultInfoDetailChart(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		map = statisticsService.getDateTypeAndHourMap(map);

		List<Map<String,Object>> sendResultInfoDetailListMap = statisticsService.getSendResultInfoDetailChart(map);

		Map<String, Object> sendResultInfoDetailMap = new HashMap<>();

		// x축 라벨 관련 리스트
		List sendResultInfoDetailLabelList = new ArrayList();

		List<Map<String, Object>> sendResultInfoDetailDatasetsListMap = new ArrayList<>();
		Map<String, Object> sendSuccessResultInfoMap = new HashMap<>();
		List sendSuccessResultInfoList = new ArrayList();

		Map<String, Object> sendFailResultInfoMap = new HashMap<>();
		List sendFailResultInfoList = new ArrayList();

		for(int i = 0; sendResultInfoDetailListMap.size() > i; i++){
			sendResultInfoDetailLabelList.add(sendResultInfoDetailListMap.get(i).get("label").toString());
			sendSuccessResultInfoList.add(sendResultInfoDetailListMap.get(i).get("sendSuccessCount").toString());
			sendFailResultInfoList.add(sendResultInfoDetailListMap.get(i).get("sendFailCount").toString());

		}

		sendSuccessResultInfoMap.put("label","발송 성공");
		sendSuccessResultInfoMap.put("data",sendSuccessResultInfoList);
		sendSuccessResultInfoMap.put("backgroundColor", "#4FBFFF");
		sendSuccessResultInfoMap.put("borderWidth", "3");
		sendSuccessResultInfoMap.put("borderColor", "#4FBFFF");

		sendFailResultInfoMap.put("label","발송 실패");
		sendFailResultInfoMap.put("data", sendFailResultInfoList);
		sendFailResultInfoMap.put("backgroundColor", "#FFC000");
		sendFailResultInfoMap.put("borderWidth", "3");
		sendFailResultInfoMap.put("borderColor", "#FFC000");

		sendResultInfoDetailDatasetsListMap.add(sendSuccessResultInfoMap);
		sendResultInfoDetailDatasetsListMap.add(sendFailResultInfoMap);

		sendResultInfoDetailMap.put("labels", sendResultInfoDetailLabelList);
		sendResultInfoDetailMap.put("datasets", sendResultInfoDetailDatasetsListMap);

		return sendResultInfoDetailMap;
	}

	@RequestMapping(value = "/getSendResultInfoDiff", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String,Object> getSendResultInfoDiff(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		map = statisticsService.getDateTypeAndHourMap(map);

		Map<String,Object> sendResultInfoDiffMap = statisticsService.getSendResultInfoDiff(map);

		return sendResultInfoDiffMap;
	}

	@RequestMapping(value = "/getCallResultInfoDetailChart", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String,Object> getCallResultInfoDetailChart(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		map = statisticsService.getDateTypeAndHourMap(map);

		List<Map<String,Object>> callResultInfoDetailChart = statisticsService.getCallResultInfoDetailChart(map);

		List callResultInfoDetailLabelList = new ArrayList();

		List<Map<String, Object>> callResultInfoDetailDatasetsListMap = new ArrayList<>();
		Map<String, Object> callSuccessCountMap = new HashMap<>();
		List callSuccessCountList = new ArrayList();

		Map<String, Object> callFailCountMap = new HashMap<>();
		List callFailCountList = new ArrayList();

		Map<String, Object> callSuccessPercentMap = new HashMap<>();
		List callSuccessPercentList = new ArrayList();

		for(int i = 0; callResultInfoDetailChart.size() > i; i++){
			callResultInfoDetailLabelList.add(callResultInfoDetailChart.get(i).get("label"));
			callSuccessCountList.add(callResultInfoDetailChart.get(i).get("callSuccessCount"));
			callFailCountList.add(callResultInfoDetailChart.get(i).get("callFailCount"));
			callSuccessPercentList.add(callResultInfoDetailChart.get(i).get("callSuccessPercent"));
		}


		callSuccessCountMap.put("label","통화 성공");
		callSuccessCountMap.put("data", callSuccessCountList);
		callSuccessCountMap.put("backgroundColor", "#4FBFFF");
		callSuccessCountMap.put("borderWidth", "3");
		callSuccessCountMap.put("borderColor", "#4FBFFF");
		callResultInfoDetailDatasetsListMap.add(callSuccessCountMap);

		callFailCountMap.put("label", "통화 실패");
		callFailCountMap.put("data", callFailCountList);
		callFailCountMap.put("backgroundColor", "#8497B0");
		callFailCountMap.put("borderWidth", "3");
		callFailCountMap.put("borderColor", "#8497B0");
		callResultInfoDetailDatasetsListMap.add(callFailCountMap);

		callSuccessPercentMap.put("label", "통화 성공률");
		callSuccessPercentMap.put("data", callSuccessPercentList);
		callSuccessPercentMap.put("backgroundColor", "#FF0000");
		callResultInfoDetailDatasetsListMap.add(callSuccessPercentMap);

		Map<String, Object> callResultInfoMap = new HashMap<>();

		callResultInfoMap.put("labels", callResultInfoDetailLabelList);
		callResultInfoMap.put("datasets", callResultInfoDetailDatasetsListMap);

		return callResultInfoMap;
	}

	@RequestMapping(value = "/getCallResultInfoDiff", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String,Object> getCallResultInfoDiff(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		map = statisticsService.getDateTypeAndHourMap(map);

		Map<String,Object> callResultInfoDiffMap = statisticsService.getCallResultInfoDiff(map);

		return callResultInfoDiffMap;
	}

	@RequestMapping(value = "/getCallFailInfoDetailChart", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String,Object> getCallFailInfoDetailChart(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		map = statisticsService.getDateTypeAndHourMap(map);

		List<Map<String,Object>> callFailInfoDetailChart = statisticsService.getCallFailInfoDetailChart(map);

		List callFailInfoDetailLabelList = new ArrayList();

		List<Map<String, Object>> callFailInfoDetailDatasetsListMap = new ArrayList<>();

		Map<String, Object> callAbsenceCountMap = new HashMap<>();
		List callAbsenceCountList = new ArrayList();

		Map<String, Object> callMissingCountMap = new HashMap<>();
		List callMissingCountList = new ArrayList();

		Map<String, Object> callRejectCountMap = new HashMap<>();
		List callRejectCountList = new ArrayList();

		Map<String, Object> callEtcCountMap = new HashMap<>();
		List callEtcCountList = new ArrayList();

		for(int i = 0; callFailInfoDetailChart.size() > i; i++){
			callFailInfoDetailLabelList.add(callFailInfoDetailChart.get(i).get("label"));
			callAbsenceCountList.add(callFailInfoDetailChart.get(i).get("callAbsenceCount"));
			callMissingCountList.add(callFailInfoDetailChart.get(i).get("callMissingCount"));
			callRejectCountList.add(callFailInfoDetailChart.get(i).get("callRejectCount"));
			callEtcCountList.add(callFailInfoDetailChart.get(i).get("callEtcCount"));
		}


		callAbsenceCountMap.put("label","부재");
		callAbsenceCountMap.put("data", callAbsenceCountList);
		callFailInfoDetailDatasetsListMap.add(callAbsenceCountMap);

		callMissingCountMap.put("label", "결번");
		callMissingCountMap.put("data", callMissingCountList);
		callFailInfoDetailDatasetsListMap.add(callMissingCountMap);

		callRejectCountMap.put("label", "수신거부");
		callRejectCountMap.put("data", callRejectCountList);
		callFailInfoDetailDatasetsListMap.add(callRejectCountMap);

		callEtcCountMap.put("label", "기타");
		callEtcCountMap.put("data", callEtcCountList);
		callFailInfoDetailDatasetsListMap.add(callEtcCountMap);

		Map<String, Object> callResultInfoMap = new HashMap<>();

		callResultInfoMap.put("labels", callFailInfoDetailLabelList);
		callResultInfoMap.put("datasets", callFailInfoDetailDatasetsListMap);

		return callResultInfoMap;
	}



	@RequestMapping(value = "/getCampaignResultDetailChart", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String,Object> getCampaignResultDetailChart(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		map = statisticsService.getDateTypeAndHourMap(map);

		List<Map<String,Object>> campaignResultLst = statisticsService.getCampaignResultDetailChart(map);
		Map<String, Object> campaignResultMap = new HashMap<>();

		List<String> labels = new ArrayList<>();
		List<String> campaignSuccess = new ArrayList<>();
		List<String> campaignFail = new ArrayList<>();
		List<String> successPer = new ArrayList<>();
		List<Map<String,Object>> tmpMapList = new ArrayList<>();

		for(Map<String, Object> tmpmap : campaignResultLst){
			labels.add((String)tmpmap.get("label"));
			campaignSuccess.add(((BigDecimal)tmpmap.get("campaignSuccessCount")).toString());
			campaignFail.add(((BigDecimal)tmpmap.get("campaignFailCount")).toString());
			successPer.add(tmpmap.get("percent").toString());
		}

		tmpMapList.add(new HashMap<String, Object>(){{
			put("label", "캠페인 성공");
			put("data", campaignSuccess);
			put("backgroundColor", "#9BBB59");
			put("borderWidth", "3");
			put("borderColor", "#9BBB59");
		}});
		tmpMapList.add(new HashMap<String, Object>(){{
			put("label", "캠페인 실패");
			put("data", campaignFail);
			put("backgroundColor", "#FFC000");
			put("borderWidth", "3");
			put("borderColor", "#FFC000");
		}});
		tmpMapList.add(new HashMap<String, Object>(){{
			put("label", "캠페인 성공률");
			put("data", successPer);
			put("backgroundColor", "#FF0000");
		}});

		campaignResultMap.put("labels", labels);
		campaignResultMap.put("datasets", tmpMapList);

		return campaignResultMap;
	}

	@RequestMapping(value = "/getCampaignResultDetailDiff", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<Map<String,Object>> getCampaignResultDetailDiff(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		List<String> campaignIdList = (List<String>)map.get("campaignIdList");
		List<Map<String, Object>> campaignList = statisticsService.detailPageCampaignInfoList(campaignIdList);
		List<Map<String, Object>> campaignResultList = new ArrayList<>();

		for(Map tmpMap : campaignList){
			tmpMap.put("isRunning", map.get("isRunning"));
			tmpMap.put("startDt", map.get("startDt"));
			tmpMap.put("endDt", map.get("endDt"));

			Map<String,Object> campaignResultMap = statisticsService.getCampaignResultDetailDiff(tmpMap);

			if(campaignResultMap.get("campaignId") == null || "".equals(campaignResultMap.get("campaignId"))){
				campaignResultMap.put("campaignId", tmpMap.get("campaignId"));
				campaignResultMap.put("campaignNm", tmpMap.get("campaignNm"));
				campaignResultMap.put("targetCount", campaignResultMap.get("targetCount"));
				campaignResultMap.put("dialSuccessCount", "0");
				campaignResultMap.put("dialTryCount", "0");
				campaignResultMap.put("callSuccessCount", "0");
				campaignResultMap.put("campaignSuccessCount", "0");
				campaignResultMap.put("targetPercent", "0.0%");
				campaignResultMap.put("dialPercent", "0.0%");
				campaignResultMap.put("callPercent", "0.0%");
			} else {
				Double targetCount = Double.parseDouble((String)campaignResultMap.get("targetCount"));
				Double dialSuccessCount = Double.parseDouble((String)campaignResultMap.get("dialSuccessCount"));
				Double callSuccessCount = Double.parseDouble((String)campaignResultMap.get("callSuccessCount"));
				Double campaignSuccessCount = Double.parseDouble((String)campaignResultMap.get("campaignSuccessCount"));

				campaignResultMap.put("campaignId", tmpMap.get("campaignId"));
				campaignResultMap.put("campaignNm", tmpMap.get("campaignNm"));
				campaignResultMap.put("targetCount", String.format("%.0f",targetCount));
				campaignResultMap.put("dialSuccessCount", String.format("%.0f",dialSuccessCount));
				campaignResultMap.put("callSuccessCount", String.format("%.0f",callSuccessCount));
				campaignResultMap.put("campaignSuccessCount", String.format("%.0f",campaignSuccessCount));
				campaignResultMap.put("dialTryCount", String.format("%.0f", targetCount));

				campaignResultMap.put("targetPercent", String.format("%.1f", (campaignSuccessCount/targetCount) * 100)+"%");
				campaignResultMap.put("dialPercent", String.format("%.1f", (campaignSuccessCount/dialSuccessCount) * 100)+"%");
				campaignResultMap.put("callPercent", String.format("%.1f", (campaignSuccessCount/callSuccessCount) * 100)+"%");
			}

			campaignResultList.add(campaignResultMap);
		}

		return campaignResultList;
	}

	@RequestMapping(value = "/getLeavePerTaskDetailDiff", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String,Object> getLeavePerTaskDetailDiff(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

		// json -> map
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		List<Map<String, Object>> compareDateList = (List<Map<String, Object>>)map.get("diffDtList");
		List<Object> compareTempList = new ArrayList<>();
		Map<String, Object> compareResultMap = new HashMap<>();

		for(Map tmpMap : compareDateList){
			Map<String, Object> compareTempMap = new HashMap<>();

			map.remove("startDt");
			map.remove("enddt");

			map.put("startDt", tmpMap.get("startDt"));
			map.put("endDt", tmpMap.get("endDt"));

			compareTempMap.put("diffStartDt", map.get("startDt"));
			compareTempMap.put("diffEndDt", map.get("endDt"));

			compareTempMap.put("taskList",statisticsService.getCustomerAwayInfoPerTask(map));
			compareTempList.add(compareTempMap);
		}
		compareResultMap.put("diffList", compareTempList);

		return compareResultMap;
	}
}
