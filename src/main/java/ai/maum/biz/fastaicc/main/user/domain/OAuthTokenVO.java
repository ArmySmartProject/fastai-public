package ai.maum.biz.fastaicc.main.user.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Data
@ToString
public class OAuthTokenVO {

    private String access_token;
    private String refresh_token;
    private String refresh_expire_time;
    private String access_expire_time;
    private String email;
    private String name;
    private String phone;
}
