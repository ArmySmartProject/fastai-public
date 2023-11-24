package ai.maum.biz.fastaicc.main.cousult.ailvr.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import ai.maum.biz.fastaicc.main.cousult.ailvr.domain.AiIVRVO;

@Repository
@Mapper
public interface AiIVRMapper {

	List<Map> getSipAccount(Map<String, Object> paramMap);

	List<Map> getAiIVRMonitoringList(Map<String, Object> paramMap);

	int getAiIVRMonitoringCount(Map<String, Object> paramMap);

	List<Map> getIbIntentList(Map<String, Object> map);

	List<Map> getObIntentList(Map<String, Object> map);

	List<Map> getIVRBotContentsList(Map<String, Object> map);

	Map<String, Object> getCustInfoForIVR(Map<String, Object> map);

	List<AiIVRVO> getCompanyIdList(String companyId);

	List<Map> getIVRHourStatistics(Map<String, Object> map);

	List<String> getSipAccountList(Map<String, Object> map);

}
