package ai.maum.biz.fastaicc.main.cousult.common.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCommonCdVO;

@Repository
@Mapper
public interface CommonMapper {
	
	public List<CmCommonCdVO> getSeachCodeList();
	
	//화면 시작시 필요 한 공통 코드
	List<Map> getCmmCdList(Map<String, Object> map);
	
	//카테고리 조회
	List<Map> getCustCategoryCdList(Map<String, Object> map);
}
