let campList = null;
let subCampList = null;
let tabList = sessionStorage.tabList ? JSON.parse(sessionStorage.tabList) :[];
let taskAwayList = null;
let campDatatable = null;
let subCampDatatable = null;
let taskAwayDatatable = null;
let voiceBotInfo = null;
let sendResultChart = null;
let callResultChart = null;
let campResultChart = null;
let today = new Date();
let year = today.getFullYear();
let month = ('0' + (today.getMonth() + 1)).slice(-2);
let day = ('0' + today.getDate()).slice(-2);
let nowDate = year + '-' + month  + '-' + day;
let nowFirstDate = nowDate.substring(0,8)+'01';
var excelSeq = 0;
var chartObj0 = new Object();
var chartObj1 = new Object();
var chartObj2 = new Object();
let mainSearchParam = JSON.parse(sessionStorage.getItem("mainSearchParam"));
let subSearchParam;
let sendDiffList = [];
let sendDiffCampareList = [];

var subchartObj0 = new Object();
var subchartObj1 = new Object();
var subchartObj2 = new Object();
var subchartObj3 = new Object();

var excelHandler = {
    getExcelFileName: function (fileName) {
        return fileName.length > 0 ? fileName + '.xlsx' : 'table-data.xlsx';
    },
    getSheetName: function (sheetName) {
        return sheetName;
    },
    getExcelData: function (tableId) {
        return document.getElementById(tableId);
    },
    getWorksheet: function (tableId) {
        return XLSX.utils.table_to_sheet(this.getExcelData(tableId), {raw: true});
    }
}

$(document).ready(function () {
    let periodButton = $('#selectPeriod').children('button');

    $('#fromMainDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true
    }).on("changeDate", function (){
        $('#fromMainDate').blur();
        $('#toMainDate').datepicker( 'setStartDate', $(this).datepicker('getDate'));
        periodButton.removeClass('active');
    });

    $('#toMainDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true
    }).on("changeDate", function (){
        $('#toMainDate').blur();
        $('#fromMainDate').datepicker( 'setEndDate', $(this).datepicker('getDate'));
        periodButton.removeClass('active');
    });

    if(mainSearchParam){
        $('#fromMainDate').datepicker('update', mainSearchParam.startDt);
        $('#toMainDate').datepicker('update', mainSearchParam.endDt);
        $('#fromMainDate').datepicker( 'setEndDate', new Date(mainSearchParam.endDt));
        $('#toMainDate').datepicker( 'setStartDate', new Date(mainSearchParam.startDt));
        $('#channel_name').text(mainSearchParam.isInbound=='Y'?'인바운드':'아웃바운드');
        if(mainSearchParam.isRunning==''){
            $('#radio01').prop('checked',true);
        }else{
            $('input:radio[value='+mainSearchParam.isRunning+']').prop('checked',true);
        }

    }else{
        $('#fromMainDate').datepicker('update', nowFirstDate);
        $('#toMainDate').datepicker('update', nowDate);
        $('#fromMainDate').datepicker( 'setEndDate', today);
        $('#toMainDate').datepicker( 'setStartDate', new Date(nowFirstDate));
    }

    periodButton.on('click', function(){
        periodButton.removeClass('active');
        $(this).addClass('active');
        let selectPeriod = $(this).text();
        let startDate = "";

        $('#toMainDate').datepicker('update', nowDate);

        if(selectPeriod == '오늘'){
            startDate = nowDate;
        }else if (selectPeriod == '1주'){
            let tempDate = new Date();
            tempDate.setDate(today.getDate()-6);
            startDate = tempDate.getFullYear()+'-'+('0' + (tempDate.getMonth() + 1)).slice(-2) + '-'+ ('0' + tempDate.getDate()).slice(-2);
        }else if (selectPeriod == '1개월'){
            startDate = getPreDate(nowDate,1,'month');
        }else if (selectPeriod == '3개월'){
            startDate = getPreDate(nowDate,3,'month');
        }else if (selectPeriod == '1년'){
            startDate = getPreDate(nowDate,1,'year');
        }
        $('#fromMainDate').datepicker('update', startDate);

        $('#toMainDate').datepicker( 'setStartDate', startDate);
        $('#fromMainDate').datepicker( 'setEndDate', nowDate);
    });

    campaignList();

    $('#campListTable').on('click', 'tbody tr', function () {
        $('#campListTable').find('tr').removeClass('active');
        $(this).addClass('active');
    });
    $('#campListTable').on('dblclick', 'tbody tr', function () {
        let row = campDatatable.row($(this)).data();
        mainSearchDataSet(row);
        hidePopup('campaign_search');
    });

    /* 캠페인 결과 상세 페이지 캠페인 리스트 */
    $('#subCampListTable').on('click', 'tbody tr', function () {
        let checkbox = $(this).find('input[type=checkbox]');
        $(this).toggleClass('active');
        $(this).find('input[type=checkbox]').prop('checked', $(this).hasClass('active'));

        if(subCampDatatable.rows(".active").count() > 5) {
            $(this).toggleClass('active');
            $(this).find('input[type=checkbox]').prop('checked', $(this).hasClass('active'));
            alert("캠페인은 5개 이하로 선택 가능합니다.");
            return;
        }
    });

    $('#mainSearch').on('click', function () {
        campaignSearch();
    });

    if(tabList.length > 0){
        getExitTab();
    }

    $(".btn_download").click(function () {
        var idx = $(".btn_download").index(this);
        if (idx == 3) {
            $(".buttonsToHide").trigger('click');
            return;
        }  //for Task별 고객이탈 현황
        var tableId = "table_" + idx;
        var isRunning = $("input[name='searchOpTime']:checked").val();
        var strTitle = $(".statistics .content.stat_main .detail_info h4").eq(idx).html().split('<')[0];
        var strTerm = "기간: " + $(".statistics .content.stat_main .detail_info h4 .stat_date").eq(idx).text();
        var strIsrun = "운영상태: " + getRunningState(isRunning);
        generate_table(eval("chartObj" + idx), tableId, strTitle, strTerm, strIsrun)
        exportTableToExcel(tableId, getExportFileName(idx))
    });

});

