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

<body class="gcsWrap">
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
	<input type="hidden" id="headerName" value="${_csrf.headerName}" />
    <input type="hidden" id="token" value="${_csrf.token}" />
		<!-- #header -->
		<jsp:include page="../common/inc_header.jsp">
			<jsp:param name="titleCode" value="A0405" />
			<jsp:param name="titleTxt" value="O/B 콜 이력조회" />
		</jsp:include>
		<!-- //#header -->
		<!-- #container -->
		<div id="container">
			<div id="contents">
				<!-- .content -->
				<div class="content">
					<!-- 검색조건 -->
					<div class="srchArea">
						<input type="hidden" id="cPage" value="1" />
						<input type="hidden" id="firstTime" />
						<input type="hidden" id="listRnum" />
						<input type="hidden" id="inspectYn" value="false" />
						<button type="button" class="btnS_line tbody_folding_toggle"><spring:message code="A0341" text="상세검색" /></button>
						<form id="searchForm">
							<table class="tbl_line_view" id="callSearchTable"
								summary="검색일시/총응대시간/제외여부/음성봇명/상담유형/회선번호/상담사/고객명/통화시간/봇,상담사 응대시간/대화이력으로 구성됨">
								<caption class="hide">검색조건</caption>
								<colgroup>
									<col width="100">
									<col>
									<col width="100">
									<col width="450">
									<col width="100">
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
										<th scope="row"><spring:message code="A0177" text="검색일시" /></th>
										<td>
											<div class="iptBox">
												<input type="text" name="fromDate" id="fromDate" class="ipt_dateTime" autocomplete="off">
												<span>-</span>
												<input type="text" name="toDate" id="toDate" class="ipt_dateTime" autocomplete="off">
											</div>
											<div class="checkBox">
												<input type="checkbox" name="ipt_check3_2" id="ipt_check3_2" class="ipt_check" checked>
												<label for="ipt_check3_2"><spring:message code="A0209" text="일 단위" /></label>
											</div>
										</td>
										<th><spring:message code="A0175" text="제외여부" /></th>
										<td>
											<div class="checkBox">
												<input type="checkbox" name="checkBox3" id="ipt_check3_1" value="exception" class="ipt_check" checked="checked">
												<label for="ipt_check3_1"><spring:message code="A0176" text="주말 제외" /></label>
											</div>
										</td>
									</tr>
								</tbody>
								<tbody class="tbody_folding hide">
									<tr>
										<th><spring:message code="A0335" text="음성봇명" /></th>
										<td id="multiple">
											<select id="multiple_select" class="select" multiple="multiple">
											</select>
										</td>
										<th><spring:message code="A0336" text="상담유형" /></th>
										<td>
											<div class="iptBox">
												<input type="text" class="ipt_txt" autocomplete="off" id="consultType" name="consultType">
											</div>
										</td>
										<th><spring:message code="A0173" text="총응대시간" /></th>
										<td>
											<div class="iptBox">
												<input type="text" class="ipt_txt" id="duration" name="duration">
												<span><spring:message code="A0174" text="초 이상" /></span>
											</div>
										</td>
									</tr>
									<tr>
										<th><spring:message code="A0337" text="회선번호" /></th>
										<td>
											<div class="iptBox">
												<input type="text" class="ipt_txt" autocomplete="off" id="sipAccount" name="sipAccount">
											</div>
										</td>
										<th><spring:message code="A0168" text="상담사" /></th>
										<td>
											<div class="iptBox">
												<input type="text" class="ipt_txt" autocomplete="off" id="custOpId" name="custOpId">
											</div>
										</td>
										<th><spring:message code="A0325" text="고객명" /></th>
										<td>
											<div class="iptBox">
												<input type="text" class="ipt_txt" autocomplete="off" id="custNm" name="custNm">
											</div>
										</td>
									</tr>
									<tr>
										<th>통화결과</th>
										<td>
											<select id="multiple_callResult" class="select" multiple="multiple">
												<option value="success">SUCCESS</option>
												<option value="fail">FAIL</option>
												<option value="null">-</option>
											</select>
										</td>
										<th>안내결과</th>
										<td>
											<select id="multiple_guideResult" class="select" multiple="multiple">
												<option value="success">SUCCESS</option>
												<option value="fail">FAIL</option>
												<option value="null">-</option>
											</select>
										</td>
										<th>검수결과</th>
										<td>
											<select id="multiple_inspectResult" class="select" multiple="multiple">
												<option value="success">SUCCESS</option>
												<option value="fail">FAIL</option>
												<option value="null">-</option>
											</select>
										</td>
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
							<a href="#" class="btnS_basic" onclick="handleResultDownload()" style="vertical-align: top;">
								결과 값 다운로드
							</a>
						</div>
					</div>
					<!-- //검색조건 -->

					<!-- .jqGridBox -->
					<div class="jqGridBox">
						<table id="jqGrid"></table>
						<div id="jqGridPager"></div>
					</div>
					<div style="display: none;">
						<table id="jqGrid_excel"></table>
						<div id="jqGrid_excel_Pager"></div>
					</div>
					<!-- //.jqGridBox -->
				</div>
			</div>
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

	<!-- ===== layer popup ===== -->
	<!-- 추가 200622 콜 이력 상세보기 -->
	<div id="lyr_history" class="lyrBox">
		<div class="lyr_top">
			<h3><spring:message code="A0339" text="대화이력" /></h3>
			<button class="btn_lyr_close">닫기</button>
		</div>
		<div class="lyr_mid" style="max-height: 655px;">
			<div class="call_detail">
				<dl class="dlBox2">
					<dt>Call ID</dt>
					<dd id="detail_callId"></dd>
				</dl>
				<dl class="dlBox2">
					<dt>Voice Bot</dt>
					<dd id="detail_sipName"></dd>
				</dl>
				<dl class="dlBox2">
					<dt>Customer Name</dt>
					<dd id="detail_custNm"></dd>
				</dl>
				<dl class="dlBox2">
					<dt>CS type</dt>
					<dd id="detail_consultType"></dd>
				</dl>
				<dl class="dlBox2">
					<dt>Start Date</dt>
					<dd id="detail_startDt"></dd>
				</dl>
			</div>

			<div class="callView">
				<div class="callView_cont">
					<!-- .cont_cell -->
					<div class="cont_cell">
						<div class="chatUI_mid">
							<ul class="lst_talk">
							</ul>
						</div>
					</div>
					<!-- //.cont_cell -->
					<!-- .cont_cell -->
					<div class="cont_cell">
						<div class="tabBox">
							<ul class="lst_tab">
