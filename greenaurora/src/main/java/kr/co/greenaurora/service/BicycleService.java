package kr.co.greenaurora.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import kr.co.greenaurora.dto.BicycleResponse;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import kr.co.greenaurora.config.QRCodeGenerator;
import kr.co.greenaurora.dto.BicycleResponse;
import kr.co.greenaurora.dto.QRForm;
import kr.co.greenaurora.entity.BicycleEntity;
import kr.co.greenaurora.repository.BicycleRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BicycleService {
	private final BicycleRepository bicycleRepository;
	
	public void bicycleInsert(BicycleEntity bicycleEntity) {
		
		Date d = new Date();

		bicycleEntity.setCreateDt(d);
		bicycleRepository.save(bicycleEntity);
	}
	
	public List<BicycleResponse> findBicycleTypeInfoByStationNumber(String stationNumber) {
		return bicycleRepository.findBicycleTypeInfoByStationNumber(stationNumber);
	}
	
	public List<BicycleResponse> findBicycleOpTypeInfoByStationNumber(String stationNumber) {
		return bicycleRepository.findBicycleOpTypeInfoByStationNumber(stationNumber);
	}

	public String bicycleQR(String revBicycleNumber) {
		//throws Exception
		Optional<BicycleEntity> opt =  bicycleRepository.findById(revBicycleNumber);
//		if(opt.get().getState().equals("A")) { // 자전거 데이터가 있다면 자전거의 상태가 a인 경우만 qr을 생성하고 아닌 경우에는 오류 문구를 반환
			
			BicycleEntity bicycleInfo = opt.get();
			// qr 생성
			QRForm qrForm = new QRForm();
			qrForm.setState(bicycleInfo.getState());
			qrForm.setBicycleNumber(bicycleInfo.getBicycleNumber());
			
			// qr 파일 생성
			String url = QRCodeGenerator.makeQrFile(qrForm);
			System.out.println("파일 생성");
			return url;
//		}
//		else {
//			throw new Exception("qr을 생성 할수 없습니다.");
//		}
	}

	public BicycleEntity findById(String bicycleNumber) {
		Optional<BicycleEntity> opt =  bicycleRepository.findById(bicycleNumber);
		System.out.println("대여하려는 자전거 정보"+opt);
				
		return opt.get();
	}

	public void saveByState(BicycleEntity bicycleEntity) {
		bicycleRepository.save(bicycleEntity);
	}

}

	
