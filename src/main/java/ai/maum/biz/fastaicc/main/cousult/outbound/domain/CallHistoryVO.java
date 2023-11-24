package ai.maum.biz.fastaicc.main.cousult.outbound.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class CallHistoryVO {
	private String callId;
	private String callDate;
	private String callTypeCode;
	private String callTypeNm;
	private String contractNo;
	private String startTime;
	private String endTime;
	private String duration;
	private String callStatus;
	private String campStatus;
	private String createDtm;
	private String callMemo;
	private String monitorCont;
	private String callbackDt;
	private String mntStatus;
	private String mntStatusName;
	private String dialResult;
	
	private String callStatusNm;
	private String cdMntStatus;
	private String chCallStatusNm;
	
	//재통화 (recall_history)
	private String recallTelNo;
	private String recallDate;
}