<%--								<li><a class="active">0000</a></li>--%>
<%--								<li><a>0000</a></li>--%>
<%--								<li><a>0000</a></li>--%>
							</ul>
						</div>
						<div class="tbl_customTd scroll">
							<table class="tbl_line_lst" summary="번호/구간/탐지로 구성됨">
								<caption class="hide">탐지내용</caption>
								<colgroup>
									<col width="40">
									<col>
									<col width="70">
								</colgroup>
								<thead>
									<tr>
										<th scope="col"><spring:message code="A0093" text="번호" /></th>
										<th scope="col"><spring:message code="A0094" text="구간" /></th>
										<th scope="col"><spring:message code="A0095" text="탐지" /></th>
									</tr>
								</thead>
								<tbody class="intent_tbody">
								</tbody>
							</table>

                            <dl class="inspect_desc">
                                <dt>검수 내용</dt>
                                <dd>
                                    <textarea id="inspectText" cols="40" rows="4"></textarea>
                                    <p id="inspectTd"></p>

                                    <div class="radioBox fl">
                                        <input type="radio" id="inspectBtn1" name="inspect"
                                               value="완료">
                                        <label for="inspectBtn1" style="cursor: default;">완료</label>
                                        <input type="radio" id="inspectBtn2" name="inspect"
                                               value="미완료">
                                        <label for="inspectBtn2"
                                               style="cursor: default;">미완료</label>
                                    </div>
                                    <button type="button" class="btnS_basic fr" id="saveInspect"
                                            onclick="saveInspect()">저장
                                    </button>
                                </dd>
                            </dl>
						</div>
					</div>
					<!-- //.cont_cell -->
				</div>
			</div>
			<!-- //.callView -->

			<div class="player">
				<audio controls autoplay>
					<source src="" type="audio/x-wav">
				</audio>
			</div>
		</div>
	</div>

	<!-- 추가 221012 캠페인 리스트 보기 및 고객 결과 값 다운로드 -->
	<div id="download_result" class="lyrBox">
		<div class="lyr_top">
			<h3><spring:message code="A0339" text="고객 결과 값 다운로드" /></h3>
			<button class="btn_lyr_close">닫기</button>
		</div>
		<div class="lyr_mid" style="max-height: 655px;">
			<div class="tbl_customTd scroll">
				<table class="tbl_bg_lst" summary="번호/캠페인 명으로 구성됨">
					<caption class="hide">캠페인 리스트</caption>
					<colgroup>
						<col width="50">
						<col>
					</colgroup>
					<thead>
					<tr>
						<th>번호</th>
						<th>캠페인 명</th>
					</tr>
					</thead>
					<tbody class="campaign_lst">
					</tbody>
				</table>
			</div>

		</div>
		<div class="lyr_btm">
			<div class="btnBox sz_small">
				<button type="button" id="download_confirm">다운로드</button>
				<button type="button" class="btn_lyr_close">닫기</button>
			</div>

		</div>
	</div>

<%@ include file="../common/inc_footer.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/setColWidth.js"></script>
<!-- script -->
<script type="text/javascript">
var recGroupSort = "desc";
var recSort = "desc";
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
	$('#ipt_check3_2').click(function(){
		dateTimePickerResetting($(this).is(":checked"));
	});

	//추가 AMR 200623 검색 박스 테이블 접기/펴기
	$('.tbody_folding_toggle').on('click', function(){
		setTimeout(() => {
			$('.tbody_folding').toggleClass('hide')
			scResize();
		}, 100);
	});

	dateTimePickerResetting($("#ipt_check3_2").is(":checked"));
	getCompanyId();

	$("#search").on("click", function(){
		$("#cPage").val(1);
		$.jgrid.gridUnload('#jqGrid');
		createColumn();
		gridSearch(1);
	});

	//다운로드 클릭시 엑셀다운로드
	$("#export").on("click", function(e){
		if(excelExport == false){
			excelExport = true;
			$.jgrid.gridUnload('#jqGrid_excel');
			createColumn('inspect');
			gridSearch(1, "Y");
		} else {
			alert('<spring:message code="A0340" text="Excel 다운로드가 진행 중입니다." />');
		}
	});

	$("#companyIdSelect").on("change", function() {
		getCampaignList(this.value);
	});

	$('#multiple_callResult').multiselect({
		includeSelectAllOption: true,
	});

	$('#multiple_guideResult').multiselect({
		includeSelectAllOption: true,
	});

	$('#multiple_inspectResult').multiselect({
		includeSelectAllOption: true,
	});

	$("input:radio[name='inspect']").click(function (){
		var count = $("input:radio[name='inspect']:checked").length;
		if (count > 0) {
			$("#saveInspect").attr("disabled", false);
		}
	});

});

