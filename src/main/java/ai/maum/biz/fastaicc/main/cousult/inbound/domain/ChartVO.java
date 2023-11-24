package ai.maum.biz.fastaicc.main.cousult.inbound.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.List;


@Getter
@Setter
@Data
public class ChartVO {
	// 차트
	private String CODE;					//코드
	private String CODE_NM;				//코드명
	private String NOW0;					//일자 오늘
	private String NOW1;					//일자 오늘-1
	private String NOW2;					//일자 오늘-2
	private String NOW3;					//일자 오늘-3
	private String NOW4;					//일자 오늘-4
	private String NOW5;					//일자 오늘-5
	private String NOW6;					//일자 오늘-6
	private String NOW7;					//일자 오늘-7
	
	
	
	private String STT_RESULT_DETAIL_ID;  
	private String STT_RESULT_ID;
	private String CALL_ID;
	private String SPEAKER_CODE;
	private String SENTENCE_ID;
	private String SENTENCE;
	private String START_TIME;
	private String END_TIME;
	private String IGNORED;
	private String CREATED_DTM;
}
