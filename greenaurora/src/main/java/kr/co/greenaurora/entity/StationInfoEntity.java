package kr.co.greenaurora.entity;

import java.sql.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
@ToString
@Table(name="station_info")
public class StationInfoEntity {

	@Id
	@Column(name="station_number")
	private String stationNumber;
	//로그인/로그아웃 구현 시 username 꼭 필요
	
	@Column(name="station_name", nullable = false)
	private String stationName;
	
	@Column(name="station_lat", nullable = false)
	private String stationLat;
	
	@Column(name="station_log", nullable = false)
	private String stationLog;
	

	@Column(name="station_create_date")
	private Date stationCreateDate;
	
	@Column(name="state")
	private char state;
	
	
	@Column(name="address")
	private String address;
	
//	@OneToMany(mappedBy = "stationInfoEntity", cascade = CascadeType.REMOVE) // 자식클래스(테이블) reply에서 외래키로 받도록 설정한 매개변수명을 value로 넣음.
//	@JsonIgnore
//	private List<BicycleEntity> bicycleList;
	
}
