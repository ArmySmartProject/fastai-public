package ai.maum.biz.fastaicc.main.cousult.common.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class CallStatusVO {
    private String callStatus;
    private int count;
}
