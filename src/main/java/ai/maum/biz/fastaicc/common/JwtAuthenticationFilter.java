package ai.maum.biz.fastaicc.common;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import com.fasterxml.jackson.databind.ObjectMapper;

import ai.maum.biz.fastaicc.common.util.UtilProperties;
import ai.maum.biz.fastaicc.main.user.domain.AuthenticaionVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import ai.maum.biz.fastaicc.main.user.service.AuthService;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

@Slf4j
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {
   
	private final AuthService authService;
    private final SSOExternalAPI ssoExternalAPI;
    private final UtilProperties utilProperties;
    
    @SneakyThrows
    @Override
    protected void doFilterInternal(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, FilterChain filterChain) throws ServletException, IOException {
        HttpSession session = httpServletRequest.getSession(true);
        UserVO user = (UserVO) httpServletRequest.getSession().getAttribute("user");

        if (user == null || SecurityContextHolder.getContext().getAuthentication() == null) {
            /* --------------------------------- 세션 미존재 --------------------------------- */
            Map<String, String> tokenMap = getCookie(httpServletRequest, httpServletResponse);

            if (tokenMap == null || "".equalsIgnoreCase(tokenMap.toString())) {             // 최초 접속 시,
                //System.out.println(" @ @ 최초 접속 !");
                filterChain.doFilter(httpServletRequest, httpServletResponse);
            }else {
                String accessToken = tokenMap.get("accessToken");
                String refreshToken = tokenMap.get("refreshToken");

                if (accessToken == null) {
                    if (refreshToken != null) {                              // 세션 X, accessToken X, refreshToken O
                        if (validateToken(refreshToken)) {
                            ssoExternalAPI.refreshJwtAccessToken(refreshToken, httpServletResponse);
                            setSessionAccessUser(accessToken, refreshToken, httpServletRequest);
                        } else {
                            expireSessionAndLogout(httpServletRequest, httpServletResponse);
                        }
                    } else {                                                // 세션 X, accessToken X, refreshToken X
                        // 정상적 현상
                    }
                }

                if (accessToken != null) {
                    if (refreshToken != null) {                              // 세션 X, accessToken O, refreshToken O
                        if (validateToken(accessToken) && validateToken(refreshToken)) {
                            setSessionAccessUser(accessToken, refreshToken, httpServletRequest);
                        }
                    } else {                                                // 세션 X, accessToken O, refreshToken X
                        log.warn(" @ JwtAuthenticationFilter: no session, no refreshToken");
                        expireSessionAndLogout(httpServletRequest, httpServletResponse);
                    }
                }
                filterChain.doFilter(httpServletRequest, httpServletResponse);
            }
        } else {
            /* --------------------------------- 세션 존재 --------------------------------- */
            Map<String, String> tokenMap = getCookie(httpServletRequest, httpServletResponse);
            if (tokenMap == null) {
                filterChain.doFilter(httpServletRequest, httpServletResponse);
            }
            String accessToken = tokenMap.get("accessToken");
            String refreshToken = tokenMap.get("refreshToken");

            if (accessToken == null) {
                if(refreshToken != null) {                              // 세션 O, accessToken X, refreshToken O
                    ssoExternalAPI.refreshJwtAccessToken(refreshToken, httpServletResponse);
                } else {                                                // 세션 O, accessToken X, refreshToken X
                    session.removeAttribute("user"); // 기존 세션 만료
                    httpServletResponse.sendRedirect(reqLogout());
                }
            }

            if (accessToken != null) {
                if(refreshToken != null) {                              // 세션 O, accessToken O, refreshToken O
                    if (validateToken(accessToken) && validateToken(refreshToken)) {
                        // 정상적 현상
                    }
                } else {                                                // 세션 O, accessToken O, refreshToken X
                    expireSessionAndLogout(httpServletRequest, httpServletResponse);
                }
            }
            filterChain.doFilter(httpServletRequest, httpServletResponse);
        }
    }


    private Key getSigningKey(String signKey) {
        byte[] keyBytes = signKey.getBytes(StandardCharsets.UTF_8);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    // Token 기간 만료 확인
    public boolean validateToken(String authToken) {
        try {
            Jwts.parserBuilder().setSigningKey(getSigningKey(utilProperties.getMaumSignKey())).build().parseClaimsJws(authToken).getBody();
            return true;
        } catch (SignatureException ex) {
            log.error("Invalid JWT signature");
        } catch (MalformedJwtException ex) {
            log.error("Invalid JWT token");
        } catch (ExpiredJwtException ex) {
            log.error("Expired JWT token");
        } catch (UnsupportedJwtException ex) {
            log.error("Unsupported JWT token");
        } catch (IllegalArgumentException ex) {
            log.error("JWT claims string is empty.");
        }
        return false;
    }

    // 로그아웃
    public String reqLogout() {
    	String lastChar = utilProperties.getDomain().substring(utilProperties.getDomain().length() - 1);
        
    	String url = utilProperties.getSsoMindslabTokenLogoutUrl();
        String params = "";
        if(lastChar.equals("/")) {
        	params = "?client_id=" + utilProperties.getSsoMindslabClientId() + "&returnUrl=" + utilProperties.getDomain() + "logout";
        }else {
        	params = "?client_id=" + utilProperties.getSsoMindslabClientId() + "&returnUrl=" + utilProperties.getDomain() + "/logout";
        }

        return url + params;
    }

    // session 만료, 쿠키 만료
    public void expireSessionAndLogout(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws IOException {

        HttpSession session = httpServletRequest.getSession(true);
        session.removeAttribute("user"); // 기존 세션 만료
        
        httpServletResponse.sendRedirect(reqLogout());
    }

    // session 설정
    public void setSessionAccessUser(String accessToken, String refreshToken, HttpServletRequest httpServletRequest) throws Exception {

        HttpSession session = httpServletRequest.getSession(true);
        
        Claims claims = Jwts.parserBuilder().setSigningKey(getSigningKey(utilProperties.getMaumSignKey())).build().parseClaimsJws(refreshToken).getBody();
        String email = claims.getSubject();
        
        Claims claimsAccess = Jwts.parserBuilder().setSigningKey(getSigningKey(utilProperties.getMaumSignKey())).build().parseClaimsJws(accessToken).getBody();
        String name = claimsAccess.get("name").toString();
        
        UserVO user = authService.getAccount(email);
        
        if(user == null) {
            authService.addMaumAiUserIfNotExist(email, name);
        }
        
        UserVO memberVo = authService.getAccount(email);
        
        SecurityContext sc = SecurityContextHolder.getContext();
        
        List<GrantedAuthority> grantedAuthorityList = new ArrayList();
        grantedAuthorityList.add(new SimpleGrantedAuthority("USER_ADMIN"));
        
        sc.setAuthentication(new AuthenticaionVO(email, "", grantedAuthorityList, memberVo));
        
        session.setAttribute("user", memberVo);
        
        session.setAttribute("username",memberVo.getUserId());
        session.setAttribute("password","");
        session.setAttribute("status", claims.get("status").toString());
        memberVo.setSessionId(RequestContextHolder.currentRequestAttributes().getSessionId());
    	authService.updateLoginDt(memberVo);
    	

        session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, sc);
    }

    // 쿠키를 통해 token 확인
    public Map<String, String> getCookie(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {

        Map<String, String> result = new HashMap<>();

        Cookie[] cookies = httpServletRequest.getCookies();
        String accessToken;
        String refreshToken;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equalsIgnoreCase("MAUM_AID")) {
                    accessToken = cookie.getValue();
                    //log.info("@ OAuth.token access_token value: {}", accessToken);

                    result.put("accessToken", accessToken);
                }
                if (cookie.getName().equalsIgnoreCase("MAUM_RID")) {
                    refreshToken = cookie.getValue();
                    //log.info("@ OAuth.token refresh_token value: {}", refreshToken);

                    result.put("refreshToken", refreshToken);
                }
            }
        } else {
            return null;
        }
        return result;
    }
}
