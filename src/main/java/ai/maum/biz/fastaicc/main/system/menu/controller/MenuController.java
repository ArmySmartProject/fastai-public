package ai.maum.biz.fastaicc.main.system.menu.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.system.menu.domain.MenuVO;
import ai.maum.biz.fastaicc.main.system.menu.service.MenuService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MenuController {
	@Autowired
	MenuService menuService;

	@RequestMapping(value = "/menutest", method = { RequestMethod.GET, RequestMethod.POST })
	public List<MenuVO> ibStatsTotalMain(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
		
		List<MenuVO> userMenuList = (List<MenuVO>) menuService.getUserMenu("A","aicc01");
		
		return userMenuList;
	}
}