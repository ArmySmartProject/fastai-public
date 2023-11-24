package ai.maum.biz.fastaicc.main.cousult.callrecording.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import ai.maum.biz.fastaicc.main.cousult.callrecording.domain.CallRecordVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmSttResultDetailVO;

@Repository
@Mapper
public interface CallRecordingMapper {

    List<CallRecordVO> getCallRecordSearch(CallRecordVO callRecordVO);

    int getCallRecordSearchCnt(CallRecordVO callRecordVO);

    List<CmSttResultDetailVO> getSttText(CallRecordVO callRecordVO);

    CmContractVO getAudioInfo(CallRecordVO callRecordVO);
}
