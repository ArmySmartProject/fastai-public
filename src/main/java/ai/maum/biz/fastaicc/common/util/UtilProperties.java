package ai.maum.biz.fastaicc.common.util;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Getter
@Service
public class UtilProperties {

    @Value("${sso.mindslab.request.authorize.url}")
    private String ssoMindslabAuthorizeReqUrl;

    @Value("${sso.mindslab.request.request-token.url}")
    private String ssoMindslabTokenReqUrl;

    @Value("${sso.mindslab.request.logout-token.url}")
    private String ssoMindslabTokenLogoutUrl;

    @Value("${sso.mindslab.callback.token.url}")
    private String ssoMindslabCallbackTokenUrl;

    @Value("${sso.mindslab.client-id}")
    private String ssoMindslabClientId;

    @Value("${sso.mindslab.request.maum-login.url}")
    private String ssoMindslabMaumLoginUrl;

    @Value("${sso.mindslab.companyId}")
    private String companyId;

    @Value("${sso.mindslab.companyGroupId}")
    private String companyGroupId;
    
    @Value("${domain}")
    private String domain;
    
    @Value("${maum.SigningKey}")
    private String maumSignKey;
}
