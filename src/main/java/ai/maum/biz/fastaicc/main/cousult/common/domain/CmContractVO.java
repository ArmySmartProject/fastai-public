package ai.maum.biz.fastaicc.main.cousult.common.domain;

import java.util.List;

import ai.maum.biz.fastaicc.main.cousult.outbound.domain.CallHistoryVO;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class CmContractVO {
	// 테이블 기본 컬럼
	private String contractNo;
	private String campaignId;
	private String custId;
	private String telNo;
	private String custOpId;
	private String prodId;
	private Integer callTryCount;
	private String lastCallId;
	private String isInbound;
	private String creatorId;
	private String updaterId;
	private String createdDtm;
	private String updatedDtm;
	private String custType;
	private String UseYn;

	// 모니터링 조회 결과 컬럼
	private String campaignNm;
	private String custNm;
	private String targetDt;
	private String targetYn;
	private String assignedDt;
	private String assignedYn;
	private String custOpNm;
	private String callDate;
	private String callStatus;
	private String callStatusNm;
	private String callStatusNmEng;
	private String mntStatus;
	private String mntStatusName;
	private String callMemo;
	private String callId;
	private List<CallHistoryVO> callHistVO;
	private String custData;
	private List<String> custDataList;

	// OB 팝업 조회 결과 컬럼
	private String prodNm;
	private String juminNo;

	//최종결과
	private String finalResult;

	// IB 조회 결과 컬럼
	private String loanPrice;
	private String bankAccNum;
	private String bankPaymentDay;
	private String duration;

	//콜백관리
	private String callbackYn;
	private String callbackDt;
	private String custTelNo;

	private String audioUrl;

	// CUST_BASE_INFO, CUST_INFO 중 가장 큰 id값
	private int maxId;
}
