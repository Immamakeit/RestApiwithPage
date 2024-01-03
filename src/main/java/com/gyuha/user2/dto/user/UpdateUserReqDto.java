package com.gyuha.user2.dto.user;

import lombok.Data;

@Data
public class UpdateUserReqDto {
    private String name;
    private String username;
    private String password;
    private String email;
    private String address;
    private String phone;
    private String website;
    private String company;
}
