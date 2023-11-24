package ai.maum.biz.fastaicc.main.cousult.autocall;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.main.api.controller.CallReservationApiController;
import ai.maum.biz.fastaicc.main.cousult.autocall.controller.AutoCallController;
import ai.maum.biz.fastaicc.main.cousult.autocall.domain.CallInfo;
import ai.maum.biz.fastaicc.main.cousult.autocall.domain.CustomerHistory;
import ai.maum.biz.fastaicc.main.cousult.autocall.service.BatchService;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersBuilder;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.launch.support.RunIdIncrementer;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
@Configuration
@EnableBatchProcessing
@EnableScheduling
public class AutoCallScheduler {

  @Autowired
  private JobLauncher jobLauncher;

  @Autowired
  private JobBuilderFactory jobBuilderFactory;

  @Autowired
  private StepBuilderFactory stepBuilderFactory;

  @Autowired
  private ApplicationArguments applicationArguments;

  @Autowired
  private BatchService batchService;

  @Autowired
  CustomProperties customProperties;

  @Autowired
  CallReservationApiController callReservationApiController;

  @Autowired
  AutoCallController autoCallController;

  public Job getCallTargetListJob(StringEntity msg) {
    return jobBuilderFactory.get("[Callback Job]")
        .incrementer(new RunIdIncrementer())
        .start(getCallTargetListTask(msg))
        .build();
  }

  public Step getCallTargetListTask(StringEntity msg) {
    return stepBuilderFactory.get("[Callback Task]")
        .tasklet((contribution, chunkContext) -> {
          getCallTargetExecuteJob(msg);
          return RepeatStatus.FINISHED;
        })
        .build();
  }

  public void getCallTargetExecuteJob(StringEntity msg) {
    String callUrl = "http://" + customProperties.getRestIp() + customProperties.getRestPort() + "/call/start";
    HttpClient hc = HttpClients.createDefault();
    HttpPost hp = new HttpPost(callUrl);
    try {
      hp.addHeader("Content-type", "application/json");
      hp.setEntity(msg);
      hc.execute(hp);
    } catch (Exception e) {
      //todo 오류 데이터 쌓아야함
      System.out.println(">> Error Job Execution:::");
      e.printStackTrace();
    }
  }

   /*
    getCallTargetList (YURA API client)
    req: condition ID
    res: contract IDS, campainId
   */
  public CallInfo getCallTargetList(Integer cond) {
    List<Integer> contractList = new ArrayList<Integer>();
    CallInfo result = new CallInfo(cond, -1, null);

    Map<String, Object> response = new HashMap<>();
    System.out.println("[getCallTargetList] IN : " + cond.toString());

    response = callReservationApiController.callReservationApi(cond.toString());

    ArrayList<String> contractNos = (ArrayList)response.get("contract_nos");
    for (String contractNo : contractNos) {
      contractList.add(Integer.parseInt(contractNo));
    }

    Integer camp = Integer.parseInt(String.valueOf(response.get("campaign_id")));
    result.setContractIds(contractList);
    result.setCampaignId(camp);

    System.out.println("[getCallTargetList] OUT : " + contractList.size() + " count, " + contractList);

    return result;
  }

  /*
    checkValid (원영이형 API client)
    req: contract IDS
    res: valid contract IDS
   */
  public List<Integer> checkValid(List<Integer> contractIds) {
    String validUrl = customProperties.getAutocallCheckValidUrl();
    List<Integer> contractList = new ArrayList<Integer>();
    HttpClient hc = HttpClients.createDefault();
    HttpPost hp = new HttpPost(validUrl);
    try {
      hp.addHeader("Content-type", "application/json");
      String sep = ",";
      String data = StringUtils.join(contractIds, sep);
      String msgStr = "{\"contract_nos\": [" + data + "]}";
      StringEntity msg = new StringEntity(msgStr);
      hp.setEntity(msg);

      System.out.println("[checkValid] IN   : " + msgStr);

      HttpResponse response = hc.execute(hp);
      if (response.getStatusLine().getStatusCode() == 200) {
        HttpEntity respEntity = response.getEntity();
        if (respEntity != null) {
          String content = EntityUtils.toString(respEntity, "UTF-8");
          JSONParser parser = new JSONParser();
          JSONObject jsonObj = (JSONObject) parser.parse(content);
          JSONArray arr =(JSONArray)jsonObj.get("contract_nos");
          for(int i=0;i<arr.size();i++) {
            Integer in = Integer.parseInt(String.valueOf(arr.get(i)));
            contractList.add(in);
          }
        }
      }
      System.out.println("[checkValid] API status code  : " + response.getStatusLine().getStatusCode());
      System.out.println("[checkValid] OUT  : " + contractList);
    } catch (Exception e) {
      //todo 오류 데이터 쌓아야함
      System.out.println("[checkValid] ERROR :::");
      e.printStackTrace();
    } finally {
      return contractList;
    }
  }

