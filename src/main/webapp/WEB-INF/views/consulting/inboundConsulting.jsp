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

<body class="gcsWrap">
<c:forEach end="${fn:length(phoneListResult)}" items="${phoneListResult}" var="botToAudio" varStatus="audioCnt">
	<audio id="alarmAudio_${botToAudio.sipUser}" src="${pageContext.request.contextPath}/resources/audio/telephone-ring-10sec.wav" muted="muted" autoplay ></audio>
</c:forEach>
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
	<input type="hidden" id= "csType"  value="${csType}" />
	<input type="hidden" id="OP_LOGIN_ID">
	<input type="hidden" id="voiceUrl" value="${voiceUrl}">
	<input type="hidden" id="proxyUrl" value="${proxyUrl}">
	<input type="hidden" id="handleCsInfoType" value="update"/>
	<input type="hidden" id="consultantType" value="false"/>

	<%@ include file="../common/inc_header_ib.jsp"%>
	<!-- #container -->
	<div id="container">

		<!-- .section -->
		<div class="section">
			<!-- //.tab_calling -->
			<div class="tab_calling_view">
				<div class="tbl_cell" style="width: 30%;">
					<!-- .callView -->
					<div class="callView">
						<!-- .callView_tit -->
						<div class="callView_tit" style="background: #7a7786;">
							<h3><spring:message code="A0014" text="고객정보" /></h3>
						</div>
						<!-- //.callView_tit -->
						<!-- .callView_cont -->
						<div class="callView_cont" id="userCont">
							<!-- .cont_cell -->
							<div class="cont_cell">
								<table class="tbl_line_view" id="USER_TABLE" summary="번호/구간/탐지로 구성됨">
									<caption class="hide"><spring:message code="A0065" text="상담내용" /></caption>
									<colgroup>
										<col width="75">
										<col>
										<col width="75">
										<col>
									</colgroup>
									<tbody>
									<input type="hidden" class="USER_CUST_ID" name="USER_CUST_ID">
									<tr>
										<th scope="row"><spring:message code="A0039" text="성명" /></th>
										<td class ="USER_CUST_NM USER_TABLE_DEL"></td>
										<th><spring:message code="A0050" text="Chat ID" /></th>
										<td class ="USER_CONSULT_CHAT_ID USER_TABLE_DEL"></td>
									</tr>
									<tr>
										<th scope="row"><spring:message code="A0040" text="고객구분" /></th>
										<td>
											<div class="radioBox purple">
												<input type="radio" name="user_ipt_radio" id="individual" class="ipt_radio"   value="0" disabled> <label for="individual" style="cursor: default"><spring:message code="A0041" text="개인" /></label>
												<input type="radio" name="user_ipt_radio" id="corporate "	class="ipt_radio"  value="1" disabled> <label for="corporate" style="cursor: default"><spring:message code="A0042" text="법인" /></label>
											</div>
										</td>
										<th><spring:message code="A0051" text="현상태" /></th>
										<td class="USER_CUST_STATE_NM USER_TABLE_DEL"></td>
									</tr>
									<tr>
										<th scope="row"><spring:message code="A0043" text="구독플랜" /></th>
										<td class="USER_CUST_SUBSC_PLAN USER_TABLE_DEL"></td>
										<th><spring:message code="A0052" text="API계정 ID" /></th>
										<td class="USER_CUST_API_ID USER_TABLE_DEL"></td>
									</tr>
									<tr>
										<th><spring:message code="A0044" text="가입경로" /></th>
										<td class="USER_CUST_REG_PATH USER_TABLE_DEL"></td>
										<th scope="row"><spring:message code="A0053" text="API계정 Key" /></th>
										<td class="USER_CUST_API_KEY USER_TABLE_DEL"></td>
									</tr>
									<tr>
										<th scope="row" ><spring:message code="A0045" text="가입일" /></th>
										<td class="USER_CUST_REG_DATE USER_TABLE_DEL"></td>
										<th><spring:message code="A0054" text="해지일" /></th>
										<td class="USER_CUST_TERM_DATE USER_TABLE_DEL"></td>
									</tr>
									<tr>
										<th scope="row"><spring:message code="A0046" text="자택주소" /></th>
										<td colspan="3" class="USER_CUST_ADDRESS USER_TABLE_DEL"></td>
									</tr>
									<tr>
										<th scope="row"><spring:message code="A0047" text="직장주소" /></th>
										<td colspan="3" class="USER_CUST_ADDRESS2 USER_TABLE_DEL"></td>
									</tr>
									<tr>
										<th scope="row"><spring:message code="A0048" text="이메일" /></th>
										<td><a class="link" href=""><span class="USER_CUST_EMAIL USER_TABLE_DEL"></span></a></td>
										<th><spring:message code="A0055" text="자택전화" /></th>
										<td >
											<button type="button" class="btn_ico call "></button>
											<span class="USER_CUST_HOME_NO USER_TABLE_DEL"></span>
										</td>
									</tr>
									<tr>
										<th scope="row"><spring:message code="A0049" text="이동전화" /></th>
										<td >
											<button type="button" class="btn_ico call"></button>
											<span class="USER_CUST_TEL_NO USER_TABLE_DEL"></span>
										</td>
										<th><spring:message code="A0056" text="직장전화" /></th>
										<td>
											<button type="button" class="btn_ico call"></button>
											<span class="USER_CUST_COMPANY_NO USER_TABLE_DEL"></span>
										</td>
									</tr>
									<tr>
										<th scope="row"><spring:message code="A0057" text="결제정보" /></th>
										<td colspan="3">
											<div class="dlBox_bg">
												<dl>
													<dt><spring:message code="A0058" text="카드정보" /></dt>
													<dd class="PAY_CARD_INFO USER_TABLE_DEL"></dd>
												</dl>
												<dl>
													<dt><spring:message code="A0043" text="구독플랜" /></dt>
													<dd class="PAY_CUST_SUBSC_PLAN USER_TABLE_DEL"></dd>
												</dl>
												<dl>
													<dt><spring:message code="A0059" text="최근 결제일" /></dt>
													<dd class="PAY_RECENT_PAYMENT_DATE USER_TABLE_DEL"></dd>
												</dl>
												<dl>
													<dt><spring:message code="A0060" text="다음 결제일" /></dt>
													<dd class="PAY_NEXT_PAYMENT_DATE USER_TABLE_DEL"></dd>
												</dl>
												<dl>
													<dt><spring:message code="A0061" text="결제금액" /></dt>
													<dd class="PAY_PAY_AMOUNT USER_TABLE_DEL"></dd>
												</dl>
												<dl>
													<dt><spring:message code="A0062" text="결제예정금액" /></dt>
													<dd class="PAY_EXPECTED_PAY_AMOUNT USER_TABLE_DEL"></dd>
												</dl>
											</div>
										</td>
									</tr>
									</tbody>
								</table>
							</div>
							<!-- //.cont_cell -->
						</div>
						<!-- //.callView_cont -->
						<div class="btnBox sz_small line">
							<button type="button" class="btnS_basic btn_userInfoModify btn_lyr_open" onclick="openInfoLayer('update')" disabled="disabled"><spring:message code="A0063" text="정보변경" /></button>
							<button type="button" class="btnS_basic btn_userInfoModify btn_lyr_open" onclick="openInfoLayer('insert')"><spring:message code="A0265" text="신규등록" /></button>
						</div>
					</div>
					<!-- //.callView -->
				</div>
				<!-- //.tbl_cell -->
				<div class="tbl_cell" style="width: 30%;">
					<!-- .callView -->
					<div class="callView">
						<!-- .callView_tit -->
						<div class="callView_tit" style="background: #7a7786;">
							<h3><spring:message code="A0065" text="상담내용" /></h3>
						</div>
						<!-- //.callView_tit -->
						<!-- .callView_cont -->
						<div class="callView_cont">
							<!-- .cont_cell -->
							<div class="cont_cell">
								<table id="CSDTL_TABLE" class="tbl_line_view" summary="상담유형/상담내용 메모/재통화/이관로 구성됨">
									<caption class="hide">상담내용</caption>
									<colgroup>
										<col width="70">
										<col>
									</colgroup>
									<tbody>
									<input type="hidden" id="CSDTL_CALL_ID">
									<input type="hidden" id="CSDTL_CONTRACT_NO">
									<input type="hidden" id="CSDTL_CAMPAIGN_ID">
									<input type="hidden" id="CSDTL_NEW_CONTRACT_NO">
									<input type="hidden" id="CSDTL_NEW_CALL_NO">
									<tr>
										<th scope="row"><spring:message code="A0066" text="상담유형1" /></th>
										<td>
											<div class="selectBox">
												<select class="select" id="cst1_1" disabled="disabled">
													<option value="999" selected ><spring:message code="A0069" text="-선택-" /></option>
												</select> <select class="select"  id="cst1_2" disabled="disabled">
												<option value="999" selected><spring:message code="A0069" text="-선택-" /></option>
											</select> <select class="select" id="cst1_3" disabled="disabled">
												<option value="999" selected><spring:message code="A0069" text="-선택-" /></option>
											</select>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><spring:message code="A0067" text="상담유형2" /></th>
										<td>
											<div class="selectBox">
												<select class="select" id="cst2_1" disabled="disabled">
													<option value="999" selected><spring:message code="A0069" text="-선택-" /></option>
												</select> <select class="select" id="cst2_2" disabled="disabled">
												<option value="999" selected><spring:message code="A0069" text="-선택-" /></option>
											</select> <select class="select" id="cst2_3" disabled="disabled">
												<option value="999" selected><spring:message code="A0069" text="-선택-" /></option>
											</select>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><spring:message code="A0068" text="상담유형3" /></th>
										<td>
											<div class="selectBox">
												<select class="select" id="cst3_1" disabled="disabled">
													<option value="999" selected><spring:message code="A0069" text="-선택-" /></option>
												</select>
												<select class="select" id="cst3_2" disabled="disabled">
													<option value="999" selected><spring:message code="A0069" text="-선택-" /></option>
												</select>
												<select class="select" id="cst3_3" disabled="disabled">
													<option value="999" selected><spring:message code="A0069" text="-선택-" /></option>
												</select>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><spring:message code="A0070" text="상담내용&lt;br&gt;메모" />
										</th>
										<td>
											<div class="textareaBox item2">
												<textarea class="textArea" placeholder="<spring:message code="A0071" text="내용을 입력해 주세요." />" id="CSDTL_CALL_MEMO" disabled="disabled"></textarea>
												<%-- <textarea class="textArea" placeholder="<spring:message code="A0072" text="모니터링 메모사항" />"  id="CSDTL_MONITOR_CONT"></textarea> --%>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><spring:message code="A0073" text="재통화" />
										</th>
										<td>
											<div class="dlBox_bg">
												<dl>
													<dt><spring:message code="A0074" text="연락처" /></dt>
													<dd>
														<div class="iptBox">
															<input type="text" class="ipt_txt"  id="CSDTL_RECALL_TEL_NO" disabled="disabled">
														</div>
													</dd>
												</dl>
												<dl>
													<dt><spring:message code="A0075" text="예약일시" /></dt>
													<dd>
														<div class="iptBox">
															<input type="text" class="ipt_dateTime reserveDate" id="CSDTL_RECALL_DATE" readonly="readonly" disabled="disabled">
														</div>
													</dd>
												</dl>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><spring:message code="A0084" text="담당자 연결" />
										</th>
										<td>
											<div class="dlBox_bg">
												<dl>
													<dt><spring:message code="A0085" text="담당자" /></dt>
													<dd>
														<div class="iptBox">
															<input type="text" class="ipt_txt" id="CSDTL_NEW_CUST_OP_ID" disabled="disabled">
														</div>
													</dd>
												</dl>
												<dl>
													<dt><spring:message code="A0086" text="담당자 메일" /></dt>
													<dd>
														<div class="iptBox">
															<input type="text" class="ipt_txt" id="CSDTL_NEW_CUST_OP_EMAIL" disabled="disabled">
														</div>
													</dd>
												</dl>
												<dl>
													<dt><spring:message code="A0087" text="긴급도" /></dt>
													<dd>
														<div class="selectBox">

															<select class="select" id="sb_commCd12" disabled="disabled">
																<option selected value="99"><spring:message code="A0069" text="-선택-" /></option>
																<c:forEach  items="${cmmCd12List}" var="cmmCdItme" varStatus="statusMnt">
																	<option value="${cmmCdItme.CODE}">${cmmCdItme.CODENM}</option>
																</c:forEach>
															</select>
														</div>
													</dd>
												</dl>
											</div>
										</td>
									</tr>
									</tbody>
								</table>
							</div>
							<!-- //.cont_cell -->
						</div>
						<!-- //.callView_cont -->
						<div class="btnBox sz_small line">
							<button type="button" class="btnS_basic saveCsBtn" onclick="saveCsDtl('Wait')" disabled="disabled"><spring:message code="A0088" text="저장 후 수신대기" /></button>
							<button type="button" class="btnS_basic saveCsBtn" onclick="saveCsDtl('Task')" disabled="disabled"><spring:message code="A0089" text="저장 후 업무" /></button>
							<button type="button" class="btnS_basic saveCsBtn" onclick="saveCsDtl('Rest')" disabled="disabled"><spring:message code="A0090" text="저장 후 휴식" /></button>
						</div>
					</div>
					<!-- //.callView -->
				</div>
				<!-- //.tbl_cell -->
				<!-- .tbl_cell -->
				<div class="tbl_cell callDetail" style="width: 40%;">
					<!-- .callView -->
					<div class="callView"  id="chatCont">
						<input type="hidden" id= "chatCont_CONTRACTNO"  />
						<!-- .callView_tit -->
						<div class="callView_tit">
							<h3><spring:message code="A0407" text="상담 모니터링" /></h3>
							<div class="call_info">
							</div>
						</div>
						<!-- //.callView_tit -->
						<!-- .callView_cont -->
						<div class="callView_cont">
							<!-- .cont_cell -->
							<div class="cont_cell" >
								<div class="chatUI_mid">
									<ul class="lst_talk">
									</ul>
								</div>
							</div>
							<!-- //.cont_cell -->
							<!-- .cont_cell -->
							<div class="cont_cell">
								<div class="tbl_customTd scroll">
									<table class="tbl_line_lst" summary="번호/구간/탐지로 구성됨">
										<caption class="hide">탐지내용</caption>
										<colgroup>
											<col width="40">
											<col>
											<col width="100">
										</colgroup>
										<thead>
										<tr>
											<th scope="col"><spring:message code="A0093" text="번호" /></th>
											<th scope="col"><spring:message code="A0094" text="구간" /></th>
											<th scope="col"><spring:message code="A0095" text="탐지" /></th>
										</tr>
										</thead>
										<tbody class="score_tbody">
										</tbody>
									</table>
								</div>
							</div>
							<!-- //.cont_cell -->
						</div>
						<!-- //.callView_cont -->
						<div class="btnBox sz_small line">
							<!-- <button type="button" class="btnS_basic" id="call_direct" onclick="call_direct();" disabled="disabled">소프트폰</button> -->
							<button type="button" class="btnS_basic" id="call_listen" disabled="disabled"><spring:message code="A0106" text="콜청취" /></button>
							<%-- 							<button type="button" class="btnS_basic" id="call_change_op" disabled="disabled"><spring:message code="A0107" text="상담개입" /></button> --%>
							<%-- 							<button type="button" class="btnS_red hide" id="call_close" disabled="disabled"><spring:message code="A0309" text="종료" /></button> --%>
							<button type="button" class="btnS_basic" id="call_change" onclick="consultPop();" disabled="disabled"><spring:message code="A0107" text="상담개입" /></button>
							<button type="button" class="btnS_red hide" id="call_end" onclick="consultEnd();"disabled="disabled"><spring:message code="A0309" text="종료" /></button>
						</div>
					</div>
					<!-- //.callView -->
				</div>
				<!-- //.tbl_cell -->

			</div>
		</div>
		<!-- //.section -->
		<!-- .section -->
		<div class="section">
			<ul class="calling_sum">
				<c:forEach end="${fn:length(phoneListResult)}" items="${phoneListResult}" var="phoneItem" varStatus="statusMnt">
					<li id="${phoneItem.sipUser}">
						<!-- .callView -->
						<div class="callView">
							<!-- .callView_tit
								<div class="callView_tit"  id="${phoneItem.sipUser}_chatBot" onclick="ttt(${phoneItem.sipUser})" > -->
								<%-- <div class="callView_tit"  id="${phoneItem.sipUser}_chatBot" onclick="ttt(${phoneItem.sipUser})"> --%>
							<div class="callView_tit"  id="${phoneItem.sipUser}_chatBot">
								<input type="hidden" id="${phoneItem.sipUser}_campId" value="${phoneItem.campaignId}"/>
								<h3>
									<spring:message code="A0249" text="음성봇" />${statusMnt.count} <span>(${phoneItem.sipUser}) </span>
								</h3>
								<div class="call_info">
										<span class="call_state" >

										<c:choose>
											<c:when test="${phoneItem.status eq 'CS0002'}">
											</c:when>
											<c:otherwise>
												<spring:message code="A0110" text="대기중" />
											</c:otherwise>
										</c:choose>

										<%-- ${phoneItem.status eq 'CS0002'?'':'&lt;spring:message code="A0110" text="대기중" /&gt;'} --%>


										</span> <span class="call_time"></span>
								</div>
							</div>
							<!-- //.callView_tit -->
							<!-- .callView_cont -->
							<div class="callView_cont">
								<!-- .cont_cell -->
								<div class="cont_cell">
									<div class="chatUI_mid">
										<ul class="lst_talk">
										</ul>
									</div>
								</div>
								<!-- //.cont_cell -->
							</div>
							<!-- //.callView_cont -->
						</div> <!-- //.callView -->
					</li>
				</c:forEach>
			</ul>
		</div>
		<!-- //.section -->
		<!-- .call_aside -->
		<div class="call_aside">
			<input type="hidden" id="contractNo">
			<input type="hidden" id="campaignId">
			<input type="hidden" id="telNo">
			<ul class="nav_call_aside">
				<li><button type="button"><spring:message code="A0096" text="상담이력" /></button></li>
				<li><button type="button" id="getRecallList">
					<spring:message code="A0104" text="예약" /><span>(${recallReqCnt})</span>
				</button></li>
				<%-- <li><button type="button">
            <spring:message code="A0105" text="받은 이관" /><span>(0)</span>
          </button></li> --%>
			</ul>
			<!-- .aside_container -->
			<div class="aside_container">
				<!-- .adide_content -->
				<div class="adide_content" id="csHisCont">
					<table class="tbl_line_lst" summary="상담일시/상담시간/구분/상담유형/처리결과/처리음성봇/담당상담사로 구성됨">
						<caption class="hide">상담이력</caption>
						<colgroup>
							<col>
							<col>
							<col>
							<col>
							<col>
							<col>
							<col>
							<col>
							<col>
						</colgroup>
						<thead>
						<tr>
							<th scope="col" nowrap><spring:message code="A0097" text="상담일시" /></th>
							<th scope="col" nowrap><spring:message code="A0266" text="통화시간" /></th>
							<th scope="col" nowrap><spring:message code="A0099" text="구분" /></th>
							<th scope="col" nowrap><spring:message code="A0066" text="상담유형1" /></th>
							<th scope="col" nowrap><spring:message code="A0067" text="상담유형2" /></th>
							<th scope="col" nowrap><spring:message code="A0068" text="상담유형3" /></th>
							<th scope="col" nowrap><spring:message code="A0100" text="처리결과" /></th>
							<th scope="col" nowrap><spring:message code="A0101" text="처리음성봇" /></th>
							<th scope="col" nowrap><spring:message code="A0102" text="담당상담사" /></th>
						</tr>
						</thead>
						<tbody class="csHis_tbody">
						</tbody>
					</table>
				</div>
				<!-- //.adide_content -->
				<!-- .adide_content -->
				<div class="adide_content" id="recallListCont">
					<table class="tbl_line_lst" summary="">
						<caption class="hide">예약</caption>
						<colgroup>
							<col>
							<col>
							<col>
							<col>
							<col>
							<col>
							<col>
							<col>
							<col>
						</colgroup>
						<thead>
						<tr>
							<th scope="col"><spring:message code="A0325" text="고객명" /></th>
							<th scope="col"><spring:message code="A0074" text="연락처" /></th>
							<th scope="col"><spring:message code="A0097" text="상담일시" /></th>
							<th scope="col"><spring:message code="A0075" text="예약일시" /></th>
							<th scope="col"><spring:message code="A0326" text="최근상담일시" /></th>
							<th scope="col"><spring:message code="A0324" text="전화걸기" /></th>
						</tr>
						</thead>
						<tbody class="callback_tbody">
						</tbody>
					</table>
				</div>
				<!-- //.adide_content -->
				<!-- .adide_content -->
				<!-- <div class="adide_content">4</div> -->
				<!-- //.adide_content -->
				<button type="button" class="btn_adide_close">닫기</button>
			</div>
			<!-- //.aside_container -->
		</div>
	</div>
	<!-- //#container -->

	<hr>

	<!-- #footer -->
	<div id="footer">
		<div class="cyrt">
			<span>&copy; MINDsLab. All rights reserved.</span>
		</div>
	</div>
	<!-- //#footer -->
