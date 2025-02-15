package kr.co.greenaurora.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import kr.co.greenaurora.entity.BoardEntity;

public interface BoardRepository extends JpaRepository<BoardEntity, String> {

	BoardEntity findByBoardKey(String boardkey);

	Page<BoardEntity> findByCategory(String string, Pageable pageable);

	List<BoardEntity> findTop5ByCategoryOrderByCreateDtDesc(String category);
	Page<BoardEntity> findByCategoryAndMemberId(String category, String memberId, Pageable pageable);
}
