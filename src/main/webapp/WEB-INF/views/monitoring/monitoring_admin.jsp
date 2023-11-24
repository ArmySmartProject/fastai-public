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
<input type="hidden" id= "headerName"  value="${_csrf.headerName}" />
<input type="hidden" id= "token"  value="${_csrf.token}" />
<input type="hidden" id="proxyUrl" value="${proxyUrl}">

    
	    <jsp:include page="../common/inc_header.jsp">
		    <jsp:param name="titleCode" value="A0006"/>
		    <jsp:param name="titleTxt" value="대시보드"/>
		</jsp:include>
		
        <!-- #container -->
        <div id="container">
        	<!-- .content -->
            <div class="content">
            <form autocomplete="off">
            	<input type="hidden"/>
                <!-- .titArea -->
                <div class="titArea">
                    <dl class="fl">
                    	<dt>company</dt>
                    	<dd>
                    		<select class="select" id="selectCompanyId">
                    		</select>
                    	</dd>
                    	<dt><spring:message code="A0144" text="기준일" /></dt>
                        <dd>
                            <div class="iptBox">
                                <input type="text" name="fromDate" id="fromDate" class="ipt_date">
                                <span>-</span>
                                <input type="text" name="toDate" id="toDate"  class="ipt_date">
                            </div>
                        </dd>
                    </dl>
                </div>
                <!-- //.titArea -->
                <!-- .stn -->
                <div class="stn allBoxType">
                    <div class="lotBox">
                        <div class="stn_tit">
                        	<h4><spring:message code="A0145" text="응대 현황" /></h4>
                            <div class="fr">
                            	<dl>
                                	<dt><spring:message code="A0144" text="기준일" />:</dt>
                                    <dd class="flagDate"></dd>
                                </dl>
                            </div>
                        </div>
                        <div class="stn_cont">
                        	<div class="h5BgBox">
                            	<div class="tit">
                                	<h5><spring:message code="A0146" text="전체현황" /></h5>
                                </div>
                                <div class="cnt">
                                	<table class="tbl_bg_lst02">
                                    <caption class="hide">응대 전체현황</caption>
                                    <colgroup>
                                    	<col><col><col><col><col>
                                        <col><col><col><col>
                                    </colgroup>
                                    <thead>
                                    	<tr>
                                        	<th scope="col" rowspan="2">&nbsp;</th>
                                            <th scope="col" rowspan="2"><spring:message code="A0147" text="총인입" /></th>
                                            <th scope="col" colspan="5"><spring:message code="A0020" text="응대" /></th>
                                            <th scope="col" rowspan="2"><spring:message code="A0150" text="포기" /></th>
                                            <th scope="col" rowspan="2"><spring:message code="A0027" text="발신" /></th>
                                        </tr>
                                    	<tr>
                                        	<th scope="col">Bot</th>
                                            <th scope="col">Bot+CSR</th>
                                            <th scope="col">Etc</th>
                                            <th scope="col">Total</th>
                                            <th scope="col"><spring:message code="A0149" text="응대율" />(%)</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<tr id="resConditionRow">
                                            <th scope="row">Call</th>
                                            <td><span class="bgBox" id="RES_TOTAL_CNT">${boardResCondition[0].TOTAL_CNT}</span></td>
                                            <td><span class="bgBox" id="RES_BOT_CNT">${boardResCondition[0].BOT_CNT}</span></td>
                                            <td><span class="bgBox" id="RES_BOT_CSR_CNT">${boardResCondition[0].BOT_CSR_CNT}</span></td>
                                            <td><span class="bgBox" id="RES_ETC_CNT">${boardResCondition[0].ETC_CNT}</span></td>
                                            <td><span class="bgBox" id="RES_TOTAL_SUM">${boardResCondition[0].TOTAL_SUM}</span></td>
                                            <td><span class="bgBox" id="RES_PERSENTAGE">${boardResCondition[0].PERSENTAGE}</span></td>
                                            <td><span class="bgBox" id="RES_GIVE_UP_CNT">${boardResCondition[0].GIVE_UP_CNT}</span></td>
                                            <td><span class="bgBox" id="RES_SEND_CNT">0</span></td>
                                        </tr>
                                    	<!-- <tr>
                                            <th scope="row">Chat</th>
                                            <td><span class="bgBox">50</span></td>
                                            <td><span class="bgBox">30</span></td>
                                            <td><span class="bgBox">20</span></td>
                                            <td><span class="bgBox">-</span></td>
                                            <td><span class="bgBox">90</span></td>
                                            <td><span class="bgBox">90.0%</span></td>
                                            <td><span class="bgBox">10</span></td>
                                            <td><span class="bgBox">40</span></td>
                                        </tr> -->
                                    </tbody>
                                    </table>
                                </div>
                            </div>
                        	<div class="h5BgBox">
                            	<div class="tit">
                                	<h5><spring:message code="A0153" text="상담 현황(실시간)" /></h5>
                                </div>
                                <div class="cnt">
                                	<table class="tbl_bg_lst02">
                                    <caption class="hide">응대 실시간 상담현황</caption>
                                    <colgroup>
                                    	<col><col><col><col><col>
                                        <col><col><col><col><col>
                                        <col><col>
                                    </colgroup>
                                    <thead>
                                    	<tr>
                                        	<th scope="col" rowspan="2">&nbsp;</th>
                                            <th scope="col" colspan="2"><spring:message code="A0154" text="IN-응대중" /></th>
                                            <th scope="col" colspan="2"><spring:message code="A0155" text="OUT-응대중" /></th>
                                            <th scope="col" colspan="3"><spring:message code="A0110" text="대기중" /></th>
                                            <th scope="col" colspan="2"><spring:message code="A0156" text="응대외" /></th>
                                        </tr>
                                    	<tr>
                                        	<th scope="col">Bot</th>
