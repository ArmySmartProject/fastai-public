package ai.maum.biz.fastaicc.main.statistic.domain;

import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class StatisticVO {
	private String toDate;
	private String fromDate;
	private String campaignId;
	private String minuteUnit;
	private String companyId;
	private String custOpId;
	
	private String startDate;
	private String startTime;
	private String campaignNm;
	private String callTotal;
	private String callAi;
	private String callAgent;
	private String callStop;
	private String callNoresp;
	private String avgDuration;
	private String sortOrder;
	private String timeSortOrder;
	private String etc;
	private String giveUp;
	
	private int page;
	private int endPageCnt;
	private int rowNum;
	private int offset;
	private int lastpage;
	
	private List<String> campaignIdList;
	
	//채팅삼담 이력조회
	private String category;
	private String userFeedback;
	private String utter;
	private String intent;
	private String createDate;
	private String session;
	private String channel;
	private String prevIntentUtter;
	private String answer;
	private String chatbotNm;
	private String counselType;
	private String consultant;
	private String custNm;
	private String botCsrCnt;
	private String daily;
	private String dailyChk;
	private String endDate;
	private String botId;
	private String Name;
	private String No;
	private String searchTime;
	private String sessionId;
	private int botChatCnt;
	private int totalChatCnt;
	private int minChatCnt;
	private int maxChatCnt;
	
	private String chatSessionLogId;
	private String userId;
	private String isSupporter;
	private String inputTime;
	private String inputType;
	private int consultantCnt;
	
	private String serviceType;
	private String roomId;
	private String supporterId;
	private String status;
	private String grade;
	private String gradeComment;
	private String supporterComment;
	private String startDtm;
	private String endDtm;

	private List<String> botIdArr;
	private List<String> categoryArr;
	private List<String> channelArr;

	//그룹 정렬
	private String groupSortOrder;
	
	private int id;
	private int host;
	private int lang;
	private float prob;
	private int totalCount;
	private int RNUM;
	private int hour;
	private int count;
	
}
