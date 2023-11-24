package ai.maum.biz.fastaicc.common.util;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Data
@ToString
public class HttpClientRes {

    private int statusCode;
    private String content;
}
