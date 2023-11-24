package ai.maum.biz.fastaicc.main.cousult.ailvr.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.ailvr.domain.AiIVRVO;

@Service
public interface AiIVRService {

	// SIP ACCOUNT 조회
	List<Map> getSipAccount(Map<String, Object> map);

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
