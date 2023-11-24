package ai.maum.biz.fastaicc.main.cousult.inbound.controller;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCampaignInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCommonCdVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmSttResultDetailVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonMonitoringService;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.cousult.inbound.domain.SipAccountVO;
import ai.maum.biz.fastaicc.main.cousult.inbound.service.InboundMonitoringService;
import ai.maum.biz.fastaicc.main.user.service.AuthService;

@Controller
public class InboundMonitoringController {

	@Autowired
	CommonService commonService;

	@Autowired
	CommonMonitoringService commonMonitoringService;

	@Autowired
	InboundMonitoringService inboundMonitoringService;

	@Autowired
	AuthService authService;

	@Autowired
	CustomProperties customProperties;

	@Inject
	VariablesMng variablesMng;

	/* 인바운드 모니터링 */
	@RequestMapping(value = "/callStatus", method = { RequestMethod.GET, RequestMethod.POST })
	public String callStatus(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		// 권한 확인
		boolean isHH = req.isUserInRole("ROLE_HH");
		if (isHH) {
			frontMntVO.setCampaignId("6");
		}

		List<SipAccountVO> phoneListResult = inboundMonitoringService.getPhoneList(frontMntVO);
		model.addAttribute("phoneListResult", phoneListResult);
		model.addAttribute("websocketUrl", customProperties.getWebsocketProtocol() + "://"
				+ customProperties.getWebsocketIp() + customProperties.getWebsocketPort());

		// DB에서 전체 리스트 SELECT.
		List<CmContractVO> latestCallList = inboundMonitoringService.getLatestCallList();
		model.addAttribute("latestCallList", latestCallList);
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름

		return "/monitoring/inboundMonitoring";
	}

	@RequestMapping(value = "/inboundPop", method = { RequestMethod.GET, RequestMethod.POST })
	public String doInboundPop(FrontMntVO frontMntVO, Model model) {
		// 검색 파트 코드값 세팅
		List<CmCommonCdVO> schCodeDto = commonService.getSeachCodeList();
		if (schCodeDto != null && schCodeDto.size() > 0) {
			HashMap<String, String> fcd09 = new HashMap<String, String>(); // 모니터링 내용

			for (CmCommonCdVO one : schCodeDto) {
				if (one.getFirstCd().equals(variablesMng.getMonitoringResultCode())) {
					fcd09.put(one.getCode(), one.getCdDesc());
				}
			}
			model.addAttribute("monitoringResultCode", Utils.makeCallStatusTag(fcd09)); // 모니터링 내용
		}

		// DB에서 전체 리스트 SELECT.
		CmContractVO topInfo = inboundMonitoringService.getInboundCallMntData(frontMntVO);
		String memo = commonMonitoringService.getRecentContractMemo(frontMntVO);
		frontMntVO.setCampaignId(topInfo.getCampaignId());
		frontMntVO.setCallId(topInfo.getLastCallId());
		List<CmCampaignInfoVO> mntResult = commonMonitoringService.getCallPopMonitoringResultList(frontMntVO);

		// 수동, 자동 모니터링 팝업 가운데 우측 모니터링 결과 답 SELECT
		HashMap<String, String> score = Utils.makeHashMapForScore(commonMonitoringService.getScoreList(frontMntVO));

		// 수동, 자동 모니터링 팝업 가운데 좌측 STT 결과 리스트 SELECT
		List<CmSttResultDetailVO> sttResult = commonMonitoringService.getSttResultAllList(frontMntVO);

		// Front에 전달할 객체들 생성.
		model.addAttribute("topInfo", topInfo);
		model.addAttribute("memo", memo);
		model.addAttribute("score", score);
		model.addAttribute("sttResult", sttResult);
		model.addAttribute("mntResult", mntResult);
		model.addAttribute("frontMntVO", frontMntVO);
		model.addAttribute("websocketUrl", customProperties.getWebsocketProtocol() + "://"
				+ customProperties.getWebsocketIp() + customProperties.getWebsocketPort());
		model.addAttribute("audioUrl", customProperties.getAudioIp() + customProperties.getAudioPort());

		return "monitoring/inboundMonitoringPopup";
	}


}
