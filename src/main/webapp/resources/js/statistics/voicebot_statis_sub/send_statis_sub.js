
$(document).ready(function () {
    $('#sendDetailFromDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#sendDetailFromDate').blur();
        $('#sendDetailToDate').datepicker( 'setStartDate', $(this).datepicker('getDate'));
        subStatsDateSetting('send');
    });

    $('#sendDetailToDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#sendDetailToDate').blur();
        $('#sendDetailFromDate').datepicker( 'setEndDate', $(this).datepicker('getDate'));
        subStatsDateSetting('send');
    });

    $('#sendDiffFromDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#sendDiffFromDate').blur();
        $('#sendDiffToDate').datepicker( 'setStartDate', $(this).datepicker('getDate'));
    });

    $('#sendDiffToDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#sendDiffToDate').blur();
        $('#sendDiffFromDate').datepicker( 'setEndDate', $(this).datepicker('getDate'));
    });

    $('#sendDateType').on('change', function (){
        formulaSetting('send');
    });

    $('#sendDetailPeriod').text(subSearchParam.startDt+'~'+subSearchParam.endDt);
    $('#sendDiffPeriod').text(subSearchParam.startDt+'~'+subSearchParam.endDt);

    if(subSearchParam.sendStartDt == undefined && subSearchParam.sendEndDt == undefined){
        $('#sendDetailFromDate').datepicker('update', subSearchParam.startDt);
        $('#sendDetailToDate').datepicker('update', subSearchParam.endDt);
        $('#sendDetailFromDate').datepicker( 'setEndDate', new Date(subSearchParam.endDt));
        $('#sendDetailToDate').datepicker( 'setStartDate', new Date(subSearchParam.startDt));
        subStatsDateSetting('send');
    } else {
        $('#sendDetailFromDate').datepicker('update', subSearchParam.sendStartDt);
        $('#sendDetailToDate').datepicker('update', subSearchParam.sendEndDt);
        $('#sendDetailFromDate').datepicker( 'setEndDate', new Date(subSearchParam.sendEndDt));
        $('#sendDetailToDate').datepicker( 'setStartDate', new Date(subSearchParam.sendStartDt));
        let tmpObj = {
            startDt : subSearchParam.sendStartDt,
            endDt : subSearchParam.sendEndDt,
            isDateType : subSearchParam.isDateType,
            isFormula : subSearchParam.isFormula
        }
        subStatsDateSetting('send',tmpObj);
    }

    /* 발송 현황 추이 */
    subStatisDetailAnalyze();

    /* 발송 규모 검색기간 */
    let searchObj = {
        campaignId : subSearchParam.campaignId,
        isInbound : subSearchParam.isInbound,
        isRunning : subSearchParam.isRunning,
        opStartTm : subSearchParam.opStartTm,
        opEndTm : subSearchParam.opEndTm,
        startDt : subSearchParam.startDt,
        endDt : subSearchParam.endDt
    };
    getSendResultInfoDiffLeft(searchObj);

    /* 발송 규모 비교기간 */
    if(subSearchParam.diffStartDt != undefined && subSearchParam.diffEndDt != undefined){
        $('#sendDiffFromDate').datepicker('update', subSearchParam.diffStartDt);
        $('#sendDiffToDate').datepicker('update', subSearchParam.diffEndDt);
        $('#sendDiffFromDate').datepicker( 'setEndDate', new Date(subSearchParam.diffEndDt));
        $('#sendDiffToDate').datepicker( 'setStartDate', new Date(subSearchParam.diffStartDt));
        subStatisDiffAnalyze();
    }

    // sub 발송현황 추이 차트 to 엑셀
    $("#btn_download_subchart0").click(function () {
        var tableId = "table_10";
        var isRunning = subSearchParam.isRunning;
        var strTitle = $("#subchart0_title h5").text();
        var strArith = "산식: " + subSearchParam.isFormula;
        var strTerm = "기간: " + subSearchParam.sendStartDt + "~" + subSearchParam.sendEndDt;
        var strIsrun = "운영상태: " + getRunningState(isRunning);
        generate_table(subchartObj0, tableId, strTitle, strTerm, strIsrun, strArith)
        exportTableToExcel(tableId, getSubExportFileName(strTitle))
    });

    // sub 발송 규모 비교 테이블 to 엑셀
    $("#btn_download_table0").click(function () {
        var tableId = "comparison_result_sending";
        var isRunning = subSearchParam.isRunning;
        var strTitle = $(this).parent().prev().text();
        var strCompareTerm = $("#compare_term0").text();
        var strTerm = subSearchParam.startDt + "~" + subSearchParam.endDt;
        var strIsrun = getRunningState(isRunning);
        addPrefix(16, tableId, strTitle, strTerm, strCompareTerm, strIsrun);
        exportExcel(tableId, getSubExportFileName(strTitle));
        removePrefix(tableId);
    });

});

