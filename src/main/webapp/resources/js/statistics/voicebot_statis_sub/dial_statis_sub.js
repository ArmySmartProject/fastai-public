$(document).ready(function () {
    $('#dialDetailFromDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#dialDetailFromDate').blur();
        $('#dialDetailToDate').datepicker( 'setStartDate', $(this).datepicker('getDate'));
        subStatsDateSetting('dial');
    });

    $('#dialDetailToDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#dialDetailToDate').blur();
        $('#dialDetailFromDate').datepicker( 'setEndDate', $(this).datepicker('getDate'));
        subStatsDateSetting('dial');
    });

    $('#dialDiffFromDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#dialDiffFromDate').blur();
        $('#dialDiffToDate').datepicker( 'setStartDate', $(this).datepicker('getDate'));
    });

    $('#dialDiffToDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#dialDiffToDate').blur();
        $('#dialDiffFromDate').datepicker( 'setEndDate', $(this).datepicker('getDate'));
    });

    $('#dialFailDetailFromDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#dialFailDetailFromDate').blur();
        $('#dialFailDetailToDate').datepicker( 'setStartDate', $(this).datepicker('getDate'));
        subStatsDateSetting('dialFail');
    });

    $('#dialFailDetailToDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#dialFailDetailToDate').blur();
        $('#dialFailDetailFromDate').datepicker( 'setEndDate', $(this).datepicker('getDate'));
        subStatsDateSetting('dialFail');
    });

    $('#dialDateType').on('change', function (){
        formulaSetting('dial');
    });

    $('#dialFailDateType').on('change', function (){
        formulaSetting('dialFail');
    });

    $('#dialDetailPeriod').text(subSearchParam.startDt+'~'+subSearchParam.endDt);

    if(subSearchParam.dialStartDt == undefined && subSearchParam.dialEndDt == undefined){
        $('#dialDetailFromDate').datepicker('update', subSearchParam.startDt);
        $('#dialDetailToDate').datepicker('update', subSearchParam.endDt);
        $('#dialDetailFromDate').datepicker( 'setEndDate', new Date(subSearchParam.endDt));
        $('#dialDetailToDate').datepicker( 'setStartDate', new Date(subSearchParam.startDt));
        subStatsDateSetting('dial');
    } else {
        $('#dialDetailFromDate').datepicker('update', subSearchParam.dialStartDt);
        $('#dialDetailToDate').datepicker('update', subSearchParam.dialEndDt);
        $('#dialDetailFromDate').datepicker( 'setEndDate', new Date(subSearchParam.dialEndDt));
        $('#dialDetailToDate').datepicker( 'setStartDate', new Date(subSearchParam.dialStartDt));
        let tmpObj = {
            startDt : subSearchParam.dialStartDt,
            endDt : subSearchParam.dialEndDt,
            isDateType : subSearchParam.dialDateType,
            isFormula : subSearchParam.dialFormula
        }
        subStatsDateSetting('dial',tmpObj);
    }

    if(subSearchParam.diffStartDt != undefined && subSearchParam.diffEndDt != undefined){
        $('#dialDiffFromDate').datepicker('update', subSearchParam.diffStartDt);
        $('#dialDiffToDate').datepicker('update', subSearchParam.diffEndDt);
        $('#dialDiffFromDate').datepicker( 'setEndDate', new Date(subSearchParam.diffEndDt));
        $('#dialDiffToDate').datepicker( 'setStartDate', new Date(subSearchParam.diffStartDt));
        dialDiffAnalyze();
    }

    if(subSearchParam.dialFailStartDt == undefined && subSearchParam.dialFailEndDt == undefined){
        $('#dialFailDetailFromDate').datepicker('update', subSearchParam.startDt);
        $('#dialFailDetailToDate').datepicker('update', subSearchParam.endDt);
        $('#dialFailDetailFromDate').datepicker( 'setEndDate', new Date(subSearchParam.endDt));
        $('#dialFailDetailToDate').datepicker( 'setStartDate', new Date(subSearchParam.startDt));
        subStatsDateSetting('dialFail');
    } else {
        $('#dialFailDetailFromDate').datepicker('update', subSearchParam.dialFailStartDt);
        $('#dialFailDetailToDate').datepicker('update', subSearchParam.dialFailEndDt);
        $('#dialFailDetailFromDate').datepicker( 'setEndDate', new Date(subSearchParam.dialFailEndDt));
        $('#dialFailDetailToDate').datepicker( 'setStartDate', new Date(subSearchParam.dialFailStartDt));
        tmpObj = {
            startDt : subSearchParam.dialFailStartDt,
            endDt : subSearchParam.dialFailEndDt,
            isDateType : subSearchParam.dialFailDateType,
            isFormula : subSearchParam.dialFailFormula
        }
        subStatsDateSetting('dialFail',tmpObj);
    }

    if(subSearchParam.dialDateType != undefined && subSearchParam.dialFormula != undefined){
        $('#dialDateType option[value='+subSearchParam.dialDateType+']').prop('selected', true);
        formulaSetting('dial');
        $('#dialFormula option[value='+subSearchParam.dialFormula+']').prop('selected', true);
    }

    if(subSearchParam.dialFailDateType != undefined && subSearchParam.dialFailFormula != undefined){
        $('#dialFailDateType option[value='+subSearchParam.dialFailDateType+']').prop('selected', true);
        formulaSetting('dialFail');
        $('#dialFailFormula option[value='+subSearchParam.dialFailFormula+']').prop('selected', true);
    }


    dialDetailAnalyze();
    dialFailDetailAnalyze();
    dialLeftDiffAnalyze();

    // sub 통화 현황 추이 차트 to 엑셀
    $("#btn_download_subchart1").click(function () {
        var tableId = "table_11";
        var isRunning = subSearchParam.isRunning;
        var strTitle = $("#subchart1_title h5").text();
        var strArith = "산식: " + subSearchParam.dialFormula;
        var strTerm = "기간: " + subSearchParam.dialStartDt + "~" + subSearchParam.dialEndDt;
        var strIsrun = "운영상태: " + getRunningState(isRunning);

        generate_table(subchartObj1, tableId, strTitle, strTerm, strIsrun, strArith)
        exportTableToExcel(tableId, getSubExportFileName(strTitle))
    });

    // sub 통화실패 현황 추이 차트 to 엑셀
    $("#btn_download_subchart2").click(function () {
        var tableId = "table_12";
        var isRunning = subSearchParam.isRunning;
        var strTitle = $("#subchart2_title h5").text();
        var strArith = "산식: " + subSearchParam.dialFailFormula;
        var strTerm = "기간: " + subSearchParam.dialFailStartDt + "~" + subSearchParam.dialFailEndDt;
        var strIsrun = "운영상태: " + getRunningState(isRunning);
        generate_table(subchartObj2, tableId, strTitle, strTerm, strIsrun, strArith)
        exportTableToExcel(tableId, getSubExportFileName(strTitle))
    });

    // sub 통화 규모 비교 테이블 to 엑셀
    $("#btn_download_table1").click(function () {
        var tableId = "comparison_result_call";
        var isRunning = subSearchParam.isRunning;
        var strTitle = $(this).parent().prev().text();
        var strCompareTerm = $("#compare_term1").text();
        var strTerm = subSearchParam.startDt + "~" + subSearchParam.endDt;
        var strIsrun = getRunningState(isRunning);
        addPrefix(16, tableId, strTitle, strTerm, strCompareTerm, strIsrun);
        exportExcel(tableId, getSubExportFileName(strTitle));
        removePrefix(tableId);
    });

});

