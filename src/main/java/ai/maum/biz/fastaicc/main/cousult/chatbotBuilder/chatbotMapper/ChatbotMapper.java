package ai.maum.biz.fastaicc.main.cousult.chatbotBuilder.chatbotMapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface ChatbotMapper {

  List<Map<String, Object>> selectAccountListByNo(Map<String, Object> param);
}
