<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-11-02
  Time: 오후 5:21
  To change this template use File | Settings | File Templates.
--%>
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
    <script type="text/javascript" src="/resources/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/resources/js/full_numbers_no_ellipses.js"></script>
    <script type="text/javascript" src="/resources/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="/resources/js/Chart2.9.3.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/resources/css/Chart.min.css">
    <script type="text/javascript" src="/resources/js/statistics/stats_chart_custom.js"></script>
    <script type="text/javascript" src="/resources/js/statistics/stats_main.js"></script>
    <script type="text/javascript" src="/resources/js/xlsx.full.min.js"></script>
    <script type="text/javascript" src="/resources/js/FileSaver.min.js"></script>
    <script type="text/javascript" src="/resources/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="/resources/js/buttons.print.min.js"></script>

</head>

<body>
<input type="hidden" id="headerName" value="${_csrf.headerName}"/>
<input type="hidden" id="token" value="${_csrf.token}"/>
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
<div id="wrap" class="statistics">
    <!-- #header -->
    <jsp:include page="../common/inc_header.jsp">
        <jsp:param name="titleCode" value="A0403"/>
        <jsp:param name="titleTxt" value="I/B 콜 통계"/>
    </jsp:include>
    <!-- //#header -->

    <%--  #container--%>
    <div id="container">
        <div class="tabBox scroll">
            <ul id="tabMenuList" class="lst_tab">
                <%--        AMR
                  1."통합 대시보드"는 항상 고정되어 있습니다.
                  2."통합 대시보드"는 탭을 닫는 버튼이 없습니다.
                --%>
                <li id="main_0">
                    <a title="통합 대시보드" class="active" onclick="statsTabSelect(0, 'main');">통합 대시보드</a>
                </li>
            </ul>
        </div>

        <div id="mainTab">
            <%--    검색영역--%>
            <div id="srchArea" class="srchArea">
                <table class="tbl_line_view" summary="캠페인, 채널, 기간, 운영구분으로 구성됨">
                    <caption class="hide">검색조건</caption>
                    <colgroup>
                        <col><col><col><col><col><col>
                    </colgroup>
                    <tbody>
                    <tr>
                        <th>캠페인</th>
                        <td colspan="3">
                            <div class="iptBox_btn">
                                <input id="searchCampId" type="hidden">
                                <input id="searchInbound" type="hidden">
                                <input id="searchOpStartTm" type="hidden">
                                <input id="searchOpEndTm" type="hidden">
                                <input id="searchCampNm" type="text" class="ipt_txt_btn" placeholder="캠페인 명을 입력 또는 검색해주세요."
                                       onKeypress="javascript:if(event.keyCode==13) {campaignSearch();}">
                                <button type="button" class="btnS_basic btn_search_w" onclick="campaignList(); openPopup('campaign_search');">검색</button>
                            </div>
                        </td>
                        <th>채널</th>
                        <td><span id="channel_name"></span></td>
                        </td>
                    </tr>
                    <tr>
                        <th>기간</th>
                        <td colspan="5" class="dateBox">
                            <div class="iptBox">
                                <input type="text" name="fromDate" id="fromMainDate" class="ipt_dateTime" autocomplete="off">
                                <span>-</span>
                                <input type="text" name="toDate" id="toMainDate"  class="ipt_dateTime" autocomplete="off">
                            </div>
                            <div id="selectPeriod" class="btnBox line">
                                <button type="button" class="btnS_lightgray">오늘</button>
                                <button type="button" class="btnS_lightgray">1주</button>
                                <button type="button" class="btnS_lightgray">1개월</button>
                                <button type="button" class="btnS_lightgray">3개월</button>
                                <button type="button" class="btnS_lightgray">1년</button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><spring:message code="A0206" text="검색유형"/></th>
                        <td colspan="5">
                            <div class="radioBox">
                                <input type="radio" name="searchOpTime" id="radio01" value="" checked>
                                <label for="radio01">전체</label>
                                <input type="radio" name="searchOpTime" id="radio02" value="Y">
                                <label for="radio02">운영중</label>
                                <input type="radio" name="searchOpTime" id="radio03" value="N">
                                <label for="radio03">운영외</label>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>

                <div class="btnBox sz_small line">
                    <button type="button" class="btnS_basic" id="mainSearch"><spring:message code="A0180" text="검색"/></button>
                    <%--<button type="button" class="btnS_basic" id="export"><spring:message code="A0182" text="다운로드"/></button>--%>
                </div>
            </div>
            <%--    //검색영역--%>
            <%--    content stat_main--%>
            <div id="statMain" class="content stat_main">
                <div class="stn allBoxType">
                    <div class="stn_cont">
                        <%--          stat_box--%>
                        <div class="stat_box">
                            <%--            campaign_info--%>
                            <div class="campaign_info">
                                <h3>{<span id="voiceBotTitle">캠페인 이름</span>} 음성봇 현황</h3>
                                <div class="info_txt">
                                    <span>음성봇 수 : </span><em id="voiceBotCount">50</em>
                                    <div class="help">?
                                        <div class="help_desc">음성봇 수는 오늘 일자 기준 운영되고 있는 회선 수 입니다.</div>
                                    </div>
                                </div>
                                <p class="stat_date" name="mainSearchDate">yyyy-mm-dd ~ yyyy-mm-dd</p>
                            </div>
                            <%--            //campaign_info--%>

                            <%--            dashboard--%>
                            <div class="dashboard">
                                <div class="col_half">
                                    <div>
                                        <h4>발송 결과</h4>
                                        <%-- AMR chart_box style background는 영역 표시 용도입니다. 확인하시면 지워주세요.--%>
                                        <div class="chart_box" id="sendResultDiv">
                                            <canvas id="sendResultCountChart" width="360" height="60"></canvas>
                                        </div>
                                        <div class="result">
                                            <span class="result_title">발송건</span>
                                            <span id="sendCnt" class="result_num">0</span>
                                        </div>
                                    </div>

                                    <div>
                                        <h4>통화 결과</h4>
                                        <div class="chart_box" id="dialResultDiv">
                                            <canvas id="dialResultCountChart" width="360" height="60"></canvas>
                                        </div>
                                        <div class="result">
                                            <span class="result_title">발송 성공건</span>
                                            <span id="sendSuccessCnt" class="result_num">0</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="col_half">
                                    <div>
                                        <h4>캠페인 결과</h4>
                                        <div class="chart_box" id="campResultDiv">
                                            <canvas id="campResultCountChart" width="360" height="60"></canvas>
                                        </div>
                                        <div class="result">
                                            <span class="result_title">대상자</span>
                                            <span id="targetCnt" class="result_num">0</span>
                                        </div>
                                    </div>

                                    <div>
                                        <h4>음성봇 정보</h4>
                                        <div class="table_wrap">
                                            <table class="tbl_bg_lst05">
                                                <colgroup>
                                                    <col style="width: 23%;">
                                                    <col style="width: 23%;">
                                                    <col style="width: 25%;">
                                                    <col style="width: 29%;">
                                                </colgroup>
                                                <thead>
                                                <tr>
                                                    <th>총 통화시간</th>
                                                    <th>평균 통화시간</th>
                                                    <th>가장 긴 통화시간</th>
                                                    <th>가장 짧은 통화시간</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr>
                                                    <td id="totalDialTime"></td>
                                                    <td id="averageDialTime"></td>
                                                    <td id="longestDialTime"></td>
                                                    <td id="shortestDialTime"></td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%--            //dashboard--%>
                        </div>
                        <%--          //stat_box--%>

                    </div>

                    <div class="stn_cont">
                        <div class="dashboard_detail">
                            <div class="stat_box">
                                <div class="detail_info">
                                    <h4>
                                        발송 결과 현황
                                        <div class="help">?
                                            <div class="help_desc" style="top: 20px; left: 0; width: 405px;">
                                                선택기간에 대한 음성봇 아웃바운 콜 발송 결과 입니다.<br><br>
                                                • 발송 성공 : 캠페인 대상자에게 실행된 음성봇 아웃바운드 콜 발송 성공 건수<br>
                                                <%--                                            • 발송 제외 : 캠페인 대상자중 특정 조건으로 음성봇 아웃바운드 콜 발송에서 제외된 건수<br>--%>
                                                <%--                                            - 특정 조건 예시 : 상담사 수동콜 완료, 65세이상, 블랙리스트 등<br>--%>
                                                • 발송 실패 : 캠페인 대상자에게 실행된 음성봇 아웃바운드 콜 중 발송 실패된 건수<br>
                                                - 발송 실패 예시 : 발송진행 중 콜 실행 중단 요청, 시스템 오류(교환기, 음성봇 등),
                                                네트워크 장애 등
                                            </div>
                                        </div>
                                        <p class="stat_date" name="mainSearchDate">yyyy-mm-dd~yyyy-mm-dd</p>
                                    </h4>
                                    <div class="btn_box">
                                        <button type="button" class="btn_download">엑셀로 다운로드</button>
                                    </div>
                                </div>
                                <div id="sendResultLineDiv" class="chart_box">
                                    <canvas id="sendResultLineChart"></canvas>
                                </div>
                                <div class="btn_box">
                                    <a href="#" onclick="statsTabOpen('send',true)">통계 상세 보기 &#8640;</a>
                                </div>
                            </div>

                            <div class="stat_box">
                                <div class="detail_info">
                                    <h4>
                                        통화 결과 현황
                                        <div class="help">?
                                            <div class="help_desc" style="top: 20px; left: 0; width: 300px;">
                                                선택기간에 대한 음성봇 아웃바운드 콜 통화 결과 입니다.<br><br>
                                                • 통화 성공 : 캠페인 대상자에게 통화 연결된 건수<br>
                                                • 통화 실패 : 캠페인 대상자에게 통화 연결되지 않은 건수<br>
                                                - 통화 실패 예시 : 부재, 수신거부, 착신거부, 결번 등<br>
                                                • 통화 성공률 : 캠페인 대상자에게 발송된 건 중 통화 연결이 된 건의 백분율<br>
                                                - 산식 : (통화 성공건 / 발송 성공건) * 100
                                            </div>
                                        </div>
                                        <p class="stat_date" name="mainSearchDate">yyyy-mm-dd~yyyy-mm-dd</p>
                                    </h4>
                                    <div class="btn_box">
                                        <button type="button" class="btn_download">엑셀로 다운로드</button>
                                    </div>
                                </div>
                                <div id="callResultLineDiv" class="chart_box">
                                    <canvas id="callResultLineChart"></canvas>
                                </div>
                                <div class="btn_box">
                                    <a href="#" onclick="statsTabOpen('dial', true)">통계 상세 보기 &#8640;</a>
                                </div>
                            </div>

                            <div class="stat_box">
                                <div class="detail_info">
                                    <h4>
                                        캠페인 결과 현황
                                        <div class="help">?
                                            <div class="help_desc" style="top: 20px; left: -40px; width: 300px;">
                                                선택기간에 대한 음성봇 캠페인 결과 입니다.<br><br>
                                                • 캠페인 성공 : 캠페인 대상자에게 통화한 결과 캠페인 목적을 달성한 성공 대상자 수<br>
                                                • 캠페인 실패 : 캠페인 대상자에게 통화한 결과 캠페인 목적을 달성하지 못한 실패 대상자 수<br>
                                                • 캠페인 성공률 : 캠페인 대상자 중 캠페인 목적을 달성한 대상자 비율(백분율)<br>
                                                - 산식 : (캠페인 성공 대상자수 / 캠페인 대상자수) * 100
                                            </div>
                                        </div>
                                        <p class="stat_date" name="mainSearchDate">yyyy-mm-dd~yyyy-mm-dd</p>
                                    </h4>
                                    <div class="btn_box">
                                        <button type="button" class="btn_download">엑셀로 다운로드</button>
                                    </div>
                                </div>
                                <div class="chart_box" id="campResultLineDiv">
                                    <canvas id="campResultLineChart"></canvas>
                                </div>
                                <div class="btn_box">
                                    <a href="#" onclick="statsTabOpen('camp', true)">통계 상세 보기 &#8640;</a>
                                </div>
                            </div>

                            <div class="stat_box status_by_task">
                                <div class="detail_info">
                                    <h4>
                                        Task별 고객 이탈 현황
                                        <div class="help">?
                                            <div class="help_desc" style="top: 20px; left: -75px; width: 300px;">
                                                선택기간에 대한 Task별 고객이탈 결과 입니다.<br><br>
                                                • Task : 음성봇 시나리오의 각 Task명<br>
                                                • 캠페인 성공 구분 : 캠페인 목적 달성 여부를 결정하는 Task인 경우, 'Y'로 표시<br>
                                                • (통화)이탈 건수 : 해당 Task에서 통화 종료한 대상자수<br>
                                                • (통화)이탈 이탈율(%) : 통화 연결된 대상자 중 캠페인에 성공한 대상자수<br>
                                                - 산식 : (통화 성공 대상자수 / 캠페인 성공 대상자수) * 100
                                            </div>
                                        </div>
                                        <p class="stat_date"  name="mainSearchDate">yyyy-mm-dd~yyyy-mm-dd</p>
                                    </h4>
                                    <div class="btn_box">
                                        <button type="button" class="btn_download" id="excel_download">엑셀로 다운로드</button>
                                    </div>
                                </div>
                                <div class="dataTable_paging_wrap" style="height: 490px;">
                                    <table id="taskAwayRate" class="tbl_bg_lst05 td_ellipsis display">
                                        <colgroup>
                                            <col style="width: 50%">
                                            <col style="width: 55px">
                                            <col style="width: 45px">
                                            <col style="width: 60px">
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th rowspan="2">Task</th>
                                            <th rowspan="2">캠페인<br>성공 구분</th>
                                            <th colspan="2">(통화)이탈</th>
                                        </tr>
                                        <tr>
                                            <td style="border-left: none;">건수</td>
                                            <td>이탈율(%)</td>
                                        </tr>
                                        </thead>
                                    </table>
                                </div>
                                <div class="btn_box">
                                    <a href="#" onclick="statsTabOpen('task', true);">비교 분석 보기 ⇀</a>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <%--    //content stat_main--%>
        </div>

        <div class="content stat_main">
            <div id="subStatsTab" style="display: none" class="stn allBoxType stat_sub">

            </div>
        </div>
    </div>
    <%--  //#container--%>

    <hr>

    <!-- #footer -->
    <div id="footer">
        <div class="cyrt"><span>&copy; MINDsLab. All rights reserved.</span></div>
    </div>
    <!-- //#footer -->
