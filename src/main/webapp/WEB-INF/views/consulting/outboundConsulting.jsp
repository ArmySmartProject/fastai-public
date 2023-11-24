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
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/conn_ob.ws.js"></script>
</head>

<body>
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
	<input type="hidden" id="headerName" value="${_csrf.headerName}" />
	<input type="hidden" id="token" value="${_csrf.token}" />
	<input type="hidden" id= "csType"   value="${csType}"  />
	<input type="hidden" id="OP_LOGIN_ID">
	<input type="hidden" id="voiceUrl" value="${voiceUrl}">
	<input type="hidden" id="proxyUrl" value="${proxyUrl}">
	<input type="hidden" id="autoCallYn" value="N">
	<input type="hidden" id="consultantType" value="false"/>

	<%@ include file="../common/inc_header_ob.jsp"%>

	<!-- #container -->
	<div id="container">
		<!-- .section -->
		<div class="section">
			<!-- //.tab_calling -->
			<div class="tab_calling_view">
				<!-- .tbl_cell -->
				<div class="tbl_cell tbl_overflow_x" style="width:30%;">
					<!-- .callView -->
					<div class="callView">
						<!-- .callView_tit -->
						<div class="callView_tit include_select">
							<h3>DB List</h3>
							<div class="call_info">
								<c:choose>
									<c:when test="${fn:length(campaignList) > 0}">
										<span>campaign</span>
										<select class="select" id="getCampaign">
											<c:forEach items="${campaignList}" var="campaignItem" varStatus="itemStatus">
												<c:choose>
													<c:when test="${itemStatus.first}">
														<option value="${campaignItem.get("CAMPAIGN_ID")}" selected>${campaignItem.get("CAMPAIGN_NM")}</option>
													</c:when>
													<c:otherwise>
														<option value="${campaignItem.get("CAMPAIGN_ID")}">${campaignItem.get("CAMPAIGN_NM")}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</c:when>
									<c:otherwise>
										<span>매핑된 campaign이 없습니다</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<!-- //.callView_tit -->
						<!-- .callView_cont -->
						<div class="callView_cont">
							<!-- .cont_cell -->
							<div class="cont_cell tbl_dropdown">
								<div class="tbl_customTd scroll" style="height:430px;">
									<table class="tbl_line_lst" summary="번호/고객명/고객구분/연락처1(대표)/연락처2/연락처3으로 구성됨">
										<caption class="hide">DB List</caption>
										<colgroup>
											<col width="25"><col width="30"><col><col><col>
											<col><col><col><col><col>
										</colgroup>
										<thead id="dbListCol">
										<tr>
											<th scope="col">
												<div class="ipt_check_only">
													<input type="checkbox" class="ipt_tbl_allCheck">
												</div>
											</th>
											<th scope="col">No.</th>
											<!-- [D] dropbox를 가지는 th에는 "th_sort" class를 추가해야 합니다. -->
											<th scope="col" class="th_sort">
												<!-- [D] .th_sort > span은 "아래화살표" 디자인이 적용됩니다. -->
												<span>성명</span>
												<!-- [D]
                                                    체크박스를 가질 때 : th_dropbox와 th_check_box 클래스를 적용해야합니다.
                                                    검색창을 가질 때 : th_dropbox와 th_search_box 클래스를 적용해야합니다.
                                                -->
												<div class="th_dropbox th_search_box">
													<div class="iptBox">
														<input type="text" id="CUST_NM" class="ipt_txt" name="searchColumn">
													</div>
													<button type="button" class="btnS_basic btn_dropbox_confirm">확인</button>
												</div>
											</th>
											<th scope="col" class="th_sort">
												<span>연락처1(대표)</span>
												<div class="th_dropbox th_search_box">
													<div class="iptBox">
														<input type="text" id="CUST_TEL_NO" class="ipt_txt" name="searchColumn">
													</div>
													<button type="button" class="btnS_basic btn_dropbox_confirm">확인</button>
												</div>
											</th>
											<th scope="col" class="th_sort">
												<span>시도</span>
												<div class="th_dropbox th_check_box">
													<div class="ipt_check_only">
														<input type="checkbox" id="check001" name="checkColumn" class="ipt_dropbox_allCheck">
														<label for="check001">전체선택</label>
													</div>
													<c:forEach items="${commonList}" var="commonItem" varStatus="ItemStatus">
														<div class="ipt_check_only">
															<input type="checkbox" class="checkColumn" id="check${ItemStatus.count}" name="callStatus" value="${commonItem.code}">
															<label for="check${ItemStatus.count}">${commonItem.cdDesc}</label>
														</div>
													</c:forEach>
													<button type="button" class="btnS_basic btn_dropbox_confirm">확인</button>
												</div>
											</th>
											<c:forEach items="${colList}" var="colItem" varStatus="ItemStatus">
												<th scope="col" class="th_sort"><span>${colItem.columnKor}</span>
													<c:if test="${colItem.dataType eq 'selectbox' || colItem.dataType eq 'radiobox'}" >
														<c:set var="caseTypeArr" value="${fn:split(colItem.caseType,',')}" />
														<div class="th_dropbox th_check_box">
															<div class="ipt_check_only">
																<input type="checkbox" id="${colItem.columnEng}" class="ipt_dropbox_allCheck">
																<label for="${colItem.columnEng}">전체선택</label>
															</div>
															<c:forEach items="${caseTypeArr}" var="caseType" varStatus="ItemStatus">
																<div class="ipt_check_only">
																	<input type="checkbox" class="checkColumn" id="${colItem.columnEng}${ItemStatus.count}" name="${colItem.columnKor}" value="${caseType}">
																	<label for="${colItem.columnEng}${ItemStatus.count}">${caseType}</label>
																</div>
															</c:forEach>

															<button type="button" class="btnS_basic btn_dropbox_confirm">확인</button>
														</div>
													</c:if>
													<c:if test="${colItem.dataType eq 'string' || colItem.dataType eq 'int'
                                                        || colItem.dataType eq 'float' || colItem.dataType eq 'date'}" >
														<div class="th_dropbox th_search_box">
															<div class="iptBox">
																<input type="text" id="${colItem.columnKor}" class="ipt_txt" name="searchColumn">
															</div>
															<button type="button" class="btnS_basic btn_dropbox_confirm">확인</button>
														</div>
													</c:if>
												</th>
											</c:forEach>
										</tr>
										</thead>
										<tbody id="dbListBody">
										<c:forEach items="${list}" var="userItem" varStatus="ItemStatus">
											<tr class="ob_cust_list">
												<td scope="row">
													<div class="ipt_check_only">
														<input type="checkbox" class="ob_cust_chk" name="obCheck">
													</div>
												</td>
												<td>${ItemStatus.count}</td>
												<td class="ob_cust_campaignId" id="obCustCampaignId" style="display: none;">${userItem.campaignId}</td>
												<td class="ob_cust_contractNo" style="display: none;">${userItem.contractNo}</td>
												<td><a onclick='setUserData("${userItem.telNo}","${userItem.contractNo}","${userItem.campaignId}", "${userItem.campaignNm}", "${userItem.custId}")'>${userItem.custNm}</a></td>
												<td class="ob_cust_telNo">${userItem.telNo}<button type="button" class="btn_ico call"></button></td>
												<td class="">${userItem.callStatusNm}</td>
												<c:set var="custDataArr" value="${userItem.custDataList}" />
												<c:forEach var="custData" items="${custDataArr}">
													<td class="">${custData}</td>
												</c:forEach>
											</tr>
										</c:forEach>
										<c:if test="${fn:length(list) <= 0}">
											<tr>
												<td scope="row" colspan="6" style="text-align: center;"><spring:message code="A0257" text="등록된 데이터가 존재하지 않습니다." /></td>
											</tr>
										</c:if>

										</tbody>
									</table>
								</div>
								<div class="paging" id="dbListPager">
									<a class="btn_paging_first" href="javascript:goPage(1)" >처음 페이지로 이동</a>
									<a class="btn_paging_prev" href="javascript:goPage('${paging.prevPage}')" >이전 페이지로 이동</a>
									<c:forEach begin="${paging.pageRangeStart}" end="${paging.pageRangeEnd}" varStatus="loopIdx">
										<c:choose>
											<c:when test="${paging.currentPage eq loopIdx.index}">
												<strong>${loopIdx.index}</strong>
											</c:when>
											<c:otherwise>
												<a href="javascript:goPage('${loopIdx.index}')">${loopIdx.index}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<a class="btn_paging_next" href="javascript:goPage('${paging.nextPage}')">다음 페이지로 이동</a>
									<a class="btn_paging_last" href="javascript:goPage('${paging.totalPage}')">마지막 페이지로 이동</a>
								</div>
							</div>
						</div>
						<!-- //.cont_cell -->
						<div class="btnBox sz_small">
							<button type="button" id="SrtAutoCall" class="btnS_basic custom" onclick="autoCall('START', '')" disabled>Direct Call</button>
						</div>
					</div>
					<!-- //.callView_cont -->
				</div>
				<!-- //.callView -->
				<!-- //.tbl_cell -->
				<div class="tbl_cell" style="width: 30%;">
					<!-- .callView -->
					<div class="callView">
						<!-- .callView_tit -->
						<div class="callView_tit">
							<h3><spring:message code="A0014" text="고객정보" /></h3>
						</div>
						<!-- //.callView_tit -->
						<!-- .callView_cont -->
						<div class="callView_cont" id="userCont">
							<!-- .cont_cell -->
							<div class="cont_cell">
								<table class="tbl_line_view" id="USER_TABLE" summary="번호/구간/탐지로 구성됨">
									<input type="hidden" id="CSDTL_CALL_ID">
									<input type="hidden" id="CSDTL_CONTRACT_NO">
									<input type="hidden" id="CSDTL_CAMPAIGN_ID">
									<caption class="hide">상담내용</caption>
									<colgroup>
										<col width="75">
										<col>
										<col width="75">
										<col>
									</colgroup>
									<tbody id="custInfoDetail">
									<tr>
										<th scope="row"><spring:message code="A0039" text="성명" /></th>
										<td class="USER_CUST_NM USER_TABLE_DEL" id="obUserCustNm"></td>
										<th><spring:message code="A0049" text="이동전화" /></th>
										<td id="obUserCustTelNo">
											<button type="button" class="btn_ico call" disabled>전화걸기</button>
											<span class="USER_CUST_TEL_NO USER_TABLE_DEL"></span>
										</td>
									</tr>
									</tbody>
									<tbody>
									<tr>
										<th scope="row"><spring:message code="A0138" text="OB결과" /></th>
										<td colspan="3">
											<div class="dlBox_bg">
												<dl>
													<dt><spring:message code="A0139" text="시도결과" /></dt>
													<dd>
														<select class="select" id="dial_status" disabled="disabled">
															<option value="999" selected ><spring:message code="A0069" text="-선택-" /></option>
															<c:forEach items="${cmmCd23List}" var="cd23Item" varStatus="ItemStatus">
																<option value="${cd23Item.CODE}">${cd23Item.CODENM}</option>
															</c:forEach>
														</select>
													</dd>
												</dl>
												<dl>
													<dt><spring:message code="A0140" text="통화결과" /></dt>
													<dd>
														<select class="select" id="mnt_status" disabled="disabled">
															<option value="999" selected ><spring:message code="A0069" text="-선택-" /></option>
															<c:forEach items="${cmmCd24List}" var="cd24Item" varStatus="ItemStatus">
																<option value="${cd24Item.CODE}">${cd24Item.CODENM}</option>
															</c:forEach>
														</select>
													</dd>
												</dl>
												<dl>
													<dt><spring:message code="A0141" text="상담메모" /></dt>
													<dd>
														<div class="iptBox">
															<input type="text" class="ipt_txt" id="ob_memo" disabled="disabled">
														</div>
													</dd>
												</dl>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row"><spring:message code="A0073" text="재통화" /></th>
										<td colspan="3">
											<div class="dlBox_bg">
												<dl>
													<dt><spring:message code="A0074" text="연락처" /></dt>
													<dd>
														<div class="iptBox">
															<input type="text" class="ipt_txt" id="CSDTL_RECALL_TEL_NO" autocomplete="off" disabled="disabled">
														</div>
													</dd>
												</dl>
												<dl>
													<dt><spring:message code="A0075" text="예약일시" /></dt>
													<dd>
														<div class="iptBox">
															<input type="text" class="ipt_dateTime reserveDate" id="CSDTL_RECALL_DATE" autocomplete="off" readonly="readonly" disabled="disabled">
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
							<button type="button" class="btnS_basic btn_userInfoModify btn_lyr_open" id="updateUserInfo" onclick="openInfoLayer('update')" disabled="disabled"><spring:message code="A0063" text="정보변경" /></button>
							<button type="button" class="btnS_basic" id="saveCsDtl" onclick="saveCsDtl()" disabled="disabled" ><spring:message code="A0320" text="저장 " /></button>
						</div>
					</div>
					<!-- //.callView -->
				</div>
				<!-- .tbl_cell -->
				<div class="tbl_cell callDetail" style="width: 40%;">
					<!-- .callView -->
					<div class="callView" id="chatCont">
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
							<div class="cont_cell">
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
											<col width="70">
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
							<button type="button" class="btnS_basic" id="StpAutoCall" onclick="autoCall('STOP', '')" disabled="disabled"><spring:message code="A0133" text="Call 종료" /></button>
							<button type="button" class="btnS_basic" id="call_listen" disabled="disabled"><spring:message code="A0106" text="콜청취" /></button>
							<%-- 									<button type="button" class="btnS_basic" id="call_change_op" disabled="disabled"><spring:message code="A0107" text="상담개입" /></button> --%>
							<%-- 									<button type="button" class="btnS_red hide" id="call_close" disabled="disabled"><spring:message code="A0309" text="종료" /></button> --%>
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
							<div class="callView_tit" id="${phoneItem.sipUser}_chatBot">
								<input type="hidden" id="phoneCampaignId" value="${phoneItem.campaignId}">
								<h3>
										${phoneItem.campaignNm}<span>(${phoneItem.sipUser}) </span>
								</h3>
								<div class="call_info">
											<span class="call_state">

											<c:choose>
												<c:when test="${phoneItem.status eq 'CS0002'}">
												</c:when>
												<c:otherwise>
													<spring:message code="A0110" text="대기중" />
												</c:otherwise>
											</c:choose>

											</span>
									<span class="call_time"></span>
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
			<input type="hidden" id="telNo">
			<ul class="nav_call_aside">
				<li><button type="button"><spring:message code="A0096" text="상담이력" /></button></li>
				<li><button type="button" id="getRecallList">
					<spring:message code="A0104" text="예약" /><span>(${recallReqCnt})</span>
				</button></li>
				<li><button type="button" id="callQueueBtn">콜큐<span>(
							<c:out value="${queuePagingVO.totalCount}"></c:out>
						)</span></button></li>
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
							<th scope="col" nowrap><spring:message code="A0251" text="통화시간" /></th>
							<th scope="col" nowrap><spring:message code="A0099" text="구분" /></th>
							<th scope="col" nowrap><spring:message code="A0139" text="시도결과" /></th>
							<th scope="col" nowrap><spring:message code="A0140" text="통화결과" /></th>
							<th scope="col" nowrap><spring:message code="A0102" text="담당상담사" /></th>
						</tr>
						</thead>
						<tbody class="csHis_tbody">
						</tbody>
					</table>
				</div>
				<!-- //.adide_content -->
				<!-- .adide_content -->
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

				<div class="adide_content inherit_height tbl_dropdown">
					<div class="call_info">
						<span>campaign</span>
						<select class="select" id="callQueueCampaign">
							<c:forEach items="${campaignList}" var="campaignItem" varStatus="itemStatus">
								<c:choose>
									<c:when test="${itemStatus.first}">
										<option value="${campaignItem.get("CAMPAIGN_ID")}" selected>${campaignItem.get("CAMPAIGN_NM")}</option>
									</c:when>
									<c:otherwise>
										<option value="${campaignItem.get("CAMPAIGN_ID")}">${campaignItem.get("CAMPAIGN_NM")}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
					<div class="tbl_customTd scroll" style="height: calc(100% - 185px);">
						<table class="tbl_line_lst" summary="번호/고객명/고객구분/연락처1(대표)/연락처2/연락처3으로 구성됨">
							<caption class="hide">DB List</caption>
							<colgroup>
								<col width="25"><col width="30"><col><col><col>
								<col><col><col><col><col>
							</colgroup>
							<thead id="callQueueColList">
							<tr>
								<th scope="col">
									<div class="ipt_check_only">
										<input type="checkbox" class="ipt_tbl_allCheck">
									</div>
								</th>
								<th scope="col">No.</th>
								<th scope="col">
									<span>성명</span>
								</th>
								<th scope="col">
									<span>연락처1(대표)</span>
								</th>
								<c:forEach items="${colList}" var="colItem" varStatus="ItemStatus">
									<th scope="col"><span>${colItem.columnKor}</span>
									</th>
								</c:forEach>
							</tr>
							</thead>
							<tbody id="callQueueListBody">
							<c:forEach items="${callQueueList}" var="userItem" varStatus="ItemStatus">
								<tr class="ob_cust_list">
									<td scope="row">
										<c:if test="${sessId eq userItem.userId || custOpType eq 'A'}">
											<div class="ipt_check_only">
												<input type="checkbox" class="ob_cust_chk" name="obCallQueueCheck" value="${userItem.obCallQueueId}">
											</div>
										</c:if>
									</td>
									<td>${ItemStatus.count}</td>
									<td class="obCallQueueCampaignId" id="obCallQueueCampaignId" style="display: none;">${userItem.campaignId}</td>
									<td class="obCallQueueCustName" id="obCallQueueCustName">${userItem.custNm}</td>
									<td class="obCallQueueTelNo">${userItem.custTelNo}</td>
									<c:set var="custDataArr" value="${userItem.custDataList}" />
									<c:forEach var="custData" items="${custDataArr}">
										<td class="">${custData}</td>
									</c:forEach>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(list) <= 0}">
								<tr>
									<td scope="row" colspan="6" style="text-align: center;"><spring:message code="A0257" text="등록된 데이터가 존재하지 않습니다." /></td>
								</tr>
							</c:if>

							</tbody>
						</table>
					</div>

					<div class="paging" id="callQueuePager">
						<a class="btn_paging_first" href="javascript:getCallQueueList(1)" >처음 페이지로 이동</a>
						<a class="btn_paging_prev" href="javascript:getCallQueueList('${queuePagingVO.prevPage}')" >이전 페이지로 이동</a>
						<c:forEach begin="${queuePagingVO.pageRangeStart}" end="${queuePagingVO.pageRangeEnd < 6 ? queuePagingVO.pageRangeEnd : 10}" varStatus="loopIdx">
							<c:choose>
								<c:when test="${queuePagingVO.currentPage eq loopIdx.index}">
									<strong>${loopIdx.index}</strong>
								</c:when>
								<c:otherwise>
									<a href="javascript:getCallQueueList('${loopIdx.index}')">${loopIdx.index}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<a class="btn_paging_next" href="javascript:getCallQueueList('${queuePagingVO.nextPage}')">다음 페이지로 이동</a>
						<a class="btn_paging_last" href="javascript:getCallQueueList('${queuePagingVO.totalPage}')">마지막 페이지로 이동</a>

						<div class="btnBox sz_small">
							<!-- [D] disalbled 를 추가하면 버튼이 비활성화 됩니다 -->
							<button type="button" id="deleteCallQueueBtn" class="btnS_basic" onclick="deleteCallQueue()" disabled>삭제</button>
						</div>
					</div>

					<div class="call_info" id="callQueueCount">
						<p class="call_screen">진행예정 : <span>
									<c:out value="${queuePagingVO.totalCount}"></c:out>
								</span> 명</p>
					</div>
				</div>
				<button type="button" class="btn_adide_close">닫기</button>
			</div>
			<!-- //.aside_container -->
		</div>
		<!-- //.call_aside -->
		<div class="userInfoBox">
			<span class="user_name" id="loginUserTxt"></span>
			<!-- <dl class="user_level">
                <dt>레벨</dt>
                <dd>상담원 관리자</dd>
            </dl>
            <dl class="user_loginTime">
                <dt>로그인 일시</dt>
                <dd>2019-09-30 오후 6:19:00</dd>
            </dl>
            <dl>
                <dt>발신번호</dt>
                <dd>
                    <select class="select">
                        <option selected>02-1588-1234</option>
                        <option>02-1588-5678</option>
                    </select>
                </dd>
            </dl> -->
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
	<button type="button" class="btn_call_mute">
		<span>음소거</span>
	</button>
	<button type="button" class="btn_call_end">
		<span>통화종료</span>
	</button>
