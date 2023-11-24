package ai.maum.biz.fastaicc.main.cousult.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.mapper.ConsultingMapper;
import ai.maum.biz.fastaicc.main.cousult.outbound.domain.CallHistoryVO;

@Service
public class ConsultingServiceImpl implements ConsultingService {
	@Autowired
	ConsultingMapper ConsultingMapper;

	// 상담 상단 상태바 조회 IB
	@Override
	public List<Map> getOpIbStateList(FrontMntVO frontMntVO) {
		return ConsultingMapper.getOpIbStateList(frontMntVO);
	}
	
	// 상담 상단 상태바 조회 OB total
	@Override
	public List<Map> getOpTotalObStateList(FrontMntVO frontMntVO) {
		return ConsultingMapper.getOpTotalObStateList(frontMntVO);
	}
	// 상담 상단 상태바 조회 OB user
	@Override
	public List<Map> getOpUserObStateList(FrontMntVO frontMntVO) {
		return ConsultingMapper.getOpUserObStateList(frontMntVO);
	}

	// 고객 상담내용 정보
	@Override
	public List<Map> getUserCsDtlList(Map<String, Object> map) {
		return ConsultingMapper.getUserCsDtlList(map);
	}

	// 고객 채팅정보리스트를 조회
	@Override
	public List<Map> getUserChatList(Map<String, Object> map) {
		return ConsultingMapper.getUserChatList(map);
	}

	// 고객 캠패인스코어 조회
	@Override
	public List<Map> getUserCampSList(Map<String, Object> map) {
		return ConsultingMapper.getUserCampSList(map);
	}

	// 고객정보
	@Override
	public List<Map> getUserInfoList(Map<String, Object> map) {
		return ConsultingMapper.getUserInfoList(map);
	}

	// 고객결재정보
	@Override
	public List<Map> getUserPaymentList(Map<String, Object> map) {
		return ConsultingMapper.getUserPaymentList(map);
	}

	// 고객 상담이력정보 정보(사이드 리스트 )
	@Override
	public List<Map> getCsHisList(Map<String, Object> map) {
		return ConsultingMapper.getCsHisList(map);
	}

	// 고객 채팅(탐지정보)
	@Override
	public List<Map> getCsContList(Map<String, Object> map) {
		return ConsultingMapper.getCsContList(map);
	}
	
	// 상담사 예약 정보(사이드리스트)
	@Override
	public List<Map> getRecallList(Map<String, Object> map) {
		return ConsultingMapper.getRecallList(map);
	}
	
	// 콜백 요청 리스트(사이드리스트)
	@Override
	public List<Map> getCallbackList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return ConsultingMapper.getCallbackList(map);
	}

	//고객정보 체크하기 
	@Override
	public Map<String, Object> getCheckCustTelNo(String custTelNo) {
		return ConsultingMapper.getCheckCustTelNo(custTelNo);
	}

	// userId가 속한 company에 mapping된 chatbot 정보 받아오기
	@Override
	public List<Map> getChatbotInfos(String userId) {
		return ConsultingMapper.getChatbotInfos(userId);
	}
//////////////////////////////////insert & update ////////////////////////////////////////////////////////
	// 상담내용 update
	@Override
	public int updateCallHistory(Map<String, Object> map) {
		return ConsultingMapper.updateCallHistory(map);
	}
	
	// 고객정보 update
	@Override
	public int updateCustBaseInfo(Map<String, Object> map) {
		return ConsultingMapper.updateCustBaseInfo(map);
	}
	
	// 금액정보 update
	@Override
	public int mergeCustPaymentInfo(Map<String, Object> map) {
		return ConsultingMapper.mergeCustPaymentInfo(map);
	}
	// 재통화 merg
	@Override
	public int mergeRecallHistory(Map<String, Object> map) {
		return ConsultingMapper.mergeRecallHistory(map);
	}

	// 이관merg
	@Override
	public int mergeCallTranSferHistory(Map<String, Object> map) {
		return ConsultingMapper.mergeCallTranSferHistory(map);
	}
	
	
	//상담사 상태 업데이트
	@Override
	public int updateCmOpInfo(Map<String, Object> map) {
		return ConsultingMapper.updateCmOpInfo(map);
	}

	//상담사 비밀번호 변경
	@Override
	public int updateUserPw(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return ConsultingMapper.updateUserPw(map);
	}
	
	//고객 정보 신규등록
	@Override
	public int insertCustBaseInfo(Map<String, Object> map) {
		return ConsultingMapper.insertCustBaseInfo(map);
	}
	
	//고객 결제정보 신규등록
	@Override
	public int insertCustPaymentInfo(Map<String, Object> map) {
		return ConsultingMapper.insertCustPaymentInfo(map);
	}
	//OB 고객정보 >> OB결과 & 재통화
	@Override
	public List<CallHistoryVO> getUserObResultRecall(String callId) {
		return ConsultingMapper.getUserObResultRecall(callId);
	}
	
	// agent Click 시 cm_contract에 cust_id 등록
	@Override
	public int updateCustId(Map<String, Object> map) {
		
		return ConsultingMapper.updateCustId(map);
	}
	// 채팅상담 상단바 업데이트
	@Override
	public int updateCmOpChatInfo(Map<String, Object> csDtlOpStatusMap) {
		return ConsultingMapper.updateCmOpChatInfo(csDtlOpStatusMap);
	}
	// 채팅상담 상담메모 업데이트
	@Override
	public int updateChatMemo(Map<String, Object> map) {
		return ConsultingMapper.updateChatMemo(map);
	}


	// TN_USER INFO CHECK
	@Override
	public List<Map> getPwDate(Map<String, Object> map) {
		return ConsultingMapper.getPwDate(map);
	}

	@Override
	public Map<String, Object> checkIsInbound(Map<String, Object> map) {
		return ConsultingMapper.checkIsInbound(map);
	}

	@Override
	public int updateObCustId(Map<String, Object> map) {
		
		return ConsultingMapper.updateObCustId(map);
	}

}