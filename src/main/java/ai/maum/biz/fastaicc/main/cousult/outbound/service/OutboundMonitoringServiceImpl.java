package ai.maum.biz.fastaicc.main.cousult.outbound.service;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.util.ExcelRead;
import ai.maum.biz.fastaicc.common.util.ReadOption;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCommonCdVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CustDataClassVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CustInfoVO;
import ai.maum.biz.fastaicc.main.cousult.outbound.mapper.UploadUserInfoMapper;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.collect.Lists;
import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import lombok.Getter;
import lombok.Setter;
import org.springframework.transaction.annotation.Transactional;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.outbound.domain.CallHistoryVO;
import ai.maum.biz.fastaicc.main.cousult.outbound.mapper.OutboundMonitoringMapper;

@Service
public class OutboundMonitoringServiceImpl implements OutboundMonitoringService {

    @Autowired
    OutboundMonitoringMapper outboundMonitoringMapper;

    @Autowired
    UploadUserInfoMapper uploadUserInfoMapper;

    @Autowired
    VariablesMng variablesMng;
    
    @Autowired
    CustomProperties customProperties;

    @Autowired
    Utils utils;

    @Override
    public List<CmContractVO> getOutboundCallMntList(FrontMntVO frontMntVO) throws ParseException {
        List<CmContractVO> result = outboundMonitoringMapper.getOutboundCallMntList(frontMntVO);
        final int basePeriod = variablesMng.getBasePeriod(); // 기준일자
        final int callCount = variablesMng.getCallCount(); // 콜 횟수
        final SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");

        for(int i=0; i<result.size(); i++) {
            List<CallHistoryVO> callHistoryDTOList = result.get(i).getCallHistVO();
            CmContractVO mntrTrgtMngmtDTO = result.get(i);
            String referDateStr = mntrTrgtMngmtDTO.getTargetDt();

            if(!StringUtils.isNotBlank(referDateStr)) {
                // 배정일자가 할당되지 않았을 때
                mntrTrgtMngmtDTO.setFinalResult("미실행");
                continue;
            }

            Date referDate = transFormat.parse(referDateStr);
            Date today = new Date();

            long referDiff = utils.getDateDiff(today, referDate);
            int callTryCount = mntrTrgtMngmtDTO.getCallTryCount();

            if(referDiff > basePeriod || callTryCount > callCount) {
                // 실행조건(콜카운트,기준일자)를 만족하지 않음
                if(callHistoryDTOList.size() == 0) {
                    // 실행조건 만족하지 않고, 전화가 한번도 실행되지 않은 경우
                    mntrTrgtMngmtDTO.setFinalResult("불완전판매");
                    continue;
                }

                for(int j = 0; j< callHistoryDTOList.size(); j++){
                    CallHistoryVO callHistoryDTO = callHistoryDTOList.get(j);
                    String callDateStr = callHistoryDTO.getCallDate();
                    Date callDate = transFormat.parse(callDateStr);

                    long callDiff = utils.getDateDiff(callDate, referDate);
                    String mntCode = callHistoryDTO.getMntStatus();
                    if(!StringUtils.isNotBlank(mntCode)) {
                        //모니터링 코드가 할당되지 않은 경우
                    } else if(callDiff < basePeriod && mntCode.equals("MR0001")) {
                        // 기간안에 완료가 있을 경우 완전판매
                        mntrTrgtMngmtDTO.setFinalResult("완전판매");
                        break;
                    }

                    if(j == callHistoryDTOList.size() - 1) {
                        mntrTrgtMngmtDTO.setFinalResult("불완전판매");
                    }
                }
            } else {
                // 실행조건(콜카운트,기준일자)를 만족
                if(callHistoryDTOList.size() == 0) {
                    mntrTrgtMngmtDTO.setFinalResult("미실행");
                    continue;
                }
                for(int j = 0; j< callHistoryDTOList.size(); j++) {
                    CallHistoryVO callHistoryDTO = callHistoryDTOList.get(j);
                    String mntCode = callHistoryDTO.getMntStatus();

                    if(!StringUtils.isNotBlank(mntCode)) {
                        //모니터링 코드가 할당되지 않은 경우
                    } else if(mntCode.equals("MR0001")) {
                        mntrTrgtMngmtDTO.setFinalResult("완전판매");
                        break;
                    }

                    if(j == callHistoryDTOList.size() - 1) {
                        mntrTrgtMngmtDTO.setFinalResult("진행중");
                    }
                }
            }
        }
        return result;
    }

