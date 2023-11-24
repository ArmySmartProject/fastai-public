package ai.maum.biz.fastaicc.main.cousult.common.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class CmOpInfoVO {
	private String custOpId;
	private String custOpNm;
	private String password;
	private String idAddr;
	private String deptCd;
	private String positionCd;
	private String custOpStatus;
	private String useYn;
	private String creatorId;
	private String updaterId;
	private String createdDtm;
	private String updatedDtm;
	private String companyId;
	private String campaignNm;
	private String userAuthTy;
	private String isInbound;

	private String count;
	private String custOpStatusNm;

}
