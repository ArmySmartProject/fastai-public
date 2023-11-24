package ai.maum.biz.fastaicc.main.cousult.ailvr.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.common.domain.PagingVO;
import ai.maum.biz.fastaicc.main.cousult.ailvr.domain.AiIVRVO;
import ai.maum.biz.fastaicc.main.cousult.ailvr.service.AiIVRService;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.statistic.service.StatisticsService;
import ai.maum.biz.fastaicc.main.user.domain.AuthenticaionVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import lombok.extern.java.Log;

@Log
@Controller
public class AiIVRController {


    @Autowired
    AiIVRService aiIVRService;
    
    @Autowired
	CustomProperties customProperties;
    
    /*통계서비스     */
    @Autowired
    StatisticsService statisticsService;

    @Value("${solr.url}")
    String solrUrl;

    @Value("${audio.ip}")
    String audioIp;

    @Value("${audio.port}")
    String aurioPort;

    @Inject
    VariablesMng variablesMng;

    @RequestMapping(value = "/aiIVRMonitoring", method = {RequestMethod.GET, RequestMethod.POST})
    public String aiIVRMonitoringMain(HttpServletRequest req, Model model) {
		return "ivr/aiIVRMonitoring";
	}
	
	@RequestMapping(value = "/aiIVRDashboard", method = {RequestMethod.GET, RequestMethod.POST})
	public String aiIVRDashboardMain(HttpServletRequest req, Model model) {
		model.addAttribute("websocketUrl", customProperties.getWebsocketProtocol() + "://"
				+ customProperties.getWebsocketIp() + customProperties.getWebsocketPort()); // 웹소켓URL
		return "ivr/aiIVRDashboard";
	}
	
	@RequestMapping(value = "/aiIVRStatistics", method = {RequestMethod.GET, RequestMethod.POST})
	public String aiIVRStatisticsMain(HttpServletRequest req, Model model) {
		return "ivr/aiIVRStatistics";
	}
	
