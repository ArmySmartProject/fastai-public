package ai.maum.biz.fastaicc.main.user.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import java.util.List;

@Getter
@Setter
@Data
@EqualsAndHashCode(callSuper = false)
public class AuthenticaionVO extends UsernamePasswordAuthenticationToken {

    private static final long serialVersionUID = 1L;

    String username;
    UserVO user;

    public AuthenticaionVO(String username, String password, List<GrantedAuthority> grantedAuthorityList, UserVO user) {
        super(username, password, grantedAuthorityList);
        this.user = user;
        this.username = username;
    }
    
    public UserVO geUser() {
    	return user;
    }
    

}
