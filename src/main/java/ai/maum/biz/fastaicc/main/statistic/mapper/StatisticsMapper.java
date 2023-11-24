package ai.maum.biz.fastaicc.main.statistic.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmOpInfoVO;
import ai.maum.biz.fastaicc.main.statistic.domain.StatisticVO;

@Repository
@Mapper
public interface StatisticsMapper {
	// 인바운드 콜 토탈 통계 리스트
	List<Map> getIbStatsTotalSList(Map<String, Object> map);

	// 인바운드 콜 토탈카운트
	Map getTotalCount(Map<String, Object> map);

	// ib, ob 콜 이력 리스트
	List<Map> getStatsRecordSList(Map<String, Object> map);

	// 콜 이력 카운트
	Map getRecordCount(Map<String, Object> map);

	// 상담원별 통계 메인 > 소속회사 상담원 List
	List<CmOpInfoVO> getCompanyAdviserList(CmOpInfoVO cmOpInfoVO);
	
	// 상담원별 통계 리스트
	List<Map> getIbStatsAdviserSList(Map<String, Object> map);

	// 상담원별 통계 카운트
	Map getAdviserCount(Map<String, Object> map);

	// I/B콜통계-문의유형 리스트
	List<Map> getIbStatsTypeSList(Map<String, Object> map);

	// I/B콜통계-문의유형 카운트
	Map getIbStatsTypeCount(Map<String, Object> map);
	
	// 대시보드-companyId
	String getBoardCompanyId(Map<String, Object> map);
	
	// 대시보드-대시보드 응대현황
	List<Map> getBoardResCondition(Map<String, Object> map);
	
	// 대시보드- 대시보드 상담현황
	List<Map> getBoardCsCondition(Map<String, Object> map);
	
	// 대시보드-대시보드 문의유형 현황
	List<Map> getBoardCsTypeCondition(Map<String, Object> map);
	
	// 대시보드-대시보드 봇 현황
	List<Map> getBoardBotCondition(Map<String, Object> map);

	// 대시보드-companyName
	String getBoardCompanyName(Map<String, Object> map);
	
	// 인바운드 대시보드 콜 통계
	List<Map> getIbDashBoardCallTotalList(Map<String, Object> map);

	// 아웃바운드 콜 통계
	List<StatisticVO> getObStatsTotalList(StatisticVO statisticVO);

	// 아웃바운드 콜 통계 카운트
	int getObStatsCount(StatisticVO statisticVO);

	List<String> getCampaignIdList(StatisticVO statisticVO);

//	List<StatisticVO> getObStatsChatList(StatisticVO statisticVO);
//
//	int getObStatsChatListCount(StatisticVO statisticVO);
//
//	List<StatisticVO> getDetailChat(StatisticVO statisticVO);

//	List<StatisticVO> getTotalMessages(StatisticVO statisticVO);
//
//	List<StatisticVO> getTotalUsers(StatisticVO statisticVO);
//
//	List<StatisticVO> getWeakProb(StatisticVO statisticVO);
//
//	List<StatisticVO> getTotalEmail(StatisticVO statisticVO);
//
//	List<StatisticVO> getTotalMsgPerHour(StatisticVO statisticVO);
//
//	List<StatisticVO> getMostIntents(StatisticVO statisticVO);
//	
//	List<StatisticVO> getMostIntentsAll(StatisticVO statisticVO);
//
//	List<StatisticVO> getUttersFromIntent(StatisticVO statisticVO);
//
//	List<StatisticVO> getTotalUserPerHour(StatisticVO statisticVO);
//
//	List<StatisticVO> getTodayUsers(StatisticVO statisticVO);
//
//	List<Map> getDeviceCount(Map<String, Object> map);
//
//	List<StatisticVO> getUserCountry(StatisticVO statisticVO);

	List<StatisticVO> getChatBotList(String companyId);

	String getColumnName(String custDataId);

	Map<String, Object> getInspectList(Map<String, Object> map);

	void updateInspectInfo(Map<String, Object> map);

	List<StatisticVO> getConsultMemo(StatisticVO statisticVO);

	List<StatisticVO> getConsultDialog(StatisticVO statisticVO);

	List<StatisticVO> getConsultDialogCnt(StatisticVO statisticVO);

	List<StatisticVO> getConsultantNm(StatisticVO statisticVO);

    int getVoicebotCount(String campaignId);

	String getCampaignNm(String campaignId);

	Map<String, Object> getVoiceSendStats(Map<String, Object> map);

	Map<String, Object> getVoiceCallTimeInfo(Map<String, Object> map);

    List<Map<String, Object>> getSendResultInfoChart(Map<String, Object> map);

	Map<String, Object> getCampaignResultCount(Map<String, Object> map);
	List<Map<String, Object>> getCustomerAwayInfoPerTask(Map<String, Object> map);
	List<Map<String, Object>> getCampaignResultInfoChart(Map<String, Object> map);

	List<Map<String, Object>> getDialResultInfoChart(Map<String, Object> map);

	List<Map<String, Object>> getSendResultInfoDetailChart(Map<String, Object> map);

	Map<String, Object> getSendResultInfoDiff(Map<String, Object> map);

    List<Map<String, Object>> getCallResultInfoDetailChart(Map<String, Object> map);

	Map<String, Object> getCallResultInfoDiff(Map<String, Object> map);

	List<Map<String, Object>> getCallFailInfoDetailChart(Map<String, Object> map);

	List<Map<String, Object>> getCampaignResultDetailChart(Map<String, Object> map);
	List<Map<String, Object>> detailPageCampaignInfoList(List<String> list);
	Map<String, Object> getCampaignResultDetailDiff(Map<String, Object> map);
}