function createJqGrid() {
	var useGrouping = $("#ipt_check3_2").is(":checked");
	var groupSort = recGroupSort;
	 //jqGrid
	var gridOption = {
			url: "${pageContext.request.contextPath}/getStatsRecordJQList",
			datatype: "local",
			mtype: "POST",
		  autowidth: false,
			ajaxGridOptions: { contentType: "application/json" },
			loadBeforeSend: function(jqXHR) {
				jqXHR.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
			},
			colNames:[
				'<spring:message code="A0135" text="NO."/>',
				'<spring:message code="A0225" text="날짜"/>',
				'<spring:message code="A0188" text="응대시작시간"/>',
				'<spring:message code="A0335" text="음성봇명"/>',
				'<spring:message code="A0336" text="상담유형"/>',
				'<spring:message code="A0337" text="회선번호"/>',
				'<spring:message code="A0168" text="상담사"/>',
				'<spring:message code="A0325" text="고객명"/>',
				'<spring:message code="A0251" text="통화시간"/>',
				'<spring:message code="A0338" text="봇/상담사 응대시간"/>',
				'통화결과',
				'통화 상태값',
				'안내결과',
				// '검수체크',
				'검수결과',
				'Task 감지',
				'<spring:message code="A0339" text="대화이력"/>',
				'callId',
				'contractNo',
				'campaignId',
				'callTypeCode',
			],
			colModel:[
				{name:'RNUM', index:'RNUM', width:30, align:'center', sortable: false, formatter:rowNumber},
				{name:'DAILY', index:'DAILY', width:130, align:'center', sorttype:'date'},
				{name:'START_TIME', index:'START_TIME', width:130, align:'center', sorttype:'date'},
				{name:'SIP_NAME', index:'SIP_NAME', width:100, align:'center', sortable: false},
				{name:'CONSULT_TYPE',index:'CONSULT_TYPE', width:70, align:'center', sortable: false, hidden:true},
				{name:'SIP_ACCOUNT', index:'SIP_ACCOUNT', width:100, align:'center', sortable: false},
				{name:'CUST_OP_ID', index:'CUST_OP_ID', width:70, align:'center', sortable: false},
				{name:'CUST_NM', index:'CUST_NM', width:100, align:'center', sortable: false},
				{name:'DURATION', index:'DURATION', width:70, align:'center', sortable: false},
				{name:'BOT_CSR_DURATION', index:'BOT_DURATION', width:70, align:'center', sortable: false, hidden:true},
				{name:'IS_CALL_SUCC', index:'IS_CALL_SUCC', width:70, align:'center', sortable: false},
				{name:'CALL_STATUS_VALUE', index:'CALL_STATUS_VALUE', width:70, align:'center', sortable: false, hidden:true},
				{name:'IS_GUIDE_SUCC', index:'IS_GUIDE_SUCC', width:70, align:'center', sortable: false},
				// {name:'checkIntent', index:'checkIntent', width:70, align:'center', sortable: false, formatter:convertCheckIntentTxt},
				{name:'IS_INSPECT_SUCC', index:'IS_INSPECT_SUCC', width:70, align:'center', sortable: false},
				{name:'TASK_INFO', index:'TASK_INFO', width:70, align:'center', sortable: false, hidden:true},
				{name:'CONVERSATION_HISTORY', index:'CONVERSATION_HISTORY', width:70, align:'center', sortable: false, formatter:addButton},
				{name:'CALL_ID',index:'CALL_ID', width:70, align:'center', sortable: false, hidden:true},
				{name:'CONTRACT_NO',index:'CONTRACT_NO', width:70, align:'center', sortable: false, hidden:true},
				{name:'CAMPAIGN_ID',index:'CAMPAIGN_ID', width:70, align:'center', sortable: false, hidden:true},
				{name:'CALL_TYPE_CODE',index:'CALL_TYPE_CODE', width:70, align:'center', sortable: false, hidden:true}
			],
			pager: "#jqGridPager",
			grouping: useGrouping,
			groupingView : {
				groupField : ['DAILY'],
				groupSummary : [true],
				groupColumnShow : [true],
				groupText : ['<b>{0}</b>'],
				groupOrder: [groupSort]
			},
			loadonce: false,
			viewrecords: true,
			gridview: true,
			footerrow: false,
			rowNum: 30,
			userDataOnFooter: false, // use the userData parameter of the JSON response to display data on footer
			jsonReader : {
				repeatitems: false,
				page: "page",	// 현제 페이지, 하단의 navi에 출력됨.
				total: "total",	// 총 페이지 수
				records: "record",
				root: "rows",
			},
			onPaging: function(pgButton){	 //페이징 처리
				var gridPage = $("#jqGrid").getGridParam("page");				// 현재 페이지 번호
				var rowNum = $("#jqGrid").getGridParam("rowNum");				// 뿌려줄 row 개수
				var records = $("#jqGrid").getGridParam("records");				// 현재 레코드 갯수
				var totalPage = Math.ceil(records/rowNum);						// 토탈갯수

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
					var nowPage = Number($("pager .ui-pg-input").val());

					if (totalPage >= nowPage && nowPage > 0) {
						gridPage = nowPage;
					} else {
						$("#pager .ui-pg-input").val(page);
						gridPage = page;
					}
				} else if (pgButton == "records") {
					gridPage = 1;
				}

				$("#cPage").val(gridPage);
				gridSearch(gridPage);
			},
			loadComplete : function(data){
				$("#inspectYn").val("false");
				$(".ui-pg-input").attr("readonly", true);

				$('.btn_lyr_open').on('click',function(){
					var winHeight = $(window).height()*0.7,
						hrefId = $(this).attr('href');

					$('body').css('overflow','hidden');
					$('body').find(hrefId).wrap('<div class="lyrWrap"></div>');
					$('body').find(hrefId).before('<div class="lyr_bg"></div>');

					//대화 UI
					$('.lyrBox .lyr_mid').each(function(){
						$(this).css('max-height', Math.floor(winHeight) +'px');
					});
					//Layer popup close
					$('.btn_lyr_close, .lyr_bg').on('click',function(){
						$(".player").empty();
						$('body').css('overflow','');
						$('body').find(hrefId).unwrap();
						//'<div class="lyrWrap"></div>'
						$('.lyr_bg').remove();
					});
				});
				setColumnWidth();
			},
			/* grouping:true */
			onSortCol : function(iCol, index, sortOrder){

				// grid sort
				if(iCol == "DAILY"){
					recGroupSort = sortOrder;
				}else if(iCol == "START_TIME"){
					recSort = sortOrder;
				}
				createJqGrid();
				gridSearch($("#cPage").val(), "N");

				return "stop";
			}
		};

	$("#jqGrid").jqGrid(gridOption);
	gridOption.pager = "#jqGrid_excel_Pager";
	$("#jqGrid_excel").jqGrid(gridOption);

	if($("#ipt_check3_2").is(":checked") == true){
		$("#jqGrid").jqGrid('showCol', ["DAILY"]);
// 		$("#jqGrid").jqGrid('hideCol', ["RNUM"]);
		$("#jqGrid_excel").jqGrid('showCol', ["DAILY"]);
		$("#jqGrid_excel").jqGrid('hideCol', ["RNUM"]);
	} else {
		$("#jqGrid").jqGrid('hideCol', ["DAILY"]);
		$("#jqGrid").jqGrid('showCol', ["RNUM"]);
		$("#jqGrid_excel").jqGrid('hideCol', ["DAILY"]);
		$("#jqGrid_excel").jqGrid('hiedCol', ["RNUM"]);
	}

	// 엑셀 버튼항목 숨기기
	$("#jqGrid_excel").jqGrid('hideCol', ["CONVERSATION_HISTORY"]);

	// 페이지 수정막기
	$(".ui-pg-input").attr("readonly", true);
	scResize();
}

function onKeyDown() {
	if(event.keyCode == 13)
	{
		$("#cPage").val(1);
		$.jgrid.gridUnload('#jqGrid');
		createColumn();
		gridSearch(1);
	}
}

