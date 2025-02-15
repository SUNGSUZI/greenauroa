package kr.co.greenaurora.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.transaction.Transactional;
import kr.co.greenaurora.entity.BoardEntity;
import kr.co.greenaurora.repository.BoardRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardSerivce {

	private final BoardRepository boardRepository;
	
	public void save(BoardEntity boardEntity) {
		boardRepository.save(boardEntity);
	}


	public List<BoardEntity> select5row(String category) {
		List<BoardEntity> list =  boardRepository.findTop5ByCategoryOrderByCreateDtDesc(category);
		if(list.isEmpty()) {
			list = null;
		}
		return list;
	}

	public String saveQnaFile(MultipartFile file) throws IOException {
       // 절대 경로로 디렉토리 지정 (프로젝트 루트 기준)
       String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/upload/qna/";

       // 디렉토리가 존재하지 않으면 생성
       File dir = new File(uploadDir);
       if (!dir.exists()) {
           dir.mkdirs();
       }

       // 파일명에 "qna__"를 추가하고, 랜덤 문자열을 추가한 후 파일을 해당 경로에 저장
       String originalFilename = file.getOriginalFilename();
       String timestamp = String.valueOf(System.currentTimeMillis());
       String newFilename = "qna__" + timestamp + "_" + originalFilename;
       String filePath = uploadDir + newFilename;
       
       // 파일을 지정된 경로로 저장
       file.transferTo(new File(filePath));

       // 저장된 파일 경로를 반환
       return "/upload/qna/" + newFilename; // 웹에서 접근할 수 있도록 상대 경로 반환
   }

	

	public String saveFile(MultipartFile file) throws IOException {
	    String uploadDir = "C:/upload/";
	    File dir = new File(uploadDir);
	    if (!dir.exists()) {
	        dir.mkdirs();
	    }

	    // 파일명에 "qna__"를 추가하고, 랜덤 문자열을 추가한 후 파일을 해당 경로에 저장
	    String originalFilename = file.getOriginalFilename();
	    String timestamp = String.valueOf(System.currentTimeMillis());
	    String newFilename = "qna__" + timestamp + "_" + originalFilename;
	    String filePath = uploadDir + newFilename;
	    
	    // 파일을 지정된 경로로 저장
	    file.transferTo(new File(filePath));

	    // 저장된 파일 경로를 반환
	    return "/upload/qna/" + newFilename; // 웹에서 접근할 수 있도록 상대 경로 반환
	}
	
	public String saveNoticeFile(MultipartFile file) throws IOException {
		// 절대 경로로 디렉토리 지정 (프로젝트 루트 기준)
		String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/upload/notice/";
 
		// 디렉토리가 존재하지 않으면 생성
		File dir = new File(uploadDir);
		if (!dir.exists()) {
			dir.mkdirs();
		}
 
		// 파일명에 "notice__"를 추가하고, 랜덤 문자열을 추가한 후 파일을 해당 경로에 저장
		String originalFilename = file.getOriginalFilename();
		String timestamp = String.valueOf(System.currentTimeMillis());
		String newFilename = "notice__" + timestamp + "_" + originalFilename;
		String filePath = uploadDir + newFilename;
		
		// 파일을 지정된 경로로 저장
		file.transferTo(new File(filePath));
 
		// 저장된 파일 경로를 반환
		return "/upload/notice/" + newFilename; // 웹에서 접근할 수 있도록 상대 경로 반환
	}   
 
	public BoardEntity findByBoardKey(String boardkey) {
	   // TODO Auto-generated method stub
	   return boardRepository.findByBoardKey(boardkey);
	}
 
	 @Transactional
	 public void deleteByBoardKey(String boardKey) {
		 BoardEntity boardEntity = boardRepository.findByBoardKey(boardKey);
		 boardRepository.delete(boardEntity);
	 }
	 
	 // 해당 카테고리 데이터를 페이징 처리하여 조회
	 public Page<BoardEntity> findByCategory(String string,Pageable pageable) {
		 return boardRepository.findByCategory(string, pageable);
	 }
 
	public Page<BoardEntity> findByCategoryAndMemberId(String category, String memberId, Pageable pageable) {
	   return boardRepository.findByCategoryAndMemberId(category, memberId, pageable);
	}
 

}
