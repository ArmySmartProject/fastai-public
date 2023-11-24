package ai.maum.biz.fastaicc.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import java.util.Map;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import ai.maum.biz.fastaicc.main.user.domain.AuthenticaionVO;
import ai.maum.biz.fastaicc.main.user.domain.OAuthTokenVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import ai.maum.biz.fastaicc.main.user.service.AuthService;

@Component("authProvider")
public class AuthProvider implements AuthenticationProvider  {

    @Autowired
    AuthService authService;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    CustomProperties customProperties;

    private static LinkedHashMap<String, UserVO> loginUsers = new LinkedHashMap();
    
    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String id = authentication.getName();
        String password = authentication.getCredentials().toString();
        
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session= attr.getRequest().getSession(false);
        OAuthTokenVO token = (OAuthTokenVO) session.getAttribute("ssoToken");
        UserVO user = authService.getAccount(id);
        int nowPwError = 0;
        try{nowPwError = user.getPwError();}catch (Exception e){nowPwError = 0;}
        if(nowPwError>=customProperties.getPwErrMax()){
            return null;
        }
        Map<String, Object> pwErrorMap = new HashMap<>();
        if(user != null){
            //회사 Id 'comp007'에 가입 유형이 S 가 아닌 유저.(가입 유형 구분 > S : 통합로그인 계정, I : Fast 계정)
            if(!(user.getCompanyId().toString().equals("comp007") && user.getSbscrbTy().toString().equals("S"))){
                pwErrorMap.put("USER_ID",user.getUserId());
                if(token==null && !passwordEncoder.matches(password, user.getPassword())) {
                    try{
                        pwErrorMap.put("PW_ERROR",nowPwError + 1);
                        authService.addPwError(pwErrorMap);
                    }catch (Exception e){}
                    return null;
                }if(token!=null && !token.getEmail().equals(id)) {
                    try{
                        pwErrorMap.put("PW_ERROR",nowPwError + 1);
                        authService.addPwError(pwErrorMap);
                    }catch (Exception e){}
                    return null;
                }
                //회사 Id 'comp007'에 가입 유형이 S 인 유저.(가입 유형 구분 > S : 통합로그인 계정, I : Fast 계정)
            }else{
                if(token==null && !passwordEncoder.matches(password, user.getPassword())) {
                    return null;
                }if(token!=null && !token.getEmail().equals(id)) {
                    return null;
                }
            }
                user.setSessionId(RequestContextHolder.currentRequestAttributes().getSessionId());
                authService.updateLoginDt(user);

        } else {
        	throw new AuthenticationCredentialsNotFoundException(id);
        }

        List<GrantedAuthority> grantedAuthorityList = new ArrayList();
        grantedAuthorityList.add(new SimpleGrantedAuthority("USER_ADMIN"));
        try{
          pwErrorMap.put("PW_ERROR",0);
          authService.addPwError(pwErrorMap);
        }catch (Exception e){}
        return new AuthenticaionVO(id, password, grantedAuthorityList, user);
    }
    
    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }

}
