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
</head>

<body>
<!-- .page loading -->
<div id="pageldg">
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
<div id="wrap">
	<jsp:include page="../common/inc_header.jsp">
	    <jsp:param name="titleCode" value="A0920"/>
	    <jsp:param name="titleTxt" value="O/B 예약콜 관리"/>
	</jsp:include>
    <!-- #container -->
    <div id="container">
    	<input type="hidden" id="cPage" value="1"/>
    	<input type="hidden" id="cPageLayer" value="1"/>
    	<input type="hidden" id="cdHistoryId" value=""/>
		<input type="hidden" id="headerName" value="${_csrf.headerName}" />
		<input type="hidden" id="token" value="${_csrf.token}" />
        <div id="contents">
            <!-- .content -->
            <div class="content">
                <div class="titArea" style="padding: 20px 0 0 0;">
                    <dl class="fl">
                        <dt>Campaign</dt>
                        <dd>
                            <select class="select" id="campaignIdSelect" onchange="changeCampaign();">
                            </select>
                        </dd>
                    </dl>
                </div>

                <!-- 검색조건 -->
                <div class="srchArea">
                    <table class="tbl_line_view" summary="검색일자,고객조회,유형검색,DB별 최종 값 기준으로 구성됨">
                        <caption class="hide">검색조건</caption>
                        <colgroup>
                            <col width="100"><col><col width="100"><col><col width="100">
                            <col><col width="100"><col>
                            <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                        </colgroup>
                        <tbody>
                        <tr>
                            <th scope="row">검색일시</th>
                            <td>
                                <div class="iptBox">
                                    <input type="text" name="fromDate" id="fromDate" class="ipt_dateTime" autocomplete="off">
                                    <span>-</span>
                                    <input type="text" name="toDate" id="toDate"  class="ipt_dateTime" autocomplete="off">
                                </div>
                            </td>
                            <th>예약콜명</th>
                            <td>
                                <div class="iptBox">
                                    <input type="text" class="ipt_txt" id="reservationName" autocomplete="off">
                                </div>
                            </td>
<!--                             <th>수정인</th> -->
<!--                             <td> -->
<!--                                 <div class="iptBox"> -->
<!--                                     <input type="text" class="ipt_txt" autocomplete="off"> -->
<!--                                 </div> -->
<!--                             </td> -->
                            <th>상태</th>
                            <td>
                                <!-- [D] 진행중, 진행완료 -->
                                <select id="multiple_select02" class="select">
                                	<option value="all">전체</option>
                                    <option value="ing">진행중</option>
                                    <option value="end">진행완료</option>
                                </select>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="btnBox sz_small line">
                        <button type="button" class="btnS_basic" id="search">검색</button>
                    </div>
                </div>
                <!-- //검색조건 -->

                <!-- .jqGridBox -->
                <!-- <a href="#lyr_statCallReservation" class="btnS_line btn_lyr_open">call 수정</a> -->
                <div class="jqGridBox" style="box-shadow: none;">
<!--                     <div class="btnBox sz_small" style="background: #dce1ea;"> -->
<!--                         <div class="fl"> -->
<!--                             <button type="button" class="btnS_basic btn_clr">삭제</button> -->
<!--                         </div> -->
<!--                     </div> -->

                    <table id="jqGrid"></table>
                    <div id="jqGridPager"></div>
                </div>
                <!-- //.jqGridBox -->


            </div>
            <!-- //.content -->
        </div>
    </div>
    <!-- //#container -->

    <hr>

    <!-- #footer -->
    <div id="footer">
        <div class="cyrt"><span>&copy; MINDsLab. All rights reserved.</span></div>
    </div>
    <!-- //#footer -->
</div>
<!-- //#wrap -->

