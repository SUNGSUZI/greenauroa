package kr.co.greenaurora.controller;

import java.security.Principal;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.greenaurora.dto.MemberForm;
import kr.co.greenaurora.entity.BoardEntity;
import kr.co.greenaurora.entity.EventEntity;
import kr.co.greenaurora.service.BoardSerivce;
import kr.co.greenaurora.service.EventService;
import kr.co.greenaurora.service.StationInfoService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainController {
	
	private final StationInfoService stationService;
	private final BoardSerivce boardService;
	private final EventService eventService;
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
		
	@GetMapping("/index")
	public String indexPage() {
		return "index";
	}
	
	@GetMapping("/find")
	public String findPage() {
		return "find";
	}
	
	@GetMapping("/signup")
	public String signupPage() {
		return "signup";
	}
	
	@GetMapping("/signup2")
	public String signup2Page() {
		return "signup2";
	}
	
	@GetMapping("/signup3")
	public String signup3Page() {
		return "signup3";
	}
	
	@GetMapping("/signup2/admin")
	public String signup2AdminPage() {
		return "signup2_admin";
	}
	
	@GetMapping("/guide")
	public String guide() {
		return "guide";
	}
	
@GetMapping("/main")
   public String main(Model model, Principal principal) {
       if (principal != null) {
           model.addAttribute("principal", principal);
           System.out.println("Current User: " + principal.getName());
           logger.info("Authenticated user: {}", principal.getName());
       } else {
           model.addAttribute("principal", "Anonymous");
           System.out.println("No authenticated user");
           logger.warn("No authenticated user found in the request.");
       }
       
       List<BoardEntity> boardList = boardService.select5row("공지사항");
       List<EventEntity> eventList = eventService.select3row();
       System.out.println("eventList>>>>>>"+eventList);
       model.addAttribute("boardList", boardList);
       model.addAttribute("eventList", eventList);

       return "main/main";
   }
   
   @PostMapping("/loginProc")
   public String login(MemberForm memberForm) {
      return "redirect:/main";
   }
	
	

	
	


}
