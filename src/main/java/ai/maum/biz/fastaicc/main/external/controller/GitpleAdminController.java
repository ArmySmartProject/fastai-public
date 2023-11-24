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
@Controller
public class GitpleAdminController {

	@GetMapping(value = {"/human/chatting-counseling"})
	public String getHumanChattingCounselingPage(HttpServletRequest req, HttpServletResponse response, Model model) {
		req.setAttribute("url","https://workspace.gitple.io");
		return "iframe/content";
	}
}
