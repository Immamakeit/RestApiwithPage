package com.gyuha.user2.controller;

import com.gyuha.user2.service.UserService;
import com.gyuha.user2.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewController {

    @Autowired
    private UserService userService;

    @GetMapping("/customError")
    public String errorPage() {
        return "errors/customError";
    }

    @GetMapping("/")
    public String usersWelcome() {
        return "views/welcome";
    }

    @GetMapping("/user/detail")
    public String userDetail(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();
        UserVo user = userService.getUserInfo(username);
        model.addAttribute("user", user);
        return "views/userDetail";
    }

    @GetMapping("/user/login")
    public String loginForm() {
        return "views/loginForm";
    }

    @GetMapping("/user/register")
    public String userRegister() {
        return "views/userRegister";
    }

    @GetMapping("/user/update")
    public String userUpdate(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();
        UserVo user = userService.getUserInfo(username);
        model.addAttribute("user", user);
        return "views/userUpdate";
    }

    @GetMapping("/user/delete")
    public String userDelete(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();
        UserVo user = userService.getUserInfo(username);
        model.addAttribute("user", user);
        return "views/userDelete";
    }

}
