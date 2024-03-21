package ai.maum.biz.fastaicc.main.statistic.chatMapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import ai.maum.biz.fastaicc.main.statistic.domain.StatisticVO;

@Repository
@Mapper
public interface ChatStatisticMapper {
	
	List<StatisticVO> getTotalMessages(StatisticVO statisticVO);

	List<StatisticVO> getTotalUsers(StatisticVO statisticVO);

	List<StatisticVO> getWeakProb(StatisticVO statisticVO);

	List<StatisticVO> getTotalEmail(StatisticVO statisticVO);

	List<StatisticVO> getTotalMsgPerHour(StatisticVO statisticVO);

	List<StatisticVO> getMostIntents(StatisticVO statisticVO);
	
	List<StatisticVO> getMostIntentsAll(StatisticVO statisticVO);

	List<StatisticVO> getUttersFromIntent(StatisticVO statisticVO);
	
	List<StatisticVO> getAllUttersFromIntent(StatisticVO statisticVO);

	List<StatisticVO> getTotalUserPerHour(StatisticVO statisticVO);

	List<StatisticVO> getTodayUsers(StatisticVO statisticVO);

	List<Map> getDeviceCount(Map<String, Object> map);
	List<Map> getCategoryCount(Map<String, Object> map);

	List<StatisticVO> getUserCountry(StatisticVO statisticVO);
	
	List<StatisticVO> getObStatsChatList(StatisticVO statisticVO);

	int getObStatsChatListCount(StatisticVO statisticVO);

	List<StatisticVO> getDetailChat(StatisticVO statisticVO);

	int updateEmailInfo(Map<String, Object> map);

	List<StatisticVO> getTotalUserMaxAvgPerHour(StatisticVO statisticVO);

	List<StatisticVO> getWeakProbUtter(StatisticVO statisticVO);
	
	List<StatisticVO> getAccountList(StatisticVO statisticVO);
	
	int updateChatbotAvailable(Map<String, Object> map);

	List<Map> getLinkCount(Map<String, Object> linkCountMap);
	
}
