package ai.maum.biz.fastaicc.common;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.main.system.menu.service.MenuService;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import ai.maum.biz.fastaicc.main.user.service.AuthService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CommonInterceptor extends HandlerInterceptorAdapter {

	/* 메뉴 서비스 */
	MenuService menuService;

	/* 권한 서비스 */
	AuthService authService;

	/* 공통 프로퍼티 */
	CustomProperties customProperties;

	public CommonInterceptor(MenuService menuService,AuthService authService,CustomProperties customProperties) {
		this.menuService = menuService;
		this.authService = authService;
		this.customProperties = customProperties;
	}

	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		//TODO : 권한체크 관련 처리를 해야 하는데 해당 URI가 화면 페이지의 URI인지 체크를 현재로서는 할 수가 없다.
//		UserVO userVo = Utils.getUserVo();
//		if(userVo!=null) {
//			// 메뉴코드 셋팅 및 메뉴 권한 체크
//			boolean isMenuAuth = false;
//			for(String key : userVo.getMenuLinkedMap().keySet()){
//				if(
//					userVo.getMenuLinkedMap().get(key).getUserMenuUrl()!=null &&
//					userVo.getMenuLinkedMap().get(key).getUserMenuUrl().equals(request.getRequestURI())
//				){
//					isMenuAuth=true;
//					break;
//				}
//			}
//			if(!isMenuAuth) {
//				response.sendRedirect(request.getContextPath() + "/error");
//				request.getSession().invalidate();
//			}
//		}
        return super.preHandle(request, response, handler);
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {


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

		// View단 Attribute 설정 및 메뉴권한 가져오기
		UserVO userVo = Utils.getUserVo();
		if(userVo!=null) {
			String userAuthTyNm = "";
			if(lang.equals("en")) {
				if(userVo.getUserAuthTy().equals("S")) {
					userAuthTyNm="superAdmin";
				}else if(userVo.getUserAuthTy().equals("A")) {
					userAuthTyNm="Admin";
				}else if(userVo.getUserAuthTy().equals("N")) {
					userAuthTyNm="Consultant";
				}else if(userVo.getUserAuthTy().equals("G")) {
					userAuthTyNm="Guest";
				}
			}else if(lang.equals("ko")){
				if(userVo.getUserAuthTy().equals("S")) {
					userAuthTyNm="슈퍼어드민";
				}else if(userVo.getUserAuthTy().equals("A")) {
					userAuthTyNm="관리자";
				}else if(userVo.getUserAuthTy().equals("N")) {
					userAuthTyNm="상담사";
				}else if(userVo.getUserAuthTy().equals("G")) {
					userAuthTyNm="게스트";
				}
			}
			userVo.setUserAuthTyNm(userAuthTyNm);

			// 유저 권한 메뉴 셋팅
			if(userVo.getMenuLinkedMap()==null)
				userVo.setMenuLinkedMap(menuService.getUserMenu(userVo.getUserAuthTy(),userVo.getUserId()));

			// 메뉴코드 셋팅
			for(String key : userVo.getMenuLinkedMap().keySet()){
				if(
					userVo.getMenuLinkedMap().get(key).getUserMenuUrl()!=null &&
					userVo.getMenuLinkedMap().get(key).getUserMenuUrl().equals(request.getServletPath())
				){
					request.setAttribute("menuCode", key);
					request.setAttribute("topMenuCode", userVo.getMenuLinkedMap().get(key).getTopMenuCode());
					request.setAttribute("menuVo", userVo.getMenuLinkedMap().get(key));
					// 메뉴 경로 설정
					String cours = menuService.getUserMeneCours(lang, key);
					request.setAttribute("cours", cours);
					break;
				}
			}

			request.setAttribute("user",userVo);
			request.setAttribute("userId",userVo.getUserId());
			request.setAttribute("enabledYn", userVo.getEnabledYn());
		}

		/** 공통 프로퍼티 처리 **/
		request.setAttribute("siteCustom", customProperties.getSiteCustom());
		request.setAttribute("proxyUrl", customProperties.getProxyProtocol() + "://"+ customProperties.getProxyIp() + customProperties.getProxyPort()); // 웹소켓 proxy URL

        super.postHandle(request, response, handler, modelAndView);
    }
}
