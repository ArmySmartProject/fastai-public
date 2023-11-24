package ai.maum.biz.fastaicc.main.workRequestProcess.controller;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.util.Utils;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.cousult.common.service.ConsultingService;
import ai.maum.biz.fastaicc.main.user.domain.AuthenticaionVO;
import ai.maum.biz.fastaicc.main.user.domain.UserVO;
import ai.maum.biz.fastaicc.main.user.service.AuthService;
import ai.maum.biz.fastaicc.main.workRequestProcess.service.WorkRequestProcessService;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Controller
public class WorkRequestProcessController {
  /* 공통서비스 */
  @Autowired
  CommonService commonService;

  /* 권한 서비스 */
  @Autowired
  AuthService authService;

  @Autowired
  CustomProperties customProperties;

  @Autowired
  WorkRequestProcessService workRequestProcessService;

  @RequestMapping(value = "/workSubmit", method = { RequestMethod.GET, RequestMethod.POST })
  public String workSubmit(HttpServletRequest req, Model model) {
    Map map = new HashMap();
    model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
    return "work_request_process/submit";
  }

  @RequestMapping(value = "/workApproval", method = { RequestMethod.GET, RequestMethod.POST })
  public String workApproval(HttpServletRequest req, Model model) {
    Map map = new HashMap();
    model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
    return "work_request_process/approval";
  }

  @RequestMapping(value = "/workList", method = { RequestMethod.GET, RequestMethod.POST })
  public String workList(HttpServletRequest req, Model model) {
    Map map = new HashMap();
    model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
    return "work_request_process/work_list";
  }

  @RequestMapping(value = "/workListForWorker", method = { RequestMethod.GET, RequestMethod.POST })
  public String workListForWorker(HttpServletRequest req, Model model) {
    Map map = new HashMap();
    model.addAttribute("username", Utils.getLogInAccount(authService).getUserNm()); // 로그인한 사용자 이름
    return "work_request_process/work_list_for_worker";
  }

