package com.ValdacBeta.service;

import com.ValdacBeta.dao.UserMapper;
import com.ValdacBeta.entity.User;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by Lsr on 10/9/14.
 */

@Service
public class UserService {

    @Resource
    UserMapper userMapper;

    public User loginByUserid(String userid,String password) {

        User user = userMapper.findByUserId(userid);

        if(password.equals(user.getPassword())){
            return user;
        } else {
            return null;
        }

    }

    public User getUserProfile(String userid) {

        User user = userMapper.findByUserId(userid);

        if(user != null){
            return user;
        } else {
            return null;
        }

    }

    public User updateUser(String userId,String username,String password,String department) {
        User newUser=new User();
        newUser.setUserid(userId);
        newUser.setPassword(password);
        newUser.setDepartment(department);
        newUser.setUsername(username);
        newUser.setKengen("6");

        userMapper.updateUser(newUser);
        User user = userMapper.findByUserId(userId);
        if(user != null){
            return user;
        } else {
            return null;
        }

    }

    public void updateUserWithoutProfile(User user){
        userMapper.updateUserWithoutProfile(user);
    }

    public void updateUserProfileById(String userid, String profile) {
        userMapper.updateUserProfileById(userid,profile);
    }

    public void updateUserProfileByUser(User user) {
        userMapper.updateUserProfileByUser(user);
    }
}
