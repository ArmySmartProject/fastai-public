package ai.maum.biz.fastaicc.main.cousult.autocall.service;

import ai.maum.biz.fastaicc.main.cousult.autocall.controller.AutoCallController;
import ai.maum.biz.fastaicc.main.cousult.autocall.domain.CustomerHistory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.*;

@Component
public class BatchServiceImpl implements BatchService {

  @Autowired
  AutoCallController autoCallController;

  @Override
  public String getCondition(Date curTime) {
    String result = "";
    SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String currentTime = transFormat.format(curTime);
    try {
      Map<String, String> out = autoCallController.getCondition(currentTime);
      if (!out.isEmpty() && out.get("RS_IDS") != null) {
        result = out.getOrDefault("RS_IDS", "").toString();//RS_IDS
      }
      System.out.println("[getCondition] IN   : " + currentTime);
      System.out.println("[getCondition] OUT  : " + result);
    } catch (Exception e) {
      System.out.println("[getCondition] ERROR :: Can't get condition data => {" + e.getMessage() + "}");
    }
    return result;
  }
  
  @Override
  public String getMsgTalkCondition(Date curTime) {
	String result = "";
    SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
    String currentTime = transFormat.format(curTime);
    try {
      Map<String, String> out = autoCallController.getMsgTalkCondition(currentTime);
      if (!out.isEmpty() && out.get("RS_IDS") != null) {
        result = out.getOrDefault("RS_IDS", "").toString();//RS_IDS
      }
      System.out.println("[getMsgTalkCondition] IN   : " + currentTime);
      System.out.println("[getMsgTalkCondition] OUT  : " + result);
    } catch (Exception e) {
      System.out.println("[getMsgTalkCondition] ERROR :: Can't get condition data => {" + e.getMessage() + "}");
    }
    return result;
  }

  @Override
  public int saveConditionHistory(int conditionId) {
    int history_id = -1;
    try {
      Map<String, Object> out = autoCallController.saveConditionHistory(conditionId);
      if (!out.isEmpty()) {
        history_id = Integer.parseInt(out.getOrDefault("INS_ID", -1).toString());//INS_ID
      }
      System.out.println("[saveConditionHistory] history_id: " + history_id);
    } catch (Exception e) {
      System.out.println("[saveConditionHistory] ERROR :: Can't save condition history => {" + e.getMessage() + "}");
    }
    return history_id;
  }

  @Override
  public String saveHistory(List<CustomerHistory> customerHistory) {
    String result = "";
    try {
      if (!customerHistory.isEmpty()) {

        List autoCallHistoryList = new ArrayList();

        for (CustomerHistory cust : customerHistory) {
          //AUTO_CALL_HISTORY 한번에 INSERT
          Map<String, Object> autoCallHistoryMap = new HashMap<>();

          autoCallHistoryMap.put("cdHistoryId", cust.getCD_HISTORY_ID());
          autoCallHistoryMap.put("contractNo", cust.getCONTRACT_NO());
          autoCallHistoryMap.put("campaignId", cust.getCAMPAIGN_ID());
          autoCallHistoryMap.put("validYn", cust.getVALID_YN());

          autoCallHistoryList.add(autoCallHistoryMap);

          // 기존 AUTO_CALL_HISTORY INSERT 로직 추후 다시 필요할때를 대비에 주석처리
          // autoCallController.saveCallHistory(cust.getCD_HISTORY_ID(), cust.getCONTRACT_NO(), cust.getCAMPAIGN_ID(), cust.getVALID_YN());
        }

        autoCallController.saveAutoCallHistory(autoCallHistoryList);

        System.out.println("[saveHistory] ended");
      }
    } catch (Exception e) {
      System.out.println("[saveHistory] ERROR :: Can't save history data => {" + e.getMessage() + "}");
    }
    return result;
  }

}