<!-- 추가 200715 예약콜 이력 -->
<div id="lyr_statCallReservation" class="lyrBox">
    <div class="lyr_top">
        <h3>예약콜 이력</h3>
        <button class="btn_lyr_close">닫기</button>
    </div>

    <div class="lyr_mid" style="max-height: 655px;">
        <!-- 검색조건 -->
        <div class="srchArea">
            <button type="button" class="btnS_line tbody_folding_toggle">상세 보기</button>
            <table class="tbl_line_view" summary="검색일시/총응대시간/제외여부/음성봇명/상담유형/회선번호/상담사/고객명/통화시간/봇,상담사 응대시간/대화이력으로 구성됨">
                <caption class="hide">검색조건</caption>
                <colgroup>
                    <col width="100"><col><col width="100"><col><col width="100">
                    <col>
                    <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                </colgroup>
                <tbody>
                    <tr class="tr_title">
                        <th class="hide">분류</th>
                        <td colspan="6">예약콜</td>
                    </tr>
                    <tr>
                        <th>예약콜명</th>
                        <td>
                            <div class="iptBox">
                                <span class="view_txt" id="cdName"></span>
                            </div>
                        </td>
                        <th>상세설명</th>
                        <td colspan="3">
                            <div class="iptBox">
                                <span class="view_txt" id="cdDesc"></span>
                            </div>
                        </td>
                    </tr>

                    <tr class="tr_title">
                        <th class="hide">검색 상세 분류</th>
                        <td colspan="6">발송대상</td>
                    </tr>
                    <tr>
                        <th>시도횟수</th>
                        <td>
                            <div class="iptBox">
                                <span class="view_txt" id="callTryCount"></span>
                            </div>
                        </td>
                        <th>상태</th>
                        <td colspan="3">
                            <div class="iptBox">
                                <span class="view_txt" id="callStatus"></span>
                            </div>
                        </td>
                    </tr>
                </tbody>

                <tbody class="tbody_folding hide">
                </tbody>
            </table>
        </div>
        <!-- //검색조건 -->

        <!-- .jqGridBox -->
        <div class="jqGridBox" style="box-shadow: none;">
            <div class="btnBox sz_small" style="background: #f8f8fb">
                <div class="fr">
                    <button type="button" class="btnS_line btn_refresh" onclick="searchRefresh();">새로고침</button>
                </div>
            </div>
            <table id="jqGrid_layer"></table>
            <div id="jqGridPager_layer"></div>
        </div>
        <!-- //.jqGridBox -->
    </div>
    <!-- //lyr_mid -->
</div>
<!-- //예약콜 관리 -->
    
<%@ include file="../common/inc_footer.jsp"%>
    