    @Override
    public int getOutboundCallMntCount(FrontMntVO frontMntVO) {
        return outboundMonitoringMapper.getOutboundCallMntCount(frontMntVO);
    }

    @Override
    public CmContractVO getOutboundCallMntData(FrontMntVO frontMntVO) {
        return outboundMonitoringMapper.getOutboundCallMntData(frontMntVO);
    }

    @Override
    public int updateMemo(FrontMntVO frontMntVO) {
        return outboundMonitoringMapper.updateMemo(frontMntVO);
    }

    @Override
    public List<String> getCallHistList(FrontMntVO frontMntVO) {
        return outboundMonitoringMapper.getCallHistList(frontMntVO);
    }

    @Getter
    @Setter
    public class UploadStatus {
        // "check" or "upload"
        String type;
        // 자유롭게.
        String description;
        // 0 ~ total
        int processed;
        int total;
    }

    private Map<String, UploadStatus> uploadStatusMap = new HashMap<>();

    @Override
    public UploadStatus getUploadStatus(String campaignId) {
        return uploadStatusMap.get(campaignId);
    }

    @Override
    public Map<String, Object> checkUploadUserList(File destFile, String campaignId, String custOpId)
        throws Exception {

        UploadStatus checkUploadStatus = new UploadStatus();
        uploadStatusMap.put(campaignId, checkUploadStatus);
        checkUploadStatus.setType("check");
        checkUploadStatus.setDescription("데이터 검증 시작");
        checkUploadStatus.setTotal(100);
        checkUploadStatus.setProcessed(1);

        int sheet = 0;
        int colCount = 0;
        int cnt = 0;
        int cntCust = 0;
        int uploadCnt = 0;
        int custBaseInfoId = 0;
        int custInfoId = 0;
        int insertCnt = 0;
        String nameCol = "";
        String telCol = "";
        Map<String, Object> dataCol = new HashMap<>();
        String custDataJson;
        String targetCol = "";
        String displayCol = "";
        String dataTypeCol = "";
        String korCol = "";
        String engCol = "";
        String caseCol = "";
        String descriptionCol = "";

        // 해당 campaign 모든 contract, custDataClass 데이터 UseYn = N 업데이트

        String[] columns = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N",
            "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};

        ReadOption excelReadOption = new ReadOption();
        excelReadOption.setFilePath(destFile.getAbsolutePath());
        excelReadOption
            .setOutputColumns(columns);
        excelReadOption.setStartRow(1);

        List<Map<String, String>> excelContent = ExcelRead.read(excelReadOption);
        List<CustInfoVO> custInfoList = new ArrayList<>();
        List<CmContractVO> cmContractList = new ArrayList<>();
        List<Map<String, Object>> beforeCustList = new ArrayList<>();

        // 고객데이터 insert list의 (telNo, idx) map
        Map<String, Integer> telIdxMap1 = new HashMap<>();
        // 고객데이터 update list의 (telNo, idx) map
        Map<String, Integer> telIdxMap2 = new HashMap<>();
        // 고객데이터 insert list 에서 중복된 idx list
        List<Integer> duplIdxList1 = new ArrayList<>();
        // 고객데이터 insert list 에서 중복된 idx list
        List<Integer> duplIdxList2 = new ArrayList<>();

        List<String> firstSheetColumsList = new ArrayList<>();
        List<String> secondSheetColumsList = new ArrayList<>();

        // status 세팅
        checkUploadStatus.setTotal(excelContent.size());
        for (Map<String, String> article : excelContent) {
            checkUploadStatus.setProcessed(cnt);

            CustDataClassVO custDataClassVO = new CustDataClassVO();
            CustInfoVO custInfoVO = new CustInfoVO();
            CmContractVO cmContractVO = new CmContractVO();
            Map<String, Object> custDataJsonMap = new HashMap<>();
            Map<String, Object> distinctMap = new HashMap<>();
            Map<String, Object> custMap = new HashMap<>();
            custDataClassVO.setCampaignId(Integer.parseInt(campaignId));
            custInfoVO.setCampaignId(Integer.parseInt(campaignId));
            // 다음 시트 구분
            if (article.get("A").equals("Sheet_Change")) {
                sheet++;
            }

            if (sheet == 0 && cnt == 0) {

                checkUploadStatus.setDescription("데이터 검증: 컬럼명 유효성 확인.");

                for (int i = 0; i < 7; i++) {
                    if (article.get(columns[i]).replace(" ", "").equals("발송여부")) {
                        targetCol = columns[i];
                    } else if (article.get(columns[i]).replace(" ", "").equals("노출여부")) {
                        displayCol = columns[i];
                    } else if (article.get(columns[i]).replace(" ", "").equals("데이터타입")) {
                        dataTypeCol = columns[i];
                    } else if (article.get(columns[i]).replace(" ", "").equals("컬럼명(한)")) {
                        korCol = columns[i];
                    } else if (article.get(columns[i]).replace(" ", "").equals("컬럼명(영)")) {
                        engCol = columns[i];
                    } else if (article.get(columns[i]).replace(" ", "").equals("후보")) {
                        caseCol = columns[i];
                    } else if (article.get(columns[i]).replace(" ", "").equals("설명")) {
                        descriptionCol = columns[i];
                    }
                }
            }

            if (sheet == 0 && cnt != 0) {
                // 필수 컬럼(데이터타입, 컬럼명(한), 컬럼명(영))이 빈값이 아닐때 insert
                if (article.get(dataTypeCol) != null && !"".equals(article.get(dataTypeCol))
                    && article.get(korCol) != null && !"".equals(article.get(korCol))
                    && article.get(engCol) != null && !"".equals(article.get(engCol))) {
                    custDataClassVO
                        .setDataType(article.get(dataTypeCol).toLowerCase().replace(" ", ""));
                    custDataClassVO.setColumnKor(article.get(korCol).replace(" ", ""));
                    custDataClassVO.setColumnEng(article.get(engCol).replace(" ", ""));
                    colCount++;
                    custDataClassVO.setUseYn("Y");
                    firstSheetColumsList.add(article.get(korCol).replace(" ", ""));
                }
            } else if (sheet == 1) {

                checkUploadStatus.setDescription("데이터 검증: 고객 데이터 유효성 확인. " + cntCust + "/ 전체");

                if (cntCust == 1) {
                    // 엑셀에 추가한 custInfo 컬럼위치값 파악
                    for (int i = 0; i < colCount; i++) {
                        if (article.get(columns[i]).replace(" ", "").equals("이름")) {
                            nameCol = columns[i];
                        } else if (article.get(columns[i]).replace(" ", "").equals("전화번호")) {
                            telCol = columns[i];
                        } else {
                            custDataClassVO.setColumnKor(article.get(columns[i]).replace(" ", ""));
                            String custClassDataId = uploadUserInfoMapper
                                .getCustClassDataId(custDataClassVO);
                            dataCol.put(columns[i], custClassDataId);
                        }
                        secondSheetColumsList.add(article.get(columns[i]).replace(" ", ""));
                    }

                } else if (cntCust > 1) {
                    // 파악한 컬럼위치로 데이터 저장
                    custInfoVO.setCustNm(article.get(nameCol).replace(" ", ""));
                    custInfoVO.setCustTelNo(article.get(telCol).replace(" ", "").replace("-", "")
                        .replace(".", "").replace("/", ""));
                    for (int i = 0; i < colCount; i++) {
                        if (dataCol.get(columns[i]) != null && !"".equals(dataCol.get(columns[i]))
                            && article.get(columns[i]) != null && !""
                            .equals(article.get(columns[i]))) {
                            custDataJsonMap.put((String) dataCol.get(columns[i]),
                                article.get(columns[i]).replace(" ", ""));
                        }
                    }
                    custDataJson = new ObjectMapper().writeValueAsString(custDataJsonMap);
                    custInfoVO.setCustData(custDataJson);
                    // 유저가 존재하지 않을때 contract,custInfo insert, name,tel 빈값이면 exception 발생
                    if (article.get(nameCol) != null && !"".equals(article.get(nameCol))
                        && article.get(telCol) != null && !"".equals(article.get(telCol))) {

                        Map<String, Object> existCust = uploadUserInfoMapper.getCustInfo(custInfoVO);

                        // DB 내 같은 전화번호 없을 때
                        if (existCust == null) {
                            cmContractVO.setCampaignId(campaignId);
                            cmContractVO.setCustNm(article.get(nameCol).replace(" ", ""));
                            cmContractVO
                                .setCustTelNo(article.get(telCol).replace(" ", "").replace("-", "")
                                    .replace(".", "").replace("/", ""));
//                            CmContractVO.setCustOpId(custOpId);
                            cmContractVO.setIsInbound("N");
                            cmContractVO.setCustData(custDataJson);
                            cmContractVO.setCreatorId(custOpId);

                            /* 현대해상 customizing code START*/
                            if (insertCnt == 0) {
                                custBaseInfoId = uploadUserInfoMapper.selectCustBaseInfoId();
                                custInfoId = uploadUserInfoMapper.selectCustInfoId();
                            } else {
                                custBaseInfoId++;
                                custInfoId++;
                            }
                            insertCnt++;
                            cmContractVO.setMaxId(
                                custBaseInfoId >= custInfoId ? custBaseInfoId + 1 : custInfoId + 1);
                            /* 현대해상 customizing code END*/

                            cmContractList.add(cmContractVO);

                            // 엑셀 시트 내 같은 전화번호 없을 때
                            if (!telIdxMap1.containsKey(custInfoVO.getCustTelNo())) {
                                telIdxMap1.put(custInfoVO.getCustTelNo(), cmContractList.size() - 1);

                                // 엑셀 시트 내 중복 전화번호 있을 때
                            } else {
                                // cmContractList에서 기존 contract 삭제하기 위해 idx 저장
                                duplIdxList1.add(telIdxMap1.get(custInfoVO.getCustTelNo()));
                                // idx 최신으로 교체
                                telIdxMap1.put(custInfoVO.getCustTelNo(), cmContractList.size() - 1);
                            }

                            // 유저(번호)가 DB에 이미 존재할 때 contract,custInfo update
                        } else {
                            beforeCustList.add(existCust);
                            custInfoList.add(custInfoVO);

                            // 엑셀 시트 내 같은 전화번호 없을 때
                            if (!telIdxMap2.containsKey(custInfoVO.getCustTelNo())) {
                                telIdxMap2.put(custInfoVO.getCustTelNo(), custInfoList.size() - 1);

                                // 엑셀 시트 내 중복 전화번호 있을 때
                            } else {
                                // custInfoList에서 기존 custInfo 삭제하기 위해 idx 저장
                                duplIdxList2.add(telIdxMap2.get(custInfoVO.getCustTelNo()));
                                // idx 최신으로 교체
                                telIdxMap2.put(custInfoVO.getCustTelNo(), custInfoList.size() - 1);
                            }
                        }
                        uploadCnt++;
                    }
                }
                cntCust++;
            }
            cnt++;
        }

        List<Map<String, Object>> oldCustList = new ArrayList<>();
        List<Map<String, Object>> newCustList = new ArrayList<>();

        checkUploadStatus.setDescription("데이터 검증: 중복 목록 체크 중.");

        // 중복 목록 1
        for (int i = duplIdxList1.size() - 1; i >= 0; i--) {
            // duplicate 된 idx list에서 idx 꺼내서 oldCust 찾기
            CmContractVO oldCust = cmContractList.get(duplIdxList1.get(i).intValue());
            // 최종 db 반영 될 distinct map에서 idx 꺼내서 newCust 찾기
            CmContractVO newCust = cmContractList.get(telIdxMap1.get(oldCust.getCustTelNo()));

            Map<String, Object> oldCustMap = new HashMap<>();
            oldCustMap.put("custNm", oldCust.getCustNm());
            oldCustMap.put("custTelNo", oldCust.getCustTelNo()); //todo(현대해상): 암호화

            Map<String, Object> newCustMap = new HashMap<>();
            newCustMap.put("custNm", newCust.getCustNm());
            newCustMap.put("custTelNo", newCust.getCustTelNo()); //todo(현대해상): 암호화

            oldCustList.add(0, oldCustMap);
            newCustList.add(0, newCustMap);
        }

        //  DB 인서트 될 목록 중 중복 목록 제거
        for (int i = duplIdxList1.size() - 1; i >= 0; i--) {
            cmContractList.remove(duplIdxList1.get(i).intValue());
        }

        // 중복 목록 2
        for (int i = duplIdxList2.size() - 1; i >= 0; i--) {
            // duplicate 된 idx list에서 idx 꺼내서 oldCust 찾기
            CustInfoVO oldCust = custInfoList.get(duplIdxList2.get(i));
            // 최종 db 반영 될 distinct map에서 idx 꺼내서 newCust 찾기
            CustInfoVO newCust = custInfoList.get(telIdxMap2.get(oldCust.getCustTelNo()));

            Map<String, Object> oldCustMap = new HashMap<>();
            oldCustMap.put("custNm", oldCust.getCustNm());
            oldCustMap.put("custTelNo", oldCust.getCustTelNo()); // 이미 암호화 되어있음.

            Map<String, Object> newCustMap = new HashMap<>();
            newCustMap.put("custNm", newCust.getCustNm());
            newCustMap.put("custTelNo", newCust.getCustTelNo()); //todo(현대해상): 암호화

            oldCustList.add(0, oldCustMap);
            newCustList.add(0, newCustMap);
        }

        //  DB 업데이트 될 목록 중 중복 목록 제거
        for (int i = duplIdxList2.size() - 1; i >= 0; i--) {
            beforeCustList.remove(duplIdxList2.get(i).intValue());
            custInfoList.remove(duplIdxList2.get(i).intValue());
        }

        // db 중복 case
        Map<String, Object> checkUpdateMap = new HashMap<>();
        checkUpdateMap.put("beforeCustList", beforeCustList);
        checkUpdateMap.put("afterCustList", custInfoList);

        // 데이터 상(엑셀) 중복 case
        Map<String, Object> checkDistinctMap = new HashMap<>();
        checkDistinctMap.put("ignoreCustList", oldCustList);
        checkDistinctMap.put("insertDistinctList", newCustList);

        Map<String, Object> checkUploadInfoMap = new HashMap<>();
        checkUploadInfoMap.put("firstSheetColumsList", firstSheetColumsList);
        checkUploadInfoMap.put("secondSheetColumsList", secondSheetColumsList);
        checkUploadInfoMap.put("checkDistinctMap", checkDistinctMap);
        checkUploadInfoMap.put("checkUpdateMap", checkUpdateMap);
        checkUploadInfoMap.put("uploadDataCnt", uploadCnt);

        // status 완료시 삭제
        uploadStatusMap.remove(campaignId);

        return checkUploadInfoMap;

    }


