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
        <jsp:param name="titleTxt" value="IVR RealTime Dashboard"/>
    </jsp:include>
    <!-- //#header -->

    <!-- #container -->
    <div id="container">
        <!-- .content -->
        <div class="content">
            <!-- .titArea -->
            <div class="titArea">
                <dl class="fl">
                    <dt>Company</dt>
                    <dd>
                        <select class="select" id="companyIdSelect">
                        </select>
                    </dd>
                </dl>
                <dl class="fr">
                    <dt>Date : </dt>
                    <dd class="realTime">
                    </dd>
                </dl>
            </div>
            <!-- //.titArea -->
            <!-- .stn -->
            <div class="stn allBoxType">
                <div class="stn_cont">
                    <div class="statusBox">
                        <div class="itemBox">
                            <div class="cnt">
                                <ul class="lst_item">
                                </ul>
                            </div>
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
		
		
		// 현재시간
		getCurrentTime();
		
		// CompanyId selectBox
		getCompanyId();
		
		//봇 연결
		conn_main_ws('${websocketUrl}');
	});
});

function getCurrentTime() {
	var tDate = new Date();
	var minutes = tDate.getMinutes() < 10 ? "0"+tDate.getMinutes() : tDate.getMinutes();
	tDate = getFormatDate(tDate) + " " + tDate.getHours() + ":" + minutes;
	$(".realTime").text(tDate);
	
	setTimeout("getCurrentTime()",1000);
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
		}else {
			alert("<spring:message code='A0333' text='CompanyId가 존재하지 않습니다.' />");
		}
		
		getBotStatus();
		
		$("#companyIdSelect").change(function(){
			getBotStatus();
		});
		
	}).fail(function(result) {
		console.log("ajax connection error: getCompanyIdList");
	});
}

function getBotStatus() {
	var param = {companyId:$("#companyIdSelect option:selected").val()};
	$.ajax({url : "${pageContext.request.contextPath}/getBotStatusList",
		data : JSON.stringify(param),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		if(result != null){
			var existBotHtml = "";
			var botLength = result.length;
			var idx = 1;
			
			for(var i = 0; i < result.length; i++) {
				var botStatus = result[i].STATUS == "CS0001" ? "call_await" : "call_ing";
				var botStatusText = result[i].STATUS == "CS0001" ? "<spring:message code='A0110' text='대기중' />" : "<spring:message code='A0091' text='통화중' />";
				var custPhone = result[i].CUSTOMER_PHONE == undefined ? "N/A" : result[i].CUSTOMER_PHONE;
				existBotHtml += "<li id='"+ result[i].SIP_USER +"' class='item "+ botStatus +"'><span class='name'><spring:message code='A0249' text='음성봇' />"+ idx++ +"<br>("+ result[i].SIP_USER +")</span>"
							  + "<span class='ico'><em>상태 아이콘</em></span><span class='time'><a>"+botStatusText+"</a><br/>00:00:00</span>"
							  + "<span class='tutor'>Tel:"+ custPhone +"</span></li>";
			}
			
			var emptyBotHtml = "";
			if(result.length < 50){
				emptyBotHtml = makeEmptyBot(botLength, idx);
			}
			
			$(".lst_item").html(existBotHtml + emptyBotHtml);
		}else {
			alert("BotStatusList dose not exist.");
		}
		
	}).fail(function(result) {
		console.log("ajax connection error: getBotStatusList");
	});
}

function makeEmptyBot(botLength, idx) {
	var emptyBot = "";
	for(var i=0; i < 50-botLength; i++){
		emptyBot += "<li class='item'><span class='name'><spring:message code='A0249' text='음성봇' />"+ idx++ +"<br>()</span><span class='ico'><em>상태 아이콘</em></span>"
					 + "<span class='time'><a><spring:message code='A0114' text='연결안됨' /></a><br/>00:00:00</span><span class='tutor'>Tel:N/A</span></li>";
	}
	return emptyBot;
}

//웹소켓 연결
function conn_main_ws(url) {
	
	console.log(url);
	var wss_url = url+"/callsocket";
	
	main_ws = new WebSocket(wss_url);
	
	//main_ws = new WebSocket(url + '/callsocket');
	
	main_ws.onopen = function() {
		main_ws.send('{"EventType":"CALL", "Event":"subscribe"}');
	};
	main_ws.onmessage = function(e) {
		
		if(e.data == "wss"){
			return;
		}
		
		var rcv_data = JSON.parse(e.data);
		console.log("call====");
		console.log(rcv_data);
		// 타입이CALL인 경우
		if (rcv_data.EventType == 'CALL') {
			if (rcv_data.Event == 'status') {
				if (rcv_data.call_status == "CS0002") {//전화 연결중인결우
					$("#" + rcv_data.Agent).removeClass("call_await").addClass("call_ing");
					$("#" + rcv_data.Agent).find('.time a').text("<spring:message code='A0091' text='통화중' />");
					$("#" + rcv_data.Agent).find("span.tutor").text("Tel:" + rcv_data.Caller);
				} else if (rcv_data.call_status == "CS0006") {
					$("#" + rcv_data.Agent).removeClass("call_await").addClass("call_ing");
					$("#" + rcv_data.Agent).find('.time a').text("<spring:message code='A0091' text='통화중' />");
					$("#" + rcv_data.Agent).find("span.tutor").text("Tel:" + rcv_data.Caller);
	            } else if (rcv_data.call_status == "CS0003") {
	            	$("#" + rcv_data.Agent).removeClass("call_ing").addClass("call_await");
					$("#" + rcv_data.Agent).find('.time a').text("<spring:message code='A0110' text='대기중' />");
					$("#" + rcv_data.Agent).find("span.tutor").text("Tel:N/A");
	            } else {
	            	$("#" + rcv_data.Agent).removeClass("call_ing").addClass("call_await");
					$("#" + rcv_data.Agent).find('.time a').text("<spring:message code='A0110' text='대기중' />");
					$("#" + rcv_data.Agent).find("span.tutor").text("Tel:N/A");
	            }
			}
		}
	};
}
</script>
</body>
</html>
