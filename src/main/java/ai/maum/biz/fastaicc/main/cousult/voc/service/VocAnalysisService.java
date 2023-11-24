package ai.maum.biz.fastaicc.main.cousult.voc.service;

import java.util.List;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmSttResultDetailVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.voc.domain.HmdResultVO;
import ai.maum.biz.fastaicc.main.cousult.voc.domain.VocNegVO;


public interface VocAnalysisService {

    List<HmdResultVO> getHmdResult(FrontMntVO frontMntVO);

    int getHmdResultCnt(FrontMntVO frontMntVO);

    List<HmdResultVO> getHmdResultDetail(FrontMntVO frontMntVO);

    int getHmdResultDetailCnt(FrontMntVO frontMntVO);

    List<CmSttResultDetailVO> getSttText(FrontMntVO frontMntVO);

    CmContractVO getAudioInfo(FrontMntVO frontMntVO);


    VocNegVO getCallNum(FrontMntVO frontMntVO);

    int getKeywordCnt(FrontMntVO frontMntVO);

    List<VocNegVO> getKeywordList(FrontMntVO frontMntVO);

    int getNegRetCnt(FrontMntVO frontMntVO);

    List<VocNegVO> getNegRetList(FrontMntVO frontMntVO);
}