function getRunningState(isRunning) {
    switch (isRunning) {
        case '0':
            strIsRun = "전체"
            break;
        case 'Y':
            strIsRun = "운영중"
            break;
        case 'N':
            strIsRun = "운영외"
            break;
        default:
            strIsRun = "전체"
    }
    return strIsRun;
}

function generate_table(obj, tableId, title, term, running) {
    //console.log('g_table obj', obj)
    var old_table = document.getElementById(tableId);
    if (old_table) old_table.parentNode.removeChild(old_table);
    label_len = obj.datasets.length
    x_len = obj.labels.length
    y_len = obj.datasets[0].data.length
    // get the reference for the body
    var body = document.getElementsByTagName("body")[0];

    // creates a <table> element and a <tbody> element
    var tbl = document.createElement("table");
    var tblBody = document.createElement("tbody");
    tbl.id = tableId

    for (var n = 0; n < 4; n++) {
        var row = document.createElement("tr");

        var cell = document.createElement("td")
        cell.colSpan = label_len + 1
        if (n == 0) title = title;
        if (n == 1) title = term;
        if (n == 2) title = running;
        var cellText = document.createTextNode(title); //"r"+i+",c"+j
        title = "";
        cell.appendChild(cellText);
        row.appendChild(cell);

        tblBody.appendChild(row);
    }

    // creating all cells
    for (var i = 0; i <= y_len; i++) {
        // creates a table row
        var row = document.createElement("tr");

        for (var j = 0; j <= label_len; j++) {
            console.log(label_len);
            // Create a <td> element and a text node, make the text
            // node the contents of the <td>, and put the <td> at
            // the end of the table row
            var cell = document.createElement("td");
            if (j == 0) {
                x_ele = obj.labels[i - 1]
            } else if (j >= 1) {
                if(label_len == 3){
                    if(j == 1){
                        x_ele = obj.datasets[j - 1].data[i - 1] / 100
                    }else {
                        x_ele = obj.datasets[j - 1].data[i - 1]
                    }
                }else {
                    x_ele = obj.datasets[j - 1].data[i - 1]
                }
                //}else if (j == 2){
                //  x_ele = obj.datasets[j-1].data[i-1]
            } else {
                x_ele = ""
            }

            if (i == 0 && j == 0) x_ele = " "
            if (i == 0 && j >= 1) x_ele = obj.datasets[j - 1].label


            var cellText = document.createTextNode(x_ele); //"r"+i+",c"+j
            cell.appendChild(cellText);
            row.appendChild(cell);
        }

        // add the row to the end of the table body
        tblBody.appendChild(row);
    }

    // put the <tbody> in the <table>
    tbl.appendChild(tblBody);
    // appends <table> into <body>
    body.appendChild(tbl);
    // sets the border attribute of tbl to 1;
    tbl.setAttribute("border", "1");

    document.getElementById(tableId).style.display = "none";
}

function exportTableToExcel(tableID, filename = '') {
    var downloadLink;
    var dataType = 'application/vnd.ms-excel;charset=utf-8,%EF%BB%BF';
    var tableSelect = document.getElementById(tableID);
    var tableHTML = tableSelect.outerHTML.replace(/ /g, '%20');

    // Specify file name
    filename = filename ? filename + '.xls' : 'excel_data.xls';

    // Create download link element
    downloadLink = document.createElement("a");
    console.log("downloadLink" + downloadLink);
    document.body.appendChild(downloadLink);

    if (navigator.msSaveOrOpenBlob) {
        var blob = new Blob(['\ufeff', tableHTML], {
            type: dataType
        });
        navigator.msSaveOrOpenBlob(blob, filename);
    } else {
        // Create a link to the file
        downloadLink.href = 'data:' + dataType + ' ' + tableHTML;

        // Setting the file name
        downloadLink.download = filename;

        //triggering the function
        downloadLink.click();
    }
}