<!--                                             <th scope="col">CSR</th> -->
                                            <th scope="col">Total</th>
                                        	<th scope="col">Bot</th>
<!--                                             <th scope="col">CSR</th> -->
                                            <th scope="col">Total</th>
                                        	<th scope="col">Bot</th>
                                            <th scope="col">CSR</th>
                                            <th scope="col">Total</th>
                                        	<th scope="col"><spring:message code="A0016" text="업무" /></th>
                                            <th scope="col"><spring:message code="A0157" text="이석" /></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<tr id="csConditionRow">                                        	
                                            <th scope="row">Call</th>
                                            <td><span class="bgBox" id="CS_IB_BOT_CSR_CNT">${boardCsCondition[0].IB_BOT_CSR_CNT}</span></td>
<%--                                             <td><span class="bgBox" id="CS_IB_USER_CSR_CNT">${boardCsCondition[0].IB_USER_CSR_CNT}</span></td> --%>
                                            <td><span class="bgBox" id="CS_IB_BOT_CSR_CNT_CAL">${boardCsCondition[0].IB_BOT_CSR_CNT + boardCsCondition[0].IB_USER_CSR_CNT}</span></td>
                                            <td><span class="bgBox" id="CS_OB_BOT_CSR_CNT">${boardCsCondition[0].OB_BOT_CSR_CNT}</span></td>
<%--                                             <td><span class="bgBox" id="CS_OB_USER_CSR_CNT">${boardCsCondition[0].OB_USER_CSR_CNT}</span></td> --%>
                                            <td><span class="bgBox" id="CS_OB_BOT_CSR_CNT_CAL">${boardCsCondition[0].OB_BOT_CSR_CNT + boardCsCondition[0].OB_USER_CSR_CNT}</span></td>
                                            <td><span class="bgBox" id="CS_BOT_WAIT_CNT">${boardCsCondition[0].BOT_WAIT_CNT}</span></td>
                                            <td><span class="bgBox" id="CS_USER_WAIT_CNT">${boardCsCondition[0].USER_WAIT_CNT}</span></td>
											<!--  대기 중인 상담사 boardCsCondition[0].USER_WAIT_CNT -->
                                            <td><span class="bgBox" id="CS_BOT_WAIT_CNT_CAL">${boardCsCondition[0].BOT_WAIT_CNT}</span></td>
                                            <td><span class="bgBox" id="CS_USER_ETC_CNT">${boardCsCondition[0].USER_ETC_CNT}</span></td>
                                            <td><span class="bgBox" id="CS_USER_REST_CNT">${boardCsCondition[0].USER_REST_CNT}</span></td>
                                        </tr>
                                    	<!-- <tr>
                                            <th scope="row">Chat</th>
                                            <td><span class="bgBox">3</span></td>
                                            <td><span class="bgBox">2</span></td>
                                            <td><span class="bgBox">5</span></td>
                                            <td><span class="bgBox">0</span></td>
                                            <td><span class="bgBox">1</span></td>
                                            <td><span class="bgBox">1</span></td>
                                            <td><span class="bgBox">1</span></td>
                                            <td><span class="bgBox">2</span></td>
                                            <td><span class="bgBox">2</span></td>
                                            <td><span class="bgBox">1</span></td>
                                            <td><span class="bgBox">2</span></td>
                                        </tr> -->
                                    </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="lotBox">
                        <div class="stn_tit">
                        	<h4><spring:message code="A0008" text="콜 통계" /></h4>
                            <div class="fr">
                            	<dl>
                                	<dt><spring:message code="A0144" text="기준일" /> :</dt>
                                    <dd class="flagDate"></dd>
                                </dl>
                            	<%-- <dl class="op100">
                                	<dt><spring:message code="A0159" text="분석기준" /></dt>
                                    <dd>
                                    	<select class="select" id="searchType">
                                        	<option value="day"><spring:message code="A0160" text="전일기준" /></option>
                                            <option value="week"><spring:message code="A0161" text="전주동기기준" /></option>
                                            <option value="month"><spring:message code="A0162" text="전월동기기준" /></option>
                                            <option value="year"><spring:message code="A0163" text="전년동기기준" /></option>
                                        </select>
                                    </dd>
                                </dl> --%>
                            </div>
                        </div>
                        <div class="stn_cont">
                        	<div style="display:none;" id = "typeInfo">분석기준에 해당하지 않는 기간입니다. 분석기준이나 기준일을 수정해 주세요.</div>
                        	<div class="chart" style="height:215px;">
                            	<canvas id="barChart"></canvas>
                            	<span id="noData" style="position: absolute;top: 50%;left: 50%;">No data</span><!-- 차트가운데 정렬 -->
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //.stn -->
                <!-- .stn -->
                <!-- 
                <div class="stn allBoxType">
                    <div class="lotBox">
                        <div class="stn_tit">
                        	<h4>키워드 클라우드(상위50)</h4>
                            <div class="fr">
                            	<dl>
                                	<dt>기준일 :</dt>
                                    <dd>10-03~10-03</dd>
                                </dl>
                            </div>
                        </div>
                        <div class="stn_cont">
                        	<div class="chart" style="width:calc(100% - 180px); height:300px; padding:0 0 0 180px;">
                            	<div id="wordCloud" style="height:300px;"></div>
                                <ol class="ol_lst">
                                	<li><em>텍스트01 텍스트01 텍스트01</em><span>(340)</span></li>
                                    <li><em>텍스트02</em><span>(300)</span></li>
                                    <li><em>텍스트03</em><span>(270)</span></li>
                                    <li><em>텍스트04</em><span>(250)</span></li>
                                    <li><em>텍스트05</em><span>(240)</span></li>
                                </ol>
                            </div>
                        </div>
                    </div>
                    <div class="lotBox">
                        <div class="stn_tit">
                        	<h4>키워드 추이현황(최근 7일)</h4>
                            <div class="fr">
                            	<dl>
                                	<dt>기준일 :</dt>
                                    <dd>10-03</dd>
                                </dl>
                            </div>
                        </div>
                        <div class="stn_cont">
                        	<div class="chart" style="height:290px;">
                            	<canvas id="lineChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                 -->
                <!-- //.stn -->
                <!-- .stn -->
                <div class="stn allBoxType">
                    <div class="stn_tit">
                        <h4><spring:message code="A0166" text="실시간 상담현황" /></h4>
                        <div class="fr">
