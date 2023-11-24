package ai.maum.biz.fastaicc.main.cousult.voiceBot.mapper;

import ai.maum.biz.fastaicc.main.cousult.common.domain.VoiceBotVO;
import ai.maum.biz.fastaicc.main.cousult.inbound.domain.SipAccountVO;
import ai.maum.biz.fastaicc.main.cousult.voiceBot.domain.ConsultantVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface VoiceBotManageMapper {

  List<VoiceBotVO> getVoiceBotList(Map<String, Object> voiceParamMap);

  List<SipAccountVO> getSipAccountList(String campaignId);

  List<ConsultantVO> getConsultantList(Map<String, Object> consultMap);

  int getConsultantCount(String companyId);

  ConsultantVO getAssignedCt(String consultantId);

  void updateAssignedCst(SipAccountVO sipAccountVO);

  List<VoiceBotVO> getUpdate(SipAccountVO sipAccountVO);

  void updateSimpleBotMapping(Map<String, Object> map);

  List<VoiceBotVO> getScenarioList(String companyId);

}
