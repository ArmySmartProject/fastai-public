<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="format-detection" content="telephone=no">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<!-- Cache reset -->
<meta http-equiv="Expires" content="Mon, 06 Jan 2016 00:00:01 GMT">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">

<%@ include file="../common/inc_head_resources.jsp"%>
</head>

<body>
<!-- .page loading -->
<div id="pageldg" class="page_loading">
	<span class="out_bg">
		<em>
			<strong>&nbsp;</strong>
			<strong>&nbsp;</strong>
			<strong>&nbsp;</strong>
			<b>&nbsp;</b>
		</em>
	</span>	
</div>
<!-- //.page loading -->
	
<!-- #wrap -->
<div id="wrap">
		<!-- #header -->
		<jsp:include page="../common/inc_header.jsp">
			<jsp:param name="titleCode" value="A0238"/>
			<jsp:param name="titleTxt" value="상담원별통계"/>
		</jsp:include>
		<!-- //#header -->
	  
		<!-- #container -->
		<div id="container">
			<!-- 검색조건 -->
			<div class="srchArea">
			<input type="hidden" id="cPage" value="1"/>
			<form id="searchStatsAdviser">
				<table class="tbl_line_view" summary="검색유형/모음기준/제외여부/검색일자/개인지정으로 구성됨">
					<caption class="hide">검색조건</caption>
					<colgroup>
						<col width="100"><col >
						<col width="100"><col >
						<col width="100"><col >
					</colgroup>
					<tbody>
					<tr>
						<th>Company</th>
						<td>
							<select class="select" id="companyIdSelect">
							</select>
						</td>
						<th><spring:message code="A0243" text="상담원 지정"/></th>
						<td id="multipleTd">
						</td>
						<th><spring:message code="A0240" text="모음기준"/></th>
						<td>
							<div class="checkBox">
								<input type="checkbox" name="checkBox2" id="ipt_check2_1" value="mode1" class="ipt_check">
								<label for="ipt_check2_1"><spring:message code="A0241" text="개인 I (시/일/월/요일)"/></label>
								<input type="checkbox" name="checkBox2" id="ipt_check2_2" value="mode2" class="ipt_check" checked="checked">
								<label for="ipt_check2_2"><spring:message code="A0242" text="(시/일/월/요일) I 개인"/></label>
							</div>
						</td>
					</tr>
					<tr>
						<th><spring:message code="A0206" text="검색유형"/></th>
						<td>
							<div class="checkBox">											
								<input type="checkbox" name="checkBox1" id="ipt_check1_1" value="daily" class="ipt_check" checked>
								<label for="ipt_check1_1"><spring:message code="A0209" text="일 단위"/></label>
								<input type="checkbox" name="checkBox1" id="ipt_check1_3" value="monthly" class="ipt_check">
								<label for="ipt_check1_3"><spring:message code="A0210" text="월 단위"/></label>
								<!-- [D] <label>의 for값과 <input>의 ID 값을 동일하게 작성해야 함 -->
							</div>
						</td>
						<th><spring:message code="A0211" text="검색일자"/></th>
						<td>
							<div class="iptBox">
								<input type="text" name="fromDate" id="fromDate" class="ipt_dateTime" autocomplete="off">
								<span>-</span>
								<input type="text" name="toDate" id="toDate"  class="ipt_dateTime" autocomplete="off">
							</div>
						</td>
						<th><spring:message code="A0175" text="제외여부"/></th>
						<td>
							<div class="checkBox">
								<input type="checkbox" name="checkBox3" id="ipt_check3_1" value="exception" class="ipt_check" checked="checked">
								<label for="ipt_check3_1"><spring:message code="A0176" text="주말 제외"/></label>
							</div>
						</td>
					</tr>
					</tbody>
				</table>
				</form>
				<!-- //검색조건 -->
				<div class="btnBox sz_small line">
					<button type="button" class="btnS_basic" id="search"><spring:message code="A0180" text="검색"/></button>
					<!-- <button type="button" class="btnS_basic"><spring:message code="A0181" text="출력"/></button> -->
					<button type="button" class="btnS_basic" id="export"><spring:message code="A0182" text="다운로드"/></button>
				</div>
			</div>
			
			<!-- .jqGridBox -->
			<div class="jqGridBox">
				<table id="jqGrid"></table>
				<div id="jqGridPager"></div>
			</div>
			<div style="display:none;">
				<table id="jqGrid_excel"></table>
				<div id="jqGrid_excel_Pager"></div>
			</div>
			<!-- //.jqGridBox -->
		</div>
		<!-- //#container -->
		<hr>

		<!-- #footer -->
		<div id="footer">
			<div class="cyrt"><span>&copy; MINDsLab. All rights reserved.</span></div>
		</div>
		<!-- //#footer -->
