package kr.co.greenaurora.service;

import java.util.Optional;


import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import kr.co.greenaurora.dto.MemberForm;
import kr.co.greenaurora.entity.MemberEntity;
import kr.co.greenaurora.repository.MemberRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberService {
	
	private final MemberRepository memberRepository;
	private final BCryptPasswordEncoder bCryptPasswordEncoder;

	public void saveMember(MemberForm memberForm) {
	    
	    Optional<MemberEntity> optionalMember = memberRepository.findByMemberId(memberForm.getMemberId());
	            
	    if(optionalMember.isEmpty()) {
	        // 신규 회원 가입
	        String encodingPass = bCryptPasswordEncoder.encode(memberForm.getMemberPass());
	        
	        MemberEntity dbMemberEntity = MemberEntity.toMemberEntity(memberForm);
	        dbMemberEntity.setMemberPass(encodingPass);
	        memberRepository.save(dbMemberEntity);
	    } else {
	        // 기존 회원 정보 수정
	        MemberEntity dbMemberEntity = optionalMember.get();
	        String dbPass = dbMemberEntity.getMemberPass();
	        String formPass = memberForm.getMemberPass();
	        
	        if(!bCryptPasswordEncoder.matches(formPass, dbPass)) {                
	            return;
	        }
	        
	        dbMemberEntity.setMemberEmail(memberForm.getMemberEmail());
	        memberRepository.save(dbMemberEntity);
	    }
	}
	
	public void saveMemberAdmin(MemberForm memberForm) {
	    
	    Optional<MemberEntity> optionalMember = memberRepository.findByMemberId(memberForm.getMemberId());
	            
	    if(optionalMember.isEmpty()) {
	        // 신규 회원 가입
	        String encodingPass = bCryptPasswordEncoder.encode(memberForm.getMemberPass());
	        
	        MemberEntity dbMemberEntity = MemberEntity.toMemberEntity(memberForm);
	        dbMemberEntity.setMemberPass(encodingPass);
	        dbMemberEntity.setRole("ROLE_ADMIN");
	        memberRepository.save(dbMemberEntity);
	    } else {
	        // 기존 회원 정보 수정
	        MemberEntity dbMemberEntity = optionalMember.get();
	        String dbPass = dbMemberEntity.getMemberPass();
	        String formPass = memberForm.getMemberPass();
	        
	        if(!bCryptPasswordEncoder.matches(formPass, dbPass)) {                
	            return;
	        }
	        
	        dbMemberEntity.setMemberEmail(memberForm.getMemberEmail());
	        memberRepository.save(dbMemberEntity);
	    }
	}

	public boolean isMemberIdExists(String memberId) {
		return memberRepository.findByMemberId(memberId).isPresent();
	}

	public boolean validateUser(String memberId, String memberPass) {
	   
	    if (memberId == null || memberPass == null || memberId.isEmpty() || memberPass.isEmpty()) {
	        return false;
	    }

	    
	    Optional<MemberEntity> optionalMember = memberRepository.findByMemberId(memberId);

	    if (optionalMember.isEmpty()) {
	        return false;
	    }

	    
	    MemberEntity member = optionalMember.get();

	    
	    return bCryptPasswordEncoder.matches(memberPass, member.getMemberPass());
	}

	
	
	public MemberEntity findByMemberId(String memberId) {
		Optional<MemberEntity> opt = memberRepository.findByMemberId(memberId);
		if(opt.isPresent()) {
			MemberEntity dto = opt.get();
			return dto;
		}
		return null;
	}

	
	public void update(MemberForm memberForm) {
		Optional<MemberEntity> opt = memberRepository.findByMemberId(memberForm.getMemberId());

		if (opt.isPresent()) {
			MemberEntity dto = opt.get();

			dto.setMemberEmail(memberForm.getMemberEmail());
			dto.setMemberPhone(memberForm.getMemberPhone());
			dto.setMemberAddress(memberForm.getMemberAddress());

			memberRepository.save(dto);
		}
	}

	@Transactional
	public boolean updatePassword(String memberId, String oldPassword, String newPassword, String confirmPassword) {
		// Optional을 사용하여 사용자 조회 및 예외 처리
        Optional<MemberEntity> opt = memberRepository.findByMemberId(memberId);

        // 사용자가 존재하지 않을 경우
        if (opt.isEmpty()) {
            return false; // 사용자 없음
        }

        MemberEntity member = opt.get();
        
        // 기존 비밀번호 확인
        if (!bCryptPasswordEncoder.matches(oldPassword, member.getMemberPass())) {
            return false;  // 기존 비밀번호 불일치
        }

        // 새 비밀번호와 확인 비밀번호 일치 검사
        if (!newPassword.equals(confirmPassword)) {
            return false;  // 새 비밀번호와 확인 비밀번호 불일치
        }

        // 새 비밀번호 암호화 후 저장
        member.setMemberPass(bCryptPasswordEncoder.encode(newPassword));
        memberRepository.save(member);
        return true;
	}

	
	@Transactional
	public boolean deleteMember(String memberId, String memberPass) {
	    // 유효성 검사 추가
	    if (memberId == null || memberId.trim().isEmpty()) {
	        throw new IllegalArgumentException("회원 ID가 입력되지 않았습니다.");
	    }

	    Optional<MemberEntity> optionalMember = memberRepository.findByMemberId(memberId);

	    if (optionalMember.isPresent()) {
	        MemberEntity member = optionalMember.get();
	        if (bCryptPasswordEncoder.matches(memberPass, member.getMemberPass())) {
	            memberRepository.delete(member);
	            return true;
	        }
	    }
	    return false;
	}

	

}
