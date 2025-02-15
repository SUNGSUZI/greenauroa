package kr.co.greenaurora.entity;

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

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name ="event_file")
public class EventFileEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.UUID)
	@Column(name="event_file_id", nullable = false, unique = true)
	private String eventFileId;
	
	@Column(name="event_key", nullable = false, unique = true)
	private String eventKey;
	
	@Column(name="file_name")
	private String fileName;
	
	@Column(name="file_list")
	private String fileList;
}
