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
			<jsp:param name="titleCode" value="A0403"/>
			<jsp:param name="titleTxt" value="I/B 콜 통계"/>
		</jsp:include>
		<!-- //#header -->
		<!-- #container -->
		<div id="container">
		<input type="hidden" id="cPage" value="1"/>
			<!-- 검색조건 -->
			<div class="srchArea">
			<form id="aaa">
				<table class="tbl_line_view" summary="검색유형/채널유형/제외여부/검색일자/서비스레벨 기준로 구성됨">
					<caption class="hide">검색조건</caption>
					<colgroup>
						<col width="100"><col width="370"><col width="100"><col width="370"><col width="100">
						<col>
						<!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
					</colgroup>
					<tbody>
					<tr>
						<th>Company</th>
						<td>
							<select class="select" id="companyIdSelect">
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="A0206" text="검색유형"/></th>
						<td>
							<div class="checkBox">
								<input type="checkbox" name="checkBox1" id="ipt_check1_1" value="30min" class="ipt_check">
								<label for="ipt_check1_1"><spring:message code="A0207" text="30분 단위"/></label>
								<input type="checkbox" name="checkBox1" id="ipt_check1_2" value="hourly" class="ipt_check">
								<label for="ipt_check1_2"><spring:message code="A0208" text="시간 단위"/></label>
								<input type="checkbox" name="checkBox1" id="ipt_check1_3" value="daily" class="ipt_check" checked>
								<label for="ipt_check1_3"><spring:message code="A0209" text="일 단위"/></label>
								<input type="checkbox" name="checkBox1" id="ipt_check1_5" value="monthly" class="ipt_check">
								<label for="ipt_check1_5"><spring:message code="A0210" text="월 단위"/></label>
								<!-- [D] <label>의 for값과 <input>의 ID 값을 동일하게 작성해야 함 -->
							</div>
						</td>
						<th scope="row"><spring:message code="A0211" text="검색일자"/></th>
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
				<div class="btnBox sz_small line">
					<button type="button" class="btnS_basic" id="search"><spring:message code="A0180" text="검색"/></button>
					<button type="button" class="btnS_basic" id="export"><spring:message code="A0182" text="다운로드"/></button>
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
			<div class="cyrt"><span>&copy; MINDsLab. All rights reserved.</span></div>
		</div>
		<!-- //#footer -->
</div>
<!-- //#wrap -->
	
<%@ include file="../common/inc_footer.jsp"%>	 
<!-- script -->  
<script type="text/javascript">

