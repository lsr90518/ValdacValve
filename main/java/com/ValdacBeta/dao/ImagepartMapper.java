package com.ValdacBeta.dao;

import com.ValdacBeta.entity.Imagepart;

/**
 * Created by Lsr on 11/5/14.
 */
public interface ImagepartMapper {
    void addRelationByImagepart(Imagepart imagepart);

    void deleteByImagename(String object);
}
