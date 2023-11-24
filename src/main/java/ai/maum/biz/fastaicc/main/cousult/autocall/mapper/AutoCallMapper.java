package ai.maum.biz.fastaicc.main.cousult.autocall.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
@Mapper
public interface AutoCallMapper {

  List<Map> selectAutoCallCondition(Map<String, String> map);

  void insertConditionHistory(Map<String, String> map);

  void insertAutoCallHistory(Map<String, String> map);

  List<Map> selectMsgTalkCondition(Map map);
  // OB_CALL_QUEUE INSERT
  void insertObCallQueue(Map<String, Object> map);
  // AUTO_CALL_HISTORY INSERT
  void saveAutoCallHistory(Map<String, Object> map);
}
