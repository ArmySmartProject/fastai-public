package ai.maum.biz.fastaicc.main.cousult.chatbot.controller;

import ai.maum.biz.fastaicc.main.cousult.common.domain.ChatRoomVO;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.ConsultingService;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;

import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ChatConsultingController {
	
	@Autowired
	CustomProperties customProperties;

	@Autowired
	ConsultingService consultingService;
	
	/* 인바운드 상담 main화면 */
	@RequestMapping(value = "/cbCsMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String ibCsMain(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		frontMntVO.setCall_type_code("Y");//콜타입 (IB & OB)
		
		if("".equals(frontMntVO.getSessId()) || frontMntVO.getSessId() == null) {
			frontMntVO.setSessId(userId);
		}
		List<Map> opIbStateTotal = consultingService.getOpIbStateList(frontMntVO);
		// 챗봇 정보 조회
		String chatConsultStatus = opIbStateTotal.get(0).get("CHAT_CONSULT_STATUS").toString();
		List<Map> chatbotInfos = consultingService.getChatbotInfos(userId);
		model.addAttribute("chatbotInfos", new Gson().toJson(chatbotInfos)); // 상담 상단 상태바 total
		model.addAttribute("opIbStateTotal", opIbStateTotal);
		model.addAttribute("chatConsultStatus", chatConsultStatus);
		model.addAttribute("chatServerURL",
				customProperties.getChattingIp() + customProperties.getChattingPort()); // 웹소켓URL
		return "/consulting/chatbotConsulting";
	}
	
	@RequestMapping(value = "/getOpChatState", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> getOpChatState(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException {
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
			consultingService.updateCmOpChatInfo(CsDtlOpStatusMap);
		}
		 
		// 상담 상단 상태바 조회
		List<Map> opIbStateTotal = consultingService.getOpIbStateList(frontMntVO);
		// 리턴 값
		map.put("opIbStateTotal", new Gson().toJson(opIbStateTotal)); // 고객 상담내용 정보
		return map;
	}
	
	@RequestMapping(value = "/updateChatMemo", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> updateChatMemo(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException {
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		
		consultingService.updateChatMemo(map);
		
		return null;
	}
	

	@RequestMapping(value = {"/mobileCbCsMain", "/redtie/mobileCbCsMain"}, method = {RequestMethod.GET, RequestMethod.POST})
	public String mobileIbCsMain(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {

		ibCsMain(frontMntVO, req, model);
		return "/mobile/chatting_list";
	}

	@RequestMapping(value = {"/mobileChatting", "/redtie/mobileChatting"}, method = {RequestMethod.GET, RequestMethod.POST})
	public String mobileChatting(FrontMntVO frontMntVO, HttpServletRequest req, Model model,
			ChatRoomVO chatRoomVO)
			throws JsonProcessingException {

		ObjectMapper mapper = new ObjectMapper();
		String jsonString = mapper.writeValueAsString(chatRoomVO);

		model.addAttribute("domain", customProperties.getProxyIp()); // 웹소켓URL
		model.addAttribute("chatRoomVO", jsonString);
		return "/mobile/chatting";
	}
}