<!--                        <dl class="bgBox"> -->
<!--                            <dt>CALL</dt> -->
<!--                            <dd> -->
<!--                            	<dl> -->
<%--                                	<dt><spring:message code="A0167" text="상담중" /></dt> --%>
<!--                                    <dd> -->
<!--                                    	<dl> -->
<!--                                        	<dt>BOT</dt> -->
<!--                                            <dd>0</dd> -->
<!--                                        </dl> -->
<!--                                    	<dl> -->
<%--                                        	<dt><spring:message code="A0168" text="상담사" /></dt> --%>
<!--                                            <dd>0</dd> -->
<!--                                        </dl> -->
                                     
<!--                                    </dd> -->
<!--                                </dl> -->
<!--                            	<dl> -->
<%--                                	<dt><spring:message code="A0110" text="대기중" /></dt> --%>
<!--                                    <dd>0</dd> -->
<!--                                </dl> -->
<!--                            </dd> -->
<!--                        </dl> -->
                        </div>
                    </div>
                    <div class="stn_cont">
                    	<ul class="nav_tab">
                        	<li><a class="active" href="#">Call</a></li>
                            <li><a href="none" style="display:none;">Chat</a></li>
                        </ul>
                        <div class="tab_content">
                        	<div class="itemBox">
                            	<div class="tit">BOT</div>
                                <div class="cnt scroll">
                                	<ul class="lst_item" id="lst_item_bot">
<%--                                 		<c:forEach end="${fn:length(boardBotCondition)}" items="${boardBotCondition}" var="phoneItem" varStatus="statusMnt"> --%>
<%-- 	                                    	<c:choose> --%>
<%-- 	                                    		<c:when test="${phoneItem.STATUS eq 'CS0001'}"> --%>
<%-- 	                                    			<li class="item call_await" id="${phoneItem.SIP_USER}"> --%>
<%-- 	                                    		</c:when> --%>
<%-- 	                                    		<c:when test="${phoneItem.STATUS eq 'CS0002'}"> --%>
<%-- 	                                    			<li class="item call_ing" id="${phoneItem.SIP_USER}"> --%>
<%-- 	                                    		</c:when> --%>
<%-- 	                                    		<c:otherwise> --%>
<!-- 	                                    			<li class="item"> -->
<%-- 	                                    		</c:otherwise> --%>
<%-- 	                                    	</c:choose> --%>
<%-- 	                                    		<input type="hidden" id="${phoneItem.SIP_USER}_campId" value="${phoneItem.CAMPAIGN_ID}"/>  --%>
<!-- 	                                        	<span class="name"> -->
<%-- 	                                        		<spring:message code="A0249" text="음성봇" />${statusMnt.count}<br/>(${phoneItem.SIP_USER})  --%>
<!-- 	                                        	</span> -->
<!-- 	                                            <span class="ico"><em>상태 아이콘</em>대기중</span> -->
<%-- 	                                            <c:choose> --%>
<%-- 	                                    		<c:when test="${phoneItem.STATUS eq 'CS0001'}"> --%>
<%-- 		                                            <span class="time"><a><spring:message code="A0110" text="대기중" /></a><br />00:00:00</span> --%>
<%-- 	                                    		</c:when> --%>
<%-- 	                                    		<c:when test="${phoneItem.STATUS eq 'CS0002'}"> --%>
<%-- 		                                            <span class="time"><a><spring:message code="A0091" text="통화중" /></a><br />00:00:00</span> --%>
<%-- 	                                    		</c:when> --%>
<%-- 	                                    		<c:otherwise> --%>
<%-- 		                                            <span class="time"><a><spring:message code="A0114" text="연결안됨" /></a><br />00:00:00</span> --%>
<%-- 	                                    		</c:otherwise> --%>
<%-- 	                                    	</c:choose> --%>
<%-- 	                                            <span class="tutor">Tutor : ${phoneItem.CUST_OP_NM}</span><!-- 봇에 상담사를 할당해준 사람 --> --%>
<!-- 	                                        </li> -->
<%-- 	                                    </c:forEach> --%>
<%-- 	                                    <c:if test="${fn:length(boardBotCondition) < 10}"> --%>
<%-- 	                                		<c:forEach begin="1" end="${10 - fn:length(boardBotCondition)}" var="cnt"> --%>
<!-- 		                                    			<li class="item"> -->
<!-- 		                                        	<span class="name"> -->
<%-- 		                                        		<spring:message code="A0249" text="음성봇" /> ${ fn:length(boardBotCondition) + cnt}<br />() --%>
<!-- 		                                        	</span> -->
<!-- 		                                            <span class="ico"><em>상태 아이콘</em>대기중</span> -->
<%-- 		                                            <span class="time"><a><spring:message code="A0114" text="연결안됨" /></a><br />00:00:00</span> --%>
<%-- 		                                            <span class="tutor">Tutor : ${phoneItem.CUST_OP_NM}</span><!-- 봇에 상담사를 할당해준 사람 --> --%>
<!-- 		                                        </li> -->
<%-- 		                                    </c:forEach> --%>
<%-- 	                                    </c:if> --%>
                                    </ul>
                                </div>
                            </div>
