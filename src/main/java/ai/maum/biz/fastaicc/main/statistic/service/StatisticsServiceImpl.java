package ai.maum.biz.fastaicc.main.statistic.service;

import java.lang.reflect.Array;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.util.*;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmOpInfoVO;
import ai.maum.biz.fastaicc.main.statistic.chatMapper.ChatStatisticMapper;
import ai.maum.biz.fastaicc.main.statistic.domain.StatisticVO;
import ai.maum.biz.fastaicc.main.statistic.mapper.StatisticsMapper;
@Service
public class StatisticsServiceImpl implements StatisticsService {
	@Autowired
	StatisticsMapper StatisticsMapper;
	
	@Autowired
	ChatStatisticMapper ChatStatisticMapper;

	//인바운드 콜 토탈 통계 리스트
	@Override
	public List<Map> getIbStatsTotalSList(Map<String, Object> map) {
		return StatisticsMapper.getIbStatsTotalSList(map);
	}
	//인바운드 콜 토탈카운트
	@Override
	public Map getTotalCount(Map<String, Object> map) {
		return StatisticsMapper.getTotalCount(map);
	}
	// 상담원별 통계 메인 > 소속회사 상담원 List
	@Override
	public List<CmOpInfoVO> getCompanyAdviserList(CmOpInfoVO cmOpInfoVO) {
		return StatisticsMapper.getCompanyAdviserList(cmOpInfoVO);
	}
	// 상담원별 통계 리스트
	@Override
	public List<Map> getIbStatsAdviserSList(Map<String, Object> map) {
		return StatisticsMapper.getIbStatsAdviserSList(map);
	}
	// 상담원별 통계 카운트
	@Override
	public Map getAdviserCount(Map<String, Object> map) {
		return StatisticsMapper.getAdviserCount(map);
	}	
	
	// 콜 이력 리스트
	@Override
	public List<Map> getStatsRecordSList(Map<String, Object> map) {
		return StatisticsMapper.getStatsRecordSList(map);
	}
	// 콜 이력 카운트
	@Override
	public Map getRecordCount(Map<String, Object> map) {
		return StatisticsMapper.getRecordCount(map);
	}
	
	
	// I/B콜통계-문의유형 리스트
	@Override
	public List<Map> getIbStatsTypeSList(Map<String, Object> map) {
		return StatisticsMapper.getIbStatsTypeSList(map);
	}
	// I/B콜통계-문의유형 카운트
	@Override
	public Map getIbStatsTypeCount(Map<String, Object> map) {
		return StatisticsMapper.getIbStatsTypeCount(map);
	}
	// 대시보드-companyId
	@Override
	public String getBoardCompanyId(Map<String, Object> map) {
		return StatisticsMapper.getBoardCompanyId(map);
	}
	// 대시보드-대시보드 응대현황
	@Override
	public List<Map> getBoardResCondition(Map<String, Object> map) {
		return StatisticsMapper.getBoardResCondition(map);
	}
	// 대시보드- 대시보드 상담현황
	@Override
	public List<Map> getBoardCsCondition(Map<String, Object> map) {
		return StatisticsMapper.getBoardCsCondition(map);
	}
	// 대시보드-대시보드 문의유형 현황
	@Override
	public List<Map> getBoardCsTypeCondition(Map<String, Object> map) {
		return StatisticsMapper.getBoardCsTypeCondition(map);
	}
	// 대시보드-대시보드 봇 현황
	@Override
	public List<Map> getBoardBotCondition(Map<String, Object> map) {
		return StatisticsMapper.getBoardBotCondition(map);
	}

	// 대시보드-companyName
	@Override
	public String getBoardCompanyName(Map<String, Object> map) {
		return StatisticsMapper.getBoardCompanyName(map);
	}
		
	//인바운드 대시보드 콜 통계
	@Override
	public List<Map> getIbDashBoardCallTotalList(Map<String, Object> map) {
		return StatisticsMapper.getIbDashBoardCallTotalList(map);
	}
	
	// 아웃바운드 콜 통계
	@Override
	public List<StatisticVO> getObStatsTotalList(StatisticVO statisticVO) {
		return StatisticsMapper.getObStatsTotalList(statisticVO);
	}
	
