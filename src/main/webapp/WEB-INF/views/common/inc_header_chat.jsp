<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	<!-- #header -->
	<div id="header">
		<h1>
			<a><spring:message code="A0004" text="채팅상담" /></a>
		</h1>
		
		<!-- .gnb -->
		<%@ include file="../common/inc_menu.jsp"%>
		<!-- //.gnb -->
		
		<!-- .lot_board_fix -->
		<div class="lot_board_fix">
			<!-- .groupBox -->
			<div class="groupBox chat_bg">
				<div class="btnBox consultStatus">
					<button type="button" value="01" <c:if test="${chatConsultStatus eq '01'}">class="active"</c:if> onclick="chOpStatus('01')"><spring:message code="A0167" text="상담중" /></button>
					<button type="button" value="02" <c:if test="${chatConsultStatus eq '02'}">class="active"</c:if> onclick="chOpStatus('02')"><spring:message code="A0904" text="부재중" /></button>
				</div>
			</div>
			<!-- //.groupBox -->
		</div>
		<!-- //.lot_board_fix -->
		
		<!-- .etc -->
		<%@ include file="../common/inc_profile.jsp"%>
		<!-- //.etc -->
	</div>
	<!-- //#header -->
	