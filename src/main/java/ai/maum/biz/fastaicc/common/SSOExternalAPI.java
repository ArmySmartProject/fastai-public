package ai.maum.biz.fastaicc.common;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.*;

@Slf4j
@Component
@RequiredArgsConstructor
public class SSOExternalAPI {

//    @Value("${url.hq}")
//    String ssoURL;
//
//    @Value("${hq.tokenReqPath}")
//    private String tokenReqPath;
	
	@Value("${sso.mindslab.request.request-token.url}")
    private String ssoMindslabTokenReqUrl;

    @Value("${maum.SigningKey}")
    private String singKey;

    private Key getSigningKey(String signKey) {
        byte[] keyBytes = signKey.getBytes(StandardCharsets.UTF_8);
        return Keys.hmacShaKeyFor(keyBytes);
    }
    public void refreshJwtAccessToken(String refreshToken, HttpServletResponse httpServletResponse) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        Map<String, Object> map = new HashMap<>();
        map.put("refresh_token", refreshToken);

        HttpEntity<Map<String, Object>> httpEntity = new HttpEntity<>(map, headers);

        ResponseEntity<String> responseEntity = restTemplate.postForEntity(ssoMindslabTokenReqUrl + ":refresh", httpEntity, String.class);
        // TODO: Invalid Case, Expired Case
        String newAccessToken = responseEntity.getBody();

        // TODO: Refactoring Target
        Claims claims = Jwts.parserBuilder().setSigningKey(getSigningKey(singKey)).build().parseClaimsJws(newAccessToken).getBody();
        String email = claims.getSubject();

        List<GrantedAuthority> grantedAuthorities = new ArrayList<>();
        grantedAuthorities.add(new SimpleGrantedAuthority("ROLE_USER"));
        grantedAuthorities.add(new SimpleGrantedAuthority("ROLE_INTERNAL"));
        grantedAuthorities.add(new SimpleGrantedAuthority("ROLE_ADMIN"));

        SecurityContext securityContext = SecurityContextHolder.getContext();
        securityContext.setAuthentication(new UsernamePasswordAuthenticationToken(email, null, grantedAuthorities));

        // TODO: Refactoring Target
        // spring mvc 4.3.5에서는 Cookie객체에서 httponly를 지원하지 않고 있습니다.
        Cookie accessTokenCookie = new Cookie("MAUM_AID", newAccessToken);
        accessTokenCookie.setPath("/");
        accessTokenCookie.setDomain("maum.ai");
        accessTokenCookie.setMaxAge(-1); // TODO: browser close 때까지 유지
        httpServletResponse.addCookie(accessTokenCookie);

        // TODO: RefreshToken을 쿠키에 담는 것 추후 고려
    }
}