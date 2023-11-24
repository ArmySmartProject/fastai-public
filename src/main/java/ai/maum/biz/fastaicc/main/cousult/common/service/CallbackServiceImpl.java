package ai.maum.biz.fastaicc.main.cousult.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CallbackVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.mapper.CallbackMapper;

@Service
public class CallbackServiceImpl implements CallbackService {

    @Autowired
    CallbackMapper callbackMapper;

    @Override
    public List<CmContractVO> getCallbackTargetList() {
        return callbackMapper.getCallbackTargetList();
    }

    // callbacklist 조회
    @Override
    public List<CmContractVO> getCallbackList(CallbackVO callbackVO) {
        return callbackMapper.getCallbackList(callbackVO);
    }

    // paging
    @Override
    public int getResultMntTotalCount(CallbackVO callbackVO) { return callbackMapper.getResultMntTotalCount(callbackVO); }

    // 기존 계약중 체크된 거 콜백 취소할 계약
    @Override
    public int undoCallback(CallbackVO callbackVO) {
        return callbackMapper.undoCallback(callbackVO);
    }

    // 기존 계약중 체크된 거 콜백 지정할 계약
    @Override
    public int doCallback(CallbackVO callbackVO) { return callbackMapper.doCallback(callbackVO); }

    // 콜백 관련 정보 수정
    @Override
    public int doCallbackModifiedRow(CallbackVO callbackVO) {
        return callbackMapper.doCallbackModifiedRow(callbackVO);
    }
}
