package ai.maum.biz.fastaicc.main.system.admin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import java.util.Map.Entry;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

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
import ai.maum.biz.fastaicc.main.system.menu.domain.MenuVO;
import ai.maum.biz.fastaicc.main.system.menu.service.MenuService;
import ai.maum.biz.fastaicc.main.user.domain.AuthenticaionVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import ai.maum.biz.fastaicc.main.user.service.AuthService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SuperCompanyController {
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

	/***
	 * company 및 권한관리
	 *
	 * @param req
	 * @param model
	 * @return
	 */
	/* company 및 권한관리 */
	@RequestMapping(value = "/superCompMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String spAdmCompManage(HttpServletRequest req, Model model) {
		Map map = new HashMap();
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		model.addAttribute("menuMap", menuService.getUserMenuAll()); // 로그인한 사용자 이름
		model.addAttribute("campaignListMap", campaignService.getAllCampaign()); // 캠페인 리스트
		return "admin/spAdmin_company_manage";
	}

	/***
	 * Company 및 권한 관리 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getSUPERCompanyJQList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String superADMCompanyJQList(@RequestBody String jsonStr, HttpServletResponse response, Model model,
			FrontMntVO frontMntVO) throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		// company 및 권한관리 리스트
		List<Map> superCompList = supercompanyService.getADMCompanyMainList(map);
		// 카운트 겟수( 페이징)
		// int totalCount = supercompanyService.getADMCompanyMainCount(map);

		// 한페이지에 보여줄 row
		frontMntVO.setPageInitPerPage(map.get("rowNum").toString());
		String currentPage = map.get("page").toString();
		frontMntVO.setCurrentPage(currentPage);

		// 페이징을 위해서 쿼리 포함 전체 카운팅
		PagingVO pagingVO = new PagingVO();
		pagingVO.setCOUNT_PER_PAGE(frontMntVO.getPageInitPerPage());
		pagingVO.setTotalCount(supercompanyService.getADMCompanyMainCount(map));
		pagingVO.setCurrentPage(frontMntVO.getCurrentPage());
		frontMntVO.setStartRow(pagingVO.getStartRow());
		frontMntVO.setLastRow(pagingVO.getLastRow());

		JsonObject jsonReTurnObj = new JsonObject();
		jsonReTurnObj.add("paging", new Gson().toJsonTree(pagingVO));
		jsonReTurnObj.add("superCompList", new Gson().toJsonTree(superCompList));
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
	@RequestMapping(value = "/insertCompanyInfo", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> insertCompanyInfo(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
		System.out.println("jsonString" + jsonStr);

		Map<String, Object> map = null;

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();

		// 상담사 상태 업데이트
		Map<String, Object> SpCompMap = new ObjectMapper().readValue(jsonObj.get("setSpComp").toString(), Map.class);
		SpCompMap.put("CUST_OP_ID", userId);
		int userDto = supercompanyService.insertCompanyInfo(SpCompMap);

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
	@RequestMapping(value = "/deleteCompanyInfo", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> deleteCompanyInfo(@RequestBody String jsonStr, HttpServletRequest request,
			HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		int userDto = supercompanyService.deleteCompanyInfo(map);

		return null;
	}

	/***
	 * 신규등록 회사명 중복체크 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getCompanyName", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<Map> getCompanyName(@RequestBody String jsonStr, HttpServletRequest request,
			HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		// 인바운드 콜 토탈 통계 리스트
		List<Map> companyListInfo = supercompanyService.getCompanyNameInfo(map);
		// 토탈카운트 겟수( 페이징)
		return companyListInfo;
	}

	/***
	 * 신규등록 회사ID 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getCompanyIdInfo", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String getCompanyIdInfo(@RequestBody String jsonStr, HttpServletRequest request,
			HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		// 회사ID 조회
		String companyId = supercompanyService.getCompanyIdInfo(map);

		return companyId;
	}

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
	 * company 및 권한관리 상세조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getCompanyInfo", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<Map> getCompanyInfo(@RequestBody String jsonStr, HttpServletRequest request,
			HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		// company 및 권한관리 회사 상세조회
		List<Map> companyInfo = supercompanyService.getCompanyInfo(map);

		return companyInfo;
	}

	/***
	 * company menu 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getCompanyMenu", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<Map> getCompanyMenu(@RequestBody String jsonStr, HttpServletRequest request,
			HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		// company 및 권한관리 회사 상세조회
		List<Map> companyMenu = supercompanyService.getCompanyMenu(map);

		return companyMenu;
	}

	/***
	 * company menu 등록
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 * @throws JSONException
	 */
	@RequestMapping(value = "/insertCompanyMenu", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> insertCompanyMenu(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException, JSONException {
		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;

		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();

		JSONArray menuArray=new JSONArray(jsonStr);
		// companyId 가져오기
		String companyId = menuArray.getJSONObject(0).get("companyId").toString();
		// companyId에 대한 메뉴 delete
		supercompanyService.deleteCompanyMenu(companyId);

		// 체크한 menu insert
		for(int i=0; i<menuArray.length(); i++) {
			JSONObject jsonObject = menuArray.getJSONObject(i);

			jsonObject.put("sortOrdr", (i+1));
			jsonObject.put("registerId", userId);
			map = new ObjectMapper().readValue(jsonObject.toString(), Map.class);

			//권한관리 popup에서 선택한 메뉴가 있을때
			if(jsonObject.has("menuCode")) {
				supercompanyService.insertCompanyMenu(map);
			}
		}
		
		List<Map> newCompanyMenu = supercompanyService.getCompanyMenu(map);
		List<Map> companyMenuGroupMenu = supercompanyService.getCompanyMenuGroupMenu(map);
		List menuList = new ArrayList<>();
		
		int insMenu = 0;
		for(Map<String,Object> menuCode : newCompanyMenu) {
			menuList.add(insMenu++, menuCode.get("MENU_CODE"));
		}
		
		for (int i = 0; i < companyMenuGroupMenu.size(); i++) {
			if(!menuList.contains(companyMenuGroupMenu.get(i).get("MENU_CODE"))) {
				supercompanyService.deleteCompanyMenuGroupMenu(companyMenuGroupMenu.get(i));
			}
		}
		
		
		

		return null;
	}
	/***
	 * company campaign 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getCompanyCampaigns", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<Map<String, Object>> getCompanyCampaigns(@RequestBody String jsonStr, HttpServletRequest request,
									HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		// company 및 권한관리 회사 상세조회
//		List<Map> companyMenu = supercompanyService.getCompanyMenu(map);
		List<Map<String, Object>> companyCampaigns = supercompanyService.getCompanyCampaigns(map);

		return companyCampaigns;
	}
	/***
	 * company campaigns 등록
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 * @throws JSONException
	 */
	@RequestMapping(value = "/insertCompanyCampaigns", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> insertCompanyCampaigns(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException, JSONException {
		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		// company campaigns insert 전에 해당 회상에 대한 companyCampaigns delete
		supercompanyService.deleteCompanyCampaigns(map.get("companyId").toString());

		// companyCampaigns Insert || parameterType List 형태로 한번에 insert
		List campaignList = (List) map.get("campaignList");
		if(campaignList.size() > 0){
			supercompanyService.insertCompanyCampaigns(map);
		}

		return null;
	}

	/***
	 * company 및 권한관리
	 *
	 * @param req
	 * @param model
	 * @return
	 */
	/* company 및 권한관리 */
	@RequestMapping(value = "/superUserMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String spAdmUserManage(HttpServletRequest req, Model model) {
		Map map = new HashMap();
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
		return "admin/spAdmin_user_manage";
	}

	/***
	 * 시스템 메뉴관리
	 *
	 * @param req
	 * @param model
	 * @return
	 */
	/* 시스템 메뉴관리*/
	@RequestMapping(value = "/superMenuMain", method = { RequestMethod.GET, RequestMethod.POST })
	public String spAdmMenuManage(HttpServletRequest req, Model model) {
		Map map = new HashMap();
		model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=(AuthenticaionVO)auth;
			UserVO userVo = userDto.getUser();
			userVo.setSysMenuMap(menuService.getMenu());
			model.addAttribute("menuLinkedMap", userVo.getSysMenuMap());
		}

		return "admin/spAdmin_menu_manage";
	}

	@RequestMapping(value = "/getMenuList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public LinkedHashMap<String, MenuVO> getMenuList(HttpServletRequest request, HttpServletResponse response) throws IOException {
		LinkedHashMap<String, MenuVO> menuList = null;

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
			AuthenticaionVO userDto=(AuthenticaionVO)auth;
			UserVO userVo = userDto.getUser();
			userVo.setSysMenuMap(menuService.getMenu());
			menuList = userVo.getSysMenuMap();
		}

		return menuList;
	}

	/***
	 * system manage menu detail 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getMenuDetail", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<Map> getMenuDetail(@RequestBody String jsonStr, HttpServletRequest request,
			HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		// company 및 권한관리 회사 상세조회
		List<Map> menuDetail = supercompanyService.getMenuDetail(map);

		String cours = menuService.getUserMeneCours(map.get("lang").toString(), map.get("menuCode").toString());
		map.put("SortOrdr", supercompanyService.getMenuSortOrdr(map));
		map.put("COURS", cours);
		menuDetail.add(map);

		return menuDetail;
	}

	/***
	 * system manage - menu detail 수정
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/updateMenuDetail", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> updateMenuDetail(@RequestBody String jsonStr, HttpServletRequest request)
			throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// 로그인 사용자 ID 가져오기
		String userId = auth.getName();
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		// menu detail 수정
		int updateMenuDetail = supercompanyService.updateMenuDetail(map);

		if(map.get("parentMenuCode") != null){
			/*
			*  TN_COMPANY_MENU 하위 메뉴는 할당되어 있지만 상위 메뉴가 할당 되어있지 않을때
			*  체크해서 INSERT 하는 로직.
			*  수정된 MENU_CODE로 COMPANY_ID LIST를 조회 한 후
			*  조회된 COMPANY_ID로 TN_COMPANY_MENU의 TOP_MENU 와 PARENT_MENU를 조회해서 없으면 INSERT
			*/

			//TN_COMPANY_MENU에서 COMPANY_ID 조회
			List<Map<String, Object>> menuInCompanyIdListMap = supercompanyService.getMenuInCompanyIdListMap(map.get("menuCode").toString());

			for (int i = 0; i < menuInCompanyIdListMap.size(); i++){

				Map<String, Object>  compTopMenuMap = new HashMap<>();
				compTopMenuMap.put("companyId", menuInCompanyIdListMap.get(i).get("companyId").toString());
				compTopMenuMap.put("topMenuCode", map.get("topMenuCode").toString());
				compTopMenuMap.put("parentMenuCode", map.get("parentMenuCode").toString());

				//TN_COMPANY_MENU에서 TOP_MENU_CODE 및 PARENT_MENU_CODE 여부 체크 있으면 'Y' 없으면 'N'
				List<Map<String,Object>> topCodeYnListMap = supercompanyService.getTopCodeYnListMap(compTopMenuMap);
				if(topCodeYnListMap.size() > 0){
					for (int j = 0; j < topCodeYnListMap.size(); j++){

						Map<String, Object> insertMenuCodeMap = new HashMap<>();
						insertMenuCodeMap.put("companyId", menuInCompanyIdListMap.get(i).get("companyId").toString());
						insertMenuCodeMap.put("userId", userId);

						// TOP_MENU_CODE랑 PARENT_MENU_CODE가 같은지 다른지 여부에 따라서 나눔.
						// 같으면 MENU_CODE값이 같기 때문에 한번만 INSERT (2DEPTH MENU일 경우)
						// 다르면 MENU_CODE값이 다르기 때문에 각각 해당 MENU_CODE를 체크해서 'N'일 경우 INSERT
						if(!map.get("topMenuCode").toString().equals(map.get("parentMenuCode").toString())){
							if(topCodeYnListMap.get(j).get("topMenuCodeYn").toString().equals("N")){
								insertMenuCodeMap.put("menuCode", map.get("topMenuCode").toString());
								supercompanyService.insertCompanyMenuCode(insertMenuCodeMap);
							}

							if(topCodeYnListMap.get(j).get("parentMenuCodeYn").toString().equals("N")){
								insertMenuCodeMap.put("menuCode", map.get("parentMenuCode").toString());
								supercompanyService.insertCompanyMenuCode(insertMenuCodeMap);
							}
						}else{
							if(topCodeYnListMap.get(j).get("topMenuCodeYn").toString().equals("N")){
								insertMenuCodeMap.put("menuCode", map.get("topMenuCode").toString());
								supercompanyService.insertCompanyMenuCode(insertMenuCodeMap);
							}
						}
					}
				}
			}

			/*
			 *  TN_COMPANY_MENU_GROUP_MENU 하위 메뉴는 할당되어 있지만 상위 메뉴가 할당 되어있지 않을때
			 *  체크해서 INSERT 하는 로직.
			 *  수정된 MENU_CODE로 COMPANY_GROUP_ID LIST를 조회 한 후
			 *  조회된 COMPANY_GROUP_ID로 TN_COMPANY_MENU_GROUP_MENU의 TOP_MENU 와 PARENT_MENU를 조회해서 없으면 INSERT
			 */

			//TN_COMPANY_MENU_GROUP_MENU에서 COMPANY_GROUP_ID 조회
			List<Map<String, Object>> compMenuGroupIdListMap = supercompanyService.getCompGroupMenuIds(map.get("menuCode").toString());

			for (int i = 0; i < compMenuGroupIdListMap.size(); i++){

				Map<String, Object>  compGroupTopMenuMap = new HashMap<>();

				compGroupTopMenuMap.put("companyGroupId", compMenuGroupIdListMap.get(i).get("companyGroupId").toString());
				compGroupTopMenuMap.put("topMenuCode", map.get("topMenuCode").toString());
				compGroupTopMenuMap.put("parentMenuCode", map.get("parentMenuCode").toString());

				//TN_COMPANY_MENU_GROUP_MENU에서 TOP_MENU_CODE 및 PARENT_MENU_CODE 여부 체크 있으면 'Y' 없으면 'N'
				List<Map<String,Object>> compGroupTopCodeYnListMap = supercompanyService.getCompGroupTopCodeYnListMap(compGroupTopMenuMap);
				if(compGroupTopCodeYnListMap.size() > 0) {
					for (int j = 0; j < compGroupTopCodeYnListMap.size(); j++) {

						Map<String, Object> insertCompGroupMenuMap = new HashMap<>();
						insertCompGroupMenuMap.put("companyGroupId", compMenuGroupIdListMap.get(i).get("companyGroupId").toString());
						insertCompGroupMenuMap.put("userId", userId);

						// TOP_MENU_CODE랑 PARENT_MENU_CODE가 같은지 다른지 여부에 따라서 나눔.
						// 같으면 MENU_CODE값이 같기 때문에 한번만 INSERT (2DEPTH MENU일 경우)
						// 다르면 MENU_CODE값이 다르기 때문에 각각 해당 MENU_CODE를 체크해서 'N'일 경우 INSERT
						if(!map.get("topMenuCode").toString().equals(map.get("parentMenuCode").toString())) {
							if (compGroupTopCodeYnListMap.get(j).get("topMenuCodeYn").toString().equals("N")) {
								insertCompGroupMenuMap.put("menuCode", map.get("topMenuCode").toString());
								supercompanyService.insertCompanyGroupMenuCode(insertCompGroupMenuMap);
							}

							if (compGroupTopCodeYnListMap.get(j).get("parentMenuCodeYn").toString().equals("N")) {
								insertCompGroupMenuMap.put("menuCode", map.get("parentMenuCode").toString());
								supercompanyService.insertCompanyGroupMenuCode(insertCompGroupMenuMap);
							}
						}else {
							if (compGroupTopCodeYnListMap.get(j).get("topMenuCodeYn").toString().equals("N")) {
								insertCompGroupMenuMap.put("menuCode", map.get("topMenuCode").toString());
								supercompanyService.insertCompanyGroupMenuCode(insertCompGroupMenuMap);
							}
						}
					}
				}
			}

		}

		UserVO userVo=null;
		AuthenticaionVO userDto=(AuthenticaionVO)auth;
		userVo = userDto.getUser();
		// 유저 권한 메뉴 셋팅
		userVo.setMenuLinkedMap(menuService.getUserMenu(userVo.getUserAuthTy(),userVo.getUserId()));
		userVo.setSysMenuMap(menuService.getMenu());

		String cours = menuService.getUserMeneCours(map.get("lang").toString(), map.get("menuCode").toString());
		map.put("COURS", cours);
		return map;
	}


	/***
	 * system manage - menu 삭제
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/deleteMenu", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> deleteMenu(@RequestBody String jsonStr, HttpServletRequest request)
			throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// 로그인 사용자 ID 가져오기
		String userId = auth.getName();

		// menu detail 수정
		Map<String, Object> deleteMenuMap = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		supercompanyService.deleteMenu(deleteMenuMap);

		UserVO userVo=null;
		AuthenticaionVO userDto=(AuthenticaionVO)auth;
		userVo = userDto.getUser();
		// 유저 권한 메뉴 셋팅
		userVo.setMenuLinkedMap(menuService.getUserMenu(userVo.getUserAuthTy(),userVo.getUserId()));
		return null;
	}

	/***
	 * system manage - menuCode 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getMenuCode", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<Map> getMenuCode(@RequestBody String jsonStr, HttpServletRequest request,
			HttpServletResponse response,Model model) throws JsonParseException, JsonMappingException, IOException {
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		Map<String, Object> map = null;
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
		List<Map> MenuCode = supercompanyService.getMenuCode(map);

		map.put("SortOrdr", supercompanyService.getMenuSortOrdr(map));
		MenuCode.add(map);
		return MenuCode;
	}

	/***
	 * system manage - menu 추가
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/insertSystemMenu", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> insertSystemMenu(@RequestBody String jsonStr)
			throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();

		// 메뉴 추가
		Map<String, Object> insertMenu = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		for (Entry<String, Object> entry: insertMenu.entrySet()) {
		    if(entry.getValue().equals(""))entry.setValue(null);
		}

		insertMenu.put("registerId", userId);
		supercompanyService.insertSystemMenu(insertMenu);

		UserVO userVo=null;
		AuthenticaionVO userDto=(AuthenticaionVO)auth;
		userVo = userDto.getUser();
		// 유저 권한 메뉴 셋팅
		userVo.setMenuLinkedMap(menuService.getUserMenu(userVo.getUserAuthTy(),userVo.getUserId()));

		return null;
	}

	/***
	 * User 관리 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getSUPERUserList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String superADMUserList(@RequestBody String jsonStr, HttpServletResponse response, Model model,
			FrontMntVO frontMntVO) throws JsonParseException, JsonMappingException, IOException {
		log.info("jsonStr====" + jsonStr);
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		// 사용자관리 조회 리스트
		List<Map> superUserList = supercompanyService.getADMUserMainList(map);
		for(int i = 0; i<superUserList.size(); i++){
			try{
				if(customProperties.getPwErrMax()<=(Integer)superUserList.get(i).get("PW_ERROR")){
					superUserList.get(i).put("nowLock",true);
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
		pagingVO.setTotalCount(supercompanyService.getADMUserMainCount(map));
		pagingVO.setCurrentPage(frontMntVO.getCurrentPage());
		frontMntVO.setStartRow(pagingVO.getStartRow());
		frontMntVO.setLastRow(pagingVO.getLastRow());

		JsonObject jsonReTurnObj = new JsonObject();
		jsonReTurnObj.add("paging", new Gson().toJsonTree(pagingVO));
		jsonReTurnObj.add("superUserList", new Gson().toJsonTree(superUserList));
		jsonReTurnObj.add("frontMnt", new Gson().toJsonTree(frontMntVO));
		jqGirdWriter(response, jsonReTurnObj);

		return null;
	}

	/***
	 * 신규등록 회사명 중복체크 조회
	 *
	 * @param jsonStr
	 * @return
	 * @throws IOException
	 * @throws JsonMappingException
	 * @throws JsonParseException
	 */
	@RequestMapping(value = "/getUserId", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<Map> getUserId(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response)
			throws JsonParseException, JsonMappingException, IOException {
		Map<String, Object> map = null;
		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		JsonArray jArray = new JsonArray();
		// json -> map
		map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

		// 중복체크 조회
		List<Map> userInfo = supercompanyService.getUserInfo(map);

		return userInfo;
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
	@RequestMapping(value = "/insertUserInfo", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> insertUserInfo(@RequestBody String jsonStr) throws JsonParseException, JsonMappingException, IOException {
		log.debug("jsonStr====" + jsonStr);
		Map<String, Object> map = null;

		// json파서
		JsonParser jp = new JsonParser();
		JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
		// 로그인 사용자 ID 가져오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = auth.getName();

		// 상담사 상태 업데이트
		Map<String, Object> SpCompMap = new ObjectMapper().readValue(jsonObj.get("setSpUser").toString(), Map.class);
		SpCompMap.put("CUST_OP_ID", userId);

		int userDto = supercompanyService.insertUserInfo(SpCompMap);

		return null;
	}

	/***
	 * 신규등록
	 *
	 * @param jsonStr
	 * @return
	 * @throws JSONException
	 */
	@RequestMapping(value = "/deleteUserInfo", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> deleteUserInfo(@RequestBody String jsonStr) throws JSONException {
		log.debug("jsonStr====" + jsonStr);

		// 로그인 사용자 ID 가져오기
		JSONObject jsonObject = new JSONObject(jsonStr);
		JSONArray jsonArray = jsonObject.getJSONArray("userId");

		for(int i = 0; i < jsonArray.length(); i++) {
			String userid = jsonArray.getString(i);

			supercompanyService.deleteUserInfo(userid);
		}

		return null;
	}

	/***
	 * company에 chatbot 할당
	 *
	 * @param req
	 * @param model
	 * @return
	 */
	/* 챗봇관리 */
	@RequestMapping(value = "/chatbotManagement", method = { RequestMethod.GET, RequestMethod.POST })
	public String chatbotManagement(HttpServletRequest req, Model model) {
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

		return "admin/spAdmin_chatbot_manage";
	}

	/* 챗봇 list 조회 */
	@ResponseBody
	@RequestMapping(value = "/getAccountList", method = { RequestMethod.GET, RequestMethod.POST })
	public Map<String, Map> getAccountList(HttpServletRequest request, HttpServletResponse response) {
		List<Map> res = supercompanyService.selectAccountList();
		Map<String, Map> map = new LinkedHashMap<>();
		for (int i = 0; i< res.size(); i++) {
			map.put(res.get(i).get("No").toString(), res.get(i));
		}

		return map;
	}

	/* company list 조회 */
	@ResponseBody
	@RequestMapping(value = "/getCompanyList", method = { RequestMethod.GET, RequestMethod.POST })
	public List<Map> getCompanyList(HttpServletRequest request, HttpServletResponse response) {
		Map map = new HashMap();
		map.put("companyKeyword", request.getParameter("companyKeyword"));

		List<Map> chatbotList = supercompanyService.selectCompanyList(map);

		return chatbotList;
	}

	/* mapping 되어있는 챗봇 목록 조회 */
	@ResponseBody
	@RequestMapping(value = "/getBotMappingInfo", method = { RequestMethod.GET, RequestMethod.POST })
	public List<Map> getBotMappingInfo(HttpServletRequest request, HttpServletResponse response) {
		Map map = new HashMap();
		map.put("companyId", request.getParameter("companyId"));

		List<Map> chatbotList = supercompanyService.selectBotMappingInfo(map);

		return chatbotList;
	}

	/* 챗봇 host병 매핑되어있는 조회 */
	@ResponseBody
	@RequestMapping(value = "/getMappedBotCnt", method = { RequestMethod.GET, RequestMethod.POST })
	public Map getMappedBotCnt(HttpServletRequest request, HttpServletResponse response) {
		return supercompanyService.selectMappedBotCnt();
	}

	/* 배정된 챗봇 목록 업데이트 */
	@ResponseBody
	@RequestMapping(value = "/saveChatbotMapping", method = { RequestMethod.GET, RequestMethod.POST })
	public void saveChatbotMapping(HttpServletRequest request, HttpServletResponse response) {
		List<Object> chatbotInfoList = new ArrayList<>();
		Map<String, String> map1 = new HashMap<>();
		Gson gson = new Gson();

		if (!request.getParameter("chatbotInfoList").equals("[]")) {
			String[] splitData = request.getParameter("chatbotInfoList").replace("[", "")
					.replace("]", "")
					.replace("},{", "}/{")
					.split("/");

			for (int i = 0; i < splitData.length; i++) {
				map1 = gson.fromJson(splitData[i], map1.getClass());
				chatbotInfoList.add(map1);
			}
		}

		Map map = new HashMap();
		map.put("companyId", request.getParameter("companyId"));
		map.put("updaterId", request.getParameter("updaterId"));
		map.put("chatbotInfoList", chatbotInfoList);

		supercompanyService.deleteChatbotMapping(map);
		if (chatbotInfoList.size() != 0) {
			supercompanyService.insertChatbotMapping(map);
		}
	}
}
