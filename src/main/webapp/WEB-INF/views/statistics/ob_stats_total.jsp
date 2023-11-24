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
		<span class="out_bg"> <em> <strong>&nbsp;</strong> <strong>&nbsp;</strong>
				<strong>&nbsp;</strong> <b>&nbsp;</b>
		</em>
		</span>
	</div>
	<!-- //.page loading -->

	<!-- #wrap -->
	<div id="wrap">

		<!-- #header -->
		<jsp:include page="../common/inc_header.jsp">
			<jsp:param name="titleCode" value="A0406"/>
			<jsp:param name="titleTxt" value="O/B 콜 통계"/>
		</jsp:include>
		<!-- .#header -->

		<!-- #container -->
		<div id="container">
			<input type="hidden" id="cPage" value="1"/>
			<input type="hidden" id="headerName" value="${_csrf.headerName}" />
			<input type="hidden" id="token" value="${_csrf.token}" />
			<!-- 검색조건 -->
			<div class="srchArea">
				<form id="aaa">
					<table class="tbl_line_view" summary="회사명/검색유형/캠페인명/검색일자 기준로 구성됨">
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
									<select class="select" id="companyIdSelect"></select>
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="A0206" text="검색유형" /></th>
								<td>
									<div class="checkBox">
										<input type="checkbox" name="checkBox1" id="ipt_check1_2" value="hourly" class="ipt_check">
										<label for="ipt_check1_2"><spring:message code="A0208" text="시간 단위" /></label>
										<input type="checkbox" name="checkBox1" id="ipt_check1_3" value="daily" class="ipt_check" checked>
										<label for="ipt_check1_3"><spring:message code="A0209" text="일 단위" /></label>
										<!-- [D] <label>의 for값과 <input>의 ID 값을 동일하게 작성해야 함 -->
									</div>
								</td>
								<th scope="row"><spring:message code="A0211" text="검색일자" /></th>
								<td>
									<div class="iptBox">
										<input type="text" name="fromDate" id="fromDate" class="ipt_dateTime" autocomplete="off">
										<span>-</span>
										<input type="text" name="toDate" id="toDate" class="ipt_dateTime" autocomplete="off">
									</div>
								</td>
								<th><spring:message code="A0312" text="캠페인 명" /></th>
								<td><select class="select" id="campaignList"></select></td>
							</tr>
						</tbody>
					</table>
				</form>
				<div class="btnBox sz_small line">
					<button type="button" class="btnS_basic" id="search">
						<spring:message code="A0180" text="검색" />
					</button>
					<button type="button" class="btnS_basic" id="export">
						<spring:message code="A0182" text="다운로드" />
					</button>
				</div>
			</div>
			<!-- //검색조건 -->

			<!-- .jqGridBox -->
			<div class="jqGridBox">
				<table id="jqGrid"></table>
				<div id="jqGridPager"></div>
			</div>
			<!-- //.jqGridBox -->
			<div style="display:none;">
			<!-- <div> -->
				<table id="jqGrid_excel"></table>
				<div id="jqGrid_excel_Pager"></div>
			</div>
			<!-- .chartBox -->
			<div class="chartBox" id="canvasAria">
				<canvas id="lineChart" height="250"></canvas>
			</div>
			<!-- //.chartBox -->
		</div>
		<!-- //#container -->

		<hr>

		<!-- #footer -->
		<div id="footer">
			<div class="cyrt">
				<span>&copy; MINDsLab. All rights reserved.</span>
			</div>
		</div>
		<!-- //#footer -->
	</div>
	<!-- //#wrap -->

	<%@ include file="../common/inc_footer.jsp"%>
	<!-- script -->
	<script type="text/javascript">

