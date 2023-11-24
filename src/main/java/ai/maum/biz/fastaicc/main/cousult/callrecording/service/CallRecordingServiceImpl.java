package ai.maum.biz.fastaicc.main.cousult.callrecording.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.callrecording.domain.CallRecordVO;
import ai.maum.biz.fastaicc.main.cousult.callrecording.mapper.CallRecordingMapper;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmSttResultDetailVO;
import lombok.extern.java.Log;

@Log
@Service
public class CallRecordingServiceImpl implements CallRecordingService {

    @Autowired
    CallRecordingMapper callRecordingMapper;


    @Override
    public List<CallRecordVO> getCallRecordSearch(CallRecordVO callRecordVO) {
        return callRecordingMapper.getCallRecordSearch(callRecordVO);
    }

    @Override
    public int getCallRecordSearchCnt(CallRecordVO callRecordVO) {
        return callRecordingMapper.getCallRecordSearchCnt(callRecordVO);
    }

    @Override
    public List<CmSttResultDetailVO> getSttText(CallRecordVO callRecordVO) {
        return callRecordingMapper.getSttText(callRecordVO);
    }

    @Override
    public CmContractVO getAudioInfo(CallRecordVO callRecordVO) {
        return callRecordingMapper.getAudioInfo(callRecordVO);
    }
}
