package kr.co.greenaurora.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import kr.co.greenaurora.entity.PurchaseEntity;
import kr.co.greenaurora.entity.RentalEntity;

public interface RentalRepository extends JpaRepository<RentalEntity, Long>{

	Page<RentalEntity> findByMemberId(String memberId, PageRequest pageRequest);

    @Query("SELECT r FROM RentalEntity r WHERE r.memberId = :memberId ORDER BY r.rentalDate DESC")
	List<RentalEntity> findLatestRentalByMember(@Param("memberId") String name);
    
    @Query("SELECT r FROM RentalEntity r WHERE r.memberId = :memberId ORDER BY r.rentalDate DESC LIMIT 1")
	Optional<RentalEntity> findLatestRentalByMemberLimitd(@Param("memberId") String name);

    @Query("SELECT r FROM RentalEntity r WHERE r.memberId = :memberId AND r.returnDate is null")
	RentalEntity findRentalByMemberIdAndReturnDate(@Param("memberId") String name);

    @Query("SELECT r FROM RentalEntity r WHERE r.memberId = :memberId AND r.rentalCharge is not null ORDER BY r.returnDate DESC LIMIT 1")
	RentalEntity findByMemberIdAndRentalChargeLimit1(@Param("memberId")String memberId);
    
}
