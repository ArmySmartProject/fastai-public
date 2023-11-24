package ai.maum.biz.fastaicc.main.error.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

@Controller
public class CustomErrorController implements ErrorController {

    private static final String PATH = "/error"; // configure 에서 Redirect 될 path

    @RequestMapping(value = PATH)
    public String error(HttpServletRequest request, Model model) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);

        model.addAttribute("errorCode", String.valueOf(status));

        return "errors/error";
    }

    @Override
    public String getErrorPath() {
        return PATH;
    }
}
