
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
        <jsp:param name="titleTxt" value="IVR Statistics"/>
    </jsp:include>
    <!-- //#header -->

    <!-- #container -->
    <div id="container">
        <!-- 검색조건 -->
        <div class="srchArea">
            <table class="tbl_line_view" summary="콜넘버, 검색일자로 구성됨">
                <caption class="hide">검색조건</caption>
                <colgroup>
                    <col width="100"><col><col width="100"><col><col width="100"><col width="400">
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
                    <th>Date</th>
                    <td>
                        <div class="iptBox">
                            <input type="text" name="fromDate" id="fromDate" class="ipt_date" autocomplete="off">
                            <span>-</span>
                            <input type="text" name="toDate" id="toDate"  class="ipt_date" autocomplete="off">
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
        <!-- .content -->
        <div class="content">
            <!-- .stn -->
            <div class="stn allBoxType">
                <div class="lotBox">
                    <div class="stn_tit">
                        <h4>IVR Call</h4>
                    </div>
                    <div class="stn_cont">
                        <div class="chart" style="height:500px;"><iframe class="chartjs-hidden-iframe" tabindex="-1" style="display: block; overflow: hidden; border: 0px; margin: 0px; top: 0px; left: 0px; bottom: 0px; right: 0px; height: 100%; width: 100%; position: absolute; pointer-events: none; z-index: -1;"></iframe>
                            <canvas id="mixedChart" width="1736" height="380" style="display: block; height: 304px; width: 1389px;"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //.stn -->
        </div>
        <!-- //.content -->
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
		
		if(lang == "ko"){
			//datepicker
			$('#fromDate').datepicker({
				format : "yyyy-mm-dd",
				language : "ko",
				autoclose : true,
				todayHighlight : true,
				defalutDate : new Date()
			});
			
			$('#toDate').datepicker({
				format : "yyyy-mm-dd",
				language : "ko",
				autoclose : true,
				todayHighlight : true,
				defalutDate : new Date() // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
			});	
		}else if(lang == "en"){
			//datepicker
			$('#fromDate').datepicker({
				format : "yyyy-mm-dd",
				language : "en",
				autoclose : true,
				todayHighlight : true,
				defalutDate : new Date()
			});
			
			$('#toDate').datepicker({	
				format : "yyyy-mm-dd",
				language : "en",
				autoclose : true,
				todayHighlight : true,
				defalutDate : new Date() // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
			});	
		}
		
		var tDate = new Date();
		tDate = getFormatDate(tDate);
		$("#fromDate").val(tDate);
		$("#toDate").val(tDate);
		
		//CompanyId selectBox
		getCompanyId();
		
		// 검색
		$("#search").on("click", function(){
			getIVRHourStatistics();
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
			getIVRHourStatistics();
		}
		
	}).fail(function(result) {
		console.log("ajax connection error: getSipAccountList");
	});
}

function getIVRHourStatistics() {
	var param = {};
	param.sipUser = $("#sipAccountSelect option:selected").val();
 	param.startDate = $("#fromDate").val();
 	param.endDate = $("#toDate").val() + " 23:59:59";
 	param.companyId = $("#companyIdSelect option:selected").val();
	
	$.ajax({url : "${pageContext.request.contextPath}/getIVRHourStatistics",
		data : JSON.stringify(param),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		if(result != null){
			var jObj = JSON.parse(result);
			var allHourList = jObj.allHourStatistics;
			var hourList = jObj.hourStatistics;
			var allStatisticsData = [];
			var searchHourData = [];
			var hours = new Array();
			
			for (var key in allHourList) {
				hours[key] = allHourList[key].callHour;
			}
			for (var key in allHourList) {
				allStatisticsData.push(allHourList[key].hourCount);
			}
			for (var key in hourList) {
				searchHourData.push(hourList[key].hourCount);
			}
			
			setChatData(allStatisticsData, searchHourData, hours);
		}
		
	}).fail(function(result) {
		console.log("ajax connection error: getIVRHourStatistics list");
	});
}
function setChatData(allStatisticsData, searchHourData, hours) {
	
	var ctx2 = document.getElementById('mixedChart').getContext('2d');
	var config = {
		    type: 'bar',
		    data: {
			    labels: hours, // 유형이 많을 경우, 상위 10내
			    datasets: [{
			        type: 'line',
			        label: 'Average Count',
			        borderColor: 'rgba(94,119,255,1.0)',
			        backgroundColor: 'rgba(94,119,255,1.0)',
			        borderWidth: 2,
			        fill: false,
			        data: allStatisticsData
			    }, {
			        type: 'bar',
			        label: 'Searched Count',
			        backgroundColor: 'rgba(178,180,195,1.0)',
			        data: searchHourData,
			        borderColor: 'white',
			        borderWidth: 2
			    }]
			},
		    options: {
		        maintainAspectRatio: false,
		        responsive: true,
				legend: {
					position: 'bottom'  //  or 'left', 'bottom', 'right'(default)
				},
		        title: {
		            display: false,
		            text: 'IVR Call'
		        },
		        tooltips: {
		            mode: 'index',
		            intersect: false,
		        },
		        scales: {
		        	yAxes: [{
		        		ticks:{
		        			beginAtZero:true
		        		}
		        	}]
		        }
		    }
		};
	
	if(window.myMixedChart == null) {
		window.myMixedChart = new Chart(ctx2, config);
	} else {
		window.myMixedChart.config = config;
		window.myMixedChart.update();
	}
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
