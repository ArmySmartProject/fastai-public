$(document).ready(function () {
    $('#campDetailFromDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#campDetailFromDate').blur();
        $('#campDetailToDate').datepicker( 'setStartDate', $(this).datepicker('getDate'));
        subStatsDateSetting('camp');
    });

    $('#campDetailToDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#campDetailToDate').blur();
        $('#campDetailFromDate').datepicker( 'setEndDate', $(this).datepicker('getDate'));
        subStatsDateSetting('camp');
    });

    $('#campDiffFromDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#campDiffFromDate').blur();
        $('#campDiffToDate').datepicker( 'setStartDate', $(this).datepicker('getDate'));
    });

    $('#campDiffToDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        orientation:'bottom'
    }).on("changeDate", function (){
        $('#campDiffToDate').blur();
        $('#campDiffFromDate').datepicker( 'setEndDate', $(this).datepicker('getDate'));
    });

    $('#campDateType').on('change', function (){
        formulaSetting('camp');
    });

    if(subSearchParam.subCampList == undefined){
        subSearchParam.subCampList = [Number(subSearchParam.campaignId)];
    }

    $('#campDetailPeriod').text(subSearchParam.startDt+'~'+subSearchParam.endDt);
    $('#campDiffLeftPeriod').text(subSearchParam.startDt+'~'+subSearchParam.endDt);
    // let tmpList = getDateDiffType(subSearchParam.startDt, subSearchParam.endDt, true);

    if(subSearchParam.campStartDt == undefined && subSearchParam.campEndDt == undefined){
        $('#campDetailFromDate').datepicker('update', subSearchParam.startDt);
        $('#campDetailToDate').datepicker('update', subSearchParam.endDt);
        $('#campDetailFromDate').datepicker( 'setEndDate', new Date(subSearchParam.endDt));
        $('#campDetailToDate').datepicker( 'setStartDate', new Date(subSearchParam.startDt));
        subStatsDateSetting('camp');
    } else {
        $('#campDetailFromDate').datepicker('update', subSearchParam.campStartDt);
        $('#campDetailToDate').datepicker('update', subSearchParam.campEndDt);
        $('#campDetailFromDate').datepicker( 'setEndDate', new Date(subSearchParam.campEndDt));
        $('#campDetailToDate').datepicker( 'setStartDate', new Date(subSearchParam.campStartDt));
        let tmpObj = {
            startDt : subSearchParam.campStartDt,
            endDt : subSearchParam.campEndDt,
            isDateType : subSearchParam.campDateType,
            isFormula : subSearchParam.campFormula
        }
        subStatsDateSetting('camp', tmpObj);
    }

    if(subSearchParam.diffStartDt != undefined && subSearchParam.diffEndDt != undefined){
        $('#campDiffFromDate').datepicker('update', subSearchParam.diffStartDt);
        $('#campDiffToDate').datepicker('update', subSearchParam.diffEndDt);
        $('#campDiffFromDate').datepicker( 'setEndDate', new Date(subSearchParam.diffEndDt));
        $('#campDiffToDate').datepicker( 'setStartDate', new Date(subSearchParam.diffStartDt));
    }

    campDetailAnalyze();
    campLeftDiffAnalyze();
    subCampListAjax();

    // sub 캠페인 결과 추이 차트 to 엑셀
    $("#btn_download_subchart3").click(function () {
        var tableId = "table_13";
        var isRunning = subSearchParam.isRunning;
        var strTitle = $("#subchart3_title h5").text();
        var strArith = "산식: " + subSearchParam.campFormula;
        var strTerm = "기간: " + subSearchParam.campStartDt + "~" + subSearchParam.campEndDt;
        var strIsrun = "운영상태: " + getRunningState(isRunning);

        generate_table(subchartObj3, tableId, strTitle, strTerm, strIsrun, strArith)
        exportTableToExcel(tableId, getSubExportFileName(strTitle))
    })

    // sub 캠페인 결과 비교 테이블 to 엑셀
    $("#btn_download_table2").click(function () {
        var tableId = "comparison_result_campaign";
        var isRunning = subSearchParam.isRunning;
        // var strTitle = $(this).parent().prev().text();
        var strTitle = $(this).parent().prev().text().split('\n')[0];
        var strCompareTerm = $("#campDiffPeriod").text();
        var strTerm = subSearchParam.startDt + "~" + subSearchParam.endDt;
        var strIsrun = getRunningState(isRunning);
        addPrefix(16, tableId, strTitle, strTerm, strCompareTerm, strIsrun);
        exportExcel(tableId, getSubExportFileName(strTitle));
        removePrefix(tableId);
    })

});

