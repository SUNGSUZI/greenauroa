package kr.co.greenaurora.entity;

import java.sql.Timestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import kr.co.greenaurora.dto.QRForm;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="qr")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class QrEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "qr_id")
	private Long id;
	
	@Column(name = "rev_key")
	private Long revKey;
	
	@Column(name = "rental_key")
	private Long rentalKey;
	
	@Column(name = "url")
	private String url;
	
	@Column(name = "create_dt")
	private Timestamp createDt;
	
	@Column(name = "state")
	private String state;
	
	public static QrEntity toQrEntity(QRForm qrForm) {

		return QrEntity.builder()
				.revKey(qrForm.getRevKey())
				.rentalKey(qrForm.getRentalKey())
				.state(qrForm.getState())
				.createDt(qrForm.getCreateDt())
				.build();
	}
	
	
}
