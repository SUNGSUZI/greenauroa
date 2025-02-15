package kr.co.greenaurora.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.greenaurora.entity.EventEntity;
import kr.co.greenaurora.entity.EventFileEntity;
import kr.co.greenaurora.repository.EventRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EventService {

	private final EventRepository eventRepository;
	
	public List<EventEntity> select3row() {
		List<EventEntity> list = eventRepository.findTop3ByOrderByCreateDtDesc();
		if(list.isEmpty()) {
			 return null;
		}
		
		return list;
	}

	public void save(EventEntity eventEntity) {
		eventRepository.save(eventEntity);
	}
	
	public String saveFile(MultipartFile file) throws IOException {
	    // 절대 경로로 디렉토리 지정 (프로젝트 루트 기준)
	    String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/upload/event/";
	    		//Paths.get("src/main/resources/static/upload/event").toAbsolutePath().toString();
	    		//;

	    // 디렉토리가 존재하지 않으면 생성
	    File dir = new File(uploadDir);
	    if (!dir.exists()) {
	        dir.mkdirs();
	    }

	    // 파일명에 "event__"를 추가하고, 랜덤 문자열을 추가한 후 파일을 해당 경로에 저장
	    String originalFilename = file.getOriginalFilename();
	    String timestamp = String.valueOf(System.currentTimeMillis());
	    String newFilename = "event__" + timestamp + "_" + originalFilename;
	    String filePath = uploadDir + newFilename;
	    
	    // 파일을 지정된 경로로 저장
	    file.transferTo(new File(filePath));

	    // 저장된 파일 경로를 반환
	    return "/upload/event/" + newFilename; // 웹에서 접근할 수 있도록 상대 경로 반환
	}

	public Page<EventEntity> findAll(Pageable pageable) {
		return eventRepository.findAll(pageable);
	}

	public EventEntity findByEventKey(String eventkey) {
		return eventRepository.findByEventKey(eventkey);
	}

	public void deleteByEventKey(String eventKey) {
		EventEntity eventEntity = eventRepository.findByEventKey(eventKey);
		eventRepository.delete(eventEntity);
	}

}