function createColumn(type) {
	var colNames = [];
	var colModels = [];
	colNames.push('<spring:message code="A0135" text="NO."/>',
			'<spring:message code="A0225" text="날짜"/>',
			'<spring:message code="A0188" text="응대시작시간"/>',
			'<spring:message code="A0335" text="음성봇명"/>',
			'<spring:message code="A0336" text="상담유형"/>',
			'<spring:message code="A0337" text="회선번호"/>',
			'<spring:message code="A0168" text="상담사"/>',
			'<spring:message code="A0325" text="고객명"/>');
	colModels.push({name:'RNUM', index:'RNUM', width:30, align:'center', sortable: false, formatter:rowNumber});
	colModels.push({name:'DAILY', index:'DAILY', width:130, align:'center', sorttype:'date'});
	colModels.push({name:'START_TIME', index:'START_TIME', width:130, align:'center', sorttype:'date'});
	colModels.push({name:'SIP_NAME', index:'SIP_NAME', width:100, align:'center', sortable: false});
	colModels.push({name:'CONSULT_TYPE',index:'CONSULT_TYPE', width:70, align:'center', sortable: false, hidden:true});
	colModels.push({name:'SIP_ACCOUNT', index:'SIP_ACCOUNT', width:100, align:'center', sortable: false});
	colModels.push({name:'CUST_OP_ID', index:'CUST_OP_ID', width:70, align:'center', sortable: false});
	colModels.push({name:'CUST_NM', index:'CUST_NM', width:100, align:'center', sortable: false});
	var searchColLeng = $("input[name='searchColumn']").length;
	for (var i=0; i<searchColLeng; i++) {
		var colName = $("input[name='searchColumn']").eq(i).attr('id');
		var colValue = $("input[name='searchColumn']").eq(i).val();
		colNames.push(colName);
		colModels.push({name:colName,index:colName, align:'center', sortable: false});

	}

	var checkCol = $(".selectColumn");
	var col;
	$.each(checkCol, function(i, v){
			col = v.name;
			colNames.push(col);
			colModels.push({name:col,index:col, align:'center', sortable: false});
	});

	colModels.push({name:'DURATION', index:'DURATION', width:70, align:'center', sortable: false});
	colModels.push({name:'BOT_CSR_DURATION', index:'BOT_DURATION', width:70, align:'center', sortable: false, hidden:true});
	colModels.push({name:'IS_CALL_SUCC', index:'IS_CALL_SUCC', width:70, align:'center', sortable: false});
	colModels.push({name:'CALL_STATUS_VALUE', index:'CALL_STATUS_VALUE', width:70, align:'center', sortable: false, hidden:true});
	colModels.push({name:'IS_GUIDE_SUCC', index:'IS_GUIDE_SUCC', width:70, align:'center', sortable: false});
	// colModels.push({name:'checkIntent', index:'checkIntent', width:70, align:'center', sortable: false, formatter:convertCheckIntentTxt});
	colModels.push({name:'IS_INSPECT_SUCC', index:'IS_INSPECT_SUCC', width:70, align:'center', sortable: false});
	colModels.push({name:'TASK_INFO', index:'TASK_INFO', width:70, align:'center', sortable: false, hidden:true});
	colModels.push({name:'CONVERSATION_HISTORY', index:'CONVERSATION_HISTORY', width:70, align:'center', sortable: false, formatter:addButton});
	colModels.push({name:'CALL_ID',index:'CALL_ID', width:70, align:'center', sortable: false, hidden:true});
	colModels.push({name:'CONTRACT_NO',index:'CONTRACT_NO', width:70, align:'center', sortable: false, hidden:true});
	colModels.push({name:'CAMPAIGN_ID',index:'CAMPAIGN_ID', width:70, align:'center', sortable: false, hidden:true});
	colModels.push({name:'CALL_TYPE_CODE',index:'CALL_TYPE_CODE', width:70, align:'center', sortable: false, hidden:true});

	colNames.push('<spring:message code="A0251" text="통화시간"/>',
			'<spring:message code="A0338" text="봇/상담사 응대시간"/>',
			'통화결과',
			'통화 상태값',
			'안내결과',
			// '검수체크',
			'검수결과',
			'Task 감지',
			'<spring:message code="A0339" text="대화이력"/>',
			'callId',
			'contractNo',
			'campaignId',
			'callTypeCode');

	createSearchJqGrid(colNames, colModels);
}

