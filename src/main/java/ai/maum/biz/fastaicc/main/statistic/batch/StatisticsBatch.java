package ai.maum.biz.fastaicc.main.statistic.batch;

import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@Configuration
@EnableBatchProcessing
@EnableScheduling
public class StatisticsBatch {
///**
//    @Autowired
//    StatisticsBatchService statisticsBatchService;
//
//    // 매일 새벽 1시에 통계 Batch 적용
//    @Scheduled(cron = "0 0 1 * * ?")
////    @Scheduled(fixedDelay = 5 * 60 * 1000)  // TEST CODE
//    public void startJob() throws Exception {
//        Date now = new Date();
//        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//        log.info("=============== Statistics Batch is called =============");
//        log.info("=============== BATCH started At : " + now + " =============");
//        Calendar cal = new GregorianCalendar(Locale.KOREA);
//        cal.setTime(now);
//        cal.add(Calendar.DATE, -1);
//        String startDateStr = formatter.format(cal.getTime());
//        String endDateStr = formatter.format(cal.getTime());
//        log.debug("params/ startDateStr ==== " + startDateStr);
//        log.debug("params/ endDateStr ==== " + endDateStr);
//
//        statisticsBatchService.insertIntoSelectStatsCallHistory(startDateStr, endDateStr);
//    }
//**/
}
