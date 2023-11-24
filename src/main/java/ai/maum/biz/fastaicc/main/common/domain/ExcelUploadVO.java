package ai.maum.biz.fastaicc.main.common.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class ExcelUploadVO {
	private String contractNo;
	private String campaignId;
	private String custNm;
	private String custTelNo;
	private String custOpId;
	private String targetDt;
}
