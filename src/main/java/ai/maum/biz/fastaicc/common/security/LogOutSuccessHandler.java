package ai.maum.biz.fastaicc.common.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;

import ai.maum.biz.fastaicc.common.util.HttpClientRes;
import ai.maum.biz.fastaicc.common.util.UtilHttpClient;
import ai.maum.biz.fastaicc.common.util.UtilProperties;
import ai.maum.biz.fastaicc.main.user.domain.OAuthTokenVO;

/**
 * 로그아웃 성공 시
 * 핸들러 들어옴.
 * custom 으로 session 에 저장한것들은
 * 여기서 정리하고 logout 처리
 */
@Component("logOutSuccessHandler")
public class LogOutSuccessHandler implements LogoutHandler, LogoutSuccessHandler {

    Logger logger = LoggerFactory.getLogger(LogOutSuccessHandler.class);

    UtilProperties properties;

    @Autowired
    public LogOutSuccessHandler(UtilProperties properties)
    {
        this.properties = properties;
    }

    @Override
    public void onLogoutSuccess(HttpServletRequest request,
                                HttpServletResponse response,
                                Authentication authentication) throws IOException, ServletException
    {
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            for (Cookie cookie : cookies) {
            	if(!cookie.getName().equals("lang")) {
            		cookie.setMaxAge(0);
            	}
                response.addCookie(cookie);
            }
        }
        
        response.setStatus(HttpServletResponse.SC_OK);
//        response.sendRedirect("/login");
//        response.sendRedirect("https://maum.ai");
    }

    @Override
    public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
    {
    	
    	HttpSession session = request.getSession(true);
    	try {
    	expireSessionAndLogout(request, response);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        /*HttpSession session = request.getSession(true);
        
        Map<String, String> paramMap = new HashMap<>();
//        if(session.getAttribute("ssoToken") != null) {
            OAuthTokenVO ssoToken = (OAuthTokenVO) session.getAttribute("ssoToken");
            paramMap.put("client_id", properties.getSsoMindslabClientId());
            paramMap.put("access_token", ssoToken.getAccess_token());
           
            try {
                HttpClientRes res = UtilHttpClient.getInstance().delete(properties.getSsoMindslabTokenReqUrl(), paramMap);
                logger.info("Logout/Token={}, DeleteRes={}", ssoToken.getAccess_token(), res.getStatusCode());
            }
            catch (Exception e){
                e.printStackTrace();
            }
//        }
        String lastChar = properties.getDomain().substring(properties.getDomain().length() - 1);
        if(paramMap.get("client_id") != null) {
        	String returnUrl = null;
        	if(lastChar.equals("/")) {
        		returnUrl = properties.getSsoMindslabTokenLogoutUrl() +"?client_id="+paramMap.get("client_id")+"&returnUrl="+properties.getDomain()+"login";
        	}else {
        		returnUrl = properties.getSsoMindslabTokenLogoutUrl() +"?client_id="+paramMap.get("client_id")+"&returnUrl="+properties.getDomain()+"/login";
        	}
        	try {
        		response.sendRedirect(returnUrl);
        	} catch (IOException e) {
        		
        		e.printStackTrace();
        	}
        	
        }else {
        	try {
        		response.sendRedirect("login");
        	} catch (IOException e) {
        		
        		e.printStackTrace();
        	}
        }*/
        
        session.removeAttribute("ssoToken");
        session.removeAttribute("userInfo");
        session.removeAttribute("SPRING_SECURITY_CONTEXT");
        
    }
    
 // 로그아웃
    public String reqLogout(HttpServletRequest request, HttpServletResponse response) {

        String url = properties.getSsoMindslabTokenLogoutUrl();

        Map<String, String> cookie = getCookie(request, response);
        String accessToken = cookie.get("accessToken");
        logger.info("accessToken ::::" + accessToken);

        try {
            HttpClient client = HttpClients.createDefault();
            HttpPost post = new HttpPost(url);

            String authToken = "Bearer " + accessToken;
            post.setHeader("Authorization", authToken);

            HttpResponse res = client.execute(post);
            String resData = EntityUtils.toString(res.getEntity(), "UTF-8");

            return resData;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;

    }

    // session 만료, 쿠키 만료
    public void expireSessionAndLogout(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws IOException {

        HttpSession session = httpServletRequest.getSession(true);
        session.removeAttribute("user"); // 기존 세션 만료

        String redirectUrl = properties.getDomain();
        String logoutResponse = reqLogout(httpServletRequest, httpServletResponse);
        logger.info("logout response ::::" + logoutResponse);

        httpServletResponse.sendRedirect(redirectUrl);
    }

    public Map<String, String> getCookie(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {

        Map<String, String> result = new HashMap<>();

        Cookie[] cookies = httpServletRequest.getCookies();
        String accessToken;
        String refreshToken;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equalsIgnoreCase("MAUM_AID")) {
                    accessToken = cookie.getValue();
//                    logger.info("@ OAuth.token access_token value: {}", accessToken);

                    result.put("accessToken", accessToken);
                }
                if (cookie.getName().equalsIgnoreCase("MAUM_RID")) {
                    refreshToken = cookie.getValue();
//                    logger.info("@ OAuth.token refresh_token value: {}", refreshToken);

                    result.put("refreshToken", refreshToken);
                }
            }
        } else {
            return null;
        }
        return result;
    }
}

