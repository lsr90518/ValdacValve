package com.ValdacBeta.dao;

import com.ValdacBeta.entity.Image;

import java.util.List;

/**
 * Created by Lsr on 11/5/14.
 */
public interface ImageMapper {
    void insertImageByObject(String object);

    int findIdByObject(String object);

    void updateSyuByImagename(Image image);


    void deleteImageByImagename(String object);

    List<Image> findImagesByKikiId(String kikiId);

    void addImageByImage(Image image);

    List<Image> findImagesByBuhinId(String buhinId);

    void updateBikouByObject(Image image);

    String findBikouByObject(String object);
}
