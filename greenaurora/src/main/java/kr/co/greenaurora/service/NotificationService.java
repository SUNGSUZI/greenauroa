package kr.co.greenaurora.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import kr.co.greenaurora.entity.NotificationEntity;
import kr.co.greenaurora.repository.NotificationRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NotificationService {
	
	@Value("${alarm.sender.name}") 
	String sender;
	
	private final NotificationRepository notificationRepository;
	
	public Page<NotificationEntity> pageList(Integer page, String userId) {
		int pageSize = 5;
		Pageable pageable = PageRequest.of(page, pageSize);
		
		return notificationRepository.findAll(userId, pageable);
		
	}

	public NotificationEntity findByNotiKey(Long notiKey) {
		// 조회시 상태값도 update
		if(notiKey != null) {
			notificationRepository.updateStateByNotiKey(notiKey);
		}
		
		Optional<NotificationEntity> opt = notificationRepository.findById(notiKey);
		if(opt.isPresent()) {
			return opt.get();
		}
		return null;
	}

	public Integer countByStateAndMemberId(String name) {
		return notificationRepository.countByStateAndMemberId("NR",name);
	}
	
	// 알람 발송
	// 작성자는 properties변수로 선정
	public void sendNoti(NotificationEntity notifiEntity) {
		notifiEntity.setSender(sender);
		notificationRepository.save(notifiEntity);
	}

}
