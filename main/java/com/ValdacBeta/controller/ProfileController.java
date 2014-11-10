package com.ValdacBeta.controller;

import com.ValdacBeta.dto.UserForm;
import com.ValdacBeta.entity.User;
import com.ValdacBeta.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

/**
 * Created by zhangrui on 2014/10/16.
 */
@Controller
@RequestMapping("/profile")
public class ProfileController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/getUserProfile", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    public String getUserProfile(HttpSession session,
                                ModelMap modelMap){
        User user=(User)session.getAttribute("user");
        if(user != null){
            return "profile/profile";
        } else {
            return "login";
        }
    }

    @RequestMapping(value="/updateUserProfile",method = RequestMethod.POST)
    public String updateUserProfile(@ModelAttribute("UserForm") UserForm userForm,
                                    HttpSession session,
                                    ModelMap modelMap){
        User user=(User)session.getAttribute("user");
        User newUser = new User();
        newUser.setUserid(user.getUserid());
        newUser.setDepartment(userForm.getDepartment());
        newUser.setUsername(userForm.getUsername());
        newUser.setPassword(userForm.getPassword());
        newUser.setKengen("6");
        if (user !=null){
            userService.updateUserWithoutProfile(newUser);
            modelMap.addAttribute("user",user);
            session.setAttribute("user",user);
            modelMap.addAttribute("message","更新完成");
            return "profile/profile";
        } else {
            return "login";
        }

    }

    @RequestMapping(value = "/getUserProfileImage", method = RequestMethod.GET)
    public String getUserProfileImage(HttpSession session,
                                      ModelMap modelMap){
        User user=(User)session.getAttribute("user");
        modelMap.addAttribute("user",user);
        session.setAttribute("user",user);
        return "profile/profileImage";
    }

    @RequestMapping(value = "/updateUserProfileById", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String updateUserProfileById(@RequestParam("userid")String userid,
                                        @RequestParam("profile")String profile,
                                        HttpSession session,
                                        ModelMap modelMap){
        User user=(User)session.getAttribute("user");
        user.setProfile(profile);
        userService.updateUserProfileByUser(user);
        session.setAttribute("user",user);
        return profile;
    }
}
