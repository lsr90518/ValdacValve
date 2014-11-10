package com.ValdacBeta.service;

import com.ValdacBeta.dao.ImagepartMapper;
import com.ValdacBeta.entity.Imagepart;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by Lsr on 11/5/14.
 */
@Service
public class ImagepartService {

    @Resource
    ImagepartMapper imagepartMapper;

    public void addRelation(String partid, String object) {
        Imagepart imagepart = new Imagepart();
        imagepart.setPartid(Integer.valueOf(partid));
        imagepart.setImagename(object);
        imagepartMapper.addRelationByImagepart(imagepart);
    }

    public void deleteRelationByImagename(String object) {
        imagepartMapper.deleteByImagename(object);
    }
}