	// 아웃바운드 콜 통계 카운트
	@Override
	public int getObStatsCount(StatisticVO statisticVO) {
		return StatisticsMapper.getObStatsCount(statisticVO);
	}
	@Override
	public List<String> getCampaignIdList(StatisticVO statisticVO) {
		return StatisticsMapper.getCampaignIdList(statisticVO);
	}
	@Override
	public List<StatisticVO> getObStatsChatList(StatisticVO statisticVO) {
		return ChatStatisticMapper.getObStatsChatList(statisticVO);
	}
	@Override
	public int getObStatsChatListCount(StatisticVO statisticVO) {
		return ChatStatisticMapper.getObStatsChatListCount(statisticVO);
	}
	@Override
	public List<StatisticVO> getDetailChat(StatisticVO statisticVO) {
		return ChatStatisticMapper.getDetailChat(statisticVO);
	}
	@Override
	public List<StatisticVO> getTotalMessages(StatisticVO statisticVO) {
		return ChatStatisticMapper.getTotalMessages(statisticVO);
	}
	@Override
	public List<StatisticVO> getTotalUsers(StatisticVO statisticVO) {
		return ChatStatisticMapper.getTotalUsers(statisticVO);
	}
	@Override
	public List<StatisticVO> getWeakProb(StatisticVO statisticVO) {
		return ChatStatisticMapper.getWeakProb(statisticVO);
	}
	@Override
	public List<StatisticVO> getTotalEmail(StatisticVO statisticVO) {
		return ChatStatisticMapper.getTotalEmail(statisticVO);
	}
	@Override
	public List<StatisticVO> getTotalMsgPerHour(StatisticVO statisticVO) {
		return ChatStatisticMapper.getTotalMsgPerHour(statisticVO);
	}
	@Override
	public List<StatisticVO> getMostIntents(StatisticVO statisticVO) {
		return ChatStatisticMapper.getMostIntents(statisticVO);
	}
	@Override
	public List<StatisticVO> getMostIntentsAll(StatisticVO statisticVO) {
		return ChatStatisticMapper.getMostIntentsAll(statisticVO);
	}
	@Override
	public List<StatisticVO> getUttersFromIntent(StatisticVO statisticVO) {
		return ChatStatisticMapper.getUttersFromIntent(statisticVO);
	}
	@Override
	public List<StatisticVO> getTotalUserPerHour(StatisticVO statisticVO) {
		return ChatStatisticMapper.getTotalUserPerHour(statisticVO);
	}
	@Override
	public List<StatisticVO> getTodayUsers(StatisticVO statisticVO) {
		return ChatStatisticMapper.getTodayUsers(statisticVO);
	}
	@Override
	public List<Map> getDeviceCount(Map<String, Object> map) {
		return ChatStatisticMapper.getDeviceCount(map);
	}
	@Override
	public List<StatisticVO> getUserCountry(StatisticVO statisticVO) {
		return ChatStatisticMapper.getUserCountry(statisticVO);
	}
	@Override
	public List<StatisticVO> getChatBotList(String companyId) {
		return StatisticsMapper.getChatBotList(companyId);
	}

	@Override
	public String getColumnName(String custDataId) {
		return StatisticsMapper.getColumnName(custDataId);
	}
	@Override
	public int updateEmailInfo(Map<String, Object> map) {
		int updateCnt = 0;
		updateCnt = ChatStatisticMapper.updateEmailInfo(map);
		return updateCnt;
	}

	@Override
	public Map<String, Object> getInspectList(Map<String, Object> map) {
		return StatisticsMapper.getInspectList(map);
	}

