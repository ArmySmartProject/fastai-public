package ai.maum.biz.fastaicc.main.user.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class AuthorityVO {
    private String username;
    private String authority;
}