</div>
<!-- //#wrap -->

<!-- 통화UI-->
<div class="callingBotton">
	<button type="button" class="btn_call_switch">
		<span>호전환</span>
	</button>
	<button type="button" class="btn_call_defer">
		<span>보류</span>
	</button>
	<button type="button" class="btn_call_mute">
		<span>음소거</span>
	</button>
</div>
<%@ include file="../common/inc_footer.jsp" %>

<!-- 상담 개입하기 -->
<div id="lyr_consultPop" class="lyrBox">
	<div class="lyr_top">
		<h3><spring:message code="A0107" text="상담 개입하기"/></h3>
		<button class="btn_lyr_close"><spring:message code="A0631" text="닫기"/></button>
	</div>
	<div class="lyr_mid">
		<div class="transferBox">
			<div class="imgBox">
				<img src="${pageContext.request.contextPath}/resources/images/ico_api_bot.png" alt="봇">
				<span>변경</span>
				<img src="${pageContext.request.contextPath}/resources/images/ico_agent_bk.png" alt="상담사">
			</div>
			<p class="txt"><spring:message code="A0902" text="해당 상담을 진행하시겠습니까?"/></p>
		</div>
	</div>
	<div class="lyr_btm">
		<div class="btnBox sz_small">
			<button id="call_change_op" class="btn_lyr_close"><spring:message code="A0107" text="개입하기"/></button>
		</div>
	</div>
