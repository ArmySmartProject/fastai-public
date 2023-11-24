package ai.maum.biz.fastaicc.main.cousult.voiceBot.controller;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.main.common.domain.PagingVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.VoiceBotVO;
import ai.maum.biz.fastaicc.main.cousult.inbound.domain.SipAccountVO;
import ai.maum.biz.fastaicc.main.cousult.voiceBot.domain.ConsultantVO;
import ai.maum.biz.fastaicc.main.cousult.voiceBot.service.VoiceBotManageService;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.Consts;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Slf4j
@Controller
public class VoiceBotManageController {
	/* 공통서비스 */
	@Autowired
	VoiceBotManageService voiceBotManageService;

	@Autowired
	CustomProperties customProperties;

	@RequestMapping(value = "/voicebotManagement", method = { RequestMethod.GET, RequestMethod.POST })
	public String obCsMain(FrontMntVO frontMntVO, HttpServletRequest req, Model model)
			throws ParseException, IOException {

		return "/system_manage/system_voicebot_manage";

	}

	@ResponseBody
	@RequestMapping(value = "/getVoiceBotList", method = {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> getVoiceBotList(HttpServletRequest request,
			HttpServletResponse response, @RequestBody String jsonStr) throws IOException {

		Map<String, Object> map = null;
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		map.put("userId", userId);
		List<VoiceBotVO> voiceBotList = voiceBotManageService.getVoiceBotList(map);
		for (int i = 0; i < voiceBotList.size(); i++) {
			SipAccountVO sipAccountVO = new SipAccountVO();
			List<VoiceBotVO> voiceBotVO = new ArrayList<>();
			sipAccountVO.setCampaignId(voiceBotList.get(i).getCampaignId());
			voiceBotVO = voiceBotManageService.getUpdate(sipAccountVO);
			if (voiceBotVO.get(0) != null && voiceBotVO.get(0) != null) {
				voiceBotList.get(i).setUpdaterId(voiceBotVO.get(0).getUpdaterId());
				voiceBotList.get(i).setUpdatedDtm(voiceBotVO.get(0).getUpdatedDtm());
			}
		}

		map.put("voiceBotList", voiceBotList);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/getSipActList", method = { RequestMethod.GET, RequestMethod.POST })
	public Map<String, Object> getSipActList(@RequestBody String jsonStr) throws IOException {

		Map<String, Object> map = null;
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		List<SipAccountVO> sipAccountList = voiceBotManageService
				.getSipAccountList(String.valueOf(map.get("CAMPAIGN_ID")));
		
		List<VoiceBotVO> scenarioList = voiceBotManageService
				.getScenarioList(String.valueOf(map.get("COMPANY_ID")));
		
		map.put("sipAccountList", sipAccountList);
		map.put("scenarioList", scenarioList);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/getVoiceConsultantList", method = { RequestMethod.GET, RequestMethod.POST })
	public Map<String, Object> getVoiceConsultantList(@RequestBody String jsonStr) throws IOException {

		Map<String, Object> map = null;
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		map.put("companyId", String.valueOf(map.get("COMPANY_ID")));
		map.put("consultantId", String.valueOf(map.get("CONSULTANT_ID")));
		List<ConsultantVO> consultantList = voiceBotManageService
				.getConsultantList(map);
		ConsultantVO consultantVO = voiceBotManageService.getAssignedCt(String.valueOf(map.get("CONSULTANT_ID")));
		if (consultantVO != null && !"".equals(consultantVO)) {
			consultantList.add(0, consultantVO);
		}

		int consultantCount = voiceBotManageService.getConsultantCount(String.valueOf(map.get("COMPANY_ID")));

		String consultantId = String.valueOf(map.get("CONSULTANT_ID"));
		for(int i=0; i<consultantList.size(); i++) {
			if(consultantList.get(i).getUserId().equals(consultantId)) {
				List<ConsultantVO> tempConsultantList = consultantList;
				ConsultantVO tempA = consultantList.get(i);
				ConsultantVO tempB = consultantList.get(0);
				tempConsultantList.set(0, tempA);
				tempConsultantList.set(i, tempB);
				consultantList = tempConsultantList;
			}
		}

		map.put("consultantList", consultantList);
		map.put("consultantCount", consultantCount);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/updateAssignedCst", method = { RequestMethod.GET, RequestMethod.POST })
	public Map<String, Object> updateAssignedCst(@RequestBody String jsonStr) throws IOException {

		Map<String, Object> map = null;
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		SipAccountVO sipAccountVO = new SipAccountVO();
		sipAccountVO.setSipUser(String.valueOf(map.get("SIP_ID")));
		sipAccountVO.setCustOpId(String.valueOf(map.get("CONSULTANT_ID")));
		sipAccountVO.setCampaignId(String.valueOf(map.get("CAMPAIGN_ID")));
		sipAccountVO.setUpdaterId(userId);
		voiceBotManageService.updateAssignedCst(sipAccountVO);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/getScenarioList", method = { RequestMethod.GET, RequestMethod.POST })
	public String getScenarioList(@RequestBody String jsonStr) throws IOException {

		try {
			HttpClient client = HttpClientBuilder.create().build();
			HttpPost post = new HttpPost(customProperties.getSimplebotListApi());

			JsonParser jp = new JsonParser();
			JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);

			post.setEntity(new StringEntity(jsonObj.toString(), Consts.UTF_8));
			post.setHeader("Content-Type", MediaType.APPLICATION_JSON_UTF8_VALUE);

			HttpResponse response = client.execute(post);
			if (response.getStatusLine().getStatusCode() == 200) {
				return EntityUtils.toString(response.getEntity(), "UTF-8");
			} else {
				System.out.println("http response isn't 200");
				return "WRONG";
			}

		} catch (Exception e) {
			System.out.println("<err>".concat(e.getMessage()));
			return "ERROR";
		}
	}

	@ResponseBody
	@RequestMapping(value = "/updateAssignedScenario", method = { RequestMethod.GET, RequestMethod.POST })
	public void updateAssignedScenario(@RequestBody String jsonStr) throws IOException {

		Map<String, Object> map = null;
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		voiceBotManageService.updateAssignedScenario(map);
	}
}
