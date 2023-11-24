package ai.maum.biz.fastaicc.main.cousult.inbound.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.cousult.inbound.domain.ChartVO;
import ai.maum.biz.fastaicc.main.cousult.inbound.service.InboundMonitoringService;
import ai.maum.biz.fastaicc.main.user.service.AuthService;

@Controller
public class InboundMonitoringDashboardController {
	/* 공통서비스 */
	@Autowired
	CommonService commonService;

    @Autowired
    AuthService authService;
    
    @Autowired
    InboundMonitoringService inboundMonitoringService;

	/*설정값 */
	@Inject
	VariablesMng variablesMng;

	/* 인바운드 모니터링 main화면 */
	@RequestMapping(value = "/ibMntDb", method = { RequestMethod.GET, RequestMethod.POST })
	public String callStatus(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		Map map = new HashMap();
	
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		map.put("FIRST_CD", "02");
		//List<CmCommonCdDTO> schCodeDto = commonService.getCodeNm(map);
		//model.addAttribute("chart4Label", schCodeDto); // 공통코드명

		return "/monitoring/inboundMonitoringDashboard";
	}

	
	//차트 4번째 ajax
    @RequestMapping(value = "/chart4Info", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String chart4Info(@RequestBody List<String> arr) {
    	Map inputMap = new HashMap();
    	inputMap.put("arr", arr);
    	
    	List<ChartVO> ChartDTO = inboundMonitoringService.getChart4InfoList(inputMap);
    	String retListJson = new Gson().toJson(ChartDTO);
        return retListJson;
    }
}

    
 
