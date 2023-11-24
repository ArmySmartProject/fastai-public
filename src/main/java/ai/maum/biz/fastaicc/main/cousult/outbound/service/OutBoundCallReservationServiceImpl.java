package ai.maum.biz.fastaicc.main.cousult.outbound.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.outbound.domain.CallReservationVO;
import ai.maum.biz.fastaicc.main.cousult.outbound.mapper.OutBoundCallReservationMapper;

@Service
public class OutBoundCallReservationServiceImpl implements OutBoundCallReservationService{
	
	@Autowired
	OutBoundCallReservationMapper outBoundCallReservationMapper;
	
	
	@Override
	public List<CallReservationVO> getCallReservationList(CallReservationVO callReservationVO) {
		
		return outBoundCallReservationMapper.getCallReservationList(callReservationVO);
	}


	@Override
	public int callReservationListCount(CallReservationVO callReservationVO) {
		
		return outBoundCallReservationMapper.callReservationListCount(callReservationVO);
	}


	@Override
	public List<CallReservationVO> getObReservationDetail(CallReservationVO callReservationVO) {
		
		return outBoundCallReservationMapper.getObReservationDetail(callReservationVO);
	}


	@Override
	public List<CallReservationVO> getObReservationCustData(CallReservationVO callReservationVO) {

		return outBoundCallReservationMapper.getObReservationCustData(callReservationVO);
	}


	@Override
	public List<CallReservationVO> checkObReservationValue(CallReservationVO callReservationVO) {
		
		return outBoundCallReservationMapper.checkObReservationValue(callReservationVO);
	}


	@Override
	public int insertReservationDate(Map<String, Object> insertMap) {
		
		return outBoundCallReservationMapper.insertReservationDate(insertMap);
	}


	@Override
	public int insertReservationCust(Map<String, Object> insertCustData) {
		
		return outBoundCallReservationMapper.insertReservationCust(insertCustData);
	}


	@Override
	public int updateReservationDate(Map<String, Object> updateMap) {
		
		return outBoundCallReservationMapper.updateReservationDate(updateMap);
	}


//	@Override
//	public int deleteConditionCustom(String id) {
//		
//		return outBoundCallReservationMapper.deleteConditionCustom(id);
//	}
	
	@Override
	public int updateReservationCust(Map<String, Object> updateCustData) {
		
		return outBoundCallReservationMapper.updateReservationCust(updateCustData);
	}


	@Override
	public int delteReservation(Map<String, Object> deleteIdMap) {
		
		return outBoundCallReservationMapper.deleteReservation(deleteIdMap);
	}


	@Override
	public List<CallReservationVO> getCallReservationRecordList(CallReservationVO callReservationVO) {
		
		return outBoundCallReservationMapper.getCallReservationRecordList(callReservationVO);
	}


	@Override
	public int callReservationRecordListCount(CallReservationVO callReservationVO) {
		
		return outBoundCallReservationMapper.callReservationRecordListCount(callReservationVO);
	}


	@Override
	public List<CallReservationVO> getStatusReservationInfo(CallReservationVO callReservationVO) {
		
		return outBoundCallReservationMapper.getStatusReservationInfo(callReservationVO);
	}


	@Override
	public int updateReservationCustUse(String id) {
		
		return outBoundCallReservationMapper.updateReservationCustUse(id);
	}


	@Override
	public List<CallReservationVO> getReservationStatsCust(CallReservationVO callReservationVO) {
		
		return outBoundCallReservationMapper.getReservationStatsCust(callReservationVO);
	}


	@Override
	public int getReservationStatsCustCount(CallReservationVO callReservationVO) {
		
		return outBoundCallReservationMapper.getReservationStatsCustCount(callReservationVO);
	}


	@Override
	public List<CallReservationVO> getCustDataValue(CallReservationVO callReservationVO) {
		
		return outBoundCallReservationMapper.getCustDataValue(callReservationVO);
	}

}