<!--                         	<div class="itemBox"> -->
<%--                             	<div class="tit"><spring:message code="A0168" text="상담사" /></div>  --%>
<!--                                 <div class="cnt scroll"> -->
<!--                                 	<ul class="lst_item"> -->
<%--                                 		<c:forEach begin="1"  end="10" varStatus="varStaus"> --%>
<!--                                 			<li class="item"> -->
<%--                                         	<span class="name"><spring:message code="A0249" text="음성봇" />${varStaus.count}()</span> --%>
<!--                                             <span class="ico"><em>상태 아이콘</em></span> -->
<%--                                             <span class="time"><a><spring:message code="A0114" text="연결안됨" /></a><br />00:00:00</span> --%>
<%--                                             <span class="tutor">Tutor : <spring:message code="A0168" text="상담사" /></span> --%>
<!--                                         </li> -->
<%--                                 		</c:forEach> --%>
<!--                                     </ul> -->
<!--                                 </div> -->
<!--                             </div> -->
                        </div>
                    </div>
                </div>
                <!-- //.stn -->
                </form>
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
var myBar = null;
var wss_url = ""; //90배포용
var lang = $.cookie("lang");
jQuery.event.add(window,"load",function(){
	$(document).ready(function (){
		// 어제 날짜
		/* var nowDate = new Date();
		var yesterDate = nowDate.getTime() - (1 * 24 * 60 * 60 * 1000);
		nowDate.setTime(yesterDate);
		 
		var yesterYear = nowDate.getFullYear();
		var yesterMonth = nowDate.getMonth() + 1;
		var yesterDay = nowDate.getDate();
		        
		if(yesterMonth < 10){ yesterMonth = "0" + yesterMonth; }
		if(yesterDay < 10) { yesterDay = "0" + yesterDay; }
		        
		var resultDate = yesterYear + "-" + yesterMonth + "-" + yesterDay; */
		
		var tDate = new Date();
		tDate.setHours(-(24*7))
        tDate = getFormatDate(tDate);
        
        
		$("#fromDate").val(tDate);//기본값 오늘
		
		var tDate = new Date();
        tDate = getFormatDate(tDate);
		$("#toDate").val(tDate);//기본값 오늘
		
// 		var tDate = new Date();
// 		date.setHours(-(24*7))
//         tDate = getFormatDate(tDate);
// 		$("#fromDate").val(tDate);//기본값 7일전
		
// 		var tDate = new Date();
//         tDate = getFormatDate(tDate);
// 		$("#toDate").val(tDate);//기본값 오늘
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
				$("#toDate").datetimepicker('setStartDate',selectedDate.date);
			});
			
			$('#toDate').datepicker({
				format : "yyyy-mm-dd",
				language : "ko",
				autoclose : true,
				todayHighlight : true,
				defalutDate : new Date(),
				startDate: $("#fromDate").val()
			}).on('changeDate', function(selectedDate){
				$("#fromDate").datetimepicker('setEndDate',selectedDate.date);
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
				$("#toDate").datetimepicker('setStartDate',selectedDate.date);
			});
			
			$('#toDate').datepicker({
				format : "yyyy-mm-dd",
				language : "en",
				autoclose : true,
				todayHighlight : true,
				defalutDate : new Date(),
				startDate: $("#fromDate").val()
			}).on('changeDate', function(selectedDate){
				$("#fromDate").datetimepicker('setEndDate',selectedDate.date);
			});	
		}
		
		getCompanyId();
		
		$("#fromDate").on("change", function(e){
			refBoardDate();
		});
		
		$("#toDate").on("change", function(e){
			refBoardDate();
		});
		
		/* $("#searchType").on("change", function(e){
			refBoardDate();
		}); */
		
		
		$(".flagDate").text($("#fromDate").val()+" ~ "+$("#toDate").val());
		
// 		lineChart();
		
		//봇 연결
//		conn_main_ws('${websocketUrl}');
		
// 		barCahrt("${dashBoardCallTotalList}", '', true);
        
// 		refBoardDate();
		
	});
});

