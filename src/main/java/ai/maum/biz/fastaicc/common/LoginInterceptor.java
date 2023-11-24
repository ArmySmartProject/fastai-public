package ai.maum.biz.fastaicc.common;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import ai.maum.biz.fastaicc.common.util.UtilProperties;
import ai.maum.biz.fastaicc.main.system.menu.service.MenuService;
import ai.maum.biz.fastaicc.main.user.service.AuthService;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginInterceptor extends HandlerInterceptorAdapter{

	/* 메뉴 서비스 */
	MenuService menuService;

	/* 권한 서비스 */
	AuthService authService;

	/* 공통 프로퍼티 */
	CustomProperties customProperties;

	UtilProperties utilProperties;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		HttpSession session = request.getSession();

		Object obj = session.getAttribute("user");


		if(obj == null) {

		}else {
			response.sendRedirect("/chatListMain");
		}

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

		super.postHandle(request, response, handler, modelAndView);
	}

}