var myChart = null;
var gridOption = null;
var timeSortOrder = "desc";
var sortOrder = "desc";
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

	// datetimepicker 재설정
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
	var colName1 = [
		'<spring:message code="A0225" text="날짜"/>',
		'<spring:message code="A0226" text="시간"/>',
		'<spring:message code="A0312" text="캠페인 명"/>',
		'<spring:message code="A0147" text="총인입"/>',
		'<spring:message code="A0227" text="Bot응대"/>',
		'<spring:message code="A0022" text="Bot+CSR"/>',
		'ETC',
		'<spring:message code="A0231" text="포기호"/>',
		'<spring:message code="A0319" text="평균통화시간"/>'
	];
	
	var colModel1 = [
		{name:'startDate',   index:'startDate',    align:'center', sorttype:'date'},                                    // 날짜
		{name:'startTime',   index:'startTime',    align:'center'},                                                     // 시간
		{name:'campaignNm',  index:'campaignNm',   align:'center', sortable: false},                                    // 캠페인 명
		{name:'callTotal',   index:'callTotal',    align:"center", summaryType:'sum', sortable: false},                 // 총 콜수
		{name:'callAi',      index:'callAi',       align:"center", summaryType:'sum', sortable: false},                 // Bot 상담콜수
		{name:'callAgent',   index:'callAgent',    align:"center", summaryType:'sum', sortable: false},                 // 상담사 개입 콜수
		{name:'etc',         index:'etc',          align:"center", summaryType:'sum', editable:true, sortable: false},  // etc
		{name:'giveUp',      index:'giveUp',       align:"center", summaryType:'sum', editable:true, sortable: false},  // 포기호
		{name:'avgDuration', index:'avgDuration',  align:"center", sortable: false},                                    // 평균통화시간
	];
	
	var colName2 = JSON.parse(JSON.stringify(colName1));
	var colModel2 = JSON.parse(JSON.stringify(colModel1));
	colName2.splice(1, 1);
	colModel2.splice(1, 1);
	
	var checkVal = $("input[name=checkBox1]:checked").val();
	var colName, colModel;
	if(checkVal == "hourly") {
		colName = colName1;
		colModel = colModel1;
	} else {
		colName = colName2;
		colModel = colModel2;
	}
	
	var groupSort = sortOrder;
	var gridOption = {
		url: "${pageContext.request.contextPath}/getObStatsTotalJQList",
		datatype: "local",
		rowNum: 30,
		colNames:colName,
		colModel:colModel,
		pager: "#jqGridPager",
		viewrecords: true,
		grouping:true,
		groupingView : {
			groupField : ['startDate'],
			groupSummary : [true],
			groupColumnShow : [true],
			groupText : ['<b>{0}</b>'],
			groupOrder: [groupSort]
		},
		loadonce: false,
		mtype: 'POST',
		ajaxGridOptions: { contentType: "application/json" },
		loadBeforeSend: function(jqXHR) {
			jqXHR.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
		},
		
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
			gridSearch(gridPage,"N");
		},
		loadComplete : function (data) {
			if(data.rows.length > 0){
				var arrDate			= new Array();		// DATE  날짜  
				var arrTime			= new Array();		// DATE  날짜  
				var arrCallTotal	= new Array();		// call_total 총콜수  
				var arrCallAi		= new Array();		// call_ai  Bot상담콜수
				var arrCallAgent	= new Array();		// call_agent  상담개입콜수
				var arrEtc			= new Array();		// etc
				var arrGiveUp		= new Array();		// giveUp 포기호 
				var arrDateTime		= new Array();		// 날짜 시간 
				var cpDataArr = [];
				var cp = $("#jqGrid").getGridParam("page");
				var rowNum = $("#jqGrid").getGridParam("rowNum");
				
				$.each(data.rows, function(i, v){

					if(cp == 1){
						if(i<rowNum){
							cpDataArr.push(v);	
						}
					}else{
						if(i + (cp-1)*rowNum + 1 >(cp-1)*rowNum && (cp*rowNum) > i + (cp-1)*rowNum){
							cpDataArr.push(v);
						}
					}
				});
				
				var checkType = $("input[name=checkBox1]:checked").val();
				$.each(cpDataArr, function(key, value){
					if(checkType == "hourly" && value.startTime == "00") {
						arrDate[key] = ["",value.startTime,value.startDate.substr(5,5)];
					} else {
						if(checkType == "hourly"){
							arrDate[key] = value.startTime;
						} else {
							arrDate[key] = value.startDate;
						}
					}
					arrTime[key]		= value.startTime;
					arrCallTotal[key]	= value.callTotal;
					arrCallAi[key]		= value.callAi;
					arrCallAgent[key]	= value.callAgent;
					arrEtc[key]			= value.etc;
					arrGiveUp[key]		= value.giveUp;
				});
				
				var lineChartData = {
						type: 'line',
						data: {
							labels: arrDate,
							datasets: [{
								label: '<spring:message code="A0147" text="총인입"/>',
								fill: false,
								backgroundColor: window.chartColors.red,
								borderColor: window.chartColors.red,
								data: arrCallTotal,
							}, {
								label: '<spring:message code="A0227" text="Bot응대"/>',
								fill: false,
								backgroundColor: window.chartColors.orange,
								borderColor: window.chartColors.orange,
								data: arrCallAi,
							}, {
								label: '<spring:message code="A0022" text="Bot+CSR"/>',
								fill: false,
								backgroundColor: window.chartColors.yellow,
								borderColor: window.chartColors.yellow,
								data: arrCallAgent,
							}, {
								label: 'ETC',
								fill: false,
								backgroundColor: window.chartColors.green,
								borderColor: window.chartColors.green,
								data: arrEtc,
							}, {
								label: '<spring:message code="A0231" text="포기호"/>',
								fill: false,
								backgroundColor: window.chartColors.blue,
								borderColor: window.chartColors.blue,
								data: arrGiveUp,
							}]
						},	
						
						options: {
							maintainAspectRatio: false,
							responsive: true,
							title: {
								display: false,
							},
							tooltips: {
								mode: 'index',
								intersect: false,
							},
							hover: {
								mode: 'nearest',
								intersect: true
							},
							legend: {
								display: true
							},
							scales: {
								xAxes: [{
									display: true,
									scaleLabel: {
										display: false,
										labelString: 'Date'
									},
									ticks: {
										beginAtZero: true,
										autoSkip: true,
										maxRotation: 0,
										minRotation: 0
									}
								}],
								yAxes: [{
									display: true,
									scaleLabel: {
										display: true,
										labelString: '건수'
									},
									ticks: {
										beginAtZero: true
									}
								}]
							}
						}
				};
				
				var lineChart = document.getElementById('lineChart').getContext('2d');

				if(myChart == null){
					myChart = new Chart(lineChart, lineChartData);	
				}else{
					myChart.destroy();
					myChart = new Chart(lineChart, lineChartData);
				}
				
				$(".ui-pg-input").attr("readonly", true);
			}else{
				// 그래프 초기화
				if(myChart != null){
					myChart.destroy();
				}
			}
		},
		onSortCol : function(iCol, index, sort){
			// grid sort
			if(iCol == "startDate"){
				sortOrder = sort;
			}
			if(iCol == "startTime"){
				timeSortOrder = sort;
			}
			
			$.jgrid.gridUnload('#jqGrid_excel');
			createJqGrid();
			gridSearch($("#cPage").val(), "N");
			
			return "stop";
		}
	};

	gridOption.pager = "#jqGridPager";
	$("#jqGrid").jqGrid(gridOption);
	gridOption.pager = "#jqGrid_excel_Pager";
	gridOption.loadComplete = "";
	$("#jqGrid_excel").jqGrid(gridOption);
	
	$(".ui-pg-input").attr("readonly", true);	// 페이지 input 비활성화
	scResize();				// 처음 그리드 생성시 resize
};

