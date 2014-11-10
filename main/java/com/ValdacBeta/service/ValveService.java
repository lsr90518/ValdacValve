package com.ValdacBeta.service;

import com.ValdacBeta.dao.ValveMapper;
import com.ValdacBeta.entity.Valve;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Lsr on 10/14/14.
 */

@Service
public class ValveService {

    @Resource
    ValveMapper valveMapper;

    public List<Valve> getAllValves(){
        List<Valve> valveList = valveMapper.findAllValve();
        return valveList;
    }

    public Valve addValve(Valve valve){

        //make sub id
        valve.setkCode("");
        valve.setKikiSysSeq("");

        //append Date
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
        valve.setTrkDate(sdf1.format(date));
        valve.setUpdDate(sdf1.format(date));

        valveMapper.insertValve(valve);

        //append id
        valve.setKikiSysId(valveMapper.getLastInsertId());
        return valve;
    }

    public List<Valve> getTenValves() {
        return valveMapper.findTenValves();
    }

    public List<Valve> getLastTenValves(){
        return valveMapper.findLastTenValves();
    }

    public Valve getValveByKikiSysId(String kikiSysId) {
        return valveMapper.findValveByKikiSysId(Integer.valueOf(kikiSysId));
    }

    public void deleteKikiSystemByKikiSysId(String kikiSysId) {
        valveMapper.deleteKikiSystemByKikiSysId(Integer.valueOf(kikiSysId));
    }

    public void updateValve(Valve valve) {
        //append Date
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
        valve.setUpdDate(sdf1.format(date));
        valveMapper.updateValveByValve(valve);
    }

    public void updateValveDateById(String id) {
        //append Date
        Valve valve = new Valve();
        valve.setKikiSysId(Integer.valueOf(id));
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
        valve.setUpdDate(sdf1.format(date));
        valveMapper.updateValveDateById(valve);
    }

    public List<Valve> getLastUpdateTenValves() {
        return valveMapper.findLastUpdateTenValves();
    }
}
