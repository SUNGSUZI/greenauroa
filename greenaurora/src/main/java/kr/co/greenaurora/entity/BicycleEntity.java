package kr.co.greenaurora.entity;



import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Table(name="station_group_bicycle")
public class BicycleEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.UUID)
	@Column(name="bicycle_number")
	private String bicycleNumber;
	//로그인/로그아웃 구현 시 username 꼭 필요
	
	@Column(name="station_number", nullable = false, unique = true)
	private String stationNumber;
	
	@Column(name="bicycle_type")
	private String bicycleType;
	
	@Column(name="op_type")
	private String opType;
	

	@Column(name="create_dt")
	private Date createDt;
	
	@Column(name="delete_dt")
	private Date deleteDt;
	
	
	@Column(name="state")
	private String state;
	
	@Column(name="rev_update_dt")
	private Date revUpdateDt;

//	@ManyToOne
//	@JsonIgnore
//	private StationInfoEntity stationInfoEntity;
	public static RentalEntity toRentalEntity(BicycleEntity bicycleInfo) {
		
		return RentalEntity.builder()
				.bicycleNumber(bicycleInfo.getBicycleNumber())
				.stationNumber(bicycleInfo.getStationNumber())
				.build();
		
	}
}
