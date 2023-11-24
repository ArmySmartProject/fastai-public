package ai.maum.biz.fastaicc.main.system.admin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ai.maum.biz.fastaicc.main.system.admin.botMapper.BotManageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ai.maum.biz.fastaicc.main.system.admin.mapper.SystemManageMapper;

@Service
public class SystemManageServiceImpl implements SystemManageService{
	@Autowired
	SystemManageMapper systemManageMapper;

	@Autowired
	BotManageMapper botManageMapper;

	@Autowired
    PasswordEncoder passwordEncoder;

	@Override
	public List<Map> getMenuGroupMainList(Map<String, Object> map) {
		return systemManageMapper.getMenuGroupMainList(map);
	}

	@Override
	public int getMenuGroupMainCount(Map<String, Object> map) {
		return systemManageMapper.getMenuGroupMainCount(map);
	}

	@Override
	public List<Map> getMenuGroupDetail(Map<String, Object> map) {
		return systemManageMapper.getMenuGroupDetail(map);
	}

	@Override
	public int insertMenuGroup(Map<String, Object> map) {
		int insertCnt = 0;

		insertCnt = systemManageMapper.insertMenuGroup(map);
		return insertCnt;
	}

	@Override
	public int insertMenuGroupMenu(Map<String, Object> map) {
		int insertCnt =0;

		insertCnt = systemManageMapper.insertMenuGroupMenu(map);
		return insertCnt;
	}

	@Override
	public int updateMenuGroup(Map<String, Object> map) {
		int updateCnt = 0;
		updateCnt = systemManageMapper.updateMenuGroup(map);
		return updateCnt;
	}

	@Override
	public int deleteMenuGroupMenu(String companyGroupId) {
		int deleteCnt = 0;
		deleteCnt = systemManageMapper.deleteMenuGroupMenu(companyGroupId);

		return deleteCnt;
	}

	@Override
	public int updateMenuGroupMenu(Map<String, Object> map) {
		int updateCnt = 0;
		updateCnt = systemManageMapper.updateMenuGroupMenu(map);

		return updateCnt;
	}

	@Override
	public int deleteMenuGroup(String companyGroupId) {
		int deleteCnt = 0;
		deleteCnt = systemManageMapper.deleteMenuGroup(companyGroupId);

		return deleteCnt;
	}

	@Override
	public List<Map> getSystemMenuGroupUserMainList(Map<String, Object> map) {
		return systemManageMapper.getSystemMenuGroupUserMainList(map);
	}

	@Override
	public int getSystemMenuGroupUserMainCount(Map<String, Object> map) {
		return systemManageMapper.getSystemMenuGroupUserMainCount(map);
	}

	@Override
	public List<Map> selectMenuAuthGroup(Map<String, Object> map) {
		return systemManageMapper.selectMenuAuthGroup(map);
	}

	@Override
	@Transactional("transactionManager")
	public int insertMenuAuthUserInfo(Map<String, Object> map) {

		return systemManageMapper.insertMenuAuthUserInfo(map);
	}

	@Override
	public int insertMenuAuthMenuGroup(Map<String, Object> map) {
		int insertCnt = 0;
		insertCnt = systemManageMapper.insertMenuAuthMenuGroup(map);

		return insertCnt;
	}

	@Override
	public String selectPassword(Map<String, Object> map) {

		return systemManageMapper.selectPassword(map);
	}

	@Override
	public List<Map> getMenuGroupUserInfo(Map<String, Object> map) {
		return systemManageMapper.getMenuGroupUserInfo(map);
	}

	@Override
	public int updateMenuAuthMenuGroup(Map<String, Object> map) {
		int updateCnt = 0;
		updateCnt = systemManageMapper.updateMenuAuthMenuGroup(map);

		return updateCnt;
	}

	@Override
	public String selectUserId(Map<String, Object> map) {
		return systemManageMapper.selectUserId(map);
	}

	@Override
	public int deleteMenuGroupUserInfo(String userid) {
		int deleteCnt = 0;
		deleteCnt = systemManageMapper.deleteMenuGroupUserInfo(userid);

		return deleteCnt;
	}

	@Override
	public int deleteAuthGroupInfo(String userid) {
		int deleteCnt = 0;
		deleteCnt = systemManageMapper.deleteAuthGroupInfo(userid);

		return deleteCnt;
	}

	@Override
	public List<Map> selectSystemCompanyInfo(Map<String, Object> map) {
		return systemManageMapper.selectSystemCompanyInfo(map);
	}

	@Override
	public int updateSystemCompanyInfo(Map<String, Object> map) {
		int updateCnt = 0;
		updateCnt = systemManageMapper.updateSystemCompanyInfo(map);

		return updateCnt;
	}

	@Override
	public List<Map> selectCompanyMenu(Map<String, Object> map) {
		return systemManageMapper.selectCompanyMenu(map);
	}

	@Override
	public int deleteMenuGroupUser(String companyGroupId) {
		int deleteCnt = 0;
		deleteCnt = systemManageMapper.deleteMenuGroupUser(companyGroupId);

		return deleteCnt;
	}

	@Override
	public Map selectBotIdsByCompanyId(Map<String, String> map) {
		List<Map> mappingInfo = systemManageMapper.selectBotIdsByCompanyId(map);
		List<Integer> botIds = new ArrayList<>();

		for (int i = 0; mappingInfo != null && i < mappingInfo.size(); i++) {
			botIds.add(Integer.parseInt(mappingInfo.get(i).get("BOT_ID").toString()));
		}
		Map map2 = new HashMap();
		map2.put("botIds", botIds);
		Map botList = selectBotList(map2);

		Map res = new HashMap();
		for (int i = 0; i < mappingInfo.size(); i++) {
			String botId = mappingInfo.get(i).get("BOT_ID").toString();
			mappingInfo.get(i).put("name", botList.get(botId));
			res.put(botId, mappingInfo.get(i));
		}
		return res;
	}

	@Override
	public List<Map> selectIntentList(Map<String, String> map) {
		return systemManageMapper.selectIntentList(map);
	}

	@Override
	public List<Map> selectPosCounselorList(Map<String, String> map) {
		return systemManageMapper.selectPosCounselorList(map);
	}

	@Override
	public List<Map> selectAssignedCounselorList(Map<String, String> map) {
		return systemManageMapper.selectAssignedCounselorList(map);
	}

	@Override
	public void deleteCounselorList(Map<String, String> map) {
		systemManageMapper.deleteCounselorList(map);
	}

	@Override
	public void insertCounselorList(Map<String, String> map) {
		systemManageMapper.insertCounselorList(map);
	}

	@Override
	public List<Map<String, Object>> getCompanyCampaigns(Map map) {
		return systemManageMapper.getCompanyCampaigns(map);
	}

	@Override
	public List<Map<String, Object>> getCompanyUserCampaigns(String userId) {
		return systemManageMapper.getCompanyUserCampaigns(userId);
	}

	@Override
	public void insertCompanyUserCampaigns(Map<String, Object> spCompMap) {
		systemManageMapper.insertCompanyUserCampaigns(spCompMap);
	}

	@Override
	public void deleteCompanyUserCampaigns(String userId) {
		systemManageMapper.deleteCompanyUserCampaigns(userId);
	}

	private Map<String, String> selectBotList(Map<String, String> map) {
		List<Map> botList = botManageMapper.selectAccountListByNo(map);
		Map<String, String> res = new HashMap();
		for (int i = 0; i < botList.size(); i++) {
			res.put(botList.get(i).get("No").toString(), botList.get(i).get("Name").toString());
		}
		return res;
	}
}