//company선택
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
			html +="<option value='All'><spring:message code='A0331' text='-전체-' /></option>"
			for(var i = 0; i < result.length; i++) {
				if(lang == "ko" || lang == null){
					html += "<option value='" + result[i].companyId + "'>" + result[i].companyId + " ["+ result[i].companyName +"]</option>"
				} else {
					html += "<option value='" + result[i].companyId + "'>" + result[i].companyId + " ["+ result[i].companyNameEN +"]</option>"
				}
			}
			
			$("#selectCompanyId").html(html);
			
			if(result.length == 1){
				$("#selectCompanyId option:eq(1)").attr("selected", "selected");
				$("#selectCompanyId").attr("disabled", "disabled");
			}
			
			lineChart();
			//봇 연결
			conn_main_ws('${websocketUrl}');
			
			barCahrt("${dashBoardCallTotalList}", '', true);
			
			refBoardDate();
			
			getBotStatus();
			
			$("#selectCompanyId").change(function(){
				getBotStatus();
				refBoardDate();
			});
			
		}else {
			alert("<spring:message code='A0333' text='CompanyId가 존재하지 않습니다.' />");
		}
		
	}).fail(function(result) {
		console.log("ajax connection error: getCompanyIdList");
	});
}

function getBotStatus() {
	var param = {companyId:$("#selectCompanyId option:selected").val()};
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
							  + "<span class='ico'><em>상태 아이콘</em></span><span class='callStatus'><a>"+botStatusText+"</a><br/></span>"
			}
			//class='time'
			var emptyBotHtml = "";
			if(result.length < 10){
				emptyBotHtml = makeEmptyBot(botLength, idx);
			}
			
			$("#lst_item_bot").html(existBotHtml + emptyBotHtml);
		}else {
			alert("BotStatusList dose not exist.");
		}
		
	}).fail(function(result) {
		console.log("ajax connection error: getBotStatusList");
	});
}

function makeEmptyBot(botLength, idx) {
	var emptyBot = "";
	for(var i=0; i < 10-botLength; i++){
		emptyBot += "<li class='item'><span class='name'><spring:message code='A0249' text='음성봇' />"+ idx++ +"<br>()</span><span class='ico'><em>상태 아이콘</em></span>"
					 + "<span><a><spring:message code='A0114' text='연결안됨' /></a><br/></span></li>";
	}
	return emptyBot;
}

function refBoardDate(){
	var toDate = $("#toDate").val();
	var fromDate  = $("#fromDate").val();
	
	fromDate = fromDate.replace(/-/gi, "");
	toDate = toDate.replace(/-/gi, "");
	
	
	if(toDate<fromDate){
		alert("<spring:message code='A0639' text='시작일이 종료일보다 빨라야합니다.' />");
	}else{
		$(".flagDate").text($("#fromDate").val()+" ~ "+$("#toDate").val());
		var compareYn = ckSearchType();
		refBoardCondition(compareYn);
	}
	
}

//응대현황, 문의유형 현황만 일단 조회
function refBoardCondition(compareYn){
	
	var json = {};
	//var searchType = $("#searchType").val();
	var startDt = $("#fromDate").val();
	var endDt = $("#toDate").val();
	var companyId = $("#selectCompanyId option:selected").val();
	
	//json.searchType = searchType;
	json.startDt = startDt;
	json.endDt = endDt;
	json.companyId = companyId;
	
	//문의유형 (기준, 비교) 조회
	httpSend("${pageContext.request.contextPath}/getBoardCsTypeCondition", $("#headerName").val(), $("#token").val(),	JSON.stringify(json)
			, function(res){
				res = JSON.parse(res);
				
				barCahrt(res.dashBoardCallTotalList, '', compareYn);
				
			}
	);
	
	//응대현황 조회
	getResAndCsCondition(json, "res");
	//상담현황 조회
	getResAndCsCondition(json, "cs");
	
}

//응대현황 조회
function getResAndCsCondition(json, type){
	httpSend("${pageContext.request.contextPath}/boardResAndCsCondition", $("#headerName").val(), $("#token").val(),	JSON.stringify(json)
			, function(res){
				res = JSON.parse(res);
				setCondition(res, type);
			}
	);
}