</div>
<!-- //#wrap -->

<%@ include file="../common/inc_footer.jsp"%> 

<!-- script -->  
<script type="text/javascript">
var advSort = "desc";
var excelExport = false;
var lang = $.cookie("lang");

$(document).ready(function (){
	$(window).bind('resize', function() {
		scResize();
	}).trigger('resize');
	
	// fixDate: 오전9시기준, curDate: 현시간기준
	var date = new Date();
	var minutes = date.getMinutes().toString().length == 1 ? "0"+date.getMinutes().toString() : date.getMinutes().toString();
	var curDate = getFormatDate(date) +" "+ date.getHours()+":"+ minutes;
	var fixDate = getFormatDate(date)+" 09:00";//오늘 특정시간
	var fromDate = (fixDate > curDate) ? curDate : fixDate;
	var toDate = (fixDate > curDate) ? fixDate : curDate;
	$("#fromDate").val(fromDate);
	$("#toDate").val(toDate);
	
	if(lang == "ko" || lang == null){
		//datetimepicker
		$('#fromDate').datetimepicker({
			language : 'ko', // 화면에 출력될 언어를 한국어로 설정합니다.
			pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
			defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
			autoclose: 1,
			endDate: $("#toDate").val()
		}).on('changeDate', function(selectedDate){
			$("#toDate").datetimepicker('setStartDate',selectedDate.date);
		});
	
		$('#toDate').datetimepicker({
			language : 'ko', // 화면에 출력될 언어를 한국어로 설정합니다.
			pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
			defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
			autoclose: 1,
			startDate: $("#fromDate").val()
		}).on('changeDate', function(selectedDate){
			$("#fromDate").datetimepicker('setEndDate',selectedDate.date);
		});
	}else if(lang == "en"){
		//datetimepicker
		$('#fromDate').datetimepicker({
			language : 'en', // 화면에 출력될 언어를 한국어로 설정합니다.
			pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
			defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
			autoclose: 1,
			endDate: $("#toDate").val()
		}).on('changeDate', function(selectedDate){
			$("#toDate").datetimepicker('setStartDate',selectedDate.date);
		});
	
		$('#toDate').datetimepicker({
			language : 'en', // 화면에 출력될 언어를 한국어로 설정합니다.
			pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
			defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
			autoclose: 1,
			startDate: $("#fromDate").val()
		}).on('changeDate', function(selectedDate){
			$("#fromDate").datetimepicker('setEndDate',selectedDate.date);
		});
	}

	// 체크박스 1
	//radio버튼처럼 checkbox name값 설정
	$('input[type="checkbox"][name="checkBox1"]').click(function(){
		//checkbox 전체를 checked 해제후 click한 요소만 true지정
		$('input[type="checkbox"][name="checkBox1"]').prop('checked', false);
		$(this).prop('checked', true);
		dateTimePickerResetting($(this).val());
	});

	//체크박스 2
	//radio버튼처럼 checkbox name값 설정
	$('input[type="checkbox"][name="checkBox2"]').click(function(){
		//checkbox 전체를 checked 해제후 click한 요소만 true지정
		$('input[type="checkbox"][name="checkBox2"]').prop('checked', false);
		$(this).prop('checked', true);
	});

	dateTimePickerResetting($("input[name=checkBox1]:checked").val());
	getCompanyId();
	
	//검색버튼 클릭시
	$("#search").on("click", function(){
		$.jgrid.gridUnload('#jqGrid');
		createJqGrid();
		
		$("#cPage").val(1);
		gridSearch(1, "N");
	});
	
	//다운로드 클릭시 엑셀다운로드
	$("#export").on("click", function(e){
		if(excelExport == false){
			excelExport = true;
			$.jgrid.gridUnload('#jqGrid_excel');
			createJqGrid();
			gridSearch(1, "Y");
		} else {
			alert('<spring:message code="A0340" text="Excel 다운로드가 진행 중입니다." />');
		}
	});
});

