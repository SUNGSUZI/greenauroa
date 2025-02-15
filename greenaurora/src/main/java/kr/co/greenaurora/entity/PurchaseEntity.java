package kr.co.greenaurora.entity;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import kr.co.greenaurora.dto.PurchaseForm;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "purchase")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class PurchaseEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "purchase_key")
	private Long purchaseKey;
	
	@Column(name = "member_id", nullable = false)
	private String memberId;

	@Column(name = "rental_key")
	private Long rentalKey;
	
	@Column(name = "used_point_key")
	private Long usedpointKey;
	
	@Column(name = "purchase_division")
	private String purchaseDivision;
	
	@Column(name = "amount")
	private int amount;
	
	@Column(name = "pay_type")
	private String payType;
	
	@Column(name = "pay_date")
	private Date payDate;
	
	public static  PurchaseEntity toPurchaseEntity(PurchaseForm form) {
		return new PurchaseEntity().builder()
				.memberId(form.getMemberId())
				.rentalKey(form.getRentalKey())
				.payType(form.getPayType())
				.amount(form.getAmount())
				.purchaseDivision(form.getPurchaseDivision())
				.build();
	}
	
}
