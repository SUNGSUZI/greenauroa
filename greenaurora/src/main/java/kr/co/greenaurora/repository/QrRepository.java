package kr.co.greenaurora.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import kr.co.greenaurora.entity.QrEntity;

public interface QrRepository extends JpaRepository<QrEntity, Long>{

}
