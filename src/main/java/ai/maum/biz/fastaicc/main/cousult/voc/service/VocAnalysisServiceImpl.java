package ai.maum.biz.fastaicc.main.cousult.voc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmSttResultDetailVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.voc.domain.HmdResultVO;
import ai.maum.biz.fastaicc.main.cousult.voc.domain.VocNegVO;
import ai.maum.biz.fastaicc.main.cousult.voc.mapper.VocAnalysisMapper;
import lombok.extern.java.Log;

@Log
@Service
public class VocAnalysisServiceImpl implements VocAnalysisService {
    @Autowired
    VocAnalysisMapper vocAnalysisMapper;

    @Override
    public List<HmdResultVO> getHmdResult(FrontMntVO frontMntVO) {
        return vocAnalysisMapper.getHmdResult(frontMntVO);
    }

    @Override
    public int getHmdResultCnt(FrontMntVO frontMntVO) {
        return vocAnalysisMapper.getHmdResultCnt(frontMntVO);
    }

    @Override
	public List<HmdResultVO> getHmdResultDetail(FrontMntVO frontMntVO) {
		return vocAnalysisMapper.getHmdResultDetail(frontMntVO);
	}

    @Override
    public int getHmdResultDetailCnt(FrontMntVO frontMntVO) {
        return vocAnalysisMapper.getHmdResultDetailCnt(frontMntVO);
    }

    @Override
    public List<CmSttResultDetailVO> getSttText(FrontMntVO frontMntVO) {
        return vocAnalysisMapper.getSttText(frontMntVO);
    }

    @Override
    public CmContractVO getAudioInfo(FrontMntVO frontMntVO) {
	    return vocAnalysisMapper.getAudioInfo(frontMntVO);
    }


    @Override
    public VocNegVO getCallNum(FrontMntVO frontMntVO) {
        return vocAnalysisMapper.getCallNum(frontMntVO);
    }

    @Override
    public int getKeywordCnt(FrontMntVO frontMntVO) {
        return vocAnalysisMapper.getKeywordCnt(frontMntVO);
    }

    @Override
    public List<VocNegVO> getKeywordList(FrontMntVO frontMntVO) {
        return vocAnalysisMapper.getKeywordList(frontMntVO);
    }

    @Override
    public int getNegRetCnt(FrontMntVO frontMntVO) {
        return vocAnalysisMapper.getNegRetCnt(frontMntVO);
    }

    @Override
    public List<VocNegVO> getNegRetList(FrontMntVO frontMntVO) {
        return vocAnalysisMapper.getNegRetList(frontMntVO);
    }

}
