package ai.maum.biz.fastaicc.main.cousult.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmOpInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.mapper.CustOpInfoMapper;

@Service
public class CustOpInfoServiceImpl implements CustOpInfoService{

	@Autowired
	CustOpInfoMapper custOpInfoMapper;

	public int getMonitoringCount(FrontMntVO frontMntVO) {
		return custOpInfoMapper.getMonitoringCount(frontMntVO);
	}

	public List<CmContractVO> getMonitoringList(FrontMntVO frontMntVO) {
		return custOpInfoMapper.getMonitoringList(frontMntVO);
	}

	public int getOpCount(FrontMntVO frontMntVO) {
		return custOpInfoMapper.getOpCount(frontMntVO);
	}

	public List<CmOpInfoVO> getOpList(FrontMntVO frontMntVO) {
		return custOpInfoMapper.getOpList(frontMntVO);
	}

	public int getMonitoringCountByOp(FrontMntVO frontMntVO) {
		return custOpInfoMapper.getMonitoringCountByOp(frontMntVO);
	}

	public List<CmContractVO> getMonitoringListByOp(FrontMntVO frontMntVO) {
		return custOpInfoMapper.getMonitoringListByOp(frontMntVO);
	}

	public boolean setOpByRandom(List<String> contractNoList) {
		FrontMntVO frontMntVO = new FrontMntVO();
		for (int i = 0; i < contractNoList.size(); i++) {
			frontMntVO.setContractNo((contractNoList.get(i)));
			int result = custOpInfoMapper.setOpByRandom(frontMntVO);
			int result2 = custOpInfoMapper.setAssign(frontMntVO);
			if(result == 0 || result2 == 0) {
				return false;
			}
		}
		return true;
	}

	public boolean setOp(List<String> contractNoList, String custOpId) {
		FrontMntVO frontMntVO = new FrontMntVO();
		for (int i = 0; i < contractNoList.size(); i++) {
			frontMntVO.setContractNo((contractNoList.get(i)));
			frontMntVO.setCustOpId(custOpId);
			int result = custOpInfoMapper.setOp(frontMntVO);
			int result2 = custOpInfoMapper.setAssign(frontMntVO);
			if(result == 0 || result2 == 0) {
				return false;
			}
		}
		return true;
	}

	public boolean cancelAssign(List<String> cancelList) {
		FrontMntVO frontMntVO = new FrontMntVO();
		for (int i = 0; i < cancelList.size(); i++) {
			frontMntVO.setContractNo((cancelList.get(i)));
			int result = custOpInfoMapper.cancelAssign(frontMntVO);
			int result2 = custOpInfoMapper.cancelOp(frontMntVO);
			if(result == 0 || result2 == 0) {
				return false;
			}
		}
		return true;
	}
}