function createSearchJqGrid(colNames, colModels) {
	var useGrouping = $("#ipt_check3_2").is(":checked");
	var groupSort = recGroupSort;
	//jqGrid
	var gridOption = {
		url: "${pageContext.request.contextPath}/getStatsRecordJQList",
		datatype: "local",
		mtype: "POST",
		autowidth: false,
		ajaxGridOptions: { contentType: "application/json" },
		loadBeforeSend: function(jqXHR) {
			jqXHR.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
		},
		colNames: colNames,
		colModel: colModels,
		pager: "#jqGridPager",
		grouping: useGrouping,
		groupingView : {
			groupField : ['DAILY'],
			groupSummary : [true],
			groupColumnShow : [true],
			groupText : ['<b>{0}</b>'],
			groupOrder: [groupSort]
		},
		loadonce: false,
		viewrecords: true,
		gridview: true,
		footerrow: false,
		rowNum: 30,
		userDataOnFooter: false, // use the userData parameter of the JSON response to display data on footer
		jsonReader : {
			repeatitems: false,
			page: "page",	// 현제 페이지, 하단의 navi에 출력됨.
			total: "total",	// 총 페이지 수
			records: "record",
			root: "rows",
		},
		onPaging: function(pgButton){	 //페이징 처리
			var gridPage = $("#jqGrid").getGridParam("page");				// 현재 페이지 번호
			var rowNum = $("#jqGrid").getGridParam("rowNum");				// 뿌려줄 row 개수
			var records = $("#jqGrid").getGridParam("records");				// 현재 레코드 갯수
			var totalPage = Math.ceil(records/rowNum);						// 토탈갯수

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
				var nowPage = Number($("pager .ui-pg-input").val());

				if (totalPage >= nowPage && nowPage > 0) {
					gridPage = nowPage;
				} else {
					$("#pager .ui-pg-input").val(page);
					gridPage = page;
				}
			} else if (pgButton == "records") {
				gridPage = 1;
			}

			$("#cPage").val(gridPage);
			gridSearch(gridPage);
		},
		loadComplete : function(data){
			$(".ui-pg-input").attr("readonly", true);

			$('.btn_lyr_open').on('click',function(){
				var winHeight = $(window).height()*0.7,
						hrefId = $(this).attr('href');

				$('body').css('overflow','hidden');
				$('body').find(hrefId).wrap('<div class="lyrWrap"></div>');
				$('body').find(hrefId).before('<div class="lyr_bg"></div>');

				//대화 UI
				$('.lyrBox .lyr_mid').each(function(){
					$(this).css('max-height', Math.floor(winHeight) +'px');
				});
				//Layer popup close
				$('.btn_lyr_close, .lyr_bg').on('click',function(){
					$(".player").empty();
					$('body').css('overflow','');
					$('body').find(hrefId).unwrap();
					//'<div class="lyrWrap"></div>'
					$('.lyr_bg').remove();
				});
			});
			setColumnWidth();
		},
		/* grouping:true */
		onSortCol : function(iCol, index, sortOrder){

			// grid sort
			if(iCol == "DAILY"){
				recGroupSort = sortOrder;
			}else if(iCol == "START_TIME"){
				recSort = sortOrder;
			}
			createJqGrid();
			gridSearch($("#cPage").val(), "N");

			return "stop";
		}
	};

	$("#jqGrid").jqGrid(gridOption);
	gridOption.pager = "#jqGrid_excel_Pager";
	$("#jqGrid_excel").jqGrid(gridOption);

	if($("#ipt_check3_2").is(":checked") == true){
		$("#jqGrid").jqGrid('showCol', ["DAILY"]);
// 		$("#jqGrid").jqGrid('hideCol', ["RNUM"]);
		$("#jqGrid_excel").jqGrid('showCol', ["DAILY"]);
		$("#jqGrid_excel").jqGrid('hideCol', ["RNUM"]);
	} else {
		$("#jqGrid").jqGrid('hideCol', ["DAILY"]);
		$("#jqGrid").jqGrid('showCol', ["RNUM"]);
		$("#jqGrid_excel").jqGrid('hideCol', ["DAILY"]);
		$("#jqGrid_excel").jqGrid('hideCol', ["RNUM"]);
	}

	// 엑셀 버튼항목 숨기기
	$("#jqGrid_excel").jqGrid('hideCol', ["CONVERSATION_HISTORY"]);

	// 페이지 수정막기
	$(".ui-pg-input").attr("readonly", true);
	scResize();
}

function dateTimePickerResetting(dateType) {
	var fromDatePicker = $('#fromDate').data('datetimepicker');
	var toDatePicker = $('#toDate').data('datetimepicker');
	if(dateType == false) {
		fromDatePicker.startViewMode = 2;
		fromDatePicker.viewMode = 2;
		fromDatePicker.minView = 0;
// 		fromDatePicker.minuteStep = 30;
		fromDatePicker.viewSelect = 1;
		fromDatePicker.setFormat("yyyy-mm-dd hh:ii")
		toDatePicker.startViewMode = 2;
		toDatePicker.viewMode = 2;
		toDatePicker.minView = 0;
// 		toDatePicker.minuteStep = 30;
		toDatePicker.viewSelect = 1;
		toDatePicker.setFormat("yyyy-mm-dd hh:ii")

	} else if(dateType == true) {
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

			getCampaignList(result[0].companyId);
			createJqGrid();
			gridSearch(1);

		}else {
			alert("<spring:message code='A0333' text='CompanyId가 존재하지 않습니다.' />");
		}

	}).fail(function(result) {
		console.log("ajax connection error: getCompanyIdList");
	});
}

function getCampaignList(companyId) {

	var obj = new Object();
	obj.companyId = companyId;
	obj.pageType = "outbound";
	$.ajax({
		url : "${pageContext.request.contextPath}/getRecordCampaignList",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		var campaignList = result.campaignList;
		$('#multiple').empty();
		// $("#multiple_select").multiselect("clearSelection");
		var innerHTML = "";
		if(campaignList != null && campaignList != ""){
			innerHTML += '<select id="multiple_select" class="select" multiple="multiple" onchange="changeCampaign(this.value);">';
			for(var i = 0; i < campaignList.length; i++){
				innerHTML += '<option value="' + campaignList[i].CAMPAIGN_ID + '">' + campaignList[i].CAMPAIGN_NM + '</option>';
			}
			innerHTML += '</select>'
			$("#multiple").append(innerHTML);
		}
		$('#multiple_select').multiselect({
			includeSelectAllOption: true,
		});

	}).fail(function(result) {
		console.log("ajax connection error: getIVRMonitoringDetail");
	});
}

function changeCampaign() {
	var campaignId = "";
	if($("#multiple_select").val() != "" && $("#multiple_select").val() != null && $("#multiple_select option:selected").length > 0) {
		$.each($("#multiple_select").val(), function(i, v){
			if( i == 0){
				campaignId = v;
			}else{
				campaignId = "";
			}
		});
	}

	var obj = new Object();
	obj.CAMPAIGN_ID = campaignId;

	$.ajax({
		url : "${pageContext.request.contextPath}/getSearchColumn",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		var colList = result.colList;
		var cnt = 1;
		$("#dynamicInfo").remove();
		var innerHTML = "";
		var multipleCnt = 0;
		innerHTML += '<tbody id="dynamicInfo">';

		$.each(colList, function(i, v){
			var obj = [];

			obj.push(v.columnKor);
			obj.push(v.dataType);
			obj.push(v.columnEng);
			if (v.caseType != null && v.caseType != "") {
				var caseTypeArr = v.caseType.split(',');
			}

			$.each(obj, function(j, jv){
				if(obj[j] == null || obj[j] == "undefined"){
					obj[j] = "";
				}
			});
			if (cnt%3 == 1) {
				innerHTML += '<tr>';
			}
			if (obj[1] == 'radiobox' || obj[1] == 'selectbox') {
				innerHTML += '<th scope="row">'+obj[0]+'</th>';
				innerHTML += '<td id="multiple'+multipleCnt+'">';
				innerHTML += '<select id="multiple_select'+multipleCnt+'" name="'+ obj[0] +'" class="selectColumn" multiple="multiple">';
				for (var j = 0; j < caseTypeArr.length; j++) {
                    innerHTML += '<option value="' + caseTypeArr[j] + '">' + caseTypeArr[j] + '</option>';
				}
                innerHTML += '</select>';
				innerHTML += '</td>';
				multipleCnt++;
			}
			if (obj[1] == 'int' || obj[1] == 'string' || obj[1] == 'float' || obj[1] == 'date') {
				innerHTML += '<th>'+obj[0]+'</th>';
				innerHTML += '<td>';
				innerHTML += '<div class="iptBox">';
				innerHTML += '<input type="text" id="'+obj[0]+'" class="ipt_txt" autocomplete="off" name="searchColumn" onkeydown="onKeyDown()">';
				innerHTML += '</div>';
				innerHTML += '</td>';
			}
			if (cnt%3 == 0) {
				innerHTML += '</tr>';
			}
			cnt++;
		});

		innerHTML += '</tbody>';
		$("#callSearchTable").append(innerHTML);

		$('.ipt_checkbox_allCheck').on('click',function(){
			var iptCheckboxAllCheck = $(this).is(":checked");
			if ( iptCheckboxAllCheck ) {
				$(this).siblings('input:checkbox').prop('checked', true);
			} else {
				$(this).siblings('input:checkbox').prop('checked', false);
			}
		});

		for (var i = 0; i < multipleCnt; i++) {
          $('#multiple_select'+i).multiselect({
            includeSelectAllOption: true,
          });
        }

	}).fail(function(result) {
		console.log("ajax connection error: getIVRMonitoringDetail");
	});
}

