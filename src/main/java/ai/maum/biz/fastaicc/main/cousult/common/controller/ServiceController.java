package ai.maum.biz.fastaicc.main.cousult.common.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCampaignInfoVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.MntTargetMngVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.CampaignService;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/service")
public class ServiceController {

    @Autowired
    CommonService commonService;

    @Autowired
    CampaignService campaignService;

    @Autowired
    CustomProperties customProperties;

    @Autowired
    VariablesMng variablesMng;

    @RequestMapping(value = "/voiceBot")
    public String voiceBotService(Model model) {
/*
        List<CmCommonCdDTO> schCodeDto = commonService.getSeachCodeList();
        HashMap<String, String> monitoringList = new HashMap<String, String>();

        for(CmCommonCdDTO one : schCodeDto) {
            if( one.getFcd().equals( variablesMng.getMntType() ) ) {
                monitoringList.put( one.getCode(), one.getCd_desc() );
            }
        }

        model.addAttribute("monitoringResultCode", Utils.makeCallStatusTag(monitoringList));*/
        model.addAttribute("websocketUrl", customProperties.getWebsocketProtocol() + "://" + customProperties.getWebsocketIp() + customProperties.getWebsocketPort());

        return "/service/voiceBot";
    }

    @RequestMapping(value = "/getCampaignTaskList")
    @ResponseBody
    public String getCampaignTaskList(int campaignId) {

        List<CmCampaignInfoVO> taskList = campaignService.getCampaignTaskList(campaignId);

        String retListJson = new Gson().toJson(taskList);

        return retListJson;
    }

    @RequestMapping(value = "/createServiceMonitoring")
    @ResponseBody
    public int createServiceMonitoring(MntTargetMngVO mntTargetMngVO) {

        campaignService.createServiceMonitoring(mntTargetMngVO);

        return mntTargetMngVO.getContractNo();
    }

    @RequestMapping(value = "/getCampaignListByService")
    @ResponseBody
    public String getCampaignListByService(String serviceName) {

        List<CmCampaignInfoVO> campaignList = campaignService.getCampaignListByService(serviceName);
        String retListJson = new Gson().toJson(campaignList);
        return retListJson;
    }

    //수동 모니터링 RestFul API 호출
    @RequestMapping(value = "/sendCM", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String serviceSendCM(FrontMntVO frontMntVO) {
        HttpClient hc = HttpClients.createDefault();

        Gson gson = new Gson();
        HashMap<String, String> getJson = new HashMap<String, String>();
        getJson = gson.fromJson(frontMntVO.getSendMsgStr(), getJson.getClass());
        log.debug("serviceSendCM_getJson==="+getJson.toString());
        String callMngUrl = "";
        if (getJson.get("Event").equals("START")) {
            callMngUrl = "http://" + customProperties.getRestIp() + customProperties.getRestPort() + "/call/start";
        } else if (getJson.get("Event").equals("TRANSFER")) {
            callMngUrl = "http://" + customProperties.getRestIp() + customProperties.getRestPort() + "/call/transfer";
        } else if (getJson.get("Event").equals("CLOSE")) {
            callMngUrl = "http://" + customProperties.getRestIp() + customProperties.getRestPort() + "/call/hangup";
        } else if (getJson.get("Event").equals("LISTEN")) {
            callMngUrl = "http://" + customProperties.getRestIp() + customProperties.getRestPort() + "/call/play";
        } else if (getJson.get("Event").equals("STOP")) {
            callMngUrl = "http://" + customProperties.getRestIp() + customProperties.getRestPort() + "/call/stop";
        } else if (getJson.get("Event").equals("DIRECT")) {
        	callMngUrl = "http://" + customProperties.getRestIp() + customProperties.getRestPort() + "/call/direct";
        } else if (getJson.get("Event").equals("HANGUP")) {
        	callMngUrl = "http://" + customProperties.getRestIp() + customProperties.getRestPort() + "/call/hangup";
        }

        HttpPost hp = new HttpPost(callMngUrl);
        StringEntity passJson;
        HttpResponse getRes;

        try {
            passJson = new StringEntity(frontMntVO.getSendMsgStr());

            hp.addHeader("Content-type", "application/json");
            hp.setEntity(passJson);

            getRes = hc.execute(hp);
            String json = EntityUtils.toString(getRes.getEntity(), "UTF-8");
        } catch (Exception e) {
            //log.info("### sendCM : error Message : " + e.getMessage());
        }

        return "SUCC";
    }

  //수동 모니터링 RestFul API 호출
    @RequestMapping(value = "/sendReqMail", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String sendReqMail(@RequestBody String jsonStr) throws JsonParseException, JsonMappingException, IOException {

    	log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(1);
		nameValuePairs.add(new BasicNameValuePair("fromaddr", map.get("fromaddr").toString()));
		nameValuePairs .add(new BasicNameValuePair("toaddr", map.get("toaddr").toString()));
		nameValuePairs.add(new BasicNameValuePair("subject", map.get("subject").toString()));
		nameValuePairs.add(new BasicNameValuePair("message", map.get("message").toString()));

    	HttpClient hc = HttpClients.createDefault();
        log.debug("serviceSendCM_getJson==="+jsonStr);
        String callMngUrl = "https://maum.ai/support/sendMail";

        HttpPost hp = new HttpPost(callMngUrl);
        StringEntity passJson;
        HttpResponse getRes;

        try {
            //passJson = new StringEntity(buffer.toString());

            //hp.addHeader("Content-type", "application/json");
            //hp.setEntity(passJson);
            hp.setEntity(new UrlEncodedFormEntity(nameValuePairs, "utf-8"));

            getRes = hc.execute(hp);
            String json = EntityUtils.toString(getRes.getEntity(), "UTF-8");
        } catch (Exception e) {
            return "FAIL";
        }

        return "SUCC";
    }

}
