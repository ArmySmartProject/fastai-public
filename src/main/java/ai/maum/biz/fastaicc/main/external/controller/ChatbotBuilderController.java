package ai.maum.biz.fastaicc.main.external.controller;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.main.cousult.chatbotBuilder.service.ChatbotBuilderService;
import ai.maum.biz.fastaicc.main.statistic.service.StatisticsService;
import ai.maum.biz.fastaicc.main.user.domain.AuthenticaionVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import ai.maum.biz.fastaicc.main.user.service.AuthService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ChatbotBuilderController {
	@Autowired
	StatisticsService statisticsService;

	@Autowired
	ChatbotBuilderService chatbotBuilderService;

	@Autowired
	AuthService authService;

	@Autowired
	CustomProperties customProperties;

	@RequestMapping(value = "/userChatbotBuilder", method = {RequestMethod.GET, RequestMethod.POST})
	public String simpleBot(HttpServletRequest req) {

		Map<String, Object> map = new HashMap<>();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		map.put("userId", userId);
		AuthenticaionVO userDto=(AuthenticaionVO)auth;
		UserVO userVo = userDto.getUser();
		Integer maxChat = 0;
		if (userVo.getUserAuthTy().equals("S")) {
			map.remove("userId");
			maxChat = 999;
		} else {
      maxChat = chatbotBuilderService.getMaxChat(map);
    }
    List<Map<String, Object>> chatbotList = chatbotBuilderService.getChatbotList(map);
		req.setAttribute("userAuthTy", userVo.getUserAuthTy());
		req.setAttribute("maxChat", maxChat);
		req.setAttribute("chatbotList", chatbotList);
		req.setAttribute("isGroup", 'n');
		req.setAttribute("url", customProperties.getChatbotBuilderUrl());
		return "iframe/content";

	}

	@RequestMapping(value = "/coChatbotbuilder", method = {RequestMethod.GET, RequestMethod.POST})
	public String voiceBotBuilder(HttpServletRequest req) {

		Map<String, Object> map = new HashMap<>();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		map.put("sessId", userId);
		String companyId = statisticsService.getBoardCompanyId(map); //로그인한 사용자의 회사 ID
		map.put("companyId", companyId);
		AuthenticaionVO userDto=(AuthenticaionVO)auth;
		UserVO userVo = userDto.getUser();
		Integer maxChat = 0;
		if (userVo.getUserAuthTy().equals("S")) {
			map.remove("companyId");
			maxChat = 999;
		} else {
			maxChat = chatbotBuilderService.getMaxChat(map);
		}
		List<Map<String, Object>> chatbotList = chatbotBuilderService.getChatbotList(map);
		req.setAttribute("userAuthTy", userVo.getUserAuthTy());
		req.setAttribute("maxChat", maxChat);
		req.setAttribute("chatbotList", chatbotList);
		req.setAttribute("isGroup", 'y');
		req.setAttribute("url", customProperties.getChatbotBuilderUrl());
		return "iframe/content";

	}

	@ResponseBody
	@RequestMapping(value = "/insertBotMapping", method = {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> insertBotMapping(@RequestBody String jsonStr, HttpServletRequest req)
		throws IOException {

		Map<String, Object> map = null;
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		map.put("sessId", userId);
		String companyId = statisticsService.getBoardCompanyId(map); //로그인한 사용자의 회사 ID
		map.put("companyId", companyId);
		chatbotBuilderService.insertBotMapping(map);
		return map;

	}

	@ResponseBody
	@RequestMapping(value = "/maxChatbotCheck", method = {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> maxChatbotCheck(@RequestBody String jsonStr, HttpServletRequest req)
			throws IOException {

		Map<String, Object> map = null;
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		String isGroup = (String) map.get("isGroup");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
    AuthenticaionVO userDto=(AuthenticaionVO)auth;
    UserVO userVo = userDto.getUser();
    if (userVo.getUserAuthTy().equals("S")) {
      map.put("result", true);
    } else {
      map.put("sessId", userId);
      String companyId = statisticsService.getBoardCompanyId(map); //로그인한 사용자의 회사 ID
      map.put("companyId", companyId);
      map = chatbotBuilderService.maxChatbotCheck(map);
      int chatCount = Integer.parseInt(map.get("count").toString());
      if (isGroup.equals("y") && map.get("compMax") != null && chatCount < Integer
          .parseInt(map.get("compMax").toString())) {
        map.put("result", true);
      } else if (isGroup.equals("n") && map.get("userMax") != null && chatCount < Integer
          .parseInt(map.get("userMax").toString())) {
        map.put("result", true);
      } else {
        map.put("result", false);
      }
    }

		return map;

	}

	@ResponseBody
	@RequestMapping(value = "/delBotMapping", method = {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> delBotMapping(@RequestBody String jsonStr, HttpServletRequest req)
			throws IOException {

		Map<String, Object> map = null;
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		map.put("sessId", userId);
		String companyId = statisticsService.getBoardCompanyId(map); //로그인한 사용자의 회사 ID
		map.put("companyId", companyId);
		chatbotBuilderService.delBotMapping(map);
		return map;

	}

	@ResponseBody
	@RequestMapping(value = "/getBotList", method = {RequestMethod.GET, RequestMethod.POST})
	public List<Map<String, Object>> getBotListByUser(@RequestBody String jsonStr, HttpServletRequest req)
			throws IOException {
		Map<String, Object> map = null;
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		if (map.get("isCompany").toString().equals("Y")) {
			map.put("userId", "");
		} else {
			map.put("companyId", "");
		}
		// mysql에서 botMapping 조회
		List<Map<String, Object>> chatbotList = chatbotBuilderService.getChatbotList(map);
		List<Map<String, Object>> result = new ArrayList<>();

		// mssql에서 bot list 조회
		if (!chatbotList.isEmpty()) {
          List<Integer> botIds = new ArrayList<>();

          for (Map<String, Object> chatbot : chatbotList) {
            botIds.add(Integer.parseInt(chatbot.get("BOT_ID").toString()));
          }
          map.put("botIds", botIds);
          result = chatbotBuilderService.selectAccountListByNo(map);
        }

		return result;
	}
}
