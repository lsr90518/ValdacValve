package com.ValdacBeta.service;

import com.ValdacBeta.dao.ImageMapper;
import com.ValdacBeta.entity.Image;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Lsr on 11/5/14.
 */

@Service
public class ImageService {

    @Resource
    ImageMapper imageMapper;

    public String insertImageByObject(String object) {

        imageMapper.insertImageByObject(object);

        int id = imageMapper.findIdByObject(object);


        return ""+id;
    }

    public String addImageByImage(Image image){


        imageMapper.addImageByImage(image);
        int id = imageMapper.findIdByObject(image.getImagename());

        return ""+id;
    }

    public void updateSyuByImagename(String imagesyu, String object) {

        Image image = new Image();
        image.setImagesyu(imagesyu);
        image.setImagename(object);
        imageMapper.updateSyuByImagename(image);

    }

    public void deleteImageByImagename(String object) {
        imageMapper.deleteImageByImagename(object);
    }

    public List<Image> getImagesByKikiId(String kikiId) {

        return imageMapper.findImagesByKikiId(kikiId);
    }

    public List<Image> getImagesByBuhinId(String buhinId) {
        return imageMapper.findImagesByBuhinId(buhinId);
    }

    public void updateBikouByObject(String bikou, String object) {
        Image image = new Image();
        image.setBikou(bikou);
        image.setImagename(object);
        imageMapper.updateBikouByObject(image);
    }

    public String getBikouByObject(String object) {
        return imageMapper.findBikouByObject(object);
    }
}
