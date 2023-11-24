package ai.maum.biz.fastaicc.main.cousult.ailvr.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.ailvr.domain.AiIVRVO;
import ai.maum.biz.fastaicc.main.cousult.ailvr.mapper.AiIVRMapper;
import lombok.extern.java.Log;

@Log
@Service
public class AiIVRServiceImpl implements AiIVRService {
	
	@Autowired
	AiIVRMapper aiIVRMapper;
	
	@Override
	public List<AiIVRVO> getCompanyIdList(String companyId) {
		return aiIVRMapper.getCompanyIdList(companyId);
	}
	
	@Override
	public List<Map> getSipAccount(Map<String, Object> paramMap) {
		return aiIVRMapper.getSipAccount(paramMap);
	}

	@Override
	public List<Map> getAiIVRMonitoringList(Map<String, Object> paramMap) {
		return aiIVRMapper.getAiIVRMonitoringList(paramMap);
	}

	@Override
	public int getAiIVRMonitoringCount(Map<String, Object> paramMap) {
		return aiIVRMapper.getAiIVRMonitoringCount(paramMap);
	}

	@Override
	public List<Map> getIbIntentList(Map<String, Object> map) {
		return aiIVRMapper.getIbIntentList(map);
	}

	@Override
	public List<Map> getObIntentList(Map<String, Object> map) {
		return aiIVRMapper.getObIntentList(map);
	}

	@Override
	public List<Map> getIVRBotContentsList(Map<String, Object> map) {
		return aiIVRMapper.getIVRBotContentsList(map);
	}

	@Override
	public Map<String, Object> getCustInfoForIVR(Map<String, Object> map) {
		return aiIVRMapper.getCustInfoForIVR(map);
	}

	@Override
	public List<Map> getIVRHourStatistics(Map<String, Object> map) {
		return aiIVRMapper.getIVRHourStatistics(map);
	}

	@Override
	public List<String> getSipAccountList(Map<String, Object> map) {
		return aiIVRMapper.getSipAccountList(map);
	}
}