    @Override
    @Transactional("transactionManager")
    public void uploadUserList(File destFile, String campaignId, String custOpId) throws Exception {
        UploadStatus checkUploadStatus = new UploadStatus();
        uploadStatusMap.put(campaignId, checkUploadStatus);
        checkUploadStatus.setType("upload");
        checkUploadStatus.setDescription("데이터 업로드 시작");
        checkUploadStatus.setTotal(100);
        checkUploadStatus.setProcessed(1);

        int sheet = 0;
        int colCount = 0;
        int cnt = 0;
        int cntCust = 0;
        int custBaseInfoId = 0;
        int custInfoId = 0;
        int insertCnt = 0;
        String nameCol = "";
        String telCol = "";
        Map<String, Object> dataCol = new HashMap<>();
        String custDataJson;
        String targetCol = "";
        String displayCol = "";
        String dataTypeCol = "";
        String korCol = "";
        String engCol = "";
        String caseCol = "";
        String descriptionCol = "";

        // 해당 campaign 모든 contract, custDataClass 데이터 UseYn = N 업데이트
        uploadUserInfoMapper.updateCtCustClassUse(campaignId);

        String[] columns = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N",
            "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};

        ReadOption excelReadOption = new ReadOption();
        excelReadOption.setFilePath(destFile.getAbsolutePath());
        excelReadOption
            .setOutputColumns(columns);
        excelReadOption.setStartRow(1);

        List<Map<String, String>> excelContent = ExcelRead.read(excelReadOption);
        List<CustInfoVO> custInfoList = new ArrayList<>();
        List<CmContractVO> cmContractList = new ArrayList<>();
        List<List<CmContractVO>> afterCmContractList;
        List<List<CustInfoVO>> afterCustInfoList;
        
        List<String> telList = new ArrayList<>();

        // status 세팅 (1: check, 2: upload로 2배)
        checkUploadStatus.setTotal(excelContent.size()*2);
        for (Map<String, String> article : excelContent) {
            checkUploadStatus.setProcessed(cnt);

            CustDataClassVO custDataClassVO = new CustDataClassVO();
            CustInfoVO custInfoVO = new CustInfoVO();
            CmContractVO cmContractVO = new CmContractVO();
            Map<String, Object> custDataJsonMap = new HashMap<>();
            custDataClassVO.setCampaignId(Integer.parseInt(campaignId));
            custInfoVO.setCampaignId(Integer.parseInt(campaignId));
            // 다음 시트 구분
            if (article.get("A").equals("Sheet_Change")) {
                sheet++;
            }

            if (sheet == 0 && cnt == 0) {

                checkUploadStatus.setDescription("데이터 업로드: 컬럼명 유효성 확인.");

                custDataClassVO.setDisplayYn("N");
                custDataClassVO.setObCallStatus("Y");
                custDataClassVO.setDataType("selectbox");
                custDataClassVO.setUseYn("Y");
                custDataClassVO.setCaseType("0,1,2,3이상");
                custDataClassVO.setColumnEng("callTryCount");
                custDataClassVO.setColumnKor("시도횟수");
                custDataClassVO.setDescription("콜 시도횟수");
                uploadUserInfoMapper.insertCustDataClass(custDataClassVO);

                custDataClassVO.setCaseType("통화실패,통화성공/안내실패,통화성공/안내성공");
                custDataClassVO.setColumnEng("objectStatus");
                custDataClassVO.setColumnKor("대상상태");
                custDataClassVO.setDescription("콜 상태");
                uploadUserInfoMapper.insertCustDataClass(custDataClassVO);

                for (int i=0; i < 7; i++) {
                    if (article.get(columns[i]).replace(" ","").equals("발송여부")) {
                        targetCol = columns[i];
                    } else if (article.get(columns[i]).replace(" ","").equals("노출여부")) {
                        displayCol = columns[i];
                    } else if (article.get(columns[i]).replace(" ","").equals("데이터타입")) {
                        dataTypeCol = columns[i];
                    } else if (article.get(columns[i]).replace(" ","").equals("컬럼명(한)")) {
                        korCol = columns[i];
                    } else if (article.get(columns[i]).replace(" ","").equals("컬럼명(영)")) {
                        engCol = columns[i];
                    } else if (article.get(columns[i]).replace(" ","").equals("후보")) {
                        caseCol = columns[i];
                    } else if (article.get(columns[i]).replace(" ","").equals("설명")) {
                        descriptionCol = columns[i];
                    }
                }
            }

            if (sheet == 0 && cnt != 0) {
                if (article.get(displayCol) != null &&
                    article.get(displayCol).equalsIgnoreCase("y")) {
                    custDataClassVO.setDisplayYn("Y");
                } else {
                    custDataClassVO.setDisplayYn("N");
                }
                if (article.get(targetCol) != null
                    && article.get(targetCol).equalsIgnoreCase("y")) {
                    custDataClassVO.setObCallStatus("Y");
                } else {
                    custDataClassVO.setObCallStatus("N");
                }
                if (article.get(dataTypeCol) != null
                    && article.get(dataTypeCol).equalsIgnoreCase("radiobox") ||
                    article.get(dataTypeCol).equalsIgnoreCase("selectbox")) {
                    // radiobox, selectbox가 있을때 caseType null인 경우 오류
                    if (article.get(caseCol) == null || "".equals(article.get(caseCol))) {
                        throw new Exception("CASE TYPE IS NULL");
                    } else {
                        custDataClassVO.setCaseType(article.get(caseCol).replace(" ",""));
                    }
                }
                if (article.get(descriptionCol) != null && !"".equals(article.get(descriptionCol))) {
                    custDataClassVO.setDescription(article.get(descriptionCol));
                }
                // 필수 컬럼(데이터타입, 컬럼명(한), 컬럼명(영))이 빈값이 아닐때 insert
                if (article.get(dataTypeCol) != null && !"".equals(article.get(dataTypeCol))
                    && article.get(korCol) != null && !"".equals(article.get(korCol))
                    && article.get(engCol) != null && !"".equals(article.get(engCol))) {
                    custDataClassVO.setDataType(article.get(dataTypeCol).toLowerCase().replace(" ",""));
                    custDataClassVO.setColumnKor(article.get(korCol).replace(" ",""));
                    custDataClassVO.setColumnEng(article.get(engCol).replace(" ",""));
                    colCount++;
                    custDataClassVO.setUseYn("Y");
                    uploadUserInfoMapper.insertCustDataClass(custDataClassVO);
                }
            } else if (sheet == 1) {

                checkUploadStatus.setDescription("데이터 업로드: 고객 데이터 유효성 확인. " + cntCust + "/ 전체");

                if (cntCust == 1) {
                    // 엑셀에 추가한 custInfo 컬럼위치값 파악
                    for (int i=0; i < colCount; i++) {
                        if (article.get(columns[i]).replace(" ","").equals("이름")) {
                            nameCol = columns[i];
                        } else if (article.get(columns[i]).replace(" ","").equals("전화번호")) {
                            telCol = columns[i];
                        } else {
                            custDataClassVO.setColumnKor(article.get(columns[i]).replace(" ",""));
                            String custClassDataId = uploadUserInfoMapper.getCustClassDataId(custDataClassVO);
                            dataCol.put(columns[i],custClassDataId);
                        }
                    }
                } else if (cntCust > 1) {
                    // 파악한 컬럼위치로 데이터 저장
                    custInfoVO.setCustNm(article.get(nameCol).replace(" ",""));
                    custInfoVO.setCustTelNo(article.get(telCol).replace(" ","").replace("-", "")
                        .replace(".","").replace("/",""));
                    for (int i=0; i < colCount; i++) {
                        if (dataCol.get(columns[i]) != null && !"".equals(dataCol.get(columns[i]))
                            && article.get(columns[i]) != null && !"".equals(article.get(columns[i]))) {
                            custDataJsonMap.put((String) dataCol.get(columns[i]),article.get(columns[i]).replace(" ",""));
                        }
                    }
                    custDataJson = new ObjectMapper().writeValueAsString(custDataJsonMap);
                    custInfoVO.setCustData(custDataJson);
                    // 유저가 존재하지 않을때 contract,custInfo insert, name,tel 빈값이면 exception 발생
                    if (article.get(nameCol) != null && !"".equals(article.get(nameCol))
                        && article.get(telCol) != null && !"".equals(article.get(telCol))) {
                        if (uploadUserInfoMapper.getCustInfo(custInfoVO) == null && !telList.contains(custInfoVO.getCustTelNo())) {
	                            cmContractVO.setCampaignId(campaignId);
	                            cmContractVO.setCustNm(article.get(nameCol).replace(" ",""));
	                            cmContractVO.setCustTelNo(article.get(telCol).replace(" ","").replace("-", "")
	                                .replace(".","").replace("/",""));
	//                            CmContractVO.setCustOpId(custOpId);
	                            cmContractVO.setIsInbound("N");
	                            cmContractVO.setCustData(custDataJson);
	                            cmContractVO.setCreatorId(custOpId);
	                            if(customProperties.getSiteCustom().equals("hdhs")) {
	                            	if (insertCnt == 0) {
	                            		custBaseInfoId = uploadUserInfoMapper.selectCustBaseInfoId();
	                            		custInfoId = uploadUserInfoMapper.selectCustInfoId();
	                            	} else {
	                            		custBaseInfoId++;
	                            		custInfoId++;
	                            	}
	                            	cmContractVO.setMaxId(custBaseInfoId >= custInfoId ? custBaseInfoId + 1 : custInfoId + 1);
	                            	insertCnt++;
	                            }
	                            cmContractList.add(cmContractVO);
	                            telList.add(custInfoVO.getCustTelNo());
                        } else {
                            // 유저가 존재할때 contract,custInfo update
                            custInfoList.add(custInfoVO);
                        }
                    }
                }
                cntCust++;
            }
            cnt++;
        }

        // MsSQL에서 한번에 insert, update하는 갯수 제한이 있어 추가 (mysql에선 필요하지 x)
        if (cmContractList.size() > 189) {
            afterCmContractList = Lists.partition(cmContractList,
                (int) (cmContractList.size() / (cmContractList.size() / 190 + 0.99)));
            for (int i = 0; i < afterCmContractList.size(); i++) {
                checkUploadStatus.setDescription("데이터 업로드: 데이터 저장 중. " + cmContractList.size() + "개 남음.");
                checkUploadStatus.setProcessed(checkUploadStatus.getTotal() - cmContractList.size() - custInfoList.size());
                uploadUserInfoMapper.insertCtCustInfo(afterCmContractList.get(i), customProperties.getSiteCustom());
            }
        } else if (cmContractList.size() > 0) {
            checkUploadStatus.setDescription("데이터 업로드: 데이터 저장 중. " + cmContractList.size() + "개 남음.");
            checkUploadStatus.setProcessed(checkUploadStatus.getTotal() - cmContractList.size() - custInfoList.size());
            uploadUserInfoMapper.insertCtCustInfo(cmContractList, customProperties.getSiteCustom());
        }
        if (custInfoList.size() > 349) {
            afterCustInfoList = Lists.partition(custInfoList,
                (int) (custInfoList.size() / (custInfoList.size() / 350 + 0.99)));
            for (int i = 0; i < afterCustInfoList.size(); i++) {
                checkUploadStatus.setDescription("데이터 업로드: 중복 데이터 업데이트 중. " + custInfoList.size() + "개 남음.");
                checkUploadStatus.setProcessed(checkUploadStatus.getTotal() - custInfoList.size());
                uploadUserInfoMapper.updateCtUseCustInfo(afterCustInfoList.get(i));
            }
        } else if (custInfoList.size() > 0) {
            checkUploadStatus.setDescription("데이터 업로드: 중복 데이터 업데이트 중. " + custInfoList.size() + "개 남음.");
            checkUploadStatus.setProcessed(checkUploadStatus.getTotal() - custInfoList.size());
            uploadUserInfoMapper.updateCtUseCustInfo(custInfoList);
        }

        // status 완료시 삭제
        uploadStatusMap.remove(campaignId);
    }

