package ai.maum.biz.fastaicc.main.maum.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class maumController {
  @RequestMapping(value = "/maumTTSBuilder", method = {RequestMethod.GET, RequestMethod.POST})
  public String maumTTSBuilder(HttpServletRequest req) {
    req.setAttribute("url", "http://221.168.32.165:9090/login");
    return "iframe/content";
  }

  @RequestMapping(value = "/maumOrchestra", method = {RequestMethod.GET, RequestMethod.POST})
  public String maumOrchestra(HttpServletRequest req) {
    req.setAttribute("url", "https://orchestra.maum.ai");
    return "iframe/content";
  }

  @RequestMapping(value = "/maumData", method = {RequestMethod.GET, RequestMethod.POST})
  public String maumData(HttpServletRequest req) {
    req.setAttribute("url", "https://data.maum.ai/builder/support/dataset/dataList.do");
    return "iframe/content";
  }

  @RequestMapping(value = "/maumDataBuilder", method = {RequestMethod.GET, RequestMethod.POST})
  public String maumDataBuilder(HttpServletRequest req) {
    req.setAttribute("url", "https://data.maum.ai/builder/");
    return "iframe/content";
  }

  @RequestMapping(value = "/infraMonitor", method = {RequestMethod.GET, RequestMethod.POST})
  public String infraMonitor(HttpServletRequest req) {
    req.setAttribute("url", "https://elk-system.maum.ai/");
    return "iframe/content";
  }
}
