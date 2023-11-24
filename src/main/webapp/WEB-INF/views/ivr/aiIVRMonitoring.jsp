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
        <jsp:param name="titleCode" value="A0503"/>
        <jsp:param name="titleTxt" value="IVR Monitoring"/>
    </jsp:include>
    <!-- //#header -->

    <!-- #container -->
    <div id="container">
    	<div id="contents">
            <!-- .content -->
            <div class="content">
                <!-- 검색조건 -->
                <div class="srchArea">
                    <table class="tbl_line_view" summary="Company, 콜넘버, 검색일자로 구성됨">
                        <caption class="hide">검색조건</caption>
                        <colgroup>
                            <col width="100"><col >
                                <col width="100"><col >
                                <col width="100"><col >
                            <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                        </colgroup>
                        <tbody>
                        <tr>
                        	<th>Company</th>
                            <td>
                                <select class="select" id="companyIdSelect">
                                </select>
                            </td>
                            <th>SIP ACCOUNT</th>
                            <td>
                                <select class="select" id="sipAccountSelect">
                                </select>
                            </td>
                            <th>Call Id</th>
                            <td>
                            	<div class="iptBox w100">
                                    <input type="text" class="ipt_txt" id="callId1" autocomplete="off" style="display: none; opacity: 0; pointer-events: none;">
                                    <input type="text" class="ipt_txt" id="callId" autocomplete="off">
                                </div>
                            </td>
                        </tr>
                        <tr>
                        	<th>Phone No</th>
                            <td>
                                <div class="iptBox w100">
                                    <input type="text" class="ipt_txt" id="telNo" autocomplete="off">
                                </div>
                            </td>
                            <th scope="row">Date</th>
                            <td>
                               <div class="iptBox">
                                    <input type="text" name="fromDate" id="fromDate" class="ipt_dateTime" autocomplete="off">
                                    <span>-</span>
                                    <input type="text" name="toDate" id="toDate" class="ipt_dateTime" autocomplete="off">
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>            
                    <div class="btnBox sz_small line">
                        <button type="button" class="btnS_basic" id="search"><spring:message code="A0180" text="검색"/></button>
                    </div>            
                </div>
                <!-- //검색조건 -->

                <!-- .stn -->
                <div class="stn allBoxType">
                    <div class="stn_cont">
                        <table class="tbl_bg_lst03">
                            <caption class="hide">monitoring List</caption>
                            <colgroup>
                                <col><col><col>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col">Company Id</th>
                                    <th scope="col">Company Name</th>
                                    <th scope="col">Call Id</th>
                                    <th scope="col">Consultant</th>
                                    <th scope="col">Sip Account</th>
                                    <th scope="col">Phone No</th>
                                    <th scope="col">Starting Date Time</th>
                                    <th scope="col">Ending Date Time</th>
                                </tr>
                            </thead>
                            <tbody id="listTBody">
                                <tr><td class='dataNone' colspan='6'><spring:message code="A0257" text="등록된 데이터가 없습니다." /></td></tr>
                            </tbody>
                        </table> 
                    </div>
                    <div class="tbl_btm_info">
                        <div class='tbl_path'><spring:message code="A0172" text="전체"/><strong>0</strong> / 0</div>
                        <div class='paging'>
                            <a class='btn_paging_first' href='javascript:#none'>처음 페이지로 이동</a>
                            <a class='btn_paging_prev' href='javascript:#none'>이전 페이지로 이동</a>
                            <span class='list'><strong>1</strong></span>
                            <a class='btn_paging_next' href='#none)'>다음 페이지로 이동</a>
                            <a class='btn_paging_last' href='#none'>마지막 페이지로 이동</a>
                        </div>
                    </div>
                </div>             
            </div>
            <!-- //.stn -->
        </div>
        <div id="aside">
            <div class="aside_tit">
                <h3>IVR Bot</h3>
            </div>
            <!-- .chatBox -->
            <div class="chatBox">
                <div class="chatUI_mid">
                    <ul class="lst_talk">
                    </ul> 
                </div>
            </div>
            <!-- //.chatBox -->
            <div class="aside_cont chat">
            </div>
            <div class="aside_tit">
                <h3>Intent</h3>
            </div>
            <div class="aside_cont category">
            </div>
            <!-- //.chatBox -->
            <div class="btnBox asideBtm">
                <button type="button" id="btn_aside_close" class="btnS_basic">Close</button>
            </div>
        </div>
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
var lang = $.cookie("lang");
jQuery.event.add(window,"load",function(){
	$(document).ready(function (){
		// GCS iframe
		$('.gcsWrap', parent.document).each(function(){
			//header 화면명 변경
			var pageTitle = $('title').text().replace('> FAST AICC', '');
			
			$(top.document).find('#header h2 a').text(pageTitle); 
		});
		
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
		
		$(".ipt_dateTime").on("change", function(e){
			checkPeriodDate($(this));
		});
		
		// 첫 로딩 시 input값에 빈값주기
		$("#callId").val("");
		$("#contractNo").val("");
		$("#telNo").val("");
		
		//CompanyId selectBox
		getCompanyId();
		
		// 검색
		$("#search").on("click", function(){
			getAiIVRMonitoringList(1);
		});
		
		 //aside(close)   
        $('#btn_aside_close').on('click',function(){
            $('#container').removeClass('aside_open');
        });
	});
});

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
			
			$("#companyIdSelect").change(function(){
				getSipAccount();
			});
			
			// SIP_ACCOUNT selectBox
			getSipAccount("load");
		}else {
			alert("<spring:message code='A0333' text='CompanyId가 존재하지 않습니다.' />");
		}
		
	}).fail(function(result) {
		console.log("ajax connection error: getCompanyIdList");
	});
}

