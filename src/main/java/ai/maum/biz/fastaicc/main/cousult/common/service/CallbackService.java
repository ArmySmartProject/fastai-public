package ai.maum.biz.fastaicc.main.cousult.common.service;


import java.util.List;

import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CallbackVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;

@Service
public interface CallbackService {

    List<CmContractVO> getCallbackTargetList();

    // callbacklist 조회
    List<CmContractVO> getCallbackList(CallbackVO callbackVO);

    // callbacklist 조회 페이징
    public int getResultMntTotalCount(CallbackVO callbackVO);

    // 콜백 취소할 체크 리스트
    public int undoCallback(CallbackVO callbackVO);

    // 콜백 지정할 체크 리스트
    public int doCallback(CallbackVO callbackVO);

    // 모니터링 대상 업로드 - 1 row 수정된 내용 저장
    public int doCallbackModifiedRow(CallbackVO callbackVO);
}
