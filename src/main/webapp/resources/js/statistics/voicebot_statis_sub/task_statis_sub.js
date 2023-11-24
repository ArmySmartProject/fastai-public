$(document).ready(function () {
    $('#taskDiffFromDate_1').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#taskDiffFromDate_1').blur();
        $('#taskDiffToDate_1').datepicker( 'setStartDate', $(this).datepicker('getDate'));
    });

    $('#taskDiffToDate_1').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#taskDiffToDate_1').blur();
        $('#taskDiffFromDate_1').datepicker( 'setEndDate', $(this).datepicker('getDate'));
    });

    $('#taskDiffFromDate_2').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#taskDiffFromDate_2').blur();
        $('#taskDiffToDate_2').datepicker( 'setStartDate', $(this).datepicker('getDate'));
    });

    $('#taskDiffToDate_2').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#taskDiffToDate_2').blur();
        $('#taskDiffFromDate_2').datepicker( 'setEndDate', $(this).datepicker('getDate'));
    });

    $('#taskDiffFromDate_3').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#taskDiffFromDate_3').blur();
        $('#taskDiffToDate_3').datepicker( 'setStartDate', $(this).datepicker('getDate'));
    });

    $('#taskDiffToDate_3').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#taskDiffToDate_3').blur();
        $('#taskDiffFromDate_3').datepicker( 'setEndDate', $(this).datepicker('getDate'));
    });

    $('#taskDetailPeriod').text(subSearchParam.startDt + '~' + subSearchParam.endDt);
    $('#taskDiffPeriod').text(subSearchParam.startDt + '~' + subSearchParam.endDt);

    if (subSearchParam.diffStartDt_1 != undefined && subSearchParam.diffEndDt_1 != undefined &&
        subSearchParam.diffStartDt_1 != '' && subSearchParam.diffEndDt_1 != ''){
        $('#taskDiffFromDate_1').datepicker('update', subSearchParam.diffStartDt_1);
        $('#taskDiffToDate_1').datepicker('update', subSearchParam.diffEndDt_1);
        $('#taskDiffFromDate_1').datepicker( 'setEndDate', new Date(subSearchParam.diffEndDt_1));
        $('#taskDiffToDate_1').datepicker( 'setStartDate', new Date(subSearchParam.diffStartDt_1));
    }

    if (subSearchParam.diffStartDt_2 != undefined && subSearchParam.diffEndDt_2 != undefined &&
        subSearchParam.diffStartDt_2 != '' && subSearchParam.diffEndDt_2 != '') {
        $('#taskDiffFromDate_2').datepicker('update', subSearchParam.diffStartDt_2);
        $('#taskDiffToDate_2').datepicker('update', subSearchParam.diffEndDt_2);
        $('#taskDiffFromDate_2').datepicker( 'setEndDate', new Date(subSearchParam.diffEndDt_2));
        $('#taskDiffToDate_2').datepicker( 'setStartDate', new Date(subSearchParam.diffStartDt_2));
    }

    if (subSearchParam.diffStartDt_3 != undefined && subSearchParam.diffEndDt_3 != undefined &&
        subSearchParam.diffStartDt_3 != '' && subSearchParam.diffEndDt_3 != ''){
        $('#taskDiffFromDate_3').datepicker('update', subSearchParam.diffStartDt_3);
        $('#taskDiffToDate_3').datepicker('update', subSearchParam.diffEndDt_3);
        $('#taskDiffFromDate_3').datepicker( 'setEndDate', new Date(subSearchParam.diffEndDt_3));
        $('#taskDiffToDate_3').datepicker( 'setStartDate', new Date(subSearchParam.diffStartDt_3));
    }

    taskDiffLeftAjax();

    // sub Task별 고객 이탈 현황 비교 분석 테이블 to 엑셀
    $("#btn_download_table3").click(function () {
        var tableId = "comparison_each_task";
        var isRunning = subSearchParam.isRunning;
        var strTitle = $(this).parent().prev().text();
        var strCompareTerm = $("#taskDiffPeriod_1").text() + ', ' + $("#taskDiffPeriod_2").text() + ', ' + $("#taskDiffPeriod_3").text()
        var strTerm = subSearchParam.startDt + "~" + subSearchParam.endDt;
        var strIsrun = getRunningState(isRunning);
        addPrefix(12, tableId, strTitle, strTerm, strCompareTerm, strIsrun);
        exportExcel(tableId, getSubExportFileName(strTitle));
        removePrefix(tableId);
    });
});

