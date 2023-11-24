package ai.maum.biz.fastaicc.main.api.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.api.domain.CallReservationApiVO;

@Service
public interface CallReservationApiService {

	int getCampaignId(CallReservationApiVO callReservationApiVO);

	List<CallReservationApiVO> getDataValue(CallReservationApiVO callReservationApiVO);

	List<CallReservationApiVO> getDistinctDataId(CallReservationApiVO callReservationApiVO);

	List<Map<String, Object>> getCustContractNos(Map<String, Object> searchMap);

	List<CallReservationApiVO> getCustDataClassInfo(CallReservationApiVO callReservationApiVO);
	
	int getReservationCustListCount(Map<String, Object> searchMap);

}
