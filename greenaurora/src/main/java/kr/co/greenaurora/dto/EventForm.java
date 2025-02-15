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
public class EventForm {
	
	private String eventKey;			 // 이벤트 번호
	private String stationNumber;		 // 따릉이 정거장
	private Integer plusPoint;			 // 추가 포인트
	private String eventName;			 // 이벤트 제목
	private MultipartFile eventThumb;	 // 이벤트 썸네일
	private String eventContent;		 // 이벤트 내용
	private String startDt;				 // 이벤트 시작일
	private String endDt;			 	 // 이벤트 마감일
	private String state;				 // 이벤트 활성 상태 (A:활성, D:비활성)
	
	@Override
	public String toString() {
		return "EventForm [eventKey=" + eventKey + ", stationNumber=" + stationNumber + ", plusPoint=" + plusPoint
				+ ", eventName=" + eventName + ", eventThumb=" + eventThumb + ", eventContent=" + eventContent
				+ ", startDt=" + startDt + ", endDt=" + endDt + ", state=" + state + "]";
	}
	
}
