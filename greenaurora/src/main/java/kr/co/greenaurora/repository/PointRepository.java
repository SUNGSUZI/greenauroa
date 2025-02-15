package kr.co.greenaurora.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import kr.co.greenaurora.entity.PointEntity;

public interface PointRepository extends JpaRepository<PointEntity, Long> {
	
	@Query("SELECT SUM(p.plusPoint) FROM PointEntity p WHERE p.memberId = :memberId")
	//select sum(plusPoint) from from PointEntity  where memberId="m001";
	Integer findMemberPointTotal(@Param("memberId")String name);

}
