package ai.maum.biz.fastaicc.main.cousult.chatbotBuilder.service;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;

@Service
public interface ChatbotBuilderService {

  List<Map<String, Object>> getChatbotList(Map<String, Object> param);

  void insertBotMapping(Map<String, Object> param);

  Map<String, Object> maxChatbotCheck(Map<String, Object> param);

  Integer getMaxChat(Map<String, Object> param);

  void delBotMapping(Map<String, Object> param);

  List<Map<String, Object>> selectAccountListByNo(Map<String, Object> param);
}
