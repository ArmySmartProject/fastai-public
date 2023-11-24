package ai.maum.biz.fastaicc.main.cousult.common.service;

import java.util.List;

import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CallStatusVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCampaignInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCampaignScoreVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmSttResultDetailVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;

@Service
public interface CommonMonitoringService {
    List<CallStatusVO> getCountOfCall(FrontMntVO frontMntVO);

    String getRecentContractMemo(FrontMntVO frontMntVO);

    List<CmCampaignInfoVO> getCallPopMonitoringResultList(FrontMntVO frontMntVO);

    List<CmCampaignScoreVO> getScoreList(FrontMntVO frontMntVO);

    List<CmSttResultDetailVO> getSttResultAllList(FrontMntVO frontMntVO);

}
