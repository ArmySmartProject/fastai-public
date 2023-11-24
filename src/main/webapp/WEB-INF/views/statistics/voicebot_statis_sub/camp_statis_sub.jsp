<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/resources/js/statistics/voicebot_statis_sub/camp_statis_sub.js"></script>
<div class="stn_cont">
    <div class="detail_info">
        <h4>
            캠페인 결과 현황 통계
            <span class="stat_date" id="campDetailPeriod"></span>
        </h4>
    </div>

    <div class="stat_box">
        <div id="subchart3_title" class="detail_info">
            <h5>캠페인 결과 추이</h5>
            <div class="btn_box">
                <button type="button" id="btn_download_subchart3" class="btn_downloadsub">엑셀로 다운로드</button>
            </div>
        </div>

        <div class="srchArea">
            <label for="campDetailFromDate" class ="title">기간 선택 :</label>
            <div class="iptBox">
                <input type="text" name="fromDate" id="campDetailFromDate" class="ipt_dateTime" autocomplete="off">
                <span>-</span>
                <input type="text" name="toDate" id="campDetailToDate"  class="ipt_dateTime" autocomplete="off">
            </div>
            <label for="campDateType" class="title">추이 기준 (x축) 선택 :</label>
            <select name="" id="campDateType" class="select">
                <option value="hourly">시</option>
                <option value="daily">일</option>
                <option value="dayOfWeek">요일</option>
                <option value="weekly">주</option>
                <option value="monthly">월</option>
                <option value="yearly">년</option>
            </select>
            <label for="campFormula" class="title">산식 선택 :</label>
            <select name="campaign_option" id="campFormula" class="select">
                <option value="sum">합계</option>
                <option value="dailyAvg">일평균</option>
                <option value="weeklyAvg">주평균</option>
                <option value="monthlyAvg">월평균</option>
            </select>

            <button type="button" id="analCampaign0" class="btnS_basic" onclick="campDetailAnalyze();">분석</button>
        </div>

        <div class="cont">
            <div class="chart_box" id="campSubStatsDiv">
                <canvas id="campSubStatsChart"></canvas>
            </div>
        </div>
    </div>

    <div class="stat_box">
        <div class="detail_info">
            <h5>캠페인 결과 비교
                <div class="help">?
                    <div class="help_desc" style="width: 260px;">
                        캠페인은 최대 5개까지 선택할 수 있습니다.<br><br>
                        돋보기 버튼을 눌러 캠페인을 선택하거나<br>
                        입력 창에 && 기호로 캠페인을 연결하여 입력하면<br>
                        다중 검색이 가능합니다.
                    </div>
                </div>
            </h5>
            <div class="btn_box">
                <button type="button" class="btn_downloadsub" id="btn_download_table2">엑셀로 다운로드</button>
            </div>
        </div>

        <div class="srchArea">
            <label for="subCampSearch">캠페인 선택 :</label>
            <div class="iptBox_btn" style="display: inline-block; width: 500px;">
                <%--              캠페인 선택 팝업은 메인 팝업과 동일하게 사용해주시면 됩니다. 선택이 들어가야 함 여기 확인 --%>
                <input type="text" id="subCampSearch" class="ipt_txt_btn" placeholder="비교할 캠페인을 입력 또는 선택해주세요. (최대 5개 선택 가능)"
                       onkeypress="javascript:if(event.keyCode==13) {campSubSearch(false);}"
                ><button type="button" class="btnS_basic btn_search_w" id="btn_pre_search1" style="margin-left: 0; padding: 1px 6px; border-radius: 0 3px 3px 0;"
                        onclick="campSubSearch(true);">검색
            </button>
            </div>

            <label for="campDiffFromDate" class ="title">비교 기간 선택 :</label>
            <div class="iptBox">
                <input type="text" name="fromDateCampaign1" id="campDiffFromDate" class="ipt_dateTime" autocomplete="off">
                <span>-</span>
                <input type="text" name="toDateCampaign1" id="campDiffToDate"  class="ipt_dateTime" autocomplete="off">
            </div>

            <button type="button" id="analCampaignScale0" class="btnS_basic" onclick="campSubSearch(false);">분석</button>
        </div>

        <div class="cont">
            <div id="comparison_result_campaign" class="table_wrap multiple_table">
                <table id="campDiffTable">
                    <colgroup>
                        <col style="width: 180px;">
                        <col style="width: 60px;">
                        <col style="width: 60px;">
                        <col style="width: 60px;">
                        <col style="width: 60px;">

                        <col style="width: 60px;">
                        <col style="width: 55px;">
                        <col style="width: 55px;">
                        <col style="width: 55px;">
                        <col style="width: 60px;">
                        <col style="width: 60px;">
                        <col style="width: 60px;">
                        <col style="width: 60px;">
                        <col style="width: 55px;">
                        <col style="width: 55px;">
                        <col style="width: 55px;">
                        <col style="width: 55px;">
                    </colgroup>
                    <thead>
                    <tr>
                        <th rowspan="3">캠페인</th>
                        <th colspan="8" class="highlight">검색 기간: <span id="campDiffLeftPeriod">2021-11-01~2021-11-25</span></th>
                        <th colspan="8" class="highlight">비교 기간: <span id="campDiffPeriod"></span></th>
                    </tr>
                    <tr>
                        <th rowspan="2">대상자<br>(명)</th>
                        <th rowspan="2">발송 성공<br>(건)</th>
                        <th rowspan="2">발송 횟수<br>(건)</th>
                        <th rowspan="2">통화 성공<br>(건)</th>
                        <th rowspan="2">캠페인<br>성공(건)</th>
                        <th colspan="3">캠페인 성공률</th>
                        <th rowspan="2">대상자<br>(명)</th>
                        <th rowspan="2">발송 성공<br>(건)</th>
                        <th rowspan="2">발송 횟수<br>(건)</th>
                        <th rowspan="2">통화 성공<br>(건)</th>
                        <th rowspan="2">캠페인<br>성공(건)</th>
                        <th colspan="3">캠페인 성공률</th>
                    </tr>
                    <tr>
                        <th>% 대상자</th>
                        <th>% 발송성공</th>
                        <th>% 통화성공</th>
                        <th>% 대상자</th>
                        <th>% 발송성공</th>
                        <th>% 통화성공</th>
                    </tr>
                    </thead>
                    <tbody class="alignR">
                    <tr>
                        <td class="select-checkbox select-checkbox sorting_1"></td>
                        <td>2</td>
                        <td>3</td>
                        <td>4</td>
                        <td>5</td>
                        <td>6</td>
                        <td>7</td>
                        <td>8</td>
                        <td>9</td>

                        <td>10</td>
                        <td>11</td>
                        <td>12</td>
                        <td>13</td>
                        <td>14</td>
                        <td>15</td>
                        <td>16</td>
                        <td>17</td>

                    </tr>
                    </tbody>
                </table>
            </div>

            <p class="small_highlight_txt">* 캠페인은 최대 5개 추가가 가능합니다. 캠페인 추가 시, 아래 행이 추가됩니다.</p>
        </div>
    </div>

</div>