function getSipAccount(status) {
	var param = {companyId:$("#companyIdSelect option:selected").val()};
	$.ajax({url : "${pageContext.request.contextPath}/getSipAccountList",
		data : JSON.stringify(param),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		var html = "<option selected value=''><spring:message code='A0331' text='-전체-' /></option>";
		if(result != null && result.length > 0){
			for(var i = 0; i < result.length; i++) {
				html += "<option value='" + result[i].SIP_USER + "'>" + result[i].ACCOUNT + "</option>"
			}
			
		}else {
			alert("<spring:message code='A0334' text='Sip Account가 존재하지 않습니다.' />");
		}
		
		$("#sipAccountSelect").html(html);
		
		// LIST 가져오기
		if(status == "load"){
			getAiIVRMonitoringList(1);
		}
		
	}).fail(function(result) {
		console.log("ajax connection error: getSipAccountList");
	});
}

function getAiIVRMonitoringList(currentPage) {
	var param = {};
	param.sipUser = $("#sipAccountSelect option:selected").val();
	param.callId = $("#callId").val();
	param.contractNo = $("#contractNo").val();
	param.telNo = $("#telNo").val();
 	param.startDate = $("#fromDate").val();
 	param.endDate = $("#toDate").val();
	param.page = currentPage;
	param.rowNum = 20;
	param.offset = (param.page * param.rowNum) - param.rowNum;
	param.companyId = $("#companyIdSelect option:selected").val();
	
	$.ajax({url : "${pageContext.request.contextPath}/getAiIVRMonitoringList",
		data : JSON.stringify(param),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		if(result != null){
			var jObj = JSON.parse(result);
			var jSPCList = jObj.aiIVRMonitoringList;
			var jPaging = jObj.paging;
			
			var inerHtml = "";
			var pagingHtml = "<div class='tbl_path'><spring:message code='A0172' text='전체'/> <strong>0</strong> / 0</div>"
				   + "<div class='paging'>"
				   + "<a class='btn_paging_first' href='javascript:#none'>처음 페이지로 이동</a>"
				   + "<a class='btn_paging_prev' href='javascript:#none'>이전 페이지로 이동</a>"
				   + "<span class='list'><strong>1</strong></span>"
				   + "<a class='btn_paging_next' href='#none)'>다음 페이지로 이동</a>"
				   + "<a class='btn_paging_last' href='#none'>마지막 페이지로 이동</a></div>";
			
			if (jSPCList.length > 0) {
				for (var key in jSPCList) {
					inerHtml += "<tr><td>" + jSPCList[key].companyId + "</td>"
							 + "<td>" + jSPCList[key].companyNm + "</td>"
							 + "<th scope='row'><a class='link' href='#none'>" + jSPCList[key].callId
							 + "<input type='hidden' id='campaignId' value='" + jSPCList[key].campaignId + "'>"
							 + "<input type='hidden' id='callTypeCode' value='" + jSPCList[key].callTypeCode + "'></a></th>"
							 + "<td>" + jSPCList[key].custOpId + "</td>"
							 + "<td>" + jSPCList[key].sipAccount + "</td>"
// 							 + "<td class='contract_no'>" + jSPCList[key].contractNo + "</td>"
							 + "<td>" + jSPCList[key].telNo + "</td>"
							 + "<td>" + jSPCList[key].startTime + "</td>"
							 + "<td>" + jSPCList[key].endTime + "</td></tr>";
				}
				
				if(jPaging.totalPage != 0){
					pagingHtml = "<div class='tbl_path'><spring:message code='A0172' text='전체'/> <strong>" + jPaging.currentPage + "</strong> / " + JSON.stringify(jPaging.totalPage) + "</div>"
							+ "<div class='paging'>"
							+ "<a class='btn_paging_first' href='javascript:getAiIVRMonitoringList(" + jPaging.pageRangeStart + ")' >처음 페이지로 이동</a>"
							+ "<a class='btn_paging_prev' href='javascript:getAiIVRMonitoringList(" + jPaging.prevPage + ")' >이전 페이지로 이동</a>"
							+ "<span class='list'>";
	
					for (var i = jPaging.pageRangeStart; i <= jPaging.pageRangeEnd; i++) {
						if (jPaging.currentPage == i) {
							pagingHtml += "<strong>" + i + "</strong>";
						} else {
							pagingHtml += "<a href='javascript:getAiIVRMonitoringList(" + i + ")'>" + i + "</a>";
						}
					}
	
					pagingHtml += "</span>"
								+ "<a class='btn_paging_next' href='javascript:getAiIVRMonitoringList(" + jPaging.nextPage + ")'>다음 페이지로 이동</a>"
								+ "<a class='btn_paging_last' href='javascript:getAiIVRMonitoringList(" + jPaging.pageRangeEnd + ")'>마지막 페이지로 이동</a>"
								+ "</div>";
				}
				
			} else {
				inerHtml = "<tr><td class='dataNone' colspan='8'><spring:message code='A0257' text='등록된 데이터가 없습니다.' /></td></tr>";
			}
			
			$("#listTBody").html(inerHtml);
			$(".tbl_btm_info").html(pagingHtml);
			
			//aside
			$('.tbl_bg_lst03 tbody a.link').on('click',function(){
				$('#container').addClass('aside_open'); 
				// 사이드 내용 가져오기
				getIVRMonitoringDetail($(this));
			});
		}
		
	}).fail(function(result) {
		console.log("ajax connection error: getAiIVRMonitoringList");
	});
}