</div>
<!-- //통화UI-->
<%@ include file="../common/inc_footer.jsp"%>

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
<input type="hidden" id="currentPage" value="1">
<input type="hidden" id="callQueueCurrentPage" value="1">

<!-- script -->
<script type="text/javascript">
	$.event.add(window,"load",function(){
		console.log("readyState : "+document.readyState);

		var lang = $.cookie("lang");
		if(lang == "ko"){
			//datepicker
			$('#OB_PAYEDT_RECENT_PAYMENT_DATE').datepicker({
				format : "yyyy-mm-dd",
				language : "ko",
				autoclose : true,
				todayHighlight : true,
				defalutDate : new Date()
			});
		}else if(lang == "en"){
			$('#OB_PAYEDT_RECENT_PAYMENT_DATE').datepicker({
				format : "yyyy-mm-dd",
				language : "en",
				autoclose : true,
				todayHighlight : true,
				defalutDate : new Date()
			});
		}

		searchBox();

		$('#getCampaign').on('change', function() {
			var obj = new Object();
			obj.CAMPAIGN_ID = this.value;
			obj.PAGE_COUNT = "10";
			$.ajax({
				url : "${pageContext.request.contextPath}/getCustInfoList",
				data : JSON.stringify(obj),
				method : 'POST',
				contentType : "application/json; charset=utf-8",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
			}).success(
					function(result) {
						getUserList(result, 'change');
						$("#SrtAutoCall").prop("disabled",true);

					}).fail(function(result) {
				console.log("getCustInfoList error");
			});
		});

		$('#callQueueCampaign').on('change', function() {
			var obj = new Object();
			obj.CAMPAIGN_ID = this.value;
			obj.PAGE_COUNT = "15";
			getCallQueueList(1);
		});

		setInterval(function() {
			var obj = new Object();
			getCallQueueList($("#callQueueCurrentPage").val());
			ajaxCall("${pageContext.request.contextPath}/getOpObState", $("#headerName").val(), $("#token").val(), JSON.stringify(obj), "N");
		}, 3000);

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

		//메인소켓 연결
		conn_main_ws('${websocketUrl}');
		// 리스트 안에 통화중인 에이전트가 있는경우 체크후 연결
		<c:forEach items="${phoneListResult}" var="phoneItem">
		if("${phoneItem.status}"== "CS0002"){
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
			agentWs('${websocketUrl}', sendMsg);
		}
		</c:forEach>

		//수신대기, 업무, 휴게
		initTextParsing('${opStatus}');
		// obOP상태정보total////
		initTextParsing('${opTotalObStateList}');
		// obOP상태정보user////
		initTextParsing('${opUserObStateList}');

		// 테이블 헤더에 있는 checkbox 클릭시
		$("#callListTable :checkbox:first").click(function(){
			// 클릭한 체크박스가 체크상태인지 체크해제상태인지 판단
			if($(this).is(":checked")){
				$("#callListTable :checkbox").prop("checked",true).change();
			}else{
				$("#callListTable :checkbox").prop("checked",false).change();
			}
		});

		//////////////////////////END


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
		// 	httpSend("${pageContext.request.contextPath}/getOpObState", $("#headerName").val(), $("#token").val(),	JSON.stringify(jsonObj), "retEditPw");
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
			setSideList("${pageContext.request.contextPath}/getRecallList");

		});

		// 추가 AMR 200618 table이 부모보다 크면 가로스크롤이 생김
		function createTblScrollx() {
			$('.tbl_overflow_x').each(function(){
				var fixWidth = $(this).outerWidth();
				$(this).find('.tbl_customTd.scroll').css({'width': fixWidth + 'px'});
				console.log(fixWidth)
			})
		}

		$('.tbl_overflow_x').find('.tbl_customTd.scroll').css({'width': 1 + 'px'});
		createTblScrollx()

		$(window).resize(function(){
			$('.tbl_overflow_x').find('.tbl_customTd.scroll').css({'width': 1 + 'px'});
			createTblScrollx()
		});

		$(".ob_cust_chk").click(function(){
			var count = $("input:checkbox[name=obCheck]:checked").length;
			var countCallQueue = $("input:checkbox[name=obCallQueueCheck]:checked").length;

			if(count > 0){
				$("#SrtAutoCall").prop("disabled",false);
			}
			else{
				$("#SrtAutoCall").prop("disabled",true);
			}
			if(countCallQueue > 0){
				$("#deleteCallQueueBtn").prop("disabled",false);
			}
			else{
				$("#deleteCallQueueBtn").prop("disabled",true);
			}
		});

	});

	function getCallQueueList(cp) {
		if (cp != 0) {
			$('#callQueueCurrentPage').val(cp);
		}
		var jsonObj = {};
		jsonObj.CAMPAIGN_ID = $("#callQueueCampaign option:selected").val();
		jsonObj.cp = cp;
		jsonObj.pageInitPerPage = 15;
		jsonObj.countPerPage = 15;
		var callQueueCheck = $("input[name='obCallQueueCheck']");
		var checkCallQueueList = [];
		var cnt = 0;
		for (var i=0; i<callQueueCheck.length; i++) {
			if (callQueueCheck[i].checked) {
				var callQueueVal = $("input[name='obCallQueueCheck']").eq(i).val();
				checkCallQueueList[cnt] = callQueueVal;
				cnt++;
			}
		}

		$.ajax({
			url: "${pageContext.request.contextPath}/getCallQueueList",
			data: JSON.stringify(jsonObj),
			method: 'POST',
			contentType: "application/json; charset=utf-8",
			beforeSend: function (xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
		}).success(
				function (result) {

					var paging = result.queuePagingVO;
					var list = result.callQueueList;
					var colList = result.colList;
					var cnt = paging.startRow + 1;
					var sessId = result.sessId;
					var custOpType = result.custOpType;
					var checkCnt = 0;

					$("#callQueueColList").empty();

					var innerHTML = "";

					innerHTML += '<tr>';
					innerHTML += '<th scope="col">';
					innerHTML += '	<div class="ipt_check_only">';
					innerHTML += '		<input type="checkbox" class="ipt_tbl_allCheck">';
					innerHTML += '	</div>';
					innerHTML += '</th>';
					innerHTML += '<th scope="col">No.</th>';
					innerHTML += '<th scope="col">';
					innerHTML += '<span>성명</span>';
					innerHTML += '</th>';
					innerHTML += '<th scope="col">';
					innerHTML += '<span>연락처1(대표)</span>';
					innerHTML += '</th>';

					$.each(colList, function (i, v) {

						var obj = [];

						obj.push(v.columnKor);
						obj.push(v.dataType);
						obj.push(v.columnEng);
						obj.push(v.custDataClassId);
						if (v.caseType != null && v.caseType != "") {
							var caseTypeArr = v.caseType.split(',');
						}

						$.each(obj, function (j, jv) {
							if (obj[j] == null || obj[j] == "undefined") {
								obj[j] = "";
							}
						});
						innerHTML += '<th scope="col"><span>' + obj[0] + '</span>';
						innerHTML += '</th>';
					});
					innerHTML += '</tr>';

					$("#callQueueColList").append(innerHTML);

					innerHTML = "";

					$.each(list, function (i, v) {

						var obj = [];

						obj.push(v.custNm);
						obj.push(v.custTelNo);
						obj.push(v.userId);
						var custDataArr = v.custDataList;
						var checked = 'n';

						$.each(obj, function (j, jv) {
							if (obj[j] == null || obj[j] == "undefined") {
								obj[j] = "";
							}
						});

						innerHTML += '<tr class="ob_cust_list">';
						innerHTML += '<td scope="row">';
						if (sessId == obj[2] || custOpType == 'A') {
							innerHTML += '	<div class="ipt_check_only">';
							for (var i = 0; i < checkCallQueueList.length; i++) {
								if (checkCallQueueList[i] == v.obCallQueueId) {
									checked = 'y';
									checkCnt++;
								}
							}
							if (checked == 'y') {
								innerHTML += '		<input type="checkbox" class="ob_cust_chk" name="obCallQueueCheck" value="' + v.obCallQueueId + '" checked>';
							} else {
								innerHTML += '		<input type="checkbox" class="ob_cust_chk" name="obCallQueueCheck" value="' + v.obCallQueueId + '">';
							}
							innerHTML += '	</div>';
						}
						innerHTML += '</td>';
						innerHTML += '<td>' + cnt + '</td>';
						// innerHTML += '<td class="obCallQueueId" style="display: none;">' + v.obCallQueueId
						// 		+ '</td>';
						innerHTML += '<td class="obCallQueueNm">' + obj[0] + '</td>';
						innerHTML += '<td class="obCallQueueTelno">' + obj[1] + '</td>';
						for (var i = 0; i < custDataArr.length; i++) {
							innerHTML += '<td class="">' + custDataArr[i] + '</td>';
						}

						innerHTML += '</tr>';

						cnt++;

					});

					$("#callQueueListBody").empty();
					$("#callQueueListBody").append(innerHTML);

					innerHTML = "";

					$("#callQueuePager").empty();

					innerHTML += '<a class="btn_paging_first" href="javascript:getCallQueueList(1)" >처음 페이지로 이동</a>';
					innerHTML += '<a class="btn_paging_prev" href="javascript:getCallQueueList(' + paging.prevPage
							+ ')" >이전 페이지로 이동</a>';

					for (var i = paging.pageRangeStart; i <= paging.pageRangeEnd; i++) {
						if (i == paging.currentPage) {
							innerHTML += "<strong>" + i + "</strong>";
						} else {
							innerHTML += '<a href="javascript:getCallQueueList(' + i + ')">' + i + '</a>';
						}
					}
					$("#callQueueCurrentPage").val(paging.currentPage);

					innerHTML += '<a class="btn_paging_next" href="javascript:getCallQueueList(' + paging.nextPage
							+ ')">다음 페이지로 이동</a>';
					innerHTML += '<a class="btn_paging_last" href="javascript:getCallQueueList('
							+ paging.totalPage + ')">마지막 페이지로 이동</a>';

					innerHTML += '<div class="btnBox sz_small">';
					if (checkCnt > 0) {
						innerHTML += '<button type="button" id="deleteCallQueueBtn" class="btnS_basic" onclick="deleteCallQueue()">삭제</button>';
					} else {
						innerHTML += '<button type="button" id="deleteCallQueueBtn" class="btnS_basic" onclick="deleteCallQueue()" disabled>삭제</button>';
					}
					innerHTML += '</div>';
					$("#callQueuePager").append(innerHTML);

					innerHTML = "";
					innerHTML += '<p class="call_screen">진행예정 : <span>' + paging.totalCount;
					innerHTML += '</span> 명</p>';

					$("#callQueueCount").empty();
					$("#callQueueCount").append(innerHTML);

					$('#callQueueBtn').html('콜큐<span>(' + paging.totalCount + ')<span>');

					$('.ipt_tbl_allCheck').on('click',function(){
						var iptTblAllCheck = $(this).is(":checked");
						if ( iptTblAllCheck ) {
							$(this).prop('checked', true);
							$(this).parents('table').find('tbody td input:checkbox').prop('checked', true);
						} else {
							$(this).prop('checked', false);
							$(this).parents('table').find('tbody td input:checkbox').prop('checked', false);
						}

						var count = $("input:checkbox[name=obCheck]:checked").length;
						var countCallQueue = $("input:checkbox[name=obCallQueueCheck]:checked").length;

						if(count > 0){
							$("#SrtAutoCall").prop("disabled",false);
						}
						else{
							$("#SrtAutoCall").prop("disabled",true);
						}
						if(countCallQueue > 0){
							$("#deleteCallQueueBtn").prop("disabled",false);
						}
						else{
							$("#deleteCallQueueBtn").prop("disabled",true);
						}
					});

					$(".ob_cust_chk").click(function(){
						var count = $("input:checkbox[name=obCheck]:checked").length;
						var countCallQueue = $("input:checkbox[name=obCallQueueCheck]:checked").length;

						if(count > 0){
							$("#SrtAutoCall").prop("disabled",false);
						}
						else{
							$("#SrtAutoCall").prop("disabled",true);
						}
						if(countCallQueue > 0){
							$("#deleteCallQueueBtn").prop("disabled",false);
						}
						else{
							$("#deleteCallQueueBtn").prop("disabled",true);
						}
					});

				}).fail(function (result) {
			console.log("OB user update error");
		});

	}

	//db list 페이지 이동 관련
	function goPage(cp){
		if( cp != 0){
			$('#currentPage').val(cp);
		}

//검색실행
		goSearch(false, cp);

	}
	function goSearch(condition, cp){
		if(condition ==  true) {
			$('#currentPage').val(1);

		}

		var url = "${pageContext.request.contextPath}/getNextList";
		var searchColLeng = $("input[name='searchColumn']").length;
		var jsonObj = {};
		jsonObj.PAGE_COUNT = '10';
		jsonObj.CAMPAIGN_ID = $("#getCampaign option:selected").val();
		for (var i=0; i<searchColLeng; i++) {
			var colName = $("input[name='searchColumn']").eq(i).attr('id');
			var colValue = $("input[name='searchColumn']").eq(i).val();
			jsonObj[colName] = colValue;

		}
		var checkCol = $('.checkColumn');
		var colStore;
		var colValue;
		for (var i=0; i<checkCol.length; i++) {
			if (checkCol[i].checked) {
				var colName = $('.checkColumn').eq(i).attr('name');
				if (colStore == colName) {
					colValue += "," + $('.checkColumn').eq(i).val();
				} else {
					colValue = $('.checkColumn').eq(i).val();

				}

				colStore = colName;
				jsonObj[colName] = colValue;
			}
		}
		jsonObj.cp = cp;
		jsonObj.pageInitPerPage = 10;
		jsonObj.countPerPage = 10;

		httpSend(url, $("#headerName").val(), $("#token").val(),	JSON.stringify(jsonObj)
				,function(result){
					result = JSON.parse(result);

					$("#SrtAutoCall").prop("disabled",true);
					var list = JSON.parse(result.list);
					var paging = JSON.parse(result.paging);
					var cnt = paging.startRow + 1;

					// if(cp%5 == 1){
					// 	cnt = cp;
					// }

					console.log(paging.totalCount);

					var innerHTML = "";

					$.each(list, function(i, v){

						var obj = [];

						// obj.push(v.custType);
						obj.push(v.custNm);
						obj.push(v.telNo);
						obj.push(v.callStatusNm);
						var custDataArr = v.custDataList;

						$.each(obj, function(j, jv){
							if(obj[j] == null || obj[j] == "undefined"){
								obj[j] = "";
							}
						});

						innerHTML += '<tr class="ob_cust_list">';
						innerHTML += '<td scope="row">';
						innerHTML += '	<div class="ipt_check_only">';
						innerHTML += '		<input type="checkbox" class="ob_cust_chk" name="obCheck">';
						innerHTML += '	</div>';
						innerHTML += '</td>';
						innerHTML += '<td>'+cnt+'</td>';
						innerHTML += '<td class="ob_cust_campaignId" id="obCustCampaignId" style="display: none;">'+v.campaignId+'</td>';
						innerHTML += '<td class="ob_cust_contractNo" style="display: none;">'+v.contractNo+'</td>';
						innerHTML += ("<td><a onclick=\"setUserData('telNo','contractNo','campaignId','campaignNm','custId')\">userNm</a></td>").replace("telNo",v.telNo)
						.replace("contractNo",v.contractNo).replace("campaignId",v.campaignId).replace("custId",v.custId).replace("campaignNm",v.campaignNm).replace("userNm",obj[0]);
						innerHTML += '<td class="ob_cust_telNo">'+obj[1]+'<button type="button" class="btn_ico call"></button></td>';
						innerHTML += '<td class="">'+obj[2]+'</td>';
						for(var i=0; i<custDataArr.length; i++){
							innerHTML += '<td class="">'+custDataArr[i]+'</td>';
						}

						innerHTML += '</tr>';

						cnt++;

					});

					$("#dbListBody").empty();
					$("#dbListBody").append(innerHTML);

					//pager
					innerHTML = "";
					$("#dbListPager").empty();

					innerHTML += '<a class="btn_paging_first" href="javascript:goPage(1)" >처음 페이지로 이동</a>';
					innerHTML += '<a class="btn_paging_prev" href="javascript:goPage('+paging.prevPage+')" >이전 페이지로 이동</a>';

					for (var i = paging.pageRangeStart; i<=paging.pageRangeEnd; i++){
						if(i == cp){
							innerHTML += "<strong>"+i+"</strong>";
						}else{
							innerHTML += '<a href="javascript:goPage('+i+')">'+i+'</a>';
						}
					}

					innerHTML += '<a class="btn_paging_next" href="javascript:goPage('+paging.nextPage+')">다음 페이지로 이동</a>';
					innerHTML += '<a class="btn_paging_last" href="javascript:goPage('+paging.totalPage+')">마지막 페이지로 이동</a>';

					$("#dbListPager").append(innerHTML);

					$(".ob_cust_chk").click(function(){
						var count = $("input:checkbox[name=obCheck]:checked").length;
						var countCallQueue = $("input:checkbox[name=obCallQueueCheck]:checked").length;

						if(count > 0){
							$("#SrtAutoCall").prop("disabled",false);
						}
						else{
							$("#SrtAutoCall").prop("disabled",true);
						}
						if(countCallQueue > 0){
							$("#deleteCallQueueBtn").prop("disabled",false);
						}
						else{
							$("#deleteCallQueueBtn").prop("disabled",true);
						}
					});

					$(".call").click(function() {
						var param = {};
						var params = [];
						var checkBtn = $(this);

						var tr = checkBtn.parent().parent();
						var td = tr.children();

						var campaignId = td.eq(2).text();
						var email3 = td.eq(3).text();
						var email4 = td.eq(4).text();
						var email5 = td.eq(6).text();
						var email6 = td.eq(7).text();

						param.campaignId = td.eq(2).text();
						param.contractNo = td.eq(3).text();
						param.custTelNo = td.eq(5).text();
						params.push(param);

						autoCall('START', params);

					});
				});

	}

	//사용자 저장기능
	function saveUser(){

		if ($("#OB_USEREDT_CUST_NM").val() == "" || $("#OB_USEREDT_CUST_NM").val() == null){
			alert('<spring:message code="A0272" text="성명은 필수입니다." />');
			return false;
		}

		<%--if ($("#OB_USEREDT_CUST_TEL_NO").val() == "" || $("#OB_USEREDT_CUST_TEL_NO").val() == null){--%>
		<%--alert('<spring:message code="A0328" text="이동전화는 필수입니다." />');--%>
		<%--return false;--%>
		<%--}--%>

		if (confirm("정말 등록하시겠습니까 ?") == true){
			var formData = $("#userEdtForm").serializeObject();
		}
		else{
			return ;
		}

		$.ajax({
			url : "${pageContext.request.contextPath}/setObUserEdt",
			data : JSON.stringify(formData),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
		}).success(
				function(result) {

					var colList = result.colList;
					var custInfo = result.custInfo;
					if (custInfo[0].custData != null && custInfo[0].custData != "") {
						var custDataArr = custInfo[0].custDataList;
					}
					var innerHTML = "";

					$("#custInfoDetail").empty();
					innerHTML += '<tr>';
					innerHTML += '<th scope="row"><spring:message code="A0039" text="성명" /></th>';
					innerHTML += '<td id="obUserCampaignId" style="display: none;">'+custInfo[0].campaignId+'</td>';
					innerHTML += '<td id="obUserCustId" style="display: none;">'+custInfo[0].custId+'</td>';
					innerHTML += '<td class="USER_CUST_NM USER_TABLE_DEL" id="obUserCustNm">'+custInfo[0].custNm+'</td>';
					innerHTML += '<th><spring:message code="A0049" text="이동전화" /></th>';
					innerHTML += '<td id="obUserCustTelNo">';
					innerHTML += '<button type="button" class="btn_ico call" disabled>전화걸기</button>';
					innerHTML += '<span id="userFormTelNo" class="USER_CUST_TEL_NO USER_TABLE_DEL">'+custInfo[0].telNo+'</span>';
					innerHTML += '</td>';
					innerHTML += '</tr>';


					$.each(colList, function(i, v){

						var obj = [];

						obj.push(v.columnKor);
						obj.push(v.dataType);
						obj.push(v.columnEng);
						if (v.caseType != null && v.caseType != "") {
							var caseTypeArr = v.caseType.split(',');
						}

						$.each(obj, function(j, jv){
							if(obj[j] == null || obj[j] == "undefined"){
								obj[j] = "";
							}
						});
						innerHTML += '<tr>';
						innerHTML += '<th scope="row">'+obj[0]+'</th>';
						if (obj[1] == 'int' || obj[1] == 'string' || obj[1] == 'float') {
							innerHTML += '<td colspan="3" id="'+obj[2]+'">'+ custDataArr[i] +'</td>';
						} else if (obj[1] == 'radiobox') {
							innerHTML += '<td colspan="3">';
							innerHTML += '<div class="radioBox purple">';
							for (var j=0; j<caseTypeArr.length; j++){
								if (custDataArr[i] == caseTypeArr[j]) {
									innerHTML += '<input type="radio" name="user_ipt_radio" id="individual" class="ipt_radio USER_TABLE_DEL" value="'+ j +'" disabled="disabled" checked="checked"> <label for="individual" style="cursor: default;">'+caseTypeArr[j]+'</label>';
								} else {
									innerHTML += '<input type="radio" name="user_ipt_radio" id="individual" class="ipt_radio USER_TABLE_DEL" value="'+ j +'" disabled="disabled"> <label for="individual" style="cursor: default;">'+caseTypeArr[j]+'</label>';
								}
							}
							innerHTML += '</div>';
							innerHTML += '</td>';
						} else if (obj[1] == 'date') {
							innerHTML += '<td colspan="3">';
							innerHTML += '<div class="iptBox">';
							innerHTML += '<input type="text" class="ipt_dateTime reserveDate" id="CSDTL_RECALL_DATE" autocomplete="off" readonly="readonly" disabled="disabled" value="'+custDataArr[i]+'">';
							innerHTML += '</div>';
							innerHTML += '</td>';
						} else if (obj[1] == 'selectbox') {
							innerHTML += '<td colspan="3">';
							innerHTML += '<div class="iptBox">';
							innerHTML += '<select class="select" disabled="disabled">';
							innerHTML += '<option value="' + custDataArr[i]+ '" selected>' + custDataArr[i] + '</option>';
							innerHTML += '</select>';
							innerHTML += '</td>';
						}

						innerHTML += '</tr>';

					});

					$("#custInfoDetail").append(innerHTML);

					//DB List 재검색
					goPage($("#currentPage").val());

					alert(getLocaleMsg("A0589", "등록이 완료되었습니다."));
				}).fail(function(result) {
			console.log("OB user update error");
		});

	}

	//autocall 실행
	function autoCall(state, type){

		if(state == "START"){

			if($("#autoCallYn").val() == "Y"){
				alertInit('<spring:message code="A0275" text="AutoCall 실행중입니다. 종료후 실행해주세요." />', "");
				return;
			}

			//초기화
			var botArr = [];
			var param = {};
			var params = [];
			var paramsCnt = 0;
			var campaignId = "";
			var botArrCnt = 0;
			//봇리스트 생성
			$.each($("div[id$='_chatBot']"), function(i,v){
				campaignId = v.children[0].value.replace(/(\s*)/g,"");
				if($("#getCampaign option:selected").val().replace(/(\s*)/g,"") == campaignId) {
					botArr[botArrCnt] = v.id.substr(0, v.id.indexOf("_"));
					botArrCnt++;
				}
			});
			if(botArr.length == 0){
				alertInit('<spring:message code="A0531" text="음성봇이 존재하지않습니다." />', "");
				return;
			}
			if(type != '') {
				params = type;
			} else {
				$.each($(".ob_cust_list"), function(i,v){
					param = {};
					if($(v).children().find(".ob_cust_chk").prop("checked")){
						param.campaignId = $(v).children(".ob_cust_campaignId").text();
						param.contractNo = $(v).children(".ob_cust_contractNo").text();
						param.custTelNo = $(v).children(".ob_cust_telNo").text();
						params[paramsCnt] = param;
						paramsCnt++;
					}

				});
			}
			console.log(params);
			var cloneSize = 0;
			var cloneArr = botArr;
			if(params.length > botArr.length){
				cloneSize = Math.ceil(params.length/botArr.length);
				for(var i=0; i<cloneSize; i++){
					botArr = botArr.concat(cloneArr);
				}
			}

			$.each(params, function(i, v){
				v.agent = botArr[i];
			});

			startAutocall($("#headerName").val(), $("#token").val(), params);
			$("#callListTable :checkbox").prop("checked",false).change();


		}else{

			if($("#autoCallYn").val() == "N"){
				alertInit('<spring:message code="A0276" text="AutoCall이 실행되지 않았습니다." />', "");
				return;
			}

			stopAutoCall($("#headerName").val(), $("#token").val());

		}

	}

	$(".call").click(function() {
		var param = {};
		var params = [];
		var checkBtn = $(this);

		var tr = checkBtn.parent().parent();
		var td = tr.children();

		var campaignId = td.eq(2).text();
		var email3 = td.eq(3).text();
		var email4 = td.eq(4).text();
		var email5 = td.eq(6).text();
		var email6 = td.eq(7).text();

		param.campaignId = td.eq(2).text();
		param.contractNo = td.eq(3).text();
		param.custTelNo = td.eq(5).text();
		params.push(param);

		autoCall('START', params);

	});


	function openInfoLayer(type){

		var obj = new Object();

		var layerTitle = "";
		var tel_no = $("#userFormTelNo").text();
		var campaign_id = $("#obUserCampaignId").text();
		var cust_id = $("#obUserCustId").text();
		layerTitle = '<spring:message code="A0064" text="고객정보 변경" />';
		$("#handleCsInfoType").val("update");
		var obj = new Object();

		obj.TEL_NO = tel_no;
		obj.CAMPAIGN_ID = campaign_id;
		obj.CUST_ID = cust_id;

		$.ajax(
				{
					url: "${pageContext.request.contextPath}/getObUserInfo",
					data: JSON.stringify(obj),
					method: 'POST',
					contentType: "application/json; charset=utf-8",
					beforeSend: function (xhr) {
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
				}).success(function (result) {
			var colList = result.colList;
			var custInfo = result.custInfo;
			if (custInfo[0].custData != null && custInfo[0].custData != "") {
				var custDataArr = custInfo[0].custDataList;
			}
			var innerHTML = "";

			$("#userEdtBody").empty();

			innerHTML += '<tr>';
			innerHTML += '<th scope="row"><spring:message code="A0039" text="성명" /></th>';
			innerHTML += '<td>';
			innerHTML += '<div class="iptBox">';
			innerHTML += '<input type="hidden" id="editFormCampaignId" name="CAMPAIGN_ID" value="'+custInfo[0].campaignId+'">';
			innerHTML += '<input type="hidden" id="editFormCustId" name="CUST_ID" value="'+custInfo[0].custId+'">';
			innerHTML += '<input type="text" class="ipt_txt" id="OB_USEREDT_CUST_NM" name="CUST_NM" value="'+custInfo[0].custNm+'">';
			innerHTML += '</div>';
			innerHTML += '</td>';
			innerHTML += '<th><spring:message code="A0049" text="이동전화" /></th>';
			innerHTML += '<td>';
			innerHTML += '<div class="iptBox">';
			innerHTML += '<input type="text" class="ipt_txt" id="OB_USEREDT_CUST_TEL_NO" name="CUST_TEL_NO" value="'+custInfo[0].telNo+'" disabled>';
			innerHTML += '</div>';
			innerHTML += '</td>';
			innerHTML += '</tr>';

			$.each(colList, function (i, v) {

				var obj = [];

				obj.push(v.columnKor);
				obj.push(v.dataType);
				obj.push(v.columnEng);
				obj.push(v.custDataClassId);
				if (v.caseType != null && v.caseType != "") {
					var caseTypeArr = v.caseType.split(',');
				}

				$.each(obj, function (j, jv) {
					if (obj[j] == null || obj[j] == "undefined") {
						obj[j] = "";
					}
				});
				innerHTML += '<tr>';
				innerHTML += '<th scope="row">' + obj[0] + '</th>';
				if (obj[1] == 'int' || obj[1] == 'string' || obj[1] == 'float') {
					innerHTML += '<td colspan="3"> <div class="iptBox"> <input type="text" class="ipt_txt" id="' + obj[2] + '" name="' + obj[3] + '" value="' + custDataArr[i] + '"></td>';
				} else if (obj[1] == 'radiobox') {
					innerHTML += '<td colspan="3">';
					innerHTML += '<div class="radioBox purple">';
					for (var j = 0; j < caseTypeArr.length; j++) {
						if (custDataArr[i] == caseTypeArr[j]) {
							innerHTML += '<input type="radio" name="' + obj[3] + '" id="individual'+j+'" class="ipt_radio" value="'
									+ caseTypeArr[j]
									+ '" checked="checked"> <label for="individual'+j+'" style="cursor: default;">'
									+ caseTypeArr[j] + '</label>';
						} else {
							innerHTML += '<input type="radio" name="' + obj[3] + '" id="individual'+j+'" class="ipt_radio" value="'
									+ caseTypeArr[j]
									+ '" > <label for="individual'+j+'" style="cursor: default;">'
									+ caseTypeArr[j] + '</label>';
						}
					}
					innerHTML += '</div>';
					innerHTML += '</td>';
				} else if (obj[1] == 'date') {
					innerHTML += '<td colspan="3">';
					innerHTML += '<div class="iptBox">';
					innerHTML += '<input type="text" class="ipt_dateTime" id="OB_PAYEDT_RECENT_PAYMENT_DATE" name="' + obj[3] + '" value="' + custDataArr[i] + '">';
					innerHTML += '</div>';
					innerHTML += '</td>';
				} else if (obj[1] == 'selectbox') {
					innerHTML += '<td colspan="3">';
					innerHTML += '<div class="iptBox">';
					innerHTML += '<select class="select" name="' + obj[3] + '">';
					for (var j = 0; j < caseTypeArr.length; j++) {
						if (custDataArr[i] == caseTypeArr[j]) {
							innerHTML += '<option value="' + caseTypeArr[j] + '" selected>' + caseTypeArr[j] + '</option>';
						} else {
							innerHTML += '<option value="' + caseTypeArr[j] + '">' + caseTypeArr[j] + '</option>';
						}
					}
					innerHTML += '</select>';
					innerHTML += '</td>';
				}

				innerHTML += '</tr>';

			});

			$("#userEdtBody").append(innerHTML);
			$('#OB_PAYEDT_RECENT_PAYMENT_DATE').datepicker({
				format : "yyyy-mm-dd",
				language : "ko",
				autoclose : true,
				todayHighlight : true,
				defalutDate : new Date()
			});

		}).fail(function (result) {
			console.log("고객정보 불러오기 error");
		});
		$("#ob_infoLayer > div > h3").text(layerTitle);
		openPopup("ob_infoLayer");
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

	function deleteCallQueue(){

		if (confirm("정말 삭제하시겠습니까 ?") == true){
			var callQueueCheck = $("input[name='obCallQueueCheck']");
			var checkCallQueueList = [];
			var cnt = 0;
			for (var i=0; i<callQueueCheck.length; i++) {
				if (callQueueCheck[i].checked) {
					var callQueueVal = $("input[name='obCallQueueCheck']").eq(i).val();
					checkCallQueueList[cnt] = callQueueVal;
					cnt++;
				}
			}
		}
		else{
			return ;
		}

		$.ajax({
			url : "${pageContext.request.contextPath}/deleteCallQueue",
			data : JSON.stringify(checkCallQueueList),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
		}).success(
				function(result) {

					var deleteCount = result.deleteCount;

					//DB List 재검색
					getCallQueueList($("#callQueueCurrentPage").val());

					alert(deleteCount + "개 삭제 완료");
				}).fail(function(result) {
			console.log("OB Call Queue Delete Error");
		});


	}

	function saveCsDtl(STATUS){

		var json = new Object();
		var jsonObj= new Object();
		//contract_no
		json.CONTRACT_NO = $("#CSDTL_CONTRACT_NO").val();
		//통화결과
		json.MNT_STATUS = $("#mnt_status").val();
		//시도결과
		json.DIAL_RESULT = $("#dial_status").val();
		//메모
		json.CALL_MEMO = $("#ob_memo").val();
		//재통화
		jsonObj.CsObResult =json;

		/* if(json.CONTRACT_NO == "" || json.CONTRACT_NO == null){
            alertInit('<spring:message code="A0278" text="상담내용을 확인하여야 저장 가능합니다." />', "");
		return;
	} */

		if(json.DIAL_RESULT == "" || json.DIAL_RESULT == null){
			alertInit('<spring:message code="A0277" text="시도결과를 선택해 주세요." />', "");
			return;
		}

		json = new Object();

		//재통화
		json.CALL_ID = $("#CSDTL_CALL_ID").val();
		json.CONTRACT_NO = $("#CSDTL_CONTRACT_NO").val();
		json.RECALL_TEL_NO = $("#CSDTL_RECALL_TEL_NO").val();
		json.RECALL_DATE =$("#CSDTL_RECALL_DATE").val();

		if(isEmpty(json.RECALL_TEL_NO) != isEmpty(json.RECALL_DATE)){
			if(isEmpty(json.RECALL_TEL_NO))
					//alert("재통화 연락처 입력 하십시오");
				alertInit('<spring:message code="A0273" text="재통화 연락처를 입력 하십시오." />', "");
			if(isEmpty(json.RECALL_DATE))
					//alert("재통화 예약일시를 입력 하십시오");
				alertInit('<spring:message code="A0260" text="재통화 예약일시를 입력 하십시오." />', "");
			return false;
		}
		//재통화
		jsonObj.CsDtlReCall =json;

		//OB결과, 재통화 정보 저장
		ajaxCall("${pageContext.request.contextPath}/setObUserCsDtl", $("#headerName").val(), $("#token").val(), JSON.stringify(jsonObj), "N");

		//callstatus > code 통화결과(02)
		//mntstatus > cude+code_nm 시도결과(09)
		setTimeout(function() {
			initSet();
		}, 100);

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

		ajaxCall("${pageContext.request.contextPath}/getOpObState", $("#headerName").val(), $("#token").val(),	JSON.stringify(jsonObj), "N");
		updateOpStatusSocket("notice");
	}

	function setUserData(tel_no,contract_no,campaignId,campaignNm,custId){
		//고객정보 disabled 해제
		$("#updateUserInfo").attr("disabled", false);
		/* $("#saveCsDtl").attr("disabled", false);
        $("#dial_status").attr("disabled", false);
        $("#mnt_status").attr("disabled", false);
        $("#ob_memo").attr("disabled", false);
        $("#CSDTL_RECALL_TEL_NO").attr("disabled", false);
        $("#CSDTL_RECALL_DATE").attr("disabled", false); */


		$("#dbListTelNo").val(tel_no);
		$("#CSDTL_CONTRACT_NO").val(contract_no);

		//ajaxCall("${pageContext.request.contextPath}/obUserInfo",$("#headerName").val(), $("#token").val(), JSON.stringify(jsonObj), "");

		var obj = new Object();

		obj.TEL_NO = tel_no;
		obj.CAMPAIGN_ID = campaignId;
		obj.CONTRACT_NO = contract_no;
		obj.CAMPAIGN_NM = campaignNm;
		obj.CUST_ID = custId;

		$.ajax(
				{
					url : "${pageContext.request.contextPath}/getObUserInfo",
					data : JSON.stringify(obj),
					method : 'POST',
					contentType : "application/json; charset=utf-8",
					beforeSend : function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
				}).success(function(result) {

			var colList = result.colList;
			var custInfo = result.custInfo;
			if (custInfo[0].custData != null && custInfo[0].custData != "") {
				var custDataArr = custInfo[0].custDataList;
			}
			var innerHTML = "";

			$("#custInfoDetail").empty();
			innerHTML += '<tr>';
			innerHTML += '<th scope="row"><spring:message code="A0039" text="성명" /></th>';
			innerHTML += '<td id="obUserCampaignId" style="display: none;">'+custInfo[0].campaignId+'</td>';
			innerHTML += '<td id="obUserCustId" style="display: none;">'+custInfo[0].custId+'</td>';
			innerHTML += '<td class="USER_CUST_NM USER_TABLE_DEL" id="obUserCustNm">'+custInfo[0].custNm+'</td>';
			innerHTML += '<th><spring:message code="A0049" text="이동전화" /></th>';
			innerHTML += '<td id="obUserCustTelNo">';
			innerHTML += '<button type="button" class="btn_ico call" disabled>전화걸기</button>';
			innerHTML += '<span id="userFormTelNo" class="USER_CUST_TEL_NO USER_TABLE_DEL">'+custInfo[0].telNo+'</span>';
			innerHTML += '</td>';
			innerHTML += '</tr>';


			$.each(colList, function(i, v){

				var obj = [];

				obj.push(v.columnKor);
				obj.push(v.dataType);
				obj.push(v.columnEng);
				if (v.caseType != null && v.caseType != "") {
					var caseTypeArr = v.caseType.split(',');
				}

				$.each(obj, function(j, jv){
					if(obj[j] == null || obj[j] == "undefined"){
						obj[j] = "";
					}
				});
				innerHTML += '<tr>';
				innerHTML += '<th scope="row">'+obj[0]+'</th>';
				if (obj[1] == 'int' || obj[1] == 'string' || obj[1] == 'float') {
					innerHTML += '<td colspan="3" id="'+obj[2]+'">'+ custDataArr[i] +'</td>';
				} else if (obj[1] == 'radiobox') {
					innerHTML += '<td colspan="3">';
					innerHTML += '<div class="radioBox purple">';
					for (var j=0; j<caseTypeArr.length; j++){
						if (custDataArr[i] == caseTypeArr[j]) {
							innerHTML += '<input type="radio" name="user_ipt_radio" id="individual" class="ipt_radio USER_TABLE_DEL" value="'+ j +'" disabled="disabled" checked="checked"> <label for="individual" style="cursor: default;">'+caseTypeArr[j]+'</label>';
						} else {
							innerHTML += '<input type="radio" name="user_ipt_radio" id="individual" class="ipt_radio USER_TABLE_DEL" value="'+ j +'" disabled="disabled"> <label for="individual" style="cursor: default;">'+caseTypeArr[j]+'</label>';
						}
					}
					innerHTML += '</div>';
					innerHTML += '</td>';
				} else if (obj[1] == 'date') {
					innerHTML += '<td colspan="3">';
					innerHTML += '<div class="iptBox">';
					innerHTML += '<input type="text" class="ipt_dateTime reserveDate" id="CSDTL_RECALL_DATE" autocomplete="off" readonly="readonly" disabled="disabled" value="'+custDataArr[i]+'">';
					innerHTML += '</div>';
					innerHTML += '</td>';
				} else if (obj[1] == 'selectbox') {
					innerHTML += '<td colspan="3">';
					innerHTML += '<div class="iptBox">';
					innerHTML += '<select class="select" disabled="disabled">';
					innerHTML += '<option value="' + custDataArr[i]+ '" selected>' + custDataArr[i] + '</option>';
					innerHTML += '</select>';
					innerHTML += '</td>';
				}

				innerHTML += '</tr>';

			});

			$("#custInfoDetail").append(innerHTML);


		}).fail(function(result) {
			console.log("고객정보 불러오기 error");
		});

		initSet();
		$('.callDetail .callView').removeClass("alarm");
		$('.callDetail .callView .callView_tit > h3').text(getLocaleMsg("A0009", "상담 모니터링"));
		$('.callDetail .callView .callView_tit span.call_state').text("");

	}
	function fnDirectCall(campaignId, contractNo, telNo){
		var obj = new Object();

		obj.CAMPAIGN_ID = String(campaignId);
		obj.CONTRACT_NO = String(contractNo);

		console.log("jsp campaignId : " + String(campaignId));
		console.log("jsp contractNo : " + String(contractNo));

		document.getElementById("call_direct").innerHTML = "통화종료";
		$("#call_direct").attr("disabled", false);

		directCall(obj);
	}




	function fnCall(callback_number, campaignId, contractNo){

		var params = [];
		var param = {};
		var botArr = [];

		$.each($("div[id$='_chatBot']"), function(i,v){
			botArr[i] = v.id.substr(0, v.id.indexOf("_"));
		});

		param.campaignId = campaignId;
		param.contractNo = contractNo;
		param.custTelNo = callback_number;
		param.agent = botArr[0];
		params[0] = param;

		console.log(params);
		startAutocall($("#headerName").val(), $("#token").val(), params);

		$(".btn_adide_close").trigger("click");

	}

	function setSideList(url){

		console.log("setSideList");
		console.log(url);

		var jsonObj = {};
		jsonObj.inboundYn = "N";

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

	// 상담개입 종료 팝업
	function consultPop(){
		openPopup("lyr_consultPop");
	}
	// 상담 개입 / 청취 종료 팝업
	function consultEnd(){
		openPopup("lyr_consultEnd_pop");
	}

	function getUserList(result, type) {

		console.log(result);
		var colList = result.colList;
		var list = result.list;
		var paging = result.paging;
		var campaignId = result.CAMPAIGN_ID;
		var commonList = result.commonList;
		var cnt = 1;
		var cp = 1;

		// if(cp%5 == 1){
		// 	cnt = cp;
		// }

		var innerHTML = "";

		$("#custInfoDetail").empty();
		innerHTML += '<tr>';
		innerHTML += '<th scope="row"><spring:message code="A0039" text="성명" /></th>';
		innerHTML += '<td class="USER_CUST_NM USER_TABLE_DEL" id="obUserCustNm"></td>';
		innerHTML += '<th><spring:message code="A0049" text="이동전화" /></th>';
		innerHTML += '<td id="obUserCustTelNo">';
		innerHTML += '<button type="button" class="btn_ico call" disabled>전화걸기</button>';
		innerHTML += '<span class="USER_CUST_TEL_NO USER_TABLE_DEL"></span>';
		innerHTML += '</td>';
		innerHTML += '</tr>';

		$("#custInfoDetail").append(innerHTML);

		innerHTML = "";
		$("#dbListPager").empty();

		innerHTML += '<a class="btn_paging_first" href="javascript:goPage(1)" >처음 페이지로 이동</a>';
		innerHTML += '<a class="btn_paging_prev" href="javascript:goPage('+paging.prevPage+')" >이전 페이지로 이동</a>';

		for (var i = paging.pageRangeStart; i<=paging.pageRangeEnd; i++){
			if(i == cp){
				innerHTML += "<strong>"+i+"</strong>";
			}else{
				innerHTML += '<a href="javascript:goPage('+i+')">'+i+'</a>';
			}
		}

		innerHTML += '<a class="btn_paging_next" href="javascript:goPage('+paging.nextPage+')">다음 페이지로 이동</a>';
		innerHTML += '<a class="btn_paging_last" href="javascript:goPage('+paging.totalPage+')">마지막 페이지로 이동</a>';

		$("#dbListPager").append(innerHTML);

		if (type == 'change') {

			$("#dbListCol").empty();

			var innerHTML = "";

			innerHTML += '<tr>';
			innerHTML += '<th scope="col">';
			innerHTML += '	<div class="ipt_check_only">';
			innerHTML += '		<input type="checkbox" class="ipt_tbl_allCheck">';
			innerHTML += '	</div>';
			innerHTML += '</th>';
			innerHTML += '<td class="ob_cust_campaignId" id="obCustCampaignId" style="display: none;">' + campaignId
					+ '</td>';
			innerHTML += '<th scope="col">No.</th>';
			innerHTML += '<th scope="col" class="th_sort">';
			innerHTML += '<span>성명</span>';
			innerHTML += '<div class="th_dropbox th_search_box">';
			innerHTML += '<div class="iptBox">';
			innerHTML += '<input type="text" id="CUST_NM" class="ipt_txt" name="searchColumn">';
			innerHTML += '</div>';
			innerHTML += '<button type="button" class="btnS_basic btn_dropbox_confirm">확인</button>';
			innerHTML += '</div>';
			innerHTML += '</th>';
			innerHTML += '<th scope="col" class="th_sort">';
			innerHTML += '<span>연락처1(대표)</span>';
			innerHTML += '<div class="th_dropbox th_search_box">';
			innerHTML += '<div class="iptBox">';
			innerHTML += '<input type="text" id="CUST_TEL_NO" class="ipt_txt" name="searchColumn">';
			innerHTML += '</div>';
			innerHTML += '<button type="button" class="btnS_basic btn_dropbox_confirm">확인</button>';
			innerHTML += '</div>';
			innerHTML += '</th>';
			innerHTML += '<th scope="col" class="th_sort">';
			innerHTML += '<span>시도</span>';
			innerHTML += '<div class="th_dropbox th_check_box">';
			innerHTML += '<div class="ipt_check_only">';
			innerHTML += '<input type="checkbox" id="check001" name="checkColumn" class="ipt_dropbox_allCheck">';
			innerHTML += '<label for="check001">전체선택</label>';
			innerHTML += '</div>';
			$.each(commonList, function (i, v) {

				var obj = [];

				obj.push(v.code);
				obj.push(v.cdDesc);

				innerHTML += '<div class="ipt_check_only">';
				innerHTML += '<input type="checkbox" class="checkColumn" id="check00'+i+'" name="callStatus" value="'+ obj[0] +'">';
				innerHTML += '<label for="check00'+i+'">'+obj[1]+'</label>';
				innerHTML += '</div>';
			});
			innerHTML += '<button type="button" class="btnS_basic btn_dropbox_confirm">확인</button>';
			innerHTML += '</div>';
			innerHTML += '</th>';

			$.each(colList, function (i, v) {

				var obj = [];

				obj.push(v.columnKor);
				obj.push(v.dataType);
				obj.push(v.columnEng);
				obj.push(v.custDataClassId);
				if (v.caseType != null && v.caseType != "") {
					var caseTypeArr = v.caseType.split(',');
				}

				$.each(obj, function (j, jv) {
					if (obj[j] == null || obj[j] == "undefined") {
						obj[j] = "";
					}
				});
				innerHTML += '<th scope="col" class="th_sort"><span>'+ obj[0] +'</span>';
				if (obj[1] == 'int' || obj[1] == 'string' || obj[1] == 'float' || obj[1] == 'date') {
					innerHTML += '<div class="th_dropbox th_search_box">';
					innerHTML += '<div class="iptBox">';
					innerHTML += '<input type="text" id="'+ obj[0] +'" class="ipt_txt" name="searchColumn">';
					innerHTML += '</div>';
					innerHTML += '<button type="button" class="btnS_basic btn_dropbox_confirm">확인</button>';
					innerHTML += '</div>';
				} else if (obj[1] == 'radiobox' || obj[1] == 'selectbox') {
					innerHTML += '<div class="th_dropbox th_check_box">';
					innerHTML += '<div class="ipt_check_only">';
					innerHTML += '<input type="checkbox" id="' + obj[2] + '" class="ipt_dropbox_allCheck">';
					innerHTML += '<label for="' + obj[2] + '">전체선택</label>';
					innerHTML += '</div>';
					for (var j = 0; j < caseTypeArr.length; j++) {
						innerHTML += '<div class="ipt_check_only">';
						innerHTML += '<input type="checkbox" class="checkColumn" id="' + obj[2] + j +'" name="' + obj[0] + '" value="'
								+ caseTypeArr[j] + '">';
						innerHTML += '<label for="' + obj[2] + j + '">' + caseTypeArr[j] + '</label>';
						innerHTML += '</div>';
					}
					innerHTML += '<button type="button" class="btnS_basic btn_dropbox_confirm">확인</button>';
					innerHTML += '</div>';
				}
				innerHTML += '</th>';
			});
			innerHTML += '</tr>';

			$("#dbListCol").append(innerHTML);

			$('.ipt_tbl_allCheck').on('click',function(){
				var iptTblAllCheck = $(this).is(":checked");
				if ( iptTblAllCheck ) {
					$(this).prop('checked', true);
					$(this).parents('table').find('tbody td input:checkbox').prop('checked', true);
				} else {
					$(this).prop('checked', false);
					$(this).parents('table').find('tbody td input:checkbox').prop('checked', false);
				}
				var count = $("input:checkbox[name=obCheck]:checked").length;
				var countCallQueue = $("input:checkbox[name=obCallQueueCheck]:checked").length;

				if(count > 0){
					$("#SrtAutoCall").prop("disabled",false);
				}
				else{
					$("#SrtAutoCall").prop("disabled",true);
				}
				if(countCallQueue > 0){
					$("#deleteCallQueueBtn").prop("disabled",false);
				}
				else{
					$("#deleteCallQueueBtn").prop("disabled",true);
				}
			});

		}

		var cnt = 1;
		var cp = 1;

		// if(cp%5 == 1){
		//   cnt = cp;
		// }

		var innerHTML = "";

		$.each(list, function (i, v) {

			var obj = [];

			obj.push(v.custNm);
			obj.push(v.telNo);
			obj.push(v.callStatusNm);
			var custDataArr = v.custDataList;

			$.each(obj, function (j, jv) {
				if (obj[j] == null || obj[j] == "undefined") {
					obj[j] = "";
				}
			});

			innerHTML += '<tr class="ob_cust_list">';
			innerHTML += '<td scope="row">';
			innerHTML += '	<div class="ipt_check_only">';
			innerHTML += '		<input type="checkbox" class="ob_cust_chk" name="obCheck">';
			innerHTML += '	</div>';
			innerHTML += '</td>';
			innerHTML += '<td>' + cnt + '</td>';
			innerHTML += '<td class="ob_cust_campaignId" id="obCustCampaignId" style="display: none;">'+v.campaignId+'</td>';
			innerHTML += '<td class="ob_cust_contractNo" style="display: none;">' + v.contractNo
					+ '</td>';
			innerHTML += ("<td><a onclick=\"setUserData('telNo','contractNo','campaignId','campaignNm','custId')\">userNm</a></td>").replace(
					"telNo", v.telNo).replace("contractNo", v.contractNo)
			.replace("campaignId", v.campaignId).replace("campaignNm", v.campaignNm).replace("custId",
					v.custId).replace("userNm", obj[0]);
			innerHTML += '<td class="ob_cust_telNo">' + obj[1] + '<button type="button" class="btn_ico call"></button></td>';
			innerHTML += '<td class="">' + obj[2] + '</td>';
			for (var i = 0; i < custDataArr.length; i++) {
				innerHTML += '<td class="">' + custDataArr[i] + '</td>';
			}

			innerHTML += '</tr>';

			cnt++;

		});

		$("#dbListBody").empty();
		$("#dbListBody").append(innerHTML);

		if (type == 'change') {
			searchBox();
		}

		$(".ob_cust_chk").click(function(){
			var count = $("input:checkbox[name=obCheck]:checked").length;
			var countCallQueue = $("input:checkbox[name=obCallQueueCheck]:checked").length;

			if(count > 0){
				$("#SrtAutoCall").prop("disabled",false);
			}
			else{
				$("#SrtAutoCall").prop("disabled",true);
			}
			if(countCallQueue > 0){
				$("#deleteCallQueueBtn").prop("disabled",false);
			}
			else{
				$("#deleteCallQueueBtn").prop("disabled",true);
			}
		});

		$(".call").click(function() {
			var param = {};
			var params = [];
			var checkBtn = $(this);

			var tr = checkBtn.parent().parent();
			var td = tr.children();

			var campaignId = td.eq(2).text();
			var email3 = td.eq(3).text();
			var email4 = td.eq(4).text();
			var email5 = td.eq(6).text();
			var email6 = td.eq(7).text();

			param.campaignId = td.eq(2).text();
			param.contractNo = td.eq(3).text();
			param.custTelNo = td.eq(5).text();
			params.push(param);

			autoCall('START', params);

		});
	}

	function checkFileType(filePath) {
		var fileFormat = filePath.split(".");
		if (fileFormat.indexOf("xlsx") > -1) {
			return true;
		} else {
			return false;
		}

	}

	function uploadExcel() {
		var form = $('#uploadExcelForm')[0];

		formData = new FormData(form);
		// 임시 campaign ID
		formData.append("campaign", 116);

		if (confirm("업로드 하시겠습니까?")) {
			$.ajax({
				url: "${pageContext.request.contextPath}/uploadUserList",
				data: formData,
				method: 'POST',
				processData: false,
				contentType: false,
				dataType:'json',
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success: function (data) {
					alert("작업을 완료하였습니다.");
				},
				error: function (data) {
					alert("작업 중 오류가 발생하였습니다.");
				}

			});
		}
	}

	function excelDown() {
		location.href= "/exportToExcel";
	}

	jQuery.fn.serializeObject = function() {
		var obj = null;
		try {
			if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
				var arr = this.serializeArray();
				if (arr) {
					obj = {};
					jQuery.each(arr, function() {
						obj[this.name] = this.value;
					});
				}//if ( arr ) {
			}
		} catch (e) {
			alert(e.message);
		} finally {
		}

		return obj;
	};

	function searchBox() {
		// 추가 AMR 200618
		$('.tbl_dropdown .th_dropbox').on('click', function(e){
			e.stopPropagation();
		})

		// 추가 AMR 200618 table th를 클릭하면 검색할 수 있는 dropbox가 보여진다.
		$('.tbl_dropdown .th_sort').on('click', function(){
			if ( $(this).children('.th_dropbox').hasClass('show') ) {
				$('.tbl_dropdown .th_sort').removeClass('active');
				$('.tbl_dropdown .th_dropbox').removeClass('show');
				return;
			}
			$('.tbl_dropdown .th_dropbox').removeClass('show');
			$('.tbl_dropdown .th_sort').removeClass('active');
			$(this).addClass('active');
			$(this).children('.th_dropbox').addClass('show');
		});

		// 추가 AMR 200618 검색 dropbox에서 확인 버튼을 클릭하면 dropbox가 닫힌다.
		$('.tbl_dropdown .btn_dropbox_confirm').on('click', function(){
			$('.tbl_dropdown .th_dropbox').removeClass('show');
			$('.tbl_dropdown .th_sort').removeClass('active');
			var searchColLeng = $("input[name='searchColumn']").length;
			var obj = new Object();
			obj.PAGE_COUNT = "10";
			obj.CAMPAIGN_ID = $("#getCampaign option:selected").val();
			for (var i=0; i<searchColLeng; i++) {
				var colName = $("input[name='searchColumn']").eq(i).attr('id');
				var colValue = $("input[name='searchColumn']").eq(i).val();
				obj[colName] = colValue;
			}

			var checkCol = $('.checkColumn');
			var colStore;
			var colValue;
			for (var i=0; i<checkCol.length; i++) {
				if (checkCol[i].checked) {
					var colName = $('.checkColumn').eq(i).attr('name');
					if (colStore == colName) {
						colValue += "," + $('.checkColumn').eq(i).val();
					} else {
						colValue = $('.checkColumn').eq(i).val();
					}

					colStore = colName;

					obj[colName] = colValue;
				}
			}
			$.ajax({
				url : "${pageContext.request.contextPath}/getCustInfoList",
				data : JSON.stringify(obj),
				method : 'POST',
				contentType : "application/json; charset=utf-8",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
			}).success(
					function(result) {
						getUserList(result, 'search');

					}).fail(function(result) {
				console.log("getCustInfoList error");
			});
		});

		// 추가 AMR 200618 table th 안에 있는 input이 focus되어 있을 때 enter 키를 누르면 확인이 클릭된다.
		$('.th_dropbox .ipt_txt, .ipt_check_only input[type="checkbox"]').on('keydown', function(e){
			var keyCode = e.which?e.which:e.keyCode;
			if ( keyCode === 13 ) {
				$('.th_dropbox.show').find('.btn_dropbox_confirm').trigger('click');
			}
		});

		// 추가 AMR 200617 table th안에 있는 전체선택 checkbox를 클릭하면 전체선택이 된다.
		$('.ipt_dropbox_allCheck').on('click',function(){
			var iptDropboxAllCheck = $(this).is(":checked");
			if ( iptDropboxAllCheck ) {
				$(this).prop('checked', true);
				$(this).parents('.th_dropbox').find('input:checkbox').prop('checked', true);
			} else {
				$(this).prop('checked', false);
				$(this).parents('.th_dropbox').find('input:checkbox').prop('checked', false);
			}
		});

		// // 추가 AMR 200618 table이 부모보다 크면 가로스크롤이 생김
		// function createTblScrollx() {
		// 	$('.tbl_overflow_x').each(function(){
		// 		var fixWidth = $(this).outerWidth();
		// 		$(this).find('.tbl_customTd.scroll').css({'width': fixWidth + 'px'});
		// 		console.log(fixWidth)
		// 	})
		// }
		//
		// $('.tbl_overflow_x').find('.tbl_customTd.scroll').css({'width': 1 + 'px'});
		// // createTblScrollx()
		//
		// $(window).resize(function(){
		// 	$('.tbl_overflow_x').find('.tbl_customTd.scroll').css({'width': 1 + 'px'});
		// 	createTblScrollx()
		// });
	}

</script>
</body>
</html>