	/***
	 * companyId list 조회
	 * 
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getCompanyIdList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<AiIVRVO> getCompanyIdList(HttpServletRequest request,
			HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		List<AiIVRVO> companyIdList = new ArrayList<AiIVRVO>();
		
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=(AuthenticaionVO)auth;
			UserVO userVo = userDto.getUser();
			
			if(userVo!=null) {
				String companyId = "";
				if(!userVo.getUserAuthTy().equals("S")) {
					companyId = userVo.getCompanyId().toString();
				}
				companyIdList = aiIVRService.getCompanyIdList(companyId);
			}
		}
		
		return companyIdList;
	}
	
	/***
	 * sip account list 조회
	 * 
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getSipAccountList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<Map> getSipAccountList(@RequestBody String jsonStr, HttpServletRequest request,
			HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
		List<Map> sipAccountList = null;

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=(AuthenticaionVO)auth;
			UserVO userVo = userDto.getUser();
			if(userVo != null) {
				if(jsonStr != null && jsonStr.length() > 0) {
					Map<String, Object> map = null;
					// json파서
					JsonParser jp = new JsonParser();
					JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
					JsonArray jArray = new JsonArray();
					// json -> map
					map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
					
					if(userVo.getUserAuthTy().equals("S") || userVo.getUserAuthTy().equals("A")) { // 슈퍼어드민
						map.put("userAuthTy", "S");
						sipAccountList = aiIVRService.getSipAccount(map);
					} else {
						map.put("userAuthTy", "O");
						map.put("userId", userVo.getUserId());
						sipAccountList = aiIVRService.getSipAccount(map);
					}
				}
			}
		}

		return sipAccountList;
	}
	
	/***
	 * IVR Monitoring List 조회
	 * 
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getAiIVRMonitoringList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String getAiIVRMonitoringList(@RequestBody String jsonStr, HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
		if(jsonStr != null && jsonStr.length() > 0) {
			Map<String, Object> map = null;
			// json파서
			JsonParser jp = new JsonParser();
			JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
			JsonArray jArray = new JsonArray();
			// json -> map
			map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			
			String sipUser = map.get("sipUser").toString();
			List<String> sipAccountList = new ArrayList<String>();
			if(sipUser.equals("")) {
				Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
					AuthenticaionVO userDto=(AuthenticaionVO)auth;
					UserVO userVo = userDto.getUser();
					if(userVo != null) {
						if(userVo.getUserAuthTy().equals("S") || userVo.getUserAuthTy().equals("A")) { // 슈퍼어드민
							map.put("userAuthTy", "S");
							sipAccountList = aiIVRService.getSipAccountList(map);
						} else {
							map.put("userAuthTy", "O");
							map.put("userId", userVo.getUserId());
							sipAccountList = aiIVRService.getSipAccountList(map);
						}
					}
				}
				map.put("sipList", sipAccountList);
			}
			List<Map> aiIVRMonitoringList = aiIVRService.getAiIVRMonitoringList(map);
			
			// 한페이지에 보여줄 row
			FrontMntVO frontMntVO = new FrontMntVO();
			frontMntVO.setPageInitPerPage(map.get("rowNum").toString());
			frontMntVO.setCurrentPage(map.get("page").toString());
			
			// 페이징을 위해서 쿼리 포함 전체 카운팅
			PagingVO pagingVO = new PagingVO();
			pagingVO.setCOUNT_PER_PAGE(frontMntVO.getPageInitPerPage());
			pagingVO.setTotalCount(aiIVRService.getAiIVRMonitoringCount(map));
			pagingVO.setCurrentPage(frontMntVO.getCurrentPage());
			frontMntVO.setStartRow(pagingVO.getStartRow());
			frontMntVO.setLastRow(pagingVO.getLastRow());
			
			JsonObject jsonReTurnObj = new JsonObject();
			jsonReTurnObj.add("paging", new Gson().toJsonTree(pagingVO));
			jsonReTurnObj.add("aiIVRMonitoringList", new Gson().toJsonTree(aiIVRMonitoringList));
			jsonReTurnObj.add("frontMnt", new Gson().toJsonTree(frontMntVO));
			jqGirdWriter(response, jsonReTurnObj);
		}
		return null;
	}
	
	/***
	 * IVR Monitoring Detail 조회
	 * 
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getIVRMonitoringDetail", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String getIVRMonitoringDetail(@RequestBody String jsonStr, HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
		if(jsonStr != null && jsonStr.length() > 0) {
			Map<String, Object> map = null;
			// json파서
			JsonParser jp = new JsonParser();
			JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
			// json -> map
			map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			List<Map> aiIVRIntentList = null;
			if(map.get("callTypeCode").equals("CT0001")) {
				aiIVRIntentList = aiIVRService.getIbIntentList(map);
			} else {
				aiIVRIntentList = aiIVRService.getObIntentList(map);
			}
			List<Map> aiIVRBotContentsList = aiIVRService.getIVRBotContentsList(map);
			Map<String, Object> custInfoForIVR = aiIVRService.getCustInfoForIVR(map);
			
			JsonObject jsonReTurnObj = new JsonObject();
			jsonReTurnObj.add("aiIVRIntentList", new Gson().toJsonTree(aiIVRIntentList));
			jsonReTurnObj.add("aiIVRBotContentsList", new Gson().toJsonTree(aiIVRBotContentsList));
			jsonReTurnObj.add("custInfoForIVR", new Gson().toJsonTree(custInfoForIVR));
			jqGirdWriter(response, jsonReTurnObj);
		}
		return null;
	}
	
	/***
	 * IVR Dashboard bot 상태 조회
	 * 
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getBotStatusList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<Map> getBotStatusList(@RequestBody String jsonStr, HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
		List<Map> boardBotCondition = null;
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
   		String userId = auth.getName();
   		
		if(jsonStr != null && jsonStr.length() > 0) {
			Map<String, Object> map = null;
			// json파서
			JsonParser jp = new JsonParser();
			JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
			// json -> map
			map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			
			map.put("sessId", userId);
			if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
				AuthenticaionVO userDto=(AuthenticaionVO)auth;
				UserVO userVo = userDto.getUser();
				if(userVo.getUserAuthTy().equals("N") || userVo.getUserAuthTy().equals("G")) {
					map.put("userAuthTy", userVo.getUserAuthTy());
				}
			}
			boardBotCondition = statisticsService.getBoardBotCondition(map);
		}
		
		
		return boardBotCondition;
	}
	
	/***
	 * IVR 시간별 통계 조회
	 * 
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getIVRHourStatistics", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<Map> getIVRHourStatistics(@RequestBody String jsonStr, HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
		List<Map> hourStatistics = null;
		List<Map> allHourStatistics = null;
		if(jsonStr != null && jsonStr.length() > 0) {
			Map<String, Object> map = null;
			// json파서
			JsonParser jp = new JsonParser();
			JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
			// json -> map
			map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
			
			String sipUser = map.get("sipUser").toString();
			List<String> sipAccountList = new ArrayList<String>();
			if(sipUser.equals("")) {
				Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
					AuthenticaionVO userDto=(AuthenticaionVO)auth;
					UserVO userVo = userDto.getUser();
					if(userVo != null) {
						if(userVo.getUserAuthTy().equals("S") || userVo.getUserAuthTy().equals("A")) { // 슈퍼어드민
							map.put("userAuthTy", "S");
							sipAccountList = aiIVRService.getSipAccountList(map);
						} else {
							map.put("userAuthTy", "O");
							map.put("userId", userVo.getUserId());
							sipAccountList = aiIVRService.getSipAccountList(map);
						}
					}
				}
				map.put("sipList", sipAccountList);
			}
			allHourStatistics = aiIVRService.getIVRHourStatistics(map);
			
			map.put("getType", "search");
			hourStatistics = aiIVRService.getIVRHourStatistics(map);
			
			JsonObject jsonReTurnObj = new JsonObject();
			jsonReTurnObj.add("allHourStatistics", new Gson().toJsonTree(allHourStatistics));
			jsonReTurnObj.add("hourStatistics", new Gson().toJsonTree(hourStatistics));
			jqGirdWriter(response, jsonReTurnObj);
		}
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
