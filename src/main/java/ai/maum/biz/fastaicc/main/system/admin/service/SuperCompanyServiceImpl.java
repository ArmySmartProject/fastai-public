package ai.maum.biz.fastaicc.main.system.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ai.maum.biz.fastaicc.main.system.admin.botMapper.BotManageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ai.maum.biz.fastaicc.main.system.admin.mapper.SuperCompanyMapper;

@Service
public class SuperCompanyServiceImpl implements SuperCompanyService {
	@Autowired
	SuperCompanyMapper superCompanyMapper;

	@Autowired
	BotManageMapper botManageMapper;

	@Autowired
    PasswordEncoder passwordEncoder;

	// superADMIN - company 및 권한관리 조회
	@Override
	public List<Map> getADMCompanyMainList(Map<String, Object> map) {
		return superCompanyMapper.getADMCompanyMainList(map);
	}

	// superADMIN - company 및 권한관리 카운트
	@Override
	public int getADMCompanyMainCount(Map<String, Object> map) {
		return superCompanyMapper.getADMCompanyMainCount(map);
	}

	// superADMIN - company 및 권한관리 신규등록
	@Override
	@Transactional("transactionManager")
	public int insertCompanyInfo(Map<String, Object> map) {
		int insertCnt = 0;

		insertCnt = superCompanyMapper.insertCompanyInfo(map);

		return insertCnt;
	}

	// superADMIN - company 및 권한관리 신규등록 회사명 중복체크 조회
	@Override
	public List<Map> getCompanyNameInfo(Map<String, Object> map) {
		return superCompanyMapper.getCompanyNameInfo(map);
	}

	// superADMIN - company 및 권한관리 상세조회
	@Override
	public List<Map> getCompanyInfo(Map<String, Object> map) {
		return superCompanyMapper.getCompanyInfo(map);
	}

	// superADMIN - company 및 권한관리 삭제
	@Override
	@Transactional("transactionManager")
	public int deleteCompanyInfo(Map<String, Object> map) {
		int deleteCnt = 0;

		deleteCnt = superCompanyMapper.deleteCompanyInfo(map);

		return deleteCnt;
	}

	// superADMIN - company 및 권한관리 회사ID 입력
	@Override
	public String getCompanyIdInfo(Map<String, Object> map) {
		return superCompanyMapper.getCompanyIdInfo(map);
	}

	// superADMIN - 사용자관리 조회
	@Override
	public List<Map> getADMUserMainList(Map<String, Object> map) {
		return superCompanyMapper.getADMUserMainList(map);
	}

	// superADMIN - 사용자관리 조회 카운트
	@Override
	public int getADMUserMainCount(Map<String, Object> map) {
		return superCompanyMapper.getADMUserMainCount(map);
	}

	// superADMIN - 사용자ID 중복조회
	@Override
	public List<Map> getUserInfo(Map<String, Object> map) {
		return superCompanyMapper.getUserInfo(map);
	}

	// superADMIN - 사용자 등록
	@Override
	@Transactional("transactionManager")
	public int insertUserInfo(Map<String, Object> map) {
		if(map.get("userPw") != null && map.get("userPw") != "") {
			map.put("userPw", passwordEncoder.encode((CharSequence) map.get("userPw")));
		}
		return superCompanyMapper.insertUserInfo(map);
	}

	// superADMIN - 사용자 삭제
	@Override
	@Transactional("transactionManager")
	public int deleteUserInfo(String userid) {
		return superCompanyMapper.deleteUserInfo(userid);
	}

	// superADMIN - company menu 조회
	@Override
	public List<Map> getCompanyMenu(Map<String, Object> map) {
		return superCompanyMapper.getCompanyMenu(map);
	}

	// superADMIN - company menu 등록
	@Override
	public int insertCompanyMenu(Map<String, Object> map) {
		int insertCnt = 0;

		insertCnt = superCompanyMapper.insertCompanyMenu(map);


		return insertCnt;
	}

	// superADMIN - company menu 삭제
	@Override
	public int deleteCompanyMenu(String companyId) {
		int deleteCnt = 0;

		deleteCnt = superCompanyMapper.deleteCompanyMenu(companyId);
		return deleteCnt;
	}

