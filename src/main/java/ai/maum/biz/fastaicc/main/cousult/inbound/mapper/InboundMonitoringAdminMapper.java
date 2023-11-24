package ai.maum.biz.fastaicc.main.cousult.inbound.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;


@Repository
@Mapper
public interface InboundMonitoringAdminMapper {
		// 모니터링 하단 콜현황
		List<Map> getCallStateList(Map map);

}
