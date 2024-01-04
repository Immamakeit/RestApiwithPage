package com.gyuha.user2.dto.user;

import lombok.Data;

@Data
public class UpdateUserReqDto {

    private Long id;
    private String name;
    private String password;
    private String email;
    private String address;
    private String phone;
    private String website;
    private String company;
}
