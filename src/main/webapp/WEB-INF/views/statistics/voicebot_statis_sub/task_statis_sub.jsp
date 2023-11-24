<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/resources/js/statistics/voicebot_statis_sub/task_statis_sub.js"></script>
<div class="stn allBoxType stat_sub">
    <div class="stn_cont">
        <div class="detail_info">
            <h4>
                Task별 고객 이탈 현황 통계
                <span class="stat_date" id="taskDetailPeriod"></span>
            </h4>
        </div>

        <div class="stat_box">
            <div class="detail_info">
                <h5>Task별 고객 이탈 현황 비교 분석</h5>
                <div class="btn_box">
                    <button type="button" class="btn_downloadsub" id="btn_download_table3">엑셀로 다운로드</button>
                </div>
            </div>

            <div class="srchArea">
                <label for="taskDiffFromDate_1" class ="title">비교 기간 1 선택 :</label>
                <div class="iptBox">
                    <input type="text" name="" id="taskDiffFromDate_1" class="ipt_dateTime" autocomplete="off">
                    <span>-</span>
                    <input type="text" name="" id="taskDiffToDate_1"  class="ipt_dateTime" autocomplete="off">
                </div>

                <label for="taskDiffFromDate_2" class ="title">비교 기간 2 선택 :</label>
                <div class="iptBox">
                    <input type="text" name="" id="taskDiffFromDate_2" class="ipt_dateTime" autocomplete="off">
                    <span>-</span>
                    <input type="text" name="" id="taskDiffToDate_2"  class="ipt_dateTime" autocomplete="off">
                </div>

                <label for="taskDiffFromDate_3" class ="title">비교 기간 3 선택 :</label>
                <div class="iptBox">
                    <input type="text" name="" id="taskDiffFromDate_3" class="ipt_dateTime" autocomplete="off">
                    <span>-</span>
                    <input type="text" name="" id="taskDiffToDate_3"  class="ipt_dateTime" autocomplete="off">
                </div>

                <button type="button" id="taskDiffAnalyze" class="btnS_basic" onclick="taskDiffAnalyze();">분석</button>
            </div>

            <div class="cont">
                <div id="comparison_each_task" class="table_wrap multiple_table">
                    <table id="taskDiffTable">
                        <colgroup>
                            <col style="width: 250px;">
                            <col style="width: 70px;">
                            <col style="width: 70px;">
                            <col style="width: 70px;">
                            <col style="width: 70px;">
                            <col style="width: 70px;">
                            <col style="width: 70px;">
                            <col style="width: 70px;">
                            <col style="width: 70px;">
                            <col style="width: 70px;">
                            <col style="width: 70px;">
                            <col style="width: 70px;">
                            <col style="width: 70px;">
                        </colgroup>
                        <thead>
                        <tr>
                            <th colspan="4" class="highlight">검색 기간</th>
                            <th colspan="3" class="highlight">비교 기간 1</th>
                            <th colspan="3" class="highlight">비교 기간 2</th>
                            <th colspan="3" class="highlight">비교 기간 3</th>
                        </tr>
                        <tr>
                            <th colspan="4"><span id="taskDiffPeriod">2021-12-01~2021-12-14</span></th>
                            <th colspan="3" id="taskDiffPeriod_1" class="info_txt"></th>
                            <th colspan="3" id="taskDiffPeriod_2" class="info_txt"></th>
                            <th colspan="3" id="taskDiffPeriod_3" class="info_txt"></th>
                        </tr>
                        <tr>
                            <th>Task</th>
                            <th>캠페인<br>성공 구분</th>
                            <th>이탈 (건)</th>
                            <th>이탈률 (%)</th>
                            <th>캠페인<br>성공 구분</th>
                            <th>이탈 (건)</th>
                            <th>이탈률 (%)</th>
                            <th>캠페인<br>성공 구분</th>
                            <th>이탈 (건)</th>
                            <th>이탈률 (%)</th>
                            <th>캠페인<br>성공 구분</th>
                            <th>이탈 (건)</th>
                            <th>이탈률 (%)</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>

    </div>
</div>