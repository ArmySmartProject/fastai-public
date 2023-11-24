package ai.maum.biz.fastaicc.main.cousult.voc.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.response.FacetField;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmSttResultDetailVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.voc.domain.HmdResultVO;
import ai.maum.biz.fastaicc.main.cousult.voc.domain.VocAnalyPagingVO;
import ai.maum.biz.fastaicc.main.cousult.voc.domain.VocNegVO;
import ai.maum.biz.fastaicc.main.cousult.voc.service.VocAnalysisService;
import lombok.extern.java.Log;

@Log
@Controller
public class VocAnalysisController {


    @Autowired
    private VocAnalysisService vocAnalysisService;

    @Value("${solr.url}")
    private String solrUrl;

    @Value("${solr.en_url}")
    private String solrEnUrl;

    @Value("${audio.ip}")
    private String audioIp;

    @Value("${audio.port}")
    private String aurioPort;

    @Inject
    private VariablesMng variablesMng;

    @RequestMapping(value = "/analysis/vocAnalysisMain", method = {RequestMethod.GET, RequestMethod.POST})
    public String vocAnalysisMain(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
        req.setAttribute("menuId", "m19");
        model.addAttribute("pageContents", frontMntVO.getPageContents());
        return "analysis/vocAnalysisMain";
    }

    @RequestMapping(value = "/analysis/highFrequencyKeyword", method = {RequestMethod.GET, RequestMethod.POST})
    public String highFrequencyKeyword(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
        return "analysis/highFrequencyKeyword";
    }

    @RequestMapping(value = "/analysis/inputReasonClassification", method = {RequestMethod.GET, RequestMethod.POST})
    public String inputReasonClassification(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {
        return "analysis/inputReasonClassification";
    }


    @ResponseBody
    @RequestMapping(value = "/getHmdResult", method = {RequestMethod.POST})
    public Map<String, Object> getHmdResult(FrontMntVO frontMntVO) {
        List<HmdResultVO> result = vocAnalysisService.getHmdResult(frontMntVO);

        int totalCnt = vocAnalysisService.getHmdResultCnt(frontMntVO);
        frontMntVO.setTotalCnt(totalCnt);
        VocAnalyPagingVO pagingVO = goPage(frontMntVO);

        Map<String, Object> map = new HashMap<>();
        map.put("list", result);
        map.put("pagingVO", pagingVO);

        return map;
    }

    @ResponseBody
    @RequestMapping(value = "/getHmdResultDetail", method = {RequestMethod.POST})
    public Map<String, Object> getHmdResultDetail(FrontMntVO frontMntVO) {
        List<HmdResultVO> result = vocAnalysisService.getHmdResultDetail(frontMntVO);

        int totalCnt = vocAnalysisService.getHmdResultDetailCnt(frontMntVO);
        frontMntVO.setTotalCnt(totalCnt);
        VocAnalyPagingVO pagingVO = goPage(frontMntVO);

        Map<String, Object> map = new HashMap<>();
        map.put("list", result);
        map.put("pagingVO", pagingVO);

        return map;
    }


    @ResponseBody
    @RequestMapping(value = "/getHighFrequencyKeyword", method = {RequestMethod.POST})
    public List<HashMap<String, ?>> getHighFrequencyKeyword(FrontMntVO frontMntVO) {
        SimpleDateFormat utcDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX");
        utcDateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));

        String startDateStr = frontMntVO.getStartDate() + "T" + "00:00:00Z";
        String endDateStr = frontMntVO.getEndDate() + "T" + "23:59:59Z";

       /* Date startUtcDate = utcDateFormat.parse(startDateStr);
        Date endUtcDate = utcDateFormat.parse(endDateStr);

        String startUtcDateStr = utcDateFormat.format(startUtcDate);
        String endUtcDateStr = utcDateFormat.format(endUtcDate);*/

        String solrUrlIn = solrUrl;
        String lang = frontMntVO.getLang();
        if(lang == null)
        {
            lang = "ko";
        }

        if(lang.equals("en"))
        {
            solrUrlIn = solrEnUrl;
        }

        SolrClient solr = new HttpSolrClient.Builder(solrUrlIn).build();
        SolrQuery query = new SolrQuery();

//      String param = "create_time:" + "[" + startUtcDateStr + " TO " + endUtcDateStr + "]";