function getExcelSeq() {
    excelSeq++;
    return excelSeq;
}

function getExportFileName(n) {
    var strTitle = $(".statistics .content.stat_main .detail_info h4").eq(n).html().split('<')[0];
    strTitle = strTitle.replace(/(\s*)/g, "") + '_' + prevDay() + '_' + getExcelSeq()
    return strTitle;
}

function s2ab(s) {
    var buf = new ArrayBuffer(s.length); //convert s to arrayBuffer
    var view = new Uint8Array(buf);  //create uint8array as viewer
    for (var i = 0; i < s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; //convert to octet
    return buf;
}

function exportExcel(tableId, strTitle) {
    // step 1. workbook 생성
    var wb = XLSX.utils.book_new();

    // step 2. 시트 만들기
    var newWorksheet = excelHandler.getWorksheet(tableId);

    // step 3. workbook에 새로만든 워크시트에 이름을 주고 붙인다.
    XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName(strTitle));

    // step 4. 엑셀 파일 만들기
    var wbout = XLSX.write(wb, {bookType: 'xlsx', type: 'binary'});

    // step 5. 엑셀 파일 내보내기
    saveAs(new Blob([s2ab(wbout)], {type: "application/octet-stream"}), excelHandler.getExcelFileName(strTitle));
}

function addPrefix(rightColspan, tableId, strTitle, strTerm, strCompareTerm, strIsrun) {
    var preTitle = '<tr><th>타이틀</th><th colspan=' + rightColspan + '>' + strTitle + '</th></tr>';
    preTitle += '<tr><th>검색기간</th><th colspan=' + rightColspan + '>' + strTerm + '</th></tr>';
    preTitle += '<tr><th>비교기간</th><th colspan=' + rightColspan + '>' + strCompareTerm + '</th></tr>';
    preTitle += '<tr><th>운영구분</th><th colspan=' + rightColspan + '>' + strIsrun + '</th></tr>';
    preTitle += '<tr><th colspan=' + (rightColspan + 1) + '></th></tr>';
    $("#" + tableId + " thead > tr:eq(0)").before(preTitle)
}

function removePrefix(tableId) {
    $("#" + tableId + " thead > tr:lt(5)").remove();
}


function getSubExportFileName(strTitle) {
    // var strTitle = $("#subchart0_title" > h5").text();
    strTitle = strTitle.replace(/(\s*)/g, "") + '_' + prevDay() + '_' + getExcelSeq()
    return strTitle;
}

function prevDay() {
    var d = new Date();
    return getDateStr(d);
}

function getDateStr(myDate) {
    var year = myDate.getFullYear();
    var month = (myDate.getMonth() + 1);
    var day = myDate.getDate();

    month = (month < 10) ? "0" + String(month) : month;
    day = (day < 10) ? "0" + String(day) : day;

    return year + '-' + month + '-' + day;
}

function campaignList(){
    let obj = new Object();
    obj.campaignNm = $('#searchCampNm').val();

    $.ajax({
        url : "getVoiceStatCampaignList",
        data : JSON.stringify(obj),
        type: "POST",
        contentType: 'application/json',
        beforeSend: function (xhr) {
            xhr.setRequestHeader($('#headerName').val(), $('#token').val());
        },
    }).success(function(result){
        campList = result.data;
        if(campDatatable != null){
            campDatatable.destroy();
        }

        if($('#searchCampId').val() == '' && mainSearchParam == undefined){
            mainSearchDataSet(campList[0]);
            mainSearch();
        }else if(mainSearchParam){
            mainSearchDataSet(mainSearchParam);
            mainSearch();
        }

        campaignDatatable();
    }).error(function (result){
        console.log(result);
    });
}

