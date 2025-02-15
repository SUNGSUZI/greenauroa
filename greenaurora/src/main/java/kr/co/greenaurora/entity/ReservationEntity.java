package kr.co.greenaurora.entity;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import kr.co.greenaurora.dto.ReservationForm;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="reservation")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReservationEntity {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="rev_key")
	private Long revKey;
	
	@Column(name="member_id", nullable = false)
	private String memberId;
	
	@Column(name="station_number", nullable = false)
	private String stationNumber;
	
	@Column(name="op_type", nullable = false)
	private String opType;
	
	@Column(name="bicycle_type", nullable = false)
	private String bicycleType;

	@Column(name="bicycle_number", nullable = false)
	private String bicycleNumber;
	
	@Column(name="rev_station", nullable = false)
	private char revStation;
	
	@Column(name="rev_start_time")
	private Date revStartTime;
	
	@Column(name="rev_end_time")
	private Date revEndTime;
	
	public static ReservationEntity toReservationEntity(ReservationForm form) {
		
		return ReservationEntity.builder()
				.memberId(form.getMemberId())
				.stationNumber(form.getStationNumber())
				.opType(form.getOpType())
				.bicycleType(form.getBicycleType())
				.build();
				
	}
	
	public static RentalEntity toRentalEntity(ReservationEntity entity) {
		return RentalEntity.builder()
				.memberId(entity.getMemberId())
				.bicycleNumber(entity.getBicycleNumber())
				.stationNumber(entity.getStationNumber())
				.build();
	}
	
	
}