function gridSearch(currentPage, excelYn) {

	if(!searchCheck()) {
		return false;
	}

	var endPageCnt = jQuery("#jqGrid").getGridParam('records').toString();

	var obj = new Object();
	obj.checkBox3 = $("input[name=checkBox3]:checked").val();
	obj.duration = $("#duration").val();
	obj.ipt_check3_1 = "on";
	obj.toDate =  $("#toDate").val();
	obj.fromDate = $("#fromDate").val();
	obj.sipName = $("#multiple_select").val();
	obj.consultType = $("#consultType").val();
	obj.sipAccount = $("#sipAccount").val();
	obj.custOpId = $("#custOpId").val();
	obj.custNm = $("#custNm").val();
	obj.callResult = $("#multiple_callResult").val();
	obj.guideResult = $("#multiple_guideResult").val();
    obj.inspectResult = $("#multiple_inspectResult").val();
	obj.excelYn = excelYn == "Y"? excelYn : "N";
	obj.groupSortOrder = recGroupSort;
	obj.sortOrder = recSort;
	obj.daily = $("#ipt_check3_2").is(":checked");
	obj.pageType = "outbound";
	obj.companyId = $("#companyIdSelect option:selected").val();
	
	obj.inspectYn = $("#inspectYn").val();
	if($("#inspectYn").val() == "true"){
		obj.listRnum = $("#listRnum").val();
	}
	
	var searchColLeng = $("input[name='searchColumn']").length;
	for (var i=0; i<searchColLeng; i++) {
		var colName = $("input[name='searchColumn']").eq(i).attr('id');
		var colValue = $("input[name='searchColumn']").eq(i).val();
		if (colValue != null && colValue != "") {
			obj[colName] = colValue;
		}

	}
	var checkCol = $(".selectColumn");
	var colStore;
	var colValue;
	var val;
	var campaignId;
    $.each(checkCol, function(i, v){
		$.each($("#multiple_select"+i).val(), function(j, z){
			if( j == 0){
				campaignId = z;
				val = v.name;
			}else{
				campaignId = campaignId + "," + z;
			}
		});
		obj[val] = campaignId;
    });

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
		$("#inspectYn").val("false");
	}else{
		$("#jqGrid").setGridParam({loadonce:false, datatype	: "json",postData	: JSON.stringify(obj)}).trigger("reloadGrid");
		$("#inspectYn").val("false");
	}
}