function campDetailAnalyze(){
    if($('#campDetailFromDate').val() != '' && $('#campDetailToDate').val() != ''){
        let tmpObj = getDateDiffType($('#campDetailFromDate').val(), $('#campDetailToDate').val(), true);
        let campObj = {
            campaignId : subSearchParam.campaignId,
            isInbound : subSearchParam.isInbound,
            isRunning : subSearchParam.isRunning,
            opStartTm : subSearchParam.opStartTm,
            opEndTm : subSearchParam.opEndTm,
            startDt : tmpObj[0],
            endDt : $('#campDetailToDate').val(),
            isDateType : $('#campDateType').val(),
            isFormula : $('#campFormula').val()
        };

        $.ajax({
            url : "getCampaignResultDetailChart",
            data : JSON.stringify(campObj),
            type: "POST",
            contentType: 'application/json',
            beforeSend: function (xhr) {
                xhr.setRequestHeader($('#headerName').val(), $('#token').val());
            },
        }).success(function (result) {
            subSearchParam.campStartDt = $('#campDetailFromDate').val();
            subSearchParam.campEndDt = $('#campDetailToDate').val();
            subSearchParam.campDateType = $('#campDateType').val();
            subSearchParam.campFormula = $('#campFormula').val();

            tabList[subSearchParam.tabListIdx] = subSearchParam;
            sessionStorage.tabList = JSON.stringify(tabList);

            subchartObj3 = result;

            $('#campSubStatsChart').remove();
            $("#campSubStatsDiv").append('<canvas id="campSubStatsChart"></canvas>');
            draw_chart('campSubStatsChart', get_line_chart_data(result, 'sub'));
        }).error(function (result) {
            console.log(result);
        });
    } else {
        alert('검색 기간을 선택해 주세요.');
    }
}

function subCampListAjax(){
    let obj = { campaignNm : '' };

    $.ajax({
        url : "getVoiceStatCampaignList",
        data : JSON.stringify(obj),
        type: "POST",
        contentType: 'application/json',
        beforeSend: function (xhr) {
            xhr.setRequestHeader($('#headerName').val(), $('#token').val());
        },
    }).success(function(result){
        subCampList = result.data;
        if(subCampDatatable != null){
            subCampDatatable.destroy();
        }

        subCampaignDatatable();
        let campListNm = '';
        $.each(subCampDatatable.rows().data(), function(i, item){
            if(subSearchParam.subCampList.indexOf(item.campaignId) > -1){
                campListNm += item.campaignNm+' && ';
            }
        });
        $('#subCampSearch').val(campListNm.slice(0,campListNm.length-4));

    }).error(function (result){
        console.log(result);
    });
}

