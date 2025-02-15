package kr.co.greenaurora.service;

import org.springframework.stereotype.Service;

import kr.co.greenaurora.repository.PointRepository;
import kr.co.greenaurora.repository.UsedPointRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PointService {

	private final PointRepository pointRepository;
	private final UsedPointRepository usedpointRepository;

	public Integer findMemberPoint(String name) {
		Integer plusPoint = pointRepository.findMemberPointTotal(name);
		Integer minusPoint = usedpointRepository.findMemberPointTotal(name);
		
		// null 체크 및 초기화
		plusPoint = (plusPoint == null) ? 0 : plusPoint;
	    minusPoint = (minusPoint == null) ? 0 : minusPoint;
	    
		Integer result = plusPoint-minusPoint;
		return (result < 0) ? 0 : result;
	}
}
