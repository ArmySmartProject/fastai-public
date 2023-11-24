package ai.maum.biz.fastaicc.main.cousult.callrecording.service;

import java.util.List;

import ai.maum.biz.fastaicc.main.cousult.callrecording.domain.CallRecordVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmSttResultDetailVO;

public interface CallRecordingService {

    List<CallRecordVO> getCallRecordSearch(CallRecordVO callRecordVO);

    int getCallRecordSearchCnt(CallRecordVO callRecordVO);

    List<CmSttResultDetailVO> getSttText(CallRecordVO callRecordVO);

    CmContractVO getAudioInfo(CallRecordVO callRecordVO);
}