/*
문의유형 현황  case
아래 기준과 다르면 기준일 데이터만 뿌려주고 alert

1. 분석기준 > 전일기준
	fdt ~ tdt 가 하루보다 크면  
2. 분석기준 > 전주동기
	fdt ~ tdt 가 일~토 기간 이내여야 함.
3. 분석기준 > 전월동기
	fdt ~ tdt 가 조회월 이내의 기간이여야 함 ex) 11.20~12.5 > X
4. 분석기준 > 전년동기
	fdt ~ tdt 가 조회년 이내의 기간이여야 함
*/
function ckSearchType(){
	
	//var searchType = $("#searchType").val();
	var sDt = $("#fromDate").val();
	var eDt = $("#toDate").val();
	
	var tempStDay = new Date(sDt);
	var tempEdDay = new Date(eDt);
	
	var sDay = tempStDay.getDay();//요일
	var eDay = tempEdDay.getDay();//요일
	
	sDt = sDt.replace(/-/gi, "");//20200317
	eDt = eDt.replace(/-/gi, "");//20200317
	
	var sMonth = sDt.substring(4,6);//03 
	var eMonth = eDt.substring(4,6);//03
	
	var sYear = sDt.substring(2,4);//20 
	var eYear = eDt.substring(2,4);//20 
	
	var res = true;//RETURN
	
	//debugger;
	
	/* if(searchType == "day"){
		if(eDt - sDt < 1){
			res = true;
		}
	}else if(searchType == "week"){
		
		
		//일 : 0, 토 : 6
		//같은주 이려면
		//1. edt - sdt <7
		//2. sdt.getDay - edt.getDay 음수 
		
		if(eDt - sDt < 7 && sDay - eDay < 0){
			res = true;
		}
		
	}else if(searchType == "month"){
		//연도, 달이 같아야함
		if(eMonth == sMonth && sYear == eYear){
			res = true;
		}
			
	}else if(searchType == "year"){
		 
		if(sYear == eYear){
			res = true;
		}
		
	} */
	
	if(!res){
		$("#typeInfo").show();
		//alert("문의유형 > 분석기준에 해당하지 않는 기간입니다. 분석기준이나 기준일을 수정해 주세요.");
	}else{
		$("#typeInfo").hide();	
	}
	
	return res;
}
//lineChart
function lineChart() {
	
	return;
	
	//4번째	
	var ctx = document.getElementById("keyWorkLineChart");
	var keyWorkLineChart = new Chart(ctx, {
		type : 'line',
		data : {
			labels : [],
			datasets : []
		},
		options : {
			responsive : false, //크기
			//maintainAspectRatio: false, //사이즈 
			legend : {
				display : false, //데이터셋 라벨 제거
			}
		}
	});
}

function barCahrt(cont1, cont2, compareYn){
	
/* 	var labelArr = [];
	var labelArrTest;
	var scale = 1;
	var maxHeight = 0; */
	
	if(cont1.length < 1){
		$("#noData").show();
		if(myBar != null){
			myBar.destroy();
		}
		return false;
	}else{
		$("#noData").hide();
	} 
	var arrDate = new Array();                     // DATE  날짜  
	var arrIncomingCount = new Array();       // INCOMING_COUNT 총인입  
	var arrBotCount = new Array();               // BOT_COUNT  Bot응대
	var arrInterventCount = new Array();       // INTERVENT_COUNT  개입응대
	var arrOpCount = new Array();                // OP_COUNT  휴먼응대
	var arrGiveUpCount = new Array();          // GIVE_UP_COUNT  포기호 
	var arrFollowUpCallCount = new Array(); 
	
	$.each(cont1, function(key, value){
		arrDate[key] = value.DATE;
		arrIncomingCount[key] = value.TOTAL_CNT;
		arrBotCount[key] = value.BOT_CNT;
		arrInterventCount[key] = value.BOT_CSR_CNT;
		arrOpCount[key] = value.ETC_CNT;
		arrGiveUpCount[key] = value.GIVE_UP_CNT;
		arrFollowUpCallCount[key] = 0;	
	});	
	
	/* $.each(cont1, function(i, v){
		var label = {};
		label.CAMPAIGN_ID = v.CAMPAIGN_ID;
		label.CONSULT_TYPE_CD = v.CONSULT_TYPE_CD;
		label.CONSULT_TYPE_NM = v.CONSULT_TYPE_NM;
		label.dup = false;
		//labelArr[i] =  label;
		labelArr.push(label);
	});
	
	 if(labelArr.length < 1){
		$("#noData").show();
		if(myBar != null){
			myBar.destroy();
		}
		return false;
	}else{
		$("#noData").hide();
	} 
	
	labelArrTest = JSON.parse(JSON.stringify(labelArr));
	
	for (var i=0; i<labelArr.length; i++){
		for (var j=i+1; j<labelArr.length; j++){
			if(JSON.stringify(labelArr[i]) == JSON.stringify(labelArr[j])){
				labelArrTest[i].dup = true;
			}
		}	
	}
	labelArrTest = labelArrTest.filter(function(el){return el != null});
	
	var labels = [];
	$.each(labelArrTest, function(i, v){
		if(labelArrTest[i].dup != true){
			labels[i] = labelArrTest[i].CONSULT_TYPE_NM; 
		}
	});
	labels = labels.filter(function(el){return el != null});
	
	var todayData = [];
	var daybeforeData = [];
	
	//기준일
	$.each(labelArrTest, function(i, v){
		
		if(v.dup == false){//1. 중복아닌헤더
			$.each(cont1, function(j, jv){
				
				//2. 만들어진 헤더의 캠페인과 카테고리 코드가 같으면 카운트를 데이터에 집어넣음	
				if(jv.CAMPAIGN_ID == v.CAMPAIGN_ID && jv.CONSULT_TYPE_CD == v.CONSULT_TYPE_CD){
					todayData[i] = jv.CONSULT_TYPE_CNT;
				}
			});
		
			if(todayData[i] == null || todayData[i] == ""){
				todayData[i] = 0;
			}
		}
	});
	
	todayData = todayData.filter(function(el){return el != null});
	
	//var searchType = $("#searchType option:selected").text();
	//var dateLabel1 = searchType+"("+$("#fromDate").val()+"~"+$("#toDate").val()+")"; //기준일
	var dateLabel1 = "("+$("#fromDate").val()+"~"+$("#toDate").val()+")"; //기준일
	
	var dateLabel2 = ""; //비교일
	
	if(compareYn){
		$.each(cont2, function(i, v){
			if(i == 0){
				//dateLabel2 = searchType+"("+v.COMPARE_SDT+"~"+v.COMPARE_EDT+")"; //비교일	
				dateLabel2 = "("+v.COMPARE_SDT+"~"+v.COMPARE_EDT+")"; //비교일	
			}
		});
	}else{
		//dateLabel2 = searchType; //비교일
	}
	
	var arrAll = [];
	
	//스케일, 최대값 생성
	if(compareYn){
		arrAll = arrAll.concat(daybeforeData, todayData);
	}else{
		arrAll = arrAll.concat(todayData);
	}
	
	maxHeight = Math.max.apply(null, arrAll);//최대값
	scale = Math.pow(10, maxHeight.toString.length);
	maxHeight = Math.ceil(maxHeight/scale)*scale; 
	*/
	
	var barChartData = {
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
		            label: 'Bot',
		            fill: false,
		            backgroundColor: window.chartColors.orange,
		            borderColor: window.chartColors.orange,
		            data:arrBotCount,
		        }, {
		            label: 'Bot+CSR',
		            fill: false,
		            backgroundColor: window.chartColors.yellow,
		            borderColor: window.chartColors.yellow,
		            data: arrInterventCount,
		        }, {
		        	label: 'ETC',
		            fill: false,
		            backgroundColor: window.chartColors.green,
		            borderColor: window.chartColors.green,
		            data: arrOpCount,
		        }, {
		        	label: '<spring:message code="A0150" text="포기"/>',
		            fill: false,
		            backgroundColor: window.chartColors.blue,
		            borderColor: window.chartColors.blue,
		            data: arrGiveUpCount,
		        }, {
		        	label: '<spring:message code="A0027" text="발신"/>',
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
		                    display: false,
		                    labelString: 'Value'
		                }
		            }]
		        }
		    }
		};

	/* var chartOption = {
		    type: 'bar',
		    data: barChartData,
		    options: {
		        maintainAspectRatio: false,
		        responsive: true,
		        title: {
		            display: false,
		            text: '문의유형 현황'
		        },
		        tooltips: {
		            mode: 'index',
		            intersect: true
		        },
				legend: {
					display: false
				},
		        scales: {
		            yAxes: [{
		                type: 'linear', // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
		                display: true,
		                position: 'left',
		                id: 'y-bar-1',
		                ticks:{
		            		min:0,
		            		max:maxHeight,
		            		stepSize:scale
		            	}	
		            }, {
		                type: 'linear', // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
		                display: false,
		                position: 'right',
		                id: 'y-bar-2',
		                gridLines: {
		                    drawOnChartArea: false
		                },ticks:{
		            		min:0,
		            		max:maxHeight,
		            		stepSize:scale
		            	}	
		            }],
		        }
		    }
		}; */
	
		var barChart = document.getElementById('barChart').getContext('2d');
		
		if(myBar == null){
			myBar = new Chart(barChart, barChartData);
		}else{
			myBar.destroy();
			myBar = new Chart(barChart, barChartData);
		}
}

