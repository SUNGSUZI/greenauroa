package kr.co.greenaurora.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;
import kr.co.greenaurora.dto.MemberForm;
import kr.co.greenaurora.entity.MemberEntity;
import kr.co.greenaurora.service.MemberService;
import kr.co.greenaurora.service.PointService;
import kr.co.greenaurora.service.RentalService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/svc/user")
@RequiredArgsConstructor
public class MemberController {
	
	private final MemberService memberService;
	private final PointService pointService;
	private final RentalService rentalService;

	
	@PostMapping("/insert")
	public String registerUser(@Valid @ModelAttribute MemberForm memberForm, BindingResult bindingResult, Model model) {
	    if (bindingResult.hasErrors()) {
	        return "redirect:/signup2"; 
	    }
	    
	    if (!memberForm.getMemberPass().equals(memberForm.getMemberPass2())) {
	        model.addAttribute("error", "비밀번호가 일치하지 않습니다");
	        return "redirect:/signup2";
	    }
	    
	    if (!isValidMemberNumber(memberForm.getMemberNumber())) {
	        model.addAttribute("error", "Invalid member number format");
	        return "redirect:/signup2";
	    }
	    
	    // 사용자 이름 중복 확인
	    if (memberService.isMemberIdExists(memberForm.getMemberId())) {
	        model.addAttribute("error", "이미 존재하는 사용자 이름입니다");
	        return "redirect:/signup2";  
	    }

	    // 사용자 저장
	    MemberEntity memberEntity = MemberEntity.toMemberEntity(memberForm);
	    memberService.saveMember(memberForm);

	    return "redirect:/signup3";
	    
	 }
	
	private boolean isValidMemberNumber(String memberNumber) {
	    // MemberNumber검증
	    return memberNumber != null && memberNumber.matches("\\d{13}"); 
	}
	


	@PostMapping("/checkId")
	@ResponseBody
	public Map<String, Boolean> checkIdDuplicate(@RequestParam String memberId) {
		boolean exists = memberService.isMemberIdExists(memberId);
		Map<String, Boolean> response = new HashMap<>();
		response.put("exists", exists);
		
		// 디버깅을 위한 로그 추가
		System.out.println("Checking memberId: " + memberId);
		System.out.println("Exists: " + exists);
		
		return response;
	}
	
	
	// read
		@GetMapping("/mypage/{memberId}")
		public String read(@PathVariable("memberId") String memberId, Model model, Principal principal) {
			MemberEntity dto = memberService.findByMemberId(memberId);
			Integer usePoint = pointService.findMemberPoint(principal.getName());
			
			model.addAttribute("dto", dto);
			model.addAttribute("usePoint", usePoint);
			return "mypage/index";
		}

		// update
		@GetMapping("/mypage/edit_information/{memberId}")
		public String update(@PathVariable("memberId") String memberId, Model model) {
			MemberEntity dto = memberService.findByMemberId(memberId);
			model.addAttribute("dto", dto);
			return "mypage/edit_information/index";
		}

		@PostMapping("/mypage/edit_information/{memberId}")
		public String update(MemberForm memberForm) {
			memberService.update(memberForm);

			return "redirect:/svc/user/mypage/" + memberForm.getMemberId();
		}

		// change_password
		@GetMapping("/mypage/change_password/{memberId}")
		public String changepw(@PathVariable("memberId") String memberId, Model model) {
			MemberEntity dto = memberService.findByMemberId(memberId);
			model.addAttribute("dto", dto);
			return "mypage/change_password/index";
		}

		@PostMapping("/mypage/change_password/{memberId}")
		public String changepw(@PathVariable("memberId") String memberId,
		                       @RequestParam String oldPassword,
		                       @RequestParam String newPassword,
		                       @RequestParam String confirmPassword,
		                       RedirectAttributes redirectAttributes) {

		    boolean isUpdated = memberService.updatePassword(memberId, oldPassword, newPassword, confirmPassword);

		    if (isUpdated) {
		        redirectAttributes.addFlashAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
		        return "redirect:/svc/user/mypage/" + memberId;
		    } else {
		        redirectAttributes.addFlashAttribute("error", "비밀번호 변경에 실패했습니다.");
		        return "redirect:/svc/user/mypage/change_password/" + memberId;
		    }
		}
		
		
		//user_delete
		@GetMapping("/mypage/user_delete/{memberId}")
		public String delete(@PathVariable("memberId") String memberId, Model model) {
			MemberEntity dto = memberService.findByMemberId(memberId);
		    model.addAttribute("dto", dto);
			return "mypage/user_delete/index";
		}
		
		@PostMapping("/mypage/user_delete/delete")
		@ResponseBody
		public String deleteUser(@RequestParam("memberId") String memberId,
		                         @RequestParam("memberPass") String memberPass) {
		    
		    boolean isDeleted = memberService.deleteMember(memberId, memberPass);

		    if (isDeleted) {
		        return "회원 탈퇴가 완료되었습니다.";  // 성공 시 단순 문자열 반환
		    } else {
		        return "비밀번호가 일치하지 않습니다.";  // 실패 시 단순 문자열 반환
		    }
		}


}