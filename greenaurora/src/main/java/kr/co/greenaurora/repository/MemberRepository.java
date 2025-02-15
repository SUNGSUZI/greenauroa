package kr.co.greenaurora.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.co.greenaurora.entity.MemberEntity;

@Repository
public interface MemberRepository extends JpaRepository<MemberEntity, String>{
	
	Optional<MemberEntity> findByMemberId(String memberId);

	Optional<MemberEntity> findByMemberNumberAndMemberName(String memberNumber, String memberName);

	Optional<MemberEntity> findByMemberIdAndMemberName(String memberId, String memberName);

	
	
	}
	
		

