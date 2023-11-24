package ai.maum.biz.fastaicc.main.cousult.common.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class CmSttResultDetailVO {
	private String sttResultDetailId;
	private String sttResultId;
	private String callId;
	private String speakerCode;
	private String sentenceId;
	private String sentence;
	private String startTime;
	private String endTime;
	private String speed;
	private String silenceYn;
	private String ignored;
	private String createdDtm;
	private String updatedDtm;
	private String creatorId;
	private String updatorId;
}
