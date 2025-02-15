package kr.co.greenaurora.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import jakarta.transaction.Transactional;
import kr.co.greenaurora.entity.BookmarkEntity;
import kr.co.greenaurora.idClass.BookmarkId;

public interface BookmarkRepository extends JpaRepository<BookmarkEntity, BookmarkId>{

	Optional<BookmarkEntity> findByMemberIdAndStationNumber(String stationNumber, String name);
	@Transactional
	void deleteByMemberIdAndStationNumber(String memberId, String stationNumber);
	

}
