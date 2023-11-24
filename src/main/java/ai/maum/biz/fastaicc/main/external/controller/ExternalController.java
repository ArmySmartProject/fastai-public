package ai.maum.biz.fastaicc.main.external.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.util.WebUtils;

import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.main.system.menu.domain.MenuVO;
import ai.maum.biz.fastaicc.main.system.menu.service.MenuService;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ExternalController {

	/* 메뉴 서비스 */
	@Autowired
	MenuService menuService;
	
	@GetMapping(value = {"/embedded/page/{menuCode}"})
	public String getHumanChattingCounselingPage(@PathVariable("menuCode") String menuCode,HttpServletRequest request, HttpServletResponse response, Model model) {
		
		// 언어 설정
		String lang = request.getParameter("lang");
		if(lang!=null) {
			request.setAttribute("lang",lang);
		}else {
			Cookie langCookie = WebUtils.getCookie(request,"lang");
			if(langCookie!=null){
				lang=langCookie.getValue();
				request.setAttribute("lang",langCookie.getValue());
			}else {
				lang="ko";
				request.setAttribute("lang","ko");
			}
		}
		
		UserVO userVo = Utils.getUserVo();
		// 메뉴코드 셋팅
		for(String key : userVo.getMenuLinkedMap().keySet()){
			if(key.equals(menuCode)
			){
				request.setAttribute("url",userVo.getMenuLinkedMap().get(key).getUserMenuUrl());
				request.setAttribute("menuCode", key);
				request.setAttribute("topMenuCode", userVo.getMenuLinkedMap().get(key).getTopMenuCode());
				request.setAttribute("menuVo", userVo.getMenuLinkedMap().get(key));
				// 메뉴 경로 설정
				String cours = menuService.getUserMeneCours(lang, key);
				request.setAttribute("cours", cours);
				break;
			}
		}
		return "iframe/content";
	}
}
