package ai.maum.biz.fastaicc.main.cousult.common.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmOpInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;

public interface CustOpInfoService {
	int getMonitoringCount(FrontMntVO frontMntVO);
	List<CmContractVO> getMonitoringList(FrontMntVO frontMntVO);

	int getOpCount(FrontMntVO frontMntVO);
	List<CmOpInfoVO> getOpList(FrontMntVO frontMntVO);

	int getMonitoringCountByOp(FrontMntVO frontMntVO);
	List<CmContractVO> getMonitoringListByOp(FrontMntVO frontMntVO);

	@Transactional("transactionManager")
	boolean setOpByRandom(List<String> contractNoList);

	@Transactional("transactionManager")
	boolean setOp(List<String> contractNoList, String custOpId);

	@Transactional("transactionManager")
	boolean cancelAssign(List<String> cancelList);

}
