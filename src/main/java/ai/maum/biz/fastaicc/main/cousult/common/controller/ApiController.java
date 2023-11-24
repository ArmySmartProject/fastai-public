package ai.maum.biz.fastaicc.main.cousult.common.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CallStatusVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonMonitoringService;

@RestController
@RequestMapping(value = "/api")
public class ApiController {

    @Autowired
    CommonMonitoringService commonMonitoringService;

    /*  인바운드 모니터링 */
    @RequestMapping(value="/inboundCallStatus", method = {RequestMethod.GET})
    public List<CallStatusVO> inboundCallStatus() {
        FrontMntVO vo = new FrontMntVO();
        vo.setIsInbound("Y");
        List<CallStatusVO> result = commonMonitoringService.getCountOfCall(vo);
        return result;
    }

    /*  아웃바운드 모니터링 */
    @RequestMapping(value="/outboundCallStatus", method = {RequestMethod.GET})
    public List<CallStatusVO> outboundCallStatus() {
        FrontMntVO vo = new FrontMntVO();
        vo.setIsInbound("N");
        List<CallStatusVO> result = commonMonitoringService.getCountOfCall(vo);
        return result;
    }
}
