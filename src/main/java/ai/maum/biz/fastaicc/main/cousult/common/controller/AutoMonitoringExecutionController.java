package ai.maum.biz.fastaicc.main.cousult.common.controller;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.common.domain.PagingVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCommonCdVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonMonitoringService;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.cousult.outbound.service.OutboundMonitoringService;
import ai.maum.biz.fastaicc.main.user.service.AuthService;

@Controller
public class AutoMonitoringExecutionController {

    @Autowired
    CommonService commonService;

    @Autowired
    CommonMonitoringService commonMonitoringService;

    @Autowired
    OutboundMonitoringService outboundMonitoringService;

    @Autowired
    AuthService authService;

    @Autowired
    CustomProperties customProperties;

    @Inject
    VariablesMng variablesMng;

    @Inject
    Utils utils;

    //자동 모니터링 실행 리스트 페이지
    @RequestMapping(value = "/autoCallMnt", method = {RequestMethod.GET, RequestMethod.POST})
    public String doAutoCallMnt(HttpServletRequest req,  Model model, FrontMntVO frontMntVO) throws ParseException {
        // 권한 확인
        boolean isHH = req.isUserInRole("ROLE_HH");
        if(isHH) {
            frontMntVO.setCampHd1("14");
            frontMntVO.setCampHd2("15");
        }

        //검색 파트 코드값 세팅
        List<CmCommonCdVO> schCodeDto = commonService.getSeachCodeList();
        if (schCodeDto != null && schCodeDto.size() > 0) {
            HashMap<String, String> fcd02 = new HashMap<String, String>();                        //공통코드 테이블.first_cd=02
            HashMap<String, String> fcd09 = new HashMap<String, String>();                        //공통코드 테이블.first_cd=09
            HashMap<String, String> fcd10 = new HashMap<String, String>();                        //공통코드 테이블.first_cd=10
            HashMap<String, String> custOp = new HashMap<String, String>();                        //상담사 정보 테이블
            HashMap<String, String> mntType = new HashMap<String, String>();                    // 모니터링 종류

            for (CmCommonCdVO one : schCodeDto) {
                if (one.getFirstCd().equals(variablesMng.getCallStatusCode())) {
                    fcd02.put(one.getCode(), one.getCdDesc());

                } else if (one.getFirstCd().equals(variablesMng.getMonitoringResultCode())) {
                    fcd09.put(one.getCode(), one.getCdDesc());

                } else if (one.getFirstCd().equals(variablesMng.getFinalResultCode())) {
                    fcd10.put(one.getCode(), one.getCdDesc());

                } else if (one.getFirstCd().equals(variablesMng.getCustOpInfoCode())) {
                    custOp.put(one.getCode(), one.getCdDesc());
                } else if (one.getFirstCd().equals(variablesMng.getMntType())) {
                    mntType.put(one.getCode(), one.getCdDesc());
                }
            }

            model.addAttribute("callStatusCode", Utils.makeCallStatusTag(fcd02));                // 콜상태
            model.addAttribute("monitoringResultCode", Utils.makeCallStatusTag(fcd09));            // 모니터링 내용
            model.addAttribute("finalResultCode", Utils.makeCallStatusTag(fcd10));                 // 최종 결과
            model.addAttribute("custInfoCode", Utils.makeCallStatusTag(custOp));                   // 상담사 정보
            model.addAttribute("mntType", Utils.makeCallStatusTag(mntType));                       // 모니터링 종류
            model.addAttribute("websocketUrl", customProperties.getWebsocketProtocol() + "://" + customProperties.getWebsocketIp() + customProperties.getWebsocketPort());
            model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
        }


        //페이징을 위해서 쿼리 포함 전체 카운팅
        PagingVO pagingVO = new PagingVO();
        pagingVO.setCOUNT_PER_PAGE(frontMntVO.getPageInitPerPage());
        pagingVO.setTotalCount(outboundMonitoringService.getOutboundCallMntCount(frontMntVO));
        pagingVO.setCurrentPage(frontMntVO.getCurrentPage());
        frontMntVO.setStartRow(pagingVO.getStartRow());
        frontMntVO.setLastRow(pagingVO.getLastRow());

        //DB에서 전체 리스트 SELECT.
        frontMntVO.setPageInitPerPage(String.valueOf(pagingVO.getCOUNT_PER_PAGE()));
        List<CmContractVO> list = outboundMonitoringService.getOutboundCallMntList(frontMntVO);
        if (!StringUtils.isBlank(frontMntVO.getAutoYN()) && frontMntVO.getAutoYN().equals("Y")) {
            list = utils.doSortForAutoMonitoring(list, frontMntVO.getCheckedChkBox());
        }


        //Front에 전달할 객체들 생성.
        model.addAttribute("paging", pagingVO);                                                    // 페이징 관련 객체
        model.addAttribute("list", list);                                                          // 페이지 리스트.
        model.addAttribute("frontMntVO", frontMntVO);

        return "monitoring/autoMonitoringExecution";
    }
}
