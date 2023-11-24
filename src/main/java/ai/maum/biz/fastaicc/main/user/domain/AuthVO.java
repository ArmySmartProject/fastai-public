package ai.maum.biz.fastaicc.main.user.domain;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class AuthVO {

    private List<String> usernameList; //for delete
    private int userId;
    private String username;
    private String name;
    private String password;
    private String newPassword;        //for update password
    private boolean isAccountNonExpired;
    private boolean isAccountNonLocked;
    private boolean isCredentialsNonExpired;
    private boolean isEnabled;
    private Collection<? extends GrantedAuthority> authorities;
    private String targetDt;           //created_date
    private List<String> checkedList;
    private List<String> delAuthList;
    private List<String> accountCheckedList;
}