        String param = "created_dtm:" + "[" + startDateStr + " TO " + endDateStr + "]";

        if (!StringUtils.isEmpty(frontMntVO.getSpeakerCode())) {
            param += " AND speaker_code:" + frontMntVO.getSpeakerCode();
        }
        if (!StringUtils.isEmpty(frontMntVO.getKeyword())) {
            param += "AND sentence:" + frontMntVO.getKeyword();
        }

        query.setQuery(param);
        query.setRows(0);
        query.setFacet(true);
        query.addFacetField("sentence");
        QueryResponse rsp = null;
        try {
            log.info("query: " + query);
            rsp = solr.query(query);
        } catch (SolrServerException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        List<FacetField> ffList = rsp.getFacetFields();
        log.info("FacetField: " + ffList);
        List result = new ArrayList();
        for (FacetField ff : ffList) {
            List<FacetField.Count> fcList = ff.getValues();
            int count = 0;
            for (FacetField.Count fc : fcList) {
                if (fc.getCount() == 0) {
                    continue;
                }

                HashMap row = new HashMap();
                row.put("no", ++count);
                row.put("keyword", fc.getName());
                row.put("count", fc.getCount());

                if (!StringUtils.isEmpty(frontMntVO.getKeyword())) { // 동일 키워드일때 제외 포함 5개만 출력
                    if (count >= 7) {
                        break;
                    } else if (frontMntVO.getKeyword().equals(fc.getName())) { //동일 키워드일때는 생략
                        continue;
                    }
                } else {
                    FrontMntVO frontMntVO2 = new FrontMntVO();
                    frontMntVO2.setStartDate(frontMntVO.getStartDate());
                    frontMntVO2.setEndDate(frontMntVO.getEndDate());
                    frontMntVO2.setLang(frontMntVO.getLang());
                    frontMntVO2.setKeyword(fc.getName());

                    List<HashMap<String, ?>> associatedKeyword = getHighFrequencyKeyword(frontMntVO2);
                    row.put("associatedKeyword", associatedKeyword);
                }
                result.add(row);
            }
        }
        log.info("result: " + result);
        return result;
    }

