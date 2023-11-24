package ai.maum.biz.fastaicc.main.cousult.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.mapper.MonitoringTargetUploadMapper;

@Service
public class MonitoringTargetUploadServiceImpl implements MonitoringTargetUploadService{

    @Autowired
    MonitoringTargetUploadMapper monitoringTargetUploadMapper;


    @Override
    public int getMonitoringTargetUploadCount(FrontMntVO frontMntVO) {
        return monitoringTargetUploadMapper.getMonitoringTargetUploadCount(frontMntVO);
    }

    @Override
    public List<CmContractVO> getMonitoringTargetUploadList(FrontMntVO frontMntVO) {
        return monitoringTargetUploadMapper.getMonitoringTargetUploadList(frontMntVO);
    }

    @Override
    public List<CmContractVO> getExcelTmpList() {
        return monitoringTargetUploadMapper.getExcelTmpList();
    }

    @Override
    public int getExcelTmpCount() {
        return monitoringTargetUploadMapper.getExcelTmpCount();
    }

    @Override
    public int uploadExcelTmp(List<Map<String, String>> paramMap) {
        return monitoringTargetUploadMapper.uploadExcelTmp(paramMap);
    }

    @Override
    public int resetExcelTmp() {
        return monitoringTargetUploadMapper.resetExcelTmp();
    }

    @Override
    public int uploadTarget(List<CmContractVO> cmContractDTOList) {
        monitoringTargetUploadMapper.uploadTarget(cmContractDTOList);
        return monitoringTargetUploadMapper.uploadTargetOB(cmContractDTOList);

    }

    @Override
    public int updateUploadTarget(FrontMntVO frontMntVO) {
        monitoringTargetUploadMapper.updateUploadTarget(frontMntVO);
        return monitoringTargetUploadMapper.updateUploadTargetOB(frontMntVO);
    }

    @Override
    public int addUploadTarget(FrontMntVO frontMntVO) {
        monitoringTargetUploadMapper.addUploadTarget(frontMntVO);
        return monitoringTargetUploadMapper.addUploadTargetOB(frontMntVO);
    }
}
