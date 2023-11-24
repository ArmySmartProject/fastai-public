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
    <input type="hidden" id="headerName" value="${_csrf.headerName}" />
    <input type="hidden" id="token" value="${_csrf.token}" />
    <input type="hidden" id="OP_LOGIN_ID">
    <input type="hidden" id="autoCallYn" value="N">
    <jsp:include page="../common/inc_header.jsp">
        <jsp:param name="titleCode" value="A0860"/>
        <jsp:param name="titleTxt" value="고객데이터 관리"/>
    </jsp:include>


    <!-- #header -->
    <!-- //#headers -->
    <!-- #container -->
    <div id="container">
        <div id="contents">
            <!-- .content -->
            <div class="content">
                <div class="titArea" style="padding: 20px 0 0 0;">
                    <dl class="fl">
                        <dt>Campaign</dt>
                        <dd>
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
                        </dd>
                    </dl>

                    <dl class="fr">
                        <dt class="hide">data upload buttons</dt>
                        <dd>
                            <%-- [D] progress_bar를 채우려면 transform: scaleX(0) 속성을 이용하면 됩니다.
                                진행되지 않은 상태는 0이고 bar가 꽉 찬 상태는 1 입니다.  --%>
                            <div class="data_progress_box">
                                <div class="data_progress">
                                    <div class="data_progress_bar" style="transform: scaleX(0)"></div>
                                </div>
                                <span class="center_txt">데이터 업로드 중 <em class="progress_text">50%</em></span>
                            </div>
                            <button type="button" id="excelDown" class="btnS_line" onclick = "location.href='${pageContext.request.contextPath}/excelTemplateDown'">템플릿 다운로드</button>
                            <button type="button" id="excelExDataDown" class="btnS_line" onclick = "location.href='${pageContext.request.contextPath}/excelExDataDown'">예시데이터 다운로드</button>
                            <button type="button" id="lyr_choose_file" class="btnS_line">데이터 업로드</button>
                        </dd>
                    </dl>
                </div>

                <!-- 검색조건 -->
                <div class="srchArea">
                    <button type="button" class="btnS_line tbody_folding_toggle">상세 검색</button>
                    <table class="tbl_line_view" summary="campaign, 이름, 전화번호, 데이터1, 데이터2, 데이터3, 데이터4, 데이터5, 데이터6 으로 구성됨">
                        <caption class="hide">검색조건</caption>
                        <colgroup>
                            <col width="100"><col><col width="100"><col><col width="100">
                            <col><col width="100"><col>
                            <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                        </colgroup>
                        <tbody id="custInfo">
                        <tr>
                            <th scope="row">이름</th>
                            <td>
                                <div class="iptBox">
                                    <input type="text" id="CUST_NM" class="ipt_txt" name="searchColumn" onkeydown="onKeyDown()">
                                </div>
                            </td>
                            <th>전화번호</th>
                            <td>
                                <div class="iptBox">
                                    <input type="text" id="CUST_TEL_NO" class="ipt_txt" name="searchColumn" onkeydown="onKeyDown()">
                                </div>
                            </td>
                        </tr>
                        </tbody>
                        <tbody id="custInfoDetail" class="tbody_folding hide">
                        <c:forEach items="${colList}" var="colItem" varStatus="ItemStatus">
                            <c:if test="${ItemStatus.count%4 == 1}">
                                <tr>
                            </c:if>
                            <c:if test="${colItem.dataType eq 'selectbox' || colItem.dataType eq 'radiobox'}" >
                                <c:set var="caseTypeArr" value="${fn:split(colItem.caseType,',')}" />
                                <th scope="row">${colItem.columnKor}</th>
                                <td>
                                    <div class="checkBox several_line">
                                        <input type="checkbox" name="ipt_check1_3" id="${colItem.columnEng}" class="ipt_check ipt_checkbox_allCheck">
                                        <label for="${colItem.columnEng}">전체</label>
                                        <c:forEach items="${caseTypeArr}" var="caseType" varStatus="ItemStatus">
                                            <input type="checkbox" class="checkColumn" id="${colItem.columnEng}${ItemStatus.count}" name="${colItem.columnKor}" value="${caseType}" onkeydown="onKeyDown()">
                                            <label for="${colItem.columnEng}${ItemStatus.count}">${caseType}</label>
                                        </c:forEach>
                                    </div>
                                </td>
                            </c:if>
                            <c:if test="${colItem.dataType eq 'string' || colItem.dataType eq 'int'
                               || colItem.dataType eq 'float' || colItem.dataType eq 'date'}" >
                                <th>${colItem.columnKor}</th>
                                <td>
                                    <div class="iptBox">
                                        <input type="text" id="${colItem.columnKor}" class="ipt_txt" autocomplete="off" name="searchColumn" onkeydown="onKeyDown()">
                                    </div>
                                </td>
                            </c:if>
                            <c:if test="${ItemStatus.count%4 == 0}">
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="btnBox sz_small line">
                        <button type="button" class="btnS_basic" onclick="searchUser('','')" onKeyDown="onKeyDown()">검색</button>
                    </div>
                </div>
                <!-- //검색조건 -->

                <!-- .stn -->
                <div class="stn allBoxType tbl_overflow_x jqSt">
                    <div class="titArea" style="padding: 20px 0 0 0;">
                        <div class="fr" style="line-height: 26px;">
                            <dl>
                                <dt class="hide">컬럼이 노출되면 파란색, 발송대상이면 노란색, 노출과 발송대상이면 초록색</dt>
                                <dd class="color_guide">
                                    <span class="color_guide01">노출여부 : Y</span>
                                    <span class="color_guide02">발송대상 : Y</span>
                                    <span class="color_guide03">노출여부, 발송대상 : Y</span>
                                    <span class="color_guide04">노출여부, 발송대상 : N</span>
                                </dd>
                                <%--history 테이블 만들어서 진행해야됨--%>
                                <%--<dt class="hide">업데이트 시간</dt>--%>
                                <%--<dd>--%>
                                    <%--<span style="margin: 0 0 0 10px; line-height: 30px;"><em id="updateTime"></em> updated</span>--%>
                                <%--</dd>--%>
                            </dl>
                        </div>
                    </div>

                    <div class="stn_cont tbl_customTd scroll" style="overflow: auto; height: 630px; margin: 10px 0 0 0; padding: 0;">
                        <table class="tbl_bg_lst04 jqSt_sort" style="max-width: none; min-width: 100%;">
                            <caption class="hide">monitoring List</caption>

                            <thead id="dbListCol">
                            <tr>
                                <!-- [D] 클래스 추가하면 색상적용이 됩니다.
                                    노출여부 Y : color_guide01
                                    발송대상 Y : color_guide02
                                    노출여부 및 발송대상 Y : color_guide03
                                -->
                                <th scope="col" class="color_guide04" style="width: 30px;">No
                                </th>

                                <c:forEach items="${nameTelColType}" var="nameTelType" varStatus="itemStatus">
                                    <c:choose>
                                        <c:when test="${itemStatus.first}">
                                            <th scope="col" id="CUST_NAME" onclick="checkSort(event)"
                                            <c:choose>
                                                <c:when test="${nameTelType.displayYn.toUpperCase() eq 'Y' && nameTelType.obCallStatus.toUpperCase() eq 'Y'}">
                                                    class="color_guide03"
                                                </c:when>
                                                <c:when test="${nameTelType.displayYn.toUpperCase() eq 'Y' && nameTelType.obCallStatus.toUpperCase() eq 'N'}">
                                                    class="color_guide01"
                                                </c:when>
                                                <c:when test="${nameTelType.displayYn.toUpperCase() eq 'N' && nameTelType.obCallStatus.toUpperCase() eq 'Y'}"> 배정현황
                                                    class="color_guide02"
                                                </c:when>
                                                <c:otherwise>
                                                    class="color_guide04"
                                                </c:otherwise>
                                            </c:choose>>이름<span class="s-ico" style="">
                                                <div class="ico_sort">
                                                    <span class="fas fa-sort-up" aria-hidden="true"></span>
                                                    <span class="fas fa-sort-down" aria-hidden="true"></span>
                                                </div>
                                            </th>
                                        </c:when>
                                        <c:otherwise>
                                            <th scope="col" id="CUST_TEL" onclick="checkSort(event)"
	                                            <c:choose>
	                                                <c:when test="${nameTelType.displayYn.toUpperCase() eq 'Y' && nameTelType.obCallStatus.toUpperCase() eq 'Y'}">
	                                                    class="color_guide03"
	                                                </c:when>
	                                                <c:when test="${nameTelType.displayYn.toUpperCase() eq 'Y' && nameTelType.obCallStatus.toUpperCase() eq 'N'}">
	                                                    class="color_guide01"
	                                                </c:when>
	                                                <c:when test="${nameTelType.displayYn.toUpperCase() eq 'N' && nameTelType.obCallStatus.toUpperCase() eq 'Y'}"> 배정현황
	                                                    class="color_guide02"
	                                                </c:when>
	                                                <c:otherwise>
	                                                    class="color_guide04"
	                                                </c:otherwise>
	                                            </c:choose>>전화번호<span class="s-ico" style="">
                                                <div class="ico_sort">
                                                    <span class="fas fa-sort-up" aria-hidden="true"></span>
                                                    <span class="fas fa-sort-down" aria-hidden="true"></span>
                                                </div>
                                            </th>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                                <c:forEach items="${colList}" var="colItem" varStatus="ItemStatus">
                                    <th scope="col" onclick="checkSort(event)"
                                            <c:choose>
                                                <c:when test="${colItem.displayYn.toUpperCase() eq 'Y' && colItem.obCallStatus.toUpperCase() eq 'Y'}">
                                                    class="color_guide03"
                                                </c:when>
                                                <c:when test="${colItem.displayYn.toUpperCase() eq 'Y' && colItem.obCallStatus.toUpperCase() eq 'N'}">
                                                    class="color_guide01"
                                                </c:when>
                                                <c:when test="${colItem.displayYn.toUpperCase() eq 'N' && colItem.obCallStatus.toUpperCase() eq 'Y'}"> 배정현황
                                                    class="color_guide02"
                                                </c:when>
                                                <c:otherwise>
                                                    class="color_guide04"
                                                </c:otherwise>
                                            </c:choose>>
                                        ${colItem.columnKor}<div class="ico_sort">
                                        <span class="fas fa-sort-up" aria-hidden="true"></span>
                                        <span class="fas fa-sort-down" aria-hidden="true"></span>
                                    </div>
                                    </th>
                                </c:forEach>
                            </tr>
                            </thead>
                            <tbody id="dbListBody">
                            <c:forEach items="${list}" var="userItem" varStatus="ItemStatus">
                                <tr>
                                    <td scope="row">${ItemStatus.count}</td>
                                    <td>${userItem.custNm}</td>
                                    <td>${userItem.telNo}</td>
                                    <c:set var="custDataArr" value="${userItem.custDataList}" />
                                    <c:forEach var="custData" items="${custDataArr}">
                                        <td>${custData}</td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- jqSt_paging -->
                    <div class="ui-state-default jqSt_paging" id="dbListPager" style="border-radius: 0 0 3px 3px;">
                        <div class="jqSt_navi">
                            <!-- [D] 이전,다음,맨처음,맨마지막 페이지 버튼에 커서를 대면 손가락 모양으로 보여집니다.
                                disabled class가 적용되면 기본 마우스 모양으로 보여집니다.
                             -->
                            <button type="button" title="First Page"><a class="ui-icon fas fa-angle-double-left" aria-hidden="true" href="javascript:goPage(1)"></a></button>
                            <button type="button" title="Previous Page"><a class="ui-icon fas fa-angle-left" aria-hidden="true" href="javascript:goPage('${paging.prevPage}')"></a></button>
                            <!-- // 첫번째 페이지로 가기, 이전 페이지로 가기 버튼 -->

                            <%--<span class="page_num">Page--%>
                                <%--<input aria-label="Page No." type="text" size="2" maxlength="7" value="1"> of--%>
                                <%--<span id="sp_1_jqGridPager">1</span>--%>
                            <%--</span>--%>
                            <c:forEach begin="${paging.pageRangeStart}" end="${paging.pageRangeEnd}" varStatus="loopIdx">
                                <c:choose>
                                    <c:when test="${paging.currentPage eq loopIdx.index}">
                                        <em>${loopIdx.index}</em>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="javascript:goPage('${loopIdx.index}')">${loopIdx.index}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <!-- // [page 현재 페이지 of 총페이지] , 현재페이지는 input value에 들어갑니다-->

                            <button type="button" title="Next Page"><a class="ui-icon fas fa-angle-right" aria-hidden="true" href="javascript:goPage('${paging.nextPage}')"></a></button>
                            <button type="button" title="Last Page"><a class="ui-icon fas fa-angle-double-right" aria-hidden="true" href="javascript:goPage('${paging.totalPage}')"></a></button>
                            <!-- // 다음 페이지로 가기, 마지막 페이지로 가기 버튼 -->

                            <%--<select title="Records per Page" class="page_selbox">--%>
                                <%--<option value="10">10</option>--%>
                                <%--<option value="20">20</option>--%>
                                <%--<option value="30" selected="selected">30</option>--%>
                            <%--</select>--%>
                            <!-- //리스트가 보여질 개수 -->
                        </div>

                        <div class="jqSt_info">
                            <span>View ${paging.startRow+1} - ${paging.lastRow} of ${paging.totalCount}</span>
                        </div>
                    </div>


                </div>
                <!-- //.stn -->
            </div>
            <!-- //.content -->
        </div>
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

