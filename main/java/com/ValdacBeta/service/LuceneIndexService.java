package com.ValdacBeta.service;

import com.ValdacBeta.dao.BuhinMapper;
import com.ValdacBeta.dao.KikiMapper;
import com.ValdacBeta.dao.ValveMapper;
import com.ValdacBeta.dto.SearchResultObject;
import com.ValdacBeta.entity.Buhin;
import com.ValdacBeta.entity.Kiki;
import com.ValdacBeta.entity.Valve;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.IntField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.*;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopScoreDocCollector;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.store.RAMDirectory;
import org.apache.lucene.util.Version;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Lsr on 10/29/14.
 */

@Service
public class LuceneIndexService {

    @Resource
    BuhinMapper buhinMapper;

    @Resource
    KikiMapper kikiMapper;

    @Resource
    ValveMapper valveMapper;

    public List<SearchResultObject> generateIndexTest(String keywords) throws IOException, ParseException {
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

    public Directory generateRAMIndex(){
        StandardAnalyzer analyzer = new StandardAnalyzer(Version.LUCENE_40);

        // 1. create the index
        Directory index = new RAMDirectory();

        IndexWriterConfig config = new IndexWriterConfig(Version.LUCENE_40, analyzer);

        IndexWriter w = null;
        try {
            w = new IndexWriter(index, config);
            initDoc(w);
            w.close();
        } catch (IOException e) {
            System.out.println("Index create failed");
            e.printStackTrace();
        }

        return index;
    }

    private void initDoc(IndexWriter w) throws IOException {

        List<Valve> valveList = valveMapper.findAllValve();

        for(int i = 0;i < valveList.size();i++){
            Document doc = new Document();
            doc.add(new TextField("id", valveList.get(i).getKikiSysId()+"", Field.Store.YES));
            doc.add(new TextField("body", valveList.get(i).toText(), Field.Store.YES));

            w.addDocument(doc);
        }

        List<Kiki> kikiList = kikiMapper.findAllKiki();

        for(int i = 0;i < kikiList.size();i++){
            Document doc = new Document();
            doc.add(new TextField("id", kikiList.get(i).getKikiId()+"", Field.Store.YES));
            doc.add(new TextField("body", kikiList.get(i).toText(), Field.Store.YES));

            w.addDocument(doc);
        }
        List<Buhin> buhinList = buhinMapper.findAllBuhins();

        for(int i = 0;i < buhinList.size();i++){
            Document doc = new Document();
            doc.add(new TextField("id", buhinList.get(i).getBuhinId()+"", Field.Store.YES));
            doc.add(new TextField("body", buhinList.get(i).toText(), Field.Store.YES));

            w.addDocument(doc);
        }
    }

    public void insertRecord(Directory index,int id, String body, int trkDate, int updDate){
        StandardAnalyzer analyzer = new StandardAnalyzer(Version.LUCENE_40);
        IndexWriterConfig config = new IndexWriterConfig(Version.LUCENE_40, analyzer);
        IndexWriter w = null;
        try {
            Document doc = new Document();
            doc.add(new TextField("id", id+"", Field.Store.YES));
            doc.add(new TextField("body", body, Field.Store.YES));
            w = new IndexWriter(index, config);
            w.addDocument(doc);
            w.close();
        } catch (IOException e) {
            System.out.println("add document failed");
            e.printStackTrace();
        }
    }

    public void deleteRecord(Directory index,int id){
        StandardAnalyzer analyzer = new StandardAnalyzer(Version.LUCENE_40);
        IndexWriterConfig config = new IndexWriterConfig(Version.LUCENE_40, analyzer);
        IndexWriter w = null;
        try {
            Document doc = new Document();
            w = new IndexWriter(index, config);
            w.deleteDocuments(new Term("id", id + ""));
            w.close();
        } catch (IOException e) {
            System.out.println("delete document failed");
            e.printStackTrace();
        }
    }

    public void updateRecord(Directory index,int id, String body, int trkDate, int updDate){
        deleteRecord(index,id);
        insertRecord(index,id,body,trkDate,updDate);
    }

    public List<SearchResultObject> selectRecord(Directory index,String keywords){
        List<SearchResultObject> resultObjectList = new ArrayList<SearchResultObject>();
        StandardAnalyzer analyzer = new StandardAnalyzer(Version.LUCENE_40);

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

        Query query = null;
        QueryParser queryParser = new QueryParser(Version.LUCENE_40,"body", analyzer);
        try {
            query = queryParser.parse(querystr);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        // 3. search
        int hitsPerPage = 100;
        IndexReader reader = null;
        try {
            reader = DirectoryReader.open(index);
        } catch (IOException e) {
            System.out.println("can not find index");
            e.printStackTrace();
        }
        IndexSearcher searcher = new IndexSearcher(reader);

        TopScoreDocCollector collector = TopScoreDocCollector.create(hitsPerPage, true);
        try {
            searcher.search(query, collector);
        } catch (IOException e) {
            e.printStackTrace();
        }
        ScoreDoc[] hits = collector.topDocs().scoreDocs;

        // 4. display results
        for(int i=0;i<hits.length;++i) {
            int docId = hits[i].doc;
            Document document = null;
            try {
                document = searcher.doc(docId);

            } catch (IOException e) {
                e.printStackTrace();
            }
            SearchResultObject tmpObj = new SearchResultObject();
            tmpObj.setId(document.get("id"));
            tmpObj.setBody(document.get("body"));
            resultObjectList.add(tmpObj);
        }

        try {
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return resultObjectList;
    }

    public String generateLocalIndex() {
        File indexFile = null;
        try {
            indexFile =  new File("indexDir");
            if(!indexFile.exists()) {
                Directory dir = FSDirectory.open(indexFile);

                StandardAnalyzer analyzer = new StandardAnalyzer(Version.LUCENE_40);
                IndexWriterConfig config = new IndexWriterConfig(Version.LUCENE_40, analyzer);

                IndexWriter w = null;

                w = new IndexWriter(dir, config);
                initDoc(w);
                w.close();
            }

        } catch (IOException e) {
            System.out.println("Index create failed");
            e.printStackTrace();
        }
        System.out.println("index file path:" + indexFile.getAbsolutePath());
        return indexFile.getAbsolutePath();
    }

    public void remakeIndex() {
        File indexFile = null;
        try {
            indexFile =  new File("indexDir");
            Directory dir = FSDirectory.open(indexFile);

            StandardAnalyzer analyzer = new StandardAnalyzer(Version.LUCENE_40);
            IndexWriterConfig config = new IndexWriterConfig(Version.LUCENE_40, analyzer);

            IndexWriter w = null;

            w = new IndexWriter(dir, config);
            initDoc(w);
            w.close();
            System.out.println(indexFile.getAbsolutePath());

        } catch (IOException e) {
            System.out.println("Index remake failed");
            e.printStackTrace();
        }

    }

    public List<SearchResultObject> makeHightLight(String keyword, List<SearchResultObject> tmpResults) {
        List<SearchResultObject> results = new ArrayList<SearchResultObject>();

        String keywords[] = keyword.split(" ");
        for (int i = 0; i < tmpResults.size(); i++) {
            SearchResultObject tmpSRO = tmpResults.get(i);
            String body = tmpSRO.getBody();
            boolean contains = false;
            for (int j = 0; j < keywords.length; j++) {
                //trim
                if(keywords[j].length()<1) {
                    continue;
                } else {
                    String parts[] = body.split(keywords[j]);
                    if(parts.length < 2){
                        //不包含
                        continue;
                    } else {
                        body = body.replace(keywords[j],"$"+keywords[j]+">?");
                        contains = true;
                    }
                }
            }
            if(contains){
                body = body.replace("$","<font color='red'>");
                body = body.replace(">?","</font>");

                tmpSRO.setBody(body);
                results.add(tmpSRO);
            }
        }

        return results;
    }
}
