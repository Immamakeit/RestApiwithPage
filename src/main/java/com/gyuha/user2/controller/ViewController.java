package com.gyuha.user2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewController {

    @GetMapping("/")
    public String usersWelcome(){
        return "welcome";
    }

    @GetMapping("/userDetail")
    public String userDetail(){
        return "userDetail";
    }

    @GetMapping("/loginForm")
    public String loginForm(){
        return "loginForm";
    }

}
