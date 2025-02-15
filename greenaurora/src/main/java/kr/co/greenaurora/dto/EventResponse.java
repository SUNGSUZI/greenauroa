package kr.co.greenaurora.dto;

import java.text.SimpleDateFormat;

import kr.co.greenaurora.entity.EventEntity;
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
public class EventResponse {
	
	private String eventKey;			 // 이벤트 번호
	private String stationNumber;		 // 따릉이 정거장
	private Integer plusPoint;			 // 추가 포인트
	private String eventName;			 // 이벤트 제목
	private String eventThumb;	 		 // 이벤트 썸네일
	private String eventContent;		 // 이벤트 내용
	private String startDt;				 // 이벤트 생성일
	private String endDt;				 // 이벤트 생성일
	private String createDt;			 // 이벤트 생성일
	private String state;				 // 이벤트 활성 상태 (A:활성, D:비활성)

    // EventEntity를 EventResponse로 변환하는 메서드
    public static EventResponse toEventResponseFromEventEntity(EventEntity eventEntity) {
    	EventResponse eventResponse = new EventResponse();
    	eventResponse.setEventKey(eventEntity.getEventKey());
    	eventResponse.setStationNumber(eventEntity.getStationNumber());
    	eventResponse.setPlusPoint(eventEntity.getPlusPoint());
    	eventResponse.setEventName(eventEntity.getEventName());
    	eventResponse.setEventContent(eventEntity.getEventContent());
    	eventResponse.setEventThumb(eventEntity.getEventThumb());
    	eventResponse.setStartDt(eventEntity.getStartDt());
    	eventResponse.setEndDt(eventEntity.getEndDt());
    	eventResponse.setState(eventEntity.getState());
    	
        // Date를 포맷된 문자열로 변환
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        eventResponse.setCreateDt(sdf.format(eventEntity.getCreateDt()));

        return eventResponse;
    }

	@Override
	public String toString() {
		return "EventResponse [eventKey=" + eventKey + ", stationNumber=" + stationNumber + ", plusPoint=" + plusPoint
				+ ", eventName=" + eventName + ", eventThumb=" + eventThumb + ", eventContent=" + eventContent
				+ ", startDt=" + startDt + ", endDt=" + endDt + ", createDt=" + createDt + ", state=" + state + "]";
	}
	
}