<!-- page Landing -->  
<script type="text/javascript">
$(window).load(function() { 
    //page loading delete  
	$('#pageldg').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });
}); 
</script> 
<!-- script -->  
<script type="text/javascript">
var lang = $.cookie("lang");
jQuery.event.add(window,"load",function(){
	$(document).ready(function (){
        // GCS iframe
        $('.gcsWrap', parent.document).each(function(){            
            //header 화면명 변경
            var pageTitle = $('title').text().replace('> FAST AICC', '');
            
            $(top.document).find('#header h2 a').text(pageTitle); 
        });
		
     	// 캠페인 리스트 불러오기
        getObReservationCampaignList();
        
        //datetimepicker
        if(lang == "ko" || lang == null){
    		//datetimepicker
    		$('#fromDate').datetimepicker({
    			language : 'ko', // 화면에 출력될 언어를 한국어로 설정합니다.
    			pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
    			defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
    			autoclose: 1,
    			endDate: $("#toDate").val()
    		}).on('changeDate', function(selectedDate){
    			$("#toDate").datetimepicker('setStartDate',selectedDate.date);
    		});
    	
    		$('#toDate').datetimepicker({
    			language : 'ko', // 화면에 출력될 언어를 한국어로 설정합니다.
    			pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
    			defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
    			autoclose: 1,
    			startDate: $("#fromDate").val()
    		}).on('changeDate', function(selectedDate){
    			$("#fromDate").datetimepicker('setEndDate',selectedDate.date);
    		});
    	}else if(lang == "en"){
    		//datetimepicker
    		$('#fromDate').datetimepicker({
    			language : 'en', // 화면에 출력될 언어를 한국어로 설정합니다.
    			pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
    			defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
    			autoclose: 1,
    			endDate: $("#toDate").val()
    		}).on('changeDate', function(selectedDate){
    			$("#toDate").datetimepicker('setStartDate',selectedDate.date);
    		});

    		$('#toDate').datetimepicker({
    			language : 'en', // 화면에 출력될 언어를 한국어로 설정합니다.
    			pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
    			defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
    			autoclose: 1,
    			startDate: $("#fromDate").val()
    		}).on('changeDate', function(selectedDate){
    			$("#fromDate").datetimepicker('setEndDate',selectedDate.date);
    		});
    	}
        
        //AMR 검색 박스 테이블 접기/펴기
        $('.tbody_folding_toggle').on('click', function(){
            setTimeout($('.tbody_folding').toggleClass('hide'), 100);
        })
		
        createJqGrid();
        createJqGridLayer();
		scResize();
		$("#search").on("click", function(){
			$("#cPage").val(1);
			$.jgrid.gridUnload('#jqGrid');
			createJqGrid();
			gridSearch(1);
		});
		
        // 추가 AMR 200713 .card_type 안에 있는 전체선택 checkbox를 클릭하면 전체선택 및 해제가 된다
        $('.card_type .ipt_checkbox_allCheck').on('click',function(){	
            var iptCheckboxAllCheck = $(this).is(":checked");
            if ( iptCheckboxAllCheck ) {
                $(this).parents('.card_type').find('input:checkbox').prop('checked', false);
                $(this).parents('.card_type').find('input:checkbox').prop('checked', true);
            } else {
                $(this).parents('.card_type').find('input:checkbox').prop('checked', false);
            }
        });

        //추가 AMR 200715 multiple_select
        $('#multiple_select01').multiselect({
          includeSelectAllOption: true,
        });
	});
});	
        
        
        
function scResize() {
	var resizeWidth = $('.jqGridBox').width()-1; //jQuery-ui의 padding 설정 및 border-width값때문에 넘치는 걸 빼줌.
	var titAreaHeight = $("#container .titArea").outerHeight(true);
	var searchBoxHeight = $("#container .srchArea").innerHeight();
	var gridSubHeight = $(".jqGridBox").outerHeight(true) - parseInt($(".ui-jqgrid-bdiv").css("height"));
	var resizeHeight = $("#container").height()  - searchBoxHeight - titAreaHeight - gridSubHeight -40; // 전체 container높이 - 검색박스높이 - 그리드(헤더,페이지,margin)높이

	// 그리드의 width를 div 에 맞춰서 적용
	$('#jqGrid').setGridWidth( resizeWidth , true); //Resized to new width as per window. 
	$('#jqGrid').setGridHeight( resizeHeight , true);
	$('#jqGrid').css("width", '');
}

function getObReservationCampaignList() {
	var param = {companyId:$("#campaignIdSelect option:selected").val()};
	$.ajax({url : "${pageContext.request.contextPath}/getObReservationCampaignList",
		data : JSON.stringify(param),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		var html = "";
		if(result != null && result.length > 0){
			for(var i = 0; i < result.length; i++) {
				html += "<option value='" + result[i].campaignId + "'>" + result[i].campaignNm + "</option>"
			}
			
		}
		
		$("#campaignIdSelect").html(html);
		createJqGrid();
        gridSearch(1,"N");
		
	}).fail(function(result) {
		console.log("ajax connection error: getObReservationCompanyIdList");
	});
}

