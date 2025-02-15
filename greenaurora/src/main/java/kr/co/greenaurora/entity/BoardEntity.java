package kr.co.greenaurora.entity;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import kr.co.greenaurora.dto.NoticeForm;
import kr.co.greenaurora.dto.QnaForm;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "board")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class BoardEntity {

	@Id
	@Column(name = "board_key", nullable = false, length = 100)
	private String boardKey; // PRIMARY KEY로 설정됨

	@Column(name = "category", length = 100, columnDefinition = "varchar(100) COMMENT '문의사항: 문의사항, 이벤트: 이벤트, 공지사항: 공지사항'")
	private String category;
	
	@Column(name = "member_id", nullable = false, length = 100, columnDefinition = "varchar(100) COMMENT '작성자'")
	private String memberId;

	@Column(name = "title", nullable = false, columnDefinition = "text")
	private String title;

	@Column(name = "sub", length = 100)
	private String sub;

	@Column(name = "contents", columnDefinition = "text")
	private String contents;
	
    @Column(name = "file_path", length = 255)
    private String filePath;

	@Column(name = "create_dt", nullable = false)
	private Date createDt;

	@Column(name = "update_dt", nullable = false)
	private Date updateDt;

	@Column(name = "secret", length = 2, columnDefinition = "char(2) COMMENT 'Y: 비공개, N: 공개'")
	private String secret;

    // QnaForm을 BoardEntity로 변환하는 메서드
    public static BoardEntity toBoardEntityFromQnaForm(QnaForm qnaForm) {
        BoardEntity boardEntity = new BoardEntity();
        boardEntity.setBoardKey(qnaForm.getBoardKey());
        boardEntity.setMemberId(qnaForm.getMemberId());
        boardEntity.setCategory(qnaForm.getCategory());
        boardEntity.setTitle(qnaForm.getTitle());
        boardEntity.setSub(qnaForm.getSub());
        boardEntity.setContents(qnaForm.getContents());
        boardEntity.setSecret(qnaForm.getSecret());
        return boardEntity;
    }
    
    // QnaForm을 BoardEntity로 변환하는 메서드
    public static BoardEntity toBoardEntityFromNoticeForm(NoticeForm noticeForm) {
        BoardEntity boardEntity = new BoardEntity();
        boardEntity.setBoardKey(noticeForm.getBoardKey());
        boardEntity.setMemberId(noticeForm.getMemberId());
        boardEntity.setCategory(noticeForm.getCategory());
        boardEntity.setTitle(noticeForm.getTitle());
        boardEntity.setSub(noticeForm.getSub());
        boardEntity.setContents(noticeForm.getContents());
        boardEntity.setSecret(noticeForm.getSecret());
        return boardEntity;
    }

	@Override
	public String toString() {
		return "BoardEntity [boardKey=" + boardKey + ", category=" + category + ", memberId=" + memberId + ", title="
				+ title + ", sub=" + sub + ", contents=" + contents + ", filePath=" + filePath + ", createDt="
				+ createDt + ", deleteDt=" + updateDt + ", secret=" + secret + "]";
	}

}