  @Scheduled(cron = "0 */${autocall.batch-interval-time} * * * *")
  public void scheduled() throws Exception {

    // autocall.is-execute가 true인 경우에만 실행
    if (!customProperties.getAutocallIsExecute()) {
      return;
    }

    Date date = new Date();
    String validUrl = customProperties.getAutocallCheckValidUrl();
    System.out.println("[scheduled] ====== START AUTO CALL ======");
    try {
      // 해당 시간에 해당하는 컨디션 조회
      String conditionList = batchService.getCondition(date);
      List<String> conds = Arrays.asList(conditionList.split(","));
      // 컨디션에 따라 매칭된 고객 contract 정보 가져오기
      if (!conds.isEmpty() && !conds.get(0).equals("")) {
        for (String cond : conds) {
          if (cond.equals("")) {
            continue;
          }
          Integer condId = Integer.parseInt(cond);
          List<Integer> contractList = new ArrayList<Integer>();
          List<Integer> valid_contractList = new ArrayList<Integer>();
          Integer campaign = 0;
          String[] sourceArgs = applicationArguments.getSourceArgs();
          Set<String> sourceArgs2 = applicationArguments.getOptionNames();
          if (sourceArgs.length > 1) {
            if (sourceArgs2.contains("CONTRACT") && sourceArgs2.contains("CAMPAIGN")) {
              String contract = applicationArguments.getOptionValues("CONTRACT").get(0);
              String camp = applicationArguments.getOptionValues("CAMPAIGN").get(0);
              contractList.add(Integer.parseInt(contract));
              campaign = Integer.parseInt(camp);
            }
          } else {
            CallInfo info = getCallTargetList(condId);
            campaign = info.getCampaignId();
            contractList = info.getContractIds();
          }
          // valid check
          if (!"".equals(validUrl)) {
            valid_contractList = checkValid(contractList);
          } else {
            valid_contractList = contractList;
          }

          if (!valid_contractList.isEmpty()) {
            /*
             * call-manager를 통하지 않고 다이렉트로 OB_CALL_QUEUE에 쌓는 로직을 추가해서
             * JOB 로직 부분은 주석 처리 해놨음.
             */

            /*
              JobParameters params = new JobParametersBuilder().addDate("requestDate", date)
                .toJobParameters();
            */

            int condHistoryId = batchService.saveConditionHistory(condId);
            List<CustomerHistory> historyList = new ArrayList<CustomerHistory>();
            //OB_CALL_QUEUE 테이블 INSERT 시 데이터 담을 LIST
            List obCallQueueInfoList = new ArrayList<>();

            for (Integer one : contractList) {
              CustomerHistory history = new CustomerHistory();
              // O(n^2) 의 효율로, 데이터가 많은 경우 변경이 필요할 수 있다.
              if (valid_contractList.contains(one)) {
                //OB_CALL_QUEUE 테이블 INSERT 시 필요 데이터
                Map<String, Object> obCallQueueInfoMap = new HashMap<>();
                obCallQueueInfoMap.put("contractNo", one.toString());
                obCallQueueInfoMap.put("campaignId", campaign.toString());
                obCallQueueInfoList.add(obCallQueueInfoMap);
                /*
                String msgStr = "{" +
                    "\"contractNo\":\"" + one.toString() + "\"" +
                    ",\"campaignId\":\"" + campaign.toString() + "\"}";
                StringEntity msg = new StringEntity(msgStr);
                JobParameters param = new JobParametersBuilder()
                    .addDate("requestDate", date)
                    .addString("contractNumber", one.toString())
                    .addString("callbackMessage", msgStr)
                    .toJobParameters();
                JobExecution execution = jobLauncher.run(getCallTargetListJob(msg), param);
                */

                history.setVALID_YN("Y");
              } else {
                history.setVALID_YN("N");
              }
              history.setCAMPAIGN_ID(campaign);
              history.setCD_HISTORY_ID(condHistoryId);
              history.setCONTRACT_NO(one);
              historyList.add(history);
            }
            // OB_CAlL_QUEUE TABLE에 INSERT
            autoCallController.saveAutoCallQueue(obCallQueueInfoList);
            if (condHistoryId > 0) {
              batchService.saveHistory(historyList);
            }
          }
        }
      }
      System.out.println("[scheduled] ======  END AUTO CALL  ======");
    } catch (Exception e) {
      System.out.println("[scheduled] ERROR :::");
      e.printStackTrace();
    } finally {
      System.out.println();
    }
  }
}