function createJqGrid(){
	
	var gridOption = {
			url: "${pageContext.request.contextPath}/getCallReservationRecordList",
			datatype: "local",
			mtype: "POST",
			ajaxGridOptions: { contentType: "application/json" },
			loadBeforeSend: function(jqXHR) {
				jqXHR.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
			},
            colNames:[
//             		  'checkbox'
            		  'NO.'
            		, '예약콜명'
            		, '상세설명'
            		, '예약일시'
            		, '콜 시작시간'
            		, '성공건수'
            		, '실패건수'
            		, '상태 (진행 콜수/총 콜수)'
            		, '보기'
            ],
            colModel:[
//                 {name:'checkbox', index:'checkbox', width: 40, align:'center', sortable: false, formatter:addCheckbox},
				{name:'RNUM', index:'RNUM', width: 30, align:'center', sortable: false},
				{name:'cdName', index:'cdName', align:'center', sortable: false},
				{name:'cdDesc', index:'cdDesc', align:'center', sortable: false},
                {name:'reservationDate', index:'reservationDate', width: 200, align:'center', sortable: false, formatter:reservationDate},

                {name:'callTime', index:'callTime', align:'center', sortable: false},
                // {name:'madeCallNum', index:'madeCallNum', align:'center'},
                {name:'successCnt', index:'successCnt', align:'center', sortable: false},
				{name:'failCnt', index:'failCnt', align:'center', sortable: false},

                {name:'callStatus', index:'callStatus', align:'center', sortable: false, formatter:callStatus},
                {name:'viewMode', index:'viewMode', width:70, align:'center', sortable: false, formatter:addButton}
            ],
            pager: "#jqGridPager",
            rowNum: 30,
            height: 'auto',
            height: 600,
            viewrecords: true,
            sortname: 'name',
            grouping:true,
            jsonReader : { 
            	repeatitems: false,
            	page: "page",    // 현제 페이지, 하단의 navi에 출력됨.
                total: "total",    // 총 페이지 수
                records: "records",
                root: "rows",
            }, 
			onPaging: function(pgButton){	 //페이징 처리
				var gridPage = $("#jqGrid").getGridParam("page");				// 현재 페이지 번호
				var rowNum = $("#jqGrid").getGridParam("rowNum");				// 뿌려줄 row 개수
				var records = $("#jqGrid").getGridParam("records");				// 현재 레코드 갯수
				var totalPage = Math.ceil(records/rowNum);						// 토탈갯수
				
				if (pgButton == "next") {
					if (gridPage < totalPage) {
						gridPage += 1;
					} else {
						gridPage = page;
					}
				} else if (pgButton == "prev") {
					if (gridPage > 1) {
						gridPage -= 1;
					} else {
						gridPage = page;
					}
				} else if (pgButton == "first") {
					gridPage = 1;
				} else if (pgButton == "last") {
					gridPage = totalPage;
				} else if (pgButton == "user") {
					var nowPage = Number($("pager .ui-pg-input").val());
					
					if (totalPage >= nowPage && nowPage > 0) {
						gridPage = nowPage;
					} else {
						$("#pager .ui-pg-input").val(page);
						gridPage = page;
					}
				} else if (pgButton == "records") {
					gridPage = 1;
				}
				
				$("#cPage").val(gridPage);
				gridSearch(gridPage, "N");
			},
            loadComplete : function(data) {
                $(".ui-pg-input").attr("readonly", true);

                $('.btn_lyr_open').on('click',function(e){
                    var winHeight = $(window).height()*0.7,
                        hrefId = $(this).attr('href');

                    // 추가 AMR 200713 checkbox가 해제되는걸 막기위한 코드
                    e.stopPropagation();

                    $('body').css('overflow','hidden');
                    $('body').find(hrefId).wrap('<div class="lyrWrap"></div>');
                    $('body').find(hrefId).before('<div class="lyr_bg"></div>');

                    //대화 UI
                    $('.lyrBox .lyr_mid').each(function(){
                        $(this).css('max-height', Math.floor(winHeight) +'px');
                    });
                    //Layer popup close
                    $('.btn_lyr_close, .lyr_bg').on('click',function(){
                    $(".player").empty();
                    $('body').css('overflow','');
                    $('body').find(hrefId).unwrap();
                    //'<div class="lyrWrap"></div>'
                    $('.lyr_bg').remove();
                    });
                });

                // 추가 AMR 200710 jqGrid 내 th (name: checkbox)를 체크박스 태그로 수정
                $('#jqgh_jqGrid_checkbox').html('<div class="checkBox"><input type="checkbox" id="total_chk" class="ipt_jqCheckbox_allCheck"><label for="total_chk"></label></div>'
                )

                // 수정 AMR 200713 jqGridBox table th안에 있는 전체선택 checkbox를 클릭하면 전체선택이 된다
                $('.ipt_jqCheckbox_allCheck').on('click',function(){	
                    var iptCheckboxAllCheck = $(this).is(":checked");

                    if ( iptCheckboxAllCheck ) {
                        // jqgrid bdiv에 있는 모든 checkbox 를 체크한다
                        $(this).parents('.jqGridBox').find('.ui-jqgrid-bdiv tr').addClass('active');
                        $(this).parents('.jqGridBox').find('.ui-jqgrid-bdiv input:checkbox').prop('checked', true);

                        // jqgrid bdiv에 있는 tr.disabled 는 체크해제한다
                        $(this).parents('.jqGridBox').find('.ui-jqgrid-bdiv tr.disabled input:checkbox').prop('checked', false);
                    } else {
                        // jqgrid bdiv에 있는 모든 checkbox 를 체크해제한다
                        $(this).parents('.jqGridBox').find('.ui-jqgrid-bdiv tr').removeClass('active');
                        $(this).parents('.jqGridBox').find('.ui-jqgrid-bdiv input:checkbox').prop('checked', false); 
                    } 
                });


                // 추가 AMR 200713 jqGridBox table tr을 클릭하면 row가 선택된다
                $('.ui-jqgrid-bdiv tr').on('click', function(){
                    if( $(this).hasClass('disabled') ) {
                        return;
                    }
                    $(this).toggleClass('active');

                    if ( $(this).hasClass('active') ) {
                        $(this).find('input:checkbox').prop('checked', true);
                    } else {
                        $(this).find('input:checkbox').prop('checked', false);
                    }
                })
                scResize();
            }
	}
	
	$('.ipt_jqCheckbox_allCheck').parent().parent().removeClass('ui-jqgrid-sortable');
	
	$("#jqGrid").jqGrid(gridOption);
	scResize();
	
}

