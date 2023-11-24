package ai.maum.biz.fastaicc.main.cousult.common.domain;

import java.util.List;
import java.util.Map;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class FrontMntVO {

	/* 세션 uid, id */
	private String sessUid;						//로그인한 계정의 UID 
	private String sessId;						//로그인한 계정의 ID
	
	
	/* 페이지 상단 검색 부분 변수. 관련 파일 : /common/outboundHeaderSearch.jsp */
	private String schTopCampId;				//캠페인ID
	private String schTopMntType;				//모니터링 종류
	private String schTopOpNm;					//상담사명
	private String schTopTargetDt;				//대상일자
	private String schTopTargetYn;				//대상여부
	private String schTopFinalResult;			//최종결과
	private String schTopCallCnt;				//콜횟수
	private String schTopCustNm;				//고객명
	private String schTopCustId;				//고객관리번호
	private String schTopCustTelNo;				//전화번호
	private String schTopMemo;					//메모
	private String schTopCallState;				//콜상태
	private String schTopCallResult;			//모니터링 내용

	/* 페이지 상단 검색 부분 관련 hidden form 관련 변수. 관련 파일 : /monitoring/manualMonitoringExecution.jsp */
	private String schCampId;
	private String schMntType;
	private String schOpId;
	private String schOpIdDetail;
	private String schOpNm;
	private String schTargetDt;
	private String schTargetYn;
	private String schFinalResult;
	private String schCallCnt;
	private String schCustNm;
	private String schCustId;
	private String schCustTelNo;
	private String schMemo;
	private String schCallState;
	private String schCallResult;
	private String schAssignedYn;			//배정 여부
	private String schAssignedDt;			//배정 일자
	private String schCompanyId;


	/* 페이지 상단 검색 부분 변수. 관련 파일 : /common/callbackHeaderSearch.jsp */
	private String schCampaignId;
	private String schCallbackStatus;
	private String schCallbackDt;
	private String schTopCampaignId;
	private String schTopCallbackDt;

	/* 페이징 관련 변수. 관련 파일: /common/paging.jsp */
	private String pageInitPerPage;
	private String pageInitPerPage2;
	private String pageInitPerPage3;
	private String currentPage;
	private String currentPage2;
	private String currentPage3;
	private int startRow;
	private int startRow2;
	private int startRow3;
	private int lastRow;
	private int lastRow2;
	private int lastRow3;


	
	
	
	/* 모니터링 대상 업로드 페이지 관련 변수 */
    private String campHd1;             //현대해상 모니터링 종류1
    private String campHd2;             //현대해상 모니터링 종류2
	private String campaign_id;			//캠페인ID
	private String prod_name;			//모니터링 종류
	private String cust_op_id;			//상담사명
	private String cust_op_uid;
	private String target_dt;					//대상일자
	private String target_yn;			//부 대상여
	private String cust_nm;				//고객명
	private String cust_uid;			//고객관리번호
	private String cust_tel_no;			//전화번호
	private String assigned_yn;			//대상 여부


	// 모니터링 대상 업로드 페이지 - 1 row 수정/저장/추가 관련 변수
	private String modifyingMntType;		//모니터링 종류
	private String modifyingCustName;		//고객명
	private String modifyingCustNo;			//고객관리번호
	private String modifyingPhoneNo;		//전화번호
	private String modifyingAssignedYN;
	private String modifyingTargetDate;
	private String modifyingTargetYn;


	// 콜백 리스트 관리 화면 수정 내용
	private String modifyingCallbackDt;     //콜백날짜
	
		





	
	
	
	/* 모니터링 대상 관리 페이지 관련 변수 */

	private String contractNo;
	





	
	/* 상담사 배정 페이지 관련 변수 */
	private int perPageStart1;
	private int perPageNum1;
	private int perPageStart2;
	private int perPageNum2;
	private int perPageStart3;
	private int perPageNum3;
	private String check_campaign_id;
	private String monitorList;		//모니터링 종류
	private String counselorName;	//상담사명
	private String uploadDate;	//대상 일자
	private String yesNo;	//배정여부
	private String check_cust_nm;
	private String check_cust_uid;
	private String checked_op;
	private String call_type_code; //콜 타입 Y 인바운드 N 아웃바운드
	
	


	
	
	
	/* 수동 모니터링 실행 페이지 관련 변수 */
	private String campaignId;			//캠페인ID
	private String mntType;				//모니터링 종류
	private String custName;			//고객명
	private String custId;				//고객관리번호
	private String custOpId;			//상담원 번호
	private String custOpNm;			//상담원명
	private String custTelNo;			//전화번호
	private String targetDt;			//대상일자
	private String memo;				//메모
	private String callResult;			//통화결과
	private List<Map<String, Object>> callStatus;			//통화상태
	private String callTryCount;		//통화횟수
	private String mntContents;			//모니터링 내용
	private String campaignNm;			//캠페인 이름
	private List<Map<String, Object>> custData;				//캠페인별 컬럼 데이터
	
	private String pcnt;				//수동 팝업 윈도우 번호. 1:1번 팝업, 2:2번 팝업
	private String chk_cnt;				//선택한 체크박스 수
	private String cno;					//수동 팝업 실행시 받은 contract_no;
	private String sendMsgStr;
	private String isCall;				//전화 걸자 말지 여부

	
	



	
	
	/* 수동 모니터링 실행 페이지 관련 변수 - 팝업 설명 */
	private String ctn;					//상세보기 : 콜 시도 횟수 번호. 기본값 가장 마지막 회차.
	private String callId;				//CALL_HISTORY.call_id
	private String popMemo;				//메모
	private String popMntCont;			//모니터링 내용
	private String callbackDate;		//콜백요청 일시.

	
	



	


	
	/* 자동 모니터링 실행 페이지 관련 변수 */
	private String sum_first_cd;		//common_cd.first_cd
	private String sum_cust_op_id;		//상담사 id. session에서 가져옴.
	private String autoYN;				//자동실행 인지 아닌지.
	private String checkedChkBox;		//자동실행하고자 체크된 체크박스.
	private String checkedDetect;		//체크된 모니터링 결과
	private String checkedChkBoxLen;	//체크된 체크박스 수.





	
	
	/* 모니터링 결과 페이지 관련 변수 */
	private String mrcontractNo;			//고객 no
	private String mrcallId;				//콜 id
	private String mrcnt; 					//팝업 윈도우 번호
	private String cd_mnt_status;				//모니터링 내용
	private String cd_mnt_status_name;			//최종결과



	/* 인바운드 모니터링 페이지 관련 변수 */
	private String number;                  //call no
	private String status;                  //call status
	private String customer_phone;          //고객 번호
	private String boot_time;                  //로딩 시간
	private String last_event;              //마지막 이벤트
	private String last_event_time;            //마지막 이벤트 시간

	/* 모니터링 공통 변수 */
	private String isInbound;			// inbound 데이터 Y/N
	private String lastCallId;


	/* 정렬 관련 변수 */
	private String sortingTarget;
	private String direction;
	private String sortingTarget2;
	private String direction2;

	// voc analysis 페이지 관련 변수
	private String pageContents;
	private String lang;
	private String vocLang;

	private String category1;
	private String category2;
	private String category3;
	private String startDate;
	private String endDate;

	// negative customer management 관련 변수
	private String fromDate;
	private String toDate;
	private String keyword;
	private String speakerCode;

	//VOC analysis 페이징 관련 변수
	private int page;
	private int amount;
	private int totalCnt;

}