function campaignDatatable(){
    campDatatable = $("#campListTable").DataTable({
        "language": {
            "emptyTable": "등록된 데이터가 없습니다.",
            "lengthMenu": "페이지당 _MENU_ 개씩 보기",
            "info": "현재 _START_ - _END_ / _TOTAL_건",
            "infoEmpty": "데이터 없음",
            "infoFiltered": "( _MAX_건의 데이터에서 필터링됨 )",
            "search": "",
            "zeroRecords": "일치하는 데이터가 없습니다.",
            "loadingRecords": "로딩중...",
            "paginate": {
                "next": "›",
                "previous": "‹",
                "first": "«",
                "last": "»",
            }
        },
        bDestroy: true,
        bFilter: false,
        bInfo: false,
        sDom: "lrtip",
        lengthChange: false,
        fixedColumns: true,
        autoWidth: false, //css width
        searching: false, //검색
        ordering: true, //정렬
        order:[],
        paging: true, // paging 디폴트 : row 10개, 페이징 5개
        pageLength: 10, // row 10개
        pagingType: "full_numbers_no_ellipses",
        data: campList, //참조 data
        columns: [
            {
                data: 'campaignNm',
                name: 'campaignNm',
                title: '캠페인명',
                searchable: false,
            },
            {
                data: 'startDt',
                name: 'startDt',
                title: '시작일자',
                searchable: false,
            },
            {
                data: 'useYn',
                name: 'useYn',
                title: '상태',
            },
            {
                data: 'campaignId',
                name: 'campaignId',
                title: '캠페인아이디',
                visible: false,
                searchable: false,
            },
            {
                data: 'isInbound',
                name: 'isInbound',
                title: '채널',
                visible: false,
                searchable: false,
            },
            {
                data: 'opStartTm',
                name: 'opStartTm',
                title: '시작시간',
                visible: false,
                searchable: false,
            },
            {
                data: 'opEndTm',
                name: 'opEndTm',
                title: '종료시간',
                visible: false,
                searchable: false,
            }
        ]
    });
    campDatatable.draw();
}

function campSelect(){
    let row = campDatatable.row(".active").data();
    if(row == undefined || row == null){
        alert("캠페인을 선택해 주세요.");
    }else{
        mainSearchDataSet(row);
        hidePopup('campaign_search');
    }
}

function getPreDate(paramDate, preDate, type){
    let date = new Date(paramDate);
    let year = date.getFullYear();
    let month = date.getMonth();

    if(type == 'year'){
        year = date.getFullYear() - preDate;
    }else if(type == 'month'){
        month = date.getMonth() - preDate;
    }

    let monthFirstDate = new Date(
        year, month,1
    );
    let monthLastDate = new Date(
        monthFirstDate.getFullYear(),monthFirstDate.getMonth() + 1,0
    );

    let result = monthFirstDate;
    if(date.getDate() >= monthLastDate.getDate()){
        result.setDate(monthLastDate.getDate());
    }else{
        result.setDate(date.getDate()+1);
    }

    return result.getFullYear() + '-' + ('0' + (result.getMonth() + 1)).slice(-2)  + '-' + ('0' + result.getDate()).slice(-2);
}

function getDateDiffType(fromDate, toDate, fromDateChange){
    let tmpFromDate = new Date(fromDate);
    let tmpToDate = new Date(toDate);
    let diffD = (tmpToDate.getTime() - tmpFromDate.getTime())/(1000*60*60*24);
    let result = [];

    if(diffD == 0){ // 당일
        if(fromDateChange) {
            tmpFromDate.setDate(tmpFromDate.getDate() - 1);
        }
        result =  ['hourly', 'hourly', 'daily'];
    }else if(diffD<=2){ // 2일이상 ~ 3일 이하
        if(fromDateChange) {
            tmpFromDate.setDate(tmpFromDate.getDate() - 7);
        }
        result =  ['daily', 'hourly', 'daily', 'dayOfWeek','weekly'];
    }else if(diffD<=6){ // 3일 초과 1주 이하
        if(fromDateChange) {
            tmpFromDate.setDate(tmpFromDate.getDate() - 7);
        }
        result =  ['daily', 'daily', 'dayOfWeek','weekly'];
    }else if(getPreDate(toDate, 1, 'month') <= fromDate){ // 1주 초과 1개월 이하
        if(fromDateChange) {
            tmpFromDate.setDate(tmpFromDate.getDate() - 7);
        }
        result =  ['daily', 'daily', 'dayOfWeek','weekly', 'monthly'];
    }else if(getPreDate(toDate, 3, 'month') <= fromDate){ // 1개월 초과 3개월 이하
        if(fromDateChange) {
            tmpFromDate = new Date(getPreDate(fromDate, 1, 'month'));
        }
        result =  ['weekly', 'daily', 'dayOfWeek','weekly', 'monthly'];
    }else if(getPreDate(toDate, 1, 'year') <= fromDate) { // 3개월 초과 1년 이하
        if(fromDateChange) {
            tmpFromDate = new Date(getPreDate(fromDate, 3, 'month'));
        }
        result =  ['monthly', 'monthly', 'yearly'];
    }else if(getPreDate(toDate, 2, 'year') <= fromDate) { // 1년 초과 2년 이하
        if(fromDateChange) {
            tmpFromDate = new Date(getPreDate(fromDate, 6, 'month'));
        }
        result =  ['monthly', 'monthly', 'yearly'];
    }else if(getPreDate(toDate, 2, 'year') > fromDate) { // 2년 초과
        if(fromDateChange) {
            tmpFromDate = new Date(getPreDate(fromDate, 6, 'month'));
        }
        result =  ['yearly', 'yearly'];
    }

    if(fromDateChange) {
        result.unshift(tmpFromDate.getFullYear() + '-' + ('0' + (tmpFromDate.getMonth() + 1)).slice(-2) + '-' + ('0' + tmpFromDate.getDate()).slice(-2));
    } else {
        result.unshift(fromDate);
    }
    return result;
}

