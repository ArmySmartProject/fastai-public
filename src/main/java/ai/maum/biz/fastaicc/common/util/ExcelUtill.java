package ai.maum.biz.fastaicc.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;

@Component
public class ExcelUtill {
	//통계 리스트, 토탈카운트, (헤더네임, 컬럼명, 그룹핑yn, 그룹핑 옵션), res
	public void excelDownload(List<Map> list, int totalCount, Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String fileName = "test.xls";
		// 워크북 생성
		List<String> headerNmList = new ArrayList<String>();
		List<String> headerColList = new ArrayList<String>();
		
		headerNmList.addAll((Collection<String>) map.get("headerNm"));
		headerColList.addAll((Collection<String>) map.get("colNm"));
		
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
	    for(int i=0; i<headerNmList.size(); i++) {
	    	cell = row.createCell(i);
	    	cell.setCellStyle(headStyle);
		    cell.setCellValue(headerNmList.get(i));
		    
	    }
	    
	    //통계 row list size
	    for(int j=0; j<list.size(); j++) {
	    	row = sheet.createRow(rowNo++);//row 추가
	    	//통계 row col > 화면 col name
	    	for(int k=0; k<headerColList.size(); k++) {
	    		//list j번째 row에서
	    		if(!"".equals(list.get(j).get(headerColList.get(k))) && list.get(j).get(headerColList.get(k)) != null) {
	    			//k 번째headerColList key를가진 컬럼이 있으면.
	    			cell = row.createCell(k);
	    			cell.setCellStyle(bodyStyle);
	    			
	    		    cell.setCellValue(list.get(j).get(headerColList.get(k)).toString());
	    		}
	    	}
	    }
	    
	   
	  
	    
		
		  response.setContentType("application/vnd.ms-excel"); // 컨텐츠 타입과 파일명 지정
		  //response.setContentType("ms-vnd/excel");
		  response.setHeader("Content-Disposition", "attachment;filename=test.xls"); //
		  //ServletOutputStream out = response.getOutputStream();

		/* wb.write(response.getOutputStream()); */
		  //wb.write(out);
		  //wb.close();
		  wb.write(response.getOutputStream()); wb.close();
		  
		  // 컨텐츠 타입과 파일명 지정 response.setContentType("ms-vnd/excel");
		 	    
	    
	    
	 // 컨텐츠 타입과 파일명 지정 response.setContentType("application/vnd.ms-excel");
	    
		
		 // 입력된 내용 파일로 쓰기 
		/*
		 * File file = new File(storePathName); FileOutputStream fos = null;
		 * 
		 * 
		 * try { fos = new FileOutputStream(file); wb.write(fos);
		 * }catch(FileNotFoundException e) { e.printStackTrace(); } finally {
		 * fos.flush(); if(wb!=null)wb.close(); if(fos!=null)fos.close(); }
		 */
		  
		/*
		 * ServletOutputStream out = response.getOutputStream(); wb.write(out);
		 */

		    
		    
		    

	    
		/*
		 * response.setHeader("Content-Disposition", "attachment;filename=test.xls"); //
		 * //엑셀 출력
		 * 
		 * wb.write(response.getOutputStream()); wb.close();
		 */
	    
	}
	
}
