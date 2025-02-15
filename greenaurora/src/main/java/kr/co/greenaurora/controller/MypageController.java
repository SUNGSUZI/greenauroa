package kr.co.greenaurora.controller;

import java.security.Principal;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.greenaurora.entity.MemberEntity;
import kr.co.greenaurora.entity.PurchaseEntity;
import kr.co.greenaurora.entity.RentalEntity;
import kr.co.greenaurora.service.MemberService;
import kr.co.greenaurora.service.PurchaseService;
import kr.co.greenaurora.service.RentalService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/svc/user")
@RequiredArgsConstructor
public class MypageController {
	
	private final MemberService memberService;
	private final RentalService rentalService;
	private final PurchaseService purchaseService;
	
	@GetMapping("/mypage/change_password")
	public String change_password() {
		return "mypage/change_password/index";
	}
	
	@GetMapping("/mypage/edit_information")
	public String edit_information() {
		return "mypage/edit_information/index";
	}
	
	@GetMapping("/mypage/purchase_history/{memberId}")
	public String purchase_history(@PathVariable("memberId") String memberId,
	        @RequestParam(defaultValue = "0") int page,
	        Model model,
	        Principal principal) {
		
		// 한 페이지당 10개의 데이터 출력
	    int size = 10;
	    PageRequest pageRequest = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "payDate"));
	    Page<PurchaseEntity> purchasePage = purchaseService.findByMemberIdWithPagination(principal.getName(), pageRequest);
	    
		MemberEntity dto = memberService.findByMemberId(memberId);
		
		model.addAttribute("dto", dto);
		model.addAttribute("list", purchasePage.getContent());
	    model.addAttribute("page", purchasePage);
	    
		return "mypage/purchase_history/index";
	}
	
	
	@GetMapping("/mypage/use_history/{memberId}")
	public String use_history(@PathVariable("memberId") String memberId,
	        @RequestParam(defaultValue = "0") int page,
	        Model model,
	        Principal principal) {

	    
	    // 한 페이지당 10개의 데이터 출력
	    int size = 10;
	    PageRequest pageRequest = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "rentalDate"));
	    Page<RentalEntity> rentalPage = rentalService.findByMemberIdWithPagination(principal.getName(), pageRequest);

	    MemberEntity dto = memberService.findByMemberId(memberId);

	    model.addAttribute("dto", dto);
	    model.addAttribute("list", rentalPage.getContent());
	    model.addAttribute("page", rentalPage);

	    return "mypage/use_history/index";
	}
	
	@GetMapping("/mypage")
	public String mypage() {
		return "mypage/index";
	}
}
