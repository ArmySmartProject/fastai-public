package ai.maum.biz.fastaicc.main.workRequestProcess.service;

import java.util.List;
import java.util.Map;

public interface WorkRequestProcessService {
    String insertWorkRequest(Map<String, Object> map);

    List<Map<String, Object>> getCampaignListForWorkProcess(Map<String, Object> map);

    List<Map<String, Object>> getSignerListForWorkProcess(Map<String, Object> map);

    List<Map<String, Object>> getWorkRequestProcessList(Map<String, Object> map);

    Map getWorkRequestProcessListCount(Map<String, Object> map);

    Map<String, Object> getWorkRequestProcessDetail(Map<String, Object> map);

    int insertWorkRequestUploadForm(Map<String, Object> map);

    List<Map<String, Object>> getWorkRequestUploadForm(Map<String, Object> map);

    int updateWorkRequestListByNo(Map<String, Object> map);

    int updateWorkRequest(Map<String, Object> map);

    List<Map<String, Object>> getWorkRequestApprovalProcessList(Map<String, Object> map);

    Map getWorkRequestApprovalProcessListCount(Map<String, Object> map);

    int updateApprovalSign(Map<String, Object> map);

    List<Map<String, Object>> getWorkRequestListForWorkerList(Map<String, Object> map);

    Map getWorkRequestListForWorkerListCount(Map<String, Object> map);

    int updateRequestTest(Map<String, Object> map);

    List<Map<String, Object>> getWorkRequestTestList(Map<String, Object> map);

    Map getWorkRequestTestListCount(Map<String, Object> map);

    int insertWorkTest(Map<String, Object> map);

    int updateWorkRequstToTest(Map<String, Object> map);

    List<Map<String, Object>> getWorkTempTestInfo(Map<String, Object> map);

    Map<String, Object> checkTempSave(Map<String, Object> map);

    int updateWorkTest(Map<String, Object> map);

    int updateImplementComplete(Map<String, Object> map);
}
