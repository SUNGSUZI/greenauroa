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
@Table(name = "point")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class PointEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "point_key")
	private Long pointKey;
	
	@Column(name = "rental_key")
	private Long rentalKey;
	
	@Column(name = "member_id", nullable = false)
	private String memberId;
	
	@Column(name = "plus_point")
	private int plusPoint;
	
	@Column(name = "create_dt")
	private Date createDt;
}
