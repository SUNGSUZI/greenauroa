package kr.co.greenaurora.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.greenaurora.dto.BicycleResponse;
import kr.co.greenaurora.entity.BicycleEntity;
import kr.co.greenaurora.entity.RentalEntity;
import kr.co.greenaurora.service.BicycleService;
import kr.co.greenaurora.service.RentalService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/bicycle")
@RequiredArgsConstructor
public class BicycleController {

	private final BicycleService bicycleService;
	private final RentalService rentalService;
	
	// 자전거 정보 insert	
	@GetMapping("/insert")
	public String bicycleinsert() {

		return "main/bicycle";
	}
		
	
	
	// 자전거 정보 insert	
	@PostMapping("/insert")
	public String bicycleinsert(BicycleEntity bicycle) {
		System.out.println(bicycle);
		bicycleService.bicycleInsert(bicycle);
		return "dd";
	}
	
	// 자전거 정보 update 
	// post 대여/ 반납할때 update 해줘야함
	@PostMapping("/update")
	@ResponseBody
	public String update() {
		return "";
	}
	
	
	// 대여소_대여가능한 가능한 자전거 데이터(자전거 타입) 가져오기
	@PostMapping("/select/resPosCnt")
	@ResponseBody
	public List<BicycleResponse> selectResPosCnt(@RequestParam String stationNumber) {
		System.out.println(stationNumber);
		return bicycleService.findBicycleTypeInfoByStationNumber(stationNumber);

	}
	
	// 대여소_대여가능한 가능한 자전거 데이터(자전거 타입) 가져오기
	@PostMapping("/select/opTypeCnt")
	@ResponseBody
	public List<BicycleResponse> selectOpTypeCnt(@RequestParam String stationNumber) {
		return bicycleService.findBicycleOpTypeInfoByStationNumber(stationNumber);

	}
	
	@GetMapping("/bicycleQr")
	public String bicycleQrPage() {
		return "main/bicycleQr";
	}
	
	// 자전거의 qr 생성
	@PostMapping("/bicycleQr")
	@ResponseBody
	public String bicycleQr(@RequestParam String bicycleNumber) { // 자전거 번호를 받아옴.
		
		String url = null;
		try {
			url =  bicycleService.bicycleQR(bicycleNumber);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return url;
	}
	
	@GetMapping("/return")
	public String returnPage(Principal principal, Model model) {
		if(principal.getName()!=null) {
			// 대여정보 조회
			RentalEntity rental = rentalService.findRentalByMemberIdAndReturnDate(principal.getName());
			model.addAttribute("dto", rental);
			System.out.println(rental);
		}
		return "main/returnBicycle";
	}
	
	// 자전거 반납
	@PostMapping("/return")
	@ResponseBody
	public boolean returnBicycle(@ModelAttribute RentalEntity rental) { // 자전거 번호를 받아옴.
		try {
			rentalService.returnBicycle(rental);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return true;
	}
	
	
}
