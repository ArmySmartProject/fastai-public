package ai.maum.biz.fastaicc.main.cousult.common.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class CmCampaignInfoVO {
	private String seq;
	private String campaignId;				//campaign seq
	private String campaignNm;				//campaign 이름
	private String category;			//대분류
	private String task;
	private String taskType;
	private String taskAnswer;
	private String taskInfo;			//C(choose) : 양자 선택 V(value) : 값 입력 N(nothing) : 받지 않음
	
	private String taskValue;
	private String serviceNm;		//서비스별 캠페인 리스트 조회 변수
}
