package kr.co.greenaurora.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class QnaForm {
	 private String boardKey;			 // 게시글 번호
	 private String category;			 // 게시글 카테고리
	 private String memberId;            // 게시글 작성자 아이디
	 private String title;               // 게시글 제목
	 private String sub;                 // 게시글 부제목
	 private String contents;            // 게시글 내용
	 private MultipartFile file;   	     // 게시글 첨부파일 추가
	 private String secret;              // 게시글 비공개유무
	
	@Override
	public String toString() {
		return "QnaForm [boardKey=" + boardKey + ", category=" + category + ", memberId=" + memberId + ", title="
				+ title + ", sub=" + sub + ", contents=" + contents + ", file=" + file + ", secret=" + secret + "]";
	}

	 
}
