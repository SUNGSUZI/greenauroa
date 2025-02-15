package kr.co.greenaurora.entity;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import kr.co.greenaurora.dto.EventForm;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "event")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class EventEntity {
    @Id
    @Column(name = "event_key", nullable = false, length = 100)
    private String eventKey;

    @Column(name = "station_number", nullable = false, length = 100)
    private String stationNumber;

    @Column(name = "plus_point")
    private Integer plusPoint;

    @Column(name = "event_name", nullable = false, columnDefinition = "TEXT")
    private String eventName;
    
    @Column(name = "event_thumb", nullable = false, length = 255)
    private String eventThumb;

    @Column(name = "event_content", nullable = false, columnDefinition = "TEXT")
    private String eventContent;

    @Column(name = "start_dt")
    private String startDt;

    @Column(name = "end_dt")
    private String endDt;

    @Column(name = "create_dt", nullable = false)
    private Date createDt;

    @Column(name = "state", length = 2, columnDefinition = "CHAR(2) DEFAULT 'A' COMMENT '활성:A 비활성:D'")
    private String state;
    
    // EventForm을 EventEntity로 변환하는 메서드
    public static EventEntity toEventEntityFromEventForm(EventForm eventForm) {
    	EventEntity eventEntity = new EventEntity();
    	eventEntity.setEventKey(eventForm.getEventKey());
    	eventEntity.setStationNumber(eventForm.getStationNumber());
    	eventEntity.setPlusPoint(eventForm.getPlusPoint());
    	eventEntity.setEventName(eventForm.getEventName());
    	eventEntity.setEventContent(eventForm.getEventContent());
    	eventEntity.setStartDt(eventForm.getStartDt());
    	eventEntity.setEndDt(eventForm.getEndDt());
    	eventEntity.setState(eventForm.getState());
        return eventEntity;
    }

	@Override
	public String toString() {
		return "EventEntity [eventKey=" + eventKey + ", stationNumber=" + stationNumber + ", plusPoint=" + plusPoint
				+ ", eventName=" + eventName + ", eventThumb=" + eventThumb + ", eventContent=" + eventContent
				+ ", startDt=" + startDt + ", endDt=" + endDt + ", createDt=" + createDt + ", state=" + state + "]";
	}
    
}