function createJqGrid() {
	//그리드 옵션 생성
	var colName1 = [
		'<spring:message code="A0244" text="상담원"/>',
		'<spring:message code="A0225" text="날짜"/>',
		'<spring:message code="A0245" text="건수"/>',
		'<spring:message code="A0235" text="평균통화시간"/>',
		'<spring:message code="A0246" text="총통화시간"/>',
		'00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23'
	];
	
	var colModel1 = [
		{name:'CUST_OP_NM', index:'CUST_OP_NM', width:140, align:'center', sorttype:'text', sortable: false},
		{name:'DATE', index:'DATE', width:90, align:'center', sorttype:'date'},
		{name:'IN_CALL_COUNT',index:'IN_CALL_COUNT', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'IN_CALL_TIME_AVG',index:'IN_CALL_TIME_AVG', width:90, align:'center', formatoptions:{newformat:'H:i:s'}, datefmt:'H:i:s', sortable: false},
		{name:'IN_CALL_TIME_TOT',index:'IN_CALL_TIME_TOT', width:90, align:'center', formatoptions:{newformat:'H:i:s'}, datefmt:'H:i:s', sortable: false},
		{name:'CNT_00',index:'CNT_00', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_01',index:'CNT_01', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_02',index:'CNT_02', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_03',index:'CNT_03', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_04',index:'CNT_04', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_05',index:'CNT_05', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_06',index:'CNT_06', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_07',index:'CNT_07', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_08',index:'CNT_08', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_09',index:'CNT_09', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_10',index:'CNT_10', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_11',index:'CNT_11', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_12',index:'CNT_12', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_13',index:'CNT_13', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_14',index:'CNT_14', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_15',index:'CNT_15', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_16',index:'CNT_16', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_17',index:'CNT_17', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_18',index:'CNT_18', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_19',index:'CNT_19', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_20',index:'CNT_20', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_21',index:'CNT_21', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_22',index:'CNT_22', width:40, align:'center', summaryType:'sum', sortable: false},
		{name:'CNT_23',index:'CNT_23', width:40, align:'center', summaryType:'sum', sortable: false}
	];
	
	var colName2 = JSON.parse(JSON.stringify(colName1));
	var tempNameArr = JSON.parse(JSON.stringify(colName1));
	
	colName2[0] = tempNameArr[1];
	colName2[1] = tempNameArr[0];
	
	var colModel2 = JSON.parse(JSON.stringify(colModel1));
	var tempModelArr = JSON.parse(JSON.stringify(colModel1));
	
	colModel2[0] = tempModelArr[1];
	colModel2[1] = tempModelArr[0];
	
	var groupSort = advSort;
	var colName,colModel,sortName;
	var checkVal = $("input[name=checkBox2]:checked").val();
	
	if(checkVal == "mode1") {
		colName = colName1;
		colModel = colModel1;
		sortName = 'CUST_OP_NM';
		groupSort = 'desc';
	} else {
		colName = colName2;
		colModel = colModel2;
		sortName = 'DATE';
		groupSort = advSort;
	}
	
	var gridOption = {
			url: "${pageContext.request.contextPath}/ibStatsAdviserJQList",
			datatype: "local",
			rowNum: 30,
			colNames: colName,
			colModel: colModel,
			pager: "#jqGridPager",
			viewrecords: true,
			grouping:true,
			groupingView : {
		 		groupField : [sortName],
				groupSummary : [true],
				groupColumnShow : [true],
				groupText : ['<b>{0}</b>'],
				groupOrder: [groupSort]
			},
			mtype: "POST",
			ajaxGridOptions: { contentType: "application/json" },
			loadBeforeSend: function(jqXHR) {
				jqXHR.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
			},
			gridview: true,
			loadonce: false,
			jsonReader : {
				root: "rows",
				page: "page",
				total: "total",
				record: "records",
				repeatitems: false,
			},
			onPaging: function(pgButton){	 //페이징 처리
				var gridPage = $("#jqGrid").getGridParam("page");				// 현재 페이지 번호
				var rowNum = $("#jqGrid").getGridParam("rowNum");				// 뿌려줄 row 개수
				var records = $("#jqGrid").getGridParam("records");				// 총 레코드
				var totalPage = Math.ceil(records/rowNum);						// 총 페이지
				
				if (pgButton == "next") {
					if (gridPage < totalPage) {
						gridPage += 1;
					} else {
						gridPage = page;
					}
				} else if (pgButton == "prev") {
					if (gridPage > 1) {
						gridPage -= 1;
					} else {
						gridPage = page;
					}
				} else if (pgButton == "first") {
					gridPage = 1;
				} else if (pgButton == "last") {
					gridPage = totalPage;
				} else if (pgButton == "user") {
					var nowPage = Number($("#jqGridPager.ui-pg-input").val());
					
					if (totalPage >= nowPage && nowPage > 0) {
						gridPage = nowPage;
					} else {
						$("#jqGridPager.ui-pg-input").val(page);
						gridPage = page;
					}
				} else if (pgButton == "records") {
					gridPage = 1;
				}				
				$("#cPage").val(gridPage);
				gridSearch(gridPage, "N");
			},
			loadComplete : function(data){
				$(".ui-pg-input").attr("readonly", true);
			},
			onSortCol : function(iCol, index, sortOrder){
				// grid sort
				if(iCol == "DATE"){
					advSort = sortOrder;
					createJqGrid();
					gridSearch($("#cPage").val(), "N");
				}
				
				return "stop";
			}
			
		};
	gridOption.pager = "#jqGrid_excel_Pager";
	$("#jqGrid_excel").jqGrid(gridOption);
	gridOption.pager = "#jqGridPager";
	$("#jqGrid").jqGrid(gridOption);
	
	$(".ui-pg-input").attr("readonly", true);
	scResize();
};