	@Override
	public void updateInspectInfo(Map<String, Object> map) {
		StatisticsMapper.updateInspectInfo(map);
	}
	@Override
	public List<StatisticVO> getTotalUserMaxAvgPerHour(StatisticVO statisticVO) {
		return ChatStatisticMapper.getTotalUserMaxAvgPerHour(statisticVO);
	}
	@Override
	public List<StatisticVO> getWeakProbUtter(StatisticVO statisticVO) {
		return ChatStatisticMapper.getWeakProbUtter(statisticVO);
	}
	@Override
	public List<StatisticVO> getConsultMemo(StatisticVO statisticVO) {
		return StatisticsMapper.getConsultMemo(statisticVO);
	}
	@Override
	public List<StatisticVO> getConsultDialog(StatisticVO statisticVO) {
		return StatisticsMapper.getConsultDialog(statisticVO);
	}
	@Override
	public List<StatisticVO> getConsultDialogCnt(StatisticVO statisticVO) {
		return StatisticsMapper.getConsultDialogCnt(statisticVO);
	}
	@Override
	public List<StatisticVO> getConsultantNm(StatisticVO statisticVO) {
		return StatisticsMapper.getConsultantNm(statisticVO);
	}
	@Override
	public List<StatisticVO> getAccountList(StatisticVO statisticVO) {
		return ChatStatisticMapper.getAccountList(statisticVO);
	}
	@Override
	public int updateChatbotAvailable(Map<String, Object> map) {
		
		return ChatStatisticMapper.updateChatbotAvailable(map);
	}
	@Override
	public List<StatisticVO> getAllUttersFromIntent(StatisticVO statisticVO) {
		
		return ChatStatisticMapper.getAllUttersFromIntent(statisticVO);
	}
	@Override
	public List<Map> getLinkCount(Map<String, Object> linkCountMap) {
		
		return ChatStatisticMapper.getLinkCount(linkCountMap);
	}

	@Override
	public Map<String, Object> getCampaignResultCount(Map<String, Object> map) {
		return StatisticsMapper.getCampaignResultCount(map);
	}

	@Override
	public int getVoicebotCount(String campaignId) {
		return StatisticsMapper.getVoicebotCount(campaignId);
	}

	@Override
	public String getCampaignNm(String campaignId) {
		return StatisticsMapper.getCampaignNm(campaignId);
	}

	@Override
	public Map<String, Object> getVoiceSendStats(Map<String, Object> map) {
		return StatisticsMapper.getVoiceSendStats(map);
	}

	@Override
	public Map<String, Object> getVoiceCallTimeInfo(Map<String, Object> map) {
		return StatisticsMapper.getVoiceCallTimeInfo(map);
	}

