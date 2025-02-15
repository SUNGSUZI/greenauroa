package kr.co.greenaurora.service;

import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import kr.co.greenaurora.entity.BicycleEntity;
import kr.co.greenaurora.entity.EventEntity;
import kr.co.greenaurora.entity.NotificationEntity;
import kr.co.greenaurora.entity.PointEntity;
import kr.co.greenaurora.entity.PurchaseEntity;
import kr.co.greenaurora.entity.RentalEntity;
import kr.co.greenaurora.entity.ReservationEntity;
import kr.co.greenaurora.repository.BicycleRepository;
import kr.co.greenaurora.repository.EventRepository;
import kr.co.greenaurora.repository.PointRepository;
import kr.co.greenaurora.repository.PurchaseRepository;
import kr.co.greenaurora.repository.RentalRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RentalService {

	private final RentalRepository rentalRepository;
	private final PurchaseRepository purchaseRepository;
	private final BicycleRepository bicycleRepository;
	private final EventRepository eventRepository;
	private final PointRepository pointRepository;
	private final NotificationService notificationService;

	public Page<RentalEntity> findByMemberIdWithPagination(String memberId, PageRequest pageRequest) {
        return rentalRepository.findByMemberId(memberId, pageRequest);
    }

	public RentalEntity findRentalMember(String name) {
		List<RentalEntity> rentals = rentalRepository.findLatestRentalByMember(name);
        return rentals.isEmpty() ? null : rentals.get(0);
	}
	
	// 렌탈 시 남은시간 호출
	public String getRemainingTimeByMember(String name) {
	    Optional<PurchaseEntity> purchaseOpt = purchaseRepository.findLatestPurchaseByMemberLimitd(name);
	    Optional<RentalEntity> rentalOpt = rentalRepository.findLatestRentalByMemberLimitd(name);
	    
	    if(purchaseOpt.isPresent() && rentalOpt.isPresent()) {
	    	PurchaseEntity purchase = purchaseOpt.get();
	    	RentalEntity rental = rentalOpt.get();
	    	
	    	LocalDateTime rentalStartTime = rental.getRentalDate();
		    LocalDateTime now = LocalDateTime.now();

		     long rentalDuration = switch (purchase.getPurchaseDivision()) {
		         case "1H" -> 60;
		         case "2H" -> 120;
		         default -> 0;
		     };

		    long elapsedMinutes = Duration.between(rentalStartTime, now).toMinutes();
		    long remainingTime = Math.max(rentalDuration - elapsedMinutes, 0);

		    // hh:mm 형식으로 변환
		    long hours = remainingTime / 60;
		    long minutes = remainingTime % 60;
		    
		    return String.format("%02d:%02d", hours, minutes);
	    }
	    return "00:00";
	}


	public RentalEntity save(ReservationEntity reservInfo) {
		RentalEntity rental = ReservationEntity.toRentalEntity(reservInfo);
		rental.setRentalDate(LocalDateTime.now());
		return rentalRepository.save(rental);
		
	}

	public RentalEntity findRentalByMemberIdAndReturnDate(String name) {
		return rentalRepository.findRentalByMemberIdAndReturnDate(name);
	}

	public RentalEntity save(BicycleEntity bicycleEntity, String memberId) {
		RentalEntity rental = BicycleEntity.toRentalEntity(bicycleEntity);
		rental.setMemberId(memberId);
		rental.setRentalDate(LocalDateTime.now());
		rental.setReturnState("NR");
		return rentalRepository.save(rental);
	}

	// 자전거 반납
	public void returnBicycle(RentalEntity rental) {

		Optional<RentalEntity> selectOpt = rentalRepository.findById(rental.getRentalKey());
		
		if(selectOpt.isPresent()) {
			RentalEntity selectRental = selectOpt.get();
			
			// 해당 대여_결제시간, 결제구분(몇시간 이용권) 조회
			Optional<PurchaseEntity> purchaseOpt =   purchaseRepository.findByRentalKey(selectRental.getRentalKey());
			String division = null;
			
			LocalDateTime returnTime = null;
			if(purchaseOpt.isPresent()) { 
				division = purchaseOpt.get().getPurchaseDivision();
				
				if(division.equals("1H")) returnTime = selectRental.getRentalDate().plusHours(1);
				if(division.equals("2H")) returnTime = selectRental.getRentalDate().plusHours(2);
			
				LocalDateTime currentTime = LocalDateTime.now();
				
				Duration duration = Duration.between(returnTime, currentTime);
			
				// 반납시간과 대여가능시간 Max 차이
				long difference = duration.toMinutes();
				
				// 과금
				if(difference>0) {
					int price = 200;
					int standardTime = 5;
					long charge  = (difference / standardTime) * price;
					long rest =  difference % standardTime;
					
					if(rest>0) charge = charge + price;
					
					// 대여정보 과금 부여
					selectRental.setRentalCharge((int)charge);
					
					// 과금 메세지
					NotificationEntity notiEntity = new NotificationEntity();
					notiEntity.setTitle("과금안내");
					
					NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(Locale.KOREA);  // 미국 화폐 형식
			        String formattedCharge = currencyFormat.format(charge);
			        
					notiEntity.setContent(selectRental.getMemberId()+"님의 자전거 대여시간이 초과되어 과금이 발생하였습니다. \n 과금금액 : "+formattedCharge+" \n 마이페이지에서 확인해주세요." );
					notiEntity.setMemberId(selectRental.getMemberId());
					notiEntity.setState("NR");
					notiEntity.setCreateDt(new Date());
					notificationService.sendNoti(notiEntity);
				}
				// 대여정보 상태 변경, 반납 대여소, 반납시간
				selectRental.setReturnState("R");
				selectRental.setReturnStationNumber(rental.getReturnStationNumber());
				selectRental.setReturnDate(currentTime);
				
				rentalRepository.save(selectRental);
			}
			// 자전거 정보 변경
			Optional<BicycleEntity> bicycleOpt = bicycleRepository.findById(rental.getBicycleNumber());
			
			if(bicycleOpt.isPresent()) {
				BicycleEntity bicycleInfo = bicycleOpt.get();
				bicycleInfo.setState("A");
				bicycleInfo.setStationNumber(rental.getReturnStationNumber());
				// 자전거정보변경
				bicycleRepository.save(bicycleInfo);
			}
			
			// 반납시 이벤트확인
			// 반납하는 대여소의 이벤트 정보 확인(이벤트기간도 확인)
			Date currentTime = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String strCurrentTime =sdf.format(currentTime);
			List<EventEntity> eventList = eventRepository.findByStationNumberWithCurrentTime(rental.getReturnStationNumber(), strCurrentTime);
			int totalPoint = 0;
			
			System.out.println("이벤트 정보"+eventList);
			if(eventList.size() > 0) {
				for(EventEntity event : eventList) {
					totalPoint += event.getPlusPoint();
				}
				
				// 포인트 적립
				PointEntity point = new PointEntity();
				point.setRentalKey(selectRental.getRentalKey());
				point.setMemberId(selectRental.getMemberId());
				point.setPlusPoint(totalPoint);
				point.setCreateDt(new Date());
				
				pointRepository.save(point);
			}
			
		}
	}

	// 대여정보에 과금이 있고 해당 대여정보에 대한 결제정보가 없는 경우
	public boolean chargeCheck(String memberId) {
		// 대여정보가 있는지
		RentalEntity rental = rentalRepository.findByMemberIdAndRentalChargeLimit1(memberId);
		
		if(rental !=null) {
			// 해당내역에 대한 과금결제내역이 있는지
			PurchaseEntity purchase = purchaseRepository.findByRentalKeyAndDivisionB(rental.getRentalKey());
			if(purchase != null) {// 과금 결제내역이 있음
				return true;
			}else { // 과금 결제내역 없음
				return false;
			}
		}
		
		return true;
	}
	//과금 계산
	public int getCurrentRentalCharge(String name) {
		return rentalRepository.findLatestRentalByMemberLimitd(name).map(RentalEntity::getRentalCharge).orElse(0);
	}
	
	public String getRentalDuration(String name) {
	    return rentalRepository.findLatestRentalByMemberLimitd(name)
	            .flatMap(rental -> purchaseRepository.findLatestPurchaseByMemberLimitd(name).map(purchase -> {
	                LocalDateTime rentalDate = rental.getRentalDate();
	                LocalDateTime returnDate = rental.getReturnDate() != null ? rental.getReturnDate() : LocalDateTime.now();

	                long totalMinutes = Duration.between(rentalDate, returnDate).toMinutes();

	                // 기본 무료 시간 설정
	                long freeMinutes = switch (purchase.getPurchaseDivision()) {
	                    case "1H" -> 60;
	                    case "2H" -> 120;
	                    default -> 0;
	                };

	                long chargeableMinutes = Math.max(totalMinutes - freeMinutes, 0);
	                long hours = chargeableMinutes / 60;
	                long minutes = chargeableMinutes % 60;

	                return String.format("%02d:%02d", hours, minutes);
	            }))
	            .orElse("00:00");
	}

	public String getPurchaseDivision(String name) {
	    Optional<PurchaseEntity> purchaseOpt = purchaseRepository.findLatestPurchaseByMemberLimitd(name);
	    return purchaseOpt.map(PurchaseEntity::getPurchaseDivision).orElse(null);
	}


	
}