function dialDetailAnalyze(){
    if($('#dialDetailFromDate').val() != '' && $('#dialDetailToDate').val() != ''){
        let dialObj = {
            campaignId : subSearchParam.campaignId,
            isInbound : subSearchParam.isInbound,
            isRunning : subSearchParam.isRunning,
            opStartTm : subSearchParam.opStartTm,
            opEndTm : subSearchParam.opEndTm,
            startDt : $('#dialDetailFromDate').val(),
            endDt : $('#dialDetailToDate').val(),
            isDateType : $('#dialDateType').val(),
            isFormula : $('#dialFormula').val()
        };

        let list = getDateDiffType(dialObj.startDt, dialObj.endDt, true);
        dialObj.startDt = list[0];

        $.ajax({
            url : "getCallResultInfoDetailChart",
            data : JSON.stringify(dialObj),
            type: "POST",
            contentType: 'application/json',
            beforeSend: function (xhr) {
                xhr.setRequestHeader($('#headerName').val(), $('#token').val());
            },
        }).success(function (result) {
            subSearchParam.dialStartDt = $('#dialDetailFromDate').val();
            subSearchParam.dialEndDt = $('#dialDetailToDate').val();
            subSearchParam.dialDateType = $('#dialDateType').val();
            subSearchParam.dialFormula = $('#dialFormula').val();

            tabList[subSearchParam.tabListIdx] = subSearchParam;
            sessionStorage.tabList = JSON.stringify(tabList);

            subchartObj1 = result;

            $('#dialSubStatsChart').remove();
            $("#dialSubStatsDiv").append('<canvas id="dialSubStatsChart"></canvas>');
            draw_chart('dialSubStatsChart', get_line_chart_data(result, 'sub'));
        }).error(function (result) {
            console.log(result);
        });
    } else {
        alert('검색 기간을 선택해 주세요.');
    }
}

