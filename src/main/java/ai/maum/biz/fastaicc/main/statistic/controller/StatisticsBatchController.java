package ai.maum.biz.fastaicc.main.statistic.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import ai.maum.biz.fastaicc.main.statistic.service.StatisticsBatchService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class StatisticsBatchController {

    /*통계 BATCH 서비스     */
    @Autowired
    StatisticsBatchService statisticsBatchService;

	/***
	 * 수동 통계 Batch 적용 API
	 *
	 * @param startDateStr
	 * @param endDateStr
	 * @return
	 */
	@RequestMapping(value = "/statsManualBatchApply", method = { RequestMethod.GET, RequestMethod.POST })
	public String statsManualBatchApply(
			@RequestParam(name = "startDateStr", required = true) String startDateStr
			, @RequestParam(name = "endDateStr", required = true) String endDateStr
	) {
		log.info("========method: statsManualBatchApply is called ===========");
		log.debug("params/ startDateStr ==== " + startDateStr);
		log.debug("params/ endDateStr ==== " + endDateStr);

		if(this.validateDateString(startDateStr) && this.validateDateString(endDateStr)) {		// parameter validation

			statisticsBatchService.insertIntoSelectStatsCallHistory(startDateStr, endDateStr);
		} else {
			log.error("========statsManualBatchApply parameters not in dateformat 'yyyy-MM-dd' ===========");
			log.error("No Batch process is called");
		}

		return null;
	}

	private boolean validateDateString(String dateString) {
		try {
			SimpleDateFormat  dateFormat = new  SimpleDateFormat("yyyy-MM-dd");

			dateFormat.setLenient(false);
			dateFormat.parse(dateString);
			return  true;
		} catch (ParseException e) {
			return false;
		}
	}
}