function setCondition(res, type){
	
	console.log("???");
	console.log(res);
	
	if(type == "res"){
		//전체현황
		$.each($("#resConditionRow > td")
				, function(i,v){
					$.each(res.boardResCondition[0], function(key, value){
						if($(v).children("span").attr("id") == "RES_"+key){
							$(v).children("span").text(value);
							if($(v).children("span").attr("id") == "RES_PERSENTAGE"){
								$(v).children("span").text(value + "%");	
							}
						}
					});
				}		
		);
	}else if(type == "cs"){
		//상담현황
		var CS_IB_BOT_CSR_CNT_CAL = res.boardCsCondition[0].IB_BOT_CSR_CNT+res.boardCsCondition[0].IB_USER_CSR_CNT;
		var CS_OB_BOT_CSR_CNT_CAL = res.boardCsCondition[0].OB_BOT_CSR_CNT+res.boardCsCondition[0].OB_USER_CSR_CNT;
		var CS_BOT_WAIT_CNT_CAL = res.boardCsCondition[0].BOT_WAIT_CNT+res.boardCsCondition[0].USER_WAIT_CNT;
		
		$.each($("#csConditionRow > td")
				, function(i,v){
					$.each(res.boardCsCondition[0], function(key, value){
						if($(v).children("span").attr("id") == "CS_"+key){
							$(v).children("span").text(value);	
						}else if($(v).children("span").attr("id").indexOf("_CAL") != -1){
							if($(v).children("span").attr("id") == "CS_IB_BOT_CSR_CNT_CAL"){
								$(v).children("span").text(CS_IB_BOT_CSR_CNT_CAL);	
							}else if($(v).children("span").attr("id") == "CS_OB_BOT_CSR_CNT_CAL"){
								$(v).children("span").text(CS_OB_BOT_CSR_CNT_CAL);	
							}else if($(v).children("span").attr("id") == "CS_BOT_WAIT_CNT_CAL"){
								$(v).children("span").text(CS_BOT_WAIT_CNT_CAL);	
							}
						}
					});
				}		
		);
	}
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
				refBoardDate();
				if (rcv_data.call_status == "CS0002") {//전화 연결중인결우
					$("#" + rcv_data.Agent).removeClass("call_await").addClass("call_ing");
					$("#" + rcv_data.Agent).find(".callStatus a").text("<spring:message code='A0091' text='통화중' />");
				} else if (rcv_data.call_status == "CS0006") {
					$("#" + rcv_data.Agent).removeClass("call_await").addClass("call_ing");
					$("#" + rcv_data.Agent).find(".callStatus a").text("<spring:message code='A0091' text='통화중' />");
	            } else if (rcv_data.call_status == "CS0003") {
	            	$("#" + rcv_data.Agent).removeClass("call_ing").addClass("call_await");
	            	$("#" + rcv_data.Agent).find(".callStatus a").text("<spring:message code='A0110' text='대기중' />");
	            } else {
	            	$("#" + rcv_data.Agent).removeClass("call_ing").addClass("call_await");
	            	$("#" + rcv_data.Agent).find(".callStatus a").text("<spring:message code='A0110' text='대기중' />");
	            }
			}
		}
	};
}