//추가 유라 김가영매니저님 jqGrid 내 버튼 추가 
function addButton(cellValue, options, rowdata, action){
	var buttonHtml = '<button type="button" class="btnS_line btn_lyr_open" onclick= showReservationDetail("'+rowdata.autoCallCdCustomIds+'",'+rowdata.campaignId+','+rowdata.id+','+rowdata.ingCall+','+rowdata.totalCall+');>보기</button>';
    return buttonHtml;
}

// 추가 AMR 200710 jqGrid td 내 체크박스 추가
// [D] AMR input:checkbox는 리스트 갯수에 따라 id,name 값 다르게 선언해야 합니다
// [D] AMR label for 값은 input id값과 동일 해야합니다
function addCheckbox(){
    var checkboxHtml = '<div class="checkBox"><input type="checkbox" id="checkbox1" class="ipt_jqCheckbox"><label for="checkbox1"></label></div>';
    return checkboxHtml;
}

function scenarioResult(cellValue, options, rowdata, action){
	var scenarioResultHtml = '';
	if(rowdata.scenarioResult == "Y"){
		scenarioResultHtml = '<span class="call_status color_guide_success">SUCCESS</span>';
	}else if(rowdata.scenarioResult == "N"){
		scenarioResultHtml = '<span class="call_status color_guide_warning">FAIL</span>';
	}else {
		scenarioResultHtml = '<span class="call_status color_guide_warning">-</span>';
	}
	return scenarioResultHtml;
}

