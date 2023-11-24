package ai.maum.biz.fastaicc.main.cousult.common.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import org.apache.ibatis.type.Alias;

@Getter
@Setter
@Data
public class CmCommonCdVO {
	/* 로그인 관련 변수 */
	private String idType;
	private String pwType;

	private String goPage;
	

	/* 페이지 상단 검색 부분 관련 변수 */
	private String firstCd;
	private String secondCd;
	private String thirdCd;
	private String code;
	private String cdDesc;
	private String note;

	private int creatorId;
	private int updaterId;
	private String createdDtm;
	private String updatedDtm;
}
