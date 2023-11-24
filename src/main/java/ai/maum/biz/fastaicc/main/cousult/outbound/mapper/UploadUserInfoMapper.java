package ai.maum.biz.fastaicc.main.cousult.outbound.mapper;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CustDataClassVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CustInfoVO;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface UploadUserInfoMapper {

  void insertCustDataClass(CustDataClassVO custDataClassVO);

  void insertCtCustInfo(@Param("list")List<CmContractVO> cmContractList,@Param("siteCustom") String siteCustom);

  void updateCtCustClassUse(String campaignId);
  
  void insertApiCustInfo(Map<String, Object> custInfoDataMap);

  void updataApiCustInfo(Map<String, Object> custInfoDataMap);

  void insertApiContract(Map<String, Object> contractDataMap);
  
  String getApiCustInfoId(Map<String, Object> custInfoDataMap);
  
  String getApiContractNo(Map<String, Object> contractDataMap);
  
  List getApiCustClassDataId(String camapignId);
  
  String getCustClassDataId(CustDataClassVO custDataClassVO);

  Map<String, Object> getCustInfo(CustInfoVO custInfoVO);
  
  void updateCtUseCustInfo(List<CustInfoVO> custInfoVO);

  Integer selectCustBaseInfoId();

  Integer selectCustInfoId();
}
