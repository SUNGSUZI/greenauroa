package kr.co.greenaurora.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.co.greenaurora.dto.MemberForm;
import kr.co.greenaurora.entity.MemberEntity;
import kr.co.greenaurora.repository.MemberRepository;
import lombok.RequiredArgsConstructor;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class FindController {

    private final MemberRepository memberRepository;   
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    @PostMapping("/findId")
    public ResponseEntity<?> findId(@RequestBody MemberForm memberForm) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            Optional<MemberEntity> dbmemberEntity = memberRepository.findByMemberNumberAndMemberName(
                memberForm.getMemberNumber(), 
                memberForm.getMemberName()
            );
            
            if (dbmemberEntity.isPresent()) {
                response.put("success", true);
                response.put("id", dbmemberEntity.get().getMemberId());
                response.put("message", "아이디 찾기 성공");
            } else {
                response.put("success", false);
                response.put("message", "일치하는 회원 정보가 없습니다.");
            }
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "서버 오류가 발생했습니다.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @PostMapping("/findPwd")
    public ResponseEntity<?> findPassword(@RequestBody MemberForm memberForm) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            Optional<MemberEntity> dbmemberOptional = memberRepository.findByMemberIdAndMemberName(
                memberForm.getMemberId(),
                memberForm.getMemberName()
            );
            
            if (dbmemberOptional.isPresent()) {
                MemberEntity dbmemberEntity = dbmemberOptional.get();
                String tempPassword = generateTempPassword();
                
                // 새 비밀번호 암호화
                String encodedPassword = bCryptPasswordEncoder.encode(tempPassword);
                
                // 기존 엔티티에 새 비밀번호 설정
                dbmemberEntity.setMemberPass(encodedPassword);
                
                // 엔티티 저장
                memberRepository.save(dbmemberEntity);
                
                response.put("success", true);
                response.put("message", "임시 비밀번호: " + tempPassword);
            } else {
                response.put("success", false);
                response.put("message", "일치하는 회원 정보가 없습니다.");
            }
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "서버 오류가 발생했습니다.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    private String generateTempPassword() {
        StringBuilder builder = new StringBuilder();
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%";
        for (int i = 0; i < 8; i++) {
            int index = (int) (Math.random() * characters.length());
            builder.append(characters.charAt(index));
        }
        return builder.toString();
    }
}