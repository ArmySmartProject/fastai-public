package ai.maum.biz.fastaicc.common.security;

import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import ai.maum.biz.fastaicc.main.system.menu.domain.MenuVO;
import ai.maum.biz.fastaicc.main.system.menu.service.MenuService;
import ai.maum.biz.fastaicc.main.user.domain.AuthenticaionVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    protected Log logger = LogFactory.getLog(this.getClass());

    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    /* 메뉴 서비스 */
	MenuService menuService;

	public LoginSuccessHandler(MenuService menuService) {
		this.menuService=menuService;
	}

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response, Authentication authentication)
            throws IOException {

    	response.setHeader("P3P","CP='CAO PSA CONi OTR OUR DEM ONL'");

        handle(request, response, authentication);
        clearAuthenticationAttributes(request);
    }

    protected void handle(HttpServletRequest request,
                          HttpServletResponse response, Authentication authentication)
            throws IOException {

        String targetUrl = determineTargetUrl(authentication, request);

        if (response.isCommitted()) {
            logger.debug("Response has already been committed. Unable to redirect to "+ targetUrl);
            return;
        }

        redirectStrategy.sendRedirect(request, response, targetUrl);
    }

    /**
     *  로그인시 사용자의 메뉴를 셋팅하고
     *  최초 로딩할 페이지를 선택함
     * @param authentication
     * @param request
     * @return
     */
    protected String determineTargetUrl(Authentication authentication, HttpServletRequest request) {

      UserVO userVo = null;
      Authentication auth = SecurityContextHolder.getContext().getAuthentication();
      if (auth != null && !auth.getPrincipal().equals("anonymousUser")) {
        AuthenticaionVO userDto = (AuthenticaionVO) auth;
        userVo = userDto.getUser();
        if (userVo != null) {
          // 유저 권한 메뉴 셋팅
          userVo.setMenuLinkedMap(
              menuService.getUserMenu(userVo.getUserAuthTy(), userVo.getUserId()));
        }
      }

      HttpSession session = request.getSession();
      String root = (String) session.getAttribute("root");
      String referer = request.getHeader("referer");
      if (root == null) {
        root = "";
      }
      String mainPage = request.getParameter("mainPage");
      if (referer.contains("/mobile/login") || root.equals("/mobile/login")) {
        mainPage = "/mobileCbCsMain";
        return mainPage;
      } else if (referer.contains("/mobile/redtie/login") || root.equals("/mobile/redtie/login")) {
        mainPage = "/redtie/mobileCbCsMain";
        return mainPage;
      } else {
        MenuVO mainMenuVo = null;
        // 사용자 메뉴중 첫번째 링크 메뉴를  최초 페이지시 불러옴
        if (!userVo.getMenuLinkedMap().isEmpty()) {
          Iterator<Entry<String, MenuVO>> iterator = userVo.getMenuLinkedMap().entrySet().iterator();
          MenuVO menuVo = iterator.next().getValue();
          while (iterator.hasNext()) {
            if (menuVo.getMenuLinkedMap() != null && menuVo.getMenuLinkedMap().size() > 0) {
              // 인바운드 상담 메뉴를 가져온다.
              mainMenuVo = getMenuElem(menuVo.getMenuLinkedMap(), "MENU004");
              // 인바운드 상담 메뉴 권한이 해당 사용자에게 부여되어있다면 반복문을 나온다
              if (mainMenuVo != null) {
                break;
              } else {
                // 부여되어 있지않다면 해당 메뉴의 첫번째 메뉴를 가져온다.
                mainMenuVo = getFirstElem(menuVo.getMenuLinkedMap());
              }
              // 다음 메뉴로 포인터의 방향으로 변경한다.
              menuVo = (MenuVO) iterator.next().getValue();
            } else {
              // 다음 메뉴로 포인터의 방향으로 변경한다.
              menuVo = (MenuVO) iterator.next().getValue();
            }
          }
        }

        // 가져온 메뉴가 없을시 사용 할 수 있는 메뉴권한이 없으므로 error를 나타낸다.
        if (mainMenuVo == null) {
          mainPage = "error";
        }

        // 권한별 페이지 정의 20200525 버그리포트 86라인 요청사항
        if (userVo.getUserAuthTy().equals("S")) {
          mainPage="/superCompMain?first";
        } else if (userVo.getUserAuthTy().equals("A")) {
          mainPage = mainMenuVo.getUserMenuUrl() + "?first";
        } else {
          mainPage = mainMenuVo.getUserMenuUrl() + "?first";
        }

        logger.info("mainPage name :: " + mainPage);
        return mainPage;

      }
    }

    protected void clearAuthenticationAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
    }

    public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
        this.redirectStrategy = redirectStrategy;
    }

    protected RedirectStrategy getRedirectStrategy() {
        return redirectStrategy;
    }

    protected MenuVO getFirstElem(LinkedHashMap<String, MenuVO> hashMap) {
    	for(String key : hashMap.keySet()) {
        	return hashMap.get(key);
    	}
    	return null;
    }

    protected MenuVO getMenuElem(LinkedHashMap<String, MenuVO> hashMap,String menuCode) {
    	for(String key : hashMap.keySet()) {
    		if(hashMap.get(key).getMenuCode().equals(menuCode)) {
    			return hashMap.get(key);
    		}
    	}
    	return null;
    }
}
