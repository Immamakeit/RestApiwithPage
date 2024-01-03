package com.gyuha.user2.config.security;

import com.gyuha.user2.service.UserService;
import com.gyuha.user2.vo.UserVo;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;


@Component
public class CustomUserDetailService implements UserDetailsService {

    private final UserService userService;

    public CustomUserDetailService(UserService userService) {
        this.userService = userService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserVo user = userService.getUserInfo(username);
        if (user == null) {
            throw new UsernameNotFoundException("No such User");
        }

        return User.builder()
                .username(user.getUsername())
                .password(user.getPassword())
                .build();
    }

}


