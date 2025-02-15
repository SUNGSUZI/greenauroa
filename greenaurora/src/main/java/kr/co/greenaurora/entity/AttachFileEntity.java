package kr.co.greenaurora.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "attach_file")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AttachFileEntity {

    @Id
    @Column(name = "attach_file_id", nullable = false, length = 100)
    private String attachFileId; // 첨부 파일 ID (기본 키)]
    
    @Column(name = "board_key", nullable = false, length = 100)
    private String boardKey; // 연관된 보드 키

    @Column(name = "file_name", length = 100)
    private String fileName; // 파일 이름

    @Column(name = "file_list", columnDefinition = "text")
    private String fileList; // 파일 목록

}