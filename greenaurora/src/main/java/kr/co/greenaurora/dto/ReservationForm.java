package kr.co.greenaurora.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ReservationForm {

	private String stationNumber;
	private String memberId;
	private String bicycleType;
	private String opType;
}