</div>

<!-- 상담 종료하기 -->
<div id="lyr_consultEnd_pop" class="lyrBox">
	<div class="lyr_top">
		<h3><spring:message code="A0703" text="상담 종료하기"/></h3>
		<button class="btn_lyr_close"><spring:message code="A0631" text="닫기"/></button>
	</div>
	<div class="lyr_mid">
		<div class="transferBox">
			<div class="imgBox">
				<img src="${pageContext.request.contextPath}/resources/images/ico_call_n.png" alt="상담종료">
			</div>
			<p class="txt"><spring:message code="A0256" text="상담을 종료하시겠습니까?"/></p>
		</div>
	</div>
	<div class="lyr_btm">
		<div class="btnBox sz_small">
			<button id="call_close" class="btn_lyr_close"><spring:message code="A0703" text="상담종료"/></button>
		</div>
	</div>
</div>
<!-- //상담 종료하기 -->

<!-- script -->
<script type="text/javascript">
	$.event.add(window, "load", function() {

		$(document).ready(function() {

			//상담사 업무상태 button
			$('.consultStatus button').on('click',function(){
				$('.consultStatus button').removeClass('active');
				$(this).addClass('active');

				$('body').append(' \
		                 <div class="lyrWrap moment"> \
		                     <div class="lyr_bg"></div> \
		                     <div class="lyrBox" >\
		                        <div class="lyr_top"> \
		                        </div> \
		                        <div class="lyr_mid"> \
		                            <div class="icoBox"> \
		                                <img src="${pageContext.request.contextPath}/resources/images/img_status.png" alt="저장완료"> \
		                            </div> \
		                            <p class="massage"><spring:message code="A0722" text="업무상태가 변경 되었습니다." /></p> \
		                        </div> \
		                    </div> \
		                </div> \
		            ');
				$('.moment, .moment .lyrBox').show();
				setTimeout(function() {
					$('.moment').addClass('lyr_hide').delay(300).queue(function() { $(this).remove(); });
				}, 1000);
			});

			//봇 상담보기
			$('.calling_sum .callView .callView_tit').on('click',function(){
				var botIndex = $(this).parents('li').index()+1,
						chatbotName = $(this).children('h3').html(),
						callStatus = $(this).children().find('.call_state').text();

				// 선택된 봇
				$('.callDetail .callView .callView_tit h3').html('');
				$('.callDetail .callView .callView_tit h3').append(chatbotName);

				//상담 상태
				$('.callDetail .callView .callView_tit .call_state').remove();
				$('html, body').scrollTop(0);

				$('.callDetail .callView').removeClass('alarm');
				if ( callStatus == '상담원연결'|| callStatus == '통화중') {
					$(this).children().find('.call_state').text('통화중');
					$('.callDetail .callView').addClass('alarm');
					$('.callDetail .callView .callView_tit').append('<span class="call_state">통화중</span>');
				} else {
					$('.callDetail .callView .callView_tit').append('<span class="call_state">'+callStatus+'</span>');
				}
			});
			//임시
			if("${sessId}" != "guest"){
				$("#reqMailForm").hide();
			};
			///////////////////////
			//메인소켓 연결
			conn_main_ws('${websocketUrl}');


			// 리스트 안에 통화중인 에이전트가 있는경우 체크후 연결
			<c:forEach items="${phoneListResult}" var="phoneItem">
			if("${phoneItem.status}"== "CS0002"){
				$("#${phoneItem.sipUser}").find('.callView').addClass("alarm");
				$("#${phoneItem.sipUser}").find('.call_state').html('<spring:message code="A0091" text="통화중" />');
				//통화중인
				var obj = new Object();
				obj.TEL_NO =  "${phoneItem.telNo}";
				obj.SIP_USER =  "${phoneItem.sipUser}";
				obj.CONTRACT_NO =  "${phoneItem.contractNo}";
				obj.CAMPAIGN_ID = "${phoneItem.campaignId}";
				$("#${phoneItem.sipUser}_chatBot").on("click",obj,function() {
					agentClick(obj);
				});//통화중이 될경우 클릭 펑션-END
				var sendMsg = '{"EventType":"STT", "Event":"subscribe", "Caller":"${phoneItem.telNo}", "Agent":"${phoneItem.sipUser}", "contract_no":"${phoneItem.contractNo}", "Origin_Url":"'+'${websocketUrl}'+"/callsocket"+'"}';


				agentWs('${websocketUrl}', sendMsg, '${phoneItem.sipUser}');
			}
			</c:forEach>
			//셀렉트 박스 클레스 변경시
			$("select[id^='cst']").on('change',function(){
				//카테고리인 경우(삼담유형)
				if($(this).attr('id').indexOf('cst') > -1){
					var obj = new Object();
					obj.CAMPAIGN_ID = 	$('#CSDTL_CAMPAIGN_ID').val();//캠페인코드
					obj.UPJQID =  $(this).attr('id');//선택한 상위카테고리 ID
					obj.UPCODE =  $(this).val();//선택한 상위카테고리 ID
					obj.TYPE = true; //구분값
					ajaxCall("${pageContext.request.contextPath}/cheCateList", "${_csrf.headerName}", "${_csrf.token}",	JSON.stringify(obj), "N");
				}
			});
			initTextParsing('${opIbStateTotal}');

			$('[name="adminStat"]').on("click", function(e){

				console.log(this.value);

				//상담사 상단정보 조회 getOpIbState 에 구분 param 추가해서 update 하고 조회해 오도록..

			});

			$("#saveUser").off().on("click", function(e){
				saveUser(e);
			});

			// $("#btnEditPw").off().on("click", function(e){
			//
			// 	if($("#originPw").val() == "" || $("#originPw").val() == null){
			// 		$("#originPwTest").css("display", "block");
			// 		return;
			// 	}
			//
			// 	if(!ckEditPw($("#testPw1").val())){
			// 		$("#pwTest1").css("display", "block");
			// 		return;
			// 	}
			//
			// 	if($("#testPw1").val() != $("#testPw2").val()){
			// 		$("#pwTest2").css("display", "block");
			// 		return;
			// 	}
			//
			// 	var json = new Object();
			// 	var jsonObj= new Object();
			//
			// 	json.originPw = $("#originPw").val();
			// 	json.pw1 = $("#testPw1").val();
			// 	json.pw2 = $("#testPw2").val();
			//
			// 	jsonObj.chUserPw=json;
			// 	jsonObj.chUserPwYn = "Y";
			//
			// 	httpSend("${pageContext.request.contextPath}/getOpIbState", $("#headerName").val(), $("#token").val(),	JSON.stringify(jsonObj), "retEditPw");
			//
			// });

			$("#testPw1").off().on("click", function(){
				$("#pwTest1").css("display", "none");
			});

			$("#testPw2").off().on("click", function(){
				$("#pwTest2").css("display", "none");
			});

			$("#originPw").off().on("click", function(){
				$("#originPwTest").css("display", "none");
			});

			$("#getRecallList").on("click", function(evt){
				console.log("in");
				//return;
				//evt.preventDefault();
				setSideList("getRecallList");

			});
		});
	});
	/*******************************************************************************
	 * 상담내용 저장기능
	 ******************************************************************************/
	function saveCsDtl(STATUS){
		console.log($("#CSDTL_CONTRACT_NO").val());

		if($("#cst1_1 option:selected").val() == null || $("#cst1_1 option:selected").val() == "" || $("#cst1_1 option:selected").val() == "999"){
			alertInit('<spring:message code="A0258" text="상담유형1은 필수사항입니다." />', "");
			return;
		}

		var json = new Object();
		var jsonObj= new Object();

		console.log($("#CSDTL_CONTRACT_NO").val());

		if(isEmpty($("#CSDTL_CONTRACT_NO").val())){
			//alert("재통화 연락처 입력 하십시오"); //원래 주석임..
			return false;
		}

		/////////////상담내용
		json.CONTRACT_NO = $("#CSDTL_CONTRACT_NO").val();
		//json.CONTRACT_NO = $("#CSDTL_NEW_CONTRACT_NO").val();

		json.CALL_ID = $("#CSDTL_CALL_ID").val();
		//json.CALL_ID = $("#CSDTL_NEW_CALL_ID").val();

		json.CALL_MEMO = $("#CSDTL_CALL_MEMO").val();
		json.MONITOR_CONT =$("#CSDTL_MONITOR_CONT").val();

		json.CONSULT_TYPE1_DEPTH1_NM = $("#cst1_1 option:selected").text();
		json.CONSULT_TYPE1_DEPTH2_NM = $("#cst1_2 option:selected").text();
		json.CONSULT_TYPE1_DEPTH3_NM = $("#cst1_3 option:selected").text();
		json.CONSULT_TYPE2_DEPTH1_NM = $("#cst2_1 option:selected").text();
		json.CONSULT_TYPE2_DEPTH2_NM = $("#cst2_2 option:selected").text();
		json.CONSULT_TYPE2_DEPTH3_NM = $("#cst2_3 option:selected").text();
		json.CONSULT_TYPE3_DEPTH1_NM = $("#cst3_1 option:selected").text();
		json.CONSULT_TYPE3_DEPTH2_NM = $("#cst3_2 option:selected").text();
		json.CONSULT_TYPE3_DEPTH3_NM = $("#cst3_3 option:selected").text();

		json.CONSULT_TYPE1_DEPTH1 = $("#cst1_1 option:selected").val();
		json.CONSULT_TYPE1_DEPTH2 = $("#cst1_2 option:selected").val();
		json.CONSULT_TYPE1_DEPTH3 = $("#cst1_3 option:selected").val();
		json.CONSULT_TYPE2_DEPTH1 = $("#cst2_1 option:selected").val();
		json.CONSULT_TYPE2_DEPTH2 = $("#cst2_2 option:selected").val();
		json.CONSULT_TYPE2_DEPTH3 = $("#cst2_3 option:selected").val();
		json.CONSULT_TYPE3_DEPTH1 = $("#cst3_1 option:selected").val();
		json.CONSULT_TYPE3_DEPTH2 = $("#cst3_2 option:selected").val();
		json.CONSULT_TYPE3_DEPTH3 = $("#cst3_3 option:selected").val();

		json.USER_CUST_NM = $(".USER_CUST_NM").text();
		json.USER_CUST_TEL_NO = $(".USER_CUST_TEL_NO").text();
		json.USER_CUST_EMAIL = $(".USER_CUST_EMAIL").text();

		jsonObj.CsDtlCont =json;
		////////////재통화			json = new Object();
		json= new Object();
		json.CONTRACT_NO = $("#CSDTL_CONTRACT_NO").val();
		json.RECALL_TEL_NO = $("#CSDTL_RECALL_TEL_NO").val();
		json.RECALL_DATE =$("#CSDTL_RECALL_DATE").val();
		if(isEmpty(json.RECALL_TEL_NO) != isEmpty(json.RECALL_DATE)){
			if(isEmpty(json.RECALL_TEL_NO))
					//alert("재통화 연락처 입력 하십시오");
				alertInit('<spring:message code="A0259" text="재통화 연락처를 입력 하십시오." />', "");
			if(isEmpty(json.RECALL_DATE))
					//alert("재통화 예약일시를 입력 하십시오");
				alertInit('<spring:message code="A0260" text="재통화 예약일시를 입력 하십시오." />', "");
			return false;
		}
		jsonObj.CsDtlReCall =json;
		////////////이관
		json = new Object();
		json.CONTRACT_NO = $("#CSDTL_CONTRACT_NO").val();
		//json.CONTRACT_NO = $("#CSDTL_NEW_CONTRACT_NO").val();

		json.NEW_CUST_OP_ID = $("#CSDTL_NEW_CUST_OP_ID").val();
		json.NEW_CUST_OP_EMAIL =$("#CSDTL_NEW_CUST_OP_EMAIL").val();
		json.IMPORTANCE_LEVEL =$("#sb_commCd12 option:selected").val();
		json.IMPORTANCE_LEVEL_NM =$("#sb_commCd12 option:selected").text();
		if(isEmpty(json.NEW_CUST_OP_ID) && isEmpty(json.NEW_CUST_OP_EMAIL)){
			$("#sb_commCd12").val("99").attr("selected", "selected");
		}else{
			if(isEmpty(json.NEW_CUST_OP_ID)){
				//alert("이관 담당자를 입력 하십시오");
				alertInit('<spring:message code="A0261" text="이관 담당자를 입력 하십시오." />', "");
				return false;
			}
			if(isEmpty(json.NEW_CUST_OP_EMAIL)){
				//alert("이관 담당자메일을 입력 하십시오");
				alertInit('<spring:message code="A0262" text="이관 담당자메일을 입력 하십시오" />', "");
				return false;
			}
			if($("#sb_commCd12").val() =="99"){
				//alert("이관 긴급도를 선택 하십시오");
				alertInit('<spring:message code="A0263" text="이관 긴급도를 선택 하십시오" />', "");
				return false;
			}
		}
		jsonObj.CsDtlEsCalation =json;
		////////////상담원 업데이트
		json = new Object();
		json.CUST_OP_STATUS = STATUS=="Rest"?"02":STATUS=="Task"?"01":"04" ;
		jsonObj.CsDtlOpStatus=json;
		//저장
		ajaxCall("${pageContext.request.contextPath}/setUserCsDtl", $("#headerName").val(), $("#token").val(),	JSON.stringify(jsonObj), "N");
		//상단 상태값
		setTimeout(function() {
			ajaxCall("${pageContext.request.contextPath}/getOpIbState", $("#headerName").val(), $("#token").val(),	JSON.stringify(jsonObj), "N");
			updateOpStatusSocket("update");
		}, 100);

		setTimeout(function() {
			initSet();
		}, 100);
	}

	/*******************************************************************************
	 * 사용자 저장기능
	 ******************************************************************************/
	function saveUser(e){
		if($("#handleCsInfoType").val() == "update") {
			saveUpdate($("#USEREDT_CUST_ID").val());
		}
		if($("#handleCsInfoType").val() == "insert"){
			saveInsert();
		}
	}

	function saveUpdate(custId) {
		var jsonObj= new Object();
		var jsonUser = new Object();
		var jsonPay = new Object();
		$("#handleCsInfoType").val("update");
		jQuery.each(serializeObject("UserEdtForm"), function(key, value) {
			if(key.indexOf('USEREDT_') == 0){
				if(key.indexOf('USEREDT_ipt_radio')== 0 ){
					jsonUser["CUST_TYPE"] = ScRemov($('input:radio[name="USEREDT_ipt_radio"]:checked').val());
				}
				key = key.replace("USEREDT_","");
				if(key == "CUST_ID"){
					jsonPay[key] = custId;
					jsonUser[key] = custId;
				} else if(key=="CUST_HOME_NO" || key=="CUST_TEL_NO" || key=="CUST_COMPANY_NO") {
					jsonUser[key] = ScRemov(value);
				} else {
					jsonUser[key] = value;
				}
			}else if(key.indexOf('PAYEDT_') == 0){
				key = key.replace("PAYEDT_","");
				jsonPay[key] = ScRemov(value);
			}
		});

		if(jsonUser.CUST_NM == "" || jsonUser.CUST_NM == null){
			alert('<spring:message code="A0272" text="성명은 필수입니다." />');
			return false;
		}

		if(jsonUser.CUST_TEL_NO == "" || jsonUser.CUST_TEL_NO == null){
			alert('<spring:message code="A0328" text="이동전화는 필수입니다." />');
			return false;
		}

		jsonObj.user  = jsonUser;
		jsonObj.pay = jsonPay;
		jsonObj.type = $("#handleCsInfoType").val();

		ajaxCall("${pageContext.request.contextPath}/setUserEdt", $("#headerName").val(), $("#token").val(),	JSON.stringify(jsonObj), "N");

	}

	function saveInsert() {
		var jsonObj= new Object();
		var jsonUser = new Object();
		var jsonPay = new Object();
		jQuery.each(serializeObject("UserEdtForm"), function(key, value) {
			if(key.indexOf('USEREDT_') == 0){
				if(key.indexOf('USEREDT_ipt_radio')== 0 ){
					jsonUser["CUST_TYPE"] = ScRemov($('input:radio[name="USEREDT_ipt_radio"]:checked').val());
				}
				key = key.replace("USEREDT_","");
				if(key == "CUST_ID"){
					jsonPay[key] = ScRemov(value);
					jsonUser[key] = ScRemov(value);
				} else if(key=="CUST_HOME_NO" || key=="CUST_TEL_NO" || key=="CUST_COMPANY_NO") {
					jsonUser[key] = ScRemov(value);
				} else {
					jsonUser[key] = value;
				}

			}else if(key.indexOf('PAYEDT_') == 0){
				key = key.replace("PAYEDT_","");
				jsonPay[key] = ScRemov(value);
			}
		});

		if(jsonUser.CUST_NM == "" || jsonUser.CUST_NM == null){
			alert('<spring:message code="A0272" text="성명은 필수입니다." />');
			return false;
		}

		if(jsonUser.CUST_TEL_NO == "" || jsonUser.CUST_TEL_NO == null){
			alert('<spring:message code="A0328" text="이동전화는 필수입니다." />');
			return false;
		}

		jsonObj.user  = jsonUser;
		jsonObj.pay = jsonPay;
		jsonObj.type = $("#handleCsInfoType").val();

		$.ajax({
			url : "${pageContext.request.contextPath}/checkCustTelNo",
			data : JSON.stringify({custTelNo:$("#USEREDT_CUST_TEL_NO").val()}),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
				xhr.setRequestHeader($("#headerName").val(),$("#token").val());
			},
		}).success(function(result) {
			if(result.CHECK_CNT == 1){
				alertInit('<spring:message code="A0602" text="이미 존재하는 전화번호입니다. 정보변경하시겠습니까?" />', "saveUpdate('"+result.CUST_ID+"')", "isFn");
			} else {
				ajaxCall("${pageContext.request.contextPath}/setUserInsert", $("#headerName").val(), $("#token").val(),	JSON.stringify(jsonObj), "N");
			}
		}).fail(function(result) {
		});
	}
	/*
  *  상단 상담사 상태변환
  */
	function chOpStatus(STATUS){

		var json = new Object();
		var jsonObj= new Object();

		json.CUST_OP_STATUS = STATUS;
		jsonObj.CsDtlOpStatus=json;
		jsonObj.updateYn = "Y";

		ajaxCall("${pageContext.request.contextPath}/getOpIbState", $("#headerName").val(), $("#token").val(),	JSON.stringify(jsonObj), "N");
		updateOpStatusSocket("update");
	}

	function openInfoLayer(type){

		var layerTitle = "";

		if(type == "insert"){
			layerTitle = '<spring:message code="A0265" text="신규등록" />';
			$("#handleCsInfoType").val("insert");
		}else{
			layerTitle = '<spring:message code="A0064" text="고객정보 변경" />';
			$("#handleCsInfoType").val("update");
		}
		reloadForm(type);

		$("#ib_infoLayer > div > h3").text(layerTitle);

		$('.cust_date').on("change", function(e){
			checkDatePeriod($(this));
		});

		openPopup("ib_infoLayer");
	}

	function retEditPw(ret){
		if(ret.editPwYn){
			alert('<spring:message code="A0270" text="비밀번호가 변경되었습니다." />');
			$('.lyrWrap').hide();
			$('.lyrBox').hide();
			logout();
		}else{
			alert('<spring:message code="A0271" text="기존 비밀번호가 틀립니다." />');
		}
	}

	function fnDirectCall(campaignId ,contractNo, telNo) {
		$("#campaignId").val(campaignId);
		$("#contractNo").val(contractNo);
		$("#telNo").val(telNo);

		var obj = new Object();

		obj.CAMPAIGN_ID = String(campaignId);
		obj.CONTRACT_NO = String(contractNo);
		console.log("jsp campaignId : " + String(campaignId));
		console.log("jsp contractNo : " + String(contractNo));

		document.getElementById("call_direct").innerHTML = "통화종료";
		$("#call_direct").attr("disabled", false);

		directCall(obj);
	}


	/*
  function fnCall(callback_number, campaignId, contractNo){

    var ret = confirm('<spring:message code="" text="확인버튼 클릭시 O/B상담으로 이동합니다." />');

			if(ret){
				var params = [];
				var param = {};
				var botArr = [];

				$.each($("div[id$='_chatBot']"), function(i,v){
					botArr[i] = v.id.substr(0, v.id.indexOf("_"));
				});

				param.campaignId = campaignId;
				param.contractNo = contractNo;
				param.custTelNo = callback_number;
				param.agent = ${obPhone};
				params[0] = param;
				console.log("fnCall");
				console.log(params);
				startAutocall($("#headerName").val(), $("#token").val(), params);

				location.href = "/obCsMain";

			}

		}
		 */
	function setSideList(url){

		console.log("setSideList");
		console.log(url);

		var jsonObj = {};
		jsonObj.inboundYn = "Y";

		httpSend(url, $("#headerName").val(), $("#token").val(),	JSON.stringify(jsonObj)
				, function(result){

					var obj;
					var callbackCnt = 0;
					var contId = "";
					if(url == "getCallbackList"){
						contId = "callBackListCont";
					}else if(url == "getRecallList"){
						contId = "recallListCont";
					}

					result = JSON.parse(result);

					//콜백 리스트조회(사이드)////
					$("#callBackListCont").find( 'tbody.callback_tbody' ).empty();
					if(valueChk(result.ret)){

						obj = JSON.parse(result.ret);

						console.log(obj);
						callbackCnt = obj.length;

						console.log(callbackCnt);

						if(obj.length > 0){
							inerHtml ="";
							$.each(obj, function(key, value){

								if(url == "getCallbackList"){

									//콜백
									inerHtml +="<tr>";
									inerHtml +="<td scope='row'>"+value.CALL_DATE+"</td>";//콜백요청일시
									inerHtml +="<td>"+value.CUST_NM+"</td>";//이름
									inerHtml +="<td>"+value.TEL_NO+"</td>";//콜백번호
									inerHtml +="<td>"+value.RECENT_CALL+"</td>";//최근 상담시간
									inerHtml +="<td>"+'<spring:message code="A0324" text="전화걸기" />'+"</td>";//전화걸기 버튼
									//inerHtml += ("<td><a onclick=\"fnDirectCall('campaignId','contractNo','telNo')\"><spring:message code='A0324' text='전화걸기' /></a></td>").replace("campaignId",value.CAMPAIGN_ID).replace("contractNo",value.CONTRACT_NO).replace("telNo",value.TEL_NO);
									inerHtml +="</tr>";
								}else if(url == "getRecallList"){

									console.log("in");

									//콜백
									inerHtml +="<tr>";
									inerHtml +="<td scope='row'>"+value.CUST_NM+"</td>";//고객명
									inerHtml +="<td>"+value.RECALL_TEL_NO+"</td>";//연락처
									inerHtml +="<td>"+value.CREATED_DTM+"</td>";//상담일시
									inerHtml +="<td>"+value.RECALL_DATE+"</td>";//예약일시
									inerHtml +="<td>"+value.RECENT_CALL+"</td>";//최근상담일시
									inerHtml +="<td>"+'<spring:message code="A0324" text="전화걸기" />'+"</td>";//전화걸기 버튼
									//inerHtml += ("<td><a onclick=\"fnDirectCall('campaignId','contractNo','telNo')\"><spring:message code='A0324' text='전화걸기' /></a></td>").replace("campaignId",value.CAMPAIGN_ID).replace("contractNo",value.CONTRACT_NO).replace("telNo",value.RECALL_TEL_NO);
									inerHtml +="</tr>";
								}

							});

							$("#"+contId).find( 'tbody.callback_tbody' ).empty();
							$("#"+contId).find( 'tbody.callback_tbody' ).append(inerHtml);


						}else{
							inerHtml ="<td scope='row' class='al_c' colspan='9'>"+getLocaleMsg("A0005", "등록된 데이터가 없습니다.")+"</td>";
							$("#"+contId).find( 'tbody.callback_tbody' ).empty();
							$("#"+contId).find( 'tbody.callback_tbody' ).append(inerHtml);
						}
					}else{

						inerHtml ="<td scope='row' class='al_c' colspan='9'>"+getLocaleMsg("A0005", "등록된 데이터가 없습니다.")+"</td>";
						$("#"+contId).find( 'tbody.callback_tbody' ).empty();
						$("#"+contId).find( 'tbody.callback_tbody' ).append(inerHtml);
					}

					console.log("callbackCnt : "+callbackCnt);

					$("#"+url+" > span").text("("+callbackCnt+")");

				});
	}

	function checkDatePeriod(curInput) {
		var toDate = $("#USEREDT_CUST_TERM_DATE").val();
		var fromDate  = $("#USEREDT_CUST_REG_DATE").val();

		fromDate = fromDate.replace(/-/gi, "");
		toDate = toDate.replace(/-/gi, "");


		if(fromDate != "" && toDate != "" && toDate<fromDate){
			curInput.val("");
			alert("가입일이 해지일보다 빨라야합니다.");
			return false;
		}
	}

	function reloadForm(type) {
		if(type == 'insert') {
			$("[id^=USEREDT_]").val("");
			$("[id^=PAYEDT_]").val("");
		} else {
			for(var i=0; i < $("[class^=USER_]").length; i++) {
				$("[id^=USEREDT_]").eq(i).val($("[class^=USER_]").eq(i).text());
			}
			for(var i=0; i < $("[class^=PAY_]").length; i++) {
				$("[id^=PAYEDT_]").eq(i).val($("[class^=PAY_]").eq(i).text());
			}
		}
	}

	// 상담개입 종료 팝업
	function consultPop(){
		openPopup("lyr_consultPop");
	}
	// 상담 개입 / 청취 종료 팝업
	function consultEnd(){
		openPopup("lyr_consultEnd_pop");
	}

</script>
</body>
</html>
