<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	String titleCode = (String)request.getParameter("titleCode");
	String titleTxt = (String)request.getParameter("titleTxt");

%>

<c:set value="<%=titleCode%>" var="titleCode"/>
<c:set value="<%=titleTxt%>" var="titleTxt"/>
<!-- #header -->
<div id="header">
	<h1>
		<c:choose>
			<c:when test="${titleCode eq 'A0940'}">
				<a href="/storeLicense">${lang=="en"?"License Insert/History":titleTxt}</a>
			</c:when>
			<c:otherwise>
				<a href="${menuVo.userMenuUrl}">${lang=="en"?menuVo.menuNmEn:menuVo.menuNmKo}</a>
			</c:otherwise>
		</c:choose>
<%--		BETA VER 사용 예시--%>
<%--		<c:if test="${menuVo.menuNmKo eq '챗봇빌더(유저)' || menuVo.menuNmKo eq '챗봇빌더(회사)'}">--%>
<%--			<span class="icon_beta">BETA VER.</span>--%>
<%--		</c:if>--%>
	</h1>
	
	<!-- .gnb -->
	<%@ include file="../common/inc_menu.jsp"%>
	<!-- //.gnb -->
	
	<!-- .etc -->
	<%@ include file="../common/inc_profile.jsp"%>
	<!-- //.etc -->
</div>
<!-- //#header -->
