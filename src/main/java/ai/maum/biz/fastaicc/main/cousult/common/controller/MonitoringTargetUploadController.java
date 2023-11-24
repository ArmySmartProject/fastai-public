package ai.maum.biz.fastaicc.main.cousult.common.controller;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.common.domain.PagingVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCommonCdVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.cousult.common.service.MonitoringTargetUploadService;
import ai.maum.biz.fastaicc.main.user.service.AuthService;

@Controller
public class MonitoringTargetUploadController {

    @Autowired
    CommonService commonService;

    @Autowired
    MonitoringTargetUploadService monitoringTargetUploadService;

    @Autowired
    AuthService authService;

    @Inject
    VariablesMng variablesMng;

    @RequestMapping(value = "/mntTargetUpload", method = {RequestMethod.GET, RequestMethod.POST})
    public String doMntTargetUpload(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
        // 권한 확인
        boolean isHH = req.isUserInRole("ROLE_HH");
        if(isHH) {
            frontMntVO.setCampHd1("14");
            frontMntVO.setCampHd2("15");
        }

        //검색 파트 코드값 세팅
        List<CmCommonCdVO> schCodeDto = commonService.getSeachCodeList();
        if (schCodeDto != null && schCodeDto.size() > 0) {
            HashMap<String, String> fcd02 = new HashMap<String, String>();
            HashMap<String, String> fcd09 = new HashMap<String, String>();
            HashMap<String, String> fcd10 = new HashMap<String, String>();
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

            model.addAttribute("callStatusCode", Utils.makeCallStatusTag(fcd02));                  // 콜상태
            model.addAttribute("monitoringResultCode", Utils.makeCallStatusTag(fcd09));            // 모니터링 내용
            model.addAttribute("finalResultCode", Utils.makeCallStatusTag(fcd10));                 // 최종 결과
            model.addAttribute("custInfoCode", Utils.makeCallStatusTag(custOp));                   // 상담사 정보
            model.addAttribute("mntType", Utils.makeCallStatusTag(mntType));                       // 모니터링 종류
            model.addAttribute("mntTypeOrigin", new Gson().toJson(mntType));
            model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
        }

        //페이징을 위해서 쿼리 포함 전체 카운팅
        PagingVO pagingVO = new PagingVO();
        pagingVO.setCOUNT_PER_PAGE(frontMntVO.getPageInitPerPage());
        pagingVO.setTotalCount(monitoringTargetUploadService.getMonitoringTargetUploadCount(frontMntVO));
        pagingVO.setCurrentPage(frontMntVO.getCurrentPage());
        frontMntVO.setStartRow(pagingVO.getStartRow());
        frontMntVO.setLastRow(pagingVO.getLastRow());

        frontMntVO.setPageInitPerPage(String.valueOf(pagingVO.getCOUNT_PER_PAGE()));
        //DB에서 전체 리스트 SELECT.
        List<CmContractVO> list = monitoringTargetUploadService.getMonitoringTargetUploadList(frontMntVO);
        //Front에 전달할 객체들 생성.
        model.addAttribute("paging", pagingVO);                                                    // 페이징 관련 객체
        model.addAttribute("list", list);

        return "monitoring/monitoringTargetUpload";
    }

    @RequestMapping(value = "/mntTargetUploadRowModify", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String doMntTargetUploadRowModifySave(FrontMntVO frontMntVO, HttpSession session) {

        frontMntVO.setSessId((String) session.getAttribute("id"));
       int result = monitoringTargetUploadService.updateUploadTarget(frontMntVO);

        if(result == 0) {
            return "FAIL";
        } else {
            return "SUCC";
        }
    }

    // 모니터링 대상 업로드 페이지 - 1 row 추가/저장
    @RequestMapping(value = "/mntTargetUploadRowAdd", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String doMntTargetUploadRowAddSave(FrontMntVO frontMntVO, HttpSession session) {
        frontMntVO.setSessId((String) session.getAttribute("id"));
        int result = monitoringTargetUploadService.addUploadTarget(frontMntVO);

        if(result == 0) {
            return "FAIL";
        } else {
            return "SUCC";
        }
    }
}