	@Override
	public List<Map<String, Object>> getSendResultInfoChart(Map<String, Object> map) {
		return StatisticsMapper.getSendResultInfoChart(map);
	}
	@Override
	public List<Map<String, Object>> getCustomerAwayInfoPerTask(Map<String, Object> map) {
		List<Map<String, Object>> mapList = StatisticsMapper.getCustomerAwayInfoPerTask(map);
		Double sum = mapList.stream().map(v -> v.get("taskCount")).collect(Collectors.toList()).stream().mapToDouble(value -> Double.valueOf(value.toString())).sum();
		Double testNum = 0.0;

		for (int i = 0; i < mapList.size(); i++){
			Double taskCount = Double.parseDouble(mapList.get(i).get("taskCount").toString());
			Double customerAwayRate = sum > 0.0 ? Math.round(taskCount/sum*100) : 0.0;
			mapList.get(i).put("customerAwayRate", String.format("%.0f",customerAwayRate));
		}
		return mapList;
	}
	@Override
	public List<Map<String, Object>> getCampaignResultInfoChart(Map<String, Object> map) {
		return StatisticsMapper.getCampaignResultInfoChart(map);
	}
	@Override
	public Map<String, Object> getDateTypeAndHourMap(Map<String, Object> map) {
		SimpleDateFormat sdf = new	SimpleDateFormat("yyyy-MM-dd");
		try {
			if(!"".equals(map.get("isFormula")) && map.get("isFormula") != null){
				// x축 옵션별 format type
				if("hourly".equals(map.get("isDateType"))){
					map.put("dateFormatType", "%m-%d %H시");
				}else if("daily".equals(map.get("isDateType"))){
					map.put("dateFormatType", "%m-%d");
				}else if("weekly".equals(map.get("isDateType"))){
					map.put("dateFormatType", "%m월");
				}else if("monthly".equals(map.get("isDateType"))){
					map.put("dateFormatType", "%Y-%m");
				}else if("yearly".equals(map.get("isDateType"))){
					map.put("dateFormatType", "%Y");
				}else{
					map.put("dateFormatType", "%H시");
				}

				// 산식 옵션별 format type
				if("dailyAvg".equals(map.get("isFormula"))){
					map.put("formulaDateFormatType", "%Y-%m-%d");
				}else if("weeklyAvg".equals(map.get("isFormula"))){
					map.put("formulaDateFormatType", "%m");
				}else if("monthlyAvg".equals(map.get("isFormula"))){
					map.put("formulaDateFormatType", "%Y-%m");
				}

				if("Y".equals(map.get("isRunning")) || "N".equals(map.get("isRunning"))){
					int i = Integer.parseInt(map.get("opEndTm").toString()) - 1;
					map.put("hourlyStartH",map.get("opStartTm"));
					map.put("hourlyEndH", i > 10 ?  Integer.toString(i) : "0"+i);
				}else{
					map.put("hourlyStartH","00");
					map.put("hourlyEndH","23");
				}

				return map;
			}


			Date startDate = sdf.parse(map.get("startDt").toString());
			Date endDate = sdf.parse(map.get("endDt").toString());

			String[] lst = map.get("startDt").toString().split("-");
			int[] startDateLst = Arrays.stream(lst).mapToInt(Integer::parseInt).toArray();
			String[] lst2 = map.get("endDt").toString().split("-");
			int[] endDatelst = Arrays.stream(lst2).mapToInt(Integer::parseInt).toArray();

			LocalDate sDate = LocalDate.of(startDateLst[0], startDateLst[1], startDateLst[2]);
			LocalDate eDate = LocalDate.of(endDatelst[0], endDatelst[1], endDatelst[2]).plusDays(1);

			Period period = sDate.until(eDate);

			int diffYear = period.getYears();
			int diffMonth = period.getMonths();
			int diffDay = period.getDays();


			if(diffYear > 1 || (diffYear == 1 && diffMonth + diffDay > 0)){ // 1년 초과
				map.put("isDateType", "year");
				map.put("dateFormatType", "%Y");
			}else{
				if(diffYear == 1 || diffMonth > 3 || (diffMonth == 3 && diffDay > 0)){ // 3개월 초과 1년 이하
					map.put("isDateType", "month");
					map.put("dateFormatType", "%Y-%m");
				}else if(diffDay > 7 || diffMonth > 0){	// 1주일(7일) 초과 3개월 이하
					map.put("isDateType", "week");
					map.put("dateFormatType", "%m월");
				}else {
					if (diffDay > 1) { // 2일 이상 1주일(7일) 이하
						map.put("isDateType", "day");
						map.put("dateFormatType", "%m-%d");
					} else { // 당일
						map.put("isDateType", "hour");
						map.put("dateFormatType", "%H시");

						if("Y".equals(map.get("isRunning")) || "N".equals(map.get("isRunning"))){
							int i = Integer.parseInt(map.get("opEndTm").toString()) - 1;
							map.put("hourlyStartH",map.get("opStartTm"));
							map.put("hourlyEndH", i > 10 ?  Integer.toString(i) : "0"+i);
						}else{
							map.put("hourlyStartH","00");
							map.put("hourlyEndH","23");
						}
					}
				}

			}

		}catch (Exception e){
			e.printStackTrace();
		}

		return map;
	}

	@Override
	public List<Map<String, Object>> getDialResultInfoChart(Map<String, Object> map) {
		return StatisticsMapper.getDialResultInfoChart(map);
	}

	@Override
	public List<Map<String, Object>> getCampaignResultDetailChart(Map<String, Object> map) {
		return StatisticsMapper.getCampaignResultDetailChart(map);
	}

	@Override
	public Map<String, Object> getSendResultInfoDiff(Map<String, Object> map) {
		return StatisticsMapper.getSendResultInfoDiff(map);
	}

	@Override
	public List<Map<String, Object>> getCallResultInfoDetailChart(Map<String, Object> map) {
		return StatisticsMapper.getCallResultInfoDetailChart(map);
	}

	@Override
	public Map<String, Object> getCallResultInfoDiff(Map<String, Object> map) {
		return StatisticsMapper.getCallResultInfoDiff(map);
	}

	@Override
	public List<Map<String, Object>> getCallFailInfoDetailChart(Map<String, Object> map) {
		return StatisticsMapper.getCallFailInfoDetailChart(map);
	}

	@Override
	public List<Map<String, Object>> getSendResultInfoDetailChart(Map<String, Object> map) {
		return StatisticsMapper.getSendResultInfoDetailChart(map);
	}
	@Override
	public List<Map<String, Object>> detailPageCampaignInfoList(List<String> list) {
		return StatisticsMapper.detailPageCampaignInfoList(list);
	}
	@Override
	public Map<String, Object> getCampaignResultDetailDiff(Map<String, Object> map) {
		return StatisticsMapper.getCampaignResultDetailDiff(map);
	}
}