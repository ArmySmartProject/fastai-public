package ai.maum.biz.fastaicc.main.cousult.outbound.mapper;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmCommonCdVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CustDataClassVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CustInfoVO;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;

@Repository
@Mapper
public interface OutboundMonitoringMapper {
    List<CmContractVO> getOutboundCallMntList(FrontMntVO frontMntVO);

    int getOutboundCallMntCount(FrontMntVO frontMntVO);

    CmContractVO getOutboundCallMntData(FrontMntVO frontMntVO);

    int updateMemo(FrontMntVO frontMntVO);

    List<String> getCallHistList(FrontMntVO frontMntVO);

    List<Map<String, Object>> getCampaignList(Map<String, Object> map);

    String getCampaignNm(String campaignId);

    List<CustDataClassVO> getCustDataClass(Map<String, Object> custMap);

    int updateCustInfo(CustInfoVO custInfoVO);

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
