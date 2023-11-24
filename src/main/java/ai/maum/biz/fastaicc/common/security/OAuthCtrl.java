package ai.maum.biz.fastaicc.common.security;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.view.RedirectView;

import com.fasterxml.jackson.databind.ObjectMapper;

import ai.maum.biz.fastaicc.common.util.CommonUtils;
import ai.maum.biz.fastaicc.common.util.HttpClientRes;
import ai.maum.biz.fastaicc.common.util.UtilHttpClient;
import ai.maum.biz.fastaicc.common.util.UtilProperties;
import ai.maum.biz.fastaicc.main.user.domain.OAuthTokenVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import ai.maum.biz.fastaicc.main.user.service.AuthService;

@Controller
@RequestMapping("/oauth")
public class OAuthCtrl {

    private UtilProperties utilProperties;
    private AuthenticationManager authManager;

    @Autowired
    AuthService authService;


    public OAuthCtrl(UtilProperties utilProperties, AuthenticationManager authManager) {
        this.utilProperties = utilProperties;
        this.authManager = authManager;
    }


    @GetMapping("/login")
    public String loginPage(HttpServletRequest request)
    {
        String referer = request.getHeader("Referer");

        if(referer != null && referer.startsWith(utilProperties.getDomain())) {
            HttpSession session = request.getSession();
            session.setAttribute("prevPage", referer.replace(utilProperties.getDomain(), ""));
        }

        return "oauth_login";
    }

    @RequestMapping("/oauth_login_process")
    public String oauth_login_process(HttpServletRequest request)
    {
    	 HttpSession session = request.getSession();
    	 UserVO user = (UserVO) session.getAttribute("userInfo");
    	 if(user!=null) {
    		 request.setAttribute("username",user.getUserId());
    		 request.setAttribute("password","oAtuh");
    	 }
    	
        return "oauth_login_process";
    }
    
    @GetMapping
    @RequestMapping("/callback")
    public String callbackToken(HttpServletRequest request,
                                      HttpServletResponse response,
                                      @RequestParam("code") String code,
                                      @RequestParam("state") String state)
    {
        Object prevPageObj = request.getSession().getAttribute("prevPage");
        RedirectView redirectView = new RedirectView(prevPageObj != null ? prevPageObj.toString() : "/");
        request.getSession().removeAttribute("prevPage");

        try {
            UtilHttpClient httpClient = UtilHttpClient.getInstance();
            Map<String, String> paramsMap = new HashMap<>();
            paramsMap.put("grant_type", "authorization_code");
            paramsMap.put("code", code);

            System.out.println(utilProperties.getSsoMindslabTokenReqUrl());
            HttpClientRes res = httpClient.post(utilProperties.getSsoMindslabTokenReqUrl(), paramsMap);

            if(HttpStatus.SC_OK != res.getStatusCode()) {
            	return "/login";
            }

            OAuthTokenVO token = CommonUtils.parseJsonStringToObject(res.getContent(), new OAuthTokenVO());

            authService.addOAuthUserIfNotExist(token);

            UserVO user = authService.getAccount(token.getEmail());
            
            if(user != null){
            	
//            	user.setSessionId(RequestContextHolder.currentRequestAttributes().getSessionId());
//        		authService.updateLoginDt(user);
//        		List<GrantedAuthority> grantedAuthorityList = new ArrayList();
//        		grantedAuthorityList.add(new SimpleGrantedAuthority("USER_ADMIN"));
//        		Authentication auth =  new AuthenticaionDTO(token.getEmail(),"", grantedAuthorityList, user);
//				SecurityContext securityContext = SecurityContextHolder.getContext();
//				securityContext.setAuthentication(auth);
            	
               HttpSession session = request.getSession();
//               session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);
               session.setAttribute("userInfo", user);
               session.setAttribute("ssoToken", token);

               request.setAttribute("username",user.getUserId());
               request.setAttribute("password","oAtuh");
      		 
               ObjectMapper mapper = new ObjectMapper();
               String jsonString = mapper.writeValueAsString(user);
               Cookie userCookie = new Cookie("userInfo", URLEncoder.encode(jsonString, "utf-8"));
               response.addCookie(userCookie);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return "/oauth_login_process";
    }


}
