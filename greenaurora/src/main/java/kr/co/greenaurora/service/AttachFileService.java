package kr.co.greenaurora.service;

import org.springframework.stereotype.Service;

import kr.co.greenaurora.repository.AttachFileRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AttachFileService {
	
	private final AttachFileRepository attachFileRepository;

}
