<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

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

    <%--<%@ include file="../common/commonHeader.jspf" %>--%>

    <!-- icon_favicon -->
    <title><spring:message code="A0615" text="FAST 대화형 AI 서비스" /></title>
</head>

<body style="background: none">
<div>
	<form action="${pageContext.request.contextPath}/loginProcess" method="POST" class="loginForm" id="login_form" name="form-login">
		<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
        <input type="hidden" value="${username}"  name="username">
		<input type="hidden" value="${password}"  name="password">
	</form>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>

<script type="text/javascript">

    $(document).ready(function (){
    	login_form.submit();
    });
</script>

</body>
</html>