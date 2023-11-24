package ai.maum.biz.fastaicc.main.api.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import ai.maum.biz.fastaicc.main.api.domain.CallReservationApiVO;

@Repository
@Mapper
public interface CallReservationApiMapper {

	int getCampaignId(CallReservationApiVO callReservationApiVO);

	List<CallReservationApiVO> getDataValue(CallReservationApiVO callReservationApiVO);

	List<CallReservationApiVO> getDistinctDataId(CallReservationApiVO callReservationApiVO);

	List<Map<String,Object>> getCustContractNos(Map<String, Object> searchMap);

	List<CallReservationApiVO> getCustDataClassInfo(CallReservationApiVO callReservationApiVO);

	int getReservationCustListCount(Map<String, Object> searchMap);
}
