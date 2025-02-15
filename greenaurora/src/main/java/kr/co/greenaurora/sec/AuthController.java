package kr.co.greenaurora.sec;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.greenaurora.dto.MemberForm;
import kr.co.greenaurora.service.MemberService;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthenticationManager authenticationManager;
    private final MemberService memberService;
    
    private static final Logger logger = LoggerFactory.getLogger(AuthController.class);


    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
    	System.out.println("여기를 오나????");
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null) {
            new SecurityContextLogoutHandler().logout(request, response, authentication);
        }

        return "redirect:/";
    }

    @PostMapping("/loginProc")
    public ResponseEntity<Map<String, Object>> loginProc(@RequestParam String memberId, @RequestParam String memberPass, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> responseBody = new HashMap<>();
        logger.info("Received login request for user: {}", memberId);

        try {
            // 인증 jwt
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(memberId, memberPass)
            );

            // 인증정보 저장 
            SecurityContextHolder.getContext().setAuthentication(authentication);
            
            // session 저장
            HttpSession session = request.getSession(true);
            SecurityContext securityContext = SecurityContextHolder.getContext();
            session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, securityContext);
            
            logger.info("Login successful for user: {}", memberId);
            logger.info("Authentication: {}", authentication);
            logger.info("Session ID: {}", session.getId());

            responseBody.put("success", true);
            responseBody.put("message", "로그인 성공");
            return ResponseEntity.ok(responseBody);

        } catch (BadCredentialsException e) {
            logger.error("Login failed - Bad credentials for user: {}", memberId);
            responseBody.put("success", false);
            responseBody.put("message", "아이디 또는 비밀번호가 틀립니다.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(responseBody);

        } catch (Exception e) {
            logger.error("Login failed for user: {} - Error: {}", memberId, e.getMessage());
            responseBody.put("success", false);
            responseBody.put("message", "로그인 실패: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseBody);
        }
    }

    @GetMapping("/login")
	public void login() {
		
	}
}
