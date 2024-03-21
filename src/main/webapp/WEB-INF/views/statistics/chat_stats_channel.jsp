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
<link rel="stylesheet" type="text/css" href="resources/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="resources/css/fast_aicc.css"/>
<link rel="stylesheet" type="text/css" href="resources/css/jquery-jvectormap-2.0.5.css"/>

<script type="text/javascript" src="resources/js/jquery-jvectormap-2.0.5.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-jvectormap-world-mill-ko.js"></script>
<script type="text/javascript" src="resources/js/chart_custom.js"></script>
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

	
<!-- #wrap -->
<div id="wrap">
		<jsp:include page="../common/inc_header.jsp">
			<jsp:param name="titleCode" value="A0930"/>
			<jsp:param name="titleTxt" value="챗봇통계"/>
		</jsp:include>

<!-- //.page loading -->
	<div id="container">
	<input type="hidden" id="headerName" value="${_csrf.headerName}" />
    <input type="hidden" id="token" value="${_csrf.token}" />
        <input type="hidden" id="categoryArr" />
        <!-- .content -->
        <div class="content chatbot_dashboard">
            <!-- .titArea -->
            <div class="titArea" style="padding: 20px 0 0 0;">
                <dl class="fl">
                    <dt>봇 선택</dt>
                    <dd>
                        <div class="selectbox">
                            <label for="select_channel" id="channelLabel">봇 선택</label>
                            <select id="select_channel">
                            </select>
                        </div>
                    </dd>
                </dl>
            </div>

            <!-- 검색조건 -->
            <div class="srchArea">
                <table class="tbl_line_view" summary="언어, 기간으로 구성됨">
                    <caption class="hide">검색조건</caption>
                    <colgroup>
                        <col width="100"><col><col width="100"><col>
                        <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                    </colgroup>
                    <tbody>
                    <tr>
                        <th>언어</th>
                        <td>
                            <div class="selectbox">
                                <label for="select_lang">한국어</label>
                                <select id="select_lang" class="select">
                                    <option value="1" selected>한국어</option>
                                    <option value="2">English</option>
                                    <option value="4">中文(简体)</option>
                                    <option value="3">日本語</option>
                                    <option value="100">전체</option>
                                </select>
                            </div>
                        </td>
                        <th>기간</th>
                        <td>
                            <div class="selectbox">
                                <label for="select_date">지난 7일</label>
                                <select id="select_date" class="select" onchange="selectDate();">
                                    <option value="7">지난 7일</option>
                                    <option value="14">지난 14일</option>
                                    <option value="28">지난 28일</option>
                                    <option value="-1">직접입력</option>
                                </select>
                            </div>
                            <div class="iptBox" style="margin: 0 0 0 10px;">
                                <input type="text" name="fromDate" id="fromDate" class="ipt_date" disabled="disabled">
                                <span>-</span>
                                <input type="text" name="toDate" id="toDate"  class="ipt_date" disabled="disabled">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>분류</th>
                        <td id="multiple2">
                            <select id="category" class="select" multiple="multiple2">
                                <option value="생성형 지식지원">생성형 지식지원</option>
                                <option value="지능형 업무지원">지능형 업무지원</option>
                                <option value="통합플랫폼 활용지원">통합플랫폼 활용지원</option>
                            </select>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div class="btnBox sz_small line">
                    <button type="button" class="btnS_basic" onclick="searchChatStats();">검색</button>
	                <button type="button" class="btnS_basic" id="excelDown" onclick="excelDown();">
						<spring:message code="A0182" text="다운로드" />
					</button>
                </div>
            </div>

            <!-- .section(All Box Type) -->
            <div class="stn allBoxType" style="overflow: initial;">
                <div class="stn_tit">
                    <h4>통계</h4>
                </div>

                <div class="stn_cont" style="overflow: initial;">
                    <div class="stn_col col_fifth">
                        <dl class="dlBox">
                            <dt>전체 챗봇 메세지 수</dt>
                            <dd id="tm_num" class="num"></dd>
                            <dd class="btnBox1">
                                <button type="button"><span class="fas fa-question-circle"></span>Help</button>
                            </dd>
                        </dl>
                        <dl class="dlBox">
                            <dt>전체 챗봇 상담 수</dt>
                            <dd id="te_num" class="num"></dd>
                            <dd class="btnBox1">
                                <button type="button"><span class="fas fa-question-circle"></span>Help</button>
                            </dd>
                        </dl>
                        <dl class="dlBox">
                            <dt>전체 사용자 수</dt>
                            <dd id="tu_num" class="num"></dd>
                            <dd class="btnBox1">
                                <button type="button"><span class="fas fa-question-circle"></span>Help</button>
                            </dd>
                        </dl>
                        <dl class="dlBox">
                            <dt>사용자 당 평균 메세지 수</dt>
                            <dd id="avg_num" class="num ft_clr_red"></dd>
                            <dd class="btnBox1">
                                <button type="button"><span class="fas fa-question-circle"></span>Help</button>
                            </dd>
                        </dl>
                    </div>
                </div>
            </div>
            <!-- //.section(All Box Type) -->

            <!-- .section(All Box Type) -->
            <div class="stn allBoxType">
                <div class="lotBox">
                    <div class="stn_tit">
                        <h4>시간대 별 메세지 현황</h4>
                    </div>

                    <div class="stn_cont">
                        <div id="dir_totalMessagesPerHour" class="chartBox1">
                            <canvas id="totalMessagesPerHour"></canvas>
                        </div>
                    </div>
                </div>
                <div class="lotBox">
                    <div class="stn_tit">
                        <h4>시간대 별 사용자 현황</h4>
                    </div>

                    <div class="stn_cont">
                        <div id="dir_activeUsersPerHour" class="chartBox1">
                            <canvas id="activeUsersPerHour"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //.section(All Box Type) -->

            <!-- .section(All Box Type) -->
            <div class="stn allBoxType">
                <div class="lotBox">
                    <div class="stn_tit">
                        <h4>분류 별 통계</h4>
                        <div class="fr">
                            <dl>
                                <dt>Total :</dt>
                                <dd id="category_sum">0</dd>
                            </dl>
                        </div>
                    </div>

                    <div class="stn_cont">
                        <div id="dir_categoryCount" class="chartBox1">
                            <canvas id="categoryCount"></canvas>
                        </div>
                    </div>
                </div>

                <div class="lotBox">
                    <div class="stn_tit">
                        <h4>유입 채널 통계</h4>
                        <div class="fr">
                            <dl>
                                <dt>Total :</dt>
                                <dd id="channel_sum">0</dd>
                            </dl>
                        </div>
                    </div>

                    <div class="stn_cont">
                        <div id="dir_channelCount" class="chartBox1">
                            <canvas id="channelCount"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //.section(All Box Type) -->

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
	
	<script type="text/javascript">
	
	var lang = $.cookie("lang");
	
	$(document).ready(function (){
		// $(".stn_cont").css("overflow","initial");
		if(lang == "ko"){
			//datepicker
			$('#fromDate').datepicker({
				format : "yyyy-mm-dd",
				language : "ko",
				autoclose : true,
				todayHighlight : true,
				defalutDate : new Date(),
				endDate: $("#toDate").val()
			}).on('changeDate', function(selectedDate){
				$("#toDate").datepicker('setStartDate',selectedDate.date);
			});
			
			$('#toDate').datepicker({
				format : "yyyy-mm-dd",
				language : "ko",
				autoclose : true,
				todayHighlight : true,
				defalutDate : new Date(),
				startDate: $("#fromDate").val()
			}).on('changeDate', function(selectedDate){
				$("#fromDate").datepicker('setEndDate',selectedDate.date);
			});
		}else if(lang == "en"){
			//datepicker
			$('#fromDate').datepicker({
				format : "yyyy-mm-dd",
				language : "en",
				autoclose : true,
				todayHighlight : true,
				defalutDate : new Date(),
				endDate: $("#toDate").val()
			}).on('changeDate', function(selectedDate){
				$("#toDate").datepicker('setStartDate',selectedDate.date);
			});
			
			$('#toDate').datepicker({
				format : "yyyy-mm-dd",
				language : "en",
				autoclose : true,
				todayHighlight : true,
				defalutDate : new Date(),
				startDate: $("#fromDate").val()
			}).on('changeDate', function(selectedDate){
				$("#fromDate").datepicker('setEndDate',selectedDate.date);
			});
		}

		getChatBotList();
        getCategoryList();
		selectDate();

	});

    function getCategoryList() {

        var obj = new Object();

        $.ajax({
            url : "${pageContext.request.contextPath}/getCategoryList",
            data : JSON.stringify(obj),
            method : 'POST',
            contentType : "application/json; charset=utf-8",
            beforeSend : function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
        }).success(function(result) {
            var categoryArr = new Array();
            $('#multiple2').empty();
            var innerHTML = "";
            innerHTML += '<select id="category" class="select" multiple="multiple2" onchange="changeCategory(this.value);">';
            if(result != null && result.length > 0){
                for(var i = 0; i < result.length; i++){
                    innerHTML += '<option value="' + result[i] + '"selected>' + result[i] + '</option>';
                    categoryArr.push(result[i]);
                }
            }
            innerHTML += '</select>';
            $("#categoryArr").val(categoryArr);
            $("#multiple2").append(innerHTML);
            $('#category').multiselect({
                includeSelectAllOption: true,
            });

        }).fail(function(result) {
            console.log("ajax connection error: getCategoryList");
        });
    }

	function getChatBotList(){
		var obj = new Object();
		obj.companyId = ""
		
		$.ajax({url : "getChatBotList",
			data : JSON.stringify(obj),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
		}).success(function(result) {
			
			var innerHtml = "";
			
			for(var i = 0; i < result.length; i++){
				if(i == 0){
					$("#channelLabel").text(result[i].name);
					innerHtml += "<option value="+result[i].botId+" selected>"+result[i].name+"</option>";
				}else{
					innerHtml += "<option value="+result[i].botId+">"+result[i].name+"</option>";
				}
			}
			$("#select_channel").empty();
			$("#select_channel").append(innerHtml);
			
			//봇 통계 함수
			searchChatStats();
			
		}).fail(function(result) {
			console.log("ajax connection error: getChatBotList");
		});
	}
	
	
	function searchChatStats(){
		
		var obj = new Object();
		
		obj.startDate = $("#fromDate").val();
		obj.endDate = $("#toDate").val();
		obj.lang = $("#select_lang").val();
		obj.host = $("#select_channel").val();
        obj.categoryArr = $("#categoryArr").val();
		
		$.ajax({url : "/getChatStats",
			data : JSON.stringify(obj),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
		}).success(function(result) {
			
			var getTotalMessage = result.getTotalMessages[0];
			var getTotalUsers = result.getTotalUsers[0];
			var avgNum = Math.round(getTotalMessage.totalCnt/getTotalUsers.totalCnt);
// 			var getWeakProb = result.getWeakProb[0];
// 			var getTotalEmail = result.getTotalEmail[0];
// 			var getMostIntents = result.getMostIntents;
// 			var getMostIntentsAll = result.getMostIntentsAll;
// 			var getTotalMsgPerHour = result.getTotalMsgPerHour;

			//Total Message Count
			$("#tm_num").text(getTotalMessage.totalCnt);
			//Total Users Count
			$("#tu_num").text(getTotalUsers.totalCnt);
			//Avg.conversation per user
			if(getTotalUsers.totalCnt == 0 || getTotalMessage.totalCnt == 0){
				avgNum = 0;
			}
			$("#avg_num").text(avgNum);
			//Weak understanding
// 			$("#wu_num").text(getWeakProb.totalCnt);
			//Total Email
			$("#te_num").text(getTotalUsers.totalCnt);
			//봇 선택에서 선택된 봇이름 타이틀로 설정
			// $("#page_title").text($("#select_channel option:selected").text());
			
			remove_canvas();
		    make_canvas();

            getTotalLineChart();
            getdoughnutChart();

		    // searchIntent();
            // getUserCountry();

		}).fail(function(result) {
			console.log("ajax connection error: searchChatStats");
		});
	}

	function selectDate(){
		var selectDate = $("#select_date").val();
		
		if(selectDate == "7"){
			var tDate = new Date();
			tDate.setHours(-(24*7))
	        tDate = getFormatDate(tDate);
	        
			$("#fromDate").val(tDate);//기본값 오늘
			
			var tDate = new Date();
	        tDate = getFormatDate(tDate);
			$("#toDate").val(tDate);//기본값 오늘
			
			
			$(".ipt_date").attr("disabled", "disabled");
	        $(".ipt_date").parents('.dlBox').addClass('date_hide');
	        $('.btn_send').removeClass('positioning');
	        
		}else if(selectDate == "14"){
			
			var tDate = new Date();
			tDate.setHours(-(24*14))
	        tDate = getFormatDate(tDate);
			
			$("#fromDate").val(tDate);//기본값 오늘
			
			var tDate = new Date();
	        tDate = getFormatDate(tDate);
			$("#toDate").val(tDate);//기본값 오늘
			
			$(".ipt_date").attr("disabled", "disabled");
	        $(".ipt_date").parents('.dlBox').addClass('date_hide');
	        $('.btn_send').removeClass('positioning');
	        
		}else if(selectDate == "28"){
			
			var tDate = new Date();
			tDate.setHours(-(24*28))
	        tDate = getFormatDate(tDate);
	        
			$("#fromDate").val(tDate);//기본값 오늘
			
			var tDate = new Date();
	        tDate = getFormatDate(tDate);
			$("#toDate").val(tDate);//기본값 오늘
			
			$(".ipt_date").attr("disabled", "disabled");
	        $(".ipt_date").parents('.dlBox').addClass('date_hide');
	        $('.btn_send').removeClass('positioning');
	        
		}else if(selectDate == "-1"){
			$("#fromDate").val("");
			$("#toDate").val("");
			
			$(".ipt_date").removeAttr("disabled");
	        $(".ipt_date").parents('.dlBox').removeClass('date_hide');
	        $('.btn_send').addClass('positioning');
		}
	}
	
	function searchIntent(){
		var obj = new Object();
		
		obj.startDate = $("#fromDate").val();
		obj.endDate = $("#toDate").val();
		obj.lang = $("#select_lang").val();
		obj.host = $("#select_channel").val();
		obj.selectView = $("select[id=cat_cnt]").val();
		
		$.ajax({url : "/getMostIntents",
			data : JSON.stringify(obj),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
		}).success(function(result) {
			var selectCount = $("#cat_cnt").val();
			
			var getMostIntents = result.getMostIntents;
			
			innerHtml = "";
			if(getMostIntents != ""){
					for (var i = 0; i < getMostIntents.length; i++) {
						if(i == 0){
							innerHtml += "<tr style='background:#EEEBEB;'>";
						}else{
							innerHtml += "<tr>";
						}
						innerHtml += "<td scope='col'>"+(i+1)+"</td>";
						innerHtml += "<td><a class='cc_text' onclick=\"searchUtters(this,'"+getMostIntents[i].content+"')\";>"+getMostIntents[i].content+"</a></td>";
						innerHtml += "<td>"+getMostIntents[i].COUNT+"</td>";
						innerHtml += "</tr>";
					}
				searchUtters(this,getMostIntents[0].content);
			}else{
				searchUtters(this,"");
				innerHtml +="<tr>";
				innerHtml +="<td colspan='3' class='dataNone'>조회된 데이터가 없습니다.</td>";
				innerHtml +="</tr>";
			}
			
			$("#cc_tbody").empty();
			$("#cc_tbody").append(innerHtml);
			
			
		}).fail(function(result) {
			console.log("ajax connection error: getMostIntents");
		});
	}
	
	function searchUtters(el,intent){
		
		
		$(".cc_text").parent().parent().css("background","none");
		$(el).parent().parent().css("background","#EEEBEB");
		
		var obj = new Object();
		
		obj.startDate = $("#fromDate").val();
		obj.endDate = $("#toDate").val();
		obj.intent = intent;
		obj.lang = $("#select_lang").val();
		obj.host = $("#select_channel").val();
		
		$.ajax({url : "/getUttersFromIntent",
			data : JSON.stringify(obj),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
		}).success(function(result) {
			var getUttersFromIntent = result.getUttersFromIntent;
			
			var innerHtml = "";
			if(getUttersFromIntent != ""){
				for (var i = 0; i < getUttersFromIntent.length; i++) {
					innerHtml += "<tr>";
					innerHtml += "<td>"+getUttersFromIntent[i].content+"</td>";
					innerHtml += "<td class='al_r'>"+getUttersFromIntent[i].COUNT+"</td>";
					innerHtml += "</tr>";
				}
			}else{
				innerHtml +="<tr>";
				innerHtml +="<td colspan='2' class='dataNone'>조회된 데이터가 없습니다.</td>";
				innerHtml +="</tr>";
			}
			
			$("#choiceIntent").empty();
			$("#choiceIntent").text("[" + intent + "] ");
			
			$("#uq_tbody").empty();
			$("#uq_tbody").append(innerHtml);
			
		}).fail(function(result) {
			console.log("ajax connection error: searchUtters");
		});
	}


	function getTotalLineChart(){
		var obj = new Object();
		
		obj.startDate = $("#fromDate").val();
		obj.endDate = $("#toDate").val();
		obj.lang = $("#select_lang").val();
		obj.host = $("#select_channel").val();
		
		$.ajax({url : "/getTotalLineChart",
			data : JSON.stringify(obj),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
		}).success(function(result) {
			var getTotalMsgPerHour = result.getTotalMsgPerHour;
			var getTotalUserPerHour = result.getTotalUserPerHour;
			let date_label = ['AM 00','AM 01','AM 02','AM 03','AM 04','AM 05','AM 06','AM 07','AM 08','AM 08','AM 10','AM 11','AM 12','PM 13','PM 14','PM 15', 'PM 16', 'PM 17', 'PM 18', 'PM 19', 'PM 20', 'PM 21', 'PM 22', 'PM 23'];
			
			var TotalMsgPerHourData = new Array();
			var TotalUserPerHourData = new Array();
						
			for (var i = 0; i < getTotalMsgPerHour.length; i++) {
				TotalMsgPerHourData.push(getTotalMsgPerHour[i]);
			}
			for (var j = 0; j < getTotalUserPerHour.length; j++) {
				TotalUserPerHourData.push(getTotalUserPerHour[j]);
			}
			
			draw_chart("totalMessagesPerHour", get_line_chart_data(date_label, TotalMsgPerHourData));
			draw_chart("activeUsersPerHour", get_line_chart_data(date_label, TotalUserPerHourData));
			
		}).fail(function(result) {
			console.log("ajax connection error: getTotalLineChart");
		});
	}
	
	function getdoughnutChart(){
		var obj = new Object();
		
		obj.startDate = $("#fromDate").val();
		obj.endDate = $("#toDate").val();
		obj.lang = $("#select_lang").val();
		obj.host = $("#select_channel").val();
		
		$.ajax({url : "/getdoughnutChart",
			data : JSON.stringify(obj),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
		}).success(function(result) {
			
			var getCategoryIntellectCount = result.getCategoryIntellectCount[0];
            var getCategoryCreationCount = result.getCategoryCreationCount[0];
            var getCategoryTotalplatformCount = result.getCategoryTotalplatformCount[0];
			var getPcCount = result.getPcCount[0];
			var getMobileCount = result.getMobileCount[0];
			var getKSCount = result.getKSCount[0];

			const category_label = ['생성형 지식지원', '지능형 업무지원', '통합플랫폼 활용지원'];
			const channel_label = ['PC', 'Mobile', 'KIOSK'];
			
			var arrayCategoryData = new Array();
            arrayCategoryData.push(getCategoryIntellectCount.totalCnt);
            arrayCategoryData.push(getCategoryCreationCount.totalCnt);
            arrayCategoryData.push(getCategoryTotalplatformCount.totalCnt);
			$("#category_sum").text(getCategoryIntellectCount.totalCnt + getCategoryCreationCount.totalCnt + getCategoryTotalplatformCount.totalCnt);
			
			var arrayChannelData = new Array();
			arrayChannelData.push(getPcCount.totalCnt);
			arrayChannelData.push(getMobileCount.totalCnt);
			arrayChannelData.push(getKSCount.totalCnt);
			$("#channel_sum").text(getPcCount.totalCnt + getMobileCount.totalCnt + getKSCount.totalCnt);

		    draw_chart("categoryCount", get_doughnut_chart_data(category_label, arrayCategoryData));
		    draw_chart("channelCount", get_doughnut_chart_data(channel_label, arrayChannelData));

		}).fail(function(result) {
			console.log("ajax connection error: getdoughnutChart");
		});
	}
	
	function getUserCountry(){
		var obj = new Object();
		
		obj.startDate = $("#fromDate").val();
		obj.endDate = $("#toDate").val();
		obj.lang = $("#select_lang").val();
		obj.host = $("#select_channel").val();
		
		$.ajax({url : "/getUserCountry",
			data : JSON.stringify(obj),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
		}).success(function(result) {
			
			var getUserCountry = result.getUserCountry;
			
			var countryArray = new Array();
			
			if(getUserCountry != ""){
				for (var i = 0; i < getUserCountry.length; i++) {
					countryArray.push(JSON.parse(getUserCountry[i].content).country);
				}
			}
			
			var current = null;
			var cnt = 0;
			var countryMap = new Object();
			//country 정렬
			countryArray.sort();
			for(var i = 0; i < countryArray.length; i++){
				if(countryArray[i] != ""){
				    if(countryArray[i] != current){
				           current = countryArray[i];
				           cnt = 1; 
				    } else{
				        cnt++;
				        countryMap[current] = cnt;
				    }
				}
			}
			
			$('#map1').vectorMap({
		        map: 'world_mill_ko',
		        // panOnDrag: true,
		        zoomOnScroll: false,
		        regionStyle: {
		            initial: {
		                fill: '#f4f3ff'
		            },
		        },
		        focusOn: {
		            x: 0.5,
		            y: 0.5,
		            scale: 0,
		            animate: true
		        },
		        series: {
		            regions: [{
		                // [D] scale이 아닌 접속자 수에 따른 색상 변화가 필요합니다.
		                values: countryMap,
		                scale: ['#FFE2E2', '#710000'],
		                normalizeFunction: 'polynomial'
		            }]
	        	},
	        	onRegionTipShow: function(e, el, code){
	            if (countryMap[code] === undefined) {
	            	countryMap[code] = 0;
	            }
	            el.html(el.html()+' (Count : '+countryMap[code]+')');
	        }});
		    $('.jvectormap-container').css({'background-color' : 'rgb(255,255,255)'});
			
		}).fail(function(result) {
			console.log("ajax connection error: getUserCountry");
		});
	}
	
	function setEmail(){
		$("#email_input").addClass("on");
	}
	
	$(".btn_close").on("click", function(){
		$("#email_input").removeClass("on");
	});
	
	function updateEmail() {
		var obj = new Object();
		obj.email = $("#email_text").val();
		obj.host = $("#select_channel").val();
		
		$.ajax({url : "/updateEmailInfo",
			data : JSON.stringify(obj),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
		}).success(function(result) {
			$("#email_text").val("");
			$("#email_input").removeClass("on");
			alert("이메일이 수정되었습니다.");
		}).fail(function(result) {
			console.log("ajax connection error: updateEmailInfo");
		});
		
	}

	function excelDown(){
		
		var obj = new Object();
		
		var hotelNm = $("#select_channel option:selected").text();
		var hotelValue = $("#select_channel option:selected").val();
		var langValue = $("#select_lang option:selected").val();
		var fromDate = $("#fromDate").val();
		var toDate = $("#toDate").val();
		
		
		window.location= "${pageContext.request.contextPath}/chatExcelDown?hotelNm="+hotelNm+"&fromDate="+fromDate+"&toDate="+toDate+"&hotelValue="+hotelValue+"&langValue="+langValue;
		
		
	}
	
	</script>
	
</body>
</html>