package com.gyuha.user2.config.security;

import com.gyuha.user2.mapper.UserMapper;
import com.gyuha.user2.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Collections;
import java.util.Optional;

public class CustomAuthenticationProvider implements AuthenticationProvider {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String username = authentication.getName();
        Object rawPassword = authentication.getCredentials();

        Optional.ofNullable(username).orElseThrow(
                () -> new BadCredentialsException("No username provided")
        );

        UserVo user = userMapper.getUserInfo(username);
        if (user == null) {
            throw new BadCredentialsException("Username not found");
        }

        verifyCredentials(rawPassword, user.getPassword());

        //parameter 는 Principal
        //key 값은 들어가야 함
        //vo 통으로 담아도 됨, 민감한 정보는 제외하고, set null 하든 따로 만들든 판단하기.
        return new UsernamePasswordAuthenticationToken(username, null, Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER")));
    }

    private void verifyCredentials(Object credentials, String password) {
        if (!passwordEncoder.matches((String)credentials, password)) {
            throw new BadCredentialsException("Incorrect password");
        }
    }
    
    // true로 반환하는 경우 공부
    @Override
    public boolean supports(Class<?> authentication) {
        return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
    }

}