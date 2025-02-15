package kr.co.greenaurora.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import kr.co.greenaurora.entity.StationInfoEntity;

public interface StationInfoRepository extends JpaRepository<StationInfoEntity, String>{

	@Query(value = "SELECT *, " +
            "(6371000 * acos(cos(radians(:targetLat)) * cos(radians(station_lat)) * cos(radians(station_log) - radians(:targeLon)) + " +
            "sin(radians(:targetLat)) * sin(radians(station_lat)))) AS distance " +
            "FROM station_info " +
            "HAVING distance <= 500 " +
            "ORDER BY distance", nativeQuery = true)
	List<StationInfoEntity> findStationWithin500m(double targetLat, double targeLon);
}
