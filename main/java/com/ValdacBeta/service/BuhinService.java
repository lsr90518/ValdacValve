package com.ValdacBeta.service;

import com.ValdacBeta.dao.BuhinMapper;
import com.ValdacBeta.entity.Buhin;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by Lsr on 10/18/14.
 */

@Service
public class BuhinService {

    @Resource
    BuhinMapper buhinMapper;
    private Buhin buhinByBuhinId;

    public List<Buhin> getAllBuhins(){
        return buhinMapper.findAllBuhins();
    }

    public Buhin addBuhin(Buhin buhin){
        //append Date
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
        buhin.setTrkDate(sdf1.format(date));
        buhin.setUpdDate(sdf1.format(date));
        buhinMapper.insertBuhin(buhin);

        //make id
        buhin.setBuhinId(buhinMapper.getLastInsertId());
        return buhin;
    }

    public void updateBuhinByBuhin(Buhin buhin){
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
        buhin.setUpdDate(sdf1.format(date));

        buhinMapper.updateBuhinByBuhin(buhin);
    }

    public void deleteBuhinByBuhinId(String buhinId){
        buhinMapper.deleteBuhinByBuhinId(Integer.valueOf(buhinId));
    }

    public List<Buhin> getBuhinByKikiId(int kikiId){
        List<Buhin> buhinList = buhinMapper.findBuhinByKikiId(kikiId);
        return buhinList;
    }

    public Buhin getBuhinById(String buhinId){
        return buhinMapper.findBuhinById(Integer.valueOf(buhinId));
    }

    public void deleteBuhinByKikiSysId(String kikiSysId){
        buhinMapper.deleteBuhinByKikiSysId(Integer.valueOf(kikiSysId));
    }

    public void deleteBuhinByKikiId(String kikiId){
        buhinMapper.deleteBuhinByKikiId(Integer.valueOf(kikiId));

    }

    public List<Buhin> getTenBuhins() {
        return buhinMapper.findTenBuhin();
    }
}
