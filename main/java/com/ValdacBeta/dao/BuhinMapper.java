package com.ValdacBeta.dao;

import com.ValdacBeta.entity.Buhin;

import java.util.List;

/**
 * Created by Lsr on 10/18/14.
 */
public interface BuhinMapper {
    public List<Buhin> findAllBuhins();

    public void insertBuhin(Buhin buhin);

    public int getLastInsertId();


    public List<Buhin> findBuhinByKikiId(int kikiId);


    public Buhin findBuhinById(int buhinId);

    public void updateBuhinByBuhin(Buhin buhin);

    public void deleteBuhinByBuhinId(int buhinId);

    void deleteBuhinByKikiSysId(Integer kikiSysId);

    void deleteBuhinByKikiId(Integer kikiId);

    List<Buhin> findTenBuhin();
}