//날짜선택 콜백함수
function setDate(text, inst){
	console.log(text);
	console.log(inst);
}

</script>
<script type="text/javascript">
// chart

/* 
// chart
var lineChartData = {
    type: 'line',
    data: {
        labels: ['19-09-27','19-09-28','19-09-29','19-09-30','19-10-01','19-10-02','19-10-03'],
        datasets: [{
            label: '가격문의',
			fill: false,
            backgroundColor: window.chartColors.red,
            borderColor: window.chartColors.red,
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ],
        }, {
            label: '사용법문의',
            fill: false,
            backgroundColor: window.chartColors.orange,
            borderColor: window.chartColors.orange,
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ],
        }, {
            label: '가입절차문의',
            fill: false,
            backgroundColor: window.chartColors.yellow,
            borderColor: window.chartColors.yellow,
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ],
        }, {
            label: '환불문의',
            fill: false,
            backgroundColor: window.chartColors.green,
            borderColor: window.chartColors.green,
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ],
        }, {
            label: '성능불만문의',
            fill: false,
            backgroundColor: window.chartColors.blue,
            borderColor: window.chartColors.blue,
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ],
        }, {
            label: '상품(TSS)문의',
            fill: false,
            backgroundColor: window.chartColors.purple,
            borderColor: window.chartColors.purple,
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ],
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
            text: '키워드 추이현황(최근7일)'
        },
        tooltips: {
            mode: 'index',
            intersect: false,
        },
        hover: {
            mode: 'nearest',
            intersect: true
        },
        scales: {
            xAxes: [{
                display: true,
                scaleLabel: {
                    display: false,
                    labelString: '최근7일'
                }
            }],
            yAxes: [{
                display: true,
                scaleLabel: {
                    display: false,
                    labelString: 'Value'
                }
            }]
        }
    }
};
var lineChart = document.getElementById('lineChart').getContext('2d');
window.myLine = new Chart(lineChart, lineChartData); */
</script>
<script type="text/javascript">
var wordCloud = [
	{text:'텍스트01', weight:10,},
	{text:'텍스트02', weight:9,},
	{text:'텍스트03', weight:8},
	{text:'텍스트04', weight:7},
	{text:'텍스트05', weight:6},
	{text:'텍스트06', weight:5},
	{text:'텍스트07', weight:4},
	{text:'텍스트08', weight:3},
	{text:'텍스트09', weight:2},
	{text:'텍스트10', weight:1},
	{text:'텍스트11', weight:1},
	{text:'텍스트12', weight:1},
	{text:'텍스트13', weight:1},
	{text:'텍스트14', weight:1},
	{text:'텍스트15', weight:1},
	{text:'텍스트16', weight:1},
	{text:'텍스트17', weight:1},
	{text:'텍스트18', weight:1},
	{text:'텍스트19', weight:1},
	{text:'텍스트20', weight:1},
	{text:'텍스트21', weight:1},
	{text:'텍스트22', weight:1},
	{text:'텍스트23', weight:1},
	{text:'텍스트24', weight:1},
	{text:'텍스트25', weight:1},
	{text:'텍스트26', weight:1},
	{text:'텍스트27', weight:1},
	{text:'텍스트28', weight:1},
	{text:'텍스트29', weight:1},
	{text:'텍스트30', weight:1},
	{text:'텍스트31', weight:1},
	{text:'텍스트32', weight:1},
	{text:'텍스트33', weight:1},
	{text:'텍스트34', weight:1},
	{text:'텍스트35', weight:1},
	{text:'텍스트36', weight:1},
	{text:'텍스트37', weight:1},
	{text:'텍스트38', weight:1},
	{text:'텍스트39', weight:1},
	{text:'텍스트40', weight:1},
	{text:'텍스트41', weight:1},
	{text:'텍스트42', weight:1},
	{text:'텍스트43', weight:1},
	{text:'텍스트44', weight:1},
	{text:'텍스트45', weight:1},
	{text:'텍스트46', weight:1},
	{text:'텍스트47', weight:1},
	{text:'텍스트48', weight:1},
	{text:'텍스트49', weight:1},
	{text:'텍스트50', weight:1},
];
	
$('#wordCloud').jQCloud(wordCloud, {
  autoResize: true,
});
</script>

</body>
</html>
