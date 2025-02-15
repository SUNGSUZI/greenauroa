package kr.co.greenaurora.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import kr.co.greenaurora.entity.ReservationEntity;

public interface ReservationRepository extends JpaRepository<ReservationEntity, Long>{

	ReservationEntity findByMemberId(String name);

	void deleteByMemberId(String name);

	@Query("SELECT r FROM ReservationEntity r WHERE r.memberId = :memberId")
	Optional<ReservationEntity> findReservationByMemberId(@Param("memberId") String memberId);

	@Query("SELECT r FROM ReservationEntity r WHERE r.memberId = :memberId AND r.revStation = :revStation")
	ReservationEntity findByMemberIdAndRevStation(@Param("memberId")String memberId, @Param("revStation")char revStation);

}
