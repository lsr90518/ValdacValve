package com.ValdacBeta.controller;

import com.ValdacBeta.entity.Master;
import com.ValdacBeta.entity.User;
import com.ValdacBeta.entity.Valve;
import com.ValdacBeta.service.MasterService;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by zhangrui on 2014/10/15.
 */
@Controller
@RequestMapping("master")
public class MasterController {

    @Autowired
    private MasterService masterService;

    @RequestMapping(value="/getMasterByTypeJson",method = RequestMethod.POST,produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getMasterJson(@RequestParam("type") String type) {

        List<Master> masterList = masterService.getMasterByType(type);
        Gson gson = new Gson();
        return gson.toJson(masterList);
    }
}
