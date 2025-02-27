package kr.co.greenaurora.entity;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import kr.co.greenaurora.dto.MemberForm;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name="member")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class MemberEntity{
   
   @Id
   @Column(name="member_id", unique=true)
   private String memberId;
   
   @Column(name="member_pass")
   private String memberPass;
   
   @Column(name="member_name")
   private String memberName;
   
   @Column(name="member_phone")
   private Integer memberPhone;
   
   @Column(name="member_number")
   private String memberNumber;
   
   @Column(name="member_email")
   private String memberEmail;
   
   @Column(name="member_address")
   private String memberAddress;
   
   @Column(name="member_create_date")
   private Date memberCreateDate;
   
   @Column(name="member_withdraw_date")
   private Date memberWithdrawDate;
   
   @Column(name="member_state")
   private String memberState;
   
   private String role;
   
   public static MemberEntity toMemberEntity(MemberForm memberForm) {
      
      return MemberEntity.builder()
            .memberId(memberForm.getMemberId())
            .memberPass(memberForm.getMemberPass())
            .memberName(memberForm.getMemberName())
            .memberPhone(memberForm.getMemberPhone())
            .memberNumber(memberForm.getMemberNumber())
            .memberEmail(memberForm.getMemberEmail())
            .memberAddress(memberForm.getMemberAddress())
            .memberCreateDate(memberForm.getMemberCreateDate())
            .memberWithdrawDate(memberForm.getMemberWithdrawDate())
            .memberState(memberForm.getMemberState())
            .role("ROLE_USER")
            .build();
            
   }
   
   
   
}
