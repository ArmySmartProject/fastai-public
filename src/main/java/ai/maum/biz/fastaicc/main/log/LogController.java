package ai.maum.biz.fastaicc.main.log;

import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.main.user.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@Controller
public class LogController {
  /* 권한 서비스 */
  @Autowired
  AuthService authService;


  @RequestMapping(value = "/logMain", method = { RequestMethod.GET, RequestMethod.POST })
  public String logMain(Model model) {
    Map map = new HashMap();

    model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
    return "log/log_main";
  }


  @ResponseBody
  @RequestMapping(value = "/logRealTime", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView logRealTime(HttpServletRequest request, HttpServletResponse response, @RequestBody String logName)
    throws Exception {
    ModelAndView view = new ModelAndView("log/log_realtime");
    view.addObject("logName", logName);
    return view;
  }

  @ResponseBody
  @RequestMapping(value = "/logFile", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView logFile(HttpServletRequest request, HttpServletResponse response, @RequestBody String logName)
    throws Exception {
    ModelAndView view = new ModelAndView("log/log_file");
    view.addObject("logName", logName);
    return view;
  }
}
