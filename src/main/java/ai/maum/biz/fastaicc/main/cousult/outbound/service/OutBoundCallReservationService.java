package ai.maum.biz.fastaicc.main.cousult.outbound.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.outbound.domain.CallReservationVO;

@Service
public interface OutBoundCallReservationService {

	List<CallReservationVO> getCallReservationList(CallReservationVO callReservationVO);

	int callReservationListCount(CallReservationVO callReservationVO);

	List<CallReservationVO> getObReservationDetail(CallReservationVO callReservationVO);

	List<CallReservationVO> getObReservationCustData(CallReservationVO callReservationVO);

	List<CallReservationVO> checkObReservationValue(CallReservationVO callReservationVO);

	int insertReservationDate(Map<String, Object> insertMap);

	int insertReservationCust(Map<String, Object> insertCustData);

	int updateReservationDate(Map<String, Object> updateMap);

//	int deleteConditionCustom(String id);

	int delteReservation(Map<String, Object> deleteIdMap);

	List<CallReservationVO> getCallReservationRecordList(CallReservationVO callReservationVO);

	int callReservationRecordListCount(CallReservationVO callReservationVO);

	List<CallReservationVO> getStatusReservationInfo(CallReservationVO callReservationVO);

	int updateReservationCust(Map<String, Object> updateCustData);

	int updateReservationCustUse(String id);

	List<CallReservationVO> getReservationStatsCust(CallReservationVO callReservationVO);

	int getReservationStatsCustCount(CallReservationVO callReservationVO);

	List<CallReservationVO> getCustDataValue(CallReservationVO callReservationVO);

}