function dialLeftDiffAnalyze(){
    let leftDiffObj = {
        campaignId : subSearchParam.campaignId,
        isInbound : subSearchParam.isInbound,
        isRunning : subSearchParam.isRunning,
        opStartTm : subSearchParam.opStartTm,
        opEndTm : subSearchParam.opEndTm,
        startDt : subSearchParam.startDt,
        endDt : subSearchParam.endDt
    };

    $.ajax({
        url : "getCallResultInfoDiff",
        data : JSON.stringify(leftDiffObj),
        type: "POST",
        contentType: 'application/json',
        beforeSend: function (xhr) {
            xhr.setRequestHeader($('#headerName').val(), $('#token').val());
        },
    }).success(function (result) {
        $('#find_term1').text(subSearchParam.startDt+'~'+subSearchParam.endDt);

        $('#dialDiffTable td:eq(0)').text(result.callSuccessSum);
        $('#dialDiffTable td:eq(1)').text(result.callSuccessPercent);
        $('#dialDiffTable td:eq(2)').text(result.callSuccessAvg);
        $('#dialDiffTable td:eq(3)').text(result.callSuccessAvgPercent);
        $('#dialDiffTable td:eq(4)').text(result.callSuccessMax);
        $('#dialDiffTable td:eq(5)').text(result.callSuccessMin);

        $('#dialDiffTable td:eq(12)').text(result.callFailSum);
        $('#dialDiffTable td:eq(13)').text(result.callFailPercent);
        $('#dialDiffTable td:eq(14)').text(result.callFailAvg);
        $('#dialDiffTable td:eq(15)').text(result.callFailAvgPercent);
        $('#dialDiffTable td:eq(16)').text(result.callFailMax);
        $('#dialDiffTable td:eq(17)').text(result.callFailMin);

        $('#dialDiffTable td:eq(24)').text(result.totalCallSum);
        $('#dialDiffTable td:eq(25)').text(result.totalCallPercent);
        $('#dialDiffTable td:eq(26)').text(result.totalCallAvg);
        $('#dialDiffTable td:eq(27)').text(result.totalCallAvgPercent);
        $('#dialDiffTable td:eq(28)').text(result.totalCallMax);
        $('#dialDiffTable td:eq(29)').text(result.totalCallMin);

    }).error(function (result) {
        console.log(result);
    });
}

