package ai.maum.biz.fastaicc.main.cousult.voc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmSttResultDetailVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.voc.domain.HmdResultVO;
import ai.maum.biz.fastaicc.main.cousult.voc.domain.VocNegVO;

@Repository
@Mapper
public interface VocAnalysisMapper {
    //총 콜수, 불만 콜수
    VocNegVO getCallNum(FrontMntVO frontMntVO);

    //총 키워드 개수
    int getKeywordCnt(FrontMntVO frontMntVO);

    //키워드 리스트
    List<VocNegVO> getKeywordList(FrontMntVO frontMntVO);

    //키워드에 따른 총 결과 개수
    int getNegRetCnt(FrontMntVO frontMntVO);

    //키워드에 따른 결과 리스트
    List<VocNegVO> getNegRetList(FrontMntVO frontMntVO);

	// HMD 결과 카테고리 분류 카운트 조회
	List<HmdResultVO> getHmdResult(FrontMntVO frontMntVO);

	int getHmdResultCnt(FrontMntVO frontMntVO);

	List<HmdResultVO> getHmdResultDetail(FrontMntVO frontMntVO);

	int getHmdResultDetailCnt(FrontMntVO frontMntVO);

	List<CmSttResultDetailVO> getSttText(FrontMntVO frontMntVO);

	CmContractVO getAudioInfo(FrontMntVO frontMntVO);
}
