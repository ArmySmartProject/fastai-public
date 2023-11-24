package ai.maum.biz.fastaicc.main.cousult.common.controller;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.common.domain.PagingVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CallbackVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCommonCdVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.CallbackService;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import ai.maum.biz.fastaicc.main.user.service.AuthService;

@Controller
public class CallbackManagementController {

    @Autowired
    AuthService authService;

    @Autowired
    CallbackService callbackService;

    @Autowired
    CommonService commonService;

    @Autowired
    CustomProperties customProperties;

    @Inject
    VariablesMng variablesMng;


    /* 사용자 관리 리스트 페이지 */
    @RequestMapping(value = "/callbackManage", method = {RequestMethod.GET, RequestMethod.POST})
    public String callbackManage(Model model, CallbackVO callbackVO) {

    	callbackVO.setUserId(Utils.getUserVo().getUserId());
    	
        //검색 파트 코드값 세팅
        List<CmCommonCdVO> schCodeDto = commonService.getSeachCodeList();
        if (schCodeDto != null && schCodeDto.size() > 0) {
            HashMap<String, String> prodName = new HashMap<String, String>();                 // 계약 종류
            HashMap<String, String> fcd11 = new HashMap<String, String>();                    // 공통코드 테이블.first_cd=11

            for (CmCommonCdVO one : schCodeDto) {
                if (one.getFirstCd().equals(variablesMng.getProd_name())) {
                    prodName.put(one.getCode(), one.getCdDesc());

                } else if (one.getFirstCd().equals(variablesMng.getCallback_status())) {
                    fcd11.put(one.getCode(), one.getCdDesc());

                }
            }

            model.addAttribute("prod_name", Utils.makeCallStatusTag(prodName));            // 계약 내용
            model.addAttribute("callback_status", Utils.makeCallStatusTag(fcd11));         // 콜백대상여부
        }

        //페이징을 위해서 쿼리 포함 전체 카운팅
        PagingVO pagingVO = new PagingVO();
        pagingVO.setCOUNT_PER_PAGE(callbackVO.getPageInitPerPage());
        pagingVO.setTotalCount(callbackService.getResultMntTotalCount(callbackVO));
        pagingVO.setCurrentPage(callbackVO.getCurrentPage());
        callbackVO.setStartRow(pagingVO.getStartRow());
        callbackVO.setLastRow(pagingVO.getLastRow());

        //Front에 전달할 객체들 생성.
        callbackVO.setPageInitPerPage(String.valueOf(pagingVO.getCOUNT_PER_PAGE()));

        //callbacklist 조회
        List<CmContractVO> callbackList = callbackService.getCallbackList(callbackVO);

        model.addAttribute("callbackList", callbackList);
        model.addAttribute("paging", pagingVO);
        model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm());     // 로그인한 사용자 이름

        return "/monitoring/callbackManage";
    }

    // 기존 계약 콜백 취소하기
    @RequestMapping(value = "/undoCallback", method = RequestMethod.POST)
    @ResponseBody
    public String undoCallback(@RequestBody List<String> checked_arr) {
        CallbackVO callbackVO = new CallbackVO();
        callbackVO.setUserId(Utils.getUserVo().getUserId());
        callbackVO.setCallIdList(checked_arr);

        int result = callbackService.undoCallback(callbackVO);

        if( result != 0 ) {
            return "SUCC";
        } else {
            return "FAIL";
        }
    }

    // 기존 계약 콜백 지정하기
    @RequestMapping(value = "/doCallback", method = RequestMethod.POST)
    @ResponseBody
    public String doCallback(@RequestBody List<String> checked_arr) {
        CallbackVO callbackVO = new CallbackVO();
        callbackVO.setUserId(Utils.getUserVo().getUserId());
        callbackVO.setCallIdList(checked_arr);

        int result = callbackService.doCallback(callbackVO);

        if( result != 0 ) {
            return "SUCC";
        } else {
            return "FAIL";
        }
    }

    // 콜백 리스트 수정
    @RequestMapping(value = "/callbackUploadRowModify", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String doCallbackUploadRowModifySave(CallbackVO callbackVO) {
    	callbackVO.setUserId(Utils.getUserVo().getUserId());
        int result = callbackService.doCallbackModifiedRow(callbackVO);

        if( result != 0 ) {
            return "SUCC";
        } else {
            return "FAIL";
        }
    }
}


