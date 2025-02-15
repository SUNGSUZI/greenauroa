package kr.co.greenaurora.repository;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import kr.co.greenaurora.entity.EventEntity;

public interface EventRepository extends JpaRepository<EventEntity, String>{

	List<EventEntity> findTop3ByOrderByCreateDtDesc();
	
	EventEntity findByEventKey(String eventkey);
	
	@Query("SELECT e FROM EventEntity e WHERE e.stationNumber = :stationNumber AND e.startDt <= :currentTime   AND e.endDt >= :currentTime")
	List<EventEntity> findByStationNumberWithCurrentTime(@Param("stationNumber") String stationNumber, @Param("currentTime") String currentTime);
}
