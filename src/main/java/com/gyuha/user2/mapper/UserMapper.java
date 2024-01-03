package com.gyuha.user2.mapper;

import com.gyuha.user2.vo.UserVo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
    UserVo getUserInfo(String username);

    void insertUser(UserVo userVo);

    int updateUser(UserVo userVo);

    int deleteUser(String username);

    boolean checkPassword(UserVo userVo);
}
