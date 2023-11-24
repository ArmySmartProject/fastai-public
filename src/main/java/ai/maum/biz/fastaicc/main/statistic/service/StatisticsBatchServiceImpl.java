package ai.maum.biz.fastaicc.main.statistic.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.statistic.mapper.StatisticsBatchMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StatisticsBatchServiceImpl implements StatisticsBatchService {

	@Autowired
	StatisticsBatchMapper statisticsBatchMapper;


	// 콜 통계 INSERT 프로세스
	@Override
	public void insertIntoSelectStatsCallHistory(String startDateStr, String endDateStr) {

		log.info("======= BATCH process insertIntoSelectStatsCallHistory started =======");

		Map<String, String> map = new HashMap<>();

		try {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date startDate = formatter.parse(startDateStr);
			Date endDate = formatter.parse(endDateStr);

			int diffDays = (int) ((endDate.getTime() - startDate.getTime()) / (24*60*60*1000));

			if(diffDays < 0) {
				log.error("ERROR endDateStr is smaller than startDateStr.");
			} else if(diffDays > 32) {  // Mysql 더미테이블 메모리 생성한게로 일수 제한
				log.error("ERROR date differences are greater than a month.");
			} else {
				// 정상 처리
				map.put("startDt", startDateStr + " 00:00:00");
				map.put("endDt", endDateStr + " 23:59:59");
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}

		if(!map.isEmpty()) {
			int result;

			//콜 통계 종합
			result = statisticsBatchMapper.insertIntoSelectStatsCallHistoryTotal(map);
			log.debug("insertIntoSelectStatsCallHistoryTotal is called / " + result + " rows are inserted");

			// 콜 통계 상담원별
			result = statisticsBatchMapper.insertIntoSelectStatsCallHistoryOp(map);
			log.debug("insertIntoSelectStatsCallHistoryOp is called / " + result + " rows are inserted");

			// 콜 통계 문의유형별
			// 대분류
			map.put("depth", "1");
			result = statisticsBatchMapper.insertIntoSelectStatsCallHistoryConsultType(map);
			log.debug("insertIntoSelectStatsCallHistoryConsultType is called / Depth: 1 /" + result + " rows are inserted");

			// 중분류
			map.put("depth", "2");
			result = statisticsBatchMapper.insertIntoSelectStatsCallHistoryConsultType(map);
			log.debug("insertIntoSelectStatsCallHistoryConsultType is called / Depth: 2 /" + result + " rows are inserted");

			// 소분류류
			map.put("depth", "3");
			result = statisticsBatchMapper.insertIntoSelectStatsCallHistoryConsultType(map);
			log.debug("insertIntoSelectStatsCallHistoryConsultType is called / Depth: 3 /" + result + " rows are inserted");

			log.info("======= BATCH process insertIntoSelectStatsCallHistory finished =======");
		}
	}
}