function reservationDate(cellValue, options, rowdata, action) {
	
	var weekDayArr = new Array();
	var weekDay = "";
	
	for(var i in rowdata.weekDay){
		if(rowdata.weekDay.split(",")[i] == "1"){
			weekDay = "일";
			weekDayArr.push(weekDay);	
		}else if(rowdata.weekDay.split(",")[i] == "2"){
			weekDay = "월";
			weekDayArr.push(weekDay);
		}else if(rowdata.weekDay.split(",")[i] == "3"){
			weekDay = "화";
			weekDayArr.push(weekDay);
		}else if(rowdata.weekDay.split(",")[i] == "4"){
			weekDay = "수";
			weekDayArr.push(weekDay);
		}else if(rowdata.weekDay.split(",")[i] == "5"){
			weekDay = "목";
			weekDayArr.push(weekDay);
		}else if(rowdata.weekDay.split(",")[i] == "6"){
			weekDay = "금";
			weekDayArr.push(weekDay);
		}else if(rowdata.weekDay.split(",")[i] == "7"){
			weekDay = "토";
			weekDayArr.push(weekDay);
		}
	}
	 
	var reservationDate = rowdata.startDtm + " ~ " + rowdata.endDtm +"<br>" + "(" + weekDayArr + ")" + "&nbsp"+rowdata.dispatchTime;
	return reservationDate;
}

function callStatus(cellValue, options, rowdata, action){
	
	var callCnt = "";
	if(rowdata.totalCall == rowdata.ingCall){
		callCnt = "<span class='call_status color_guide_success'>진행완료 <em class='stat_call'>( " + rowdata.ingCall + "/" + rowdata.totalCall + " )</em></span>";
	}else{
		callCnt = "<span class='call_status color_guide_warning'>진행중 <em class='stat_call'>( " + rowdata.ingCall + "/" + rowdata.totalCall + " )</em></span>";
	}
	
	return callCnt;
}

function changeCampaign(){
	createJqGrid();
	gridSearch(1,"N");
}

function gridSearch(currentPage, excelYn) {

	var obj = new Object();
	
	obj.campaignId = $("#campaignIdSelect option:selected").val();
	obj.cdName = $("#reservationName").val();
	obj.toDate =  $("#toDate").val();
	obj.fromDate = $("#fromDate").val();
	obj.callStatus = $("#multiple_select02").val();
	
	if(excelYn != "Y"){
		obj.page = currentPage; // current page 
		obj.lastpage =  $('#jqGrid').getGridParam('lastpage'); // current page 
		obj.rowNum = jQuery("#jqGrid").getGridParam('rowNum'); //페이지 갯수
		obj.allRecords = jQuery("#jqGrid").getGridParam('records'); 
		obj.endPageCnt = jQuery("#jqGrid").getGridParam('rowNum');//마지막페이지 cnt
		obj.offset = (obj.page * obj.rowNum)-obj.rowNum;
	}
	
	if(excelYn == "Y"){
		$("#jqGrid_excel").jqGrid("clearGridData", true);
		$("#jqGrid_excel").setGridParam({loadComplete:excelFn.fn, loadonce : true, datatype:"json",postData	: JSON.stringify(obj)}).trigger("reloadGrid");
	}else{
		$("#jqGrid").setGridParam({loadonce:false, datatype	: "json",postData	: JSON.stringify(obj)}).trigger("reloadGrid");
	}
}

