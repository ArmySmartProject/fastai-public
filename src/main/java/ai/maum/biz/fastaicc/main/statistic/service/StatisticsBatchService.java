package ai.maum.biz.fastaicc.main.statistic.service;

import java.util.List;
import java.util.Map;

public interface StatisticsBatchService {

	// 콜 통계 INSERT 프로세스
	void insertIntoSelectStatsCallHistory(String startDateStr, String endDateStr);
}
