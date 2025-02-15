package kr.co.greenaurora.dto;

import lombok.Data;

@Data
public class LoginRequest {
    private String memberId;
    private String memberPass;
}