function getRecordDetail(rowId, callId, contractNo, campaignId, RNUM) {
	
	$("#listRnum").val(RNUM);
	$("#inspectYn").val("false");
	var obj = new Object();
	obj.callId = callId;
	obj.contractNo = contractNo;
	obj.campaignId = campaignId;
	obj.callTypeCode = $('#jqGrid').getCell(rowId, 'CALL_TYPE_CODE');

	$.ajax({url : "${pageContext.request.contextPath}/getStatsRecordDetail",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		if(result != null && result != ""){
			var jObj = JSON.parse(result);
			var contentsList = jObj.botContentsList;
			var intentList = jObj.intentList;
			var inspectList = jObj.inspectList;
			var contentsHtml = "";
			var intentHtml = "";
			$("#inspectText").val("");
			$('input[name="inspect"]').removeAttr('checked');
			$("#inspectTd").html("");
			$("#saveInspect").attr("disabled", true);

			if (contentsList.length > 0) {
				for (var key in contentsList) {
					
					var speaker = contentsList[key].SPEAKER_CODE == "ST0001" ? "user" : "bot";
					var createdDtm = moment(contentsList[key].CREATED_DTM).format("YYYY-MM-DD");
					var createdTime = moment(contentsList[key].CREATED_DTM).format("HH:mm:ss");
					if(contentsList[key].IGNORED == "Y"){
						contentsHtml += "<li class='" + speaker + "'><div class='bot_msg'><em class='txt' name='ignoredMsg'  onclick=activeTask(this,'"+createdDtm+"','"+createdTime+"','"+callId+"','"+contentsList[key].START_TIME+"','"+speaker+"','"+campaignId+"');>" + contentsList[key].SENTENCE + "</em>"
									 + "<div class='date'>" + contentsList[key].UPDATED_DTM + "</div></div></li>"; //CREATED_DTM
					}else{
						contentsHtml += "<li class='" + speaker + "'><div class='bot_msg'><em class='txt' onclick=activeTask(this,'"+createdDtm+"','"+createdTime+"','"+callId+"','"+contentsList[key].START_TIME+"','"+speaker+"','"+campaignId+"');>" + contentsList[key].SENTENCE + "</em>"
									 + "<div class='date'>" + contentsList[key].UPDATED_DTM + "</div></div></li>"; //CREATED_DTM
					}
				}
				$("#firstTime").val(contentsList[0].CREATED_DTM);
			}

			//사용자 UI
			contentsHtml +="<li class='stmMessage' style='width:340px;'><span>user[test] leaves a room</span></li>";

			if (intentList.length > 0) {
				$('.tabBox').show();
				$('.tabBox .lst_tab').empty();
				$('.tbl_line_lst').show();

				//tab 타이틀 만들기
				for (var i=0; i < intentList.length; i++) {
					var tabList = $('<li><a>' + intentList[i].contractNo + '</a></li>')
					$('.tabBox .lst_tab').append(tabList);
				}
				makeIntentHtml(0);

				$('.tabBox .lst_tab a').on('click', function() {
					var a = $(this);
					var index = intentList.findIndex(e => e.contractNo === Number(a.text()));

					makeIntentHtml(index)
				});
			} else {

				$('.tabBox').hide();
				$('.tbl_line_lst').hide();
			}

			function activeTabList(index) {
				$('.tabBox .lst_tab li').removeClass('active');
				$('.tabBox .lst_tab li').eq(index).addClass('active');
			}

			function makeIntentHtml(index) {
				activeTabList(index);

				$(".intent_tbody").empty();
				intentHtml = '';

				var list = intentList[index].list;

				for (var i = 0; i < list.length; i++) {
					var j = i+1;
					var activeY = list[i].TASK_VALUE == "Y" ? "active" : "";
					var activeN = list[i].TASK_VALUE == "N" ? "active" : "";
					var taskValHtml = "";
					if(list[i].TASK_VALUE == "Y" || list[i].TASK_VALUE == "N"){
						taskValHtml = "<span class='"+activeY+"'>YES</span><span class='"+activeN+"'>NO</span>"
					}else{
						if(list[i].TASK_VALUE === ''){
							taskValHtml = "-";
						} else {
							taskValHtml = list[i].TASK_VALUE;
						}
					}

					intentHtml +="<tr id='task_"+list[i].SEQ_NUM+"'><td scope='row'>"+ j +"</td><td>"+ list[i].TASK_INFO
									+"</td><td><div class='detectBox'>"+ taskValHtml +"</div></td></tr>";
				}

				$(".intent_tbody").html(intentHtml);
			}

			if (inspectList.INSPECT_RESULT == 'Y') {
				$("input:radio[name='inspect']:radio[value='완료']").prop('checked', true);
				$("#saveInspect").attr("disabled", false);
			} else if (inspectList.INSPECT_RESULT == 'N') {
				$("input:radio[name='inspect']:radio[value='미완료']").prop('checked', true);
				$("#saveInspect").attr("disabled", false);
			}

			if (inspectList.INSPECT_MEMO != '') {
				$("#inspectText").val(inspectList.INSPECT_MEMO);
			}

			if (inspectList.INSPECT_UPDATED_DTM != '' && inspectList.INSPECTOR != '') {
				$("#inspectTd").html('수정날짜 : ' + inspectList.INSPECT_UPDATED_DTM + '&nbsp;&nbsp;&nbsp;검수자 : ' + inspectList.INSPECTOR);
			}

			$(".call_detail #detail_callId").text(callId);
			$(".lyrBox .lyr_top h3").text($('#jqGrid').getCell(rowId, 'SIP_NAME'));
			$(".call_detail #detail_sipName").text($('#jqGrid').getCell(rowId, 'SIP_NAME'));
			$(".call_detail #detail_custNm").text($('#jqGrid').getCell(rowId, 'CUST_NM'));
			$(".call_detail #detail_consultType").text($('#jqGrid').getCell(rowId, 'CONSULT_TYPE'));
			$(".call_detail #detail_startDt").text($('#jqGrid').getCell(rowId, 'START_TIME'));
			$(".lst_talk").html(contentsHtml);
			// $(".intent_tbody").html(intentHtml);
			
			
			//ignoredMsg class="ignored" 추가
			$("[name=ignoredMsg]").addClass("ignored");
			
			// /{callId}/{contractNo}/{campaignId}
			var playerHtml = '<audio preload="auto" controls id="audioPlay"><source src="'+jObj.audioUrl+callId+"/"+contractNo+"/"+campaignId+'"></audio>';

			$(".player").empty();
			$(".player").html(playerHtml);

			$('audio').audioPlayer();
			$('.btn_player_play').on('click',function(){
				$(this).toggleClass('pause');
			});
		}

	}).fail(function(result) {
		console.log("ajax connection error: getIVRMonitoringDetail");
	});
}

function saveInspect() {
	var obj = new Object();
	obj.inspectMemo = $("#inspectText").val();
	obj.inspectResult = $("input[name='inspect']:checked").val();
	obj.callId = $("#detail_callId").text().replace(/(\s*)/g,"");

	$.ajax({url : "${pageContext.request.contextPath}/updateInspectInfo",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		$(".btn_lyr_close").trigger("click");
// 		$("#search").trigger("click");
		$("#inspectYn").val("true");
		gridSearch($("#cPage").val(),"N");
		
	}).fail(function(result) {
		console.log("ajax connection error: getIVRMonitoringDetail");
	});
}

