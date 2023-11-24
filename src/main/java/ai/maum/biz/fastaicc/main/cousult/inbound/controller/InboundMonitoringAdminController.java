package ai.maum.biz.fastaicc.main.cousult.inbound.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
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

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.cousult.common.service.ConsultingService;
import ai.maum.biz.fastaicc.main.cousult.inbound.service.InboundMonitoringAdminService;
import ai.maum.biz.fastaicc.main.cousult.inbound.service.InboundMonitoringService;
import ai.maum.biz.fastaicc.main.statistic.service.StatisticsService;
import ai.maum.biz.fastaicc.main.user.domain.AuthenticaionVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import ai.maum.biz.fastaicc.main.user.service.AuthService;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class InboundMonitoringAdminController {
	/* 공통서비스 */
	@Autowired
	CommonService commonService;

    @Autowired
    AuthService authService;
    
    /* 상담서비스 */
	@Autowired
	ConsultingService consultingService;
	
	/* 인바운드 모니터 서비스 */
	@Autowired
	InboundMonitoringService inboundMonitoringService;
    
    @Autowired
    InboundMonitoringAdminService inboundmonitoringAdminService;
    
    @Autowired
	CustomProperties customProperties;
    
    /*통계서비스     */
    @Autowired
    StatisticsService statisticsService;

	/*설정값 */
	@Inject
	VariablesMng variablesMng;
	
	/***
	 *    모니터링 어드민 메인 화면
	 * @param frontMntVO
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/mntAdminMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String callStatus(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		
		//frontMntVO.setCall_type_code("Y");//콜타입 (IB & OB), 봇 전체조회
		// 음성 봇 리스트 조회
		//List<SipAccountDTO> phoneListResult = inboundMonitoringService.getPhoneList(frontMntVO);
		
		Map map = new HashMap();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=(AuthenticaionVO)auth;
			UserVO userVo = userDto.getUser();
			map.put("userAuthTy", userVo.getUserAuthTy());
		}
		
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");//오늘 ~ 오늘
		//SimpleDateFormat format2 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
		
		Calendar c1 = new GregorianCalendar();

		c1.add(Calendar.DATE, 0); // 오늘

		//SimpleDateFormat format1 = new SimpleDateFormat ("2020-02-01 00:00:00");
		//SimpleDateFormat format2 = new SimpleDateFormat ("2020-02-15 HH:mm:ss");
		
		//초기 검색일 오늘~오늘
		String startDt = format1.format(c1.getTime());
		String endDt = format1.format(c1.getTime());
		//String endDt = format2.format(c1.getTime());
		
		map.put("sessId", userId);
		String companyId = statisticsService.getBoardCompanyId(map);
		map.put("companyId", companyId);
		
		List<Map> boardResCondition = statisticsService.getBoardResCondition(map);
		List<Map> boardCsCondition = statisticsService.getBoardCsCondition(map);
		
		List<Map> boardBotCondition = statisticsService.getBoardBotCondition(map);//toDate 데이터
		
		map.put("startDt", startDt);
		map.put("endDt", endDt);
		//List<Map> boardCsTypeCondition = statisticsService.getBoardCsTypeCondition(map);//기준
		map.put("searchType", "day");
		//List<Map> boardCsTypeCondition2 = statisticsService.getBoardCsTypeCondition(map);//비교(default > 전일)
		
		model.addAttribute("boardResCondition", boardResCondition); // 대시보드 전체현황
		model.addAttribute("boardCsCondition", boardCsCondition); // 대쉬보드 상담현황
		//model.addAttribute("boardCsTypeCondition", new Gson().toJson(boardCsTypeCondition)); // 대쉬보드 문의유형
		//model.addAttribute("boardCsTypeCondition2", new Gson().toJson(boardCsTypeCondition2)); // 대쉬보드 문의유형
		model.addAttribute("boardBotCondition", boardBotCondition); // 대쉬보드 봇현황
		model.addAttribute("companyId", companyId); // companyId
		
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		//model.addAttribute("phoneListResult", phoneListResult); // 로그인한 사용자 이름
		model.addAttribute("websocketUrl", customProperties.getWebsocketProtocol() + "://"
				+ customProperties.getWebsocketIp() + customProperties.getWebsocketPort()); // 웹소켓URL
		model.addAttribute("proxyUrl", customProperties.getProxyProtocol() + "://"
				+ customProperties.getProxyIp() + customProperties.getProxyPort()); // 웹소켓 proxy URL
		//map.put("FIRST_CD", "02");
		//List<CmCommonCdDTO> schCodeDto = commonService.getCodeNm(map);
		//model.addAttribute("chart4Label", schCodeDto); // 공통코드명
		
		List<Map> ibDashBoardCallTotalList = statisticsService.getIbDashBoardCallTotalList(map);
		map.put("dashBoardCallTotalList", ibDashBoardCallTotalList);
		
		return "/monitoring/monitoring_admin";
	}
	/***
	 *  모니터링 하단 콜현황
	 * @param arr
	 * @return
	 */
    @RequestMapping(value = "/getCallStateList", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String getCallStateList(@RequestBody List<String> arr) {
    	Map inputMap = new HashMap();
    	inputMap.put("arr", arr);
 
    	List<Map> CallStateList = inboundmonitoringAdminService.getCallStateList(inputMap);
    	String retListJson = new Gson().toJson(CallStateList);
        return retListJson;
    }
    
    /***
	 * ib 대쉬보드 > 문의유형 현황 조회
	 * @param arr
	 * @return
     * @throws IOException 
     * @throws JsonMappingException 
     * @throws JsonParseException 
	 */
//    @RequestMapping(value = "/getBoardCsTypeCondition", method = {RequestMethod.GET, RequestMethod.POST})
//    @ResponseBody
//    public Map<String, Object> getBoardCsTypeCondition(@RequestBody String jsonStr) throws JsonParseException, JsonMappingException, IOException {
//    	
//    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//		String userId = auth.getName();
//    	
//    	Map map = new HashMap();
//    	// json파서
//		JsonParser jp = new JsonParser();
//		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
//		// json -> map
//		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
//		
//		map.put("sessId", userId);
//		String companyId = statisticsService.getBoardCompanyId(map);
//		map.put("companyId", companyId);
//		    	
//		List<Map> boardCsTypeCondition2 = statisticsService.getBoardCsTypeCondition(map);//비교(searchType 있는상태)
//		map.put("searchType", "");
//		List<Map> boardCsTypeCondition = statisticsService.getBoardCsTypeCondition(map);//기준(searchType 지움) > fdt ~ tdt 조회
//		
//		map.put("boardCsTypeCondition", boardCsTypeCondition);
//		map.put("boardCsTypeCondition2", boardCsTypeCondition2);
//    	
//        return map;
//    }
    
    @RequestMapping(value = "/getBoardCsTypeCondition", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> getBoardCsTypeCondition(@RequestBody String jsonStr) throws JsonParseException, JsonMappingException, IOException {
    	
    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
    	
    	Map map = new HashMap();
    	// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		
		map.put("sessId", userId);
//		String companyId = statisticsService.getBoardCompanyId(map);
//		map.put("companyId", companyId);
		
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=(AuthenticaionVO)auth;
			UserVO userVo = userDto.getUser();
			if(userVo.getUserAuthTy().equals("N") || userVo.getUserAuthTy().equals("G")) {
				map.put("userAuthTy", userVo.getUserAuthTy());
			}
		}
		//인바운드 대시보드 콜 통계
		List<Map> ibDashBoardCallTotalList = statisticsService.getIbDashBoardCallTotalList(map);
		    	
		map.put("dashBoardCallTotalList", ibDashBoardCallTotalList);

		return map;
    }
    
    /***
   	 * ib 대쉬보드 > 응대 현황 조회
   	 * @param arr
   	 * @return
        * @throws IOException 
        * @throws JsonMappingException 
        * @throws JsonParseException 
   	 */
       @RequestMapping(value = "/boardResAndCsCondition", method = {RequestMethod.GET, RequestMethod.POST})
       @ResponseBody
       public Map<String, Object> boardResAndCsCondition(@RequestBody String jsonStr) throws JsonParseException, JsonMappingException, IOException {
       	
       	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
   		String userId = auth.getName();
       	
       	Map map = new HashMap();
       	// json파서
   		JsonParser jp = new JsonParser();
   		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
   		// json -> map
   		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
   		
   		map.put("sessId", userId);
//   		String companyId = statisticsService.getBoardCompanyId(map);
//   		map.put("companyId", companyId);
   		
   		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=(AuthenticaionVO)auth;
			UserVO userVo = userDto.getUser();
			if(userVo.getUserAuthTy().equals("N") || userVo.getUserAuthTy().equals("G")) {
				map.put("userAuthTy", userVo.getUserAuthTy());
			}
		}
   		
   		    	
   		List<Map> boardResCondition = statisticsService.getBoardResCondition(map);
		List<Map> boardCsCondition = statisticsService.getBoardCsCondition(map);
   		
   		map.put("boardResCondition", boardResCondition);
   		map.put("boardCsCondition", boardCsCondition);
       	
       return map;
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

    
 
