package kr.co.greenaurora.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import kr.co.greenaurora.idClass.BookmarkId;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
@Table(name="bookmark")
@IdClass(BookmarkId.class) // 복합키 클래스 지정
public class BookmarkEntity {
	@Id
    @Column(name = "member_id", nullable = false)
    private String memberId;

    @Id
    @Column(name = "station_number", nullable = false)
    private String stationNumber;
	
}
