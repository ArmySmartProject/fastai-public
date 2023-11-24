package ai.maum.biz.fastaicc.main.cousult.common.domain;

import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class CallbackVO {
	
	private String userId;
	private String schCampaignId;
	private String schCustNm;
	private String schCustTelNo;
	private String schCallbackStatus;
	private String schCallbackDt;
	private String callId;
	private List<String> callIdList;

	private String modifyingCallbackDt;

	private String pageInitPerPage;
	private String currentPage;
	private int startRow;
	private int lastRow;

	/* 정렬 관련 변수 */
	private String sortingTarget;
	private String direction;
}


