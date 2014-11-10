package com.ValdacBeta.dao;

import com.ValdacBeta.entity.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by Lsr on 10/9/14.
 */
public interface UserMapper {

    @Select("select * from user where userId=#{userId}")
    public User findByUserId(String userid);


    public void updateUser(User user);

    void updateUserWithoutProfile(User user);

    void updateUserProfileById(String userid, String profile);

    void updateUserProfileByUser(User user);
}