function dateTimePickerResetting(dateType) {
	var fromDatePicker = $('#fromDate').data('datetimepicker');
	var toDatePicker = $('#toDate').data('datetimepicker');
	if(dateType == "hourly") {
		fromDatePicker.startViewMode = 2;
		fromDatePicker.viewMode = 2;
		fromDatePicker.minView = 1;
		fromDatePicker.viewSelect = 1;
		fromDatePicker.setFormat("yyyy-mm-dd hh:ii")
		toDatePicker.startViewMode = 2;
		toDatePicker.viewMode = 2;
		toDatePicker.minView = 1;
		toDatePicker.viewSelect = 1;
		toDatePicker.setFormat("yyyy-mm-dd hh:ii")
		
	} else if(dateType == "daily") {
		fromDatePicker.startViewMode = 2;
		fromDatePicker.viewMode = 2;
		fromDatePicker.minView = 2;
		fromDatePicker.viewSelect = 2;
		fromDatePicker.setFormat("yyyy-mm-dd")
		toDatePicker.startViewMode = 3;
		toDatePicker.viewMode = 3;
		toDatePicker.minView = 2;
		toDatePicker.viewSelect = 2;
		toDatePicker.setFormat("yyyy-mm-dd")
		
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
				getCampaignList("");
			});
			
			getCampaignList("load");
			
		}else {
			alert("<spring:message code='A0333' text='CompanyId가 존재하지 않습니다.' />");
		}
		
	}).fail(function(result) {
		console.log("ajax connection error: getCompanyIdList");
	});
}

