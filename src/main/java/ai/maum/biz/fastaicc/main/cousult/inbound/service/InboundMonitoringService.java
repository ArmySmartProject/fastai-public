package ai.maum.biz.fastaicc.main.cousult.inbound.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.inbound.domain.ChartVO;
import ai.maum.biz.fastaicc.main.cousult.inbound.domain.SipAccountVO;

@Service
public interface InboundMonitoringService {
	List<CmContractVO> getInboundCallMntList(FrontMntVO frontMntVO);

	int getInboundCallMntCount(FrontMntVO frontMntVO);

	CmContractVO getInboundCallMntData(FrontMntVO frontMntVO);

	List<SipAccountVO> getPhoneList(FrontMntVO frontMntVO);

	List<CmContractVO> getLatestCallList();

	int updateMemo(FrontMntVO frontMntVO);

	// 차트
	List<ChartVO> getChart4InfoList(Map map);

	

}
