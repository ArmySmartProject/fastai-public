package ai.maum.biz.fastaicc.main.cousult.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;

public interface MonitoringTargetUploadService {

    int getMonitoringTargetUploadCount(FrontMntVO frontMntVO);

    List<CmContractVO> getMonitoringTargetUploadList(FrontMntVO frontMntVO);

    List<CmContractVO> getExcelTmpList();

    int getExcelTmpCount();

    int uploadExcelTmp(List<Map<String, String>> paramMap);

    int resetExcelTmp();

    @Transactional("transactionManager")
    int uploadTarget(List<CmContractVO> cmContractDTOList);

    @Transactional("transactionManager")
    int updateUploadTarget(FrontMntVO frontMntVO);

    @Transactional("transactionManager")
    int addUploadTarget(FrontMntVO frontMntVO);

}