<!-- 파일 선택 팝업 -->
<div id="lyr_select_file" class="lyrBox lyr_alert">
    <div class="lyr_cont">
        <p>선택한 파일을 적용하시겠습니까?</p>
        <form id="uploadExcelForm" name="uploadExcelForm" method="post" enctype="multipart/form-data">
            <input type="file" id="select_file" name="select_file" class="hide" accept=".xls, .xlsx">
            <label for="select_file">파일선택</label>
        </form>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button class="btn_close" onclick="checkUploadExcel()">적용</button>
            <button class="btn_close">취소</button>
        </div>
    </div>
</div>
<!-- //안내 팝업 -->

<!-- 업로드 데이터 유효성검사 팝업 -->
<div id="data_upload_check" class="lyrBox lyr_alert">
    <div class="lyr_top">
        <h3>업로드 데이터 확인</h3>
    </div>
    <div class="lyr_mid">
        <div class="lot_row">
            <div class="lot_cell">
                <div class="data_titles">
                    <h4>엑셀 데이터 갯수: <span id="uploadDataCnt">300</span>개</h4>
                    <h4>저장할 데이터 갯수: <span class="highlight" id="saveDataCnt">296</span>개</h4>
                </div>

                <h5>컬럼 유효성 검사</h5>
                <div class="tbl_customTd scroll tbl_col_validation">
                    <table class="tbl_line_lst" summary="컬럼 규격, 업로드 컬럼으로 구성됨">
                        <caption class="hide">컬럼 유효성 검사</caption>
                        <colgroup>
                            <col><col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">컬럼 규격(sheet1)</th>
                            <th scope="col">업로드 컬럼(sheet2)</th>
                        </tr>
                        </thead>
                        <tbody id="checkUploadColums">
                        <tr>
                            <td>이름</td>
                            <td class="valid"><i>&#10003;</i> 유효</td>
                        </tr>
                        <tr>
                            <td>전화번호</td>
                            <td class="valid"><i>&#10003;</i> 유효</td>
                        </tr>
                        <tr>
                            <td>계약일</td>
                            <td class="invalid"><i>&#215;</i> 무효</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="lot_cell">
                <h5>고객 데이터 유효성 검사</h5>
                <p class="infoTxt">업로드 목록 내 중복된 데이터: <span id="distinctCnt">4</span>건</p>
                <div class="tbl_customTd scroll tbl_data_validation">
                    <table class="tbl_line_lst" summary="무시될 데이터와 업데이트 될 데이터로 구성됨">
                        <caption class="hide">업로드 목록 내 중복된 데이터</caption>
                        <colgroup>
                            <col><col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">무시될 데이터</th>
                            <th scope="col">업데이트 될 데이터</th>
                        </tr>
                        </thead>
                        <tbody id="checkUploadDistinct">
                        <tr>
                            <td colspan="2" style="text-align: center; opacity: 1;">중복된 데이터가 없습니다.</td>
                        </tr>
                        <tr>
                            <td>홍길동 010-1234-1234</td>
                            <td>이방원 010-1234-1234</td>
                        </tr>
                        <tr>
                            <td>이일이 010-2120-2120</td>
                            <td>이삼이 010-2120-2120</td>
                        </tr>
                        <tr>
                            <td>이오이 010-2520-2520</td>
                            <td>이팔이 010-2520-2520</td>
                        </tr>
                        <tr>
                            <td>삼오이 010-3520-3520</td>
                            <td>삼칠이 010-3520-3520</td>
                        </tr>
                        <tr>
                            <td>test</td>
                            <td>test</td>
                        </tr>
                        <tr>
                            <td>test</td>
                            <td>test</td>
                        </tr>
                        <tr>
                            <td>test</td>
                            <td>test</td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <p class="infoTxt">이미 등록되어 있는 고객 데이터: <span id="updateCnt">4</span>건</p>
                <div class="tbl_customTd scroll tbl_data_validation">
                    <table class="tbl_line_lst" summary="삭제될 데이터와 업데이트 될 데이터로 구성됨">
                        <caption class="hide">업로드 목록 내 중복된 데이터</caption>
                        <colgroup>
                            <col><col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">삭제될 데이터</th>
                            <th scope="col">업데이트 될 데이터</th>
                        </tr>
                        </thead>
                        <tbody id="checkUploadUpdate">
                        <tr>
                            <td colspan="2" style="text-align: center; opacity: 1;">이미 등록되어 있는 데이터가 없습니다.</td>
                        </tr>
                        <tr>
                            <td>홍길동 010-1234-1234</td>
                            <td>이방원 010-1234-1234</td>
                        </tr>
                        <tr>
                            <td>이일이 010-2120-2120</td>
                            <td>이삼이 010-2120-2120</td>
                        </tr>
                        <tr>
                            <td>이오이 010-2520-2520</td>
                            <td>이팔이 010-2520-2520</td>
                        </tr>
                        <tr>
                            <td>삼오이 010-3520-3520</td>
                            <td>삼칠이 010-3520-3520</td>
                        </tr>
                        <tr>
                            <td>test</td>
                            <td>test</td>
                        </tr>
                        <tr>
                            <td>test</td>
                            <td>test</td>
                        </tr>
                        <tr>
                            <td>test</td>
                            <td>test</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button class="btn_win_close" onclick="uploadExcel();">업로드</button>
            <button class="btn_win_close">취소</button>
        </div>
    </div>
