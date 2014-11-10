package com.ValdacBeta.dao;

import com.ValdacBeta.entity.Kikisystemrelation;

import java.util.List;

/**
 * Created by Lsr on 10/27/14.
 */
public interface KikisystemrelationMapper {

    public List<Kikisystemrelation> findAllRelation();

    List<Integer> findKikiIdsByKikiSysId(Integer kikiSysId);

    List<Integer> findBuhinIdsByKikiSysId(Integer kikiSysId);

    List<Kikisystemrelation> findAllByKikiSysId(Integer kikiSysId);

    public void deleteItemsByKikiSysId(Integer kikiSysId);

    void insertKikiSysId(int kikiSysId);

    void insertValveKiki(Integer kikiSysId, int kikiId);

    void insertRecord(Kikisystemrelation kikisystemrelation);

    int findkikiSysIdByKikiId(Integer kikiid);

    Kikisystemrelation findItemByBuhinid(Integer buhinid);
}
