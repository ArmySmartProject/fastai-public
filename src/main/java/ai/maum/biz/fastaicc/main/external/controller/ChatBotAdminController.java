package ai.maum.biz.fastaicc.main.external.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Slf4j
@RequestMapping("/chatbot-admin")
@Controller
public class ChatBotAdminController {
	
  @GetMapping(value = {"/dashboard"})
  public String getChatBotAdminDashboardPage(HttpServletRequest request, HttpServletResponse response, Model model) {
    log.info("ChatBotAdminController.{}", "getChatBotAdminDashboardPage()");

    request.setAttribute("titleCode","A0407");
    request.setAttribute("titleTxt","서비스 현황");
    request.setAttribute("url","https://chat-build.maum.ai:91/#/management/dashboard");
	return "iframe/content";
  }

  @GetMapping(value = {"/chatbot-management"})
  public String getChatBotAdminChatbotManagementPage(HttpServletRequest request, HttpServletResponse response, Model model) {
    log.info("ChatBotAdminController.{}", "getChatBotAdminChatbotManagementPage()");
    request.setAttribute("titleCode","A0407");
    request.setAttribute("titleTxt","챗봇 관리");
    request.setAttribute("url","https://chat-build.maum.ai:91/#/management/chatbot-management");
	return "iframe/content";
  }

  @GetMapping(value = {"/bqa"})
  public String getChatBotAdminBQAPage(HttpServletRequest request, HttpServletResponse response, Model model) {
    log.info("ChatBotAdminController.{}", "getChatBotAdminBQAPage()");
    
    request.setAttribute("titleCode","A0407");
    request.setAttribute("titleTxt","BQA");
    request.setAttribute("url","https://chat-build.maum.ai:91/#/management/domains/d-bqa");
	return "iframe/content";
  }

  @GetMapping(value = {"/scenario"})
  public String getChatBotAdminScenarioPage(HttpServletRequest request, HttpServletResponse response, Model model) {
    log.info("ChatBotAdminController.{}", "getChatBotAdminScenarioPage()");

    request.setAttribute("titleCode","A0407");
    request.setAttribute("titleTxt","시나리오");
    request.setAttribute("url","https://chat-build.maum.ai:91/#/management/domains/d-scenario");
	return "iframe/content";
  }

  @GetMapping(value = {"/api"})
  public String getChatBotAdminApiPage(HttpServletRequest request, HttpServletResponse response, Model model) {
    log.info("ChatBotAdminController.{}", "getChatBotAdminApiPage()");

    request.setAttribute("titleCode","A0407");
    request.setAttribute("titleTxt","API");
    request.setAttribute("url","https://chat-build.maum.ai:91/#/management/add-ons/api-mgmt");
	return "iframe/content";
  }

  @GetMapping(value = {"/nlp-test"})
  public String getChatBotAdmiNLPTestPage(HttpServletRequest request, HttpServletResponse response, Model model) {
    log.info("ChatBotAdminController.{}", "getChatBotAdmiNLPTestPage()");

    request.setAttribute("titleCode","A0407");
    request.setAttribute("titleTxt","NLP 테스트");
    request.setAttribute("url","https://chat-build.maum.ai:91/#/management/add-ons/nlp-test");
	return "iframe/content";
  }

  @GetMapping(value = {"/workspace"})
  public String getChatBotAdminWorkspacePage(HttpServletRequest request, HttpServletResponse response, Model model) {
    log.info("ChatBotAdminController.{}", "getChatBotAdminWorkspacePage()");

    request.setAttribute("titleCode","A0407");
    request.setAttribute("titleTxt","Workspace 관리");
    request.setAttribute("url","https://chat-build.maum.ai:91/#/management/management/workspaces");
	return "iframe/content";
  }

  @GetMapping(value = {"/team"})
  public String getChatBotAdminTeamPage(HttpServletRequest request, HttpServletResponse response, Model model) {
    log.info("ChatBotAdminController.{}", "getChatBotAdminTeamPage()");

    request.setAttribute("titleCode","A0407");
    request.setAttribute("titleTxt","Team 관리");
    request.setAttribute("url","https://chat-build.maum.ai:91/#/management/management/teams");
	return "iframe/content";
  }

