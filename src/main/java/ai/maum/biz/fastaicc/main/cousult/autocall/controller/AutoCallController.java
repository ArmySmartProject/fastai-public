package ai.maum.biz.fastaicc.main.cousult.autocall.controller;

import ai.maum.biz.fastaicc.main.cousult.autocall.service.AutoCallService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AutoCallController {

  @Autowired
  AutoCallService autoCallService;

  public Map<String, String> getCondition(String currentTime) {
    Map map = new HashMap();

    map.put("currentTime", currentTime);
    List<Map> conditionIdList = autoCallService.selectAutoCallCondition(map);

    String ids = "";
    for (Map list : conditionIdList) {
      ids += list.get("ID") + ",";
    }

    Map<String, String> out = new HashMap<>();
    out.put("RS_IDS", ids);

    return out;
  }
  
  public Map<String, String> getMsgTalkCondition(String currentTime) {
	  Map map = new HashMap();
	  
	  map.put("currentTime", currentTime);
	  List<Map> conditionIdList = autoCallService.selectMsgTalkCondition(map);
	  
	  String ids = "";
	  for (Map list : conditionIdList) {
		  ids += list.get("ID") + ",";
	  }
	  
	  Map<String, String> out = new HashMap<>();
	  out.put("RS_IDS", ids);
	  
	  return out;
  }

  public Map<String, Object> saveConditionHistory(int conditionId) {
    Map map = new HashMap();

    map.put("conditionId", conditionId);

    Map<String, Object> out = new HashMap<>();
    autoCallService.insertConditionHistory(map);
    out.put("INS_ID", map.get("historyId"));

    return out;
  }

  public Map<String, Object> saveCallHistory(int historyId, int contractNo, int campaignId, String validYn) {
    Map map = new HashMap();

    map.put("cdHistoryId", historyId);
    map.put("contractNo", contractNo);
    map.put("campaignId", campaignId);
    map.put("validYn", validYn);
    autoCallService.insertAutoCallHistory(map);

    Map<String, Object> out = new HashMap<>();

    return out;
  }
  // OB_CALL_QUEUE INSERT
  public Map<String, Object> saveAutoCallQueue (List obCallQueueInfoList){

      Map<String,Object> map = new HashMap<>();

      map.put("obCallQueueInfoList", obCallQueueInfoList);

      autoCallService.insertObCallQueue(map);

      Map<String, Object> out = new HashMap<>();

      return out;
  }
  // AUTO_CALL_HISTORY INSERT
  public Map<String, Object> saveAutoCallHistory (List autoCallHistoryList){

      Map<String,Object> map = new HashMap<>();

      map.put("autoCallHistoryList", autoCallHistoryList);

      autoCallService.saveAutoCallHistory(map);

      Map<String, Object> out = new HashMap<>();

      return out;
  }
}
