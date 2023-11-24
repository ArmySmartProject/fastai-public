package ai.maum.biz.fastaicc.main.cousult.inbound.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@Data
public class SipAccountVO {
    private String sipDomain;
    private String sipUser;
    private String telUri;
    private String pbxName;
    private String status;
    private int contractNo;
    private String customerPhone;
    private String bootTime;
    private String lastEvent;
    private String lastEventTime;
    private String campaignId;
    private String isInbound;
    private String telNo;
    private String campaignNm;
    private String custOpId;
    private String updaterId;
    private String simplebotId;
}