  @GetMapping(value = {"/user"})
  public String getChatBotAdminUserPage(HttpServletRequest request, HttpServletResponse response, Model model) {
    log.info("ChatBotAdminController.{}", "getChatBotAdminUserPage()");

    request.setAttribute("titleCode","A0407");
    request.setAttribute("titleTxt","User 관리");
    request.setAttribute("url","https://chat-build.maum.ai:91/#/management/management/users");
	return "iframe/content";
  }

  @GetMapping(value = {"/code"})
  public String getChatBotAdminCodePage(HttpServletRequest request, HttpServletResponse response, Model model) {
    log.info("ChatBotAdminController.{}", "getChatBotAdminCodePage()");

    request.setAttribute("titleCode","A0407");
    request.setAttribute("titleTxt","코드 관리");
    request.setAttribute("url","https://chat-build.maum.ai:91/#/management/management/common-codes");
	return "iframe/content";
  }

  @GetMapping(value = {"/code-group"})
  public String getChatBotAdminCodeGroupPage(HttpServletRequest request, HttpServletResponse response, Model model) {
    log.info("ChatBotAdminController.{}", "getChatBotAdminCodeGroupPage()");

    request.setAttribute("titleCode","A0407");
    request.setAttribute("titleTxt","코드 그룹 관리");
    request.setAttribute("url","https://chat-build.maum.ai:91/#/management/management/common-code-groups");
	return "iframe/content";
  }

  @GetMapping(value = {"/logs"})
  public String getChatBotAdminLogsPage(HttpServletRequest request, HttpServletResponse response, Model model) {
    log.info("ChatBotAdminController.{}", "getChatBotAdminLogsPage()");

    request.setAttribute("titleCode","A0407");
    request.setAttribute("titleTxt","대화 이력 조회");
    request.setAttribute("url","https://chat-build.maum.ai:91/#/management/dialogs/logs");
	return "iframe/content";
  }

  @GetMapping(value = {"/error"})
  public String getChatBotAdminErrorPage(HttpServletRequest request, HttpServletResponse response, Model model) {
    log.info("ChatBotAdminController.{}", "getChatBotAdminErrorPage()");

    request.setAttribute("titleCode","A0407");
    request.setAttribute("titleTxt","답변불가 대화현황 조회");
    request.setAttribute("url","https://chat-build.maum.ai:91/#/management/dialogs/error");
	return "iframe/content";
  }

  @GetMapping(value = {"/profile"})
  public String getChatBotAdminProfilePage(HttpServletRequest request, HttpServletResponse response, Model model) {
    log.info("ChatBotAdminController.{}", "getChatBotAdminProfilePage()");

    request.setAttribute("titleCode","A0407");
    request.setAttribute("titleTxt","프로필");
    request.setAttribute("url","https://chat-build.maum.ai:91/#/management/profile");
	return "iframe/content";
  }

  @GetMapping(value = {"/nlp-synonym"})
  public String getChatBotAdminNlpSynonymPage(HttpServletRequest request, HttpServletResponse response, Model model) {
    log.info("ChatBotAdminController.{}", "getChatBotAdminNlpSynonymPage()");

    request.setAttribute("titleCode","A0407");
    request.setAttribute("titleTxt","유의어 처리");
    request.setAttribute("url","https://chat-build.maum.ai:91/#/management/nlp/synonym/synonyms");
	return "iframe/content";
  }

  @GetMapping(value = {"/nlp-employees"})
  public String getChatBotAdminNlpEmployeesPage(HttpServletRequest request, HttpServletResponse response, Model model) {
    log.info("ChatBotAdminController.{}", "getChatBotAdminNlpEmployeesPage()");

    request.setAttribute("titleCode","A0407");
    request.setAttribute("titleTxt","사용자 사전");
    request.setAttribute("url","https://chat-build.maum.ai:91/#/management/nlp/user-dic/employees");
	return "iframe/content";
  }


}
