package ai.maum.biz.fastaicc.main.api.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import ai.maum.biz.fastaicc.main.api.domain.CallReservationApiVO;
import ai.maum.biz.fastaicc.main.api.service.CallReservationApiService;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CallReservationApiController {

	/* 공통서비스 */
	@Autowired
	CommonService commonService;
	
	@Autowired
    CallReservationApiService callReservationApiService;


	public Map<String, Object> callReservationApi(String conditionId) {
		System.out.println("=========== callReservationApi called ===========");

		CallReservationApiVO callReservationApiVO = new CallReservationApiVO();

		callReservationApiVO.setAutoCallConditionId(conditionId);

		// campaignId 가져오기
		int campaignId = callReservationApiService.getCampaignId(callReservationApiVO);

		// custdataClassId 및 dataValue
		List<CallReservationApiVO> dataValueList = callReservationApiService.getDataValue(callReservationApiVO);

		// 중복된 custDataClassId
		List<CallReservationApiVO> distinctId = callReservationApiService.getDistinctDataId(callReservationApiVO);
		List<CallReservationApiVO> custDataInfo = callReservationApiService.getCustDataClassInfo(callReservationApiVO);

		List<Map<String, Object>> custDataList = new ArrayList<>();
		List<Map<String, Object>> custDataList2 = new ArrayList<>();

		ArrayList<String> array = new ArrayList<>();
		ArrayList<Integer> arrayTest = new ArrayList<>();
		if(distinctId.isEmpty() == false) {
			for (int j = 0; j < distinctId.size(); j++) {
				array = new ArrayList<>();
				for (int i = 0; i < dataValueList.size(); i++) {
					for (int k = 0; k < custDataInfo.size(); k++) {
						if(!custDataInfo.get(k).getColumnKor().equals("이름") && !custDataInfo.get(k).getColumnKor().equals("전화번호") && !custDataInfo.get(k).getColumnKor().equals("시도횟수") && !custDataInfo.get(k).getColumnKor().equals("대상상태")) {
							if(custDataInfo.get(k).getCustDataClassId() == dataValueList.get(i).getCustDataClassId()) {
								Map<String, Object> custDataMap = new HashMap<>();
								if(distinctId.get(j).getCustDataClassId() == dataValueList.get(i).getCustDataClassId()) {
									array.add(dataValueList.get(i).getDataValue());
									custDataMap.put("keyName", "$.\""+dataValueList.get(i).getCustDataClassId()+"\"");
									custDataMap.put("keyValue", array);
									custDataList.add(custDataMap);
								}
								arrayTest.add(distinctId.get(j).getCustDataClassId());
							}
						}
					}
				}
			}
		}
		
		for (int i = 0; i < dataValueList.size(); i++) {
			for (int j = 0; j < custDataInfo.size(); j++) {
				if(!custDataInfo.get(j).getColumnKor().equals("이름") && !custDataInfo.get(j).getColumnKor().equals("전화번호") && !custDataInfo.get(j).getColumnKor().equals("시도횟수") && !custDataInfo.get(j).getColumnKor().equals("대상상태")) {
					if(custDataInfo.get(j).getCustDataClassId() == dataValueList.get(i).getCustDataClassId()) {
						if(!arrayTest.contains(dataValueList.get(i).getCustDataClassId())) {
							Map<String, Object> custDataMap = new HashMap<>();
							custDataMap.put("keyName", "$.\""+dataValueList.get(i).getCustDataClassId()+"\"");
							custDataMap.put("keyValue", dataValueList.get(i).getDataValue());
							custDataList.add(custDataMap);
						}
					}
				}
			}
		}



		// custDataList 중복 제거
		for (int i = 0; i < custDataList.size(); i++) {
			if(!custDataList2.contains(custDataList.get(i))) {
				custDataList2.add(custDataList.get(i));
			}
		}

		List<Map<String, Object>> custDataArrayList = new ArrayList<>();

		int index = 0;
		for (int i = 0; i < custDataList2.size(); i++) {
			if(custDataList2.get(i).get("keyValue").getClass() == ArrayList.class) {
				ArrayList<String> keyValueArr = (ArrayList<String>) custDataList2.get(i).get("keyValue");
				String[] keyValue = keyValueArr.toString().replace("[", "").replace("]", "").split(",");
				for (int k = 0; k < keyValue.length; k++) {
					Map<String, Object> custDataMap2 = new HashMap<>();
					custDataMap2.put("keyName", custDataList2.get(i).get("keyName"));
					custDataMap2.put("keyValue", keyValue[k].trim());
					if(k == 0) {
						custDataMap2.put("status", "and");
					}else {
						custDataMap2.put("status", "or");
					}

					if(keyValue.length == k+1){
						custDataMap2.put("operate", ')');
					}
					custDataArrayList.add(index++, custDataMap2);
				}
			}else if (!"".equals(custDataList2.get(i).get("keyValue"))){
				Map<String, Object> custDataMap3 = new HashMap<>();
				custDataMap3.put("status", "and");
				custDataMap3.put("operate", ')');
				custDataMap3.put("keyName", custDataList2.get(i).get("keyName"));
				custDataMap3.put("keyValue", custDataList2.get(i).get("keyValue"));
				custDataArrayList.add(index++, custDataMap3);
			}
		}

		Map<String, Object> searchMap = new HashMap<>();

		List<Map<String, Object>> callCountArrayList = new ArrayList<>();
		List<Map<String, Object>> objectStatusArrayList = new ArrayList<>();
		List<Map<String, Object>> custInfoList = new ArrayList<>();
		ArrayList<String> callCountArr = new ArrayList<>();
		ArrayList<String> objectStatusArr = new ArrayList<>();
		int callCountIdx = 0;
		int objectStatusIdx = 0;
		int custIndex = 0;
		String contractNum = "";
		for (int i = 0; i < custDataInfo.size(); i++) {
			for (int j = 0; j < dataValueList.size(); j++) {
				Map<String, Object> custInfo = new HashMap<>();
				if(custDataInfo.get(i).getColumnKor().equals("이름") && custDataInfo.get(i).getCustDataClassId() == dataValueList.get(j).getCustDataClassId()) {
					custInfo.put("custNm", dataValueList.get(j).getDataValue());
					custInfoList.add(custIndex++, custInfo);
//					searchMap.put("name", dataValueList.get(j).getDataValue());
				}else if(custDataInfo.get(i).getColumnKor().equals("전화번호") && custDataInfo.get(i).getCustDataClassId() == dataValueList.get(j).getCustDataClassId()) {
					custInfo.put("custTelNo", dataValueList.get(j).getDataValue());
					custInfoList.add(custIndex++, custInfo);
//					searchMap.put("telephone", dataValueList.get(j).getDataValue());
				}else if(custDataInfo.get(i).getColumnKor().equals("시도횟수") && custDataInfo.get(i).getCustDataClassId() == dataValueList.get(j).getCustDataClassId()) {
					callCountArr.add(dataValueList.get(j).getDataValue());
				}else if(custDataInfo.get(i).getColumnKor().equals("대상상태") && custDataInfo.get(i).getCustDataClassId() == dataValueList.get(j).getCustDataClassId()) {
					objectStatusArr.add(dataValueList.get(j).getDataValue());
				}
			}
			if(custDataInfo.get(i).getColumnKor().equals("고객ID")) {
				contractNum = "$.\""+custDataInfo.get(i).getCustDataClassId()+"\"";
			}
		}
		if(callCountArr.size() > 0) {
			String[] callCount = callCountArr.toString().replace("[", "").replace("]", "").split(",");
			for (int k = 0; k < callCount.length; k++) {
				Map<String, Object> callCountMap = new HashMap<>();
				callCountMap.put("callTryCount", callCount[k].trim());
				if(k == 0) {
					callCountMap.put("status", "and");
				}else {
					callCountMap.put("status", "or");
				}
				if(callCount.length == k+1) {
					callCountMap.put("operate", ')');
				}
				callCountArrayList.add(callCountIdx++, callCountMap);
			}
		}

		if(objectStatusArr.size() > 0) {
			String[] objectStatus = objectStatusArr.toString().replace("[", "").replace("]", "").split(",");
			for (int k = 0; k < objectStatus.length; k++) {
				Map<String, Object> objectStatusMap = new HashMap<>();
				objectStatusMap.put("objectStatus", objectStatus[k].trim());
				if(k == 0) {
					objectStatusMap.put("status", "and");
				}else {
					objectStatusMap.put("status", "or");
				}
				if(objectStatus.length == k+1) {
					objectStatusMap.put("operate", ')');
				}
				objectStatusArrayList.add(objectStatusIdx++,objectStatusMap);
			}
		}

		searchMap.put("callCountArrayList", callCountArrayList);
		searchMap.put("objectStatusArrayList", objectStatusArrayList);
		searchMap.put("campaignId", campaignId);
		searchMap.put("custDataArrayList", custDataArrayList);
		searchMap.put("custInfoList", custInfoList);
		searchMap.put("contractNum", contractNum);
		
		List<Map<String, Object>> getContractNos = callReservationApiService.getCustContractNos(searchMap);
		ArrayList<String> contractNos = new ArrayList<>();
		Map<String, Object> contractNosMap = new HashMap<>();
		for (int i = 0; i < getContractNos.size(); i++) {
			if (getContractNos.get(i).get("contractNo") != null) {
				contractNos.add(getContractNos.get(i).get("contractNo").toString());
			}
		}
		//고객명 가져오기
		ArrayList<String> custNms = new ArrayList<>();
		for (int i = 0; i < getContractNos.size(); i++) {
			if(getContractNos.get(i).get("custNm") != null) {
				custNms.add("\""+getContractNos.get(i).get("custNm").toString()+"\"");
			}else {
				custNms.add("\"\"");
			}
		}
		//고객 전화번호 가져오기
		ArrayList<String> custTelNos = new ArrayList<>();
		for (int i = 0; i < getContractNos.size(); i++) {
			if(getContractNos.get(i).get("custTelNo") != null) {
				custTelNos.add("\""+getContractNos.get(i).get("custTelNo").toString()+"\"");
			}else {
				custTelNos.add("\"\"");
			}
		}
		
		//계약번호 가져오기
		ArrayList<String> contractNums = new ArrayList<>();
		for (int i = 0; i < getContractNos.size(); i++) {
			if(getContractNos.get(i).get("contractNum") != null) {
				contractNums.add("\""+getContractNos.get(i).get("contractNum").toString()+"\"");
			}else {
				contractNums.add("\"\"");
			}
		}
		
		contractNosMap.put("campaign_id", campaignId);
		contractNosMap.put("contract_nos", contractNos);
		contractNosMap.put("cust_nms", custNms);
		contractNosMap.put("cust_tel_nos", custTelNos);
		contractNosMap.put("contract_nums", contractNums);
		

		return contractNosMap;
	}
}
