package com.ValdacBeta.controller;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.ValdacBeta.dto.SearchResultObject;
import com.ValdacBeta.entity.Buhin;
import com.ValdacBeta.entity.Kiki;
import com.ValdacBeta.entity.Kikisystemrelation;
import com.ValdacBeta.entity.Valve;
import com.ValdacBeta.service.*;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * Created by Lsr on 10/20/14.
 */

@Controller
@RequestMapping("search")
public class SearchController {

    @Autowired
    SearchService searchService;
    @Autowired
    LuceneIndexService luceneIndexService;
    @Autowired
    KikisystemrelationService kikisystemrelationService;
    @Autowired
    ValveService valveService;
    @Autowired
    KikiService kikiService;
    @Autowired
    BuhinService buhinService;

    @RequestMapping(method = RequestMethod.GET)
    public String index(HttpSession session,ModelMap modelMap) throws IOException, ParseException {

        List<Valve> valveList = valveService.getTenValves();
        List<Kiki> kikiList = kikiService.getTenKikis();
        List<Buhin> buhinList = buhinService.getTenBuhins();

        List<SearchResultObject> valveResults = new ArrayList<SearchResultObject>();
        List<SearchResultObject> kikiResults = new ArrayList<SearchResultObject>();
        List<SearchResultObject> buhinResults = new ArrayList<SearchResultObject>();
        for (int i = 0; i < valveList.size(); i++) {
            SearchResultObject searchResultObject = new SearchResultObject();
            searchResultObject.setId(valveList.get(i).getKikiSysId()+"");
            searchResultObject.setBody(valveList.get(i).toText());
            valveResults.add(searchResultObject);
        }
        for (int i = 0; i < kikiList.size(); i++) {
            SearchResultObject searchResultObject = new SearchResultObject();
            searchResultObject.setId(kikiList.get(i).getKikiId()+"");
            searchResultObject.setBody(kikiList.get(i).toText());
            kikiResults.add(searchResultObject);
        }
        for (int i = 0; i < buhinList.size(); i++) {
            SearchResultObject searchResultObject = new SearchResultObject();
            searchResultObject.setId(buhinList.get(i).getBuhinId()+"");
            searchResultObject.setBody(buhinList.get(i).toText());
            buhinResults.add(searchResultObject);
        }

        modelMap.addAttribute("valveResults", valveResults);
        modelMap.addAttribute("kikiResults", kikiResults);
        modelMap.addAttribute("buhinResults", buhinResults);

        return "list";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String query(@RequestParam("keyword")String keyword, ModelMap modelMap,HttpSession session) throws IOException, ParseException {

        String indexPath = (String) session.getAttribute("indexPath");
        Directory index = FSDirectory.open(new File(indexPath));
        List<SearchResultObject> results = luceneIndexService.selectRecord(index, keyword);

        List<SearchResultObject> valveResults = new ArrayList<SearchResultObject>();
        List<SearchResultObject> kikiResults = new ArrayList<SearchResultObject>();
        List<SearchResultObject> buhinResults = new ArrayList<SearchResultObject>();

        //make high light
//        List<SearchResultObject> results = luceneIndexService.makeHightLight(keyword, tmpResults);

        for(int i = 0;i<results.size();i++){
            //判断ID
            if(Integer.valueOf(results.get(i).getId()) < 20000000){
                //valve info
                valveResults.add(results.get(i));
            } else if(Integer.valueOf(results.get(i).getId()) < 40000000) {
                //kiki info

                kikiResults.add(results.get(i));
            } else {
                buhinResults.add(results.get(i));
            }
        }
        modelMap.addAttribute("valveResults",valveResults);
        modelMap.addAttribute("kikiResults",kikiResults);
        modelMap.addAttribute("buhinResults",buhinResults);

        return "list";
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String getItemById(@PathVariable String id){

        String idStr = kikisystemrelationService.getPathById(id);

        return "redirect:/item"+idStr;
    }

    @RequestMapping(value = "/remakeIndex", method = RequestMethod.GET)
    public String remakeIndex(){
        luceneIndexService.remakeIndex();
        return "index";
    }

}
