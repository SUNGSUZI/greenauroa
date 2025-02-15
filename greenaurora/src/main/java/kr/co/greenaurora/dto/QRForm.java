package kr.co.greenaurora.dto;

import java.sql.Timestamp;

import kr.co.greenaurora.entity.QrEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class QRForm {

	private Long revKey;
	private Long rentalKey;
	private String url;
	private Timestamp createDt;
	private String state;
	private String bicycleNumber;
	
	
	public static QRForm toQRForm(QrEntity qrEntity) {

		return QRForm.builder()
				.revKey(qrEntity.getRevKey())
				.rentalKey(qrEntity.getRentalKey())
				.state(qrEntity.getState())
				.createDt(qrEntity.getCreateDt())
				.build();
	}
	
}