</div>
<!-- //업로드 데이터 유효성검사 팝업 -->

<!-- 공통 script -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>
<!-- fontAwesome -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/all.js"></script>
<!-- datepicker -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap-datepicker.js"></script>
<!-- 공통 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>

<!-- page Landing -->
<script type="text/javascript">
  $(window).load(function() {
    //page loading delete
    $('#pageldg').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });
  });
</script>
<!-- script -->
<script type="text/javascript">
  jQuery.event.add(window,"load",function(){
    $(document).ready(function (){
      // GCS iframe
      $('.gcsWrap', parent.document).each(function(){
        //header 화면명 변경
        var pageTitle = $('title').text().replace('> FAST AICC', '');

        $(top.document).find('#header h2 a').text(pageTitle);
      });

      //datepicker
      $('#fromDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
      });

      $('#toDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true
      });

      $('#getCampaign').on('change', function() {
        var obj = new Object();
        obj.CAMPAIGN_ID = this.value;
        obj.PAGE_COUNT = "20";
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

            }).fail(function(result) {
          console.log("getCustInfoList error");
        });
      });

      //AMR 검색 박스 테이블 접기/펴기
      $('.tbody_folding_toggle').on('click', function(){
        setTimeout(function(){
          $('.tbody_folding').toggleClass('hide')
      }, 100);
      });

      // 추가 AMR 200617 table th안에 있는 전체선택 checkbox를 클릭하면 전체선택이 된다.
      $('.ipt_checkbox_allCheck').on('click',function(){
        var iptCheckboxAllCheck = $(this).is(":checked");
        if ( iptCheckboxAllCheck ) {
          $(this).siblings('input:checkbox').prop('checked', true);
        } else {
          $(this).siblings('input:checkbox').prop('checked', false);
        }
      });

      // 추가 AMR 200701 파일 선택 레이어 팝업 open 및 파일 선택 열기
      $('#lyr_choose_file').on('click',function(){
        $('#lyr_select_file').css('display', 'block');
        $('#select_file').trigger('click');
      });

      // 추가 AMR 200701 파일 선택 레이어에서 닫기를 누르면 input file label명을 파일선택으로 변경하기
      $('#lyr_select_file .btn_close').on('click',function(){
        $('.lyr_alert').hide();
        $('#select_file').next('label').text('파일선택')
      });
      
      $('#data_upload_check .btn_win_close').on('click',function(){
        $('.lyr_alert').hide();
      });

      //선택한 파일이름을 label에 치환
      $('#select_file').change(function(e){
        var fileName = e.target.files[0].name;
        $(this).next('label').text(fileName);
      });

      // AMR 200618 table이 부모보다 크면 가로스크롤이 생김
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
    });
  });

  function checkSort(e) {
    // $('.jqSt_sort th').on('click', function(){
    var columnModel;
    var sortType;
    var tableInfo;
    var th;
    var sortTh = $(e.path);
    var thisTh = $(e.target);
    for (var i=0; i<sortTh.length; i++) {
      if (sortTh[i].localName == 'th') {
        th = sortTh[i];
      }
    }
    thisTh[0] = th;
    if (thisTh.find('.ico_sort span:first-child').hasClass('active') ) {
      columnModel = thisTh.text().replace(/(\s*)/g, "");
      sortType = 'desc';
      searchUser(columnModel, sortType, thisTh);
    } else if (thisTh.find('.ico_sort span:last-child').hasClass('active') ) {
      searchUser(columnModel, sortType, thisTh);
    } else {
      columnModel = thisTh.text().replace(/(\s*)/g, "");
      sortType = 'asc';
      searchUser(columnModel, sortType, thisTh);
    }

  }

  function getUserList(result, type) {

    console.log(result);
    var colList = result.colList;
    var list = result.list;
    var paging = result.paging;
    var nameTelColType = result.nameTelColType;

    innerHTML ="";
    $("#dbListPager").empty();
    var cp = 1;

    innerHTML += '<div class="jqSt_navi">';
    innerHTML += '<button type="button" title="First Page"><a class="ui-icon fas fa-angle-double-left" aria-hidden="true" href="javascript:goPage(1)" ></a></button>';
    innerHTML += '<button type="button" title="Previous Page"><a class="ui-icon fas fa-angle-left" aria-hidden="true" href="javascript:goPage(' + paging.prevPage
        + ')" ></a></button>';

    for (var i = paging.pageRangeStart; i <= paging.pageRangeEnd; i++) {
      if (i == cp) {
        innerHTML += "<em>" + i + "</em>";
      } else {
        innerHTML += '<a href="javascript:goPage(' + i + ')">' + i + '</a>';
      }
    }

    innerHTML += '<button type="button" title="Next Page"><a class="ui-icon fas fa-angle-right" aria-hidden="true" href="javascript:goPage(' + paging.nextPage
        + ')"></a></button>';
    innerHTML += '<button type="button" title="Last Page"><a class="ui-icon fas fa-angle-double-right" aria-hidden="true" href="javascript:goPage(' + paging.totalPage
        + ')"></a></button>';
    innerHTML += '<div class="jqSt_info">';
    innerHTML += '<span>View ' + eval(paging.startRow + 1) + ' - ' + paging.lastRow + ' of ' + paging.totalCount + '</span>';
    innerHTML += '</div>';

    $("#dbListPager").append(innerHTML);

    if (type == 'change') {

      if ( $('.tbody_folding').hasClass('hide') ) {
        $('.tbody_folding').removeClass('hide');
        $('.tbody_folding').addClass('hide');
      }
      $('.tbody_folding').addClass('hide');

      var innerHTML = "";

      $("#CUST_NM").val("");
      $("#CUST_TEL_NO").val("");
      $("#custInfoDetail").empty();

      var cnt = 1;

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
        if (cnt%4 == 1) {
          innerHTML += '<tr>';
        }
        if (obj[1] == 'radiobox' || obj[1] == 'selectbox') {
          innerHTML += '<th scope="row">'+obj[0]+'</th>';
          innerHTML += '<td>';
          innerHTML += '<div class="checkBox several_line">';
          innerHTML += '<input type="checkbox" id="'+obj[2]+'" class="ipt_check ipt_checkbox_allCheck" onkeydown="onKeyDown()">';
          innerHTML += '<label for="'+obj[2]+'">전체선택</label>';
          for (var j = 0; j < caseTypeArr.length; j++) {
            innerHTML += '<input type="checkbox" class="checkColumn" id="' + obj[2] + j +'" name="' + obj[0] + '" value="'
                + caseTypeArr[j] + '" onkeydown="onKeyDown()">';
            innerHTML += '<label for="' + obj[2] + j + '">' + caseTypeArr[j] + '</label>';
          }
          innerHTML += '</div>';
          innerHTML += '</td>';
        }
        if (obj[1] == 'int' || obj[1] == 'string' || obj[1] == 'float' || obj[1] == 'date') {
          innerHTML += '<th>'+obj[0]+'</th>';
          innerHTML += '<td>';
          innerHTML += '<div class="iptBox">';
          innerHTML += '<input type="text" id="'+obj[0]+'" class="ipt_txt" autocomplete="off" name="searchColumn" onkeydown="onKeyDown()">';
          innerHTML += '</div>';
          innerHTML += '</td>';
        }
        if (cnt%4 == 0) {
          innerHTML += '</tr>';
        }
        cnt++;
      });

      $("#custInfoDetail").append(innerHTML);

      $("#dbListCol").empty();

      var innerHTML = "";

      innerHTML += '<tr>';
      innerHTML += '<th scope="col" class="color_guide04" style="width: 30px;">No';
      innerHTML += '</th>';
      for (var i = 0; i < nameTelColType.length; i++) {
        if (i == 0) {
          innerHTML += '<th scope="col" id="CUST_NAME" onclick="checkSort(event)"';
          if (nameTelColType[i].displayYn.toUpperCase() == 'Y' && nameTelColType[i].obCallStatus.toUpperCase() == 'Y') {
            innerHTML += 'class="color_guide03">';
          } else if (nameTelColType[i].displayYn.toUpperCase() == 'Y' && nameTelColType[i].obCallStatus.toUpperCase() == 'N') {
            innerHTML += 'class="color_guide01">';
          } else if (nameTelColType[i].displayYn.toUpperCase() == 'N' && nameTelColType[i].obCallStatus.toUpperCase() == 'Y') {
            innerHTML += 'class="color_guide02">';
          } else {
            innerHTML += 'class="color_guide04">';
          }
          innerHTML += '이름<span class="s-ico" style="">';
          innerHTML += '<div class="ico_sort">';
          innerHTML += '<span class="fas fa-sort-up" aria-hidden="true"></span>';
          innerHTML += '<span class="fas fa-sort-down" aria-hidden="true"></span>';
          innerHTML += '</div>';
          innerHTML += '</th>';
        } else {
          innerHTML += '<th scope="col" id="CUST_TEL" onclick="checkSort(event)"';
          if (nameTelColType[i].displayYn.toUpperCase() == 'Y' && nameTelColType[i].obCallStatus.toUpperCase() == 'Y') {
            innerHTML += 'class="color_guide03">';
          } else if (nameTelColType[i].displayYn.toUpperCase() == 'Y' && nameTelColType[i].obCallStatus.toUpperCase() == 'N') {
            innerHTML += 'class="color_guide01">';
          } else if (nameTelColType[i].displayYn.toUpperCase() == 'N' && nameTelColType[i].obCallStatus.toUpperCase() == 'Y') {
            innerHTML += 'class="color_guide02">';
          } else {
            innerHTML += 'class="color_guide04">';
          }
          innerHTML += '전화번호<span class="s-ico" style="">';
          innerHTML += '<div class="ico_sort">';
          innerHTML += '<span class="fas fa-sort-up" aria-hidden="true"></span>';
          innerHTML += '<span class="fas fa-sort-down" aria-hidden="true"></span>';
          innerHTML += '</div>';
          innerHTML += '</th>';
        }
      }

      $.each(colList, function (i, v) {

        var obj = [];

        obj.push(v.columnKor);
        obj.push(v.displayYn);
        obj.push(v.obCallStatus);

        $.each(obj, function (j, jv) {
          if (obj[j] == null || obj[j] == "undefined") {
            obj[j] = "";
          }
        });
        innerHTML += '<th scope="col" onclick="checkSort(event)"';
        if (obj[1].toUpperCase() == 'Y' && obj[2].toUpperCase() == 'Y') {
          innerHTML += 'class="color_guide03">';
        } else if (obj[1].toUpperCase() == 'Y' && obj[2].toUpperCase() == 'N') {
          innerHTML += 'class="color_guide01">';
        } else if (obj[1].toUpperCase() == 'N' && obj[2].toUpperCase() == 'Y') {
          innerHTML += 'class="color_guide02">';
        } else {
          innerHTML += 'class="color_guide04">';
        }
        innerHTML += obj[0] + '<span class="s-ico" style="">';
        innerHTML += '<div class="ico_sort">';
        innerHTML += '<span class="fas fa-sort-up" aria-hidden="true"></span>';
        innerHTML += '<span class="fas fa-sort-down" aria-hidden="true"></span>';
        innerHTML += '</div>';
        innerHTML += '</th>';
      });

      innerHTML += '</tr>';

      $("#dbListCol").append(innerHTML);

    }

    // if(cp%5 == 1){
    //   cnt = cp;
    // }

    var innerHTML = "";
    cnt = paging.startRow + 1;

    $.each(list, function (i, v) {

      var obj = [];

      obj.push(v.custNm);
      obj.push(v.telNo);
      var custDataArr = v.custDataList;

      $.each(obj, function (j, jv) {
        if (obj[j] == null || obj[j] == "undefined") {
          obj[j] = "";
        }
      });

      innerHTML += '<tr>';
      innerHTML += '<td>' + cnt + '</td>';
      innerHTML += '<td class="ob_cust_contractNo" style="display: none;">' + v.contractNo
          + '</td>';
      innerHTML += ("<td><a onclick=\"setUserData('telNo','contractNo','campaignId','campaignNm','custId')\">userNm</a></td>").replace(
          "telNo", v.telNo).replace("contractNo", v.contractNo)
      .replace("campaignId", v.campaignId).replace("campaignNm", v.campaignNm).replace("custId",
          v.custId).replace("userNm", obj[0]);
      innerHTML += '<td class="ob_cust_telNo">' + obj[1] + '</td>';
      for (var i = 0; i < custDataArr.length; i++) {
        innerHTML += '<td class="">' + custDataArr[i] + '</td>';
      }

      innerHTML += '</tr>';

      cnt++;

    });

    $("#dbListBody").empty();
    $("#dbListBody").append(innerHTML);

    // $('.jqSt_sort th').on('click', function(){
    //   if ( $(this).find('.ico_sort span:first-child').hasClass('active') ) {
    //     $(this).find('.ico_sort span').removeClass('active');
    //     $(this).find('.ico_sort span:last-child').addClass('active');
    //     return;
    //   } else if ( $(this).find('.ico_sort span:last-child').hasClass('active') ) {
    //     $(this).find('.ico_sort span').removeClass('active');
    //     return;
    //   }
    //
    //   $('.jqSt_sort th').find('.ico_sort span').removeClass('active');
    //   $(this).find('.ico_sort span').removeClass('active');
    //   $(this).find('.ico_sort span:first-child').addClass('active');
    // });

    $('.ipt_checkbox_allCheck').on('click',function(){
      var iptCheckboxAllCheck = $(this).is(":checked");
      if ( iptCheckboxAllCheck ) {
        $(this).siblings('input:checkbox').prop('checked', true);
      } else {
        $(this).siblings('input:checkbox').prop('checked', false);
      }
    });
  }

  function getUploadStatus(){
      var form = $('#uploadExcelForm')[0];

      formData = new FormData(form);
      // 임시 campaign ID
      formData.append("campaign", $("#getCampaign option:selected").val());

      $.ajax({
          url: "${pageContext.request.contextPath}/getUploadStatus",
          data: formData,
          method: 'POST',
          processData: false,
          contentType: false,
          dataType:'json',
          beforeSend : function(xhr) {
              xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
          },
          success: function (data) {
              var $progressBox = $('dl.fr dd div.data_progress_box');
              if (data == null || data.uploadStatus == null) {
                  // $progressBox.removeClass('on');
                  $progressBox.find('.data_progress_bar').css('transform', 'scaleX(1)');
                  $progressBox.find('span.center_txt').html("완료");

              } else {
                  if (!$progressBox.hasClass('on')) {
                      $progressBox.addClass('on');
                  }

                  var uploadStatus = data.uploadStatus;
                  var percent = Number(uploadStatus.processed) / Number(uploadStatus.total);

                  // console.log(Number(uploadStatus.processed));
                  // console.log(Number(uploadStatus.total));
                  $progressBox.find('.data_progress_bar').css('transform', 'scaleX(' + percent + ')');
                  $progressBox.find('span.center_txt').html(uploadStatus.description);
                  //+' <em class="progress_text">' + uploadStatus.processed + '/' + uploadStatus.total + '</em>');
              }
              console.log("---------------------");
          },
          error: function (data) {
              var $progressBox = $('dl.fr dd div.data_progress_box');
              $progressBox.removeClass('on');

              console.log('업로드 상태를 가져올 수 없습니다.');
              console.log(data);
          }

      });
  }

  function statusMonitoringDone(interval) {
      var $progressBox = $('dl.fr dd div.data_progress_box');
      $progressBox.removeClass('on');
      clearInterval(interval);
  }


  function checkUploadExcel(){

    // 1초마다 업로드 상태 가져오기
    var statusInterval = setInterval(getUploadStatus, 1000);

  	var form = $('#uploadExcelForm')[0];

    formData = new FormData(form);
    // 임시 campaign ID
    formData.append("campaign", $("#getCampaign option:selected").val());
    
    $.ajax({
        url: "${pageContext.request.contextPath}/checkUploadUserList",
        data: formData,
        method: 'POST',
        processData: false,
        contentType: false,
        dataType:'json',
        beforeSend : function(xhr) {
          xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function (data) {
        	var firstSheetColumsList = data.checkExcelMap.firstSheetColumsList;
        	var secondSheetColumsList = data.checkExcelMap.secondSheetColumsList;
        	var checkDistinctMap = data.checkExcelMap.checkDistinctMap;
        	var checkUpdateMap = data.checkExcelMap.checkUpdateMap;
        	var uploadDataCnt = data.checkExcelMap.uploadDataCnt;
        	var saveDataCnt = uploadDataCnt - checkDistinctMap.ignoreCustList.length;
        	
        	$("#uploadDataCnt").text(uploadDataCnt);
        	$("#saveDataCnt").text(saveDataCnt);
        	
        	//컬럼 유효성 체크
        	columsHtml = "";
       		for(i=0; i < firstSheetColumsList.length || i < secondSheetColumsList.length; i++){
       		    if(firstSheetColumsList[i] == secondSheetColumsList[i]){
       		    	columsHtml +="<tr>";
       		    	columsHtml +="<td>"+ firstSheetColumsList[i] +"</td>";
       		    	columsHtml +="<td class='valid'><i>&#10003;</i> 유효</td>";
       		    	columsHtml +="</tr>";
       		    }else{
       		    	columsHtml +="<tr>";
       		    	columsHtml +="<td>"+ firstSheetColumsList[i] +"</td>";
       		    	columsHtml +="<td class='invalid'><i>&#215;</i> 무효</td>";
       		    	columsHtml +="</tr>";
       		    }
       		}
        	$("#checkUploadColums").empty();
        	$("#checkUploadColums").append(columsHtml);
        	
        	var distinctHtml = "";
        	$("#distinctCnt").text(checkDistinctMap.ignoreCustList.length);
        	if(checkDistinctMap.ignoreCustList.length > 0){
	        	for (var i = 0; i < checkDistinctMap.ignoreCustList.length; i++) {
        			distinctHtml += "<tr>";
        			distinctHtml += "<td>"+checkDistinctMap.ignoreCustList[i].custNm+" "+ checkDistinctMap.ignoreCustList[i].custTelNo+"</td>";
       				distinctHtml += "<td>"+checkDistinctMap.insertDistinctList[i].custNm+" "+ checkDistinctMap.insertDistinctList[i].custTelNo+"</td>";
        			distinctHtml += "</tr>";
        		}
			}else{
       			distinctHtml += "<tr>";
				distinctHtml += "<td colspan='2' style='text-align: center; opacity: 1;'>엑셀 내에 중복된 데이터가 없습니다.</td>";
       			distinctHtml += "</tr>";
			}
        	
        	$("#checkUploadDistinct").empty();
        	$("#checkUploadDistinct").append(distinctHtml);
        	
        	var updateHtml = "";
        	$("#updateCnt").text(checkUpdateMap.beforeCustList.length);
        	if(checkUpdateMap.beforeCustList.length > 0){
	        	for (var i = 0; i < checkUpdateMap.beforeCustList.length; i++) {
	        		updateHtml += "<tr>";
	        		updateHtml += "<td>"+checkUpdateMap.beforeCustList[i].custNm+" "+ checkUpdateMap.beforeCustList[i].custTelNo+"</td>";
	        		updateHtml += "<td>"+checkUpdateMap.afterCustList[i].custNm+" "+ checkUpdateMap.afterCustList[i].custTelNo+"</td>";
	        		updateHtml += "</tr>";
        		}
			}else{
				updateHtml += "<tr>";
				updateHtml += "<td colspan='2' style='text-align: center; opacity: 1;'>이미 등록되어 있는 데이터가 없습니다.</td>";
				updateHtml += "</tr>";
			}
        	
        	$("#checkUploadUpdate").empty();
        	$("#checkUploadUpdate").append(updateHtml);
        	
        	$('#data_upload_check').css('display', 'block');

            statusMonitoringDone(statusInterval);
        },
        error: function (data) {
            alert("작업 중 오류가 발생하였습니다.");
            statusMonitoringDone(statusInterval);
          }

        });
    
  }

  function uploadExcel() {

      // 1초마다 업로드 상태 가져오기
      var statusInterval = setInterval(getUploadStatus, 1000);

    var form = $('#uploadExcelForm')[0];

    formData = new FormData(form);
    // 임시 campaign ID
    formData.append("campaign", $("#getCampaign option:selected").val());
	
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
          $('.lyr_alert').hide();
          // $('#updateTime').text(data.updateTime);
          var obj = new Object();
          obj.CAMPAIGN_ID = $("#getCampaign option:selected").val();
          obj.PAGE_COUNT = "20";
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
                  statusMonitoringDone(statusInterval);
              }).fail(function(result) {
            console.log("getCustInfoList error");
              statusMonitoringDone(statusInterval);
          });
        },
        error: function (data) {
          alert("작업 중 오류가 발생하였습니다.");
            statusMonitoringDone(statusInterval);
        }

      });
    }else {
    	statusMonitoringDone(statusInterval);
    }
  }

  function searchUser(columnModel, sortType, $this) {
    var searchColLeng = $("input[name='searchColumn']").length;
    var obj = new Object();
    obj.PAGE_COUNT = "20";
    obj.CAMPAIGN_ID = $("#getCampaign option:selected").val();
    obj.COLUMN_MODEL = columnModel;
    obj.SORT_TYPE = sortType;
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
          if ($this.find('.ico_sort span:first-child').hasClass('active') ) {
            $this.find('.ico_sort span').removeClass('active');
            $this.find('.ico_sort span:last-child').addClass('active');
          } else if ($this.find('.ico_sort span:last-child').hasClass('active') ) {
            $this.find('.ico_sort span').removeClass('active');
          } else {
            $('.jqSt_sort th').find('.ico_sort span').removeClass('active');
            $this.find('.ico_sort span').removeClass('active');
            $this.find('.ico_sort span:first-child').addClass('active');
          }

        }).fail(function(result) {
      console.log("getCustInfoList error");
    });
  };

  function goPage(cp){
    if( cp != 0){
      $('#currentPage').val(cp);
    }

    goSearch(false, cp);
  }

  //검색실행
  function goSearch(condition, cp){
    if(condition ==  true) {
      $('#currentPage').val(1);
    }

    var url = "${pageContext.request.contextPath}/getNextList";
    var searchColLeng = $("input[name='searchColumn']").length;
    var thLeng = $(".jqSt_sort th").length;
    var jsonObj = {};
    var sortModel;
    var sortType;
    jsonObj.PAGE_COUNT = '20';
    jsonObj.CAMPAIGN_ID = $("#getCampaign option:selected").val();

    for (var i=0; i<thLeng; i++) {
      if ($('.jqSt_sort th').eq(i).find('.ico_sort span:first-child').hasClass('active')) {
        sortModel = $('.jqSt_sort th').eq(i).text().replace(/(\s*)/g, "");
        sortType = 'asc';
      } else if ($('.jqSt_sort th').eq(i).find('.ico_sort span:last-child').hasClass('active')) {
        sortModel = $('.jqSt_sort th').eq(i).text().replace(/(\s*)/g, "");
        sortType = 'desc';
      }
    }

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
    jsonObj.COLUMN_MODEL = sortModel;
    jsonObj.SORT_TYPE = sortType;
    jsonObj.cp = cp;
    jsonObj.pageInitPerPage = 20;
    jsonObj.countPerPage = 10;

    httpSend(url, $("#headerName").val(), $("#token").val(),	JSON.stringify(jsonObj)
        ,function(result){
          result = JSON.parse(result);

          var list = JSON.parse(result.list);
          var paging = JSON.parse(result.paging);
          var cnt = paging.startRow + 1;

          console.log(paging.totalCount);

          var innerHTML = "";

          $.each(list, function(i, v){

            var obj = [];

            obj.push(v.custNm);
            obj.push(v.telNo);
            obj.push(v.callStatusNm);
            var custDataArr = v.custDataList;

            $.each(obj, function(j, jv){
              if(obj[j] == null || obj[j] == "undefined"){
                obj[j] = "";
              }
            });

            innerHTML += '<tr>';
            innerHTML += '<td scope="row">'+cnt+'</td>';
            innerHTML += '	<td>'+obj[0]+'</td>';
            innerHTML += '		<td>'+obj[1]+'</td>';
            for(var i=0; i<custDataArr.length; i++){
              innerHTML += '<td>'+custDataArr[i]+'</td>';
            }
            innerHTML += '</tr>';

            cnt++;

          });

          $("#dbListBody").empty();
          $("#dbListBody").append(innerHTML);

          //pager
          innerHTML = "";
          $("#dbListPager").empty();


          innerHTML += '<div class="jqSt_navi">';
          innerHTML += '<button type="button" title="First Page"><a class="ui-icon fas fa-angle-double-left" aria-hidden="true" href="javascript:goPage(1)" ></a></button>';
          innerHTML += '<button type="button" title="Previous Page"><a class="ui-icon fas fa-angle-left" aria-hidden="true" href="javascript:goPage(' + paging.prevPage
              + ')" ></a></button>';

          for (var i = paging.pageRangeStart; i <= paging.pageRangeEnd; i++) {
            if (i == cp) {
              innerHTML += "<em>" + i + "</em>";
            } else {
              innerHTML += '<a href="javascript:goPage(' + i + ')">' + i + '</a>';
            }
          }

          innerHTML += '<button type="button" title="Next Page"><a class="ui-icon fas fa-angle-right" aria-hidden="true" href="javascript:goPage(' + paging.nextPage
              + ')"></a></button>';
          innerHTML += '<button type="button" title="Last Page"><a class="ui-icon fas fa-angle-double-right" aria-hidden="true" href="javascript:goPage(' + paging.totalPage
              + ')"></a></button>';

          innerHTML += '</div>';
          innerHTML += '<div class="jqSt_info">';
          innerHTML += '<span>View ' + eval(paging.startRow + 1) + ' - ' + paging.lastRow + ' of ' + paging.totalCount + '</span>';
          innerHTML += '</div>';
          innerHTML += '</div>';

          $("#dbListPager").append(innerHTML);

        });

  }

  function onKeyDown() {
    if(event.keyCode == 13)
    {
      searchUser();
    }
  }

</script>
</body>
</html>
