<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/resources/js/statistics/voicebot_statis_sub/dial_statis_sub.js"></script>
<div class="stn allBoxType stat_sub">
    <div class="stn_cont">
        <div class="detail_info">
            <h4>
                통화 결과 현황
                <span class="stat_date" id="dialDetailPeriod"></span>
            </h4>
        </div>

        <div class="stat_box">
            <div id="subchart1_title" class="detail_info">
                <h5>통화 현황 추이</h5>
                <div class="btn_box">
                    <button type="button" id="btn_download_subchart1" class="btn_downloadsub">엑셀로 다운로드</button>
                </div>
            </div>

            <div class="srchArea">
                <label for="dialDetailFromDate" class ="title">기간 선택 :</label>
                <div class="iptBox">
                    <input type="text" name="" id="dialDetailFromDate" class="ipt_dateTime" autocomplete="off">
                    <span>-</span>
                    <input type="text" name="" id="dialDetailToDate"  class="ipt_dateTime" autocomplete="off">
                </div>
                <label for="dialDateType" class="title">추이 기준 (x축) 선택 :</label>
                <select name="" id="dialDateType" class="select">
                    <option value="hourly">시</option>
                    <option value="daily">일</option>
                    <option value="dayOfWeek">요일</option>
                    <option value="weekly">주</option>
                    <option value="monthly">월</option>
                    <option value="yearly">년</option>
                </select>
                <label for="dialFormula" class="title">산식 선택 :</label>
                <select name="" id="dialFormula" class="select formular_option">
                    <option value="sum">합계</option>
                    <option value="dailyAvg">일평균</option>
                    <option value="weeklyAvg">주평균</option>
                    <option value="monthlyAvg">월평균</option>
                </select>

                <button type="button" id="analDial0" class="btnS_basic" onclick="dialDetailAnalyze();">분석</button>
            </div>

            <div class="cont">
                <div class="chart_box" id="dialSubStatsDiv">
                    <canvas id="dialSubStatsChart"></canvas>
                </div>
            </div>
        </div>

        <div class="stat_box">
            <div id="subtable1_title" class="detail_info">
                <h5>통화 결과 비교</h5>
                <div class="btn_box">
                    <button type="button" id="btn_download_table1" class="btn_downloadsub">엑셀로 다운로드</button>
                </div>
            </div>

            <div class="srchArea">
                <label for="dialDiffFromDate" class ="title">비교 기간 선택 :</label>
                <div class="iptBox">
                    <input type="text" name="" id="dialDiffFromDate" class="ipt_dateTime" autocomplete="off">
                    <span>-</span>
                    <input type="text" name="" id="dialDiffToDate"  class="ipt_dateTime" autocomplete="off">
                </div>

                <button type="button" id="analDialScale0" class="btnS_basic" onclick="dialDiffAnalyze();">분석</button>
            </div>

            <div class="cont">
                <div id="comparison_result_call" class="table_wrap multiple_table">
                    <table id="dialDiffTable">
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
                            <th colspan="6" id="find_term1">2021-10-01~2021-10-25</th>
                            <th colspan="6" id="compare_term1" class="info_txt">비교 기간을 선택해 주세요.</th>
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
                            <th>통화 성공</th>
                            <td>43,034</td>
                            <td>84.1%</td>
                            <td>2,690</td>
                            <td>84.1%</td>
                            <td>3,092</td>
                            <td>543</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <th>통화 실패</th>
                            <td>310</td>
                            <td>0.0%</td>
                            <td>19</td>
                            <td>0.0%</td>
                            <td>255</td>
                            <td>0</td>
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
                            <td>51,158</td>
                            <td>100.0%</td>
                            <td>3,197</td>
                            <td>100.0%</td>
                            <td>4,798</td>
                            <td>2,752</td>
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

        <div class="stat_box">
            <div id="subchart2_title" class="detail_info">
                <h5>통화 실패 사유</h5>
                <div class="btn_box">
                    <button type="button" id="btn_download_subchart2" class="btn_downloadsub">엑셀로 다운로드</button>
                </div>
            </div>

            <div class="srchArea">
                <label for="dialFailDetailFromDate" class ="title">기간 선택 :</label>
                <div class="iptBox">
                    <input type="text" name="" id="dialFailDetailFromDate" class="ipt_dateTime" autocomplete="off">
                    <span>-</span>
                    <input type="text" name="" id="dialFailDetailToDate"  class="ipt_dateTime" autocomplete="off">
                </div>
                <label for="dialFailDateType" class="title">추이 기준 (x축) 선택 :</label>
                <select name="" id="dialFailDateType" class="select">
                    <option value="hourly" selected>시</option>
                    <option value="daily">일</option>
                    <option value="dayOfWeek">요일</option>
                    <option value="weekly">주</option>
                    <option value="monthly">월</option>
                    <option value="yearly">년</option>
                </select>
                <label for="dialFailFormula" class="title">산식 선택 :</label>
                <select name="" id="dialFailFormula" class="select" disabled>
                    <option value="sum" selected>합계</option>
                    <option value="dailyAvg">일평균</option>
                    <option value="weeklyAvg">주평균</option>
                    <option value="monthlyAvg">월평균</option>
                </select>

                <button type="button" id="analDialFail0" class="btnS_basic" onclick="dialFailDetailAnalyze();">분석</button>
            </div>

            <div class="cont">
                <div class="chart_box" id="dialFailSubStatsDiv">
                    <canvas id="dialFailSubStatsChart"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>