var myChart = null;
var groupDateSort ='desc';
var groupSort = 'desc';
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
			minView: 1,
			endDate: $("#toDate").val()
		}).on('changeDate', function(selectedDate){
			$("#toDate").datetimepicker('setStartDate',selectedDate.date);
		});
		$('#toDate').datetimepicker({
			language : 'ko', // 화면에 출력될 언어를 한국어로 설정합니다.
			pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
			defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
			autoclose: 1,
			minView: 1,
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
			minView: 1,
			endDate: $("#toDate").val()
		}).on('changeDate', function(selectedDate){
			$("#toDate").datetimepicker('setStartDate',selectedDate.date);
		});
		$('#toDate').datetimepicker({
			language : 'en', // 화면에 출력될 언어를 한국어로 설정합니다.
			pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
			defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
			autoclose: 1,
			minView: 1,
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
	
	dateTimePickerResetting($("input[name=checkBox1]:checked").val());
	getCompanyId();
	
	//검색버튼 클릭시
	$("#search").on("click", function(){
		$.jgrid.gridUnload('#jqGrid');
		createJqGrid();
		$("#cPage").val(1);
		gridSearch(1,"N", groupSort, groupDateSort);
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

//jqGrid
function createJqGrid(){
	var sortName = groupSort;
	var dateType = $("input[name=checkBox1]:checked").val();
	var useGrouping = dateType == "30min" || dateType == "hourly" ? true : false;
	var timeHidden = dateType == "30min" || dateType == "hourly" ? false : true;
	var gridOption = {
			url: "${pageContext.request.contextPath}/getIbStatsTotalJQList",
			datatype: "local",
			rowNum: 30,
			colNames:[
				'<spring:message code="A0225" text="날짜"/>',
				'<spring:message code="A0329" text="상세일시"/>',
				'<spring:message code="A0147" text="총인입"/>',
				'<spring:message code="A0227" text="Bot응대"/>',
				'<spring:message code="A0022" text="Bot+CSR"/>',
				'ETC',
				'<spring:message code="A0230" text="총응대호"/>',
				'<spring:message code="A0149" text="응대율"/>',
				'<spring:message code="A0231" text="포기호"/>',
				'<spring:message code="A0232" text="포기율"/>',
				'<spring:message code="A0233" text="Follow-up call"/>',
				'<spring:message code="A0235" text="평균통화시간"/>',
				'<spring:message code="A0237" text="평균포기시간"/>'
				],
			colModel:[
				{name:'DATE',				 index:'DATE',				 align:'center'},  // 날짜
				{name:'DETAIL_TIME',		  index:'DETAIL_TIME',		  align:'center', hidden:timeHidden},  // 시간
				{name:'INCOMING_COUNT',	   index:'INCOMING_COUNT',	   align:"center", summaryType:'sum', sortable: false},  // 총인입
				{name:'BOT_COUNT',			index:'BOT_COUNT',			align:"center", summaryType:'sum', sortable: false},  // Bot응대
				{name:'BOT_CSR_CNT',		  index:'BOT_CSR_CNT',		  align:"center", summaryType:'sum', sortable: false},  // bot+csr
				{name:'ETC_CNT',			  index:'ETC_CNT',			  align:"center", summaryType:'sum', sortable: false},  // etc
				{name:'TOTAL_COUNT',		  index:'TOTAL_COUNT',		  align:"center", summaryType:'sum', sortable: false},  // 총응대호
				{name:'PERSENTAGE',		   index:'PER_TOTAL_COUNT',	  align:"center", sortable: false},  // 응대율
				{name:'GIVE_UP_COUNT',		index:'GIVE_UP_COUNT',		align:"center", summaryType:'sum', sortable: false},  // 포기호
				{name:'PER_GIVE_UP_COUNT',	index:'PER_GIVE_UP_COUNT',	align:"center", sortable: false},  // 포기율
				{name:'FOLLOW_UP_CALL_COUNT', index:'FOLLOW_UP_CALL_COUNT', align:"center", summaryType:'sum', sortable: false},  //Follow-up call
				{name:'AVG_CALL_TIME',		index:'AVG_CALL_TIME',		align:"center", sortable: false},  // 평균통화시간
				{name:'AVG_GIVE_UP_TIME',	 index:'AVG_GIVE_UP_TIME',	 align:"center", sortable: false} // 평균포기시간}
			],
			pager: "#jqGridPager",
			viewrecords: true,
			grouping:useGrouping,
			groupingView : {
				groupField : ['DATE'],
				groupSummary : [true],
				groupColumnShow : [true],
				groupText : ['{0}'],
				groupOrder: [sortName]
			},
			
			mtype: 'POST',
			ajaxGridOptions: { contentType: "application/json" },
			loadBeforeSend: function(jqXHR) {
				jqXHR.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
			},
			loadonce: false, 
			jsonReader : {
				root: "rows",
				page: "page",
				total: "total",
				record: "records",
				repeatitems: false,
			},
			
			onPaging: function(pgButton){	 //페이징 처리
				var gridPage = $("#jqGrid").getGridParam("page");					 // 현재 페이지 번호
				var rowNum = $("#jqGrid").getGridParam("rowNum");				// 뿌려줄 row 개수
				var records = $("#jqGrid").getGridParam("records");				//  총 레코드  
				var totalPage = Math.ceil(records/rowNum);			 	 // 총 페이지					   
								
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
				gridSearch(gridPage);				
			},
			loadComplete : function (data) {
				if(data.rows.length > 0){
					var arrDate = new Array();					 // DATE  날짜  
					var arrIncomingCount = new Array();	   // INCOMING_COUNT 총인입  
					var arrBotCount = new Array();			   // BOT_COUNT  Bot응대
					var arrBotCSRcount = new Array();	   // BOT_CSR_CNT  bot+csr
					var arrEtcCount = new Array();				// ETC_CNT  휴먼응대
					var arrGiveUpCount = new Array();		  // GIVE_UP_COUNT  포기호 
					var arrFollowUpCallCount = new Array();  // FOLLOW_UP_CALL_COUNT 
					
					var checkType = $("input[name=checkBox1]:checked").val();
					$.each(data.rows, function(key, value){
						if((checkType == "30min" || checkType == "hourly")) {
							if(value.DETAIL_TIME == "00" || value.DETAIL_TIME == "00:00") {
								arrDate[key] = ["",value.DETAIL_TIME,value.DATE.substr(5,5)];
							} else {
								arrDate[key] = value.DETAIL_TIME;
							}
						} else {
							arrDate[key] = value.DATE;
						}
						arrIncomingCount[key] = value.INCOMING_COUNT;
						arrBotCount[key] = value.BOT_COUNT;
						arrBotCSRcount[key] = value.BOT_CSR_CNT;
						arrEtcCount[key] = value.ETC_CNT;
						arrGiveUpCount[key] = value.GIVE_UP_COUNT;
						arrFollowUpCallCount[key] = value.FOLLOW_UP_CALL_COUNT;	
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
									data: arrIncomingCount,
								}, {
									label: '<spring:message code="A0227" text="Bot응대"/>',
									fill: false,
									backgroundColor: window.chartColors.orange,
									borderColor: window.chartColors.orange,
									data:arrBotCount,
								}, {
									label: '<spring:message code="A0022" text="Bot+CSR"/>',
									fill: false,
									backgroundColor: window.chartColors.yellow,
									borderColor: window.chartColors.yellow,
									data: arrBotCSRcount,
								}, {
									label: 'ETC',
									fill: false,
									backgroundColor: window.chartColors.green,
									borderColor: window.chartColors.green,
									data: arrEtcCount,
								}, {
									label: '<spring:message code="A0231" text="포기호"/>',
									fill: false,
									backgroundColor: window.chartColors.blue,
									borderColor: window.chartColors.blue,
									data: arrGiveUpCount,
								}, {
									label: '<spring:message code="A0233" text="Follow-up call"/>',
									fill: false,
									backgroundColor: window.chartColors.purple,
									borderColor: window.chartColors.purple,
									data: arrFollowUpCallCount,
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
										ticks :{
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
			onSortCol : function(iCol, index, sortOrder){
				// grid sort
				if(iCol == "DATE"){
					$.jgrid.gridUnload('#jqGrid_excel');
					groupSort = sortOrder;
					createJqGrid();
					gridSearch($("#cPage").val(), "N");
				}
				
				if(iCol == "DETAIL_TIME"){
					groupDateSort = sortOrder;
					gridSearch($("#cPage").val(), "N");
				}
				
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
}

function dateTimePickerResetting(dateType) {
	var fromDatePicker = $('#fromDate').data('datetimepicker');
	var toDatePicker = $('#toDate').data('datetimepicker');
	if(dateType == "30min") {
		fromDatePicker.startViewMode = 2;
		fromDatePicker.viewMode = 2;
		fromDatePicker.minView = 0;
		fromDatePicker.minuteStep = 30;
		fromDatePicker.viewSelect = 1;
		fromDatePicker.setFormat("yyyy-mm-dd hh:ii")
		toDatePicker.startViewMode = 2;
		toDatePicker.viewMode = 2;
		toDatePicker.minView = 0;
		toDatePicker.minuteStep = 30;
		toDatePicker.viewSelect = 1;
		toDatePicker.setFormat("yyyy-mm-dd hh:ii")
		
	} else if(dateType == "hourly") {
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
	$.ajax({url : "${pageContext.request.contextPath}/getCompanyIdList",
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
			
			createJqGrid();
			gridSearch(1);
			
		}else {
			alert("<spring:message code='A0333' text='CompanyId가 존재하지 않습니다.' />");
		}
		
	}).fail(function(result) {
		console.log("ajax connection error: getCompanyIdList");
	});
}

function gridSearch(currentPage, excelYn) {
	// search validation check
	if(!searchCheck()) {
		return false;
	}
	
	var obj = new Object();
	obj.checkBox1 = $("input[name=checkBox1]:checked").val(); // 검색유형   / hourly / daily / monthly
	obj.checkBox3 = $("input[name=checkBox3]:checked").val(); // 제외여부 
	obj.fromDate = $("#fromDate").val();
	obj.toDate =  $("#toDate").val();
	obj.dateSort = groupSort;
	obj.dateDetailSort = groupDateSort;
	obj.companyId = $("#companyIdSelect option:selected").val();
	
	if(excelYn != "Y"){
		obj.page = currentPage;	
		obj.lastpage =  $('#jqGrid').getGridParam('lastpage'); 
		obj.rowNum = jQuery("#jqGrid").getGridParam('rowNum'); 
		obj.allRecords = jQuery("#jqGrid").getGridParam('records');
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
				includeGroupHeader : false,
				includeFooter: false,
				fileName : "<spring:message code='A0403' text='I/B 콜 통계'/>.xlsx",
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
	var chartBoxHeight = $(".chartBox").outerHeight(true);
	var resizeHeight = $("#container").height() - searchBoxHeight - gridSubHeight - chartBoxHeight; // 전체 container높이  - 검색박스높이 - 그리드(헤더,페이지,margin)높이 - 차트박스높이

	
	// 그리드의 width를 div 에 맞춰서 적용
	$('#jqGrid').setGridWidth( resizeWidth , true);
	$('#jqGrid').setGridHeight( resizeHeight , true);
	$('#jqGrid').css("width", '');
}

</script>

</body>
</html>