    @Override
    public int getCustDataClassId(CustDataClassVO custDataClassVO) {
        return outboundMonitoringMapper.getCustDataClassId(custDataClassVO);
    }

    @Override
    public List<CmCommonCdVO> getCommonList() {
        return outboundMonitoringMapper.getCommonList();
    }

    @Override
    public List<CustDataClassVO> getNameTelType(Map<String, Object> campaign) {
        return outboundMonitoringMapper.getNameTelType(campaign);
    }

    @Override
    public List<CustInfoVO> getCallQueueList(FrontMntVO frontMntVO) {
        return outboundMonitoringMapper.getCallQueueList(frontMntVO);
    }

    @Override
    public int getCallQueueCount(FrontMntVO frontMntVO) {
        return outboundMonitoringMapper.getCallQueueCount(frontMntVO);
    }

    @Override
    public int deleteCallQueue(List<Integer> obCallQueueId) {
        return outboundMonitoringMapper.deleteCallQueue(obCallQueueId);
    }

    @Override
    public String getCustOpType(String custOpId) {
        return outboundMonitoringMapper.getCustOpType(custOpId);
    }

    @Override
    public List<Integer> getCustDataClassIdList(CustDataClassVO custDataClassVO) {
        return outboundMonitoringMapper.getCustDataClassIdList(custDataClassVO);
    }

    @Override
    public List<Map<String, Object>> getCampaignList(Map<String, Object> map) {
        return outboundMonitoringMapper.getCampaignList(map);
    }

    @Override
    public String getCampaignNm(String campaignId) {
        return outboundMonitoringMapper.getCampaignNm(campaignId);
    }

    @Override
    public List<CustDataClassVO> getCustDataClass(Map<String ,Object> custMap) {
        return outboundMonitoringMapper.getCustDataClass(custMap);
    }

    @Override
    public void updateCustInfo(CustInfoVO custInfoVO) {
        outboundMonitoringMapper.updateCustInfo(custInfoVO);
    }

    @Override
    public List<Map<String, Object>> getCustResultList(Map<String, Object> map) {
        return outboundMonitoringMapper.getCustResultList(map);
    }
}