function taskDiffLeftAjax(){
    let tmpList = [{
        startDt : subSearchParam.startDt,
        endDt : subSearchParam.endDt
    }];
    let taskObj = {
        campaignId : subSearchParam.campaignId,
        isInbound : subSearchParam.isInbound,
        isRunning : subSearchParam.isRunning,
        opStartTm : subSearchParam.opStartTm,
        opEndTm : subSearchParam.opEndTm,
        diffDtList : tmpList
    };

    $.ajax({
        url : "getLeavePerTaskDetailDiff",
        data : JSON.stringify(taskObj),
        type: "POST",
        contentType: 'application/json',
        beforeSend: function (xhr) {
            xhr.setRequestHeader($('#headerName').val(), $('#token').val());
        },
    }).success(function (result) {
        let list = result.diffList[0].taskList;
        let html = "";

        $.each(list, function (i, item){
            html += "<tr>";
            html += "  <td>" +  item.task + "</td>";
            html += "  <td>" +  item.isSuccess + "</td>";
            html += "  <td>" +  (item.isSuccess == 'Y' ? '-' : item.taskCount) + "</td>";
            html += "  <td>" +  (item.isSuccess == 'Y' ? '-' : item.customerAwayRate+ '%')  + "</td>";

            html += "  <td name='diff_1'>-</td> <td name='diff_1'>-</td> <td name='diff_1'>-</td>" // 비교 1
            html += "  <td name='diff_2'>-</td> <td name='diff_2'>-</td> <td name='diff_2'>-</td>" // 비교 2
            html += "  <td name='diff_3'>-</td> <td name='diff_3'>-</td> <td name='diff_3'>-</td>" // 비교 3
            html += "</tr>";
        });

        $("#taskDiffTable tbody").empty();
        $("#taskDiffTable tbody").append(html);

        if(($('#taskDiffFromDate_1').val() != '' && $('#taskDiffToDate_1').val() != '') ||
            ($('#taskDiffFromDate_2').val() != '' && $('#taskDiffToDate_2').val() != '') ||
            ($('#taskDiffFromDate_3').val() != '' && $('#taskDiffToDate_3').val() != '')){
            taskDiffAnalyze();
        }

    }).error(function (result) {
        console.log(result);
    });
}

function taskDiffAnalyze(){
    let tmpList = [];
    let tmpObj_1 = {
        startDt : $('#taskDiffFromDate_1').val(),
        endDt : $('#taskDiffToDate_1').val()
    };
    tmpList.push(tmpObj_1);
    let tmpObj_2 = {
        startDt : $('#taskDiffFromDate_2').val(),
        endDt : $('#taskDiffToDate_2').val()
    };
    tmpList.push(tmpObj_2);
    let tmpObj_3 = {
        startDt : $('#taskDiffFromDate_3').val(),
        endDt : $('#taskDiffToDate_3').val()
    };
    tmpList.push(tmpObj_3);

    if($('#taskDiffFromDate_1').val() == '' && $('#taskDiffToDate_1').val() == '' &&
        $('#taskDiffFromDate_2').val() == '' && $('#taskDiffToDate_2').val() == '' &&
        $('#taskDiffFromDate_3').val() == '' && $('#taskDiffToDate_3').val() == ''){
       alert('비교 기간을 선택해 주세요.');
    } else {
        let taskObj = {
            campaignId : subSearchParam.campaignId,
            isInbound : subSearchParam.isInbound,
            isRunning : subSearchParam.isRunning,
            opStartTm : subSearchParam.opStartTm,
            opEndTm : subSearchParam.opEndTm,
            diffDtList : tmpList
        };

        $.ajax({
            url : "getLeavePerTaskDetailDiff",
            data : JSON.stringify(taskObj),
            type: "POST",
            contentType: 'application/json',
            beforeSend: function (xhr) {
                xhr.setRequestHeader($('#headerName').val(), $('#token').val());
            },
        }).success(function (result) {
            $.each(result.diffList, function(i, item){
                // console.log(i, item);
                let el = $('#taskDiffTable td[name=diff_'+(i+1)+']');
                if(item.diffStartDt != '' && item.diffEndDt != ''){
                    for(let j = 0; j < item.taskList.length*3; j += 3){
                        var obj = item.taskList[j/3];
                        $(el).eq(j).text(obj.isSuccess);
                        $(el).eq(j+1).text(obj.isSuccess == 'Y' ? '-' : obj.taskCount);
                        $(el).eq(j+2).text(obj.isSuccess == 'Y' ? '-' : obj.customerAwayRate + '%');
                    }

                    $('#taskDiffPeriod_'+(i+1)).removeClass('info_txt');
                    $('#taskDiffPeriod_'+(i+1)).text(tmpList[i].startDt +' ~ '+ tmpList[i].endDt);

                }else{
                    for(let j = 0; j < item.taskList.length; j ++){
                        $(el).text('-');
                    }

                    $('#taskDiffPeriod_'+(i+1)).addClass('info_txt');
                    $('#taskDiffPeriod_'+(i+1)).text('비교 기간을 선택해 주세요.');
                }
            });

            subSearchParam.diffStartDt_1 = tmpObj_1.startDt;
            subSearchParam.diffEndDt_1 = tmpObj_1.endDt;
            subSearchParam.diffStartDt_2 = tmpObj_2.startDt;
            subSearchParam.diffEndDt_2 = tmpObj_2.endDt;
            subSearchParam.diffStartDt_3 = tmpObj_3.startDt;
            subSearchParam.diffEndDt_3 = tmpObj_3.endDt;
            tabList[subSearchParam.tabListIdx] = subSearchParam;
            sessionStorage.tabList = JSON.stringify(tabList);
        }).error(function (result) {
            console.log(result);
        });
    }
}