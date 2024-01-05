package com.gyuha.user2.controller;

import com.gyuha.user2.service.UserService;
import com.gyuha.user2.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class TestController {

    @Autowired
    private UserService userService;

    @GetMapping("/userList")
    public List<UserVo> userList() {
        return userService.userList();
    }
}
