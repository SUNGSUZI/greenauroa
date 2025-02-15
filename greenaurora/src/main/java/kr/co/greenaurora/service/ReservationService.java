package kr.co.greenaurora.service;

import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.greenaurora.dto.ReservationForm;
import kr.co.greenaurora.entity.ReservationEntity;
import kr.co.greenaurora.repository.BicycleRepository;
import kr.co.greenaurora.config.QRCodeGenerator;
import kr.co.greenaurora.dto.QRForm;
import kr.co.greenaurora.dto.ReservationForm;
import kr.co.greenaurora.entity.NotificationEntity;
import kr.co.greenaurora.entity.ReservationEntity;
import kr.co.greenaurora.repository.BicycleRepository;
import kr.co.greenaurora.repository.QrRepository;
import kr.co.greenaurora.repository.ReservationRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReservationService {
	
	private final BicycleRepository bicycleRepository;
	private final ReservationRepository reservationRepository;

	private final QrRepository qrRepository;
	
	private final NotificationService notificationService;
	
	public String reservBicycle(ReservationForm form) {
		bicycleRepository.updateBicycleStatus(form.getStationNumber(), form.getBicycleType(), form.getOpType());
		return bicycleRepository.findUpdatedBicycleNumber();
		
	}
	

	public Map<String, Object> insert(ReservationForm form, String name){
		
		
		Map<String, Object> result = new HashMap<>();
		// 예약자전거 상태 변경및 조회
		String revBicycleNumber = reservBicycle(form);
		

		
		System.out.println("예약한 자전거 번호"+revBicycleNumber);
		// 예약 저장
		//Date d= new Date();
		LocalDateTime now = LocalDateTime.now();
		Date d = Date.from(now.atZone(ZoneId.systemDefault()).toInstant());
		
		form.setMemberId(name);
		ReservationEntity rev = ReservationEntity.toReservationEntity(form);
		rev.setBicycleNumber(revBicycleNumber);
		rev.setRevStartTime(d);
		rev.setRevStation('R');
		
		// 20분 더하기
        LocalDateTime newTime = now.plusMinutes(20);
        Date endTime = Date.from(newTime.atZone(ZoneId.systemDefault()).toInstant());
        rev.setRevEndTime(endTime);
		ReservationEntity revResult=  reservationRepository.save(rev);
		
		// 메세지 전송(알림)
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strDate = sdf.format(d);
		NotificationEntity notiEntity = new NotificationEntity();
		notiEntity.setTitle("예약완료 안내");
		notiEntity.setContent(name+"님의 자전거 예약완료 되었습니다. 자전거번호 : "+revBicycleNumber+"예약일시 : " + strDate);
		notiEntity.setMemberId(name);
		notiEntity.setState("NR");
		notiEntity.setCreateDt(d);
		notificationService.sendNoti(notiEntity);
		

		try {
			result.put("bicycleNumber", revBicycleNumber);
			result.put("status", true);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
			result.put("status", false);
		}
		
		return result;
	}


	public ReservationEntity findReservation(String name) {
		// 예약 정보가 없으면 null 반환
		return reservationRepository.findByMemberId(name);
	}

	@Transactional
	public void deleteByMemberId(String name) {
		reservationRepository.deleteByMemberId(name);
		
	}

	//예약 취소까지 시간
	@Transactional
	public String getReferenceById(String name) {
	    Optional<ReservationEntity> reservationOpt = reservationRepository.findReservationByMemberId(name);

	    if (reservationOpt.isPresent()) {
	        ReservationEntity reservation = reservationOpt.get();

	        LocalDateTime reservationEndTime = reservation.getRevEndTime().toInstant()
	                .atZone(ZoneId.systemDefault()).toLocalDateTime();

	        LocalDateTime now = LocalDateTime.now();

	        if (!now.isBefore(reservationEndTime)) {
	            reservationRepository.delete(reservation);
	            System.out.println("Reservation for " + name + " deleted.");
	            return "00:00";
	        }

	        long elapsedSeconds = Duration.between(now, reservationEndTime).toSeconds();
	        long hours = elapsedSeconds / 3600;
	        long minutes = (elapsedSeconds % 3600) / 60;
	        long seconds = elapsedSeconds % 60;

	        // 시간:분:초 형식으로 반환
	        return String.format("%02d:%02d:%02d", hours, minutes, seconds);
	    }

	    // 예약이 없을 경우 처리
	    return "no_reservation";
	}



	public ReservationEntity findReservationById(Long revkey) {
		Optional<ReservationEntity> opt= reservationRepository.findById(revkey);
		
		if(opt.isPresent()) {
			return opt.get();
		}
		return null;
	}

	// memberId를 이용해 예약상태가 R(예약중)인것만 조회
	public ReservationEntity findByMemberIdAndRevStation(String name, char station) {
		
		return reservationRepository.findByMemberIdAndRevStation(name,station);
	}


	public void save(ReservationEntity reservInfo) throws Exception {
		try {
			reservationRepository.save(reservInfo);
		}catch (Exception e) {
			throw new Exception("저장실패했습니다.");
		}
		
	}
	

}
