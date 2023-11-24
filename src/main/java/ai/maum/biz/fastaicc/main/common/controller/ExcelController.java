package ai.maum.biz.fastaicc.main.common.controller;

import ai.maum.biz.fastaicc.main.cousult.outbound.service.OutboundMonitoringService;
import ai.maum.biz.fastaicc.main.cousult.outbound.service.OutboundMonitoringServiceImpl.UploadStatus;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.tomcat.util.json.JSONParser;
import org.apache.tomcat.util.json.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.cousult.common.service.ConsultingService;
import ai.maum.biz.fastaicc.main.cousult.inbound.service.InboundMonitoringService;
import ai.maum.biz.fastaicc.main.statistic.service.StatisticsService;
import ai.maum.biz.fastaicc.main.user.service.AuthService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Slf4j
@Controller
public class ExcelController {

	/* 공통서비스 */
	@Autowired
	CommonService commonService;

	/* 권한 서비스 */
	@Autowired
	AuthService authService;
	
	/* 인바운드 모니터 서비스 */
	@Autowired
	InboundMonitoringService inboundMonitoringService;

	/* 상담서비스 */
	@Autowired
	ConsultingService consultingService;

	@Autowired
	CustomProperties customProperties;
	/* 설정값 */
	@Inject
	VariablesMng variablesMng;

	/* 아웃바운드 모니터링 서비스 */
	@Autowired
	OutboundMonitoringService outboundMonitoringService;

    /*통계서비스     */
    @Autowired
    StatisticsService statisticsService;
    
    @RequestMapping(value = "/excelDownload", method = { RequestMethod.GET, RequestMethod.POST })
    public void excelRouting(@RequestParam String jsonForExcel, @RequestParam String excelType, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	//분기해야할경우 작성
    	if("stats_record".equals(excelType)) {
    		getRecordList(jsonForExcel, request, response);
    	}else if("stats_adviser".equals(excelType)) {
    		getAdviserList(jsonForExcel, request, response);
    	}else if("stats_total".equals(excelType)) {
    		getTotalList(jsonForExcel, request, response);
    	}else if("stats_type".equals(excelType)) {
    		getTypeList(jsonForExcel, request, response);
    	}
    }
    
    private void getTypeList(String jsonForExcel, HttpServletRequest request, HttpServletResponse response) throws Exception  {
		// TODO Auto-generated method stub
    	log.info("jsonStr====" + jsonForExcel);
    	//stats_record list 조회
    	Map<String, Object> map = null;
    	JSONParser parser = new JSONParser(jsonForExcel);
    	Object obj = parser.parse();
		// json -> map
		map = new ObjectMapper().readValue(obj.toString(), Map.class);
		//인바운드 콜 통계 리스트
		List<Map> list = statisticsService.getIbStatsTypeSList(map);
		makeExcelFile(list, request, response);
	}

	private void getTotalList(String jsonForExcel, HttpServletRequest request, HttpServletResponse response) throws Exception  {
		// TODO Auto-generated method stub
		log.info("jsonStr====" + jsonForExcel);
    	//stats_record list 조회
    	Map<String, Object> map = null;
    	JSONParser parser = new JSONParser(jsonForExcel);
    	Object obj = parser.parse();
		// json -> map
		map = new ObjectMapper().readValue(obj.toString(), Map.class);
		//인바운드 콜 통계 리스트
		List<Map> list = statisticsService.getIbStatsTotalSList(map);
		makeExcelFile(list, request, response);
	}

	private void getAdviserList(String jsonForExcel, HttpServletRequest request, HttpServletResponse response) throws Exception  {
		// TODO Auto-generated method stub
		log.info("jsonStr====" + jsonForExcel);
    	//stats_record list 조회
    	Map<String, Object> map = null;
    	JSONParser parser = new JSONParser(jsonForExcel);
    	Object obj = parser.parse();
		// json -> map
		map = new ObjectMapper().readValue(obj.toString(), Map.class);
		//인바운드 콜 통계 리스트
		List<Map> list = statisticsService.getIbStatsAdviserSList(map);
		makeExcelFile(list, request, response);
	}

	private void getRecordList(String jsonForExcel, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
    	log.info("jsonStr====" + jsonForExcel);
    	//stats_record list 조회
    	Map<String, Object> map = null;
    	JSONParser parser = new JSONParser(jsonForExcel);
    	Object obj = parser.parse();
		// json -> map
		map = new ObjectMapper().readValue(obj.toString(), Map.class);
		//인바운드 콜 통계 리스트
		List<Map> list = statisticsService.getStatsRecordSList(map);
		makeExcelFile(list, request, response);
		
	}

