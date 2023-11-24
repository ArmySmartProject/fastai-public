<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/resources/js/statistics/voicebot_statis_sub/send_statis_sub.js"></script>
<div class="stn_cont">
    <div class="detail_info">
        <h4>
            발송 결과 현황
            <p class="stat_date" id="sendDetailPeriod"></p>
        </h4>
    </div>

    <div class="stat_box">

        <div class="detail_info" id="subchart0_title">
            <h5>발송현황 추이</h5>
            <div class="btn_box">
                <button type="button" id="btn_download_subchart0" class="btn_download">엑셀로 다운로드</button>
            </div>
        </div>

        <div class="srchArea">
            <label for="sendDetailFromDate" class ="title">기간 선택 :</label>
            <div class="iptBox">
                <input type="text" name="fromDate" id="sendDetailFromDate" class="ipt_dateTime" autocomplete="off">
                <span>-</span>
                <input type="text" name="toDate" id="sendDetailToDate"  class="ipt_dateTime" autocomplete="off">
            </div>
            <label for="sendDateType" class="title">추이 기준 (x축) 선택 :</label>
            <select id="sendDateType" class="select">
                <option value="hourly">시</option>
                <option value="daily">일</option>
                <option value="dayOfWeek">요일</option>
                <option value="weekly">주</option>
                <option value="monthly">월</option>
                <option value="yearly">년</option>
            </select>
            <label for="sendFormula" class="title">산식 옵션 :</label>
            <select name="" id="sendFormula" class="select">
                <option value="sum">합계</option>
                <option value="dailyAvg">일평균</option>
                <option value="weeklyAvg">주평균</option>
                <option value="monthlyAvg">월평균</option>
            </select>

            <button type="button" class="btnS_basic" onclick="subStatisDetailAnalyze();">분석</button>
        </div>

        <div class="cont">
            <div id="sendSubStatsDiv" class="chart_box">
                <canvas id="sendSubStatsChart"></canvas>
            </div>
        </div>
    </div>

    <div class="stat_box">
        <div class="detail_info">
            <h5>발송 규모 비교</h5>
            <div class="btn_box">
                <button type="button" class="btn_download" id="btn_download_table0">엑셀로 다운로드</button>
            </div>
        </div>

        <div class="srchArea">
            <label for="sendDiffFromDate" class ="title">비교 기간 선택 :</label>
            <div class="iptBox">
                <input type="text" name="" id="sendDiffFromDate" class="ipt_dateTime" autocomplete="off">
                <span>-</span>
                <input type="text" name="" id="sendDiffToDate"  class="ipt_dateTime" autocomplete="off">
            </div>

            <button type="button" class="btnS_basic" onclick="subStatisDiffAnalyze();">분석</button>
        </div>

        <div class="cont">
            <div id="comparison_result_sending" class="table_wrap multiple_table">
                <table id="sendDiffTable">
                    <colgroup>
                        <col style="width: 135px;">
                        <col style="width: 80px;">
                        <col style="width: 80px;">
                        <col style="width: 80px;">
                        <col style="width: 80px;">
                        <col style="width: 80px;">
                        <col style="width: 80px;">
                        <col style="width: 80px;">
                        <col style="width: 80px;">
                        <col style="width: 80px;">
                        <col style="width: 80px;">
                        <col style="width: 80px;">
                        <col style="width: 80px;">
                    </colgroup>
                    <thead>
                    <tr>
                        <th rowspan="3">구분</th>
                        <th colspan="6" class="highlight">검색 기간</th>
                        <th colspan="6" class="highlight">비교 기간</th>
                    </tr>
                    <tr>
                        <th colspan="6" id="sendDiffPeriod">2021-10-01~2021-10-25</th>
                        <th colspan="6" id="compare_term0" class="info_txt">비교 기간을 선택해 주세요.</th>
                    </tr>
                    <tr>
                        <th>총건수</th>
                        <th>% Total</th>
                        <th>일평균(건)</th>
                        <th>일평균(%)</th>
                        <th>일 Max(건)</th>
                        <th>일 Min(건)</th>
                        <th>총건수</th>
                        <th>% Total</th>
                        <th>일평균(건)</th>
                        <th>일평균(%)</th>
                        <th>일 Max(건)</th>
                        <th>일 Min(건)</th>
                    </tr>
                    </thead>
                    <tbody class="alignR">
                    <tr>
                        <th>발송 성공</th>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>

                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <th>발송 실패</th>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>

                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    </tbody>
                    <tfoot class="alignR">
                    <tr>
                        <th>Total</th>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>

                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>

</div>