package kr.co.greenaurora.controller;

import java.security.Principal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.websocket.server.PathParam;
import kr.co.greenaurora.entity.BicycleEntity;
import kr.co.greenaurora.entity.PurchaseEntity;
import kr.co.greenaurora.entity.RentalEntity;
import kr.co.greenaurora.entity.ReservationEntity;
import kr.co.greenaurora.service.BicycleService;
import kr.co.greenaurora.service.PurchaseService;
import kr.co.greenaurora.service.RentalService;
import kr.co.greenaurora.service.ReservationService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/rental")
@RequiredArgsConstructor
public class RentalController {
	private final ReservationService reservationService;
	private final PurchaseService purchaseService;
	private final RentalService rentalService;
	private final BicycleService bicycleService;
	
	@GetMapping("/remainingtime")
	@ResponseBody
	public Map<String, String> getLatestPurchase(Principal principal) {
	    String remainingTime  = rentalService.getRemainingTimeByMember(principal.getName());
	    int rentalCharge = rentalService.getCurrentRentalCharge(principal.getName());
	    String rentalDuration = rentalService.getRentalDuration(principal.getName());


	    Map<String, String> map = new HashMap<>();
	    map.put("remainingTime", remainingTime);
	    map.put("rentalCharge", String.valueOf(rentalCharge));
	    map.put("rentalDuration", rentalDuration);
	    return map;
	}
	

	
	@GetMapping("/qr/insert")
	@ResponseBody
	public String QRinsert(@PathParam("bicycleNumber") String bicycleNumber, Principal principal) throws Exception {
		//, @PathParam("state") char state
		System.out.println("들어왔니??");
		
		// 결제내역의 1HP, 2HP의 구분이 있는지 최근 기준으로... 있다면 사용했는지 확인, 사용내역이 있는경우 24시간이 지났는지 확인
		PurchaseEntity purchaseCheck = purchaseService.findPurchaseCheck(principal.getName());
		
		if(principal != null && purchaseCheck != null) {// 결제수단이 있는경우
			
			// 접속자의 예약정보 조회, 예약상태가 R인 경우
			ReservationEntity reservInfo =  reservationService.findByMemberIdAndRevStation(principal.getName(), 'R');
			
			// 상태가 대여인 자전거는 빌릴 수 없음.
			BicycleEntity bicycleEntity = bicycleService.findById(bicycleNumber);
			// 자전거 사용 L이 아닌경우
			if(bicycleEntity !=null && bicycleEntity.getState()=="L") return "대여가능한 자전거가 아닙니다.";
			
			// 현재사용자가 대여한 내역이 있는 경우 대여불가
			RentalEntity rentalInfo = rentalService.findRentalByMemberIdAndReturnDate(principal.getName());
			
			// 과금확인
			boolean rentalChargeCheck = rentalService.chargeCheck(principal.getName());
			
			if(rentalInfo !=null) return "현재 대여중인 자전거가 있습니다.";
			
			if(!rentalChargeCheck) return "과금결제 후 대여 가능합니다.";
			if(reservInfo!=null) {// 예약정보가 있는 경우
				// 접속자의 예약 정보와 qr의 자전거 번호가 같은 경우 대여 진행
				if(bicycleNumber.equals(reservInfo.getBicycleNumber())){
					RentalEntity rentalSaveInfo =  rentalService.save(reservInfo);
					// reserv 테이블 예약 상태 S로 변경
					reservInfo.setRevStation('S');
					reservationService.save(reservInfo);
					// 자전거 상태 대여 L로 변경
					bicycleEntity.setState("L");
					bicycleService.saveByState(bicycleEntity);
					// 결제내역 추가 
					PurchaseEntity insertPurchase = new PurchaseEntity();
						insertPurchase.setMemberId(principal.getName());
						insertPurchase.setRentalKey(rentalSaveInfo.getRentalKey());
						// 이용권확인
						if(purchaseCheck.getPurchaseDivision() == "1HP") {
							insertPurchase.setPurchaseDivision("1H");
						}else {
							insertPurchase.setPurchaseDivision("2H");
						}
						insertPurchase.setPayDate(new Date());
					purchaseService.save(insertPurchase);
					return "대여되었습니다.";
				}else {
					return "예약한 자전거와 다른 자전거입니다.";
				}
			}else {// 대여진행
				RentalEntity rentalSaveInfo = rentalService.save(bicycleEntity, principal.getName());
				// 자전거 상태 대여 L로 변경
				bicycleEntity.setState("L");
				bicycleService.saveByState(bicycleEntity);
				// 결제내역 추가 
				PurchaseEntity insertPurchase = new PurchaseEntity();
					insertPurchase.setMemberId(principal.getName());
					insertPurchase.setRentalKey(rentalSaveInfo.getRentalKey());
					// 이용권확인
					if(purchaseCheck.getPurchaseDivision().equals("1HP")) {
						insertPurchase.setPurchaseDivision("1H");
					}else {
						insertPurchase.setPurchaseDivision("2H");
					}
					insertPurchase.setPayDate(new Date());
				purchaseService.save(insertPurchase);
				return "대여되었습니다.";
			}
				
		}else {
			return "결제수단을 먼저 등록해주세요.";
		}
	}
	
	
}
