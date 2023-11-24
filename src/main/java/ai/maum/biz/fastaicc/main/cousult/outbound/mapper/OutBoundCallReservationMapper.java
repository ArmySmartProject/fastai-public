package ai.maum.biz.fastaicc.main.cousult.outbound.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import ai.maum.biz.fastaicc.main.cousult.outbound.domain.CallReservationVO;

@Repository
@Mapper
public interface OutBoundCallReservationMapper {

	List<CallReservationVO> getCallReservationList(CallReservationVO callReservationVO);

	int callReservationListCount(CallReservationVO callReservationVO);

	List<CallReservationVO> getObReservationDetail(CallReservationVO callReservationVO);

	List<CallReservationVO> getObReservationCustData(CallReservationVO callReservationVO);

	List<CallReservationVO> checkObReservationValue(CallReservationVO callReservationVO);

	int insertReservationDate(Map<String, Object> insertMap);

	int insertReservationCust(Map<String, Object> insertCustData);

	int updateReservationDate(Map<String, Object> updateMap);

//	int deleteConditionCustom(String id);

	int deleteReservation(Map<String, Object> deleteIdMap);

	int updateReservationCust(Map<String, Object> updateCustData);
	
	List<CallReservationVO> getCallReservationRecordList(CallReservationVO callReservationVO);

	int callReservationRecordListCount(CallReservationVO callReservationVO);

	List<CallReservationVO> getStatusReservationInfo(CallReservationVO callReservationVO);

	int updateReservationCustUse(String id);

	List<CallReservationVO> getReservationStatsCust(CallReservationVO callReservationVO);

	int getReservationStatsCustCount(CallReservationVO callReservationVO);

	List<CallReservationVO> getCustDataValue(CallReservationVO callReservationVO);


}
