package ai.maum.biz.fastaicc.common.security;

import ai.maum.biz.fastaicc.common.util.CommonUtils;
import ai.maum.biz.fastaicc.common.util.UtilProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/sso")
public class OAuthApiCtrl {

    UtilProperties properties;

    @Autowired
    public OAuthApiCtrl(UtilProperties properties)
    {
        this.properties = properties;
    }

    @GetMapping("/properties/request")
    public ResponseEntity<Object> getSsoRequestProperties()
    {
        Map<String, String> propertiesMap = new HashMap<>();
        propertiesMap.put("maumLoginUrl", properties.getSsoMindslabMaumLoginUrl());

        return new ResponseEntity<>(propertiesMap, HttpStatus.OK);
    }
}