function dialDiffAnalyze(){
    if($('#dialDiffFromDate').val() != '' && $('#dialDiffToDate').val() != ''){
        let diffObj = {
            campaignId : subSearchParam.campaignId,
            isInbound : subSearchParam.isInbound,
            isRunning : subSearchParam.isRunning,
            opStartTm : subSearchParam.opStartTm,
            opEndTm : subSearchParam.opEndTm,
            startDt : $('#dialDiffFromDate').val(),
            endDt : $('#dialDiffToDate').val()
        };

        $.ajax({
            url : "getCallResultInfoDiff",
            data : JSON.stringify(diffObj),
            type: "POST",
            contentType: 'application/json',
            beforeSend: function (xhr) {
                xhr.setRequestHeader($('#headerName').val(), $('#token').val());
            },
        }).success(function (result) {
            subSearchParam.diffStartDt = $('#dialDiffFromDate').val();
            subSearchParam.diffEndDt = $('#dialDiffToDate').val();
            $('#compare_term1').text($('#dialDiffFromDate').val()+'~'+$('#dialDiffToDate').val());

            $('#dialDiffTable td:eq(6)').text(result.callSuccessSum);
            $('#dialDiffTable td:eq(7)').text(result.callSuccessPercent);
            $('#dialDiffTable td:eq(8)').text(result.callSuccessAvg);
            $('#dialDiffTable td:eq(9)').text(result.callSuccessAvgPercent);
            $('#dialDiffTable td:eq(10)').text(result.callSuccessMax);
            $('#dialDiffTable td:eq(11)').text(result.callSuccessMin);

            $('#dialDiffTable td:eq(18)').text(result.callFailSum);
            $('#dialDiffTable td:eq(19)').text(result.callFailPercent);
            $('#dialDiffTable td:eq(20)').text(result.callFailAvg);
            $('#dialDiffTable td:eq(21)').text(result.callFailAvgPercent);
            $('#dialDiffTable td:eq(22)').text(result.callFailMax);
            $('#dialDiffTable td:eq(23)').text(result.callFailMin);

            $('#dialDiffTable td:eq(30)').text(result.totalCallSum);
            $('#dialDiffTable td:eq(31)').text(result.totalCallPercent);
            $('#dialDiffTable td:eq(32)').text(result.totalCallAvg);
            $('#dialDiffTable td:eq(33)').text(result.totalCallAvgPercent);
            $('#dialDiffTable td:eq(34)').text(result.totalCallMax);
            $('#dialDiffTable td:eq(35)').text(result.totalCallMin);

            tabList[subSearchParam.tabListIdx] = subSearchParam;
            sessionStorage.tabList = JSON.stringify(tabList);

        }).error(function (result) {
            console.log(result);
        });
    } else {
        alert('검색 기간을 선택해 주세요.');
    }
}

function dialFailDetailAnalyze(){
    if($('#dialFailDetailFromDate').val() != '' && $('#dialFailDetailToDate').val() != ''){
        let dialFailObj = {
            campaignId : subSearchParam.campaignId,
            isInbound : subSearchParam.isInbound,
            isRunning : subSearchParam.isRunning,
            opStartTm : subSearchParam.opStartTm,
            opEndTm : subSearchParam.opEndTm,
            startDt : $('#dialFailDetailFromDate').val(),
            endDt : $('#dialFailDetailToDate').val(),
            isDateType : $('#dialFailDateType').val(),
            isFormula : $('#dialFailFormula').val()
        };

        let list = getDateDiffType(dialFailObj.startDt, dialFailObj.endDt, true);
        dialFailObj.startDt = list[0];

        $.ajax({
            url : "getCallFailInfoDetailChart",
            data : JSON.stringify(dialFailObj),
            type: "POST",
            contentType: 'application/json',
            beforeSend: function (xhr) {
                xhr.setRequestHeader($('#headerName').val(), $('#token').val());
            },
        }).success(function (result) {
            subSearchParam.dialFailStartDt = $('#dialFailDetailFromDate').val();
            subSearchParam.dialFailEndDt = $('#dialFailDetailToDate').val();
            subSearchParam.dialFailDateType = $('#dialFailDateType').val();
            subSearchParam.dialFailFormula = $('#dialFailFormula').val();

            tabList[subSearchParam.tabListIdx] = subSearchParam;
            sessionStorage.tabList = JSON.stringify(tabList);

            subchartObj2 = result;

            $('#dialFailSubStatsChart').remove();
            $("#dialFailSubStatsDiv").append('<canvas id="dialFailSubStatsChart"></canvas>');
            draw_chart('dialFailSubStatsChart', get_line_chart_dialFail(result));
        }).error(function (result) {
            console.log(result);
        });
    } else {
        alert('검색 기간을 선택해 주세요.');
    }
}
