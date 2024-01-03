package com.gyuha.user2.controller;

import com.gyuha.user2.consts.ResultCode;
import com.gyuha.user2.dto.CommonRespDto;
import com.gyuha.user2.dto.user.CheckPasswordReqDto;
import com.gyuha.user2.dto.user.CreateUserReqDto;
import com.gyuha.user2.dto.user.GetUserRespDto;
import com.gyuha.user2.dto.user.UpdateUserReqDto;
import com.gyuha.user2.exception.DataNotFoundException;
import com.gyuha.user2.service.UserService;
import com.gyuha.user2.vo.UserVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/api")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/user/info")
    public GetUserRespDto getUserInfo(@RequestParam String username) {
        GetUserRespDto getUserRespDto = new GetUserRespDto();
        try {
            UserVo userDetails = userService.getUserInfo(username);
            getUserRespDto.setUserDetail(userDetails);
            return getUserRespDto;
        } catch (Exception e) {
            log.error("Error at UserController.getUserInfo", e);
            getUserRespDto.setCode(ResultCode.UNKNOWN_EXCEPTION.value());
            getUserRespDto.setMessage("Error occured while getting detail of user");
            return getUserRespDto;
        }

    }

    @PostMapping("/user/check/password")
    public CommonRespDto checkPassword(@RequestBody CheckPasswordReqDto checkPasswordReqDto) {
        CommonRespDto commonRespDto = new CommonRespDto();
        try {
            //UserVo userVo = new UserVo(checkPasswordReqDto);
            if (!userService.isPasswordValid(checkPasswordReqDto.getUsername(), checkPasswordReqDto.getPassword())) {
                commonRespDto.setCode(ResultCode.INVALID_PASSWORD.value());
                commonRespDto.setMessage("Password is Invalid");
            }
            return commonRespDto;
        } catch (Exception e) {
            log.error("Error at UserController.checkPassword", e);
            commonRespDto.setCode(ResultCode.UNKNOWN_EXCEPTION.value());
            commonRespDto.setMessage("Error while checking Password");
            return commonRespDto;
        }
    }

    @PostMapping("/user/register")
    public CommonRespDto registerUser(@RequestBody CreateUserReqDto createUserReqDto) {
        CommonRespDto commonRespDto = new CommonRespDto();
        try {
            UserVo userVo = new UserVo(createUserReqDto);
            userService.createUser(userVo);
            return commonRespDto;
        } catch (DataIntegrityViolationException e) {
            commonRespDto.setCode(ResultCode.VIOLATED_INTEGRITY_DB.value());
            commonRespDto.setMessage("username, email must be filled and can not be duplicate");
            return commonRespDto;
        } catch (Exception e) {
            log.error("Error at UserController.registerUser", e);
            commonRespDto.setCode(ResultCode.UNKNOWN_EXCEPTION.value());
            commonRespDto.setMessage("Error occured while registering User");
            return commonRespDto;
        }
    }

    @PostMapping("/user/update")
    public CommonRespDto updateUser(@RequestBody UpdateUserReqDto updateUserReqDto) {
        CommonRespDto commonRespDto = new CommonRespDto();
        try {
            UserVo userVo = new UserVo(updateUserReqDto);
            userService.updateUser(userVo);
            return commonRespDto;
        } catch (DataNotFoundException e) {
            commonRespDto.setCode(ResultCode.DATA_NOT_FOUND.value());
            commonRespDto.setMessage(e.getLocalizedMessage());
            return commonRespDto;
        } catch (DataIntegrityViolationException e) {
            commonRespDto.setCode(ResultCode.VIOLATED_INTEGRITY_DB.value());
            commonRespDto.setMessage("username, email must be filled and can not be duplicate");
            return commonRespDto;
        } catch (Exception e) {
            log.error("Error at UserController.updateUser", e);
            commonRespDto.setCode(ResultCode.UNKNOWN_EXCEPTION.value());
            commonRespDto.setMessage("Error occured while updating User");
            return commonRespDto;
        }
    }

//    @PostMapping("/user/delete")
//    public CommonRespDto deleteUser(@RequestBody UserVo userVo) {
//        CommonRespDto commonRespDto = new CommonRespDto();
//        try {
//            return commonRespDto;
//        } catch (Exception e) {
//            return commonRespDto;
//        }
//    }

}