function getCampaignList(type) {
	var param = {companyId:$("#companyIdSelect option:selected").val()};
	$.ajax({url : "${pageContext.request.contextPath}/getCampaignList",
		data : JSON.stringify(param),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		var html = "";
		if(result != null && result.length > 0){
			html = "<option selected value=''><spring:message code='A0331' text='-전체-' /></option>";
			for(var i = 0; i < result.length; i++) {
				html += "<option value='" + result[i].campaignId + "'>" + result[i].campaignNm + "</option>"
			}
			
		}else {
			html = "<option selected value='99'><spring:message code='A0069' text='-선택-' /></option>";
		}
		
		$("#campaignList").html(html);
		
		if(type == "load") {
			createJqGrid();
			gridSearch(1);
		}
		
	}).fail(function(result) {
		console.log("ajax connection error: getCompanyIdList");
	});
}


function gridSearch(currentPage, excelYn) {
	if(!searchCheck()) {
		return false;
	}
	
	var obj = new Object();
	obj.minuteUnit = $("input[name=checkBox1]:checked").val(); // 검색유형  시간 단위(hourly) / 일 단위(daily)
	obj.fromDate  = $("#fromDate").val();
	obj.toDate	= $("#toDate").val();
	obj.campaignId = $("#campaignList option:selected").val(); // 캠페인 명
	obj.excelYn = excelYn == "Y"? excelYn : "N";
	obj.sortOrder = sortOrder;
	obj.timeSortOrder = timeSortOrder;
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
		$("#jqGrid").setGridParam({loadonce:false, datatype:"json", postData:JSON.stringify(obj)}).trigger("reloadGrid");
	}
}

var excelFn = {fn:function(){
	if($("#gbox_jqGrid_excel .ui-widget-content").length > 0 && $("#jqGrid_excel #norecs").length == 0){
		setTimeout(function() {
			$("#jqGrid_excel").jqGrid("exportToExcel",{
				includeLabels : true,
				includeGroupHeader : true,
				includeFooter: true,
				fileName : "<spring:message code="A0406" text="O/B 콜 통계"/>.xlsx",
				mimetype : "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
				//maxlength : 40,
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
	var chartBoxHeight = $(".chartBox").outerHeight(true);
	var resizeHeight = $("#container").height() - searchBoxHeight - gridSubHeight - chartBoxHeight; // 전체 container높이 - 검색박스높이 - 그리드(헤더,페이지,margin)높이 - 차트박스높이

	
	// 그리드의 width를 div 에 맞춰서 적용
	$('#jqGrid').setGridWidth( resizeWidth , true);
	$('#jqGrid').setGridHeight( resizeHeight , true);
	$('#jqGrid').css("width", '');
}

</script>

</body>
</html>
