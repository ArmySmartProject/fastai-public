package ai.maum.biz.fastaicc.main.system.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface SystemManageMapper {


	// 메뉴 그룹 권한관리
	List<Map> getMenuGroupMainList(Map<String, Object> map);

	// 메뉴 그룹 권한관리
	int getMenuGroupMainCount(Map<String, Object> map);

	// system manage - 메뉴그룹 상세 조회
	List<Map> getMenuGroupDetail(Map<String, Object> map);

	// system manage - menuGroup 추가
	int insertMenuGroup(Map<String, Object> map);

	// system manage - menuGroupMenu 추가
	int insertMenuGroupMenu(Map<String, Object> map);

	// system manage - menuGroup 수정
	int updateMenuGroup(Map<String, Object> map);

	// system manage - menuGroupMenu 삭제(삭제 후 다시 등록)
	int deleteMenuGroupMenu(String companyGroupId);

	// system manage - menuGroupMenu 수정(삭제 후 다시 등록)
	int updateMenuGroupMenu(Map<String, Object> map);

	// system manage - menuGroup 삭제
	int deleteMenuGroup(String companyGroupId);

	// system manage - menuGroup 삭제
	int deleteMenuGroupUser(String companyGroupId);

	// 메뉴 그룹 사용자 관리 리스트
	List<Map> getSystemMenuGroupUserMainList(Map<String, Object> map);

	// 메뉴 그룹 사용자 관리 리스트 카운트
	int getSystemMenuGroupUserMainCount(Map<String, Object> map);

	// 메뉴 권한 그룹 관리 조회
	List<Map> selectMenuAuthGroup(Map<String, Object> map);

	// 메뉴 권한 그룹 - 사용자 등록
	int insertMenuAuthUserInfo(Map<String, Object> map);

	// 메뉴 권한 그룹 - 사용자 권한그룹 등록
	int insertMenuAuthMenuGroup(Map<String, Object> map);

	// 메뉴 권한 그룹 - 사용자 권한그룹 수정
	int updateMenuAuthMenuGroup(Map<String, Object> map);

	// 메뉴 권한 그룹 - 비밀번호 조회
	String selectPassword(Map<String, Object> map);

	// 메뉴 권한 그룹 - 아이디 조회 (TN_COMPANY_MENU_GROUP_USER)
	String selectUserId(Map<String, Object> map);

	// 메뉴 권한 그룹 관리 상세 조회
	List<Map> getMenuGroupUserInfo(Map<String, Object> map);

	// 메뉴 그룹 사용자 삭제
	int deleteMenuGroupUserInfo(String userid);

	// 사용자 메뉴 권한 그룹 삭제
	int deleteAuthGroupInfo(String userid);

	// 메뉴 권한 그룹 관리 상세 조회
	List<Map> selectSystemCompanyInfo(Map<String, Object> map);

	// 회사 정보 수정
	int updateSystemCompanyInfo(Map<String, Object> map);

	List<Map> selectCompanyMenu(Map<String, Object> map);

	List<Map> selectBotIdsByCompanyId(Map<String, String> map);

	List<Map> selectIntentList(Map<String, String> map);

	List<Map> selectPosCounselorList(Map<String, String> map);

	List<Map> selectAssignedCounselorList(Map<String, String> map);

	void deleteCounselorList(Map<String, String> map);

	void insertCounselorList(Map<String, String> map);

    List<Map<String, Object>> getCompanyCampaigns(Map map);

	List<Map<String, Object>> getCompanyUserCampaigns(String userId);

	void insertCompanyUserCampaigns(Map<String, Object> spCompMap);

	void deleteCompanyUserCampaigns(String userId);
}
