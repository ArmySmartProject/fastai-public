package ai.maum.biz.fastaicc.main.cousult.common.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;

@Repository
@Mapper
public interface MonitoringTargetUploadMapper {
    int getMonitoringTargetUploadCount(FrontMntVO frontMntVO);

    List<CmContractVO> getMonitoringTargetUploadList(FrontMntVO frontMntVO);

    List<CmContractVO> getExcelTmpList();

    int getExcelTmpCount();

    int uploadExcelTmp(List<Map<String, String>> paramMap);

    int resetExcelTmp();

    int uploadTarget(List<CmContractVO> cmContractDTOList);

    int uploadTargetOB(List<CmContractVO> cmContractDTOList);

    int updateUploadTarget(FrontMntVO frontMntVO);

    int updateUploadTargetOB(FrontMntVO frontMntVO);

    int addUploadTarget(FrontMntVO frontMntVO);

    int addUploadTargetOB(FrontMntVO frontMntVO);

}
