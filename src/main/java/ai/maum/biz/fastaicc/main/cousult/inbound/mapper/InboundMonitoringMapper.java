package ai.maum.biz.fastaicc.main.cousult.inbound.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.inbound.domain.ChartVO;
import ai.maum.biz.fastaicc.main.cousult.inbound.domain.SipAccountVO;

@Repository
@Mapper
public interface InboundMonitoringMapper {

	List<CmContractVO> getInboundCallMntList(FrontMntVO frontMntVO);

	int getInboundCallMntCount(FrontMntVO frontMntVO);

	CmContractVO getInboundCallMntData(FrontMntVO frontMntVO);

	List<SipAccountVO> getPhoneList(FrontMntVO frontMntVO);

	List<CmContractVO> getLatestCallList();

	int updateMemo(FrontMntVO frontMntVO);

	List<ChartVO> getChart4InfoList(Map map);

}
