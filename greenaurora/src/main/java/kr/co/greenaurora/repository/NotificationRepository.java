package kr.co.greenaurora.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import jakarta.transaction.Transactional;
import kr.co.greenaurora.entity.NotificationEntity;

public interface NotificationRepository extends JpaRepository<NotificationEntity, Long>{

	@Query(nativeQuery = true,
			countQuery = "SELECT COUNT(noti_key) FROM notification WHERE member_id = :userId",
		    value = 
		        "SELECT *, "+
		        "CASE "
		        + "WHEN state='NR' THEN 1 "
		        + "ELSE 2 "
		        + "END AS STATE_ORDER "+
		        "FROM notification "+ 
		        "WHERE member_id = :userId "+ 
		        "ORDER BY STATE_ORDER, create_dt DESC " +
		        "LIMIT :#{#pageable.pageSize} OFFSET :#{#pageable.offset} "
		        
				)
	Page<NotificationEntity> findAll(@Param("userId") String userId, @Param("pageable") Pageable pageable);

	Integer countByStateAndMemberId(String string, String name);

	@Modifying
    @Transactional
    @Query("UPDATE NotificationEntity n SET n.state = 'R' WHERE n.notiKey = :notiKey and n.state = 'NR'")
	void updateStateByNotiKey(@Param("notiKey") Long notiKey);
}