function mainSearchDataSet(obj){
    $('#searchCampId').val(obj.campaignId);
    $('#searchInbound').val(obj.isInbound);
    $('#channel_name').text(obj.isInbound=='Y'?'인바운드':'아웃바운드');
    $('#searchOpStartTm').val(obj.opStartTm);
    $('#searchOpEndTm').val(obj.opEndTm);
    $('#searchCampNm').val(obj.campaignNm);
}

function campaignSearch(){
    let popOpen = true;
    let campNm = $('#searchCampNm').val();

    $.each(campList, function (i, item){
       if(item.campaignNm === campNm){
           popOpen = false;
           mainSearchDataSet(item);
           mainSearch();
       }
    });

    if(popOpen){
        $('#searchCampNm').blur();
        campaignList();
        openPopup('campaign_search');
    }
}

function mainSearchDataSetting(){
    sendResultInfoChart(mainSearchParam);
    dialResultInfoChart(mainSearchParam);
    campResultInfoChart(mainSearchParam);
    getCustomerAwayInfoPerTask(mainSearchParam);

    $.ajax({
        url : "getVoiceBotInfo",
        data : JSON.stringify(mainSearchParam),
        type: "POST",
        contentType: 'application/json',
        beforeSend: function (xhr) {
            xhr.setRequestHeader($('#headerName').val(), $('#token').val());
        },
    }).success(function (result) {
        voiceBotInfo = result;

        $("#voiceBotTitle").text(voiceBotInfo.title);
        $("#voiceBotCount").text(voiceBotInfo.voiceBotCount);
        $("#totalDialTime").text(voiceBotInfo.voiceBotInfo.totalDialTime);
        $("#averageDialTime").text(voiceBotInfo.voiceBotInfo.averageDialTime);
        $("#longestDialTime").text(voiceBotInfo.voiceBotInfo.longestDialTime);
        $("#shortestDialTime").text(voiceBotInfo.voiceBotInfo.shortestDialTime);
        $("#sendCnt").text(voiceBotInfo.sendCount);
        $("#sendSuccessCnt").text(voiceBotInfo.sendSuccessCount);
        $("#targetCnt").text(voiceBotInfo.dialTargetCount);

        draw_chart('sendResultCountChart', get_horizontal_chart_data(voiceBotInfo.sendResult));
        draw_chart('dialResultCountChart', get_horizontal_chart_data(voiceBotInfo.dialResult));
        draw_chart('campResultCountChart', get_horizontal_chart_data(voiceBotInfo.campaignResult));
    }).error(function (result) {
       console.log(result);
    });
}

function sendResultInfoChart(obj){
    $.ajax({
        url : "getSendResultInfoChart",
        data : JSON.stringify(obj),
        type: "POST",
        contentType: 'application/json',
        beforeSend: function (xhr) {
            xhr.setRequestHeader($('#headerName').val(), $('#token').val());
        },
    }).success(function (result) {
        sendResultChart = result;

        draw_chart('sendResultLineChart', get_line_chart_data(sendResultChart, 'main'));
        chartObj0 = sendResultChart;
    }).error(function (result) {
        console.log(result);
    });
}

function dialResultInfoChart(obj){
    $.ajax({
        url : "getDialResultInfoChart",
        data : JSON.stringify(obj),
        type: "POST",
        contentType: 'application/json',
        beforeSend: function (xhr) {
            xhr.setRequestHeader($('#headerName').val(), $('#token').val());
        },
    }).success(function (result) {
        callResultChart = result;

        draw_chart('callResultLineChart', get_line_chart_data(callResultChart, 'main'));
        chartObj1 = callResultChart;
    }).error(function (result) {
        console.log(result);
    });
}

function campResultInfoChart(obj){
    $.ajax({
        url : "getCampaignResultInfoChart",
        data : JSON.stringify(obj),
        type: "POST",
        contentType: 'application/json',
        beforeSend: function (xhr) {
            xhr.setRequestHeader($('#headerName').val(), $('#token').val());
        },
    }).success(function (result) {
        campResultChart = result;

        draw_chart('campResultLineChart', get_line_chart_data(campResultChart, 'main'));
        chartObj2 = campResultChart;
    }).error(function (result) {
        console.log(result);
    });
}

