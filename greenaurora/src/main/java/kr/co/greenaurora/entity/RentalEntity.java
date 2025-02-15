package kr.co.greenaurora.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name = "rental")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
@ToString
public class RentalEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "rental_key")
	private Long rentalKey;
	
	@Column(name = "member_id")
	private String memberId;
	
	@Column(name = "bicycle_number")
	private String bicycleNumber;
	
	@Column(name = "station_number")
	private String stationNumber;
	
	@Column(name = "rental_date")
	private LocalDateTime rentalDate;
	
	@Column(name = "return_date")
	private LocalDateTime returnDate;
	
	@Column(name = "return_state")
	private String returnState;
	
	@Column(name = "return_station_number")
	private String returnStationNumber;
	
	@Column(name = "rental_charge")
	private int rentalCharge;
}
