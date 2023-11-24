package ai.maum.biz.fastaicc.main.cousult.outbound.service;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCommonCdVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CustDataClassVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CustInfoVO;
import ai.maum.biz.fastaicc.main.cousult.outbound.service.OutboundMonitoringServiceImpl.UploadStatus;
import java.io.File;
import java.text.ParseException;
import java.util.List;

import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;

@Service
public interface OutboundMonitoringService {
    List<CmContractVO> getOutboundCallMntList(FrontMntVO frontMntVO) throws ParseException;

    int getOutboundCallMntCount(FrontMntVO frontMntVO);

    CmContractVO getOutboundCallMntData(FrontMntVO frontMntVO);

    int updateMemo(FrontMntVO frontMntVO);

    List<String> getCallHistList(FrontMntVO frontMntVO);

    UploadStatus getUploadStatus(String campaignId);

    Map<String, Object> checkUploadUserList(File destFile, String campaignId, String custOpId) throws Exception;

    void uploadUserList(File destFile, String campaignId, String custOpId) throws Exception;

    List<Map<String, Object>> getCampaignList(Map<String, Object> map);

    String getCampaignNm(String campaignId);

    List<CustDataClassVO> getCustDataClass(Map<String, Object> custMap);

    void updateCustInfo(CustInfoVO custInfoVO);

    int getCustDataClassId(CustDataClassVO custDataClassVO);

    List<CmCommonCdVO> getCommonList();

    List<CustDataClassVO> getNameTelType(Map<String, Object> campaign);

    List<CustInfoVO> getCallQueueList(FrontMntVO frontMntVO);

    int getCallQueueCount(FrontMntVO frontMntVO);

    int deleteCallQueue(List<Integer> obCallQueueId);

    String getCustOpType(String custOpId);

    List<Integer> getCustDataClassIdList(CustDataClassVO custDataClassVO);

    List<Map<String, Object>> getCustResultList(Map<String, Object> map);
}