function getCustomerAwayInfoPerTask(obj){
    $.ajax({
        url : "getCustomerAwayInfoPerTask",
        data : JSON.stringify(obj),
        type: "POST",
        contentType: 'application/json',
        beforeSend: function (xhr) {
            xhr.setRequestHeader($('#headerName').val(), $('#token').val());
        },
    }).success(function (result) {
        if(taskAwayDatatable != null){
            taskAwayDatatable.destroy();
        }
        taskAwayList = result;
        taskAwayRateDatatable();
    }).error(function (result) {
        console.log(result);
    });
}

function taskAwayRateDatatable(){
    taskAwayDatatable = $("#taskAwayRate").DataTable({
        "createdRow": function( row, data, dataIndex ) {
            if(data.isSuccess == 'Y'){
                $(row).addClass('status_success');
            }
        },
        "language": {
            "emptyTable": "등록된 데이터가 없습니다.",
            "lengthMenu": "페이지당 _MENU_ 개씩 보기",
            "info": "현재 _START_ - _END_ / _TOTAL_건",
            "infoEmpty": "데이터 없음",
            "infoFiltered": "( _MAX_건의 데이터에서 필터링됨 )",
            "search": "",
            "zeroRecords": "일치하는 데이터가 없습니다.",
            "loadingRecords": "로딩중...",
            "paginate": {
                "next": "›",
                "previous": "‹",
                "first": "«",
                "last": "»",
            }
        },
        dom: 'Bfrtip',
        buttons: [
            {
                extend: "excel",
                className: "buttonsToHide",
                title: "",
                // init: function(dt, node, config) {
                //   var strTitle = $(".statistics .content.stat_main .detail_info h4").eq(3).html().split('<')[0];
                //   strTitle = strTitle.replace(/(\s*)/g, "") + '_' + prevDay() +'_' + getExcelSeq()
                //   config.title = strTitle;
                // },
                filename: function () {
                    return getExportFileName(3);
                },
                customize: function (xlsx) {
                    var sheet = xlsx.xl.worksheets['sheet1.xml'];
                    var numrows = 4;
                    var clR = $('row', sheet);

                    //update Row
                    clR.each(function () {
                        var attr = $(this).attr('r');
                        var ind = parseInt(attr);
                        ind = ind + numrows;
                        $(this).attr("r", ind);
                    });

                    // Create row before data
                    $('row c ', sheet).each(function () {
                        var attr = $(this).attr('r');
                        var pre = attr.substring(0, 1);
                        var ind = parseInt(attr.substring(1, attr.length));
                        ind = ind + numrows;
                        $(this).attr("r", pre + ind);
                    });

                    function Addrow(index, data) {
                        msg = '<row r="' + index + '">'
                        for (i = 0; i < data.length; i++) {
                            var key = data[i].key;
                            var value = data[i].value;
                            msg += '<c t="inlineStr" r="' + key + index + '">';
                            msg += '<is>';
                            msg += '<t>' + value + '</t>';
                            msg += '</is>';
                            msg += '</c>';
                        }
                        msg += '</row>';
                        return msg;
                    }

                    var isRunning = $("input[name='radioName1']:checked").val();
                    var strTitle = $(".statistics .content.stat_main .detail_info h4").eq(3).html().split('<')[0];
                    var strTerm = "기간: " + $(".statistics .content.stat_main .detail_info h4 .stat_date").eq(3).text()
                    var strIsrun = "운영상태: " + getRunningState(isRunning);

                    //insert
                    var r1 = Addrow(1, [{key: 'A', value: strTitle}]);
                    var r2 = Addrow(2, [{key: 'A', value: strTerm}]);
                    var r3 = Addrow(3, [{key: 'A', value: strIsrun}]);
                    var r4 = Addrow(4, [{key: 'A', value: ''}]);

                    sheet.childNodes[0].childNodes[1].innerHTML = r1 + r2 + r3 + r4 + sheet.childNodes[0].childNodes[1].innerHTML;
                }
            }
        ],
        bDestroy: true,
        bFilter: false,
        bInfo: false,
        sDom: "lrtip",
        lengthChange: false,
        fixedColumns: true,
        autoWidth: false, //css width
        searching: false, //검색
        ordering: false, //정렬
        paging: true, // paging 디폴트 : row 10개, 페이징 5개
        pageLength: 10, // row 5개
        pagingType: "full_numbers_no_ellipses",
        data: taskAwayList.data, //참조 data
        columns: [
            {
                data: 'task',
                name: 'task',
                title: 'Task',
            },
            {
                data: 'isSuccess',
                name: 'isSuccess',
                title: '캠페인<br>성공 구분',
                render: function (data, type, row) {
                    data = data == 'Y' ? '성공' : '실패';
                    return data;
                }
            },
            {
                data: 'taskCount',
                name: 'taskCount',
                title: '건수',
                render: function (data, type, row) {
                    if(row.isSuccess == 'Y'){
                        return '-';
                    }else{
                        return data;
                    }

                }
            },
            {
                data: 'customerAwayRate',
                name: 'customerAwayRate',
                title: '이탈율(%)',
                render: function (data, type, row) {
                    if(row.isSuccess == 'Y'){
                        return '-';
                    }else{
                        return data + "%";
                    }

                }
            },
        ]
    });
    taskAwayDatatable.buttons('.buttonsToHide').nodes().addClass('hidden');
    taskAwayDatatable.draw();
}