function dateTimePickerResetting(dateType) {
	var fromDatePicker = $('#fromDate').data('datetimepicker');
	var toDatePicker = $('#toDate').data('datetimepicker');
	if(dateType == "daily") {
		fromDatePicker.startViewMode = 2;
		fromDatePicker.viewMode = 2;
		fromDatePicker.minView = 2;
		fromDatePicker.viewSelect = 2;
		fromDatePicker.setFormat("yyyy-mm-dd")
		toDatePicker.startViewMode = 2;
		toDatePicker.viewMode = 2;
		toDatePicker.minView = 2;
		toDatePicker.viewSelect = 2;
		toDatePicker.setFormat("yyyy-mm-dd")
		
	} else if(dateType == "monthly") {
		fromDatePicker.startViewMode = 3;
		fromDatePicker.viewMode = 3;
		fromDatePicker.minView = 3;
		fromDatePicker.viewSelect = 3;
		fromDatePicker.setFormat("yyyy-mm")
		toDatePicker.startViewMode = 3;
		toDatePicker.viewMode = 3;
		toDatePicker.minView = 3;
		toDatePicker.viewSelect = 3;
		toDatePicker.setFormat("yyyy-mm")
	}
	fromDatePicker.showMode();
	toDatePicker.showMode();
}

function getCompanyId() {
	$.ajax({
		url : "${pageContext.request.contextPath}/getCompanyIdList",
		data : {},
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		if(result != null && result.length > 0){
			var html = "";
			for(var i = 0; i < result.length; i++) {
				if(lang == "ko" || lang == null){
					html += "<option value='" + result[i].companyId + "'>" + result[i].companyId + " ["+ result[i].companyName +"]</option>"
				} else {
					html += "<option value='" + result[i].companyId + "'>" + result[i].companyId + " ["+ result[i].companyNameEN +"]</option>"
				}
			}
			
			$("#companyIdSelect").html(html);
			
			if(result.length == 1){
				$("#companyIdSelect").attr("disabled", "disabled");
			}
			$("#companyIdSelect").change(function(){
				getConsultantList("");
			});
			
			getConsultantList("load");
			
		}else {
			alert("<spring:message code='A0333' text='CompanyId가 존재하지 않습니다.' />");
		}
		
	}).fail(function(result) {
		console.log("ajax connection error: getCompanyIdList");
	});
}

function getConsultantList(type) {
	var param = {companyId:$("#companyIdSelect option:selected").val()};
	$.ajax({
		url : "${pageContext.request.contextPath}/getConsultantList",
		data : JSON.stringify(param),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		if(result != null && result.length > 0){
			var selectHtml = "<select id='multiple_select' class='select' multiple='multiple'></select>";
			var optionHtml = "";
			
			for(var i = 0; i < result.length; i++) {
				optionHtml += "<option value='" + result[i].custOpId + "'>" + result[i].custOpId + " ["+ result[i].custOpNm +"]</option>"
			}
			
			$("#multipleTd").html(selectHtml);
			$("#multiple_select").html(optionHtml);
			
			multiSelectEvent();
			
			if(type == "load") {
				createJqGrid();
				gridSearch(1);
			}
			
		}else {
			alert("<spring:message code='A0333' text='CompanyId가 존재하지 않습니다.' />");
		}
		
	}).fail(function(result) {
		console.log("ajax connection error: getCompanyIdList");
	});
}

function multiSelectEvent() {
	if($.cookie("lang") == "ko" || !$.cookie("lang")){
		$('#multiple_select').multiselect({
			includeSelectAllOption: true,
			nonSelectedText: '선택하세요',
			allSelectedText: '전체선택',
			selectAllText: '전체선택',
		});
		
	}else if($.cookie("lang") == "en"){
		$('#multiple_select').multiselect({
			includeSelectAllOption: true,
			nonSelectedText: '-Select-',
			allSelectedText: 'OverAll',
			selectAllText: 'OverAll',
		});
	}
	$("#multiple_select").multiselect("selectAll", false); // 전체선택 (false:selectbox가 비활성화된 상태에서 선택가능, true:활성화된 상태에서만 선택가능)
	$("#multiple_select").multiselect("refresh");
}

