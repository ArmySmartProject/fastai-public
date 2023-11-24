package ai.maum.biz.fastaicc.main.cousult.common.service;

import java.util.List;
import java.util.Map;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCommonCdVO;

public interface CommonService {

	// 모니터링 페이지 상단 검색 부분 관련 변수
	public List<CmCommonCdVO> getSeachCodeList();
	//화면 시작시 필요 한 공통 코드
	List<Map> getCmmCdList(Map<String, Object> map);
	//카테고리 조회
	List<Map> getCustCategoryCdList(Map<String, Object> map);
	

}
