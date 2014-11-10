package com.ValdacBeta.service;

import java.io.*;
import com.ValdacBeta.dao.BuhinMapper;
import com.ValdacBeta.dao.KikiMapper;
import com.ValdacBeta.dao.ValveMapper;
import com.ValdacBeta.dto.SearchResultObject;
import com.ValdacBeta.entity.Buhin;
import com.ValdacBeta.entity.Kiki;
import com.ValdacBeta.entity.Valve;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.*;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.RAMDirectory;
import org.apache.lucene.util.Version;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;


/**
 * Created by Lsr on 10/21/14.
 */

@Service
public class SearchService {

    @Resource
    BuhinMapper buhinMapper;

    @Resource
    KikiMapper kikiMapper;

    @Resource
    ValveMapper valveMapper;

    public List<Valve> searchValveByKeywords(String keywords){
        return null;
    }

    public List<Kiki> searchKikiByKeywords(String keywords){
        return null;
    }

    public List<Buhin> searchBuhinByKeywords(String Buhin){
        return null;
    }

    public List<SearchResultObject> generateIndex(String keywords) throws IOException, ParseException {
        List<SearchResultObject> resultObjectList = new ArrayList<SearchResultObject>();
        // 0. Specify the analyzer for tokenizing text.
        //    The same analyzer should be used for indexing and searching
        StandardAnalyzer analyzer = new StandardAnalyzer(Version.LUCENE_40);

        // 1. create the index
        Directory index = new RAMDirectory();

        IndexWriterConfig config = new IndexWriterConfig(Version.LUCENE_40, analyzer);

        IndexWriter w = null;
        w = new IndexWriter(index, config);
        initDoc(w);
        w.close();

        // 2. query
        String tmpKeyword = "";

        String words[] = keywords.split(" ");

        for(int i = 0;i<words.length;i++){

            //trim
            if(words[i].length()<1)
                continue;

            words[i] = words[i].replace("-"," AND ");
            words[i] = words[i].replace("/"," AND ");

            //judge wheather it is String
            if(words[i].charAt(0) != '0'){
                try{
                    Integer.valueOf(words[i]);
                    words[i] = words[i] + "*";
                } catch (Exception e){
                }
            }

            if(i == words.length-1){
                tmpKeyword = tmpKeyword + words[i];
            } else {
                tmpKeyword = tmpKeyword + words[i] + " AND ";
            }
        }

        String querystr = tmpKeyword;

        Query q = null;
        QueryParser queryParser = new QueryParser(Version.LUCENE_40,"body", analyzer);
        q = queryParser.parse(querystr);

        // 3. search
        int hitsPerPage = 10;
        IndexReader reader = DirectoryReader.open(index);
        IndexSearcher searcher = new IndexSearcher(reader);

        TopScoreDocCollector collector = TopScoreDocCollector.create(hitsPerPage, true);
        searcher.search(q, collector);
        ScoreDoc[] hits = collector.topDocs().scoreDocs;

        // 4. display results
        for(int i=0;i<hits.length;++i) {
            int docId = hits[i].doc;
            Document d = searcher.doc(docId);
            SearchResultObject tmpObj = new SearchResultObject();
            tmpObj.setId(d.get("id"));
            tmpObj.setBody(d.get("body"));
            resultObjectList.add(tmpObj);
        }

        reader.close();
        return resultObjectList;
    }

    private void initDoc(IndexWriter w) throws IOException {

        List<Valve> valveList = valveMapper.findAllValve();
        w.deleteAll();

        for(int i = 0;i < valveList.size();i++){
            Document doc = new Document();
            doc.add(new IntField("id", valveList.get(i).getKikiSysId(), Field.Store.YES));
            doc.add(new TextField("body", valveList.get(i).toText(), Field.Store.YES));
            doc.add(new IntField("trkDate", valveList.get(i).getTrkDateInt(), Field.Store.YES));
            doc.add(new IntField("updDate", valveList.get(i).getUpdDateInt(), Field.Store.YES));

            w.addDocument(doc);
        }
    }

}