function subCampaignDatatable(){
    subCampDatatable = $("#subCampListTable").DataTable({
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
        data: subCampList, //참조 data
        columns: [
            {
                data: null,
                title: '', // 캠페인 아이디 체크 박스
                searchable: false,
                className: 'text-center',
                sortable:false,
                render: function (data, type, row, meta) {
                    let el = '<input type="checkbox" name="checkCampaign" id="check_'+data.campaignId+'" class="type_check">\n' +
                            '<label for="check_'+data.campaignId+'" class="label_check" style="width: 17px; height: 17px;" onclick="event.stopPropagation();"></label>';
                    return el;
                }
            },
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
                className: 'text-center',
                searchable: false,
            },
            {
                data: 'useYn',
                name: 'useYn',
                className: 'text-center',
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
    subCampDatatable.draw();
}

function subCampSelect(){
    let list = subCampDatatable.rows(".active").data();
    if(list.length == 0){
        alert('캠페인을 선택해 주세요.');
    }else{
        let campList = [];
        let campListNm = '';
        for(let i = 0; i<list.length; i++){
            campList.push(Number(list[i].campaignId));
            campListNm += list[i].campaignNm+" && ";
        }
        $('#subCampSearch').val(campListNm.slice(0,campListNm.length-4));
        subSearchParam.subCampList = campList;
        hidePopup('campaign_sub_search');
        campLeftDiffAnalyze();
    }
}

function subCampSearchCheck(){
    let campSearch = $('#subCampSearch').val();
    let noMatchCamp = '';
    let campSearchList = [];

    if(campSearch == ''){
        $('#subCampListTable tr').removeClass('active');
        $('#subCampListTable input[type=checkbox]').prop('checked', false);
    }else{
        campSearchList = campSearch.split('&&')
                                .map(function (item){ return item.trim(); })
                                .filter(function (el){ return el != ''; });
        console.log('campSearchList', campSearchList);

        let campList = [];
        let campIdList = [];

        if(campSearchList.length > 5){
            alert('캠페인은 5개 이하로 입력해주세요.');
        }else{
            $('#subCampListTable tr').removeClass('active');
            $('#subCampListTable input[type=checkbox]').prop('checked', false);

            $.each(campSearchList, function (j, jtem){
                $.each(subCampDatatable.rows().data(), function (i, item){
                    if(jtem == item.campaignNm){
                        campList.push(item.campaignNm);
                        campIdList.push(item.campaignId);
                        $('#subCampListTable tr').eq(i+1).click();
                    }
                });
            });

            if(campIdList.length != campSearchList.length){
                $.each(campSearchList, function(i, item){
                   if(campList.indexOf(item) < 0){
                       noMatchCamp += item + ' && ';
                   }
                });
            }

            subSearchParam.subCampList = campIdList.length > 0 ? campIdList : subSearchParam.subCampList;
        }

    }

    let obj = {
        list: campSearchList,
        noMatchCamp:noMatchCamp.slice(0, noMatchCamp.length-4)
    };

    return obj;
}

function campSubSearch(popOpen){
    let obj = subCampSearchCheck();

    if(obj.noMatchCamp == ''){
        if(popOpen){ // 돋보기 클릭
            openPopup('campaign_sub_search');
        }else{ // 엔터 & 분석
            campLeftDiffAnalyze();
        }
    }else{
        if(!popOpen){
            alert('일치 하지 않는 캠페인이 있습니다. (' +obj.noMatchCamp+')');
        }
        openPopup('campaign_sub_search');
    }
}




function campLeftDiffAnalyze(){
    let leftDiffObj = {
        campaignIdList : subSearchParam.subCampList,
        isRunning : subSearchParam.isRunning,
        startDt : subSearchParam.startDt,
        endDt : subSearchParam.endDt
    };

    $.ajax({
        url : "getCampaignResultDetailDiff",
        data : JSON.stringify(leftDiffObj),
        type: "POST",
        contentType: 'application/json',
        beforeSend: function (xhr) {
            xhr.setRequestHeader($('#headerName').val(), $('#token').val());
        },
    }).success(function (result) {
        let list = result;
        let html = "";

        $.each(subSearchParam.subCampList, function(j, jtem){
            $.each(list, function (i, item){

                if(item.campaignId == jtem){
                    html += "<tr id='camp_"+item.campaignId+"'>";
                    html += "    <td style='text-align:center;'>"+item.campaignNm+"</td>";
                    html += "    <td>"+item.targetCount+"</td>";
                    html += "    <td>"+item.dialSuccessCount+"</td>";
                    html += "    <td>"+item.dialTryCount+"</td>";
                    html += "    <td>"+item.callSuccessCount+"</td>";
                    html += "    <td>"+item.campaignSuccessCount+"</td>";

                    html += "    <td>"+item.targetPercent.replace('NaN', '0.0')+"</td>";
                    html += "    <td>"+item.dialPercent.replace('NaN', '0.0')+"</td>";
                    html += "    <td>"+item.callPercent.replace('NaN', '0.0')+"</td>";

                    html += "    <td></td> <td></td> <td></td> <td></td> <td></td>";
                    html += "    <td></td> <td></td> <td></td>";
                    html += "</tr>";
                }
            });
        });


        $('#campDiffTable tbody').empty();
        $('#campDiffTable tbody').append(html);


        if($('#campDiffFromDate').val() != '' && $('#campDiffToDate').val() != ''){
            campDiffAnalyze();
        }else{
            tabList[subSearchParam.tabListIdx] = subSearchParam;
            sessionStorage.tabList = JSON.stringify(tabList);
        }

    }).error(function (result) {
        console.log(result);
    });
}

function campDiffAnalyze(){
    if($('#campDiffFromDate').val() != '' && $('#campDiffToDate').val() != ''){
        let campList = subSearchParam.subCampList;

        if(campList.length > 0){
            let diffObj = {
                campaignIdList : campList,
                isRunning : subSearchParam.isRunning,
                startDt : $('#campDiffFromDate').val(),
                endDt : $('#campDiffToDate').val()
            };
            console.log("diffObj",diffObj);
            $.ajax({
                url : "getCampaignResultDetailDiff",
                data : JSON.stringify(diffObj),
                type: "POST",
                contentType: 'application/json',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader($('#headerName').val(), $('#token').val());
                },
            }).success(function (result) {
                console.log(result);

                $('#campDiffPeriod').text($('#campDiffFromDate').val()+'~'+$('#campDiffToDate').val());
                $.each(result, function (i, item){

                    $('#camp_'+item.campaignId).find('td').eq(9).text(item.targetCount);
                    $('#camp_'+item.campaignId).find('td').eq(10).text(item.dialSuccessCount);
                    $('#camp_'+item.campaignId).find('td').eq(11).text(item.dialTryCount);
                    $('#camp_'+item.campaignId).find('td').eq(12).text(item.callSuccessCount);
                    $('#camp_'+item.campaignId).find('td').eq(13).text(item.campaignSuccessCount);

                    $('#camp_'+item.campaignId).find('td').eq(14).text(item.targetPercent.replace('NaN', '0.0'));
                    $('#camp_'+item.campaignId).find('td').eq(15).text(item.dialPercent.replace('NaN', '0.0'));
                    $('#camp_'+item.campaignId).find('td').eq(16).text(item.callPercent.replace('NaN', '0.0'));
                });

                subSearchParam.diffStartDt = $('#campDiffFromDate').val();
                subSearchParam.diffEndDt = $('#campDiffToDate').val();

                tabList[subSearchParam.tabListIdx] = subSearchParam;
                sessionStorage.tabList = JSON.stringify(tabList);
            }).error(function (result) {
                console.log(result);
            });
        }else{
            alert("캠페인을 선택해주세요.");
        }
    } else {
        alert('검색 기간을 선택해 주세요.');
    }
}