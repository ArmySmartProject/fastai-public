package ai.maum.biz.fastaicc.main.manual;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ManualController {
    @RequestMapping(value="/manual")
    public String getMenu(@RequestParam(value="page", defaultValue="ob01") String page, Model model){
        model.addAttribute("menu", page);
        return "manual/manual";
    }
}