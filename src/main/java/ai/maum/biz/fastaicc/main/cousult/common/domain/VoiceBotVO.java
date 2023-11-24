package ai.maum.biz.fastaicc.main.cousult.common.domain;

import lombok.Data;

@Data
public class VoiceBotVO {

    private String campaignId;
    private String campaignNm;
    private String description;
    private String lang;
    private int linesCount;
    private int lineAssigned;
    private int totalConsultant;
    private String updaterId;
    private String updatedDtm;
    private String isInbound;
    private String companyId;
    private String sipUser;
    private String scenarioName;
    private String name;
    private String id;

}
