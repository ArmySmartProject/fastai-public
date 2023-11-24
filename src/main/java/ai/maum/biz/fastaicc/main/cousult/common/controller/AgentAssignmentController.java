package ai.maum.biz.fastaicc.main.cousult.common.controller;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.common.domain.PagingVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCommonCdVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmOpInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.cousult.common.service.CustOpInfoService;
import ai.maum.biz.fastaicc.main.user.service.AuthService;

@Controller
public class AgentAssignmentController {

    @Autowired
    CustOpInfoService custOpInfoService;

    @Autowired
    AuthService authService;

    @Autowired
    CommonService commonService;

    @Inject
    VariablesMng variablesMng;

    @RequestMapping(value = "/opAssign", method = {RequestMethod.GET, RequestMethod.POST})
    public String setCounselor(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {

        // 권한 확인
        boolean isHH = req.isUserInRole("ROLE_HH");
        if(isHH) {
            frontMntVO.setCampHd1("14");
            frontMntVO.setCampHd2("15");
        }

        //검색 파트 코드값 세팅
        List<CmCommonCdVO> schCodeDto = commonService.getSeachCodeList();
        if (schCodeDto != null && schCodeDto.size() > 0) {
            HashMap<String, String> custOp = new HashMap<String, String>();                        //상담사 정보 테이블
            HashMap<String, String> mntType = new HashMap<String, String>();                        // 모니터링 종류

            for (CmCommonCdVO one : schCodeDto) {
                 if (one.getFirstCd().equals(variablesMng.getCustOpInfoCode())) {
                    custOp.put(one.getCode(), one.getCdDesc());
                } else if (one.getFirstCd().equals(variablesMng.getMntType())) {
                    mntType.put(one.getCode(), one.getCdDesc());
                }
            }

            model.addAttribute("custInfoCode", Utils.makeCallStatusTag(custOp));                   // 상담사 정보
            model.addAttribute("mntType", Utils.makeCallStatusTag(mntType));                       // 모니터링 종류
            model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
        }

        PagingVO pagingVO = new PagingVO();
        pagingVO.setCOUNT_PER_PAGE(frontMntVO.getPageInitPerPage());
        pagingVO.setTotalCount(custOpInfoService.getMonitoringCount(frontMntVO));
        pagingVO.setCurrentPage(frontMntVO.getCurrentPage());
        frontMntVO.setStartRow(pagingVO.getStartRow());
        frontMntVO.setLastRow(pagingVO.getLastRow());
        frontMntVO.setPageInitPerPage( String.valueOf(pagingVO.getCOUNT_PER_PAGE()) );

        List<CmContractVO> list = custOpInfoService.getMonitoringList(frontMntVO);

        model.addAttribute("paging", pagingVO);
        model.addAttribute("list", list);
        model.addAttribute("frontMntVO", frontMntVO);
        model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름

        PagingVO pagingVO2 = new PagingVO();
        pagingVO2.setCOUNT_PER_PAGE(frontMntVO.getPageInitPerPage2());
        pagingVO2.setTotalCount(custOpInfoService.getOpCount(frontMntVO));
        pagingVO2.setCurrentPage(frontMntVO.getCurrentPage2());
        frontMntVO.setStartRow2(pagingVO2.getStartRow());
        frontMntVO.setLastRow2(pagingVO2.getLastRow());
        frontMntVO.setPageInitPerPage2( String.valueOf(pagingVO2.getCOUNT_PER_PAGE()) );
        List<CmOpInfoVO> opList = custOpInfoService.getOpList(frontMntVO);

        model.addAttribute("paging2", pagingVO2);
        model.addAttribute("opList", opList);


        /* 상담사별 상세 */
        PagingVO pagingVO3 = new PagingVO();
        pagingVO3.setCOUNT_PER_PAGE(frontMntVO.getPageInitPerPage3());
        pagingVO3.setTotalCount(custOpInfoService.getMonitoringCountByOp(frontMntVO));
        pagingVO3.setCurrentPage(frontMntVO.getCurrentPage3());
        frontMntVO.setStartRow3(pagingVO3.getStartRow());
        frontMntVO.setLastRow3(pagingVO3.getLastRow());
        frontMntVO.setPageInitPerPage3( String.valueOf(pagingVO3.getCOUNT_PER_PAGE()) );
        List<CmContractVO> detailList = custOpInfoService.getMonitoringListByOp(frontMntVO);

        model.addAttribute("paging3", pagingVO3);
        model.addAttribute("detailList", detailList);

        return "monitoring/agentAssignment";
    }


    //상담사 랜덤 배정
    @ResponseBody
    @RequestMapping(value = "/setOpByRandom", method = {RequestMethod.GET, RequestMethod.POST})
    public String setOpByRandom(@RequestParam(value = "contractNoList") List<String> contractNoList) {
        boolean result = custOpInfoService.setOpByRandom(contractNoList);
        if(result) {
            return "SUCC";
        } else {
            return "FAIL";
        }
    }

    //상담사 선택 배정
    @ResponseBody
    @RequestMapping(value = "/setOp", method = {RequestMethod.GET, RequestMethod.POST})
    public String setOp(@RequestParam(value = "contractNoList") List<String> contractNoList, @RequestParam(value = "custOpId") String custOpId) {
        boolean result = custOpInfoService.setOp(contractNoList, custOpId);
        if(result) {
            return "SUCC";
        } else {
            return "FAIL";
        }
    }

    //배정취소
    @ResponseBody
    @RequestMapping(value = "/cancelAssign", method = {RequestMethod.GET, RequestMethod.POST})
    public String cancelAssign(@RequestParam(value = "cancelList") List<String> cancelList) {
        boolean result = custOpInfoService.cancelAssign(cancelList);
        if(result) {
            return "SUCC";
        } else {
            return "FAIL";
        }
    }
}
