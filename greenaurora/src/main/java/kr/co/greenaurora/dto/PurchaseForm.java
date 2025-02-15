package kr.co.greenaurora.dto;

import java.util.List;

import kr.co.greenaurora.entity.PointEntity;
import kr.co.greenaurora.entity.UsedPointEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Setter
@Getter
@Builder
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class PurchaseForm {

	private String memberId;
	private Long rentalKey;
	private String payType;
	private int amount;
	private String purchaseDivision;
	private UsedPointEntity point;
}
