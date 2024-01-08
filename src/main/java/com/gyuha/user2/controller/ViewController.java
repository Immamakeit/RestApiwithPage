package com.gyuha.user2.controller;

import com.gyuha.user2.service.UserService;
import com.gyuha.user2.vo.UserVo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.IOException;

@Controller
public class ViewController {

    @Autowired
    private UserService userService;

    private UserVo getCurrentUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();
        return userService.getUserInfo(username);
    }

    @GetMapping("/")
    public String usersWelcome() {
        return "views/welcome";
    }

    @GetMapping("/signin")
    public String signIn(Model model, HttpServletResponse response) throws IOException {
        if (getCurrentUser() != null) {
            response.sendRedirect("/user/detail");
        }
        return "views/signIn";
    }

    @GetMapping("/signup")
    public String signUp() {
        return "views/signUp";
    }

    @GetMapping("/customError")
    public String errorPage() {
        return "errors/customError";
    }

    @GetMapping("/user/detail")
    public String userDetail(Model model) {
        UserVo user = getCurrentUser();
        model.addAttribute("user", user);
        return "views/userDetail";
    }

    @GetMapping("/user/update")
    public String userUpdate(Model model) {
        UserVo user = getCurrentUser();
        model.addAttribute("user", user);
        return "views/userUpdate";
    }

    @GetMapping("/user/delete")
    public String userDelete(Model model) {
        UserVo user = getCurrentUser();
        model.addAttribute("user", user);
        return "views/userDelete";
    }

}
