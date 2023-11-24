package ai.maum.biz.fastaicc.main.cousult.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCommonCdVO;
import ai.maum.biz.fastaicc.main.cousult.common.mapper.CommonMapper;

@Service
public class CommonServiceImpl implements CommonService{

	@Autowired
	CommonMapper mapper;

	public List<CmCommonCdVO> getSeachCodeList(){
		return mapper.getSeachCodeList();
	}
	

	//화면 시작시 필요 한 공통 코드
    @Override
    public List<Map> getCmmCdList(Map<String, Object> map) {
    	return mapper.getCmmCdList(map);
    }
    
	//카테고리 조회
    @Override
    public List<Map> getCustCategoryCdList(Map<String, Object> map) {
    	return mapper.getCustCategoryCdList(map);
    }
    
    
    
}
