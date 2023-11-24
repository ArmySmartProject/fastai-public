package ai.maum.biz.fastaicc.main.cousult.common.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import ai.maum.biz.fastaicc.common.CustomProperties;
import ai.maum.biz.fastaicc.common.util.VariablesMng;
import ai.maum.biz.fastaicc.main.common.controller.ExcelUploadUtilController;
import ai.maum.biz.fastaicc.main.cousult.common.domain.CmContractVO;
import ai.maum.biz.fastaicc.main.cousult.common.service.CommonService;
import ai.maum.biz.fastaicc.main.cousult.common.service.MonitoringTargetUploadService;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class CommonController {

	@Autowired
	CommonService commonService;

	@Autowired
	MonitoringTargetUploadService monitoringTargetUploadService;

	@Autowired
	CustomProperties customProperties;
	
	@Inject
	VariablesMng variablesMng;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String intro(Model model) {
		//model.addAttribute("menuId", variablesMng.getMenuIdString("mntTargetUpload"));			// menuId 설정.

		return "/login";
	}

	/*엑셀 업로드 액션*/
	@ResponseBody
	@RequestMapping(value = "/uploadAction", method = {RequestMethod.GET, RequestMethod.POST})
	public String uploadAction(MultipartFile[] uploadFile) {

		//파일 저장 경로 window/Linux
		//String uploadFolder = "D:\\Dev\\tmp";
		String uploadFolder = customProperties.getExcelUploadPath();

		Map<String, String> history_map = new HashMap<>();

		//저장할 폴더 생성 (yyyy/MM/dd)
		File uploadPath = new File(uploadFolder, getFolder());
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		String return_str = "";
		String formattedDate = getTodate();
		String uploadFileName = "";
		String rawFileName = "";

		for (MultipartFile multipartFile : uploadFile) {

			rawFileName = multipartFile.getOriginalFilename();
			rawFileName = rawFileName.substring(uploadFileName.lastIndexOf("\\") + 1);

			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + formattedDate + "_" + rawFileName; //저장파일 형식 (random문자열'_'업로드시간'_'업로드파일명)
			File saveFile = new File(uploadPath, uploadFileName);

			try {
				multipartFile.transferTo(saveFile);
				return_str = excelDataUpload(saveFile); // excelData DB 저장
				if (return_str.equals("SUCC")) {
					return_str = tmpToTarget();
				}
			} catch (Exception e) {
				monitoringTargetUploadService.resetExcelTmp();
				return_str = "FAIL";
			}

		}
		return return_str;
	}

	/*excel 내부 Data DB table에 저장*/
	public String excelDataUpload(File destFile) {
		ExcelUploadUtilController excelUploadUtil = new ExcelUploadUtilController();
		excelUploadUtil.setFilePath(destFile.getAbsolutePath());

		// 엑셀 컬럼 인덱스
		excelUploadUtil.setOutputColumns("A", "B", "C", "D");

		excelUploadUtil.setStartRow(2);

		String return_str = "";

		int check_listCnt = 0;
		int cnt_excel_row = 0;
		int cnt_upload_row = 0;

		check_listCnt = monitoringTargetUploadService.getExcelTmpCount();
		if (check_listCnt > 0) {
			monitoringTargetUploadService.resetExcelTmp();
		}
		List<Map<String, String>> excelContent = ExcelUploadUtilController.read(excelUploadUtil);
		cnt_excel_row = excelContent.size();
		try {
			cnt_upload_row = monitoringTargetUploadService.uploadExcelTmp(excelContent);
			//excel data갯수와 tmp테이블에 저장된 갯수 비교후 맞는지 확인
			if (cnt_excel_row == cnt_upload_row) {
				//if(cnt_excel_row.equals(cnt_upload_row))
				return_str = "SUCC";
			} else {
				return_str = "FAIL";
			}
		} catch (Exception e) {
			log.error("uploadService Exception: " + e.getMessage());
			return_str = "exception error";
			// TODO: handle exception
		}

		return return_str;
	}

	public String tmpToTarget() {

		String return_str = "";

		int check_tmpListCnt = 0;
		int check_targetListCnt = 0;

		List<CmContractVO> cmContractDTOList = monitoringTargetUploadService.getExcelTmpList();
		check_tmpListCnt = monitoringTargetUploadService.getExcelTmpCount();
		check_targetListCnt = monitoringTargetUploadService.uploadTarget(cmContractDTOList);

		monitoringTargetUploadService.resetExcelTmp();
		//tmp 갯수와 tartget 갯수 비교후 맞는지 확인.
		if (check_tmpListCnt == check_targetListCnt) {
			return_str = "SUCC";
		} else {
			return_str = "FAIL";
		}
		return return_str;

	}

	/* 저장할 폴더 생성 */
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}

	private String getTodate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
		Date date = new Date();
		String str = sdf.format(date);
		return str;
	}
 	
}
