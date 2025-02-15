package kr.co.greenaurora.service;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import kr.co.greenaurora.dto.PurchaseForm;
import kr.co.greenaurora.entity.PurchaseEntity;
import kr.co.greenaurora.entity.UsedPointEntity;
import kr.co.greenaurora.repository.PurchaseRepository;
import kr.co.greenaurora.repository.UsedPointRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PurchaseService {

	private final PurchaseRepository purchaseRepository;
	private final UsedPointRepository usedPointRepository;

	public void purchaseInsert(PurchaseForm form) {
		PurchaseEntity entity = PurchaseEntity.toPurchaseEntity(form);
		
		// 포인트
		if(!ObjectUtils.isEmpty(form.getPoint().getPointDecrease()) && form.getPoint().getPointDecrease()!=0) {
			UsedPointEntity usedpointEntity = new UsedPointEntity();
			usedpointEntity.setPointUseDate(new Date());
			usedpointEntity.setMemberId(form.getMemberId());
			usedpointEntity.setPointDecrease(form.getPoint().getPointDecrease());
			UsedPointEntity pointResult = usedPointRepository.save(usedpointEntity);
			entity.setUsedpointKey(pointResult.getUsedPointKey());
		}
		
		entity.setPayDate(new Date());
		purchaseRepository.save(entity);
	}

	public Page<PurchaseEntity> findByMemberIdWithPagination(String memberId, PageRequest pageRequest) {
        return purchaseRepository.findByMemberId(memberId, pageRequest);

	}
    
	// 결제내역 구분이 1HP or 2HP이고 결제시간으로부터 24시간이 지났는지 확인
	public PurchaseEntity findPurchaseCheck(String name) {
		LocalDateTime startTime = LocalDateTime.now().minusHours(24);
		PurchaseEntity checkList = purchaseRepository.find24InPurchaseList(name, startTime);
		
		// 결제내역이 있는 경우 true 반환
		if(checkList !=null) {
			return checkList;
		}
		return null;
	}

	public void save(PurchaseEntity insertPurchase) {
		purchaseRepository.save(insertPurchase);
	}
	
}
