package ai.maum.biz.fastaicc.main.cousult.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CallStatusVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCampaignInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCampaignScoreVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmSttResultDetailVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.mapper.CommonMonitoringMapper;

@Service
public class CommonMonitoringServiceImpl implements CommonMonitoringService {

    @Autowired
    CommonMonitoringMapper commonMonitoringMapper;

    @Override
    public List<CallStatusVO> getCountOfCall(FrontMntVO frontMntVO) {
        return commonMonitoringMapper.getCountOfCall(frontMntVO);
    }

    @Override
    public String getRecentContractMemo(FrontMntVO frontMntVO) {
        return commonMonitoringMapper.getRecentContractMemo(frontMntVO);
    }

    @Override
    public List<CmCampaignInfoVO> getCallPopMonitoringResultList(FrontMntVO frontMntVO) {
        return commonMonitoringMapper.getCallPopMonitoringResultList(frontMntVO);
    }

    @Override
    public List<CmCampaignScoreVO> getScoreList(FrontMntVO frontMntVO) {
        return commonMonitoringMapper.getScoreList(frontMntVO);
    }

    @Override
    public List<CmSttResultDetailVO> getSttResultAllList(FrontMntVO frontMntVO) {
        return commonMonitoringMapper.getSttResultAllList(frontMntVO);
    }
}