    @ResponseBody
    @RequestMapping(value = "/getHighFrequencyKeywordDetail", method = {RequestMethod.POST})
    public List<HashMap<String, ?>> getHighFrequencyKeywordDetail(FrontMntVO frontMntVO) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat utcDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX");
        utcDateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));

        String startDateStr = frontMntVO.getStartDate() + "T" + "00:00:00Z";
        String endDateStr = frontMntVO.getEndDate() + "T" + "23:59:59Z";

        String solrUrlIn = solrUrl;
        String lang = frontMntVO.getLang();
        if(lang == null)
        {
            lang = "ko";
        }

        if(lang.equals("en"))
        {
            solrUrlIn = solrEnUrl;
        }

        SolrClient solr = new HttpSolrClient.Builder(solrUrlIn).build();
        SolrQuery query = new SolrQuery();

        String param = "created_dtm:" + "[" + startDateStr + " TO " + endDateStr + "]";

        if (!StringUtils.isEmpty(frontMntVO.getSpeakerCode())) {
            param += " AND speaker_code:" + frontMntVO.getSpeakerCode();
        }
        if (!StringUtils.isEmpty(frontMntVO.getKeyword())) {
            param += " AND sentence:" + frontMntVO.getKeyword();
        }

        query.setQuery(param);
        query.setRows(Integer.MAX_VALUE);

        QueryResponse rsp = null;
        ArrayList result = new ArrayList();

        try {
            rsp = solr.query(query);
        } catch (SolrServerException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        SolrDocumentList solrDocumentList = rsp.getResults();
        int numFound = (int) solrDocumentList.getNumFound();
        HashMap<String, Object> firstRow = new HashMap<>();
        firstRow.put("numFound", numFound);
        result.add(firstRow);

        for (SolrDocument solrDocument : solrDocumentList) {
            Collection<String> fieldNames = solrDocument.getFieldNames();
            HashMap<String, Object> solrRow = new HashMap<>();
            for (String key : fieldNames) {
                if (key.equals("created_dtm")) {
                    Date date = (Date) solrDocument.getFieldValue(key);
                    solrRow.put(key, format.format(date));
                    continue;
                } else if (key.equals("speaker_code")) {
                    if (solrDocument.getFieldValue(key).equals("ST0001")) {
                        solrRow.put("speaker", lang.equals("en") == true ? "customer" : "고객");
                    } else if (solrDocument.getFieldValue(key).equals("ST0002")) {
                        solrRow.put("speaker", lang.equals("en") == true ? "agent" :"상담사");
                    } else {
                        solrRow.put("speaker", lang.equals("en") == true ? "mono" : "모노");
                    }
                }
                solrRow.put(key, solrDocument.getFieldValue(key));
            }
            result.add(solrRow);

        }
        return result;

    }


    @RequestMapping(value = "/analysis/negativeCustomerManagement", method = {RequestMethod.GET, RequestMethod.POST})
    public String negativeCustomerManagement(FrontMntVO frontMntVO, HttpServletRequest req, Model model) {

        return "analysis/negativeCustomerManagement";
    }


    private VocAnalyPagingVO goPage(FrontMntVO frontMntVO) {

        int curPage = (int) ((double) frontMntVO.getPage() / (double) frontMntVO.getAmount()) + 1;
        if (curPage < 1) {
            curPage = 1;
        }
        int amount = frontMntVO.getAmount();
        int totalCnt = frontMntVO.getTotalCnt();

        VocAnalyPagingVO pagingVO = new VocAnalyPagingVO(amount, 5);
        pagingVO.setTotalCount(totalCnt);
        pagingVO.setCurrentPage(String.valueOf(curPage));

        log.info("goPage: " + pagingVO.toString());

        return pagingVO;
    }


    @ResponseBody
    @PostMapping("/analysis/negativeCustomerManagement/updateCallNum")
    public String updateCallNum(FrontMntVO frontMntVO) {

        log.info("updateCallNum: " + frontMntVO.toString());

        VocNegVO callNumDTO = vocAnalysisService.getCallNum(
                frontMntVO
        );

        Gson gson = new Gson();
        String sentCallNum = gson.toJson(callNumDTO);

        return sentCallNum;
    }

    @ResponseBody
    @PostMapping("/analysis/negativeCustomerManagement/updateResultByKeyword")
    public String updateResultByKeyword(FrontMntVO frontMntVO) {

        log.info("updateResultByKeyword: " + frontMntVO.toString());

        List<VocNegVO> negRetList = vocAnalysisService.getNegRetList(
                frontMntVO
        );

        frontMntVO.setTotalCnt(vocAnalysisService.getNegRetCnt(
                frontMntVO
        ));
        VocAnalyPagingVO pagingVO = goPage(frontMntVO);

        Map<String, Object> map = new HashMap<>();
        map.put("negList", negRetList);
        map.put("pagingVO", pagingVO);

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        String ret = gson.toJson(map);

        return ret;
    }


    @ResponseBody
    @PostMapping("/analysis/negativeCustomerManagement/getSearchResult")
    public String getSearchResult(FrontMntVO frontMntVO) {

        log.info("getSearchResult: " + frontMntVO.toString());

        List<VocNegVO> keywordList = vocAnalysisService.getKeywordList(
                frontMntVO
        );

        frontMntVO.setTotalCnt(vocAnalysisService.getKeywordCnt(
                frontMntVO
        ));
        VocAnalyPagingVO pagingVO = goPage(frontMntVO);

        Map<String, Object> map = new HashMap<>();
        map.put("keywordList", keywordList);
        map.put("pagingVO", pagingVO);

        Gson gson = new Gson();
        String ret = gson.toJson(map);

        return ret;
    }

    @ResponseBody
    @RequestMapping(value = "/getSttText", method = {RequestMethod.POST})
    public List<CmSttResultDetailVO> getSttText(FrontMntVO frontMntVO) {
        List<CmSttResultDetailVO> result = vocAnalysisService.getSttText(frontMntVO);
        return result;
    }

    @ResponseBody
    @RequestMapping(value = "/getAudioInfo", method = {RequestMethod.POST})
    public CmContractVO getAudioInfo(FrontMntVO frontMntVO) {
        CmContractVO result = vocAnalysisService.getAudioInfo(frontMntVO);
        String audioUrl = audioIp + aurioPort;
        result.setAudioUrl(audioUrl);
        return result;
    }
}