  /***
   * 작업의뢰 등록
   *
   * @param jsonStr
   * @return
   * @throws IOException
   * @throws JsonMappingException
   * @throws JsonParseException
   */
  @RequestMapping(value = "/insertWorkRequest", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public String insertWorkRequest(@RequestBody String jsonStr)
          throws JsonParseException, JsonMappingException, IOException {
    log.debug("jsonStr====" + jsonStr);
    System.out.println("jsonString" + jsonStr);

    Map<String, Object> map = null;
    // json파서
    JsonParser jp = new JsonParser();
    JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
    JsonArray jArray = new JsonArray();
    // json -> map
    map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
    // 로그인 사용자 ID 가져오기
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String userId = auth.getName();

    map.put("planerId", userId);

    String workRequestNo = workRequestProcessService.insertWorkRequest(map);

    return workRequestNo;
  }

  /***
   * 작업의뢰 유형 및 결재자 리스트
   *
   * @param jsonStr
   * @return
   * @throws IOException
   * @throws JsonMappingException
   * @throws JsonParseException
   */
  @RequestMapping(value = "/getWorkCategoryAndSigner", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public Map<String,Object> getWorkCategoryAndSigner(@RequestBody String jsonStr) throws JsonParseException, JsonMappingException, IOException {
    log.debug("jsonStr====" + jsonStr);
    System.out.println("jsonString" + jsonStr);

    Map<String, Object> map = null;
    // json파서
    JsonParser jp = new JsonParser();
    JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
    JsonArray jArray = new JsonArray();
    // json -> map
    map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
    // 로그인 사용자 ID 가져오기
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String companyId = "";
    if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
      AuthenticaionVO userDto=(AuthenticaionVO)auth;
      UserVO userVo = userDto.getUser();
      companyId = userVo.getCompanyId();
    }
    map.put("companyId", companyId);
    List<Map<String,Object>> getCampaignList = workRequestProcessService.getCampaignListForWorkProcess(map);
    List<Map<String,Object>> getSignerList = workRequestProcessService.getSignerListForWorkProcess(map);

    Map<String, Object> getWorkCategoryAndSignerMap = new HashMap<>();
    getWorkCategoryAndSignerMap.put("getCampaignList", getCampaignList);
    getWorkCategoryAndSignerMap.put("getSignerList", getSignerList);

    return getWorkCategoryAndSignerMap;
  }

  /***
   * 작업의뢰 기안 현황 리스트
   *
   * @param jsonStr
   * @return
   * @throws IOException
   * @throws JsonMappingException
   * @throws JsonParseException
   */
  @RequestMapping(value = "/getWorkRequestProcessList", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public String getWorkRequestProcessList(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
    log.debug("jsonStr====" + jsonStr);
    System.out.println("jsonString" + jsonStr);

    Map<String, Object> map = null;
    // json파서
    JsonParser jp = new JsonParser();
    JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
    JsonArray jArray = new JsonArray();
    // json -> map
    map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
    // 로그인 사용자 ID 가져오기
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String companyId = "";
    String userId = "";
    if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
      AuthenticaionVO userDto=(AuthenticaionVO)auth;
      UserVO userVo = userDto.getUser();
      companyId = userVo.getCompanyId();
      userId = userVo.getUserId();
    }
    map.put("companyId", companyId);
    map.put("planerId", userId);

    List<Map<String,Object>> getWorkRequestProcessList = workRequestProcessService.getWorkRequestProcessList(map);

    int totalCount = Integer.parseInt(workRequestProcessService.getWorkRequestProcessListCount(map).get("totalCnt").toString());

    String rowNum = "";
    if(map.get("rowNum") == null) {
      rowNum = String.valueOf(totalCount);
    } else {
      rowNum = map.get("rowNum").toString();
    }

    // 리턴 값
    JsonObject jsonReTurnObj =  new JsonObject();
    jsonReTurnObj.add("rows",new Gson().toJsonTree(getWorkRequestProcessList));
    jsonReTurnObj.add("page",new Gson().toJsonTree(map.get("page")));
    jsonReTurnObj.add("total",new Gson().toJsonTree(Math.round(Math.ceil(totalCount/Double.parseDouble(rowNum)))));
    jsonReTurnObj.add("record",new Gson().toJsonTree(totalCount));
    jqGirdWriter(response, jsonReTurnObj);

    return null;
  }

  public static void jqGirdWriter(HttpServletResponse response, JsonObject jsonReTurnObj) throws IOException {
    response.setContentType("text/html");
    response.setCharacterEncoding("UTF-8");
    PrintWriter out = response.getWriter();
    out.println(jsonReTurnObj);
    out.close();
  }

  @RequestMapping(value = "/workRequestFormDown")
  public void workRequestFormDown(HttpServletRequest request, HttpServletResponse response) throws Exception {

    Map<String,Object> map = new HashMap<>();
    List<Map<String, Object>> getWorkRequestUploadFormListMap = workRequestProcessService.getWorkRequestUploadForm(map);

    //defaultfilepath + realfilepath 부분을 실제 경로로만 변경해주면 됨
    File downloadfile = new File(customProperties.getWorkRequestFormPath() + getWorkRequestUploadFormListMap.get(0).get("fileNm").toString());
    if (downloadfile.exists() && downloadfile.isFile()) {
      response.setContentType("application/octet-stream; charset=utf-8");
      response.setContentLength((int) downloadfile.length());
      OutputStream outputstream = null;
      FileInputStream inputstream = null;
      try {
        response.setHeader("Content-Disposition", getDisposition(getWorkRequestUploadFormListMap.get(0).get("fileNm").toString(), check_browser(request)));
        response.setHeader("Content-Transfer-Encoding", "binary");
        outputstream = response.getOutputStream();
        inputstream = new FileInputStream(downloadfile);
        //Spring framework 사용할 경우
        //FileCopyUtils.copy(fis, out);

        //일반 자바/JSP 파일다운로드
        byte[] buffer = new byte[1024];
        int length = 0;
        while((length = inputstream.read(buffer)) > 0) {
          outputstream.write(buffer,0,length);
        }
      } catch (Exception e) {
        e.printStackTrace();
      } finally {
        try {
          if (inputstream != null){
            inputstream.close();
          }
          outputstream.flush();
          outputstream.close();
        } catch (Exception e2) {}
      }
    }else {
      System.out.println("파일존재하지 않음");
    }
  }

  @RequestMapping(value = "/workRequestFileDown")
  public void workRequestFileDown(HttpServletRequest request, HttpServletResponse response) throws Exception {

    String workRequestNo = request.getParameter("workRequestNo").toString();
    String fileNm = request.getParameter("fileNm").toString();
    System.out.println(workRequestNo + " :: " + fileNm);


    //defaultfilepath + realfilepath 부분을 실제 경로로만 변경해주면 됨
    File downloadfile = new File(customProperties.getWorkRequestUploadPath() + workRequestNo +"/"+fileNm);
    if (downloadfile.exists() && downloadfile.isFile()) {
      response.setContentType("application/octet-stream; charset=utf-8");
      response.setContentLength((int) downloadfile.length());
      OutputStream outputstream = null;
      FileInputStream inputstream = null;
      try {
        response.setHeader("Content-Disposition", getDisposition(fileNm, check_browser(request)));
        response.setHeader("Content-Transfer-Encoding", "binary");
        outputstream = response.getOutputStream();
        inputstream = new FileInputStream(downloadfile);
        //Spring framework 사용할 경우
        //FileCopyUtils.copy(fis, out);

        //일반 자바/JSP 파일다운로드
        byte[] buffer = new byte[1024];
        int length = 0;
        while((length = inputstream.read(buffer)) > 0) {
          outputstream.write(buffer,0,length);
        }
      } catch (Exception e) {
        e.printStackTrace();
      } finally {
        try {
          if (inputstream != null){
            inputstream.close();
          }
          outputstream.flush();
          outputstream.close();
        } catch (Exception e2) {}
      }
    }else {
      System.out.println("파일존재하지 않음");
    }
  }

  private String check_browser(HttpServletRequest request) {
    String browser = "";
    String header = request.getHeader("User-Agent");
    //신규추가된 indexof : Trident(IE11) 일반 MSIE로는 체크 안됨
    if (header.indexOf("MSIE") > -1 || header.indexOf("Trident") > -1){
      browser = "ie";
    }
    //크롬일 경우
    else if (header.indexOf("Chrome") > -1){
      browser = "chrome";
    }
    //오페라일경우
    else if (header.indexOf("Opera") > -1){
      browser = "opera";
    }
    //사파리일 경우
    else if (header.indexOf("Apple") > -1){
      browser = "sarari";
    } else {
      browser = "firfox";
    }
    return browser;
  }

  private String getDisposition(String down_filename, String browser_check) throws UnsupportedEncodingException {
    String prefix = "attachment;filename=";
    String encodedfilename = null;
    System.out.println("browser_check:"+browser_check);
    if (browser_check.equals("ie")) {
      encodedfilename = URLEncoder.encode(down_filename, "UTF-8").replaceAll("\\+", "%20");
    }else if (browser_check.equals("chrome")) {
      StringBuffer sb = new StringBuffer();
      for (int i = 0; i < down_filename.length(); i++){
        char c = down_filename.charAt(i);
        if (c > '~') {
          sb.append(URLEncoder.encode("" + c, "UTF-8"));
        } else {
          sb.append(c);
        }
      }
      encodedfilename = sb.toString();
    }else {
      encodedfilename = "\"" + new String(down_filename.getBytes("UTF-8"), "8859_1") + "\"";
    }
    return prefix + encodedfilename;
  }

  /***
   * 작업의뢰 상세 팝업
   *
   * @param jsonStr
   * @return
   * @throws IOException
   * @throws JsonMappingException
   * @throws JsonParseException
   */
  @RequestMapping(value = "/getWorkRequestProcessDetail", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public Map<String,Object> getWorkRequestProcessDetail(@RequestBody String jsonStr) throws JsonParseException, JsonMappingException, IOException {
    log.debug("jsonStr====" + jsonStr);
    System.out.println("jsonString" + jsonStr);

    Map<String, Object> map = null;
    // json파서
    JsonParser jp = new JsonParser();
    JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
    JsonArray jArray = new JsonArray();
    // json -> map
    map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
    // 로그인 사용자 ID 가져오기
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String companyId = "";
    if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
      AuthenticaionVO userDto=(AuthenticaionVO)auth;
      UserVO userVo = userDto.getUser();
      companyId = userVo.getCompanyId();
    }
    map.put("companyId", companyId);
    Map<String,Object> workRequestProcessDetailMap = workRequestProcessService.getWorkRequestProcessDetail(map);

    return workRequestProcessDetailMap;
  }

  @RequestMapping(value = "/uploadWorkRequestForm", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public ModelAndView uploadWorkRequestForm(MultipartHttpServletRequest request)
          throws Exception {

    System.out.println("엑셀 파일 업로드 컨트롤러");
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String custOpId = auth.getName();
    MultipartFile excelFile = request.getFile("select_file");
    if (excelFile == null || excelFile.isEmpty()) {
      throw new RuntimeException("엑셀파일을 선택 해 주세요.");
    }

    File destFile = new File(
            customProperties.getWorkRequestFormPath() + excelFile.getOriginalFilename());
    try {
      excelFile.transferTo(destFile);
    } catch (IllegalStateException | IOException e) {
      throw new RuntimeException(e.getMessage(), e);
    }

//		destFile.delete();
    SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");

    Date time = new Date();

    String updateTime = format.format(time);
    Map<String, Object> map = new HashMap<>();
    map.put("id", custOpId);
    map.put("fileNm", excelFile.getOriginalFilename());
    workRequestProcessService.insertWorkRequestUploadForm(map);

    ModelAndView view = new ModelAndView("jsonView");
    view.addObject("status", "OK");
    return view;
  }

  @RequestMapping(value = "/uploadWorkRequestFile", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public ModelAndView uploadWorkRequestFile(MultipartHttpServletRequest request)
          throws Exception {

    System.out.println("엑셀 파일 업로드 컨트롤러");
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String custOpId = auth.getName();
    String workRequestNo = request.getParameter("workRequestNo").toString();
    MultipartFile excelFile = request.getFile("file_id1");

//    if (excelFile == null || excelFile.isEmpty()) {
//      throw new RuntimeException("파일을 선택 해 주세요.");
//    }
    if (excelFile != null && !excelFile.isEmpty() && excelFile.getOriginalFilename() != "") {

      File checkFile = new File(customProperties.getWorkRequestUploadPath() + workRequestNo + "/");

      if(!Files.exists(Paths.get(customProperties.getWorkRequestUploadPath() + workRequestNo + "/"))){
        Files.createDirectory(Paths.get(customProperties.getWorkRequestUploadPath() + workRequestNo + "/"));
      }else{
        FileUtils.cleanDirectory(checkFile);
      }

      File destFile = new File(
              customProperties.getWorkRequestUploadPath() + workRequestNo + "/" + excelFile.getOriginalFilename());
      try {
        excelFile.transferTo(destFile);
      } catch (IllegalStateException | IOException e) {
        throw new RuntimeException(e.getMessage(), e);
      }
    }

//		destFile.delete();
    Map<String, Object> map = new HashMap<>();
    map.put("workRequestNo", workRequestNo);
    map.put("workFileNm", excelFile.getOriginalFilename());
    workRequestProcessService.updateWorkRequestListByNo(map);

    ModelAndView view = new ModelAndView("jsonView");
    view.addObject("status", "OK");
    return view;
  }

  /***
   * 작업의뢰서 등록 리스트
   *
   * @param jsonStr
   * @return
   * @throws IOException
   * @throws JsonMappingException
   * @throws JsonParseException
   */
  @RequestMapping(value = "/getWorkRequestUploadFormList", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public List<Map<String,Object>> getWorkRequestUploadFormList(@RequestBody String jsonStr) throws JsonParseException, JsonMappingException, IOException {
    log.debug("jsonStr====" + jsonStr);
    System.out.println("jsonString" + jsonStr);

    Map<String, Object> map = null;
    // json파서
    JsonParser jp = new JsonParser();
    JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
    JsonArray jArray = new JsonArray();
    // json -> map
    map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
    // 로그인 사용자 ID 가져오기
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String companyId = "";
    if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
      AuthenticaionVO userDto=(AuthenticaionVO)auth;
      UserVO userVo = userDto.getUser();
      companyId = userVo.getCompanyId();
    }
    map.put("companyId", companyId);

    List<Map<String, Object>> getWorkRequestUploadFormListMap = workRequestProcessService.getWorkRequestUploadForm(map);;

    return getWorkRequestUploadFormListMap;
  }

  /***
   * 작업의뢰서 리스트 삭제
   *
   * @param jsonStr
   * @return
   * @throws IOException
   * @throws JsonMappingException
   * @throws JsonParseException
   */
  @RequestMapping(value = "/updateWorkRequest", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public int updateWorkRequest(@RequestBody String jsonStr) throws JsonParseException, JsonMappingException, IOException {
    log.debug("jsonStr====" + jsonStr);
    System.out.println("jsonString" + jsonStr);

    Map<String, Object> map = null;
    // json파서
    JsonParser jp = new JsonParser();
    JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
    JsonArray jArray = new JsonArray();
    // json -> map
    map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);

    int updateWorkRequest = workRequestProcessService.updateWorkRequest(map);

   // File checkFile = new File(customProperties.getWorkRequestUploadPath() + map.get("workRequestNo").toString() + "/");

//    while(checkFile.exists()){
//      File[] folder_list = checkFile.listFiles();
//
//      for (int j = 0; j < folder_list.length; j++) {
//        folder_list[j].delete(); //파일 삭제
//        System.out.println("파일이 삭제되었습니다.");
//      }
//
//      if(folder_list.length == 0 && checkFile.isDirectory()){
//        checkFile.delete(); //대상폴더 삭제
//        System.out.println("폴더가 삭제되었습니다.");
//      }
//    }

    return updateWorkRequest;
  }

  /***
   * 작업의뢰 결재 현황 리스트
   *
   * @param jsonStr
   * @return
   * @throws IOException
   * @throws JsonMappingException
   * @throws JsonParseException
   */
  @RequestMapping(value = "/getWorkRequestApprovalProcessList", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public String getWorkRequestApprovalProcessList(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
    log.debug("jsonStr====" + jsonStr);
    System.out.println("jsonString" + jsonStr);

    Map<String, Object> map = null;
    // json파서
    JsonParser jp = new JsonParser();
    JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
    JsonArray jArray = new JsonArray();
    // json -> map
    map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
    // 로그인 사용자 ID 가져오기
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String companyId = "";
    if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
      AuthenticaionVO userDto=(AuthenticaionVO)auth;
      UserVO userVo = userDto.getUser();
      companyId = userVo.getCompanyId();
    }
    map.put("companyId", companyId);
    List statCodeList = new ArrayList();
    if(map.get("workSignStat").toString().equals("signing")){
        statCodeList.add("WR02");
        map.put("workSignStat", statCodeList);
    }else if(map.get("workSignStat").toString().equals("signComplete")){
        statCodeList.add("WR03");
        statCodeList.add("WR05");
        statCodeList.add("WR06");
        statCodeList.add("WR07");
        statCodeList.add("WR08");
        statCodeList.add("WR09");
        statCodeList.add("WR10");
        map.put("workSignStat", statCodeList);
    } else {
      map.put("workSignStat", statCodeList);
    }

    List<Map<String,Object>> getWorkRequestApprovalProcessList = workRequestProcessService.getWorkRequestApprovalProcessList(map);

    int totalCount = Integer.parseInt(workRequestProcessService.getWorkRequestApprovalProcessListCount(map).get("totalCnt").toString());

    String rowNum = "";
    if(map.get("rowNum") == null) {
      rowNum = String.valueOf(totalCount);
    } else {
      rowNum = map.get("rowNum").toString();
    }

    // 리턴 값
    JsonObject jsonReTurnObj =  new JsonObject();
    jsonReTurnObj.add("rows",new Gson().toJsonTree(getWorkRequestApprovalProcessList));
    jsonReTurnObj.add("page",new Gson().toJsonTree(map.get("page")));
    jsonReTurnObj.add("total",new Gson().toJsonTree(Math.round(Math.ceil(totalCount/Double.parseDouble(rowNum)))));
    jsonReTurnObj.add("record",new Gson().toJsonTree(totalCount));
    jqGirdWriter(response, jsonReTurnObj);

    return null;
  }

  /***
   * 작업의뢰 결재 현황 결재 승인 업데이트
   *
   * @param jsonStr
   * @return
   * @throws IOException
   * @throws JsonMappingException
   * @throws JsonParseException
   */
  @RequestMapping(value = "/updateApprovalSign", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public int updateApprovalSign(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
    log.debug("jsonStr====" + jsonStr);
    System.out.println("jsonString" + jsonStr);

    Map<String, Object> map = null;
    // json파서
    JsonParser jp = new JsonParser();
    JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
    JsonArray jArray = new JsonArray();
    // json -> map
    map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
    // 로그인 사용자 ID 가져오기
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String companyId = "";
    if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
      AuthenticaionVO userDto=(AuthenticaionVO)auth;
      UserVO userVo = userDto.getUser();
      companyId = userVo.getCompanyId();
    }
    map.put("companyId", companyId);

    int updateApprovalSign = workRequestProcessService.updateApprovalSign(map);

    return updateApprovalSign;
  }

  /***
   * 작업의뢰 작업자 작업의뢰 리스트
   *
   * @param jsonStr
   * @return
   * @throws IOException
   * @throws JsonMappingException
   * @throws JsonParseException
   */
  @RequestMapping(value = "/getWorkRequestListForWorkerList", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public String getWorkRequestListForWorkerList(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
    log.debug("jsonStr====" + jsonStr);
    System.out.println("jsonString" + jsonStr);

    Map<String, Object> map = null;
    // json파서
    JsonParser jp = new JsonParser();
    JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
    JsonArray jArray = new JsonArray();
    // json -> map
    map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
    // 로그인 사용자 ID 가져오기
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String companyId = "";
    if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
      AuthenticaionVO userDto=(AuthenticaionVO)auth;
      UserVO userVo = userDto.getUser();
      companyId = userVo.getCompanyId();
    }
    map.put("companyId", companyId);
    List statCodeList = new ArrayList();
    if(map.get("workSignStat").toString().equals("working")){
      statCodeList.add("WR05");
      statCodeList.add("WR08");
      map.put("workSignStat", statCodeList);
    }else if(map.get("workSignStat").toString().equals("testing")){
      statCodeList.add("WR06");
      statCodeList.add("WR07");
      map.put("workSignStat", statCodeList);
    } else if(map.get("workSignStat").toString().equals("systemPlan")){
      statCodeList.add("WR09");
      map.put("workSignStat", statCodeList);
    }else if (map.get("workSignStat").toString().equals("systemComplete")){
      statCodeList.add("WR10");
      map.put("workSignStat", statCodeList);
    }else {
      map.put("workSignStat", statCodeList);
    }

    List<Map<String,Object>> getWorkRequestListForWorkerList = workRequestProcessService.getWorkRequestListForWorkerList(map);

    int totalCount = Integer.parseInt(workRequestProcessService.getWorkRequestListForWorkerListCount(map).get("totalCnt").toString());

    String rowNum = "";
    if(map.get("rowNum") == null) {
      rowNum = String.valueOf(totalCount);
    } else {
      rowNum = map.get("rowNum").toString();
    }

    // 리턴 값
    JsonObject jsonReTurnObj =  new JsonObject();
    jsonReTurnObj.add("rows",new Gson().toJsonTree(getWorkRequestListForWorkerList));
    jsonReTurnObj.add("page",new Gson().toJsonTree(map.get("page")));
    jsonReTurnObj.add("total",new Gson().toJsonTree(Math.round(Math.ceil(totalCount/Double.parseDouble(rowNum)))));
    jsonReTurnObj.add("record",new Gson().toJsonTree(totalCount));
    jqGirdWriter(response, jsonReTurnObj);

    return null;
  }

  /***
   * 작업의뢰 테스트 요청
   *
   * @param jsonStr
   * @return
   * @throws IOException
   * @throws JsonMappingException
   * @throws JsonParseException
   */
  @RequestMapping(value = "/updateRequestTest", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public int updateRequestTest(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
    log.debug("jsonStr====" + jsonStr);
    System.out.println("jsonString" + jsonStr);

    Map<String, Object> map = null;
    // json파서
    JsonParser jp = new JsonParser();
    JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
    JsonArray jArray = new JsonArray();
    // json -> map
    map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
    // 로그인 사용자 ID 가져오기
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String companyId = "";
    if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
      AuthenticaionVO userDto=(AuthenticaionVO)auth;
      UserVO userVo = userDto.getUser();
      companyId = userVo.getCompanyId();
    }
    map.put("companyId", companyId);

    int updateRequestTest = workRequestProcessService.updateRequestTest(map);

    return updateRequestTest;
  }

  /***
   * 작업의뢰 테스트 현황 리스트
   *
   * @param jsonStr
   * @return
   * @throws IOException
   * @throws JsonMappingException
   * @throws JsonParseException
   */
  @RequestMapping(value = "/getWorkRequestTestList", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public String getWorkRequestTestList(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
    log.debug("jsonStr====" + jsonStr);
    System.out.println("jsonString" + jsonStr);

    Map<String, Object> map = null;
    // json파서
    JsonParser jp = new JsonParser();
    JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
    JsonArray jArray = new JsonArray();
    // json -> map
    map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
    // 로그인 사용자 ID 가져오기
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String companyId = "";
    if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
      AuthenticaionVO userDto=(AuthenticaionVO)auth;
      UserVO userVo = userDto.getUser();
      companyId = userVo.getCompanyId();
    }
    map.put("companyId", companyId);
    List statCodeList = new ArrayList();
    if(map.get("workSignStat").toString().equals("working")){
      statCodeList.add("WR05");
      map.put("workSignStat", statCodeList);
    }else if(map.get("workSignStat").toString().equals("workComplete")){
      statCodeList.add("WR06");
      statCodeList.add("WR07");
      statCodeList.add("WR08");
      map.put("workSignStat", statCodeList);
    } else {
      map.put("workSignStat", statCodeList);
    }

    List<Map<String,Object>> getWorkRequestTestList = workRequestProcessService.getWorkRequestTestList(map);

    int totalCount = Integer.parseInt(workRequestProcessService.getWorkRequestTestListCount(map).get("totalCnt").toString());

    String rowNum = "";
    if(map.get("rowNum") == null) {
      rowNum = String.valueOf(totalCount);
    } else {
      rowNum = map.get("rowNum").toString();
    }

    // 리턴 값
    JsonObject jsonReTurnObj =  new JsonObject();
    jsonReTurnObj.add("rows",new Gson().toJsonTree(getWorkRequestTestList));
    jsonReTurnObj.add("page",new Gson().toJsonTree(map.get("page")));
    jsonReTurnObj.add("total",new Gson().toJsonTree(Math.round(Math.ceil(totalCount/Double.parseDouble(rowNum)))));
    jsonReTurnObj.add("record",new Gson().toJsonTree(totalCount));
    jqGirdWriter(response, jsonReTurnObj);

    return null;
  }

  /***
   * 작업의뢰 테스트 등록
   *
   * @param jsonStr
   * @return
   * @throws IOException
   * @throws JsonMappingException
   * @throws JsonParseException
   */
  @RequestMapping(value = "/insertWorkTest", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public int insertWorkTest(@RequestBody String jsonStr)
          throws JsonParseException, JsonMappingException, IOException {
    log.debug("jsonStr====" + jsonStr);
    System.out.println("jsonString" + jsonStr);

    Map<String, Object> map = null;
    // json파서
    JsonParser jp = new JsonParser();
    JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
    JsonArray jArray = new JsonArray();
    // json -> map
    map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
    // 로그인 사용자 ID 가져오기
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String userId = auth.getName();

    map.put("planerId", userId);
    int insertWorkTest = 0;
    Map<String, Object> checkTempSave = workRequestProcessService.checkTempSave(map);

    if(checkTempSave == null){
      insertWorkTest = workRequestProcessService.insertWorkTest(map);
    }else {
      workRequestProcessService.updateWorkTest(map);
    }

    int updateWorkRequstToTest = workRequestProcessService.updateWorkRequstToTest(map);

    return insertWorkTest;
  }

  /***
   * 작업의뢰 테스트 정보
   *
   * @param jsonStr
   * @return
   * @throws IOException
   * @throws JsonMappingException
   * @throws JsonParseException
   */
  @RequestMapping(value = "/getWorkTempTestInfo", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public List<Map<String,Object>> getWorkTempTestInfo(@RequestBody String jsonStr) throws JsonParseException, JsonMappingException, IOException {
    log.debug("jsonStr====" + jsonStr);
    System.out.println("jsonString" + jsonStr);

    Map<String, Object> map = null;
    // json파서
    JsonParser jp = new JsonParser();
    JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
    JsonArray jArray = new JsonArray();
    // json -> map
    map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
    // 로그인 사용자 ID 가져오기
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String companyId = "";
    if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
      AuthenticaionVO userDto=(AuthenticaionVO)auth;
      UserVO userVo = userDto.getUser();
      companyId = userVo.getCompanyId();
    }
    map.put("companyId", companyId);
    List<Map<String,Object>> workTempTestInfoListMap = workRequestProcessService.getWorkTempTestInfo(map);

    return workTempTestInfoListMap;
  }

  /***
   * 작업의뢰 이행 완료 업데이트
   *
   * @param jsonStr
   * @return
   * @throws IOException
   * @throws JsonMappingException
   * @throws JsonParseException
   */
  @RequestMapping(value = "/updateImplementComplete", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public int updateImplementComplete(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
    log.debug("jsonStr====" + jsonStr);
    System.out.println("jsonString" + jsonStr);

    Map<String, Object> map = null;
    // json파서
    JsonParser jp = new JsonParser();
    JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
    JsonArray jArray = new JsonArray();
    // json -> map
    map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
    // 로그인 사용자 ID 가져오기
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String companyId = "";
    if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
      AuthenticaionVO userDto=(AuthenticaionVO)auth;
      UserVO userVo = userDto.getUser();
      companyId = userVo.getCompanyId();
    }
    map.put("companyId", companyId);

    int updateImplementComplete = workRequestProcessService.updateImplementComplete(map);

    return updateImplementComplete;
  }

  /***
   * 작업의뢰 테스트 보기 팝업 내용
   *
   * @param jsonStr
   * @return
   * @throws IOException
   * @throws JsonMappingException
   * @throws JsonParseException
   */
  @RequestMapping(value = "/getTestInfoDetail", method = { RequestMethod.GET, RequestMethod.POST })
  @ResponseBody
  public Map<String, Object> getTestInfoDetail(@RequestBody String jsonStr, HttpServletRequest request, HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException {
    log.debug("jsonStr====" + jsonStr);
    System.out.println("jsonString" + jsonStr);

    Map<String, Object> map = null;
    // json파서
    JsonParser jp = new JsonParser();
    JsonObject jsonObj = (JsonObject) jp.parse(jsonStr);
    JsonArray jArray = new JsonArray();
    // json -> map
    map = new ObjectMapper().readValue(jsonObj.toString(), Map.class);
    // 로그인 사용자 ID 가져오기
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String companyId = "";
    if(auth!=null && !auth.getPrincipal().equals("anonymousUser")) {
      AuthenticaionVO userDto=(AuthenticaionVO)auth;
      UserVO userVo = userDto.getUser();
      companyId = userVo.getCompanyId();
    }
    map.put("companyId", companyId);

    Map<String,Object> workRequestProcessDetailMap = workRequestProcessService.getWorkRequestProcessDetail(map);

    List<Map<String, Object>> workTempTestInfoListMap = workRequestProcessService.getWorkTempTestInfo(map);

    Map<String, Object> testInfoMap = new HashMap<>();
    testInfoMap.put("workRequestProcessDetailMap", workRequestProcessDetailMap);
    testInfoMap.put("workTempTestInfoListMap", workTempTestInfoListMap);

    return testInfoMap;
  }
}