	@Override
	public List<Map> getMenuDetail(Map<String, Object> map) {
		return superCompanyMapper.getMenuDetail(map);
	}

	@Override
	public List<Map> getMenuSortOrdr(Map<String, Object> map) {
		return superCompanyMapper.getMenuSortOrdr(map);
	}

	@Override
	public int updateMenuDetail(Map<String, Object> map) {
		int updateCnt = 0;

		updateCnt = superCompanyMapper.updateMenuDetail(map);
		return updateCnt;
	}

	@Override
	public List<Map> getMenuCode(Map<String, Object> map) {

		return superCompanyMapper.getMenuCode(map);
	}

	@Override
	public int insertSystemMenu(Map<String, Object> map) {
		int insertCnt = 0;

		insertCnt = superCompanyMapper.insertSystemMenu(map);
		return insertCnt;
	}

	@Override
	public int deleteMenu(Map<String, Object> map) {
		return superCompanyMapper.deleteMenu(map);
	}

	@Override
	public List<Map> selectAccountList() {
		return botManageMapper.selectAccountList();
	}

	@Override
	public List<Map> selectCompanyList(Map<String, String> map) {
		return superCompanyMapper.selectCompanyList(map);
	}

	@Override
	public List<Map> selectBotMappingInfo(Map<String, String> map) {
		return superCompanyMapper.selectBotMappingInfo(map);
	}

	@Override
	public Map selectMappedBotCnt() {
	  List<Map> res = superCompanyMapper.selectMappedBotCnt();
	  Map botCnt = new HashMap();
	  for(int i = 0; i < res.size(); i++) {
	    botCnt.put(res.get(i).get("BOT_ID"), res.get(i).get("botCnt"));
      }
	  return botCnt;
	}

	@Override
	public void deleteChatbotMapping(Map<String, String> map) {
		superCompanyMapper.deleteChatbotMapping(map);
	}

	@Override
	public void insertChatbotMapping(Map<String, String> map) {
		superCompanyMapper.insertChatbotMapping(map);
	}

	@Override
	public List<Map> getCompanyMenuGroupMenu(Map<String, Object> map) {
		return superCompanyMapper.getCompanyMenuGroupMenu(map);
	}

	@Override
	public void deleteCompanyMenuGroupMenu(Map<String, String> map) {
		superCompanyMapper.deleteCompanyMenuGroupMenu(map);
		
	}

	@Override
	public List<Map<String, Object>> getMenuInCompanyIdListMap(String menuCode) {
		return superCompanyMapper.getMenuInCompanyIdListMap(menuCode);
	}

	@Override
	public List<Map<String, Object>> getTopCodeYnListMap(Map<String, Object> compTopMenuMap) {
		return superCompanyMapper.getTopCodeYnListMap(compTopMenuMap);
	}

	@Override
	public void insertCompanyMenuCode(Map<String, Object> insertMenuCodeMap) {
		superCompanyMapper.insertCompanyMenuCode(insertMenuCodeMap);
	}

	@Override
	public List<Map<String, Object>> getCompGroupMenuIds(String menuCode) {
		return superCompanyMapper.getCompGroupMenuIds(menuCode);
	}

	@Override
	public List<Map<String, Object>> getCompGroupTopCodeYnListMap(Map<String, Object> compGroupTopMenuMap) {
		return superCompanyMapper.getCompGroupTopCodeYnListMap(compGroupTopMenuMap);
	}

	@Override
	public void insertCompanyGroupMenuCode(Map<String, Object> insertCompGroupMenuMap) {
		superCompanyMapper.insertCompanyGroupMenuCode(insertCompGroupMenuMap);
	}

	@Override
	public List<Map<String, Object>> getCompanyCampaigns(Map<String, Object> map) {
		return superCompanyMapper.getCompanyCampaigns(map);
	}

	@Override
	public void deleteCompanyCampaigns(String companyId) {
		superCompanyMapper.deleteCompanyCampaigns(companyId);
	}

	@Override
	public void insertCompanyCampaigns(Map<String, Object> campaignList) {
		superCompanyMapper.insertCompanyCampaigns(campaignList);
	}
}
