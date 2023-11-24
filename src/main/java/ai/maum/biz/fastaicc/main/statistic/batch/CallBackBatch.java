package ai.maum.biz.fastaicc.main.statistic.batch;

import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;

@Component
@Configuration
@EnableBatchProcessing
@EnableScheduling
public class CallBackBatch {

	
/**
 * 
    @Autowired
    private JobBuilderFactory jobBuilderFactory;

    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Autowired
    private SimpleJobLauncher jobLauncher;

    @Autowired
    CallbackService callbackService;

    @Autowired
    CustomProperties customProperties;

    // Job 을 생성하는 메소드
    public Job getCallbackTargetListJob(StringEntity msg) {
        return jobBuilderFactory.get("[Callback Job]")
                .incrementer(new RunIdIncrementer())
                .start(getCallbackTargetListTask(msg))
                .build();
    }

    // Job 에 의해 실행되는 메소드 (여러 Step 으로 순차적으로 처리할 수 있음)
    public Step getCallbackTargetListTask(StringEntity msg) {
        return stepBuilderFactory.get("[Callback Task]")
                .tasklet((contribution, chunkContext) -> {
                    getCallbackTargetExecuteJob(msg);
                    return RepeatStatus.FINISHED;
                })
                .build();
    }

    // 콜백 수행 요청 ( 전화 걸기 - 장비가 통화중이면 Queue에 누적 )
    public void getCallbackTargetExecuteJob(StringEntity msg){


        HttpClient hc = HttpClients.createDefault();

        String callMngUrl = "http://" + customProperties.getRestIp() + customProperties.getRestPort() + "/call/start";

        HttpPost hp = new HttpPost(callMngUrl);

        try {

            hp.addHeader("Content-type", "application/json");
            hp.setEntity(msg);
            hc.execute(hp);

        } catch (Exception e) {
            // TODO: 2019.07.31 - 예외처리에 대한 후처리 작성
        }


    }

    // 매 시 55분 실행되는 Cron Scheduler
    @Scheduled(cron = "0 55 * * * ?")
    public void startJob() throws Exception
    {
        List<CmContractDTO> callbackList = callbackService.getCallbackTargetList();
        if(callbackList.size() != 0) {
            for (CmContractDTO callbackItem : callbackList) {
                String msgStr = "{" +
                        "\"EventType\":\"STT\"" +
                        ",\"Event\":\"START\"" +
                        ",\"Caller\":\"" + callbackItem.getCustTelNo() + "\"" +
                        ",\"Agent\":\"\"" +
                        ",\"contractNo\":\"" + callbackItem.getContractNo() + "\"" +
                        ",\"campaignId\":\"" + callbackItem.getCampaignId() + "\"}";
                StringEntity msg = new StringEntity(msgStr);
                JobParameters param = new JobParametersBuilder()
                        .addString("contractNumber", callbackItem.getContractNo())
                        .addString("callbackMessage", msgStr)
                        .toJobParameters();
                JobExecution execution = jobLauncher.run(getCallbackTargetListJob(msg), param);
            }
        }
    }
    
**/
}
