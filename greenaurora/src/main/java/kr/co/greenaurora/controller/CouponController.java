package kr.co.greenaurora.controller;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.greenaurora.dto.PurchaseForm;
import kr.co.greenaurora.service.PointService;
import kr.co.greenaurora.service.PurchaseService;
import lombok.RequiredArgsConstructor;

@RequestMapping("/coupon")
@RequiredArgsConstructor
@Controller
public class CouponController {

	
	private final PointService pointService;
	private final PurchaseService purchaseService;
	@GetMapping("/buy")
	public String buy(Model model,Principal principal) {
		
		String Id = principal.getName();
		Integer usePoint = pointService.findMemberPoint(Id);
		
		model.addAttribute("usePoint",usePoint);
		
		return "main/coupone_buy";
	}
	
	@PostMapping("/purchase/insert")
	@ResponseBody
	public boolean purchaseInsert(@RequestBody PurchaseForm form, Principal principal) {
		try {
			form.setMemberId(principal.getName());
			purchaseService.purchaseInsert(form);
			return true;
		}catch(Exception e) {
			return false;
		}
	}
}
