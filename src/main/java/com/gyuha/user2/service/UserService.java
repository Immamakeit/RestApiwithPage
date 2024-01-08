package com.gyuha.user2.service;

import com.gyuha.user2.exception.DataNotFoundException;
import com.gyuha.user2.mapper.UserMapper;
import com.gyuha.user2.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public UserVo getUserInfo(String username) {
        return userMapper.getUserInfo(username);
    }

    public void createUser(UserVo userVo) {
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

    public boolean isPasswordValid(UserVo userVo) {
        UserVo storedUser = userMapper.getUserInfo(userVo.getUsername());
        if (storedUser == null) {
            return false;
        }
        return passwordEncoder.matches(userVo.getPassword(), storedUser.getPassword());
    }

    public boolean isEmailDuplicate(UserVo userVo) {
        return userMapper.isEmailDuplicate(userVo);
    }

}