function activeTask(txt, createdDtm, createdTime,callId, strTime, speaker, campaignId){
	//txt 클릭시 Class="on" 제거 및 추가
	$(".txt").removeClass("on");
	$(txt).addClass("on");
	
	var obj = new Object();
	
	obj.callId = callId;
	obj.campaignId = campaignId;
	obj.callTypeCode = "CT0002";
	
	$.ajax({url : "getTaskDate",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		if(result != null && result != ""){
			var jObj = JSON.parse(result);
			var intentList = jObj.intentList;
			
			var msgDate = createdDtm+" "+createdTime;
			
			//TASK 구간 border 초기화			
			$("tr[id*=task_]").removeClass("on");
			for (var i = 0; i < intentList.length; i++) {
				
				if(i == 0){
					var taskPreCreatedDtm = moment(intentList[i].UPDATED_DTM).format("YYYY-MM-DD HH:mm:ss");
					if(msgDate < taskPreCreatedDtm){
						$("#task_"+intentList[i].SEQ_NUM+"").addClass("on");
					}
				}else {
					var taskPreCreatedDtm = moment(intentList[i-1].UPDATED_DTM).format("YYYY-MM-DD HH:mm:ss");
					var taskNextCreatedDtm = moment(intentList[i].UPDATED_DTM).format("YYYY-MM-DD HH:mm:ss");
					if(msgDate < taskNextCreatedDtm && msgDate >= taskPreCreatedDtm){
						$("#task_"+intentList[i].SEQ_NUM+"").addClass("on");
					}
				}
				
			}
			
			//시간 계산
			var startDate = $("#detail_startDt").text();
			
			var selectTime = new Date(msgDate);
			var startTime = new Date(startDate);
			var firstTime = new Date($("#firstTime").val());
			
			var diff = Math.abs(startTime - selectTime);
			diff = Math.floor(diff / 1000);
			
			var firstDiff = Math.abs(firstTime - startTime);
			firstDiff = Math.floor(firstDiff / 1000);
			if(speaker == "bot"){
				document.getElementById("audioPlay").currentTime = ((diff-1) + parseFloat(strTime));
			}else if(speaker == "user"){
				document.getElementById("audioPlay").currentTime = ((firstDiff-2) + parseFloat(strTime));
			}
			
			
			
		}
	}).fail(function(result) {
		console.log("ajax connection error: getIVRMonitoringDetail");
	});
	
}
//jqGrid list rowNumber
function rowNumber(cellvalue, options, rowObject){
    var nTotalCnt = $('#jqGrid').getGridParam('records');
    var nPage     = $('#jqGrid').getGridParam('page');
    var nRows     = $('#jqGrid').getGridParam('rowNum');
    var rowNum = null;
    
  	//일단위 체크시 날짜로 정렬
    if($("#ipt_check3_2").is(":checked") == true){
		if(recGroupSort == "desc"){
			rowNum = ( nPage-1 ) * nRows + (parseInt(options.rowId));
		}else if(recGroupSort == "asc"){
			rowNum = nTotalCnt - ( nPage-1 )*nRows - ( options.rowId - 1 );
		} 
    }else{//일단위 해제시 응대시작시간으로 정렬
    	if(recSort == "desc"){
    		rowNum = ( nPage-1 ) * nRows + (parseInt(options.rowId));
    	}else if(recSort == "asc"){
    		rowNum = nTotalCnt - ( nPage-1 ) * nRows - ( options.rowId - 1 );
    	}
    }
	
    return rowNum;
}
function convertCheckIntentTxt (cellvalue, options, rowObject){
	var new_cell_value = "";

	if(cellvalue == "Y"){
		new_cell_value = "Y";
	}else{
		new_cell_value = "";
	}

	return new_cell_value;
}

function addButton(cellvalue, options, rowObject){
	var buttonHtml = '<a href="#lyr_history" class="btnS_line btn_lyr_open" onclick="getRecordDetail('
		   + options.rowId+','+ rowObject.CALL_ID +','+ rowObject.CONTRACT_NO +','+ rowObject.CAMPAIGN_ID +','+rowObject.RNUM+')"><spring:message code="A0204" text="보기" /></a>';
	return buttonHtml;
}

var excelFn = {fn:function(){
	if($("#gbox_jqGrid_excel .ui-widget-content").length > 0 && $("#jqGrid_excel #norecs").length == 0){
		setTimeout(function() {
			$("#jqGrid_excel").jqGrid("exportToExcel",{
				includeLabels : true,
				includeGroupHeader : true,
				includeFooter: true,
				fileName : "<spring:message code="A0405" text="O/B 콜 이력조회"/>.xlsx",
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

function scResize() { //only height resize
	var searchBoxHeight = $("#container .srchArea").outerHeight(true);
	var gridSubHeight = $(".jqGridBox").outerHeight(true) - parseInt($(".ui-jqgrid-bdiv").css("height"));
	var resizeHeight = $("#container").height() - searchBoxHeight - gridSubHeight; // 전체 container높이 - 검색박스높이 - 그리드(헤더,페이지,margin)높이

	$('#jqGrid').setGridHeight( resizeHeight , true);
}

function setColumnWidth(){
	var resizeWidth = $('#gbox_jqGrid .ui-jqgrid-htable').width();
	$('#jqGrid').setGridWidth( resizeWidth , true);
}

function handleResultDownload() {
	//팝업 on/off 이벤트
	var winHeight = $(window).height()*0.7;
	var $popup = $('#download_result');

	$('body').css('overflow','hidden');
	$popup.wrap('<div class="lyrWrap"></div>');
	$popup.before('<div class="lyr_bg"></div>');
	$popup.find('.lyr_mid').css('max-height', Math.floor(winHeight) +'px');

	$('.btn_lyr_close, .lyr_bg').on('click',function(){
		$('.btn_lyr_close, .lyr_bg').off('click');
		$('body').css('overflow','');
		$popup.unwrap();
		$('.lyr_bg').remove();
	});

	$('#download_confirm').off('click');
	$('#download_confirm').on('click', custResultDownExcel);

	//캠페인 조회해서 뿌리기
	let obj = {}
	obj.companyId = $("#companyIdSelect").val();
	obj.pageType = "outbound";

	$.ajax({
		url : "${pageContext.request.contextPath}/getRecordCampaignList",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		let campaignList = result.campaignList;
		let $tbody = $popup.find('tbody');
		$tbody.empty();

		let trTemp = $('<tr></tr>');
		for(let i=0; i<campaignList.length; i++) {
			let trClone = trTemp.clone();
			trClone.append('<td>'+ (i+1) +'</td>');
			trClone.append('<td>'+ campaignList[i].CAMPAIGN_NM +'</td>');
			trClone.attr('camp-data', campaignList[i].CAMPAIGN_ID)
			trClone.on('click', function(){
				$tbody.find('tr').removeClass('on');
				$(this).addClass('on');
			});

			if (i === 0) {
				trClone.addClass('on');
			}

			$tbody.append(trClone);
		}

	}).error(function(result) {
		console.log(result)
	});
}

function custResultDownExcel() {
	let obj = {}
	obj.campaignId = $('#download_result .campaign_lst').find('tr.on').attr('camp-data');

	let req = new XMLHttpRequest();
	req.open('POST', 'excelCustResultDown',true);
	req.responseType = 'blob';
	req.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");

	req.onload  = function (e) {
		if(this.status === 200){
			let blob = this.response;
			let fileName = decodeURI(req.getResponseHeader('Content-Disposition').split('filename=')[1]);

			if(window.navigator.msSaveOrOpenBlob){ // IE
				window.navigator.msSaveOrOpenBlob(blob, fileName);
			}else{
				let dl = window.document.createElement('a')
				dl.href = window.URL.createObjectURL(new Blob([blob], { type: req.getResponseHeader("Content-Type") }));
				dl.download = fileName;
				document.body.appendChild(dl);
				dl.click();
				document.body.removeChild(dl);
			}
		} else if (this.status === 204) {
			alert('다운로드 받을 데이터가 없습니다');
		} else{
			alert('엑셀 다운로드 Error');
		}
	};
	req.send(JSON.stringify(obj));
}
</script>
</body>
</html>
