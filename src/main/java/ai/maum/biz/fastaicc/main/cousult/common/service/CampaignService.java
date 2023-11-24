package ai.maum.biz.fastaicc.main.cousult.common.service;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCampaignInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmOpInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.MntTargetMngVO;

@Service
public interface CampaignService {

    List<CmCampaignInfoVO> getCampaignTaskList(int campaignId);

    List<CmCampaignInfoVO> getCampaignListByService(String serviceName);

    @Transactional("transactionManager")
    int createServiceMonitoring(MntTargetMngVO mntTargetMngVO);

	List<CmCampaignInfoVO> getCampaignList(CmOpInfoVO cmOpInfoVO);

    List<Map<String, Object>> getVoiceStatCampaignList(CmOpInfoVO cmOpInfoVO);

    List<Map<String, Object>> getAllCampaign();
}
