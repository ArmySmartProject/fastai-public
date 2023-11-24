package ai.maum.biz.fastaicc.main.cousult.autocall.service;

import ai.maum.biz.fastaicc.main.cousult.autocall.mapper.AutoCallMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class AutoCallServiceImpl implements AutoCallService {

  @Autowired
  AutoCallMapper autoCallMapper;

  @Override
  public List<Map> selectAutoCallCondition(Map<String, String> map) {
    System.out.println("in selectAutoCallCondition");
    List<Map> result = autoCallMapper.selectAutoCallCondition(map);
    return result;
  }

  @Override
  public List<Map> selectMsgTalkCondition(Map map) {
	  System.out.println("in selectMsgTalkCondition");
	  List<Map> result = autoCallMapper.selectMsgTalkCondition(map);
	  return result;
  }

  @Override
  // OB_CALL_QUEUE INSERT
  public void insertObCallQueue(Map<String, Object> map) {
    autoCallMapper.insertObCallQueue(map);
  }

  @Override
  // AUTO_CALL_HISTORY INSERT
  public void saveAutoCallHistory(Map<String, Object> map) { autoCallMapper.saveAutoCallHistory(map);}

  @Override
  public void insertConditionHistory(Map<String, String> map) {
    autoCallMapper.insertConditionHistory(map);
  }

  @Override
  public void insertAutoCallHistory(Map<String, String> map) {
    autoCallMapper.insertAutoCallHistory(map);
  }

}
