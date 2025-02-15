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

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name="notification")
public class NotificationEntity {

	@Id
	@GeneratedValue(strategy =GenerationType.IDENTITY)
	@Column(name="noti_key", nullable = false, unique = true)
	private Long notiKey;
	
	@Column(name="member_id", nullable = false)
	private String memberId;
	
	@Column(name="content")
	private String content;
	
	@Column(name="state", nullable = false)
	private String state;
	
	@Column(name="title")
	private String title;
	
	@Column(name="sender", nullable = false)
	private String sender;

	@Column(name="create_dt", nullable = false)
	private Date createDt;
	
}
