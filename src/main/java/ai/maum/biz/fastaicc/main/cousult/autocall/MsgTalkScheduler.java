package ai.maum.biz.fastaicc.main.cousult.autocall;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.main.api.controller.CallReservationApiController;
import ai.maum.biz.fastaicc.main.cousult.autocall.domain.MsgTalkInfo;
import ai.maum.biz.fastaicc.main.cousult.autocall.service.BatchService;


@Component
@Configuration
@EnableBatchProcessing
@EnableScheduling
public class MsgTalkScheduler {

	  @Autowired
	  private BatchService batchService;

	  @Autowired
	  CustomProperties customProperties;
	  
	  @Autowired
	  CallReservationApiController callReservationApiController;
	  
	  /*
	    getCallTargetList (YURA API client)
	    req: condition ID
	    res: contract IDS, campainId
	   */
	  public MsgTalkInfo getMsgTalkTargetList(Integer cond) {
		List<Integer> contractList = new ArrayList<Integer>();
	    List<String> custNmList = new ArrayList<String>();
	    List<String> custTelNoList = new ArrayList<String>();
	    List<String> contractNumList = new ArrayList<String>();
	    MsgTalkInfo result = new MsgTalkInfo(cond, -1, null, null, null, null);
	    
	    Map<String, Object> response = new HashMap<>();
	    System.out.println("[getCallTargetList] IN : " + cond.toString());

	    response = callReservationApiController.callReservationApi(cond.toString());

	    ArrayList<String> custNms = (ArrayList)response.get("cust_nms");
	    for (String custNm : custNms) {
	    	custNmList.add(custNm);
	    }
	    
	    ArrayList<String> custTelNos = (ArrayList)response.get("cust_tel_nos");
	    for (String custTelNo : custTelNos) {
	    	custTelNoList.add(custTelNo);
	    }
	    
	    ArrayList<String> contractNums = (ArrayList)response.get("contract_nums");
	    for(String contractNum : contractNums) {
	    	contractNumList.add(contractNum);
	    }
	    
	    ArrayList<String> contractNos = (ArrayList)response.get("contract_nos");
	    for (String contractNo : contractNos) {
	      contractList.add(Integer.parseInt(contractNo));
	    }

	    Integer camp = Integer.parseInt(String.valueOf(response.get("campaign_id")));
	    result.setCustNms(custNmList);
	    result.setCustTelNos(custTelNoList);
	    result.setContractNums(contractNumList);
	    result.setContractIds(contractList);
	    result.setCampaignId(camp);

	    System.out.println("[getMsgTalkTargetList] custNmList OUT : " + custNmList.size() + " count, " + custNmList);
	    System.out.println("[getMsgTalkTargetList] custTelNoList OUT : " + custTelNoList.size() + " count, " + custTelNoList);
	    System.out.println("[getMsgTalkTargetList] contractNumList OUT : " + contractNumList.size() + " count, " + contractNumList);

	    return result;
	  }

