package ai.maum.biz.fastaicc.main.cousult.autocall.service;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface AutoCallService {

  List<Map> selectAutoCallCondition(Map<String, String> map);

  void insertConditionHistory(Map<String, String> map);

  void insertAutoCallHistory(Map<String, String> map);

  List<Map> selectMsgTalkCondition(Map map);
  // OB_CALL_QUEUE INSERT
  void insertObCallQueue(Map<String, Object> map);
  // AUTO_CALL_HISTORY INSERT
  void saveAutoCallHistory(Map<String,Object> map);
}