function showReservationDetail(autoCallCdCustomIds, campaignId, id, ingCall, totalCall){
	//상세보기 상태부분
	if(ingCall == totalCall){
		$("#callStatus").text("진행완료");
	}else{
		$("#callStatus").text("진행중");
	}
	
	
	var obj = new Object();
	
	obj.autoCallConditionCustomIds = autoCallCdCustomIds;
	obj.campaignId = campaignId;
	obj.id = id;
	
	$.ajax({
		url : "${pageContext.request.contextPath}/getStatusReservationDetail",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		
		var custDataValue = result.custDataValue;
		var statusReservationInfo = result.statusReservationInfo;
		
		if(statusReservationInfo[0].cdName == null || statusReservationInfo[0].cdName == ""){
			$(".iptBox").find("#cdName").text("-");
		}else{
			$(".iptBox").find("#cdName").text(statusReservationInfo[0].cdName);
		}
		
		if(statusReservationInfo[0].cdDesc == null || statusReservationInfo[0].cdDesc == ""){
			$(".iptBox").find("#cdDesc").text("-");
		}else{
			$(".iptBox").find("#cdDesc").text(statusReservationInfo[0].cdDesc);
		}
		
		
		var innerHtml = "";
		
		for(var i = 0; i < custDataValue.length; i++){
			if(custDataValue[i].columnKor == "시도횟수"){
				$("#callTryCount").text(custDataValue[i].dataValue);
			}else if(custDataValue[i].columnKor == "대상상태"){
				
			}else{
				if((i % 3) == 0){
					innerHtml += "<tr>";
				}
					innerHtml +="<th>"+custDataValue[i].columnKor+"</th>";
					innerHtml +="<td>";
					innerHtml +="<div class='iptBox'>";
					innerHtml +="<span class='view_txt'>"+custDataValue[i].dataValue+"</span>";
					innerHtml +="</div>";
					innerHtml +="</td>";
					
				if((i % 3) == 2){
					innerHtml += "</tr>";
				}
			}
			
		}
		
		$(".tbody_folding").empty();
		$(".tbody_folding").append(innerHtml);
		$("#cdHistoryId").val(id);
		createJqGridLayer();
		gridLayerSearch(1, 'N', id);
		openPopup("lyr_statCallReservation");
	}).fail(function(result) {
		console.log("ajax connection error: getObReservationCompanyIdList");
	});
	
}

function createJqGridLayer(){
	
    // 추가 AMR jqGrid (레이어)
	var gridLayerOption = {
		
    	url: "${pageContext.request.contextPath}/getReservationStatsCust",
        datatype: "local",
		mtype: "POST",
		ajaxGridOptions: { contentType: "application/json" },
		loadBeforeSend: function(jqXHR) {
			jqXHR.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
		},
        colNames:['NO.', '이름', '전화번호', '콜 시작시간', '통화시간', 
        '상태', '안내결과', '통화결과','비고'
        ],
        colModel:[
			{name:'RNUM', index:'RNUM', width: 40, align:'center', sortable: false},
			{name:'custNm', index:'custNm', align:'center', sortable: false},
			{name:'custTelNo', index:'custTelNo', align:'center', sortable: false},
            {name:'callDate', index:'callDate', align:'center', sortable: false},
            {name:'duration', index:'duration', align:'center', sortable: false},
            
			{name:'callPlan', index:'callPlan', align:'center' , sortable: false, formatter:callPlan},
            {name:'scenarioResult', index:'scenarioResult', align:'center', sortable: false, formatter:scenarioResult},
            {name:'callStats', index:'callStats', align:'center', sortable: false , formatter:callStats},
			{name:'callMemo', index:'callMemo', align:'center', sortable: false},
        ],
        autowidth: true,
        height: 'auto',
        rowNum: 30,
        pager: "#jqGridPager_layer",
        height: 580,
        viewrecords: true,
        grouping:true,
        jsonReader : { 
        	repeatitems: false,
        	page: "page",    // 현제 페이지, 하단의 navi에 출력됨.
            total: "total",    // 총 페이지 수
            records: "records",
            root: "rows",
        }, 
		onPaging: function(pgButton){	 //페이징 처리
			var gridPage = $("#jqGrid_layer").getGridParam("page");				// 현재 페이지 번호
			var rowNum = $("#jqGrid_layer").getGridParam("rowNum");				// 뿌려줄 row 개수
			var records = $("#jqGrid_layer").getGridParam("records");				// 현재 레코드 갯수
			var totalPage = Math.ceil(records/rowNum);						// 토탈갯수
			
			if (pgButton == "next") {
				if (gridPage < totalPage) {
					gridPage += 1;
				} else {
					gridPage = page;
				}
			} else if (pgButton == "prev") {
				if (gridPage > 1) {
					gridPage -= 1;
				} else {
					gridPage = page;
				}
			} else if (pgButton == "first") {
				gridPage = 1;
			} else if (pgButton == "last") {
				gridPage = totalPage;
			} else if (pgButton == "user") {
				var nowPage = Number($("pager .ui-pg-input").val());
				
				if (totalPage >= nowPage && nowPage > 0) {
					gridPage = nowPage;
				} else {
					$("#pager .ui-pg-input").val(page);
					gridPage = page;
				}
			} else if (pgButton == "records") {
				gridPage = 1;
			}
			
			$("#cPageLayer").val(gridPage);
			gridLayerSearch(gridPage,"N",$("#cdHistoryId").val());
		},
        loadComplete : function(data) {
//             $('#jqGrid_layer').css({'width': 100 + '%',});
		$('#jqGrid_layer').setGridWidth( 600 , true);
		
        }
	}
	
    $("#jqGrid_layer").jqGrid(gridLayerOption);
}

