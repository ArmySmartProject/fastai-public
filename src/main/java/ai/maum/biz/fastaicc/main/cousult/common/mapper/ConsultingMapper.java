package ai.maum.biz.fastaicc.main.cousult.common.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.outbound.domain.CallHistoryVO;

@Repository
@Mapper
public interface ConsultingMapper {

	// 상담 상단 상태바 조회 IB
	List<Map> getOpIbStateList(FrontMntVO frontMntVO);

	// 상담 상단 상태바 조회 OB total
	List<Map> getOpTotalObStateList(FrontMntVO frontMntVO);

	// 상담 상단 상태바 조회 OB user
	List<Map> getOpUserObStateList(FrontMntVO frontMntVO);

	// 고객 채팅정보리스트를 조회
	List<Map> getUserChatList(Map<String, Object> map);

	// 고객 상담내용 정보
	List<Map> getUserCsDtlList(Map<String, Object> map);

	// 고객 캠패인스코어 조회
	List<Map> getUserCampSList(Map<String, Object> map);

	// 고객정보
	List<Map> getUserInfoList(Map<String, Object> map);

	// 고객결재정보
	List<Map> getUserPaymentList(Map<String, Object> map);

	// 고객 상담이력정보 정보(사이드 리스트 )
	List<Map> getCsHisList(Map<String, Object> map);

	// 고객 채팅(탐지정보)
	List<Map> getCsContList(Map<String, Object> map);
	
	// 상담예약 사이드 리스트
	List<Map> getRecallList(Map<String, Object> map);
	
	// 콜백요청 리스트(사이드리스트)
	List<Map> getCallbackList(Map<String, Object> map);
	
	//고객정보 체크하기 
	Map<String, Object> getCheckCustTelNo(String custTelNo);
	
	//OB 고객정보 >> OB결과 & 재통화
	List<CallHistoryVO> getUserObResultRecall(String callId);

	// userId가 속한 company에 mapping된 chatbot 정보 받아오기
	List<Map> getChatbotInfos(String userId);

//////////////////////////////////insert & update ////////////////////////////////////////////////////////
	// 고객정보 update
	int updateCustBaseInfo(Map<String, Object> map);

	// 금액정보 update
	int mergeCustPaymentInfo(Map<String, Object> map);

	// 상담내용 update
	int updateCallHistory(Map<String, Object> csDtlContMap);

	// 재통화 merge
	int mergeRecallHistory(Map<String, Object> csDtlContMap);

	// 이관merge
	int mergeCallTranSferHistory(Map<String, Object> csDtlContMap);

	// 상담사 상태 업데이트
	int updateCmOpInfo(Map<String, Object> csDtlContMap);

	//상담사 비밀번호 변경
	int updateUserPw(Map<String, Object> map);
	
	//고객 정보 신규등록
	int insertCustBaseInfo(Map<String, Object> map);
	
	//고객 결제정보 신규등록
	int insertCustPaymentInfo(Map<String, Object> map);

	// agent Click 시 cm_contract에 cust_id 등록
	int updateCustId(Map<String, Object> map);
	// 채팅상담 상단바 업데이트
	int updateCmOpChatInfo(Map<String, Object> csDtlOpStatusMap);
	// 채팅상담 상담메모 업데이트
	int updateChatMemo(Map<String, Object> map);
	
	// cm_contract에 cust_id (OB) 변경
	int updateObCustId(Map<String, Object> map);

	// TN_USER PasswordDate Check
	List<Map> getPwDate(Map<String, Object> map);

	Map<String, Object> checkIsInbound(Map<String, Object> map);
}
