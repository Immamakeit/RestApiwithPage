package com.gyuha.user2.service;

import com.gyuha.user2.config.security.CustomUserDetailService;
import com.gyuha.user2.exception.DataNotFoundException;
import com.gyuha.user2.mapper.UserMapper;
import com.gyuha.user2.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private CustomUserDetailService customUserDetailService;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    public UserVo getUserInfo(String username) {
        return userMapper.getUserInfo(username);
    }

    public void createUser(UserVo userVo) throws DataIntegrityViolationException {
        String encodedPassword = passwordEncoder.encode(userVo.getPassword());
        userVo.setPassword(encodedPassword);
        userMapper.insertUser(userVo);
    }

    public void updateUser(UserVo userVo) throws DataIntegrityViolationException {
        if (userMapper.updateUser(userVo) == 0) {
            throw new DataNotFoundException("update failed since No such user exists " + userVo.getUsername());
        }
    }

    public void deleteUser(UserVo userVo) {
        if (userMapper.deleteUser(userVo) == 0) {
            throw new DataNotFoundException("delete failed since No such user exists " + userVo.getId());
        }
    }

    public boolean isPasswordValid(String username, String password) {
        UserDetails userDetails = customUserDetailService.loadUserByUsername(username);
        return passwordEncoder.matches(password, userDetails.getPassword());
    }

}