function gridSearch(currentPage, excelYn) {
	if(!searchCheck()) {
		return false;
	}
	
	var obj = new Object();
	obj.checkBox1 = $("input[name=checkBox1]:checked").val(); // 검색유형  daily / monthly
	obj.checkBox2 = $("input[name=checkBox2]:checked").val(); // 모음기준  mode1 / mode2
	obj.checkBox3 = $("input[name=checkBox3]:checked").val(); // 제외여부 
		
	obj.fromDate = $("#fromDate").val();
	obj.toDate =  $("#toDate").val();	
	var tempStr = "";
	if($("#multiple_select").val() != "" && $("#multiple_select").val() != null && $("#multiple_select").val().length > 0){
		$.each($("#multiple_select").val(), function(i, v){
			if(i == 0){
				tempStr = v;	
			}else{
				tempStr = tempStr+","+v;
			}
		});
		obj.multiple_select_yn = "Y";
	}else{
		obj.multiple_select_yn = "N";
	}
	obj.temp_multiple_select = tempStr; // 개인지정
	obj.custId = $("#custId").val();
	obj.sortOrder = advSort;
	obj.groupType = $("input[name=checkBox2]:checked").val() == 'mode1' ? "custOpNm" : "date";
	obj.companyId = $("#companyIdSelect option:selected").val();
	
	if(excelYn != "Y"){
		obj.page = currentPage; // current page 
		obj.lastpage =  $('#jqGrid').getGridParam('lastpage'); // current page 
		obj.rowNum = jQuery("#jqGrid").getGridParam('rowNum'); //페이지 갯수
		obj.allRecords = jQuery("#jqGrid").getGridParam('records'); 
		obj.endPageCnt = jQuery("#jqGrid").getGridParam('rowNum');//마지막페이지 cnt
		obj.offset = (obj.page * obj.rowNum)-obj.rowNum;
	}
	
	if(excelYn == "Y"){
		$("#jqGrid_excel").jqGrid("clearGridData", true);
		$("#jqGrid_excel").setGridParam({loadComplete:excelFn.fn, loadonce : true, datatype:"json",postData	: JSON.stringify(obj)}).trigger("reloadGrid");
	}else{
		$("#jqGrid").setGridParam({loadonce:false, datatype	: "json",postData	: JSON.stringify(obj)}).trigger("reloadGrid");
	}
}

var excelFn = {fn:function(){
	if($("#gbox_jqGrid_excel .ui-widget-content").length > 0 && $("#jqGrid_excel #norecs").length == 0){
		setTimeout(function() {
			$("#jqGrid_excel").jqGrid("exportToExcel",{
				includeLabels : true,
				includeGroupHeader : true,
				includeFooter: true,
				fileName : "<spring:message code="A0238" text="상담원별통계"/>.xlsx",
				mimetype : "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
				maxlength : 40,
				onBeforeExport : "",
				replaceStr : null,
				loadIndicator : true
			});
			excelExport = false;
		}, 500);
	}else {
		excelExport = false;
		alert("<spring:message code='A0600' text='다운로드 할 데이터가 없습니다.' />");
	}
}};

function searchCheck() {
	if($("#fromDate").val() == "" || $("#toDate").val() == "") {
		alert('<spring:message code="A0601" text="검색 날짜를 입력해주세요." />');
		return false;
	}
	return true;
}

function scResize() {
	var resizeWidth = $('.jqGridBox').width()-1; //jQuery-ui의 padding 설정 및 border-width값때문에 넘치는 걸 빼줌.
	var searchBoxHeight = $("#container .srchArea").outerHeight(true);
	var gridSubHeight = $(".jqGridBox").outerHeight(true) - parseInt($(".ui-jqgrid-bdiv").css("height"));
	var resizeHeight = $("#container").height() - searchBoxHeight - gridSubHeight; // 전체 container높이 - 검색박스높이 - 그리드(헤더,페이지,margin)높이

	// 그리드의 width를 div 에 맞춰서 적용
	$('#jqGrid').setGridWidth( resizeWidth , true); //Resized to new width as per window. 
	$('#jqGrid').setGridHeight( resizeHeight , true);
	$('#jqGrid').css("width", '');
}
</script>
</body>
</html>
