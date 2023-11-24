package ai.maum.biz.fastaicc.main.cousult.inbound.controller;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.common.domain.PagingVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCampaignInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCommonCdVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmSttResultDetailVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonMonitoringService;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.cousult.inbound.service.InboundMonitoringService;
import ai.maum.biz.fastaicc.main.user.service.AuthService;

@Controller
public class InboundMonitoringResultController {

    @Autowired
    CommonService commonService;

    @Autowired
    CommonMonitoringService commonMonitoringService;

    @Autowired
    InboundMonitoringService inboundMonitoringService;

    @Autowired
    AuthService authService;

    @Autowired
    CustomProperties customProperties;

    @Inject
    VariablesMng variablesMng;

    /* 인바운드 모니터링 결과 리스트 페이지 */
    @RequestMapping(value = "/ibMntResult", method = {RequestMethod.GET, RequestMethod.POST})
    public String ibMntResult(HttpServletRequest req, Model model, FrontMntVO frontMntVO) {

        frontMntVO.setIsInbound("Y");

        // 권한 확인
        boolean isHH = req.isUserInRole("ROLE_HH");
        if(isHH) {
            frontMntVO.setCampaignId("6");
        }

        //검색 파트 코드값 세팅
        List<CmCommonCdVO> schCodeDto = commonService.getSeachCodeList();
        if( schCodeDto != null && schCodeDto.size() > 0 ) {
            HashMap<String, String> fcd02 = new HashMap<String, String>();
            HashMap<String, String> fcd09 = new HashMap<String, String>();
            HashMap<String, String> fcd10 = new HashMap<String, String>();
            HashMap<String, String> custOp = new HashMap<String, String>();						//상담사 정보 테이블

            for(CmCommonCdVO one : schCodeDto) {
                if( one.getFirstCd().equals( variablesMng.getCallStatusCode() ) ) {
                    fcd02.put( one.getCode(), one.getCdDesc() );
                }else if( one.getFirstCd().equals( variablesMng.getMonitoringResultCode() ) ) {
                    fcd09.put( one.getCode(), one.getCdDesc() );
                }else if( one.getFirstCd().equals( variablesMng.getFinalResultCode() ) ) {
                    fcd10.put( one.getCode(), one.getCdDesc() );
                }else if( one.getFirstCd().equals( variablesMng.getCustOpInfoCode() ) ) {
                    custOp.put( one.getCode(), one.getCdDesc() );
                }
            }

            model.addAttribute("callStatusCode", Utils.makeCallStatusTag(fcd02));				    // 콜상태
            model.addAttribute("monitoringResultCode", Utils.makeCallStatusTag(fcd09));			// 모니터링 내용
            model.addAttribute("finalResultCode", Utils.makeCallStatusTag(fcd10));				    // 최종 결과
            model.addAttribute("custInfoCode", Utils.makeCallStatusTag(custOp));				    // 상담사 정보
            model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
        }

        //페이징을 위해서 쿼리 포함 전체 카운팅
        PagingVO pagingVO = new PagingVO();
        pagingVO.setCOUNT_PER_PAGE( frontMntVO.getPageInitPerPage() );
        pagingVO.setTotalCount( inboundMonitoringService.getInboundCallMntCount(frontMntVO) );
        pagingVO.setCurrentPage( frontMntVO.getCurrentPage() );
        frontMntVO.setStartRow( pagingVO.getStartRow() );
        frontMntVO.setLastRow( pagingVO.getLastRow() );

        //Front에 전달할 객체들 생성.
        frontMntVO.setPageInitPerPage( String.valueOf(pagingVO.getCOUNT_PER_PAGE()) );

        //DB에서 전체 리스트 SELECT.
        List<CmContractVO> list = inboundMonitoringService.getInboundCallMntList(frontMntVO);

        model.addAttribute("paging", pagingVO);
        model.addAttribute("list", list);

        return "monitoring/inboundMonitoringResult";
    }

    /* 인바운드 모니터링 결과 상세보기 팝업 */
    @RequestMapping(value = "/ibMntResultPop", method = RequestMethod.GET)
    public String ibMntResultPop(Model model, FrontMntVO frontMntVO) {

        //수동 모니터링 팝업 상단 부분 정보 SELECT
        CmContractVO topInfo = inboundMonitoringService.getInboundCallMntData(frontMntVO);
        frontMntVO.setCampaignId( topInfo.getCampaignId() );
        frontMntVO.setCallId( frontMntVO.getCtn() );

        //수동, 자동 모니터링 팝업 하단 우측 메모
        String memo = commonMonitoringService.getRecentContractMemo(frontMntVO);

        List<CmCampaignInfoVO> mntResult = commonMonitoringService.getCallPopMonitoringResultList(frontMntVO);

        //수동, 자동 모니터링 팝업 가운데 우측 모니터링 결과 답  SELECT
        HashMap<String, String> score = Utils.makeHashMapForScore(commonMonitoringService.getScoreList(frontMntVO));

        //수동, 자동 모니터링 팝업 가운데 좌측 STT 결과 리스트 SELECT
        List<CmSttResultDetailVO> sttResult = commonMonitoringService.getSttResultAllList(frontMntVO);

        //Front에 전달할 객체들 생성.
        model.addAttribute("topInfo", topInfo);
        model.addAttribute("memo", memo);
        model.addAttribute("mntResult", mntResult);
        model.addAttribute("score", score);
        model.addAttribute("sttResult", sttResult);
        model.addAttribute("frontMntVO", frontMntVO);
        model.addAttribute("audioUrl",customProperties.getAudioIp() + customProperties.getAudioPort());

        return "/monitoring/inboundMonitoringResultPopup";
    }

    //인바운드 모니터링 - 팝업에서 "메모 저장" 버튼 클릭
    @RequestMapping(value = "/ibMntPopSave", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String ibMntPopSave(FrontMntVO frontMntVO) {
        int result = inboundMonitoringService.updateMemo(frontMntVO);
        if(result == 0) {
            return "FAIL";
        }
        return "SUCC";
    }
}
