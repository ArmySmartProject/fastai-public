package ai.maum.biz.fastaicc.main.cousult.chatbotBuilder.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface ChatbotBuilderMapper {

  List<Map<String, Object>> getChatbotList(Map<String, Object> param);

  void insertBotMapping(Map<String, Object> param);

  Map<String, Object> maxChatbotCheck(Map<String, Object> param);

  Integer getMaxChat(Map<String, Object> param);

  void delBotMapping(Map<String, Object> param);

}
