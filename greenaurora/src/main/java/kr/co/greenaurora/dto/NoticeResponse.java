package kr.co.greenaurora.dto;

import java.text.SimpleDateFormat;

import kr.co.greenaurora.entity.BoardEntity;
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
public class NoticeResponse {
	 private String boardKey;			 // 게시글 번호
	 private String category;			 // 게시글 카테고리
	 private String memberId;            // 게시글 작성자 아이디
	 private String title;               // 게시글 제목
	 private String sub;                 // 게시글 부제목
	 private String contents;            // 게시글 내용
	 private String filePath;            // 게시글 첨부파일 추가
	 private String createDt;			 // 게시글 생성일
	 private String secret;				 // 게시글 비공개유무
	
   // BoardEntity를 QnaResponse로 변환하는 메서드
   public static NoticeResponse toNoticeResponseFromBoardEntity(BoardEntity boardEntity) {
	   NoticeResponse noticeResponse = new NoticeResponse();
	   noticeResponse.setBoardKey(boardEntity.getBoardKey());
	   noticeResponse.setCategory(boardEntity.getCategory());
	   noticeResponse.setMemberId(boardEntity.getMemberId());
	   noticeResponse.setTitle(boardEntity.getTitle());
	   noticeResponse.setSub(boardEntity.getSub());
	   noticeResponse.setContents(boardEntity.getContents());
	   noticeResponse.setFilePath(boardEntity.getFilePath());
	   noticeResponse.setSecret(boardEntity.getSecret());
       

       // Date를 포맷된 문자열로 변환
       SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
       noticeResponse.setCreateDt(sdf.format(boardEntity.getCreateDt()));

       return noticeResponse;
       
   }

	@Override
	public String toString() {
		return "NoticeResponse [boardKey=" + boardKey + ", category=" + category + ", memberId=" + memberId + ", title="
				+ title + ", sub=" + sub + ", contents=" + contents + ", filePath=" + filePath + ", createDt=" + createDt
				+ ", secret=" + secret + "]";
	}

}
