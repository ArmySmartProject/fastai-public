<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	<!-- #header -->
	<div id="header">
		<h1>
			<a><spring:message code="A0400" text="I/B 상담화면" /></a>
		</h1>
		
		<!-- .gnb -->
		<%@ include file="../common/inc_menu.jsp"%>
		<!-- //.gnb -->
		
		<!-- .lot_board_fix -->
		<div class="lot_board_fix">
			<!-- .groupBox -->
			<div class="groupBox bg_none">
				<div class="btnBox consultStatus">
					<button type="button" value="04" onclick="chOpStatus('04')"><spring:message code="A0015" text="수신대기" /></button>
					<button type="button" value="01" onclick="chOpStatus('01')"><spring:message code="A0016" text="업무" /></button>
					<button type="button" value="02" onclick="chOpStatus('02')"><spring:message code="A0017" text="휴게" /></button>
				</div>
			</div>
			<!-- //.groupBox -->
			<!-- .groupBox -->
			<div class="groupBox">
				<div class="groupBox_tit"><spring:message code="A0018" text="총 현황" /></div>
				<div class="groupBox_cont">
					<dl class="groupBox_dlBox">
						<dt><spring:message code="A0147" text="총 인입" /></dt>
						<dd>
							<span class="num" id ="TOTAL_CNT"></span>
						</dd>
					</dl>
					<dl class="groupBox_dlBox">
						<dt><spring:message code="A0020" text="응대" /></dt>
						<dd>
							<ul>
								<li><strong>Bot</strong> <span class="num" id ="BOT_CNT"></span></li>
								<li><strong>Bot+CSR</strong> <span class="num" id="BOT_CSR_CNT"></span></li>
								<li><strong>ETC</strong> <span class="num" id ="ETC_CNT"></span></li>
								<li><strong><spring:message code="A0250" text="계" /></strong> <span class="num" id ="TOTAL_SUM"></span></li>
							</ul>
						</dd>
					</dl>
					<dl class="groupBox_dlBox">
						<dt>시나리오</dt>
						<dd>
							<span class="num" id ="TOTAL_SCENARIO_CNT"></span>
						</dd>
					</dl>
					<dl class="groupBox_dlBox">
						<dt><spring:message code="A0025" text="대기고객" /></dt>
						<dd>
							<span class="num ft_clr_red">0</span>
						</dd>
					</dl>
				</div>
			</div>
			<!-- //.groupBox -->
			<!-- .groupBox -->
			<div class="groupBox">
				<div class="groupBox_tit"><spring:message code="A0026" text="나의 현황" /></div>
				<div class="groupBox_cont">
					<dl class="groupBox_dlBox">
						<dt><spring:message code="A0020" text="응대" /></dt>
						<dd>
							<ul>
								<li><strong>Bot</strong> <span class="num" id ="USER_BOT_CNT"></span></li>
								<li><strong>BOT+CSR</strong> <span class="num" id ="USER_BOT_CSR_CNT"></span></li>
								<li><strong>ETC</strong> <span class="num" id ="USER_ETC_CNT"></span></li>
								<li><strong><spring:message code="A0250" text="계" /></strong> <span class="num" id ="USER_TOTAL_CNT"></span></li>
							</ul>
						</dd>
					</dl>
					<dl class="groupBox_dlBox">
						<dt>시나리오</dt>
						<dd>
							<span class="num" id ="USER_SCENARIO_CNT"></span>
						</dd>
					</dl>
					<dl class="groupBox_dlBox">
						<dt><spring:message code="A0027" text="발신" /></dt>
						<dd>
							<span class="num">0</span>
						</dd>
					</dl>
					<dl class="groupBox_dlBox">
						<dt><spring:message code="A0028" text="총 통화시간" /></dt>
						<dd>
							<span class="time" id ="USER_TALK_TIME"></span>
						</dd>
					</dl>
					<dl class="groupBox_dlBox">
						<dt><spring:message code="A0029" text="평균 통화시간" /></dt>
						<dd>
							<span class="time" id ="AVR_TALK_TIME"></span>
						</dd>
					</dl>
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
	