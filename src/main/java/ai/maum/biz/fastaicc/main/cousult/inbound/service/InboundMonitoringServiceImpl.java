package ai.maum.biz.fastaicc.main.cousult.inbound.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.inbound.domain.ChartVO;
import ai.maum.biz.fastaicc.main.cousult.inbound.domain.SipAccountVO;
import ai.maum.biz.fastaicc.main.cousult.inbound.mapper.InboundMonitoringMapper;

@Service
public class InboundMonitoringServiceImpl implements InboundMonitoringService {
    @Autowired
    InboundMonitoringMapper inboundMonitoringMapper;


    @Override
    public List<CmContractVO> getInboundCallMntList(FrontMntVO frontMntVO) {
        return inboundMonitoringMapper.getInboundCallMntList(frontMntVO);
    }

    @Override
    public int getInboundCallMntCount(FrontMntVO frontMntVO) {
        return inboundMonitoringMapper.getInboundCallMntCount(frontMntVO);
    }

    @Override
    public CmContractVO getInboundCallMntData(FrontMntVO frontMntVO) {
        return inboundMonitoringMapper.getInboundCallMntData(frontMntVO);
    }

    @Override
    public List<SipAccountVO> getPhoneList(FrontMntVO frontMntVO) {
        return inboundMonitoringMapper.getPhoneList(frontMntVO);
    }

    @Override
    public List<CmContractVO> getLatestCallList() {
        return inboundMonitoringMapper.getLatestCallList();
    }

    @Override
    public int updateMemo(FrontMntVO frontMntVO) {
        return inboundMonitoringMapper.updateMemo(frontMntVO);
    }
	@Override
	public List<ChartVO> getChart4InfoList(Map map) {
		 return inboundMonitoringMapper.getChart4InfoList(map);
	}

}

