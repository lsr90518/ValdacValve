package com.ValdacBeta.controller;

import com.ValdacBeta.dto.BuhinForm;
import com.ValdacBeta.dto.KikiForm;
import com.ValdacBeta.dto.ValveForm;
import com.ValdacBeta.entity.*;
import com.ValdacBeta.service.*;
import com.google.gson.Gson;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * Created by Lsr on 10/27/14.
 */

@Controller
@RequestMapping("item")
public class ItemController {
    @Autowired
    ValveService valveService;
    @Autowired
    KikiService kikiService;
    @Autowired
    BuhinService buhinService;
    @Autowired
    KikisystemrelationService kikisystemrelationService;
    @Autowired
    LuceneIndexService luceneIndexService;
    @Autowired
    ImageService imageService;

    @RequestMapping(method = RequestMethod.GET)
    public String index(HttpSession session, ModelMap modelMap){

        return "redirect:/search";
    }

    @RequestMapping(value = "/{kikiSysId}", method = RequestMethod.GET)
    public String getItemByKikisysid(@PathVariable String kikiSysId,ModelMap modelMap, HttpSession session){
//        if((User)session.getAttribute("user") != null){
        Valve valve = valveService.getValveByKikiSysId(kikiSysId);
        modelMap.addAttribute("valve",valve);

        List<Kiki> kikiList = kikiService.getKikiBySysId(kikiSysId);
        modelMap.addAttribute("kikiList",kikiList);

        return "valve/addvalvekiki";
//        } else {
//            return "login";
//        }
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String add(HttpSession session){

//        if((User)session.getAttribute("user") != null){
            return "valve/addvalve";
//        } else {
//            return "login";
//        }
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addvlave(@ModelAttribute("ValveForm")ValveForm valveForm, ModelMap modelMap,HttpSession session){
        Valve valve = new Valve();
        valve.makeupValveByForm(valveForm);

        //insert into kikisystem table
        valve = valveService.addValve(valve);

        //insert into relation table
        kikisystemrelationService.addKikiSysId(valve.getKikiSysId());

        //insert index
        String indexPath = (String) session.getAttribute("indexPath");
        Directory index = null;
        try {
            index = FSDirectory.open(new File(indexPath));
        } catch (IOException e) {
            System.out.println("index read error");
            e.printStackTrace();
        }
        luceneIndexService.insertRecord(index,valve.getKikiSysId(),valve.toText(),valve.getTrkDateInt(),valve.getUpdDateInt());

        return "redirect:/item/"+valve.getKikiSysId();
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public String edit(@ModelAttribute("ValveForm")ValveForm valveForm, ModelMap modelMap, HttpSession session){
        Valve valve = new Valve();
        valve.makeupValveByForm(valveForm);
        valve.setKikiSysId(valveForm.getKikiSysId());

        valveService.updateValve(valve);

        List<Kiki> kikiList = kikiService.getKikiBySysId(""+valveForm.getKikiSysId());
        modelMap.addAttribute("kikiList",kikiList);

        modelMap.addAttribute("valve",valve);
        modelMap.addAttribute("message","更新完了");
        session.setAttribute("valve",valve);

        return "valve/addvalvekiki";
    }

    @RequestMapping(value = "/{kikiSysId}/delete", method = RequestMethod.GET)
    public String deleteValveById(@PathVariable String kikiSysId, HttpSession session){
        valveService.deleteKikiSystemByKikiSysId(kikiSysId);

        //update index
        String indexPath = (String) session.getAttribute("indexPath");
        Directory index = null;
        try {
            index = FSDirectory.open(new File(indexPath));
        } catch (IOException e) {
            System.out.println("index read error");
            e.printStackTrace();
        }
        luceneIndexService.deleteRecord(index,Integer.valueOf(kikiSysId));

        return "redirect:/item";
    }

    @RequestMapping(value = "/getAllValveJson", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getCandidateJson(){
        List<Valve> valveList = valveService.getAllValves();
        Gson gson = new Gson();
        return gson.toJson(valveList);
    }

    @RequestMapping(value = "/{kikiSysId}/add", method = RequestMethod.POST)
    public String addValveKiki(@ModelAttribute("KikiForm")KikiForm kikiForm, ModelMap modelMap, @PathVariable String kikiSysId,HttpSession session){

        Kiki kiki = new Kiki();
        kiki.makeupValveByForm(kikiForm);
        kiki = kikiService.addKiki(kiki);

        Kikisystemrelation kikisystemrelation = new Kikisystemrelation();
        kikisystemrelation.setKikiid(kiki.getKikiId());
        kikisystemrelation.setKikisysid(Integer.valueOf(kikiSysId));
        kikisystemrelationService.addRecord(kikisystemrelation);


        //insert index
        String indexPath = (String) session.getAttribute("indexPath");
        Directory index = null;
        try {
            index = FSDirectory.open(new File(indexPath));
        } catch (IOException e) {
            System.out.println("index read error");
            e.printStackTrace();
        }
        luceneIndexService.insertRecord(index,kiki.getKikiId(),kiki.toText(),kiki.getTrkDateInt(),kiki.getUpdDateInt());

        return "redirect:/item/"+kikiSysId;
    }

    @RequestMapping(value = "/{kikiSysId}/{kikiId}", method = RequestMethod.GET)
    public String getKikiByKikiId(@PathVariable String kikiSysId,
                                  @PathVariable String kikiId,
                                  ModelMap modelMap,
                                  HttpSession session){
        Valve valve = valveService.getValveByKikiSysId(kikiSysId);
        Kiki kiki = kikiService.getKikiByKikiId(kikiId);
        List<Image> imageList = imageService.getImagesByKikiId(kikiId);

        modelMap.addAttribute("valve",valve);
        modelMap.addAttribute("kiki",kiki);
        modelMap.addAttribute("imageList",imageList);


        List<Buhin> buhinList = buhinService.getBuhinByKikiId(Integer.valueOf(kikiId));
        modelMap.addAttribute("buhinList",buhinList);

        return "kiki/addkiki";
    }

    @RequestMapping(value = "/{kikiSysId}/{kikiId}/edit", method = RequestMethod.POST)
    public String editKiki(@PathVariable String kikiSysId,
                           @PathVariable String kikiId,
                           @ModelAttribute("KikiForm") KikiForm kikiForm,
                           ModelMap modelMap,
                           HttpSession session){
        Kiki kiki = new Kiki();
        kiki.makeupValveByForm(kikiForm);
        kiki.setKikiId(kikiForm.getKikiId());
        kikiService.updateKikiByKiki(kiki);
        valveService.updateValveDateById(kikiSysId);
        List<Image> imageList = imageService.getImagesByKikiId(kikiId);
        modelMap.addAttribute("imageList",imageList);

        Valve valve = valveService.getValveByKikiSysId(kikiSysId);

        modelMap.addAttribute("valve",valve);
        modelMap.addAttribute("kiki",kiki);

        List<Buhin> buhinList = buhinService.getBuhinByKikiId(Integer.valueOf(kikiId));
        modelMap.addAttribute("buhinList",buhinList);
        modelMap.addAttribute("message","更新完了");

        return "kiki/addkiki";
    }

    @RequestMapping(value = "/{kikiSysId}/{kikiId}/delete", method = RequestMethod.GET)
    public String deleteKiki(@PathVariable String kikiSysId,
                             @PathVariable String kikiId,
                             ModelMap modelMap,
                             HttpSession session){
        kikiService.deleteKikiByKikiByKikiId(kikiId);

        //update index
        String indexPath = (String) session.getAttribute("indexPath");
        Directory index = null;
        try {
            index = FSDirectory.open(new File(indexPath));
        } catch (IOException e) {
            System.out.println("index read error");
            e.printStackTrace();
        }
        luceneIndexService.deleteRecord(index,Integer.valueOf(kikiId));

        return "redirect:/item/"+kikiSysId;
    }

    @RequestMapping(value = "/{kikiSysId}/{kikiId}/add", method = RequestMethod.POST)
    public String addBuhin(@PathVariable String kikiSysId,
                           @PathVariable String kikiId,
                           @ModelAttribute("BuhinForm")BuhinForm buhinForm,
                           ModelMap modelMap,
                           HttpSession session){
        Buhin buhin = new Buhin();
        buhin.makeupValueByForm(buhinForm);
        buhin = buhinService.addBuhin(buhin);

        Kikisystemrelation kikisystemrelation = new Kikisystemrelation();
        kikisystemrelation.setKikiid(Integer.valueOf(kikiId));
        kikisystemrelation.setKikisysid(Integer.valueOf(kikiSysId));
        kikisystemrelation.setBuhinid(buhin.getBuhinId());
        kikisystemrelationService.addRecord(kikisystemrelation);


        //insert index
        String indexPath = (String) session.getAttribute("indexPath");
        Directory index = null;
        try {
            index = FSDirectory.open(new File(indexPath));
        } catch (IOException e) {
            System.out.println("index read error");
            e.printStackTrace();
        }
        luceneIndexService.insertRecord(index,buhin.getBuhinId(),buhin.toText(),buhin.getTrkDateInt(),buhin.getUpdDateInt());

        return "redirect:/item/"+kikiSysId+"/"+kikiId;
    }

    @RequestMapping(value = "/{kikiSysId}/{kikiId}/{buhinId}",method = RequestMethod.GET)
    public String getBuhin(@PathVariable String kikiSysId,
                           @PathVariable String kikiId,
                           @PathVariable String buhinId,
                           ModelMap modelMap,
                           HttpSession session){
        Valve valve = valveService.getValveByKikiSysId(kikiSysId);
        Kiki kiki = kikiService.getKikiByKikiId(kikiId);
        Buhin buhin = buhinService.getBuhinById(buhinId);
        List<Image> imageList = imageService.getImagesByBuhinId(buhinId);

        modelMap.addAttribute("valve",valve);
        modelMap.addAttribute("kiki",kiki);
        modelMap.addAttribute("buhin",buhin);
        modelMap.addAttribute("imageList",imageList);

        return "buhin/addbuhin";
    }

    @RequestMapping(value = "/{kikiSysId}/{kikiId}/{buhinId}/edit", method = RequestMethod.POST)
    public String editBuhin(@PathVariable String kikiSysId,
                            @PathVariable String kikiId,
                            @PathVariable String buhinId,
                            @ModelAttribute("BuhinForm")BuhinForm buhinForm,
                            ModelMap modelMap,
                            HttpSession session){
        Buhin buhin = new Buhin();
        buhin.makeupValueByForm(buhinForm);
        buhin.setBuhinId(buhinForm.getBuhinId());
        buhinService.updateBuhinByBuhin(buhin);
        valveService.updateValveDateById(kikiSysId);
        List<Image> imageList = imageService.getImagesByBuhinId(buhinId);
        modelMap.addAttribute("imageList",imageList);

        Valve valve = valveService.getValveByKikiSysId(kikiSysId);
        Kiki kiki = kikiService.getKikiByKikiId(kikiId);
        modelMap.addAttribute("valve",valve);
        modelMap.addAttribute("kiki",kiki);
        modelMap.addAttribute("buhin",buhin);
        modelMap.addAttribute("message","更新完了");
        return "buhin/addbuhin";
    }

    @RequestMapping(value = "/{kikiSysId}/{kikiId}/{buhinId}/delete", method = RequestMethod.GET)
    public String deleteBuhin(@PathVariable String kikiSysId,
                              @PathVariable String kikiId,
                              @PathVariable String buhinId,
                              HttpSession session){
        buhinService.deleteBuhinByBuhinId(buhinId);
        //update index
        String indexPath = (String) session.getAttribute("indexPath");
        Directory index = null;
        try {
            index = FSDirectory.open(new File(indexPath));
        } catch (IOException e) {
            System.out.println("index read error");
            e.printStackTrace();
        }
        luceneIndexService.deleteRecord(index,Integer.valueOf(buhinId));
        return "redirect:/item/"+kikiSysId+"/"+kikiId;
    }
}
