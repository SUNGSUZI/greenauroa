package kr.co.greenaurora.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import jakarta.transaction.Transactional;
import kr.co.greenaurora.dto.BicycleResponse;
import kr.co.greenaurora.entity.BicycleEntity;

public interface BicycleRepository extends JpaRepository<BicycleEntity, String> {
	
	@Query("SELECT new kr.co.greenaurora.dto.BicycleResponse(s.bicycleType, COUNT(*)) "+"FROM BicycleEntity s WHERE s.stationNumber = :station_number and s.state = 'A' GROUP BY s.bicycleType")
	List<BicycleResponse> findBicycleTypeInfoByStationNumber(@Param("station_number") String stationNumber);
	
	@Query("SELECT new kr.co.greenaurora.dto.BicycleResponse(s.opType, COUNT(*)) "+"FROM BicycleEntity s WHERE s.stationNumber = :station_number and s.state = 'A' GROUP BY s.opType")
	List<BicycleResponse> findBicycleOpTypeInfoByStationNumber(@Param("station_number") String stationNumber);
	
	// 자전거 state 변경
	@Modifying
	@Transactional
	@Query(value = "UPDATE station_group_bicycle b " +
            "JOIN (" +
            "    SELECT tmp.bicycle_number " +
            "    FROM (" +
            "        SELECT s.bicycle_number, ROW_NUMBER() OVER (ORDER BY s.bicycle_number) AS rn " +
            "        FROM station_group_bicycle s " +
            "        WHERE s.state = 'A' " +
            "        AND s.station_number = :stationNumber " +
            "        AND s.bicycle_type = :bikeType " +
            "        AND s.op_type = :opType " +
            "    ) tmp " +
            "    WHERE tmp.rn = 1" +  
            ") selected ON b.bicycle_number = selected.bicycle_number " +
            "SET b.state = 'R' " +
            "WHERE b.state = 'A'", nativeQuery = true) 
	// nativeQuery = true 을 해야 서브 쿼리를 사용할 수 있음.
	// MySQL의 SQL 문법을 사용하고 있기 때문에 JPA가 이를 JPQL로 변환하지 않습니다.
	void updateBicycleStatus(@Param("stationNumber")String stationNumber, @Param("bikeType") String bicycleType, @Param("opType")String opType);
	
	
	// 변경 후 바로 조회
	@Query(value = "SELECT b.bicycle_number FROM station_group_bicycle b " +
            "WHERE b.state = 'R' " +
            "ORDER BY b.rev_update_dt DESC " +  // `updatedAt`을 기준으로 최신 순서로 정렬 (필요에 따라 컬럼 수정)
            "LIMIT 1", nativeQuery = true)
	String findUpdatedBicycleNumber();



}
