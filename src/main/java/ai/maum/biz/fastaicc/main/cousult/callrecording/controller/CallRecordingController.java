package ai.maum.biz.fastaicc.main.cousult.callrecording.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import ai.maum.biz.fastaicc.main.cousult.callrecording.domain.CallRecordVO;
import ai.maum.biz.fastaicc.main.cousult.callrecording.service.CallRecordingService;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmSttResultDetailVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.voc.domain.VocAnalyPagingVO;
import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/callRecording/")
public class CallRecordingController {

    @Autowired
    CallRecordingService callRecordingService;

    @Value("${audio.ip}")
    String audioIp;

    @Value("${audio.port}")
    String aurioPort;

    @GetMapping("monitor")
    public String recodringMonitor(FrontMntVO frontMntVO, HttpServletRequest req, Model model){

        return "callRecording/monitor";
    }

    @GetMapping("setting")
    public String setting(FrontMntVO frontMntVO, HttpServletRequest req, Model model){

        return "callRecording/setting";
    }

    @ResponseBody
    @PostMapping("getMonitorSearchResult")
    public String getMonitorSearchResult(CallRecordVO callRecordVO){
        log.info(callRecordVO.toString());
        List<CallRecordVO> list =  callRecordingService.getCallRecordSearch(callRecordVO);

        callRecordVO.setTotalCnt(callRecordingService.getCallRecordSearchCnt(callRecordVO));
        VocAnalyPagingVO pagingVO = goPage(callRecordVO);

        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("pagingVO", pagingVO);

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        String ret = gson.toJson(map);

        return ret;
    }

    private VocAnalyPagingVO goPage(CallRecordVO callRecordVO) {

        int curPage = (int)((double)callRecordVO.getPage() / (double)callRecordVO.getAmount()) + 1;
        if(curPage < 1){
            curPage = 1;
        }
        int amount = callRecordVO.getAmount();
        int totalCnt = callRecordVO.getTotalCnt();

        VocAnalyPagingVO pagingVO = new VocAnalyPagingVO(amount,5);
        pagingVO.setTotalCount(totalCnt);
        pagingVO.setCurrentPage(String.valueOf(curPage));

        log.info("goPage: " + pagingVO.toString());

        return pagingVO;
    }

    @ResponseBody
    @PostMapping("getSttText")
    public List<CmSttResultDetailVO> getSttText(CallRecordVO callRecordVO) {
        List<CmSttResultDetailVO> result = callRecordingService.getSttText(callRecordVO);

        return result;
    }

    @ResponseBody
    @PostMapping("getAudioInfo")
    public CmContractVO getAudioInfo(CallRecordVO callRecordVO) {
        CmContractVO result = callRecordingService.getAudioInfo(callRecordVO);

        if(result != null){
            String audioUrl = audioIp + aurioPort;
            result.setAudioUrl(audioUrl);
        }
        else{
            result = new CmContractVO();
            result.setAudioUrl("none");
        }
        log.info(result.toString());

        return result;
    }
}