function searchValid(){
    if(!$('#searchCampId').val()){
        alert('캠페인을 선택해주세요.');
        return false;
    }else if(!$('#fromMainDate').val() || !$('#toMainDate').val()){
        alert('검색기간을 선택해주세요.');
        return false;
    }else{
        return true;
    }
}

function mainSearch(){
    let obj = {
        "campaignId":$('#searchCampId').val(),
        "startDt"   :$('#fromMainDate').val(),
        "endDt"	    :$('#toMainDate').val(),
        "isInbound" :$('#searchInbound').val(),
        "isRunning" :$('input[name=searchOpTime]:checked').val(),
        "opStartTm" :$('#searchOpStartTm').val(),
        "opEndTm"   :$('#searchOpEndTm').val(),
        "campaignNm":$('#searchCampNm').val()
    };
    sessionStorage.removeItem("mainSearchParam");
    sessionStorage.setItem("mainSearchParam", JSON.stringify(obj));
    mainSearchParam = obj;

    if(searchValid()){
        $('p[name=mainSearchDate]').text($('#fromMainDate').val() + '~' + $('#toMainDate').val());
        canvas_refresh();
        mainSearchDataSetting();
    }
}

function getExitTab(){
    let list = tabList;
    tabList = [];
    sessionStorage.removeItem("tabList");
    $.each(list, function(i, item){
        statsTabOpen(item.tabType, false, item);
    });

    statsTabSelect(0,'main');
}

function statsTabOpen(tab, moveType, exitTab){
    let obj = new Object();
    let searchPeriod = '';
    if(exitTab){
        obj = exitTab;
        searchPeriod = exitTab.startDt + '~' + exitTab.endDt;
    }else{
        obj = JSON.parse(sessionStorage.mainSearchParam);
        searchPeriod = mainSearchParam.startDt + '~' + mainSearchParam.endDt;
    }

    let tabMenu = '';
    let tabIdx = Number($('#tabMenuList li').eq($('#tabMenuList li').length-1).attr('id').split('_')[1])+1;
    $('#tabMenuList a').removeClass('active');

    if(tab == 'send') {
        tabMenu = '<li id="tab_'+tabIdx+'" >\n' +
                '   <a title="발송 결과 현황 ' + searchPeriod + '" class="active" onclick="statsTabSelect('+tabIdx+', \'send\');">' +
                '       발송 결과 현황<span>'+searchPeriod+'</span></a>\n' +
                '   <button type="button" class="btn_close" onclick="statsTabClose('+tabIdx+')">&#215;</button>\n' +
                '</li>';

        obj.tabIdx = tabIdx;
        obj.tabType = 'send';
    }else if(tab == 'dial'){
        tabMenu = '<li id="tab_'+tabIdx+'" >\n' +
                '   <a title="통화 결과 현황 ' + searchPeriod + '" class="active" onclick="statsTabSelect('+tabIdx+',\'dial\');">' +
                '       통화 결과 현황<span>'+searchPeriod+'</span></a>\n' +
                '   <button type="button" class="btn_close" onclick="statsTabClose('+tabIdx+')">&#215;</button>\n' +
                '</li>';

        obj.tabIdx = tabIdx;
        obj.tabType = 'dial';
    }else if(tab == 'camp'){
        tabMenu = '<li id="tab_'+tabIdx+'" >\n' +
                '   <a title="캠페인 결과 현황 ' + searchPeriod + '" class="active" onclick="statsTabSelect('+tabIdx+',\'camp\');">' +
                '       캠페인 결과 현황<span>'+searchPeriod+'</span></a>\n' +
                '   <button type="button" class="btn_close" onclick="statsTabClose('+tabIdx+')">&#215;</button>\n' +
                '</li>';

        obj.tabIdx = tabIdx;
        obj.tabType = 'camp';
    }else if(tab == 'task'){
        tabMenu = '<li id="tab_'+tabIdx+'">\n' +
                '   <a title="Task별 고객 이탈 현황 ' + searchPeriod + '" class="active" onclick="statsTabSelect('+tabIdx+',\'task\');">' +
                '       Task별 고객 이탈 현황<span>'+searchPeriod+'</span></a>\n' +
                '   <button type="button" class="btn_close" onclick="statsTabClose('+tabIdx+')">&#215;</button>\n' +
                '</li>';

        obj.tabIdx = tabIdx;
        obj.tabType = 'task';
    } // campDetailPeriod
    tabList.push(obj);
    sessionStorage.tabList = JSON.stringify(tabList);

    $('#tabMenuList').append(tabMenu);
    if(moveType) {
        statsTabSelect(tabIdx, obj.tabType);
    }
}

