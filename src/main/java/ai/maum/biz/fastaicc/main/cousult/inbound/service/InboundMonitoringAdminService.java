package ai.maum.biz.fastaicc.main.cousult.inbound.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public interface InboundMonitoringAdminService {

	// 모니터링 하단 콜현황
	List<Map> getCallStateList(Map map);
	

}
