package ai.maum.biz.fastaicc.main.system.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface SuperCompanyMapper {
	// superADMIN - company 및 권한관리 조회
	List<Map> getADMCompanyMainList(Map<String, Object> map);

	// superADMIN - company 및 권한관리 카운트
	int getADMCompanyMainCount(Map<String, Object> map);

	// superADMIN - company 및 권한관리 신규등록
	int insertCompanyInfo(Map<String, Object> map);

	// superADMIN - company 및 권한관리 신규등록 회사명 중복체크 조회
	List<Map> getCompanyNameInfo(Map<String, Object> map);

	// superADMIN - company 및 권한관리 상세조회
	List<Map> getCompanyInfo(Map<String, Object> map);

	// superADMIN - company 및 권한관리 삭제
	int deleteCompanyInfo(Map<String, Object> map);

	// superADMIN - company 및 권한관리 회사ID 입력
	String getCompanyIdInfo(Map<String, Object> map);

	// superADMIN - 사용자관리 조회
	List<Map> getADMUserMainList(Map<String, Object> map);

	// superADMIN - 사용자관리관리 카운트
	int getADMUserMainCount(Map<String, Object> map);

	// superADMIN - company 및 권한관리 조회
	List<Map> getUserInfo(Map<String, Object> map);

	// superADMIN - 사용자 등록
	int insertUserInfo(Map<String, Object> map);

	// superADMIN - 사용자 삭제
	int deleteUserInfo(String userid);

	// superADMIN - company menu 조회
	List<Map> getCompanyMenu(Map<String, Object> map);

	// superADMIN - company menu 등록
	int insertCompanyMenu(Map<String, Object> map);

	// supuerADMIN - company menu 삭제
	int deleteCompanyMenu(String companyId);

	// system manage - menu detail 조회
	List<Map> getMenuDetail(Map<String, Object> map);

	// system manage - menu sortOrdr 조회
	List<Map> getMenuSortOrdr(Map<String, Object> map);

	// system manage - menu detail 수정
	int updateMenuDetail(Map<String, Object> map);

	// system manage - menu 삭제
	int deleteMenu(Map<String, Object> map);

	// system manage - menuCode 조회
	List<Map> getMenuCode(Map<String, Object> map);

	// system manage - menu 추가
	int insertSystemMenu(Map<String, Object> map);

	// superADMIN - 회사 목록 조회 (회사별 할당된 챗봇 수 함께 조회)
	List<Map> selectCompanyList(Map<String, String> map);

	List<Map> selectBotMappingInfo(Map<String, String> map);

	List<Map> selectMappedBotCnt();

	void deleteChatbotMapping(Map<String, String> map);

	void insertChatbotMapping(Map<String, String> map);

	List<Map> getCompanyMenuGroupMenu(Map<String, Object> map);

	void deleteCompanyMenuGroupMenu(Map<String, String> map);

    List<Map<String, Object>> getMenuInCompanyIdListMap(String menuCode);

	List<Map<String, Object>> getTopCodeYnListMap(Map<String, Object> compTopMenuMap);

	void insertCompanyMenuCode(Map<String, Object> insertMenuCodeMap);

	List<Map<String, Object>> getCompGroupMenuIds(String menuCode);

	List<Map<String, Object>> getCompGroupTopCodeYnListMap(Map<String, Object> compGroupTopMenuMap);

	void insertCompanyGroupMenuCode(Map<String, Object> insertCompGroupMenuMap);

    List<Map<String, Object>> getCompanyCampaigns(Map<String, Object> map);

	void deleteCompanyCampaigns(String companyId);

	void insertCompanyCampaigns(Map<String, Object> campaignList);
}
