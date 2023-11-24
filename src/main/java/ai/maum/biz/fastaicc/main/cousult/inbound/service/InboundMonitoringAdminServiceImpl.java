package ai.maum.biz.fastaicc.main.cousult.inbound.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.inbound.mapper.InboundMonitoringAdminMapper;

@Service
public class InboundMonitoringAdminServiceImpl implements InboundMonitoringAdminService {
    @Autowired
    InboundMonitoringAdminMapper inboundmonitoringAdminMapper;
	// 모니터링 하단 콜현황
	@Override
	public List<Map> getCallStateList(Map map) {
		 return inboundmonitoringAdminMapper.getCallStateList(map);
	}

}

