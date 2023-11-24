package ai.maum.biz.fastaicc.main.external.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.main.user.domain.AuthenticaionVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.CampaignService;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.statistic.service.StatisticsService;
import ai.maum.biz.fastaicc.main.user.service.AuthService;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value = "/bot")
public class SimpleBotController {
	/* 공통서비스 */
	@Autowired
	CommonService commonService;

	/*통계서비스     */
    @Autowired
    StatisticsService statisticsService;

    /* 설정값 */
	@Inject
	VariablesMng variablesMng;

	/* 권한 서비스 */
	@Autowired
	AuthService authService;

	@Autowired
    CampaignService campaignService;

	@Autowired
	CustomProperties customProperties;

    /*  인바운드 모니터링 */
	@RequestMapping(value="/simpleBot",  method = { RequestMethod.GET, RequestMethod.POST })
    public String simpleBot(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		req.setAttribute("titleCode","A0407");
		req.setAttribute("titleTxt","챗봇관리");
		req.setAttribute("url", customProperties.getSimplebotUrl());
		return "iframe/content";
    }

	/*  음성봇 빌더 */
	@RequestMapping(value="/voicebotBuilder",  method = { RequestMethod.GET, RequestMethod.POST })
	public String voiceBotBuilder(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		Map map = new HashMap();
		model.addAttribute("userName", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();

		map.put("sessId", userId);
		String companyId = statisticsService.getBoardCompanyId(map); //로그인한 사용자의 회사 ID
		req.setAttribute("companyId", companyId);

		req.setAttribute("titleCode","A0407");
		req.setAttribute("titleTxt","음성봇빌더");
		req.setAttribute("url", customProperties.getSimplebotUrl());
		return "iframe/content";
    }

	/*  음성봇 빌더 */
	@RequestMapping(value="/voicebotBuilderV2",  method = { RequestMethod.GET, RequestMethod.POST })
	public String voicebotBuilderV2(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		Map map = new HashMap();
		model.addAttribute("userName", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		AuthenticaionVO userDto=(AuthenticaionVO)auth;
		UserVO userVo = userDto.getUser();
		String userId = auth.getName();

		map.put("sessId", userId);
		String companyId = statisticsService.getBoardCompanyId(map); //로그인한 사용자의 회사 ID
		req.setAttribute("companyId", companyId);
		req.setAttribute("userAuthTy", userVo.getUserAuthTy());;

		req.setAttribute("titleCode","A0407");
		req.setAttribute("titleTxt","음성봇빌더");
		req.setAttribute("url", customProperties.getVoicebotBuilderUrl());
		return "iframe/content";
	}
}
