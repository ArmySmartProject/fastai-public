package ai.maum.biz.fastaicc.main.statistic.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface StatisticsBatchMapper {

	// 콜 통계 종합 INSERT 프로세스
	int insertIntoSelectStatsCallHistoryTotal(Map<String, String> map);

	// 콜 통계 상담원별  INSERT 프로세스
	int insertIntoSelectStatsCallHistoryOp(Map<String, String> map);

	// 콜 통계 문의유형별  INSERT 프로세스
	int insertIntoSelectStatsCallHistoryConsultType(Map<String, String> map);

}
