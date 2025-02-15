package kr.co.greenaurora.dto;

import java.util.Date;

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
public class MemberForm {
	
	private String memberId;
	private String memberPass;
	private String memberPass2;
	private String memberName;
	private Integer memberPhone;
    private String memberNumber;
	private String memberEmail;
	private String memberAddress;
	private Date memberCreateDate;
	private Date memberWithdrawDate;
	private String memberState;
	private String oldPassword;
    private String newPassword;
}
