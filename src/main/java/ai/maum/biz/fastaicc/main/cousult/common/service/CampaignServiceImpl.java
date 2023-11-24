package ai.maum.biz.fastaicc.main.cousult.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCampaignInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmOpInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.MntTargetMngVO;
import ai.maum.biz.fastaicc.main.cousult.common.mapper.CampaignMapper;

@Service
public class CampaignServiceImpl implements CampaignService {

    @Autowired
    CampaignMapper campaignMapper;

    @Override
    public List<CmCampaignInfoVO> getCampaignTaskList(int campaignId) {
        return campaignMapper.getCampaignTaskList(campaignId);
    }

    @Override
    public List<CmCampaignInfoVO> getCampaignListByService(String serviceName) {
        return campaignMapper.getCampaignListByService(serviceName);
    }

    @Override
    public int createServiceMonitoring(MntTargetMngVO mntTargetMngVO) {
        int custId = campaignMapper.insertUser(mntTargetMngVO);

        mntTargetMngVO.setCustId(custId);

        return campaignMapper.createServiceMonitoring(mntTargetMngVO);
    }

	@Override
	public List<CmCampaignInfoVO> getCampaignList(CmOpInfoVO cmOpInfoVO) {
		return campaignMapper.getCampaignList(cmOpInfoVO);
	}

    @Override
    public List<Map<String, Object>> getVoiceStatCampaignList(CmOpInfoVO cmOpInfoVO) {
        return campaignMapper.getVoiceStatCampaignList(cmOpInfoVO);
    }

    @Override
    public List<Map<String, Object>> getAllCampaign() {
        return campaignMapper.getAllCampaign();
    }
}
