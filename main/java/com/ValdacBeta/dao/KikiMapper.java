package com.ValdacBeta.dao;

import com.ValdacBeta.entity.Kiki;

import java.util.List;

/**
 * Created by Lsr on 10/15/14.
 */
public interface KikiMapper {

    public List<Kiki> findAllKiki();

    public Kiki findKikiById(int KikiId);

    public List<Kiki> findKikiBySysId(int KikiSysId);

    public void insertKiki(Kiki kiki);

    public int getLastInsertId();

    public void updateKikiByKiki(Kiki kiki);

    public void deleteKikiByKikiId(int kiki);

    void deleteKikiByKikiSysId(Integer kikiSysId);

    List<Kiki> findTenKiki();
}
