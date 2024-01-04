package com.gyuha.user2.vo;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.gyuha.user2.dto.user.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class UserVo {

    private Long id;
    private String name;
    private String username;
    private String password;
    private String email;
    private String address;
    private String phone;
    private String website;
    private String company;

    public UserVo(CreateUserReqDto createUserReqDto) {
        this.name = createUserReqDto.getName();
        this.username = createUserReqDto.getUsername();
        this.password = createUserReqDto.getPassword();
        this.email = createUserReqDto.getEmail();
        this.address = createUserReqDto.getAddress();
        this.phone = createUserReqDto.getPhone();
        this.website = createUserReqDto.getWebsite();
    }

    public UserVo(UpdateUserReqDto updateUserReqDto) {
        this.id = updateUserReqDto.getId();
        this.name = updateUserReqDto.getName();
        this.password = updateUserReqDto.getPassword();
        this.email = updateUserReqDto.getEmail();
        this.address = updateUserReqDto.getAddress();
        this.phone = updateUserReqDto.getPhone();
        this.website = updateUserReqDto.getWebsite();
    }

    public UserVo(CheckPasswordReqDto checkPasswordReqDto) {
        this.username = checkPasswordReqDto.getUsername();
        this.password = checkPasswordReqDto.getPassword();
    }

    public UserVo(DeleteUserReqDto deleteUserReqDto) {
        this.id = deleteUserReqDto.getId();
    }

    public UserVo(CheckDuplicateEmailReqDto checkDuplicateEmailReqDto) {
        this.email= checkDuplicateEmailReqDto.getEmail();
    }

}