	  /*
	    sendNotiMsg (원영이형 API client)
	    req: custNms, custTelNos, contractNums
	    res: valid custNms, custTelNos, contractNums
	   */
	  public Map<String, Object> sendNotiMsg(List<String> custNms, List<String> custTelNos, List<String> contractNums) {
	    String validUrl = customProperties.getMsgtalkCheckValidUrl();
	    Map<String, Object> custInfoMap = new HashMap<>();
	    List<String> custNmList = new ArrayList<>();
	    List<String> custTelNoList = new ArrayList<>();
	    List<String> contractNumList = new ArrayList<>();
	    HttpClient hc = HttpClients.createDefault();
	    HttpPost hp = new HttpPost(validUrl);
	    try {
	      hp.addHeader("Content-type", "application/json; charset=utf-8");
	      String sep = ",";
	      String custNmData = StringUtils.join(custNms, sep);
	      String custTelNoData = StringUtils.join(custTelNos, sep);
	      String contractNumData = StringUtils.join(contractNums, sep);
	      String msgStr = "{\"cust_nms\": [" + custNmData + "],\"cust_tel_nos\": [" + custTelNoData + "],\"contract_nums\": [" + contractNumData + "]}";
	      StringEntity msg = new StringEntity(msgStr, "UTF-8");
	      hp.setEntity(msg);
	      
	      System.out.println("[sendNotiMsg] IN   : " + msgStr);
	      System.out.println("[sendNotiMsg] IN  Count : " + custNms.size());
	      
	      HttpResponse response = hc.execute(hp);
	     if (response.getStatusLine().getStatusCode() == 200) {
	        HttpEntity respEntity = response.getEntity();
	        if (respEntity != null) {
	          String content = EntityUtils.toString(respEntity, "UTF-8");
	          JSONParser parser = new JSONParser();
	          JSONObject jsonObj = (JSONObject) parser.parse(content);
	          JSONArray custNmsArr =(JSONArray)jsonObj.get("cust_nms");
	          JSONArray custTelNosArr =(JSONArray)jsonObj.get("cust_tel_nos");
	          JSONArray contractNumsArr =(JSONArray)jsonObj.get("contract_nums");
	          for(int i=0;i<custNmsArr.size();i++) {
	            String in = String.valueOf(custNmsArr.get(i));
	            custNmList.add(in);
	          }
	          for(int i=0;i<custTelNosArr.size();i++) {
	            String in = String.valueOf(custTelNosArr.get(i));
	            custTelNoList.add(in);
	          }
	          for(int i=0;i<contractNumsArr.size();i++) {
	        	  String in = String.valueOf(contractNumsArr.get(i));
	        	  contractNumList.add(in);
	          }
	          custInfoMap.put("custNms", custNmList);  
	          custInfoMap.put("custTelNos", custTelNoList);
	          custInfoMap.put("contractNums", contractNumList);
	          System.out.println("[sendNotiMsg] OUT  Count: " + custNmsArr.size());
	        }
	      }
	      System.out.println("[sendNotiMsg] API status code  : " + response.getStatusLine().getStatusCode());
	      System.out.println("[sendNotiMsg] OUT  : " + custInfoMap);
	    } catch (Exception e) {
	      //todo 오류 데이터 쌓아야함
	      System.out.println("[sendNotiMsg] ERROR :::");
	      e.printStackTrace();
	    } finally {
	      return custInfoMap;
	    }
	  }
	  