</div>
<!-- //#wrap -->

<%@ include file="../common/inc_footer.jsp"%>

<%--Main 캠페인 리스트 모달--%>
<div class="lyrBox" id="campaign_search">
    <div class="lyr_top">
        <h3>캠페인 리스트</h3>
        <button class="btn_lyr_close">닫기</button>
    </div>
    <div class="lyr_mid">
        <div class="dataTable_paging_wrap" style="height: 370px;">
            <table class="tbl_bg_lst05" id="campListTable">
                <colgroup>
                    <col style="width: 150px;">
                    <col style="width: 150px;">
                    <col style="width: 100px;">
                </colgroup>
                <thead>
                <tr>
                    <th>캠페인명</th>
                    <th>시작일자</th>
                    <th>상태</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button type="button" onclick="campSelect();">확인</button>
            <button type="button" class="btn_lyr_close" onclick="hidePopup('campaign_search');">취소</button>
        </div>
    </div>
</div>
<%--//Main 캠페인 리스트 모달--%>

<%--Sub 캠페인 리스트 모달--%>
<div class="lyrBox" id="campaign_sub_search" style="width: 700px;">
    <div class="lyr_top">
        <h3>캠페인 리스트</h3>
        <button class="btn_lyr_close">닫기</button>
    </div>
    <div class="lyr_mid" style="max-height: 650px;">
        <div class="dataTable_paging_wrap" style="height: 370px;">
            <table class="tbl_bg_lst05" id="subCampListTable">
                <colgroup>
                    <col style="width: 100px;">
                    <col style="width: 150px;">
                    <col style="width: 150px;">
                    <col style="width: 100px;">
                </colgroup>
                <thead>
                <tr>
                    <th>캠페인아이디</th>
                    <th>캠페인명</th>
                    <th>시작일자</th>
                    <th>상태</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button type="button" onclick="subCampSelect();">확인</button>
            <button type="button" class="btn_lyr_close" onclick="hidePopup('campaign_sub_search');">취소</button>
        </div>
    </div>
</div>
<%--//Sub 캠페인 리스트 모달--%>

</body>
</html>
