package kr.co.greenaurora.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StreamlitRedirectController {

    @GetMapping("/admin")
    public String redirectToStreamlit() {
        return "redirect:http://localhost:8501/";
    }
}