function subStatisDetailAnalyze(){
    let fromDate = $('#sendDetailFromDate').val();
    let toDate = $('#sendDetailToDate').val()
    if(fromDate != '' && toDate != ''){

        let searchObj = {
            campaignId : subSearchParam.campaignId,
            isInbound : subSearchParam.isInbound,
            isRunning : subSearchParam.isRunning,
            opStartTm : subSearchParam.opStartTm,
            opEndTm : subSearchParam.opEndTm,
            startDt : fromDate,
            endDt : toDate,
            isDateType : $('#sendDateType').val(),
            isFormula : $('#sendFormula').val()
        };

        let list = getDateDiffType(fromDate, toDate, true);
        searchObj.startDt = list[0];

        $.ajax({
            url : "getSendResultInfoDetailChart",
            data : JSON.stringify(searchObj),
            type: "POST",
            contentType: 'application/json',
            beforeSend: function (xhr) {
                xhr.setRequestHeader($('#headerName').val(), $('#token').val());
            },
        }).success(function (result) {
            subSearchParam.sendStartDt = fromDate;
            subSearchParam.sendEndDt = toDate;
            subSearchParam.isDateType = $('#sendDateType').val();
            subSearchParam.isFormula = $('#sendFormula').val();
            tabList[subSearchParam.tabListIdx] = subSearchParam;
            sessionStorage.tabList = JSON.stringify(tabList);

            subchartObj0 = result;

            $('#sendSubStatsChart').remove();
            $("#sendSubStatsDiv").append('<canvas id="sendSubStatsChart"></canvas>');
            draw_chart('sendSubStatsChart', get_line_chart_data(result, 'sub'));
        }).error(function (result) {
            console.log(result);
        });

    } else{
        alert('검색 기간을 선택해 주세요.');
    }
}

function getSendResultInfoDiffLeft(searchParam){
    $.ajax({
        url : "getSendResultInfoDiff",
        data : JSON.stringify(searchParam),
        type: "POST",
        contentType: 'application/json',
        beforeSend: function (xhr) {
            xhr.setRequestHeader($('#headerName').val(), $('#token').val());
        },
    }).success(function (result) {
        sendDiffList = result;

        $('#sendDiffTable td:eq(0)').text(sendDiffList.sendSuccessSum);
        $('#sendDiffTable td:eq(1)').text(sendDiffList.sendSuccessPercent);
        $('#sendDiffTable td:eq(2)').text(sendDiffList.sendSuccessAvg);
        $('#sendDiffTable td:eq(3)').text(sendDiffList.sendSuccessAvgPercent);
        $('#sendDiffTable td:eq(4)').text(sendDiffList.sendSuccessMax);
        $('#sendDiffTable td:eq(5)').text(sendDiffList.sendSuccessMin);

        $('#sendDiffTable td:eq(12)').text(sendDiffList.sendFailSum);
        $('#sendDiffTable td:eq(13)').text(sendDiffList.sendFailPercent);
        $('#sendDiffTable td:eq(14)').text(sendDiffList.sendFailAvg);
        $('#sendDiffTable td:eq(15)').text(sendDiffList.sendFailAvgPercent);
        $('#sendDiffTable td:eq(16)').text(sendDiffList.sendFailMax);
        $('#sendDiffTable td:eq(17)').text(sendDiffList.sendFailMin);

        $('#sendDiffTable td:eq(24)').text(sendDiffList.sendTotalCount);
        $('#sendDiffTable td:eq(25)').text(sendDiffList.sendTotalPercent);
        $('#sendDiffTable td:eq(26)').text(sendDiffList.sendTotalAvg);
        $('#sendDiffTable td:eq(27)').text(sendDiffList.sendTotalAvgPercent);
        $('#sendDiffTable td:eq(28)').text(sendDiffList.sendCountMax);
        $('#sendDiffTable td:eq(29)').text(sendDiffList.sendCountMin);

    }).error(function (result) {
        console.log(result);
    });
}

