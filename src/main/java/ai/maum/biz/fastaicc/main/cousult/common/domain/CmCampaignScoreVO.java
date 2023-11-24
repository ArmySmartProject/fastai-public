package ai.maum.biz.fastaicc.main.cousult.common.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class CmCampaignScoreVO {
	private String seqNum;
	private String callId;
	private String contractNo;
	private String infoSeq;
	private String infoTask;
	private String taskValue;
	private String reviewComent;
}
