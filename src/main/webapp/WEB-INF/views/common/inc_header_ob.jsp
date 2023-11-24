<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- #header -->
        <div id="header">
            <h1>
                <a><spring:message code="A0404" text="O/B 상담화면" /></a>
            </h1>
            
            <!-- .gnb -->
			<%@ include file="../common/inc_menu.jsp"%>
			<!-- //.gnb -->
			
            <!-- .lot_board_fix -->
            <div class="lot_board_fix">
	            <div class="groupBox bg_none">
					<div class="btnBox consultStatus">
						<button type="button" value="04" onclick="chOpStatus('04')"><spring:message code="A0015" text="수신대기" /></button>
						<button type="button" value="01" onclick="chOpStatus('01')"><spring:message code="A0016" text="업무" /></button>
						<button type="button" value="02" onclick="chOpStatus('02')"><spring:message code="A0017" text="휴게" /></button>
					</div>
				</div>
                <!-- .groupBox -->
                <div class="groupBox">
                    <div class="groupBox_tit"><spring:message code="A0018" text="총 현황" /></div>
                    <div class="groupBox_cont">
                        <dl class="groupBox_dlBox">
                            <dt><spring:message code="A0123" text="DB 기준" /></dt>
                            <dd>
                                <ul>
                                    <li>
                                        <strong><spring:message code="A0127" text="시도" /></strong>
                                        <span class="num" id ="TOTAL_TRY_CNT"></span>
                                    </li>
                                    <li>
                                        <strong><spring:message code="A0129" text="성공" /></strong>
                                        <span class="num" id ="TOTAL_SUC_CNT"></span>
                                    </li>
                                </ul>
                            </dd>
                        </dl>
                        <dl class="groupBox_dlBox">
                            <dt ><spring:message code="A0128" text="통화" /></dt>
                            <dd>
                                <span class="num" id ="TOTAL_CALL_CNT"></span>
                            </dd>
                        </dl>
                        <dl class="groupBox_dlBox">
                            <dt>시나리오</dt>
                            <dd>
                                <span class="num" id ="TOTAL_SCENARIO_CNT"></span>
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
                            <dt><spring:message code="A0126" text="DB 기준" /></dt>
                            <dd>
                                <ul>
                                    <li>
                                        <strong><spring:message code="A0127" text="시도" /></strong>
                                        <span class="num" id ="USER_TRY_CNT"></span>
                                    </li>
                                    <li>
                                        <strong><spring:message code="A0129" text="성공" /></strong>
                                        <span class="num" id ="USER_SUC_CNT"></span>
                                    </li>
                                </ul>
                            </dd>
                        </dl>
                        <dl class="groupBox_dlBox">
                            <dt><spring:message code="A0128" text="통화" /></dt>
                            <dd>
                                <span class="num" id ="USER_CALL_CNT"></span>
                            </dd>
                        </dl>
                        <dl class="groupBox_dlBox">
                            <dt>시나리오</dt>
                            <dd>
                                <span class="num" id ="USER_SCENARIO_CNT"></span>
                            </dd>
                        </dl>
                    </div>
                </div>
                <!-- //.groupBox -->
                <!-- .groupBox -->
                <!-- //.groupBox -->
            </div>
            <!-- //.lot_board_fix -->
         	
			<!-- .etc -->
			<%@ include file="../common/inc_profile.jsp"%>
		<!-- //.etc -->
        </div>
        <!-- //#header -->