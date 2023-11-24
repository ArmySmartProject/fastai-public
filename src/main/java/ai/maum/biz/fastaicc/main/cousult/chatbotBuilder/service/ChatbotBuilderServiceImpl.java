package ai.maum.biz.fastaicc.main.cousult.chatbotBuilder.service;

import ai.maum.biz.fastaicc.main.cousult.chatbotBuilder.mapper.ChatbotBuilderMapper;
import java.util.List;
import java.util.Map;

import ai.maum.biz.fastaicc.main.cousult.chatbotBuilder.chatbotMapper.ChatbotMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChatbotBuilderServiceImpl implements ChatbotBuilderService {

    @Autowired
    ChatbotBuilderMapper chatbotBuilderMapper;

    @Autowired
    ChatbotMapper chatbotBuilderMssqlMapper;

    @Override
    public List<Map<String, Object>> getChatbotList(Map<String, Object> param) {
        return chatbotBuilderMapper.getChatbotList(param);
    }

    @Override
    public void insertBotMapping(Map<String, Object> param) {
        chatbotBuilderMapper.insertBotMapping(param);
    }

    @Override
    public Map<String, Object> maxChatbotCheck(Map<String, Object> param) {
        return chatbotBuilderMapper.maxChatbotCheck(param);
    }

    @Override
    public Integer getMaxChat(Map<String, Object> param) {
        return chatbotBuilderMapper.getMaxChat(param);
    }

    @Override
    public void delBotMapping(Map<String, Object> param) {
        chatbotBuilderMapper.delBotMapping(param);
    }

    @Override
    public List<Map<String, Object>> selectAccountListByNo(Map<String, Object> param) {
        return chatbotBuilderMssqlMapper.selectAccountListByNo(param);
    }
}