function getSendResultInfoDiff(searchParam){
    $.ajax({
        url : "getSendResultInfoDiff",
        data : JSON.stringify(searchParam),
        type: "POST",
        contentType: 'application/json',
        beforeSend: function (xhr) {
            xhr.setRequestHeader($('#headerName').val(), $('#token').val());
        },
    }).success(function (result) {
        sendDiffCampareList = result;
        subSearchParam.diffStartDt = $('#sendDiffFromDate').val();
        subSearchParam.diffEndDt = $('#sendDiffToDate').val();
        tabList[subSearchParam.tabListIdx] = subSearchParam;
        sessionStorage.tabList = JSON.stringify(tabList);

        $('#compare_term0').text($('#sendDiffFromDate').val()+'~'+$('#sendDiffToDate').val());
        $('#sendDiffTable td:eq(6)').text(sendDiffCampareList.sendSuccessSum);
        $('#sendDiffTable td:eq(7)').text(sendDiffCampareList.sendSuccessPercent);
        $('#sendDiffTable td:eq(8)').text(sendDiffCampareList.sendSuccessAvg);
        $('#sendDiffTable td:eq(9)').text(sendDiffCampareList.sendSuccessAvgPercent);
        $('#sendDiffTable td:eq(10)').text(sendDiffCampareList.sendSuccessMax);
        $('#sendDiffTable td:eq(11)').text(sendDiffCampareList.sendSuccessMin);

        $('#sendDiffTable td:eq(18)').text(sendDiffCampareList.sendFailSum);
        $('#sendDiffTable td:eq(19)').text(sendDiffCampareList.sendFailPercent);
        $('#sendDiffTable td:eq(20)').text(sendDiffCampareList.sendFailAvg);
        $('#sendDiffTable td:eq(21)').text(sendDiffCampareList.sendFailAvgPercent);
        $('#sendDiffTable td:eq(22)').text(sendDiffCampareList.sendFailMax);
        $('#sendDiffTable td:eq(23)').text(sendDiffCampareList.sendFailMin);

        $('#sendDiffTable td:eq(30)').text(sendDiffCampareList.sendTotalCount);
        $('#sendDiffTable td:eq(31)').text(sendDiffCampareList.sendTotalPercent);
        $('#sendDiffTable td:eq(32)').text(sendDiffCampareList.sendTotalAvg);
        $('#sendDiffTable td:eq(33)').text(sendDiffCampareList.sendTotalAvgPercent);
        $('#sendDiffTable td:eq(34)').text(sendDiffCampareList.sendCountMax);
        $('#sendDiffTable td:eq(35)').text(sendDiffCampareList.sendCountMin);
    }).error(function (result) {
        console.log(result);
    });
}

function subStatisDiffAnalyze(){
    let obj = {
        campaignId : subSearchParam.campaignId,
        isInbound : subSearchParam.isInbound,
        isRunning : subSearchParam.isRunning,
        opStartTm : subSearchParam.opStartTm,
        opEndTm : subSearchParam.opEndTm,
        startDt : $('#sendDiffFromDate').val(),
        endDt : $('#sendDiffToDate').val()
    };

    if(obj.startDt && obj.endDt){
        getSendResultInfoDiff(obj);
    }else{
        alert('비교기간을 선택해주세요.');
    }
}