package ai.maum.biz.fastaicc.main.api.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.api.domain.CallReservationApiVO;
import ai.maum.biz.fastaicc.main.api.mapper.CallReservationApiMapper;

@Service
public class CallReservationApiServiceImpl implements CallReservationApiService{

	@Autowired
	CallReservationApiMapper callReservationApiMapper;

	@Override
	public int getCampaignId(CallReservationApiVO callReservationApiVO) {
		return callReservationApiMapper.getCampaignId(callReservationApiVO);
	}
	
	@Override
	public List<CallReservationApiVO> getDataValue(CallReservationApiVO callReservationApiVO) {
		
		return callReservationApiMapper.getDataValue(callReservationApiVO);
	}

	@Override
	public List<CallReservationApiVO> getDistinctDataId(CallReservationApiVO callReservationApiVO) {

		return callReservationApiMapper.getDistinctDataId(callReservationApiVO);
	}

	@Override
	public List<Map<String, Object>> getCustContractNos(Map<String, Object> searchMap) {
		
		return callReservationApiMapper.getCustContractNos(searchMap);
	}

	@Override
	public List<CallReservationApiVO> getCustDataClassInfo(CallReservationApiVO callReservationApiVO) {

		return callReservationApiMapper.getCustDataClassInfo(callReservationApiVO);
	}

	@Override
	public int getReservationCustListCount(Map<String, Object> searchMap) {
		return callReservationApiMapper.getReservationCustListCount(searchMap);
	}

}