function statsTabClose(tabIdx){
    let actCheck = true;
    let activeTab = $('#tab_'+tabIdx).index();
    $('#tab_'+tabIdx).remove();
    $('#tabMenuList a').each(function(index, item){
        if($(this).attr('class') == 'active'){
            actCheck = false;
        }
    });

    for(let i=activeTab-1; i<tabList.length; i++){
        tabList[i].tabListIdx = tabList[i].tabListIdx - 1;
    }

    tabList.splice(activeTab-1, 1);
    sessionStorage.setItem('tabList', JSON.stringify(tabList));

    if(actCheck){
        if(activeTab < tabList.length-1){
            $('#tabMenuList a').eq(activeTab).click();
        }else{
            $('#tabMenuList a').eq(tabList.length).click();
        }
    }

}

function statsTabSelect(tabIdx, tabType){
    $('#tabMenuList a').removeClass('active');

    if(tabType == 'main'){
        $('#subStatsTab').empty();
        $('#subStatsTab').hide();
        $('#mainTab').show();
        $('#tabMenuList a').eq(0).addClass('active');
        mainSearchDataSet(mainSearchParam);
        mainSearch();

    } else {
        $('#subStatsTab').show();
        $('#mainTab').hide();
        $('#tabMenuList a').eq($('#tab_'+tabIdx).index()).addClass('active');

        subStatisSubAjax($('#tab_'+tabIdx).index()-1, tabType);
    }

}


function subStatsDateSetting(type, searchObj){
    let obj = [];

    if(searchObj){
        obj = getDateDiffType(searchObj.startDt, searchObj.endDt, false);

        $('#'+ type+'DateType option').hide();
        $.each(obj, function(i, item){
            if(i>1){
                $('#'+ type+'DateType option[value='+item+']').show();
            }
        });

        $('#'+ type+'DateType option[value='+(searchObj.isDateType==undefined?obj[1]:searchObj.isDateType)+']').prop('selected', true);
        formulaSetting(type);
        if(searchObj.isFormula==undefined){
            $('#'+type+'Formula option:eq(0)').prop('selected', true);
        }else{
            $('#'+type+'Formula option[value='+searchObj.isFormula+']').prop('selected', true);
        }

    } else {
        obj = getDateDiffType($('#'+type+'DetailFromDate').val(), $('#'+type+'DetailToDate').val(), false);
        $('#'+ type+'DateType option').hide();
        $.each(obj, function(i, item){
            if(i>1){
                $('#'+ type+'DateType option[value='+item+']').show();
            }
        });

        $('#'+ type+'DateType option[value='+obj[1]+']').prop('selected', true);
        formulaSetting(type);
        $('#'+type+'Formula option:eq(0)').prop('selected', true);
    }
}


function formulaSetting(type){
    $('#'+type+'Formula').prop('disabled', false);
    let formulaList = [];
    let selectVal = $('#'+ type+'DateType').val();

    if(selectVal == 'hourly'){
        $('#'+type+'Formula').prop('disabled', true);
        formulaList = ['sum'];
    } else if (selectVal == 'daily' || selectVal == 'dayOfWeek'){
        formulaList = ['sum'];
    } else if(selectVal == 'weekly'){
        formulaList = ['sum', 'dailyAvg'];
    } else if(selectVal == 'monthly'){
        formulaList = ['sum', 'dailyAvg', 'weeklyAvg'];
    } else if(selectVal == 'yearly'){
        formulaList = ['sum', 'dailyAvg','weeklyAvg','monthlyAvg'];
    }
    $('#'+type+'Formula option').hide();
    $.each(formulaList, function(i, item){
        $('#'+type+'Formula option[value='+item+']').show();
        if(i == 0){
            $('#'+type+'Formula option[value='+item+']').prop('selected', true);
        }
    });
}

function subStatisSubAjax(idx, type){
    let obj = new Object();

    $.ajax({
        url : type+"StatisSub",
        type: "POST",
        contentType: 'application/json',
        beforeSend: function (xhr) {
            xhr.setRequestHeader($('#headerName').val(), $('#token').val());
        },
    }).success(function (result) {
        sendDiffList = [];
        subSearchParam = tabList[idx];
        subSearchParam.tabListIdx = idx;

        $('#subStatsTab').empty();
        $('#subStatsTab').html(result);
    }).error(function (result) {
        console.log(result);
    });
}

function voicebotStatsExcelDownload(){

}