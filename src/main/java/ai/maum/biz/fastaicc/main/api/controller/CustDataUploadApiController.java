package ai.maum.biz.fastaicc.main.api.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import ai.maum.biz.fastaicc.main.api.domain.CallReservationApiVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CustDataClassVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CustInfoVO;
import ai.maum.biz.fastaicc.main.cousult.outbound.mapper.UploadUserInfoMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CustDataUploadApiController {
	
	@Autowired
	UploadUserInfoMapper uploadUserInfoMapper;
	
	
	@RequestMapping(value = "/custDataUploadApi", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> custDataUploadApi(@RequestBody String jsonStr, CustDataClassVO custDataClassVO ,HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr=====" + jsonStr);
		// json파서
		JsonParser jp = new JsonParser();
		JsonArray jsonArray = (JsonArray) jp.parse(jsonStr);
		Map<String, Object> custDataClassMap = new ObjectMapper().readValue(jsonArray.getAsJsonArray().get(0).toString(), Map.class);
		
		
		Map<String, Object> responseMap = new HashMap<>();
		custDataClassVO.setCampaignId(Integer.parseInt(custDataClassMap.get("campaignId").toString()));
		
		/*uploadUserInfoMapper.updateCtCustClassUse(custDataClassMap.get("campaignId").toString());
		
		List dataClassList = new ArrayList<>();
		Map<String, Object> custDataJsonMap = (Map<String, Object>) custDataClassMap.get("custData");
		
		dataClassList.add("objectStatus");
		dataClassList.add("callTryCount");
		
		for(String key : custDataClassMap.keySet()) {
			if(key.equals("custNm")) {
				dataClassList.add(key);
			}else if(key.equals("telNo")) {
				dataClassList.add(key);
			}
		}
		
		for(String key : custDataJsonMap.keySet()) {
			if(key.equals("email")) {
				dataClassList.add(key);
			}else if(key.equals("behavior")) {
				dataClassList.add(key);
			}else if(key.equals("installPlace")) {
				dataClassList.add(key);
			}else if(key.equals("location")) {
				dataClassList.add(key);
			}else if(key.equals("recognitionTime")) {
				dataClassList.add(key);
			}
		}
		
		for (int i = 0; i < dataClassList.size(); i++) {
			custDataClassVO.setObCallStatus("Y");
			custDataClassVO.setUseYn("Y");
			if(dataClassList.get(i).equals("custNm")) {
				custDataClassVO.setDisplayYn("Y");
				custDataClassVO.setDataType("string");
				custDataClassVO.setColumnKor("이름");
				custDataClassVO.setColumnEng("name");
				custDataClassVO.setCaseType(null);
				custDataClassVO.setDescription(null);
			}else if(dataClassList.get(i).equals("telNo")) {
				custDataClassVO.setDisplayYn("Y");
				custDataClassVO.setDataType("string");
				custDataClassVO.setColumnKor("전화번호");
				custDataClassVO.setColumnEng("telNo");
				custDataClassVO.setCaseType(null);
				custDataClassVO.setDescription(null);
			}else if(dataClassList.get(i).equals("email")) {
				custDataClassVO.setDisplayYn("Y");
				custDataClassVO.setDataType("string");
				custDataClassVO.setColumnKor("이메일");
				custDataClassVO.setColumnEng(dataClassList.get(i).toString());
				custDataClassVO.setCaseType(null);
				custDataClassVO.setDescription(null);
			}else if(dataClassList.get(i).equals("behavior")) {
				custDataClassVO.setDisplayYn("Y");
				custDataClassVO.setDataType("string");
				custDataClassVO.setColumnKor("이상행동");
				custDataClassVO.setColumnEng(dataClassList.get(i).toString());
				custDataClassVO.setCaseType(null);
				custDataClassVO.setDescription(null);
			}else if(dataClassList.get(i).equals("installPlace")) {
				custDataClassVO.setDisplayYn("Y");
				custDataClassVO.setDataType("string");
				custDataClassVO.setColumnKor("설치장소");
				custDataClassVO.setColumnEng(dataClassList.get(i).toString());
				custDataClassVO.setCaseType(null);
				custDataClassVO.setDescription(null);
			}else if(dataClassList.get(i).equals("location")) {
				custDataClassVO.setDisplayYn("Y");
				custDataClassVO.setDataType("string");
				custDataClassVO.setColumnKor("카메라위치");
				custDataClassVO.setColumnEng(dataClassList.get(i).toString());
				custDataClassVO.setCaseType(null);
				custDataClassVO.setDescription(null);
			}else if(dataClassList.get(i).equals("recognitionTime")) {
				custDataClassVO.setDisplayYn("Y");
				custDataClassVO.setDataType("string");
				custDataClassVO.setColumnKor("인식시간");
				custDataClassVO.setColumnEng(dataClassList.get(i).toString());
				custDataClassVO.setCaseType(null);
				custDataClassVO.setDescription(null);
			}else if(dataClassList.get(i).equals("objectStatus")) {
				custDataClassVO.setDisplayYn("N");
				custDataClassVO.setDataType("selectbox");
				custDataClassVO.setColumnKor("대상상태");
				custDataClassVO.setColumnEng(dataClassList.get(i).toString());
				custDataClassVO.setCaseType("통화실패,통화성공/안내실패,통화성공/안내성공");
				custDataClassVO.setDescription("콜 상태");
			}else if(dataClassList.get(i).equals("callTryCount")) {
				custDataClassVO.setDisplayYn("N");
				custDataClassVO.setDataType("selectbox");
				custDataClassVO.setColumnKor("시도횟수");
				custDataClassVO.setColumnEng(dataClassList.get(i).toString());
				custDataClassVO.setCaseType("0,1,2,3이상");
				custDataClassVO.setDescription("콜 시도횟수");
			}
			uploadUserInfoMapper.insertCustDataClass(custDataClassVO);
		}
		*/
		
		List<Map<String, Object>> getCustDataClassIdMap = uploadUserInfoMapper.getApiCustClassDataId(custDataClassMap.get("campaignId").toString());
		CustInfoVO custInfoVO = new CustInfoVO();
		List contractNoList = new ArrayList<>();
		String contractNo = "";
		for (int i = 0; i < jsonArray.size(); i++) {
			Map<String, Object> custInfoDataMap = new HashMap<>();
			Map<String, Object> contractDataMap = new HashMap<>();
			// request Cust Info
			Map<String, Object> custInfoMap = new ObjectMapper().readValue(jsonArray.getAsJsonArray().get(i).toString(), Map.class);
			
			// request Cust Data
			Map<String, Object> custDataMap = (Map<String, Object>) custInfoMap.get("custData");
			
			custInfoVO.setCampaignId(Integer.parseInt(custDataClassMap.get("campaignId").toString()));
			custInfoVO.setCustTelNo(custInfoMap.get("telNo").toString());
			
			// custData json 타입 키값 custDataClassId로 변경
			for (int j = 0; j < getCustDataClassIdMap.size(); j++) {
				if(getCustDataClassIdMap.get(j).get("columnEng").toString().equals("email")) {
					custDataMap.put(getCustDataClassIdMap.get(j).get("custDataClassId").toString(), custDataMap.remove("email"));
				}else if(getCustDataClassIdMap.get(j).get("columnEng").toString().equals("behavior")) {
					custDataMap.put(getCustDataClassIdMap.get(j).get("custDataClassId").toString(), custDataMap.remove("behavior"));
				}else if(getCustDataClassIdMap.get(j).get("columnEng").toString().equals("installPlace")) {
					custDataMap.put(getCustDataClassIdMap.get(j).get("custDataClassId").toString(), custDataMap.remove("installPlace"));
				}else if(getCustDataClassIdMap.get(j).get("columnEng").toString().equals("location")) {
					custDataMap.put(getCustDataClassIdMap.get(j).get("custDataClassId").toString(), custDataMap.remove("location"));
				}else if(getCustDataClassIdMap.get(j).get("columnEng").toString().equals("recognitionTime")) {
					custDataMap.put(getCustDataClassIdMap.get(j).get("custDataClassId").toString(), custDataMap.remove("recognitionTime"));
				}
			}
			JSONObject custData = new JSONObject(custDataMap);
			
			Map<String, Object> existCust = uploadUserInfoMapper.getCustInfo(custInfoVO);
			
			if(existCust == null) {
				custInfoDataMap.put("campaignId", custDataClassMap.get("campaignId").toString());
				custInfoDataMap.put("custNm", custInfoMap.get("custNm").toString());
				custInfoDataMap.put("custTelNo", custInfoMap.get("telNo").toString());
				custInfoDataMap.put("custData", custData.toString());
				uploadUserInfoMapper.insertApiCustInfo(custInfoDataMap);
				
				contractDataMap.put("campaignId", custDataClassMap.get("campaignId").toString());
				contractDataMap.put("custId", uploadUserInfoMapper.getApiCustInfoId(custInfoDataMap));
				contractDataMap.put("custTelNo", custInfoMap.get("telNo").toString());
				uploadUserInfoMapper.insertApiContract(contractDataMap);
				
				contractNo = uploadUserInfoMapper.getApiContractNo(contractDataMap);
			}else {
				custInfoDataMap.put("campaignId", custDataClassMap.get("campaignId").toString());
				custInfoDataMap.put("custNm", custInfoMap.get("custNm").toString());
				custInfoDataMap.put("custTelNo", custInfoMap.get("telNo").toString());
				custInfoDataMap.put("custData", custData.toString());
				uploadUserInfoMapper.updataApiCustInfo(custInfoDataMap);
				
				
				contractDataMap.put("campaignId", custDataClassMap.get("campaignId").toString());
				contractDataMap.put("custTelNo", custInfoMap.get("telNo").toString());
				contractNo = uploadUserInfoMapper.getApiContractNo(contractDataMap);
			}
			
			contractNoList.add(contractNo);
			
		}
		
		if(response.getStatus() == 200) {
			responseMap.put("code", response.getStatus());
			responseMap.put("msg", "success");
			responseMap.put("campaignId", custDataClassMap.get("campaignId").toString());
			responseMap.put("contractNo", contractNoList);
		}else {
			responseMap.put("code", response.getStatus());
			responseMap.put("msg", "fail");
		}
		
		return responseMap;
	}
}
