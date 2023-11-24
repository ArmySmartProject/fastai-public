package ai.maum.biz.fastaicc.main.cousult.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmOpInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;

@Repository
@Mapper
public interface CustOpInfoMapper {
	int getMonitoringCount(FrontMntVO frontMntVO);
	List<CmContractVO> getMonitoringList(FrontMntVO frontMntVO);

	int getOpCount(FrontMntVO frontMntVO);
	List<CmOpInfoVO> getOpList(FrontMntVO frontMntVO);

	int getMonitoringCountByOp(FrontMntVO frontMntVO);
	List<CmContractVO> getMonitoringListByOp(FrontMntVO frontMntVO);

	int setOpByRandom(FrontMntVO frontMntVO);
	int setAssign(FrontMntVO frontMntVO);
	int setOp(FrontMntVO frontMntVO);

	int cancelAssign(FrontMntVO frontMntVO);
	int cancelOp(FrontMntVO frontMntVO);
}
