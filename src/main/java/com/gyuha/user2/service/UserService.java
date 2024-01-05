package com.gyuha.user2.service;

import com.gyuha.user2.mapper.UserMapper;
import com.gyuha.user2.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    public List<UserVo> userList() {
        ArrayList<UserVo> userArrayList = (ArrayList<UserVo>) userMapper.userList();
        return userArrayList;
    }

}


