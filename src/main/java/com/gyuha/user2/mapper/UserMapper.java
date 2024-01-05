package com.gyuha.user2.mapper;

import com.gyuha.user2.vo.UserVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMapper {
//    UserVo getUserInfo(String username);

    List<UserVo> userList();

//    void insertUser(UserVo userVo);
//
//    int updateUser(UserVo userVo);
//
//    int deleteUser(UserVo userVo);
//
//    boolean isEmailDuplicate(UserVo userVo);

}
