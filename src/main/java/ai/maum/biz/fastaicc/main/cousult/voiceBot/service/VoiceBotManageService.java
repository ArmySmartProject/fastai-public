package ai.maum.biz.fastaicc.main.cousult.voiceBot.service;

import ai.maum.biz.fastaicc.main.cousult.common.domain.VoiceBotVO;
import ai.maum.biz.fastaicc.main.cousult.inbound.domain.SipAccountVO;
import ai.maum.biz.fastaicc.main.cousult.voiceBot.domain.ConsultantVO;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;

@Service
public interface VoiceBotManageService {

  List<VoiceBotVO> getVoiceBotList(Map<String, Object> voiceParamMap);

  List<SipAccountVO> getSipAccountList(String campaignId);

  List<ConsultantVO> getConsultantList(Map<String, Object> consultMap);

  int getConsultantCount(String companyId);

  ConsultantVO getAssignedCt(String consultantId);

  void updateAssignedCst(SipAccountVO sipAccountVO);

  List<VoiceBotVO> getUpdate(SipAccountVO sipAccountVO);

  void updateAssignedScenario(Map<String, Object> map);

  List<VoiceBotVO> getScenarioList(String companyId);
}
