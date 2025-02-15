package kr.co.greenaurora.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.co.greenaurora.entity.StationInfoEntity;
import kr.co.greenaurora.controller.MainController;

import kr.co.greenaurora.repository.StationInfoRepository;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@Service
@RequiredArgsConstructor
public class StationInfoService {

	private final StationInfoRepository stationInfoRepository;
	private static final Logger log = LoggerFactory.getLogger(MainController.class);
	
	public List<StationInfoEntity> findStationInfoList(double targetLat, double targetLon) {
		List<StationInfoEntity> list = stationInfoRepository.findStationWithin500m(targetLat, targetLon);
		//findAll();
		if (list.isEmpty()) {
			log.warn("역 정보를 찾을 수 없습니다");
			return null;
		}
		return list;
	}
	
	
}
