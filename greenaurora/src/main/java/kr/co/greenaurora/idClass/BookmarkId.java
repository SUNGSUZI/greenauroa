package kr.co.greenaurora.idClass;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class BookmarkId implements Serializable{

	@Id
	@Column(name="member_id", nullable = false)
	private String memberId;
	
	@Id
	@Column(name="station_number", nullable = false)
	private String stationNumber;
	
	@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        BookmarkId that = (BookmarkId) o;
        return Objects.equals(memberId, that.memberId) && 
               Objects.equals(stationNumber, that.stationNumber);
    }
}
