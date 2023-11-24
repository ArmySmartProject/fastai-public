package ai.maum.biz.fastaicc.main.cousult.voiceBot.service;

import ai.maum.biz.fastaicc.main.cousult.common.domain.VoiceBotVO;
import ai.maum.biz.fastaicc.main.cousult.inbound.domain.SipAccountVO;
import ai.maum.biz.fastaicc.main.cousult.voiceBot.domain.ConsultantVO;
import ai.maum.biz.fastaicc.main.cousult.voiceBot.mapper.VoiceBotManageMapper;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class VoiceBotManageServiceImpl implements VoiceBotManageService {

    @Autowired
    VoiceBotManageMapper voiceBotManageMapper;

    @Override
    public List<VoiceBotVO> getVoiceBotList(Map<String, Object> voiceParamMap) {
        return voiceBotManageMapper.getVoiceBotList(voiceParamMap);
    }

    @Override
    public List<SipAccountVO> getSipAccountList(String campaignId) {
        return voiceBotManageMapper.getSipAccountList(campaignId);
    }

    @Override
    public List<ConsultantVO> getConsultantList(Map<String, Object> consultMap) {
        return voiceBotManageMapper.getConsultantList(consultMap);
    }

    @Override
    public int getConsultantCount(String companyId) {
        return voiceBotManageMapper.getConsultantCount(companyId);
    }

    @Override
    public ConsultantVO getAssignedCt(String consultantId) {
        return voiceBotManageMapper.getAssignedCt(consultantId);
    }

    @Override
    public void updateAssignedCst(SipAccountVO sipAccountVO) {
        voiceBotManageMapper.updateAssignedCst(sipAccountVO);
    }

    @Override
    public List<VoiceBotVO> getUpdate(SipAccountVO sipAccountVO) {
        return voiceBotManageMapper.getUpdate(sipAccountVO);
    }

    @Override
    public void updateAssignedScenario(Map<String, Object> map) {
        voiceBotManageMapper.updateSimpleBotMapping(map);
    }

	@Override
	public List<VoiceBotVO> getScenarioList(String companyId) {
		return voiceBotManageMapper.getScenarioList(companyId);
	}
}
