package com.ValdacBeta.controller;

import com.ValdacBeta.entity.Image;
import com.ValdacBeta.service.ImageService;
import com.ValdacBeta.service.ImagepartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Lsr on 11/5/14.
 */
@Controller
@RequestMapping("/image")
public class ImageController {

    @Autowired
    ImageService imageService;

    @Autowired
    ImagepartService imagepartService;

    @RequestMapping(value = "/saveImageByImagePath", method = RequestMethod.POST, produces = "html/text;charset=UTF-8")
    @ResponseBody
    public String saveImageByImagePath(@RequestParam("object")String object,
                                       HttpSession session,
                                       ModelMap modelMap){
        Image image = new Image();

        image.setImagename(object);
        image.setImagesyu("");
        image.setBikou("");
        image.setKaiteino("");
        image.setPapersize("A4");
        //append Date
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
        image.setTrkDate(sdf1.format(date));

        String imageid = imageService.addImageByImage(image);
        return imageid;
    }

    @RequestMapping(value = "/updateSyuByImagename", method = RequestMethod.POST, produces = "html/text;charset=UTF-8")
    @ResponseBody
    public String updateSyuByImagename(@RequestParam("imagesyu")String imagesyu,
                                       @RequestParam("object")String object){

        imageService.updateSyuByImagename(imagesyu,object);
        return "";
    }

    @RequestMapping(value = "/deleteByImagename", method = RequestMethod.POST, produces = "html/text;charset=UTF-8")
    @ResponseBody
    public String deleteByImagename(@RequestParam("object")String object){
        imageService.deleteImageByImagename(object);
        imagepartService.deleteRelationByImagename(object);
        return object;
    }

    @RequestMapping(value = "/addRelation", method = RequestMethod.POST, produces = "html/text;charset=UTF-8")
    @ResponseBody
    public String addRelation(@RequestParam("partid") String partid,
                              @RequestParam("object") String object){

        imagepartService.addRelation(partid,object);

        return "";
    }

    @RequestMapping(value = "/submitBikouById", method = RequestMethod.POST, produces = "html/text;charset=UTF-8")
    @ResponseBody
    public String submitBikouById(@RequestParam("bikou")String bikou,
                                  @RequestParam("object")String object){
        imageService.updateBikouByObject(bikou,object);
        return "";
    }

    @RequestMapping(value = "/getBikouByObject", method = RequestMethod.GET, produces = "html/text;charset=UTF-8")
    @ResponseBody
    public String getBikouByObject(@RequestParam("object")String object){
        return imageService.getBikouByObject(object);
    }
}
