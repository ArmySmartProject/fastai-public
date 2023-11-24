package ai.maum.biz.fastaicc.main.cousult.common.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCampaignInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmOpInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.MntTargetMngVO;

@Repository
@Mapper
public interface CampaignMapper {

    List<CmCampaignInfoVO> getCampaignTaskList(int campaignId);

    List<CmCampaignInfoVO> getCampaignListByService(String serviceName);

    int createServiceMonitoring(MntTargetMngVO mntTargetMngVO);

    int insertUser(MntTargetMngVO mntTargetMngVO);

	List<CmCampaignInfoVO> getCampaignList(CmOpInfoVO cmOpInfoVO);

    List<Map<String, Object>> getVoiceStatCampaignList(CmOpInfoVO cmOpInfoVO);

    List<Map<String, Object>> getAllCampaign();
}