	public void makeExcelFile(List<Map> list, HttpServletRequest request, HttpServletResponse response) throws IOException {
    	
    	String headerNameStr = request.getParameter("headerNm");
    	String colNameStr = request.getParameter("colNm");
    	String groupingCol = request.getParameter("groupingCol");
    	
    	String[] headerArr = null;
    	String[] colArr = null;
    	
    	if(headerNameStr != null && !"".equals(headerNameStr)) {
    		headerArr = headerNameStr.split(";@;");
    	}
    	
    	if(colNameStr != null && !"".equals(colNameStr)) {
    		colArr = colNameStr.split(";@;");
    	}
    	
    	Workbook wb = new HSSFWorkbook();
	    Sheet sheet = wb.createSheet("게시판");//통계이름
	    Row row = null;
	    Cell cell = null;
	    int rowNo = 0;
    	
	    // 테이블 헤더용 스타일

	    CellStyle headStyle = wb.createCellStyle();

	    // 가는 경계선을 가집니다.
	    headStyle.setBorderTop(BorderStyle.THIN);
	    headStyle.setBorderBottom(BorderStyle.THIN);
	    headStyle.setBorderLeft(BorderStyle.THIN);
	    headStyle.setBorderRight(BorderStyle.THIN);

	    // 데이터는 가운데 정렬합니다.
	    headStyle.setAlignment(HorizontalAlignment.CENTER);

	    // 데이터용 경계 스타일 테두리만 지정
	    CellStyle bodyStyle = wb.createCellStyle();
	    bodyStyle.setBorderTop(BorderStyle.THIN);
	    bodyStyle.setBorderBottom(BorderStyle.THIN);
	    bodyStyle.setBorderLeft(BorderStyle.THIN);
	    bodyStyle.setBorderRight(BorderStyle.THIN);
	    
	    //create header row
	    row = sheet.createRow(rowNo++);
	    //enter header name
	    for(int i=0; i<headerArr.length; i++) {
	    	cell = row.createCell(i);
	    	cell.setCellStyle(headStyle);
		    cell.setCellValue(headerArr[i]);
		    
	    }
    	
	    String tempGroupColValue = "";
	    
     	//통계 row list size
		for(int j=0; j<list.size(); j++) {
			row = sheet.createRow(rowNo++);//row 추가
			//통계 row col > 화면 col name
			for(int k=0; k<colArr.length; k++) {
				if(k == 0 ) {
					if("No.".equals(headerArr[0])) {//이력조회 화면만 No 존재
						cell = row.createCell(k);
						cell.setCellStyle(bodyStyle);
					    cell.setCellValue(j+1);
					}
				}else if(!"".equals(list.get(j).get(colArr[k])) && list.get(j).get(colArr[k]) != null) {//list j번째 row에서
					//k 번째headerColList key를가진 컬럼이 있으면.
					//그룹핑일경우
					if(!"".equals(groupingCol) && groupingCol != null) {
						//temp가 공백이거나 temp와 현재 row 의 그룹컬럼값이 다름 > 그룹row 생성
						if("".equals(tempGroupColValue) || !tempGroupColValue.equals(list.get(j).get(groupingCol).toString())) {
							cell = row.createCell(0);
							cell.setCellStyle(bodyStyle);
						    cell.setCellValue(list.get(j).get(groupingCol).toString());
						    row = sheet.createRow(rowNo++);//row 추가
						    tempGroupColValue = list.get(j).get(groupingCol).toString();
						}
						
						cell = row.createCell(k);
						cell.setCellStyle(bodyStyle);
					    cell.setCellValue(list.get(j).get(colArr[k]).toString());
						
					}else {
						cell = row.createCell(k);
						cell.setCellStyle(bodyStyle);
					    cell.setCellValue(list.get(j).get(colArr[k]).toString());
					}
				}
			}
		}
	    
		 response.setHeader("Content-Disposition", "attachment;filename=test.xls"); //
		 //엑셀 출력
		  
		 wb.write(response.getOutputStream()); 
		 wb.close();
    	
    }

	@RequestMapping(value = "/uploadUserList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public ModelAndView uploadUserList(MultipartHttpServletRequest request) throws Exception {

		System.out.println("엑셀 파일 업로드 컨트롤러");
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String custOpId = auth.getName();
		String[] campaignId = request.getParameterValues("campaign");
		MultipartFile excelFile = request.getFile("select_file");
		if (excelFile == null || excelFile.isEmpty()) {
			throw new RuntimeException("엑셀파일을 선택 해 주세요.");
		}

		File destFile = new File(
				customProperties.getExcelUploadPath() + excelFile.getOriginalFilename());
		try {
			excelFile.transferTo(destFile);
		} catch (IllegalStateException | IOException e) {
			throw new RuntimeException(e.getMessage(), e);
		}

		outboundMonitoringService.uploadUserList(destFile, campaignId[0], custOpId);

		destFile.delete();
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");

		Date time = new Date();

		String updateTime = format.format(time);

		ModelAndView view = new ModelAndView("jsonView");
		view.addObject("status", "OK");
		view.addObject("updateTime", updateTime);
		return view;
	}
	
	@RequestMapping(value = "/checkUploadUserList", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public ModelAndView checkUploadUserList(MultipartHttpServletRequest request)
			throws Exception {
		
		System.out.println("엑셀 파일 업로드 컨트롤러");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String custOpId = auth.getName();
		String[] campaignId = request.getParameterValues("campaign");
		MultipartFile excelFile = request.getFile("select_file");
		if (excelFile == null || excelFile.isEmpty()) {
			throw new RuntimeException("엑셀파일을 선택 해 주세요.");
		}
		
		File destFile = new File(
				customProperties.getExcelUploadPath() + excelFile.getOriginalFilename());
		try {
			excelFile.transferTo(destFile);
		} catch (IllegalStateException | IOException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
		
		Map<String, Object> checkExcelMap = outboundMonitoringService.checkUploadUserList(destFile, campaignId[0], custOpId);
		
//		destFile.delete();
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
		
		Date time = new Date();
		
		String updateTime = format.format(time);
		
		ModelAndView view = new ModelAndView("jsonView");
		view.addObject("status", "OK");
		view.addObject("updateTime", updateTime);
		view.addObject("checkExcelMap", checkExcelMap);
		return view;
	}

	@RequestMapping(value = "/getUploadStatus", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public ModelAndView getUploadStatus(MultipartHttpServletRequest request)
			throws Exception {

		System.out.println("getUploadStatus");
		String[] campaignId = request.getParameterValues("campaign");

		UploadStatus uploadStatus = outboundMonitoringService.getUploadStatus(campaignId[0]);

		ModelAndView view = new ModelAndView("jsonView");
		view.addObject("uploadStatus", uploadStatus);

		return view;
	}

}
