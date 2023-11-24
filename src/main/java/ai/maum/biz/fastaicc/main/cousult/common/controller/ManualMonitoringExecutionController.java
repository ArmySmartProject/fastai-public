package ai.maum.biz.fastaicc.main.cousult.common.controller;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

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
import ai.maum.biz.fastaicc.main.cousult.outbound.service.OutboundMonitoringService;
import ai.maum.biz.fastaicc.main.user.service.AuthService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ManualMonitoringExecutionController {

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

    HttpClient hc;

    public ManualMonitoringExecutionController() {
        hc = HttpClients.createDefault();
    }

    //수동 모니터링 실행 리스트 페이지
    @RequestMapping(value = "/manualCallMnt", method = {RequestMethod.GET, RequestMethod.POST})
    public String doManualMnt(FrontMntVO frontMntVO, HttpServletRequest req, Model model) throws ParseException {
        // 권한 확인
        boolean isHH = req.isUserInRole("ROLE_HH");
        if(isHH) {
            frontMntVO.setCampHd1("14");
            frontMntVO.setCampHd2("15");
        }

        //검색 파트 코드값 세팅
        List<CmCommonCdVO> schCodeDto = commonService.getSeachCodeList();
        if (schCodeDto != null && schCodeDto.size() > 0) {
            HashMap<String, String> fcd02 = new HashMap<String, String>();                        // 콜상태
            HashMap<String, String> fcd09 = new HashMap<String, String>();                        // 모니터링 내용
            HashMap<String, String> fcd10 = new HashMap<String, String>();                        // 최종 결과
            HashMap<String, String> custOp = new HashMap<String, String>();                        //상담사 정보 테이블
            HashMap<String, String> mntType = new HashMap<String, String>();                        // 모니터링 종류

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


        //Front에 전달할 객체들 생성.
        model.addAttribute("frontMntVO", frontMntVO);
        model.addAttribute("paging", pagingVO);                                                    // 페이징 관련 객체
        model.addAttribute("list", list);                                                        // 페이지 리스트.

        return "monitoring/manualMonitoringExecution";
    }


    //수동 모니터링 실행 팝업 페이지
    @RequestMapping(value = "/manualPop", method = {RequestMethod.GET, RequestMethod.POST})
    public String doManualPop(FrontMntVO frontMntVO, Model model) {
        //DB에서 전체 리스트 SELECT.
        CmContractVO topInfo = outboundMonitoringService.getOutboundCallMntData(frontMntVO);

        frontMntVO.setCampaignId(topInfo.getCampaignId());
        frontMntVO.setCallId(topInfo.getCallId());

        String memo = commonMonitoringService.getRecentContractMemo(frontMntVO);

        List<CmCampaignInfoVO> mntResult = commonMonitoringService.getCallPopMonitoringResultList(frontMntVO);

        //Front에 전달할 객체들 생성.
        if(frontMntVO.getIsCall().equals("Y")){
            model.addAttribute("isCall", true);

        } else {
            model.addAttribute("isCall", false);

            //수동, 자동 모니터링 팝업 가운데 우측 모니터링 결과 답  SELECT
            HashMap<String, String> score = Utils.makeHashMapForScore(commonMonitoringService.getScoreList(frontMntVO));

            //수동, 자동 모니터링 팝업 가운데 좌측 STT 결과 리스트 SELECT
            List<CmSttResultDetailVO> sttResult = commonMonitoringService.getSttResultAllList(frontMntVO);

            model.addAttribute("score", score);
            model.addAttribute("sttResult", sttResult);
        }

        model.addAttribute("memo", memo);
        model.addAttribute("topInfo", topInfo);
        model.addAttribute("mntResult", mntResult);
        model.addAttribute("frontMntVO", frontMntVO);
        model.addAttribute("websocketUrl", customProperties.getWebsocketProtocol() + "://" + customProperties.getWebsocketIp() + customProperties.getWebsocketPort());
        model.addAttribute("audioUrl", customProperties.getAudioIp() + customProperties.getAudioPort());

        return "monitoring/manualMonitoringExecutionPopup";
    }


    //수동 모니터링 RestFul API 호출
    @RequestMapping(value = "/sendCM", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String sendCM(@RequestBody String jsonStr, FrontMntVO frontMntVO) {


        Gson gson = new Gson();
        HashMap<String, String> getJson = new HashMap<String, String>();

        //getJson = gson.fromJson(frontMntVO.getSendMsgStr(), getJson.getClass());
        getJson = gson.fromJson(jsonStr, getJson.getClass());
        log.debug("manualMonitoringExecution_getJson==="+getJson.toString());
        String callMngUrl = "";
        if (getJson.get("Event").equals("START")) {
            callMngUrl = "http://" + customProperties.getRestIp() + customProperties.getRestPort() + "/call/start";
        } else if (getJson.get("Event").equals("TRANSFER")) {
            callMngUrl = "http://" + customProperties.getRestIp() + customProperties.getRestPort() + "/call/transfer";
        } else if (getJson.get("Event").equals("CLOSE")) {
            callMngUrl = "http://" + customProperties.getRestIp() + customProperties.getRestPort() + "/call/hangup";
        } else if (getJson.get("Event").equals("LISTEN")) {
            callMngUrl = "http://" + customProperties.getRestIp() + customProperties.getRestPort() + "/call/play";
        } else if (getJson.get("Event").equals("STOP")) {
            callMngUrl = "http://" + customProperties.getRestIp() + customProperties.getRestPort() + "/call/stop";
        } else if (getJson.get("Event").equals("DIRECT")) {
        	callMngUrl = "http://" + customProperties.getRestIp() + customProperties.getRestPort() + "/call/direct";
        } else if (getJson.get("Event").equals("HANGUP")) {
        	callMngUrl = "http://" + customProperties.getRestIp() + customProperties.getRestPort() + "/call/hangup";
        }

        log.info(callMngUrl);
        HttpPost hp = new HttpPost(callMngUrl);
        StringEntity passJson;
        HttpResponse getRes;
        
        String result= "SUCC";
        try {
            passJson = new StringEntity(jsonStr);

            hp.addHeader("Content-type", "application/json");
            hp.setEntity(passJson);

            getRes = hc.execute(hp);
            String json = EntityUtils.toString(getRes.getEntity(), "UTF-8");
        } catch (Exception e) {
        	result="FAIL";
        	e.printStackTrace();
//            log.info("### sendCM : error Message : " + e.getMessage());
        }

        return result;
    }

    //수동, 자동 모니터링 실행 - 팝업에서 "저장" 버튼 클릭
    @RequestMapping(value = "/manualPopSave", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String doManualPopSave(FrontMntVO frontMntVO) {
        int result = outboundMonitoringService.updateMemo(frontMntVO);
        if(result == 0) {
            return "FAIL";
        } else {
            return "SUCC";
        }
    }
}
