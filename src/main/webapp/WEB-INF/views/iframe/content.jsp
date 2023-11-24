<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	response.setHeader("P3P","CP='CAO PSA CONi OTR OUR DEM ONL'");
%>
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
<meta http-equiv="sss" content="no-cache">

<%@ include file="../common/inc_head_resources.jsp"%>
</head>

<body>
	<!-- .page loading -->
	<div id="pageldg" class="page_loading">
		<span class="out_bg"> <em> <strong>&nbsp;</strong> <strong>&nbsp;</strong> <strong>&nbsp;</strong> <b>&nbsp;</b>
		</em>
		</span>
	</div>
	<!-- //.page loading -->
	<!-- #wrap -->
	<div id="wrap">
		<input type="hidden" id= "headerName"  value="${_csrf.headerName}" />
		<input type="hidden" id= "token"  value="${_csrf.token}" />

		<jsp:include page="../common/inc_header.jsp"></jsp:include>
			<!-- #container -->
		<div id="container">
			<iframe id="portalFrame" name="iframe" frameborder="0" src="${url}?lang=${lang}"></iframe>
		</div>
	</div>
	<!-- //#wrap -->
    <%@ include file="../common/inc_footer.jsp" %>

	<!-- script -->
	<script type="text/javascript">
		<%
			response.setHeader("P3P","CP='CAO PSA CONi OTR OUR DEM ONL'");
		%>

		$(window).load(function() {
			var userId="${userId}";
			var companyId = "${companyId}";
			var chatbotList = "${chatbotList}";
			var isGroup = "${isGroup}";
			var maxChat = "${maxChat}";
			var userAuthTy = "${userAuthTy}";
			document.getElementById("portalFrame").contentWindow.postMessage({userId:userId, companyId:companyId, chatbotList:chatbotList, isGroup:isGroup, maxChat:maxChat, userAuthTy:userAuthTy}, '*');
		});

		window.addEventListener('message', requestChatbotBuilder, false);

		function requestChatbotBuilder(e) {
			var obj = new Object();
			obj.isGroup = e.data.isGroup;
			if (e.data.isInsert != undefined) {
				obj.host = e.data.host;

				$.ajax({
					url : "${pageContext.request.contextPath}/insertBotMapping",
					data : JSON.stringify(obj),
					method : 'POST',
					contentType : "application/json; charset=utf-8",
					beforeSend : function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
				}).success(function(result) {
					callbackResult('y');

				}).fail(function(result) {
					callbackResult('n');
				});

			} else if (e.data.check != undefined) {
				$.ajax({
					url : "${pageContext.request.contextPath}/maxChatbotCheck",
					data : JSON.stringify(obj),
					method : 'POST',
					contentType : "application/json; charset=utf-8",
					beforeSend : function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
				}).success(function(result) {
					if (result.result == true) {
						callbackResult('y');
					} else {
						callbackResult('n');
					}
				}).fail(function(result) {
					console.log("maxChatbotCheck error");
				});

			} else {
				obj.host = e.data.host;
				$.ajax({
					url : "${pageContext.request.contextPath}/delBotMapping",
					data : JSON.stringify(obj),
					method : 'POST',
					contentType : "application/json; charset=utf-8",
					beforeSend : function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
				}).success(function(result) {
					callbackResult('y');
				}).fail(function(result) {
					callbackResult('n');
				});
			}
		}

		function callbackResult(type) {
			document.getElementById("portalFrame").contentWindow.postMessage({callback:type}, '*');
		}



	</script>
</body>
</html>
