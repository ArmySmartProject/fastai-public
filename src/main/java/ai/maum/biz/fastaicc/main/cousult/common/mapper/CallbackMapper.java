package ai.maum.biz.fastaicc.main.cousult.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CallbackVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;

@Repository
@Mapper
public interface CallbackMapper {

    List<CmContractVO> getCallbackTargetList();

    // callbacklist 조회
    List<CmContractVO> getCallbackList(CallbackVO callbackVO);

    // callbacklist 조회 페이징
    public int getResultMntTotalCount(CallbackVO callbackVO);

    // 콜백취소할 리스트
    public int undoCallback(CallbackVO callbackVO);

    // 콜백지정할 리스트
    public int doCallback(CallbackVO callbackVO);

    // 콜백 관련 정보 수정
    public int doCallbackModifiedRow(CallbackVO callbackVO);
}