function callPlan(cellValue, options, rowdata, action){
	
	var callPlan = "";
	
	if(rowdata.callPlan == "0"){
		callPlan = "<span class='call_status color_guide_warning'>미진행</span>";
	}else if (rowdata.callPlan == "1"){
		callPlan = "<span class='call_status color_guide_success'>진행완료</span>";
	}else if (rowdata.callPlan == "2"){
		callPlan = "<span class='call_status color_guide_warning'>진행중</span>";
	}
	return callPlan;
}
function callStats(cellValue, options, rowdata, action){
	var callStats = "";
	
	if(rowdata.callStats == "0"){
		callStats = "<span class='call_status color_guide_warning'>실패</span>";
	}else if (rowdata.callStats == "1"){
		callStats = "<span class='call_status color_guide_success'>성공</span>";
	}else {
		callStats = "-";
	}
	
	return callStats;
}

function gridLayerSearch(cPageLayer, excelYn, cdHistoryId) {

	var obj = new Object();
	
	obj.campaignId = $("#campaignIdSelect option:selected").val();
	obj.cdHistoryId = cdHistoryId;
	
	obj.page = cPageLayer; // current page 
	obj.lastpage =  $('#jqGrid_layer').getGridParam('lastpage'); // current page 
	obj.rowNum = jQuery("#jqGrid_layer").getGridParam('rowNum'); //페이지 갯수
	obj.allRecords = jQuery("#jqGrid_layer").getGridParam('records'); 
	obj.endPageCnt = jQuery("#jqGrid_layer").getGridParam('rowNum');//마지막페이지 cnt
	obj.offset = (obj.page * obj.rowNum)-obj.rowNum;
	
	if(excelYn == "Y"){
		$("#jqGrid_excel").jqGrid("clearGridData", true);
		$("#jqGrid_excel").setGridParam({loadComplete:excelFn.fn, loadonce : true, datatype:"json",postData	: JSON.stringify(obj)}).trigger("reloadGrid");
	}else{
		$("#jqGrid_layer").setGridParam({loadonce:false, datatype	: "json",postData	: JSON.stringify(obj)}).trigger("reloadGrid");
	}
}

function searchRefresh(){
	gridLayerSearch($("#cPageLayer").val(), "N", $("#cdHistoryId").val());
}
</script>
</body>
</html>