function getIVRMonitoringDetail(curRow) {
	var param = {};
	param.callId = curRow.text();
// 	param.contractNo = curRow.parents("tr").find(".contract_no").text();
	param.campaignId = curRow.find("#campaignId").val();
	param.callTypeCode = curRow.find("#callTypeCode").val();
	$.ajax({url : "${pageContext.request.contextPath}/getIVRMonitoringDetail",
		data : JSON.stringify(param),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		if(result != null && result != ""){
			var jObj = JSON.parse(result);
			var intentList = jObj.aiIVRIntentList;
			var contentsList = jObj.aiIVRBotContentsList;
			var custInfo = jObj.custInfoForIVR;
			var intentHtml = "";
			var contentsHtml = "";
			var custHtml = "";
			
			if (intentList.length > 0) {
				for (var key in intentList) {
					intentHtml += "<dl class='dlBox'><dt>" + intentList[key].TASK_INFO + "</dt><dd>" + intentList[key].TASK_VALUE + "</dd></dl>";
				}
			}
			
			if (contentsList.length > 0) {
				for (var key in contentsList) {
					var speaker = contentsList[key].SPEAKER_CODE == "ST0001" ? "user" : "bot";
						
					contentsHtml += "<li class='" + speaker + "'><div class='bot_msg'><em class='txt'>" + contentsList[key].SENTENCE + "</em>"
								 + "<div class='date'>" + contentsList[key].UPDATED_DTM + "</div></div></li>"; //CREATED_DTM
				}
			}
			
			if (custInfo != "" && custInfo != null) {
				custHtml = "<dl class='dlBox'><dt>Customer Name</dt><dd>" + custInfo.CUST_NM + "</dd></dl>"
						 + "<dl class='dlBox'><dt>Phone No.</dt><dd>" + custInfo.CUST_TEL_NO + "</dd></dl>";
			}
			
			$(".category").html(intentHtml);
			$(".lst_talk").html(contentsHtml);
			$(".chat").html(custHtml);
			
		}
		
	}).fail(function(result) {
		console.log("ajax connection error: getIVRMonitoringDetail");
	});
}

function checkPeriodDate(curInput) {
	var toDate = $("#toDate").val();
	var fromDate  = $("#fromDate").val();
	
	fromDate = fromDate.replace(/-/gi, "");
	toDate = toDate.replace(/-/gi, "");
	
	
	if(toDate<fromDate){
		curInput.val("");
		alert("시작일이 종료일보다 빨라야합니다.");
		return false;
	}
}
</script>
</body>
</html>
