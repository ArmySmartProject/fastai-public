package ai.maum.biz.fastaicc.main.system.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.*;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.util.ExcelUtill;
import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.common.domain.PagingVO;
import ai.maum.biz.fastaicc.main.cousult.common.domain.FrontMntVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.CampaignService;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.cousult.common.service.ConsultingService;
import ai.maum.biz.fastaicc.main.statistic.service.StatisticsService;
import ai.maum.biz.fastaicc.main.system.admin.service.SuperCompanyService;
import ai.maum.biz.fastaicc.main.system.admin.service.SystemManageService;
import ai.maum.biz.fastaicc.main.system.menu.service.MenuService;
import ai.maum.biz.fastaicc.main.user.domain.AuthenticaionVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import ai.maum.biz.fastaicc.main.user.service.AuthService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SystemManageController {
	/* 공통서비스 */
	@Autowired
	CommonService commonService;

	/* 권한 서비스 */
	@Autowired
	AuthService authService;

	/* 상담서비스 */
	@Autowired
	ConsultingService consultingService;

	@Autowired
	CustomProperties customProperties;
	/* 설정값 */
	@Inject
	VariablesMng variablesMng;

	/* 통계서비스 */
	@Autowired
	StatisticsService statisticsService;

	/* 통계서비스 */
	@Autowired
	SuperCompanyService supercompanyService;

	@Autowired
	CampaignService campaignService;

	@Inject
	ExcelUtill excelUtill;

	@Autowired
	MenuService menuService;

	@Autowired
	SystemManageService systemManageService;

	@Autowired
	PasswordEncoder passwordEncoder;

	/***
	 *
	 * @param response
	 * @param jsonReTurnObj
	 * @throws IOException
	 */
	public static void jqGirdWriter(HttpServletResponse response, JsonObject jsonReTurnObj) throws IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.println(jsonReTurnObj);
		out.close();
	}

	/***
	 * 메뉴 그룹 권한관리 메인
	 *
	 * @param req
	 * @param model
	 * @return
	 */
	/* 메뉴 그룹 권한관리*/
	@RequestMapping(value = "/systemMenuGroupMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String systemMenuGroupMain(HttpServletRequest req, Model model) {
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름


		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=(AuthenticaionVO)auth;
			UserVO userVo = userDto.getUser();

			model.addAttribute("menuLinkedMap", menuService.getUserMenuCompany(userVo.getUserId())); // 로그인한 사용자 이름
		}

		return "system_manage/system_menu_group_manage";
	}

	/***
	 * 메뉴그룹 권한관리 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getMenuGroupMainList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String getMenuGroupMainList(@RequestBody String jsonStr, HttpServletResponse response, Model model,
			FrontMntVO frontMntVO) throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr====" + jsonStr);
		//로그인한 유저의 CompanyId
		String companyId = Utils.getLogInAccount(authService).getCompanyId();
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		map.put("companyId", companyId);
		// 메뉴그룹 권한관리 조회 리스트
		List<Map> MenuGroupList = systemManageService.getMenuGroupMainList(map);
		// 토탈카운트 겟수( 페이징)
		// int totalCount = supercompanyService.getADMCompanyMainCount(map);

		// 한페이지에 보여줄 row
		frontMntVO.setPageInitPerPage(map.get("rowNum").toString());
		String currentPage = map.get("page").toString();
		frontMntVO.setCurrentPage(currentPage);

		// 페이징을 위해서 쿼리 포함 전체 카운팅
		PagingVO pagingVO = new PagingVO();
		pagingVO.setCOUNT_PER_PAGE(frontMntVO.getPageInitPerPage());
		pagingVO.setTotalCount(systemManageService.getMenuGroupMainCount(map));
		pagingVO.setCurrentPage(frontMntVO.getCurrentPage());
		frontMntVO.setStartRow(pagingVO.getStartRow());
		frontMntVO.setLastRow(pagingVO.getLastRow());

		JsonObject jsonReTurnObj = new JsonObject();
		jsonReTurnObj.add("paging", new Gson().toJsonTree(pagingVO));
		jsonReTurnObj.add("MenuGroupList", new Gson().toJsonTree(MenuGroupList));
		jsonReTurnObj.add("frontMnt", new Gson().toJsonTree(frontMntVO));
		jqGirdWriter(response, jsonReTurnObj);

		return null;
	}

	/***
	 * system manage - 메뉴그룹관리 상세조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getMenuGroupDetail", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<Map> getMenuGroupDetail(@RequestBody String jsonStr, HttpServletRequest request)
			throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		// menu detail 수정
		List<Map> getMenuGroupDetail = systemManageService.getMenuGroupDetail(map);

		return getMenuGroupDetail;
	}

	/***
	 * system manage - 메뉴그룹 권한 관리 등록
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 * @throws JSONException
	 */
	@RequestMapping(value = "/insertMenuGroup", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> insertMenuGroup(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException, JSONException {
		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		Map<String, Object> map1 = null;
		//로그인한 유저의 CompanyId
		String companyId = Utils.getLogInAccount(authService).getCompanyId();
		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();


		JSONArray menuArray=new JSONArray(jsonStr);
		JSONObject jsonObject11 = menuArray.getJSONObject(0);
		jsonObject11.put("companyId", companyId);
		jsonObject11.put("registerId", userId);
		map1 = new ObjectMapper().readValue(jsonObject11.toString(), Map.class);

		systemManageService.insertMenuGroup(map1);

		// 체크한 menu insert
		for(int i=0; i<menuArray.length(); i++) {
			JSONObject jsonObject = menuArray.getJSONObject(i);

			jsonObject.put("registerId", userId);
			map = new ObjectMapper().readValue(jsonObject.toString(), Map.class);

			//권한관리 popup에서 선택한 메뉴가 있을때
			if(jsonObject.has("menuCode")) {
				systemManageService.insertMenuGroupMenu(map);
			}
		}

		return null;
	}

	/***
	 * system manage - 메뉴그룹 권한 관리 수정
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 * @throws JSONException
	 */
	@RequestMapping(value = "/updateMenuGroup", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> updateMenuGroup(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException, JSONException {
		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		Map<String, Object> map1 = null;
		//로그인한 유저의 CompanyId
		String companyId = Utils.getLogInAccount(authService).getCompanyId();
		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();

		JSONArray menuArray=new JSONArray(jsonStr);

		JSONObject jsonObject11 = menuArray.getJSONObject(0);
		jsonObject11.put("updusrId", userId);

		map1 = new ObjectMapper().readValue(jsonObject11.toString(), Map.class);
		// update menuGroup Service 넣기
		systemManageService.updateMenuGroup(map1);

		String companyGroupId = jsonObject11.getString("companyGroupId");
		systemManageService.deleteMenuGroupMenu(companyGroupId);

		// 체크한 menu insert
		for(int i=0; i<menuArray.length(); i++) {
			JSONObject jsonObject = menuArray.getJSONObject(i);

			jsonObject.put("registerId", userId);
			map = new ObjectMapper().readValue(jsonObject.toString(), Map.class);

			//권한관리 popup에서 선택한 메뉴가 있을때
			if(jsonObject.has("menuCode")) {
				systemManageService.updateMenuGroupMenu(map);
			}
		}
		return null;
	}

	/***
	 * 메뉴 그룹 권한 관리 삭제
	 *
	 * @param jsonStr
	 * @return
	 * @throws JSONException
	 */
	@RequestMapping(value = "/deleteMenuGroupInfo", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> deleteMenuGroupInfo(@RequestBody String jsonStr) throws JSONException {
		log.debug("jsonStr====" + jsonStr);

		JSONObject jsonObject = new JSONObject(jsonStr);
		JSONArray jsonArray = jsonObject.getJSONArray("companyGroupId");

		for(int i = 0; i < jsonArray.length(); i++) {
			String companyGroupId = jsonArray.getString(i);
			// menuGroupUser 삭제
			systemManageService.deleteMenuGroupUser(companyGroupId);
			// menuGroupMenu 삭제
			systemManageService.deleteMenuGroupMenu(companyGroupId);
			// menuGroup 삭제
			systemManageService.deleteMenuGroup(companyGroupId);
		}

		return null;
	}


	/***
	 * 시스템 관리 - 메뉴 그룹 사용자리 메인
	 *
	 * @param req
	 * @param model
	 * @return
	 */
	/* 메뉴 그룹 권한관리*/
	@RequestMapping(value = "/systemMenuGroupUserMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String systemMenuGroupUserMain(HttpServletRequest req, Model model) {
		Map map = new HashMap();
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름

		String companyId = Utils.getLogInAccount(authService).getCompanyId();

		map.put("companyId", companyId);
		// 권한 그룹 조회
		model.addAttribute("MenuAuthGroup", systemManageService.selectMenuAuthGroup(map));
		model.addAttribute("companyCampaigns", systemManageService.getCompanyCampaigns(map));

		return "system_manage/system_menu_group_user_manage";
	}

	/***
	 * 메뉴그룹 권한관리 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getMenuGroupUserMainList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String getMenuGroupUserMainList(@RequestBody String jsonStr, HttpServletResponse response, Model model,
			FrontMntVO frontMntVO) throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr====" + jsonStr);
		//로그인한 유저의 CompanyId
		String companyId = Utils.getLogInAccount(authService).getCompanyId();
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		map.put("companyId", companyId);
		// 메뉴그룹 권한관리 조회 리스트
		List<Map> MenuGroupUserList = systemManageService.getSystemMenuGroupUserMainList(map);
		for(int i = 0; i<MenuGroupUserList.size(); i++){
			try{
				if(customProperties.getPwErrMax()<=(Integer)MenuGroupUserList.get(i).get("PW_ERROR")){
					MenuGroupUserList.get(i).put("nowLock",true);
				}
			}catch (Exception e){}
		}
		// 토탈카운트 겟수( 페이징)
		// int totalCount = supercompanyService.getADMCompanyMainCount(map);

		// 한페이지에 보여줄 row
		frontMntVO.setPageInitPerPage(map.get("rowNum").toString());
		String currentPage = map.get("page").toString();
		frontMntVO.setCurrentPage(currentPage);

		// 페이징을 위해서 쿼리 포함 전체 카운팅
		PagingVO pagingVO = new PagingVO();
		pagingVO.setCOUNT_PER_PAGE(frontMntVO.getPageInitPerPage());
		pagingVO.setTotalCount(systemManageService.getSystemMenuGroupUserMainCount(map));
		pagingVO.setCurrentPage(frontMntVO.getCurrentPage());
		frontMntVO.setStartRow(pagingVO.getStartRow());
		frontMntVO.setLastRow(pagingVO.getLastRow());

		JsonObject jsonReTurnObj = new JsonObject();
		jsonReTurnObj.add("paging", new Gson().toJsonTree(pagingVO));
		jsonReTurnObj.add("MenuGroupUserList", new Gson().toJsonTree(MenuGroupUserList));
		jsonReTurnObj.add("frontMnt", new Gson().toJsonTree(frontMntVO));
		jqGirdWriter(response, jsonReTurnObj);

		return null;
	}

	/***
	 * 신규등록
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/insertMenuAuthUserInfo", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String insertMenuAuthUserInfo(@RequestBody String jsonStr) throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
		String result = "";

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		String companyId = Utils.getLogInAccount(authService).getCompanyId();
		// 상담사 상태 업데이트
		Map<String, Object> SpCompMap = new ObjectMapper().readValue(jsonObj.get("setSpUser").toString(), Map.class);
		SpCompMap.put("CUST_OP_ID", userId);
		SpCompMap.put("companyId", companyId);

		String menuGroupUserId = systemManageService.selectUserId(SpCompMap);
		/*String orginPw = systemManageService.selectPassword(SpCompMap);
		String inputPw = (String) SpCompMap.get("userPw");*/
		if(SpCompMap.get("userPw") != null && SpCompMap.get("userPw") != "") {
			String securityPw = passwordEncoder.encode((CharSequence) SpCompMap.get("userPw"));
			SpCompMap.put("userPw", securityPw);
		}

/*		if(orginPw != null) {
			if(orginPw.equals(inputPw)) {
				SpCompMap.put("userPw", orginPw);
			}else {
				SpCompMap.put("userPw", securityPw);
			}
		}else {
			SpCompMap.put("userPw", securityPw);
		}
*/
		int userDto = systemManageService.insertMenuAuthUserInfo(SpCompMap);

		// 메뉴 권한그룹 등록 및 수정
		if(menuGroupUserId == null) {
			systemManageService.insertMenuAuthMenuGroup(SpCompMap);
			result = "insert";
		}else {
			systemManageService.updateMenuAuthMenuGroup(SpCompMap);
			result = "update";
		}

		//CM_COMPANY_USER_CAMPAIGNS USER에 대한 CAMPAIGN DELETE
		systemManageService.deleteCompanyUserCampaigns(SpCompMap.get("userId").toString());

		//CM_COMPANY_USER_CAMPAIGNS에 회사별 USER CAMPAIGN INSERT
		List userCampaignList = (List) SpCompMap.get("userCampaignList");
		if(userCampaignList.size() > 0){
			systemManageService.insertCompanyUserCampaigns(SpCompMap);
		}
		return result;
	}

	/***
	 * 상세조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getMenuGroupUserId", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<Map> getMenuGroupUserId(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		List<Map> userInfo = systemManageService.getMenuGroupUserInfo(map);

		List<Map<String, Object>> userCampaigns = systemManageService.getCompanyUserCampaigns(map.get("ipt_srchId").toString());

		Map<String, Object> userCampaignsMap = new HashMap<>();
		userCampaignsMap.put("userCampaignsList", userCampaigns);

		userInfo.add(userCampaignsMap);

		return userInfo;
	}


	/***
	 * 메뉴그룹 유저Info 삭제
	 *
	 * @param jsonStr
	 * @return
	 * @throws JSONException
	 */
	@RequestMapping(value = "/deleteMenuGroupUserInfo", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> deleteMenuGroupUserInfo(@RequestBody String jsonStr) throws JSONException {
		log.debug("jsonStr====" + jsonStr);

		// 로그인 사용자 ID 가져오기
		JSONObject jsonObject = new JSONObject(jsonStr);
		JSONArray jsonArray = jsonObject.getJSONArray("userId");

		for(int i = 0; i < jsonArray.length(); i++) {
			String userid = jsonArray.getString(i);
			systemManageService.deleteMenuGroupUserInfo(userid);

			systemManageService.deleteAuthGroupInfo(userid);

		}

		return null;
	}

	/***
	 * 회사 및 신청한 서비스 사용 정보 확인 / 수정
	 *
	 * @param req
	 * @param model
	 * @return
	 */
	/* 메뉴 그룹 권한관리*/
	@RequestMapping(value = "/systemCompanyInfoMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String systemCompanyInfoMain(HttpServletRequest req, Model model) {
		Map map = new HashMap();
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		String companyId = Utils.getLogInAccount(authService).getCompanyId();
		map.put("companyId", companyId);
		// 권한 그룹 조회
		model.addAttribute("systemCompany", systemManageService.selectSystemCompanyInfo(map));
		model.addAttribute("companyMenu", systemManageService.selectCompanyMenu(map));
		return "system_manage/system_company_info";
	}

	/***
	 * system manage - 회사 정보 수정
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/updateSystemCompanyInfo", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<Map> updateSystemCompanyInfo(@RequestBody String jsonStr, HttpServletRequest request)
			throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
		//System.out.println("jsonStr" + jsonStr);

		Map<String, Object> map = null;
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		map.put("userId", userId);
		// 회사 정보 수정
		systemManageService.updateSystemCompanyInfo(map);

		return null;
	}

	/* 인텐트관리 */
	@RequestMapping(value = "/alarmIntentManagement", method = { RequestMethod.GET, RequestMethod.POST })
	public String alarmIntentManagementMain(HttpServletRequest req, Model model) {
		Map map = new HashMap();
		model.addAttribute("userName", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();

		map.put("sessId", userId);
		String companyId = statisticsService.getBoardCompanyId(map); //로그인한 사용자의 회사 ID
		map.put("companyId", companyId);
		String companyName = statisticsService.getBoardCompanyName(map); //로그인한 사용자의 회사 명
		model.addAttribute("userId", userId);
		model.addAttribute("companyId", companyId);
		model.addAttribute("companyName", companyName);

		return "system_manage/alarm_intent_management";
	}

	/* 인텐트 (카테고리) list 조회 */
	@ResponseBody
	@RequestMapping(value = "/getMappingInfo", method = { RequestMethod.GET, RequestMethod.POST })
	public Map getMappingInfo(HttpServletRequest request, HttpServletResponse response) {
		Map map = new HashMap();
		map.put("companyId", request.getParameter("companyId"));

		Map intentList = systemManageService.selectBotIdsByCompanyId(map);

		return intentList;
	}

  /* 인텐트 (카테고리) list 조회 */
  @ResponseBody
  @RequestMapping(value = "/getIntentList", method = { RequestMethod.GET, RequestMethod.POST })
  public List<Map> getIntentList(HttpServletRequest request, HttpServletResponse response) {
  	Map map = new HashMap();
  	map.put("companyId", request.getParameter("companyId"));
  	map.put("keyword", request.getParameter("keyword"));

    List<Map> intentList = systemManageService.selectIntentList(map);

    return intentList;
  }

	/* 배정 가능한 상담사 목록 조회 */
	@ResponseBody
	@RequestMapping(value = "/getPosCounselorList", method = { RequestMethod.GET, RequestMethod.POST })
	public List<Map> getPosCounselorList(HttpServletRequest request, HttpServletResponse response) {
		Map map = new HashMap();
		map.put("companyId", request.getParameter("companyId"));
		map.put("botId", request.getParameter("botId"));
		map.put("intentId", request.getParameter("intentId"));
		map.put("keyword", request.getParameter("keyword"));

		List<Map> intentList = systemManageService.selectPosCounselorList(map);

		return intentList;
	}

	/* 챗봇-인텐트에 배정되어 있는 상담사 목록 조회 */
	@ResponseBody
	@RequestMapping(value = "/getAssignedCounselorList", method = { RequestMethod.GET, RequestMethod.POST })
	public List<Map> getAssignedCounselorList(HttpServletRequest request, HttpServletResponse response) {
		Map map = new HashMap();
		map.put("companyId", request.getParameter("companyId"));
		map.put("botId", request.getParameter("botId"));
		map.put("intentId", request.getParameter("intentId"));
		map.put("keyword", request.getParameter("keyword"));

		List<Map> intentList = systemManageService.selectAssignedCounselorList(map);

		return intentList;
	}

	/* 배정된 상담사 목록 업데이트 */
	@ResponseBody
	@RequestMapping(value = "/saveCounselorList", method = { RequestMethod.GET, RequestMethod.POST })
	public void saveCounselorList(HttpServletRequest request, HttpServletResponse response) {
		List<Object> counselorInfoList = new ArrayList<>();
		Map<String, String> map1 = new HashMap<>();
		Gson gson = new Gson();

		if (!request.getParameter("counselorInfoList").equals("[]")) {
			String[] splitData = request.getParameter("counselorInfoList").replace("[", "")
					.replace("]", "")
					.replace("},{", "}/{")
					.split("/");

			for (int i = 0; i < splitData.length; i++) {
				map1 = gson.fromJson(splitData[i], map1.getClass());
				counselorInfoList.add(map1);
			}
		}

		Map map = new HashMap();
		map.put("companyId", request.getParameter("companyId"));
		map.put("botId", request.getParameter("botId"));
		map.put("intentId", request.getParameter("intentId"));
		map.put("updaterId", request.getParameter("updaterId"));
		map.put("counselorInfoList", counselorInfoList);

		systemManageService.deleteCounselorList(map);
		if (counselorInfoList.size() != 0) {
			systemManageService.insertCounselorList(map);
		}
	}
}
