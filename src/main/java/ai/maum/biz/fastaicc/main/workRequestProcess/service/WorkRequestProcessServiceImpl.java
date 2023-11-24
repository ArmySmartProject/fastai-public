package ai.maum.biz.fastaicc.main.workRequestProcess.service;

import ai.maum.biz.fastaicc.main.workRequestProcess.mapper.WorkRequestProcessMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class WorkRequestProcessServiceImpl implements WorkRequestProcessService{
    @Autowired
    WorkRequestProcessMapper workRequestProcessMapper;

    @Override
    public String insertWorkRequest(Map<String, Object> map) {
        workRequestProcessMapper.insertWorkRequest(map);
        return map.get("workRequestNo").toString();
    }

    @Override
    public List<Map<String, Object>> getCampaignListForWorkProcess(Map<String, Object> map) {
        return workRequestProcessMapper.getCampaignListForWorkProcess(map);
    }

    @Override
    public List<Map<String, Object>> getSignerListForWorkProcess(Map<String, Object> map) {
        return workRequestProcessMapper.getSignerListForWorkProcess(map);
    }

    @Override
    public List<Map<String, Object>> getWorkRequestProcessList(Map<String, Object> map) {
        return workRequestProcessMapper.getWorkRequestProcessList(map);
    }

    @Override
    public Map getWorkRequestProcessListCount(Map<String, Object> map) {
        return workRequestProcessMapper.getWorkRequestProcessListCount(map);
    }

    @Override
    public Map<String, Object> getWorkRequestProcessDetail(Map<String, Object> map) {
        return workRequestProcessMapper.getWorkRequestProcessDetail(map);
    }

    @Override
    public int insertWorkRequestUploadForm(Map<String, Object> map) {
        return workRequestProcessMapper.insertWorkRequestUploadForm(map);
    }

    @Override
    public List<Map<String, Object>> getWorkRequestUploadForm(Map<String, Object> map) {
        return workRequestProcessMapper.getWorkRequestUploadForm(map);
    }

    @Override
    public int updateWorkRequestListByNo(Map<String, Object> map) {
        return workRequestProcessMapper.updateWorkRequestListByNo(map);
    }

    @Override
    public int updateWorkRequest(Map<String, Object> map) {
        return workRequestProcessMapper.updateWorkRequest(map);
    }

    @Override
    public List<Map<String, Object>> getWorkRequestApprovalProcessList(Map<String, Object> map) {
        return workRequestProcessMapper.getWorkRequestApprovalProcessList(map);
    }

    @Override
    public Map getWorkRequestApprovalProcessListCount(Map<String, Object> map) {
        return workRequestProcessMapper.getWorkRequestApprovalProcessListCount(map);
    }

    @Override
    public int updateApprovalSign(Map<String, Object> map) {
        return workRequestProcessMapper.updateApprovalSign(map);
    }

    @Override
    public List<Map<String, Object>> getWorkRequestListForWorkerList(Map<String, Object> map) {
        return workRequestProcessMapper.getWorkRequestListForWorkerList(map);
    }

    @Override
    public Map getWorkRequestListForWorkerListCount(Map<String, Object> map) {
        return workRequestProcessMapper.getWorkRequestListForWorkerListCount(map);
    }

    @Override
    public int updateRequestTest(Map<String, Object> map) {
        return workRequestProcessMapper.updateRequestTest(map);
    }

    @Override
    public List<Map<String, Object>> getWorkRequestTestList(Map<String, Object> map) {
        return workRequestProcessMapper.getWorkRequestTestList(map);
    }

    @Override
    public Map getWorkRequestTestListCount(Map<String, Object> map) {
        return workRequestProcessMapper.getWorkRequestTestListCount(map);
    }

    @Override
    public int insertWorkTest(Map<String, Object> map) {
        return workRequestProcessMapper.insertWorkTest(map);
    }

    @Override
    public int updateWorkRequstToTest(Map<String, Object> map) {
        return workRequestProcessMapper.updateWorkRequstToTest(map);
    }

    @Override
    public List<Map<String, Object>> getWorkTempTestInfo(Map<String, Object> map) {
        return workRequestProcessMapper.getWorkTempTestInfo(map);
    }

    @Override
    public Map<String, Object> checkTempSave(Map<String, Object> map) {
        return workRequestProcessMapper.checkTempSave(map);
    }

    @Override
    public int updateWorkTest(Map<String, Object> map) {
        return workRequestProcessMapper.updateWorkTest(map);
    }

    @Override
    public int updateImplementComplete(Map<String, Object> map) {
        return workRequestProcessMapper.updateImplementComplete(map);
    }
}
