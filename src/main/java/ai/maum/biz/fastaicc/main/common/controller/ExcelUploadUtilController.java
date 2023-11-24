package ai.maum.biz.fastaicc.main.common.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellReference;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelUploadUtilController {
	/**
     * 엑셀파일의 경로
     */
    private String filePath;
    
    /**
     * 추출할 컬럼 명
     */
    private List<String> outputColumns;
    
    /**
     * 추출을 시작할 행 번호
     */
    private int startRow;
    
    public String getFilePath() {
        return filePath;
    }
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
    public List<String> getOutputColumns() {
        
        List<String> temp = new ArrayList<String>();
        temp.addAll(outputColumns);
        
        return temp;
    }
    public void setOutputColumns(List<String> outputColumns) {
        
        List<String> temp = new ArrayList<String>();
        temp.addAll(outputColumns);
        
        this.outputColumns = temp;
    }
    
    public void setOutputColumns(String ... outputColumns) {
        
        if(this.outputColumns == null) {
            this.outputColumns = new ArrayList<String>();
        }
        
        for(String ouputColumn : outputColumns) {
            this.outputColumns.add(ouputColumn);
        }
    }
    
    public int getStartRow() {
        return startRow;
    }
    public void setStartRow(int startRow) {
        this.startRow = startRow;
    }
    
	public static List<Map<String, String>> read(ExcelUploadUtilController excelReadOption) {
        //엑셀 파일 자체
        //엑셀파일을 읽어 들인다.
        //FileType.getWorkbook() <-- 파일의 확장자에 따라서 적절하게 가져온다.
        Workbook wb = getWorkbook(excelReadOption.getFilePath());
        /**
         * 엑셀 파일에서 첫번째 시트를 가지고 온다.
         */
        Sheet sheet = wb.getSheetAt(0);

        /**
         * sheet에서 유효한(데이터가 있는) 행의 개수를 가져온다.
         */
        int numOfRows = sheet.getPhysicalNumberOfRows();
        int numOfCells = 0;
        
        Row row = null;
        Cell cell = null;
        
        String cellName = "";
        /**
         * 각 row마다의 값을 저장할 맵 객체
         * 저장되는 형식은 다음과 같다.
         * put("A", "이름");
         * put("B", "게임명");
         */
        Map<String, String> map = null;
        /*
         * 각 Row를 리스트에 담는다.
         * 하나의 Row를 하나의 Map으로 표현되며
         * List에는 모든 Row가 포함될 것이다.
         */
        List<Map<String, String>> result = new ArrayList<Map<String, String>>(); 
        /**
         * 각 Row만큼 반복을 한다.
         */

        /*
         * 네임 셀을 기준으로 셀 갯수를 구한다.
         */
        row = sheet.getRow(excelReadOption.getStartRow() - 2);
        numOfCells = row.getPhysicalNumberOfCells();

        for(int rowIndex = excelReadOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
            /*
             * 워크북에서 가져온 시트에서 rowIndex에 해당하는 Row를 가져온다.
             * 하나의 Row는 여러개의 Cell을 가진다.
             */
            row = sheet.getRow(rowIndex);
            
            if(row != null) {

                /*
                 * 데이터를 담을 맵 객체 초기화
                 */
                map = new HashMap<String, String>();
                /*
                 * cell의 수 만큼 반복한다.
                 */
                for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {
                    /*
                     * Row에서 CellIndex에 해당하는 Cell을 가져온다.
                     */
                    cell = row.getCell(cellIndex);
                    /*
                     * 현재 Cell의 이름을 가져온다
                     * 이름의 예 : A,B,C,D,......
                     */
                    cellName = getName(cell, cellIndex);
                    /*
                     * 추출 대상 컬럼인지 확인한다
                     * 추출 대상 컬럼이 아니라면, 
                     * for로 다시 올라간다
                     */
                    if( !excelReadOption.getOutputColumns().contains(cellName) ) {
                        continue;
                    }
                    /*
                     * map객체의 Cell의 이름을 키(Key)로 데이터를 담는다.
                     */

                    String value = getValue(cell);
                    if (value == null || value.isEmpty() || value.equals("")) {
                        value = null;
                    }

                    map.put(cellName, value);
                }
                /*
                 * 만들어진 Map객체를 List로 넣는다.
                 */
                result.add(map);
                
            }
            
        }

        return result;
        
    }
	
	public static Workbook getWorkbook(String filePath) {
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(filePath);
		} catch (FileNotFoundException e) {
			// TODO: handle exception
			throw new RuntimeException(e.getMessage(), e);
		}
		Workbook wb = null;
		
		if(filePath.toUpperCase().endsWith(".XLS")) {
            try {
                wb = new HSSFWorkbook(fis);
            } catch (IOException e) {
                throw new RuntimeException(e.getMessage(), e);
            }
		}else if(filePath.toUpperCase().endsWith(".XLSX")) {
            try {
                wb = new XSSFWorkbook(fis);
            } catch (IOException e) {
                throw new RuntimeException(e.getMessage(), e);
            }
        }
		return wb;
	}
	
	/**
     * Cell에 해당하는 Column Name을 가젼온다(A,B,C..)
     * 만약 Cell이 Null이라면 int cellIndex의 값으로
     * Column Name을 가져온다.
     * @param cell
     * @param cellIndex
     * @return
     */
    public static String getName(Cell cell, int cellIndex) {
        int cellNum = 0;
        if(cell != null) {
            cellNum = cell.getColumnIndex();
        }
        else {
            cellNum = cellIndex;
        }
        
        return CellReference.convertNumToColString(cellNum);
    }
    
    public static String getValue(Cell cell) {
        String value = "";
        
        if(cell == null) {
            value = "";
        }
        else {
        
        switch(cell.getCellType()) {
        case FORMULA :
            value = cell.getCellFormula();
            break;
        
        case NUMERIC :
            value = (int)cell.getNumericCellValue() + "";
            break;
            
        case STRING :
            value = cell.getStringCellValue();
            /*try {
				value = URLEncoder.encode(value,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}*/
            break;
        
        case BOOLEAN :
            value = cell.getBooleanCellValue() + "";
            break;
       
        case BLANK :
            value = "";
            break;
        
        case ERROR :
            value = cell.getErrorCellValue() + "";
            break;
        default:
            value = cell.getStringCellValue();
        }
        
        }
        return value;
    }
}

