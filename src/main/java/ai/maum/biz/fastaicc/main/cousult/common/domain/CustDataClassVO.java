package ai.maum.biz.fastaicc.main.cousult.common.domain;

import lombok.Data;

@Data
public class CustDataClassVO {

    private int custDataClassId;
    private int campaignId;
    private String displayYn;
    private String obCallStatus;
    private String dataType;
    private String columnKor;
    private String columnEng;
    private String caseType;
    private String description;
    private String useYn;

}
