package kr.co.greenaurora.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import kr.co.greenaurora.entity.PurchaseEntity;

public interface PurchaseRepository extends JpaRepository<PurchaseEntity, Long>{

	Page<PurchaseEntity> findByMemberId(String memberId, PageRequest pageRequest);
	
	Optional<PurchaseEntity> findByRentalKey(Long rentalKey);
	
	@Query("SELECT p FROM PurchaseEntity p WHERE p.memberId = :memberId ORDER BY p.payDate DESC LIMIT 1")
	Optional<PurchaseEntity> findLatestPurchaseByMemberLimitd(@Param("memberId") String name);

	
	@Query("SELECT p FROM PurchaseEntity p " +
	           "WHERE p.memberId = :memberId " +
	           "AND p.purchaseDivision IN ('1HP', '2HP') " +
	           "AND p.payDate >= :startTime")
	PurchaseEntity find24InPurchaseList(@Param("memberId")String memberId, @Param("startTime")LocalDateTime startTime);
	
	@Query("SELECT p FROM PurchaseEntity p WHERE p.rentalKey = :rentalKey AND p.purchaseDivision = 'B'")
	PurchaseEntity findByRentalKeyAndDivisionB(@Param("rentalKey")Long rentalKey);

	
}
