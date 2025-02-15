package kr.co.greenaurora.entity;

import java.util.Date;

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

@Entity
@Table(name = "used_point")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class UsedPointEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "used_point_key")
	private Long usedPointKey;
	
	@Column(name = "member_id", nullable = false)
	private String memberId;
	
	@Column(name = "point_use_date")
	private Date pointUseDate;
	
	@Column(name = "point_decrease")
	private int pointDecrease;
}
