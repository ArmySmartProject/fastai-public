package ai.maum.biz.fastaicc.main.cousult.common.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@Data
public class MntTargetMngVO {
	private int contractNo;
	private int campaignId;
	private String custUid;
	private Date assignedDt;
	private String assignedYn;
	private Date targetDt;
	private String juminNo;
	private String prodName;
	private String custNm;
	private String custTelNo;
	private String custType;
	private String custOpId;
	private int custId;
	private int callTryCount;
	private String callStatus;
	private String callResult;
	private Date callbackDt;
	private String callbackStatus;
	private String creatorId;
	private String modifierId;
	private Date createDt;
	private Date modifyDt;
	
	private Date callDate;
	private int callId;
	
}