	  /*
	    checkValid (원영이형 API client)
	    req: contract IDS
	    res: valid contract IDS
	   */
	  public List<Integer> checkValid(List<Integer> contractIds) {
	    String validUrl = customProperties.getAutocallCheckValidUrl();
	    List<Integer> contractList = new ArrayList<Integer>();
	    HttpClient hc = HttpClients.createDefault();
	    HttpPost hp = new HttpPost(validUrl);
	    try {
	      hp.addHeader("Content-type", "application/json");
	      String sep = ",";
	      String data = StringUtils.join(contractIds, sep);
	      String msgStr = "{\"contract_nos\": [" + data + "]}";
	      StringEntity msg = new StringEntity(msgStr);
	      hp.setEntity(msg);

	      System.out.println("[checkValid] IN   : " + msgStr);

	      HttpResponse response = hc.execute(hp);
	      if (response.getStatusLine().getStatusCode() == 200) {
	        HttpEntity respEntity = response.getEntity();
	        if (respEntity != null) {
	          String content = EntityUtils.toString(respEntity, "UTF-8");
	          JSONParser parser = new JSONParser();
	          JSONObject jsonObj = (JSONObject) parser.parse(content);
	          JSONArray arr =(JSONArray)jsonObj.get("contract_nos");
	          for(int i=0;i<arr.size();i++) {
	            Integer in = Integer.parseInt(String.valueOf(arr.get(i)));
	            contractList.add(in);
	          }
	        }
	      }
	      System.out.println("[checkValid] API status code  : " + response.getStatusLine().getStatusCode());
	      System.out.println("[checkValid] OUT  : " + contractList);
	    } catch (Exception e) {
	      //todo 오류 데이터 쌓아야함
	      System.out.println("[checkValid] ERROR :::");
	      e.printStackTrace();
	    } finally {
	      return contractList;
	    }
	  }
	  
	  
	  @Scheduled(cron = "${msgtalk.batch-interval-time}")
	  public void msgtalkScheduled() throws Exception {
	  	
		// msgtalk.is-execute가 true인 경우에만 실행
	    if (!customProperties.getMsgtalkIsExecute()) {
	      return;
	    }
	    Date date = new Date();
	    System.out.println("[scheduled] ====== START MSG TALK ======");
		try {
			// 해당 시간에 해당하는 컨디션 조회
		    String conditionList = batchService.getMsgTalkCondition(date);
		    List<String> conds = Arrays.asList(conditionList.split(","));
		    
		    if (!conds.isEmpty() && !conds.get(0).equals("")) {
		    	for (String cond : conds) {
		            if (cond.equals("")) {
		              continue;
		            }
		            Integer condId = Integer.parseInt(cond);
		            
		            List<Integer> contractList = new ArrayList<Integer>();
		            List<Integer> valid_contractList = new ArrayList<Integer>();
		            
		            
		            List<String> custNmList = new ArrayList<String>();
		            List<String> custTelNoList = new ArrayList<String>();
		            List<String> contractNumList = new ArrayList<String>();
	                
		            MsgTalkInfo info = getMsgTalkTargetList(condId);
		            
		            contractList = info.getContractIds();
		            custNmList = info.getCustNms();
	                custTelNoList = info.getCustTelNos();
	                contractNumList = info.getContractNums();
	                
	                List<Map<String,Object>> custInfoMapList = new ArrayList<>();
	                
	                int idx = 0;
	            	for (int i = 0; i < custNmList.size(); i++) {
	            		Map<String,Object> custInfoMap = new HashMap<>();
						for (int j = 0; j < custTelNoList.size(); j++) {
							if(i == j) {
								custInfoMap.put("custNm", custNmList.get(i));
								custInfoMap.put("custTelNo", custTelNoList.get(j));
							}
						}
						for (int k = 0; k < contractNumList.size(); k++) {
							if(i == k) {
								custInfoMap.put("contractNum", contractNumList.get(k));
							}
						}

						for (int k2 = 0; k2 < contractList.size(); k2++) {
							if(i == k2) {
								custInfoMap.put("contractNo", contractList.get(k2));
							}
						}
						custInfoMapList.add(idx++, custInfoMap);
					}
	                
	            	List<String> validCustNmList = new ArrayList<String>();
		            List<String> validCustTelNoList = new ArrayList<String>();
		            List<String> validContractNumList = new ArrayList<String>();
	            	
	                valid_contractList = checkValid(contractList);
	                
	                for (int i = 0; i < custInfoMapList.size(); i++) {
	                	if(valid_contractList.contains(custInfoMapList.get(i).get("contractNo"))) {
	                		validCustNmList.add(custInfoMapList.get(i).get("custNm").toString());
	                		validCustTelNoList.add(custInfoMapList.get(i).get("custTelNo").toString());
	                		validContractNumList.add(custInfoMapList.get(i).get("contractNum").toString());
	                	}
					}
	               /* 
	                System.out.println("[validCustNmList] : " + validCustNmList);
	                System.out.println("[validCustTelNoList] : " + validCustTelNoList);
	                System.out.println("[validContractNumList] : " + validContractNumList);
	                */
	                sendNotiMsg(validCustNmList, validCustTelNoList, validContractNumList);
		            
		    	}
		    }
			
			System.out.println("[scheduled] ======  END MSG TALK ======");
	    } catch (Exception e) {
	    	System.out.println("[scheduled] ERROR :::");
			e.printStackTrace();
		}finally {
			System.out.println();
		}
		 
	 }
}
