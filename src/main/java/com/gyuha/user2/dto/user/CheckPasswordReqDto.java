package com.gyuha.user2.dto.user;

import lombok.Data;

@Data
public class CheckPasswordReqDto {
    private String username;
    private String password;
}
