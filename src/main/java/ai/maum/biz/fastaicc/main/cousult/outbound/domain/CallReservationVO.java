package ai.maum.biz.fastaicc.main.cousult.outbound.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class CallReservationVO {
	//예약콜 리스트
	private int RNUM;
	private int id;
	private String startDtm;
	private String endDtm;
	private String dispatchTime;
	private String obCallStatus;
	private int callTryAccount;
	private String createDtm;
	private String creator;
	private int campaignId;
	private int progressStatus;
	private int activeStatus;
	private String useYn;
	private String weekDay;
	private String cdDesc;
	private String cdName;
	private String updater;
	private String updateDtm;
	
	//발송 대상관련 CUST_DATA_CLASS
	private int custDataClassId;
	private String displayYn;
	private String dataType;
	private String columnKor;
	private String columnEng;
	private String caseType;
	private String description;
	
	//columnDataType
	private String typeName;
	private String typeOperate;
	
	//AUTO_CALL_CONDITION_CUSTOM
	private String dataValue;
	
	//CUST_INFO
	private int custId;
	private String custNm;
	private String custTelNo;
	private String custData;
	
	private String custDataKey;
	private String custDatavalue;
	
	private String contractNo;
	
	//autoCallHistory
	private String callTime;
	private int autoCallConditionId;
	private String cdHistoryId;
	private int successCnt;
	private int failCnt;
	private int ingCall;
	private int totalCall;
	private String toDate;
	private String fromDate;
	private String autoCallCdCustomIds;
	private String callPlan;
	private String callStats;
	private String callDate;
	private String duration;
	private List<String> autoCallConditionCustomIds;
	private String callStatus;
	private String callMemo;
	private String scenarioResult;
	private String taskValue;
	
	//페이징 처리 관련
	private int page;
	private int endPageCnt;
	private int rowNum;
	private int offset;
	private int lastpage;
	
}
