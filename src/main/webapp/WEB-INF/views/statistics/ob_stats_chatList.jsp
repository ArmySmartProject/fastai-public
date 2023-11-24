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

<title>채팅상담 이력조회 &gt; FAST AICC</title>
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
		<input type="hidden" id="headerName" value="${_csrf.headerName}" />
		<input type="hidden" id="token" value="${_csrf.token}" />
		<jsp:include page="../common/inc_header.jsp">
		    <jsp:param name="titleCode" value="A0730"/>
		    <jsp:param name="titleTxt" value="채팅상담 이력조회"/>
		</jsp:include>
    <!-- #container -->
    <div id="container">
        <!-- #content -->
        <div id="contents">
            <!-- .content -->
            <div class="content">
                <!-- 검색조건 -->
                <div class="srchArea">
                <input type="hidden" id="cPage" value="1"/>
                <input type="hidden" id="botIdArr" />
                    <button type="button" class="btnS_line tbody_folding_toggle">상세 검색</button>
                    <table class="tbl_line_view" summary="검색일시/총응대시간/제외여부/음성봇명/상담유형/회선번호/상담사/고객명/통화시간/봇,상담사 응대시간/대화이력으로 구성됨">
                        <caption class="hide">검색조건</caption>
                        <colgroup>
                            <col width="100">
                            <col>
                            <col width="100">
                            <col>
                            <col width="100">
                            <col>
                            <col width="100">
                            <col>
                            <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                        </colgroup>
                        <tbody>
                            <tr>
                            	<th>Company</th>
								<td>
									<select class="select" id="companyIdSelect">
									</select>
								</td>
                                <th scope="row">검색일시</th>
                                <td colspan="5">
                                    <div class="iptBox">
                                        <input type="text" class="ipt_dateTime" name="fromDate" id="fromDate" autocomplete="off">
                                        <span>-</span>
                                        <input type="text" name="toDate" id="toDate" class="ipt_dateTime" autocomplete="off">
                                    </div>
                                    <div class="checkBox">
                                        <input type="checkbox" name="ipt_check3_2" id="ipt_check3_2" class="ipt_check" checked>
                                        <label for="ipt_check3_2">일 단위 검색</label>
                                        <input type="checkbox" name="ipt_check3_3" id="ipt_check3_3" class="ipt_check" checked onclick="searchTimeCheck(this);">
                                        <label for="ipt_check3_3">응대시작시간</label>
                                        <input type="checkbox" name="ipt_check3_3" id="ipt_check3_4" class="ipt_check" onclick="searchTimeCheck(this);">
                                        <label for="ipt_check3_4">응대종료시간</label>
                                    </div>
                                    <input style="opacity:0;pointer-events:none;" type="text" name="fromDate_Auto" id="fromDate_Auto" class="ipt_dateTime1" autocomplete="off">
                                    <input style="opacity:0;pointer-events:none;" type="text" name="toDate" id="toDate_Auto"  class="ipt_dateTime1" autocomplete="off">
                                </td>
                            </tr>
                        </tbody>
                        <tbody class="tbody_folding hide">
                            <tr>
                                <th>챗봇명</th>
								<td id="multiple">
									<select id="multiple_select" class="select" multiple="multiple">
										<option>테스트</option>
									</select>
								</td>
                                <th>상담사</th>
                                <td>
                                    <div class="iptBox">
                                        <input type="text" class="ipt_txt" id="consultant" autocomplete="off">
                                    </div>
                                </td>
                                <th>총 발화수 </th>
                                <td>
                                    <div class="iptBox">
                                        <input type="text" class="ipt_txt" id="totalChatCnt" autocomplete="off">
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="btnBox sz_small line">
                        <button type="button" id="search" class="btnS_basic">검색</button>
                        <button type="button" id="exportExcel" class="btnS_basic">다운로드</button>
                    </div>
                </div>
                <!-- //검색조건 -->
                <div class="aside_box">
                    <!-- .jqGridBox -->
                    <div class="jqGridBox cont">
                        <table id="jqGrid"></table>
                        <div id="jqGridPager"></div>
                    </div>
                    <div style="display: none;">
						<table id="jqGrid_excel"></table>
						<div id="jqGrid_excel_Pager"></div>
					</div>
                    <!-- //.jqGridBox -->
                    
                    <div class="cont_aside">
                        <div class="aside_tit" style="padding:13px 10px 10px 10px;">
                            <h3 class="tit">마인즈랩 설리봇</h3>
                            <div class="memo_drop">
								<%-- [D]swich에 hover를 하면 dropbox에 class active가 붙어야 합니다 --%>
							    <div class="swich" title="메모보기">
							        <svg width="20" height="24" viewBox="0 0 20 24" fill="none" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
							            <rect width="20" height="24" fill="url(#pattern0)"/>
							            <defs>
							                <pattern id="pattern0" patternContentUnits="objectBoundingBox" width="1" height="1">
							                    <use xlink:href="#image0" transform="translate(-0.00136986) scale(0.0164384 0.0136986)"/>
							                </pattern>
							                <image id="image0" width="61" height="73" xlink:href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAD0AAABJCAYAAACO0S4+AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyNpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDYuMC1jMDAzIDc5LjE2NDUyNywgMjAyMC8xMC8xNS0xNzo0ODozMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIyLjEgKFdpbmRvd3MpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOkQ0RTk3MURCNDU5NTExRUJCRDA5RDdERkZFNEQ1RDk1IiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOkQ0RTk3MURDNDU5NTExRUJCRDA5RDdERkZFNEQ1RDk1Ij4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6RDRFOTcxRDk0NTk1MTFFQkJEMDlEN0RGRkU0RDVEOTUiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6RDRFOTcxREE0NTk1MTFFQkJEMDlEN0RGRkU0RDVEOTUiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7lYvUpAAADj0lEQVR42uycS08TURTHb4dOywxDh1CgL6HUlaDRBCFoIhhMXLhAI5+BjVsSWZoYN8ZHYljoQlz4AWiCrA0+FioICx/oSuRNUYxT+oJC6zkohJbbUAoOnXL+yc1kOnPa++u5c885TU5NyWSS7UaPev14qIHRC+MsjDcwOmFMXuvsyEvbdAksNz2BcRGG8u/41AC2e4ZuTTtvMYDtnqEtaedFBrDdlOnh475c7HgbgSnPbTdl5r3Y2FCnRCKxW1owdFXTQp5IdNmcSCRymdBevsRd24pmc1KSrfFSRZ5TbYpflotvvB/9EtrR0/XHfLenZgJdS0sRkRlcpaVyvNrjeDD2dbyb62nwrmVxUXsFNzSzAhE6Dniu+7zuVrtdbQWvr6RsZAg8PjFbMMBbhVzIl7J7w5K+V6jAW8GRc/2ZHhoZU2AJ/IaNq4gVuGSpeK2+zldmDoejdzIBq6rCzjSdYEc8lcwiiukpYYqyTQX/p+1KPM6mZ36wt8OfGESdbfdGorEi4L1rhrDUzvuAMgDuuNLGrBbjbOLomKO1buZxVzJ//wv2W1vadg/yClow7OS9QTN42EjAW4Xzbm46zr0GvA4hFlvmJii4pDPmrkJq9moyZZ8U6WVb7anivh6FREtYW0tkXCqZ5HZVpJy7nBVZT1wvW1Hk+pJhZplTwdHW0gAroQrTvvXjhfOn8952x9x7JymKzNovnWNGst2P0tLQImiCJmiCJmgjKqc4HQpF2ODrUTY795Nl8dvZ/nsK0lHMzjBZwditi6cReHpm4UCAN1JJ/PznL0f0W96BhV95sUznA4v6QTuqyvMC2umw6we9kfinl3p6PtOGKjgoZBE0QRM0QRM0QRM0VVlUZVGVRVUWVVlUZVGcJmiCJmiCJmiCpiqLqiyqsqjKoiqLqiwKWQRN0IcGWhTN3O437IcwsuLx1Yw7vyAVW7l02ABiZE1BxsaTJFlXBUWRuFffDX9myyvG9DbOG+fPk2orCQiqTRngXcROl77+Qfbt+2zGpZKPSxrn64d58zp1/kIrA4exGa1cwFbb2hpXz2HYtWu9rh7gDa6HLPB0l8/rHipkYORDzpQ4bberLd4a54dCBPZWOz8i37bkBHuLJybnT2HnKTZbFwIscgDP/Ymp+ZMbvdPcKgubrBsb6m5i46kWDF0OBsOOLP8e4OAzLUg8ZIjDNghLsEs/KymRunl/D/BHgAEAGsGylqTjvdMAAAAASUVORK5CYII="/>
							            </defs>
							        </svg>
							    </div>
							    <%-- [D]dropbox에 class active가 붙으면 보여집니다. --%>
							    <div class="dropbox">
							        <div class="inner">
							            <p id="consultTxt">이곳은 상담사가 남겨놓은 메모를 보는 곳 입니다. 메모가 길어지면 스크롤이 생깁니다. 최대 height는 500px 입니다.</p>
							        </div>
							    </div>
						    </div>
                        </div>
                        <!-- .chatBox -->
                        <div class="chatBox" style="height: calc(100% - 100px);">
                            <div class="chatUI_mid" style="height: 100%;">
                                <ul class="lst_talk">
                                </ul>
                            </div>
                        </div>
                        <!-- //.chatBox -->
                        <div class="btnBox asideBtm">
                            <button type="button" class="btnS_basic btn_contAside_close">Close</button>
                        </div>
                    </div>
                </div>

            </div>
            <!-- //.content -->
        </div>
        <!-- //#contents -->
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
var recGroupSort = "desc";
var recSort = "desc";
var lang = $.cookie("lang");
jQuery.event.add(window,"load",function(){
	$(document).ready(function (){
		$(window).bind('resize', function() {
			scResize();
		}).trigger('resize');
		
		var lang = $.cookie("lang");
		
        // GCS iframe
        $('.gcsWrap', parent.document).each(function(){            
            //header 화면명 변경
            var pageTitle = $('title').text().replace('> FAST AICC', '');
            
            $(top.document).find('#header h2 a').text(pageTitle); 
        });
        
       	$('#fromDate').val(getFormatDate(new Date()));
       	$('#toDate').val(getFormatDate(new Date()));
        if(lang == "ko" || lang == null){
        	//datetimepicker
	        $('#fromDate').datetimepicker({
	        	language : 'ko', // 화면에 출력될 언어를 한국어로 설정합니다.
	            pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
	            defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
	            autoclose: 1,
	            minView: 2,
	            format: 'yyyy-mm-dd'
	        }).on('changeDate', function(selectedDate){
	        	$("#toDate").datetimepicker('setStartDate',selectedDate.date);
	        });
		
			$('#toDate').datetimepicker({
	            language : 'ko', // 화면에 출력될 언어를 한국어로 설정합니다.
	            pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
	            defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
	            autoclose: 1,
	            minView: 2,
	            format: 'yyyy-mm-dd'
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
                minView: 2,
	            format: 'yyyy-mm-dd'
            }).on('changeDate', function(selectedDate){
	        	$("#toDate").datetimepicker('setStartDate',selectedDate.date);
	        });
    	
    		$('#toDate').datetimepicker({
                language : 'en', // 화면에 출력될 언어를 한국어로 설정합니다.
                pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
                defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
                autoclose: 1,
                minView: 2,
	            format: 'yyyy-mm-dd'
    		}).on('changeDate', function(selectedDate){
	        	$("#fromDate").datetimepicker('setEndDate',selectedDate.date);
	        });	
        }
     	// 체크박스 1
    	//radio버튼처럼 checkbox name값 설정
    	$('#ipt_check3_2').click(function(){
    		dateTimePickerResetting($(this).is(":checked"));
    	});

    	//추가 AMR 200623 검색 박스 테이블 접기/펴기
    	$('.tbody_folding_toggle').on('click', function(){
    		setTimeout(() => {
    			$('.tbody_folding').toggleClass('hide')
    			var searchBoxHeight = $("#container .srchArea").outerHeight(true);
    	    	var gridSubHeight = $(".jqGridBox").outerHeight(true) - parseInt($(".ui-jqgrid-bdiv").css("height"));
    	    	var resizeHeight = $("#container").height() - searchBoxHeight - gridSubHeight; // 전체 container높이 - 헤더높이 - 검색박스높이 - 그리드(헤더,페이지,margin)높이
    	    	$('#jqGrid').setGridHeight( resizeHeight , true);
    	    	$('.cont_aside').css({'height': $('.jqGridBox').height() + 'px',});
    		}, 100);
    	});

    	dateTimePickerResetting($("#ipt_check3_2").is(":checked"));	
        
        getCompanyId();
        
        $("#companyIdSelect").on("change", function() {
        	getChatbotList(this.value);
    	});
        
        $("#search").on("click", function(){
        	$("#cPage").val(1);
        	$.jgrid.gridUnload('#jqGrid');
        	createJqGrid();
        	gridSearch(1);
        	console.log("실행순서 1");
        });

        	//다운로드 클릭시 엑셀다운로드	      
        $("#exportExcel").on("click", function(){
        	$.jgrid.gridUnload('#jqGrid_excel');
        	createJqGrid();
        	//검색할때 loadComplet 날림
        	gridSearch(1, "Y");
        });
        
        $('#multiple_select').multiselect({
			includeSelectAllOption: true,
		});	
        
        
        createJqGrid();
        
        
        $('.memo_drop').on('mouseenter',function(){
        	$('.dropbox').addClass("active");
        });
        $('.memo_drop').on('mouseleave',function(){
        	$('.dropbox').removeClass("active");
        });
        	
	});
});

//검색 일시 응대시간으로 검색 설정
function searchTimeCheck(el){
	var timeCheckBox = document.getElementsByName("ipt_check3_3");
	
	timeCheckBox.forEach((cb) => {
		cb.checked = false;
	})
	
	el.checked = true;
}


function createJqGrid() {      	
	var useGrouping = $("#ipt_check3_2").is(":checked");
	var groupSort = recGroupSort;
	var gridOption = {
		url: "${pageContext.request.contextPath}/getObStatsChatList",
		datatype:"local",
		mtype: "POST",
		ajaxGridOptions: { contentType: "application/json"},
		loadBeforeSend: function(jqXHR) {
			jqXHR.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
		},
		
		colNames:[
			'NO.',
			'<spring:message code="A0225" text="날짜"/>',
			'응대시작시간', 
			'응대종료시간', 
			'챗봇명', 
// 			'상담유형', 
			'유입채널', 
		 	'상담사', 
// 		 	'고객명', 
		 	'총 발화 수', 
		 	'봇/상담사 발화 수', 
		 	'대화이력'
			],
		colModel:[
			{name:'RNUM', index:'no', width: 50, align:'center', sortable: false},
			{name:'daily', index:'daily', width:130, align:'center', sorttype:'date'},
			{name:'startDate', width: 170, index:'startDate', align:'center', sorttype:'date'},
			{name:'endDate', width: 170, index:'endDate', align:'center', sorttype:'date'},
			{name:'chatbotNm', width: 150, index:'chatbotNm', align:'center', sortable: false},
	        {name:'channel', width: 150, index:'channel', align:'center', formatter: chatChannel, sortable: false},
			{name:'consultant', width: 150, index:'consultant', align:'center', sortable: false},
			{name:'totalChatCnt', width: 150, index:'totalChatCnt', align:'center', sortable: false},
			{name:'botCsrCnt', width: 150, index:'botCsrCnt', align:'center', sortable: false},
	        {name:'dialogBtn', width: 150, index:'dialogBtn', align:'center', formatter: dialogBtn, sortable: false},
		],
    loadonce: false,
    viewrecords: true,
    gridview: true,   
    footerrow: false,
    rowNum: 30,
    userDataOnFooter: false, // use the userData parameter of the JSON response to display data on footer
    grouping: useGrouping,
	groupingView : {
		groupField : ['daily'],
		groupSummary : [true],
		groupColumnShow : [false],
		groupText : ['<b>{0}</b>'],
		groupOrder: [groupSort]
	},
    jsonReader : { 
    	repeatitems: false,
    	page: "page",    // 현제 페이지, 하단의 navi에 출력됨.
        total: "total",    // 총 페이지 수
        records: "records",
        root: "rows",
    },
    onPaging: function(pgButton){     //페이징 처리
        
        var gridPage = $("#jqGrid").getGridParam("page");                     // 현재 페이지 번호
        var rowNum = $("#jqGrid").getGridParam("rowNum");                // 뿌려줄 row 개수
        var records = $("#jqGrid").getGridParam("records");                // 현재 레코드 갯수
        
        var totalPage = Math.ceil(records/rowNum);               // 토탈갯수
        
        console.log("onpage");
        console.log(gridPage);
        console.log(rowNum);
        console.log("totalPage:"+totalPage);
        console.log(records);
        console.log(pgButton);
        
        
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
        
        console.log("this page");
        console.log(gridPage);
        console.log("total page");
        console.log(totalPage);
        
		$("#cPage").val(gridPage);
		gridSearch(gridPage);
        
        },
        loadComplete : function(data){
//	        	$('#jqGrid').css("width", 'auto');
//	        	$('.ui-jqgrid-htable').css("width", 'auto');
        	$(".ui-pg-input").attr("readonly", true);
        	// 추가 AMR cont aside height
            var contHeight = $('.aside_box .cont').height();
            $('.cont_aside').css({'height': $('.jqGridBox').height() + 'px',});

            //추가 AMR cont aside(open)
            $('.btn_contAside_open').on('click',function(){	
                $('.aside_box').addClass('aside_open'); 
//	                scResize();
            });

            //추가 AMR cont aside(close)
            $('.btn_contAside_close').on('click',function(){	            
                $('.aside_box').removeClass('aside_open'); 
//	                scResize();
            });	
            if($("#ipt_check3_3").prop("checked") == true){
				$("#jqGrid").setColProp('endDate', {sortable: false});
            }else if($("#ipt_check3_4").prop("checked") == true){
				$("#jqGrid").setColProp('startDate', {sortable: false});
            }
            
        },
        /* grouping:true */
		onSortCol : function(iCol, index, sortOrder){
			// grid sort
			if(iCol == "daily"){
				recGroupSort = sortOrder;
			}else if(iCol == "startDate" && $("#ipt_check3_3").prop("checked") == true){
				recGroupSort = sortOrder;
				recSort = sortOrder;
			}else if(iCol == "endDate" && $("#ipt_check3_4").prop("checked") == true){
				recGroupSort = sortOrder;
				recSort = sortOrder;
			}
			createJqGrid();
			gridSearch($("#cPage").val(), "N");
			
			return "stop";
		}
	};

	gridOption.pager = "#jqGrid_excel_Pager";
	$("#jqGrid_excel").jqGrid(gridOption);
	gridOption.pager = "#jqGridPager";
	$("#jqGrid").jqGrid(gridOption);
	
// 	if($("#ipt_check3_2").is(":checked") == true){
// 		$("#jqGrid").jqGrid('showCol', ["daily"]);
// 		$("#jqGrid").jqGrid('hideCol', ["RNUM"]);
// 		$("#jqGrid_excel").jqGrid('showCol', ["daily"]);
// 		$("#jqGrid_excel").jqGrid('hideCol', ["RNUM"]);
// 		scResize();
// 	} else {
// 		$("#jqGrid").jqGrid('hideCol', ["daily"]);
// 		$("#jqGrid").jqGrid('showCol', ["RNUM"]);
// 		$("#jqGrid_excel").jqGrid('hideCol', ["daily"]);
// 		$("#jqGrid_excel").jqGrid('showCol', ["RNUM"]);
// 		scResize();
// 	}
	
	$(".ui-pg-input").attr("readonly", true);
	scResize();
	// 엑셀 다운로드내용 대화이력 버튼 숨기기
	$("#jqGrid_excel").jqGrid('hideCol', ["dialogBtn"]);
	
}

function dateTimePickerResetting(dateType) {
	var fromDatePicker = $('#fromDate').data('datetimepicker');
	var toDatePicker = $('#toDate').data('datetimepicker');
	if(dateType == false) {
		fromDatePicker.startViewMode = 2;
		fromDatePicker.viewMode = 2;
		fromDatePicker.minView = 0;
// 		fromDatePicker.minuteStep = 30;
		fromDatePicker.viewSelect = 1;
		fromDatePicker.setFormat("yyyy-mm-dd hh:ii")
		toDatePicker.startViewMode = 2;
		toDatePicker.viewMode = 2;
		toDatePicker.minView = 0;
// 		toDatePicker.minuteStep = 30;
		toDatePicker.viewSelect = 1;
		toDatePicker.setFormat("yyyy-mm-dd hh:ii")
		
	} else if(dateType == true) {
		fromDatePicker.startViewMode = 2;
		fromDatePicker.viewMode = 2;
		fromDatePicker.minView = 2;
		fromDatePicker.viewSelect = 2;
		fromDatePicker.setFormat("yyyy-mm-dd")
		toDatePicker.startViewMode = 2;
		toDatePicker.viewMode = 2;
		toDatePicker.minView = 2;
		toDatePicker.viewSelect = 2;
		toDatePicker.setFormat("yyyy-mm-dd")
		
	}
	fromDatePicker.showMode();
	toDatePicker.showMode();
}


function getCompanyId() {
	$.ajax({url : "${pageContext.request.contextPath}/getCompanyIdList",
		data : {},
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		if(result != null && result.length > 0){
			var html = "";
			for(var i = 0; i < result.length; i++) {
				if(lang == "ko" || lang == null){
					html += "<option value='" + result[i].companyId + "'>" + result[i].companyId + " ["+ result[i].companyName +"]</option>"
				} else {
					html += "<option value='" + result[i].companyId + "'>" + result[i].companyId + " ["+ result[i].companyNameEN +"]</option>"
				}
			}

			$("#companyIdSelect").html(html);

			if(result.length == 1){
				$("#companyIdSelect").attr("disabled", "disabled");
			}
			
			getChatbotList(result[0].companyId);
			
		}else {
			alert("<spring:message code='A0333' text='CompanyId가 존재하지 않습니다.' />");
		}

	}).fail(function(result) {
		console.log("ajax connection error: getCompanyIdList");
	});
}

function getChatbotList(companyId) {

	var obj = new Object();
	obj.companyId = companyId;

	$.ajax({
		url : "${pageContext.request.contextPath}/getChatBotList",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		var botIdArr = new Array();
		$('#multiple').empty();
		// $("#multiple_select").multiselect("clearSelection");
		var innerHTML = "";
			innerHTML += '<select id="multiple_select" class="select" multiple="multiple" onchange="changeChatbot(this.value);">';
			if(result != null && result.length > 0){
				for(var i = 0; i < result.length; i++){
					innerHTML += '<option value="' + result[i].botId + '"selected>' + result[i].name + '</option>';
					botIdArr.push(result[i].botId);
				}
			}
			innerHTML += '</select>'
			$("#botIdArr").val(botIdArr);
			$("#multiple").append(innerHTML);
		$('#multiple_select').multiselect({
			includeSelectAllOption: true,
		});
		
		gridSearch(1,"N");

	}).fail(function(result) {
		console.log("ajax connection error: getChatbotList");
	});
}

function changeChatbot(){
	var botId = "";
	if($("#multiple_select").val() != "" && $("#multiple_select").val() != null && $("#multiple_select option:selected").length > 0) {
		$.each($("#multiple_select").val(), function(i, v){
			if( i == 0){
				botId = v;
			}else if(i > 0){
				botId = botId + "," + v;
			}else{
				botId = "";
			}
		});
	}
	$("#botIdArr").val(botId);
}



function gridSearch(currentPage, excelYn) {
	
	console.log("실행순서 2");

    if(excelYn === "Y" && jQuery("#jqGrid").getGridParam('records') === 0 ){
        alert("다운로드 가능한 데이터가 존재하지 않습니다.");
        return;
    }

	$('.aside_box').removeClass('aside_open');
	var endPageCnt = jQuery("#jqGrid").getGridParam('records').toString();
	
	var obj = new Object();
	obj.toDate =  $("#toDate").val();
	obj.fromDate = $("#fromDate").val();
	obj.excelYn = excelYn == "Y"? excelYn : "N";
	obj.dailyChk = $("#ipt_check3_2").is(":checked");	
	obj.groupSortOrder = recGroupSort;
	obj.sortOrder = recSort;
	obj.botIdArr = $("#botIdArr").val();
	obj.consultant = $("#consultant").val();
	obj.totalChatCnt = $("#totalChatCnt").val();
	
	if($("#ipt_check3_3").prop("checked") == true){
		obj.searchTime = "startTime";
	}else if($("#ipt_check3_4").prop("checked") == true){
		obj.searchTime = "endTime";
	}
	
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

var excelFn = {fn:function(){
	if($("#gbox_jqGrid_excel .ui-widget-content").length > 0 && $("#jqGrid_excel #norecs").length == 0){
		setTimeout(function() {
			console.log("실행순서 4");
			$("#jqGrid_excel").jqGrid("exportToExcel",{
			  includeLabels : true,
			  includeGroupHeader : true,
			  includeFooter: true,
			  fileName : "채팅상담 이력조회.xlsx",
			  mimetype : "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
			  maxlength : 40,
			  onBeforeExport : "",
			  replaceStr : null,
			  loadIndicator : true
			});
		}, 300);
	}
}};
function dialogBtn(cellValue, options, rowdata, action){
	var dialogBtn = "<button class='btnS_line btn_contAside_open' onclick=showDialog('"+rowdata.session+"','"+rowdata.id+"','"+rowdata.host+"',this)>보기</button>";
	
	return dialogBtn;
}

function chatChannel(cellValue, options, rowdata, action){
	var channel = ""; 
	
	if(rowdata.channel != null){
		channel = JSON.parse(rowdata.channel).channel;
	}else{
		channel = "-";
	}
	
	return channel;
}

function scResize() {
	
	var resizeWidth = $('.jqGridBox').width()-1; //jQuery-ui의 padding 설정 및 border-width값때문에 넘치는 걸 빼줌.
	var searchBoxHeight = $("#container .srchArea").outerHeight(true);
	var gridSubHeight = $(".jqGridBox").outerHeight(true) - parseInt($(".ui-jqgrid-bdiv").css("height"));
	var resizeHeight = $("#container").height() - searchBoxHeight - gridSubHeight; // 전체 container높이 - 헤더높이 - 검색박스높이 - 그리드(헤더,페이지,margin)높이

	// 그리드의 width를 div 에 맞춰서 적용
	$('#jqGrid').setGridWidth( resizeWidth , true); //Resized to new width as per window. 
	$('#jqGrid').setGridHeight( resizeHeight , true);
	$('#jqGrid').css("width", 'auto');
	$('.ui-jqgrid-htable').css("width", 'auto');
	$('.cont_aside').css({'height': $('.jqGridBox').height() + 'px',});
}

function showDialog(session, sessionId, host, el){
	$(".ui-widget-content").removeClass('active');
	$(el).parent().parent().addClass("active");
	
	var obj = new Object();
	
	obj.session = session;
	obj.sessionId = sessionId;
	obj.host = host;
	
	$.ajax({
		url : "${pageContext.request.contextPath}/getDetailChat",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		var detailChat = result.DetailChat;
		var consultMemo = result.ConsultMemo;
		var consultDialog = result.ConsultDialog;
		
		$(".aside_tit > .tit").text(detailChat[0].chatbotNm);
		
		if(consultMemo != ""){
			$("#consultTxt").text(consultMemo[0].SUPPORTER_COMMENT);
		}else{
			$("#consultTxt").text("");
		}

		var arrDialog = new Array();
		//sub DB 대화
		for(var i = 0; i < detailChat.length; i++){
			var objDialog = new Object();
			objDialog.type = "intentLog";
			objDialog.utter = detailChat[i].utter;
			objDialog.answer = detailChat[i].answer;
			objDialog.date = detailChat[i].createDate;
			arrDialog.push(objDialog);
		}
		//main DB 대화
		for(var i = 0; i < consultDialog.length; i++){
			var objDialog = new Object();
			objDialog.type = "chatLog";
			objDialog.utter = consultDialog[i].UTTER;
			objDialog.isSupporter = consultDialog[i].IS_SUPPORTER;
			objDialog.date = consultDialog[i].INPUT_TIME;
			arrDialog.push(objDialog);
		}
		//대화내용 날짜순으로 정렬
		arrDialog.sort(function(a,b){
			 return new Date(a.date) < new Date(b.date) ? -1 : new Date(a.date) > new Date(b.date) ? 1 : 0 ;
		});
		
		var innerHtml = "";
		
		for(var i = 0; i < arrDialog.length; i++){
		    if(arrDialog[i].type == "intentLog"){
		    	innerHtml += "<li class='user'>";
				innerHtml += "<div class='bot_msg'>";
				innerHtml += "<em class='txt'>"+arrDialog[i].utter+"</em>"
				innerHtml += "<div class='date'>"+arrDialog[i].date+"</div>"
				innerHtml += "</div>";
				innerHtml += "</li>";
				if(arrDialog[i].answer != null){
					innerHtml += "<li class='bot'>";
					innerHtml += "<div class='bot_msg'>";
					innerHtml += "<em class='txt'>"+arrDialog[i].answer+"</em>"
					innerHtml += "<div class='date'>"+arrDialog[i].date+"</div>"
					innerHtml += "</div>";
					innerHtml += "</li>";
				}
			}else if(arrDialog[i].type == "chatLog"){
		    	if(arrDialog[i].isSupporter == "0"){
					innerHtml += "<li class='user'>";
					innerHtml += "<div class='bot_msg'>";
					innerHtml += "<em class='txt'>"+arrDialog[i].utter+"</em>"
					innerHtml += "<div class='date'>"+arrDialog[i].date+"</div>"
					innerHtml += "</div>";
					innerHtml += "</li>";
				}else if(arrDialog[i].isSupporter == "1"){
					innerHtml += "<li class='bot consultant'>";
					innerHtml += "<div class='bot_msg'>";
					innerHtml += "<em class='txt'>"+arrDialog[i].utter+"</em>"
					innerHtml += "<div class='date'>"+arrDialog[i].date+"</div>"
					innerHtml += "</div>";
					innerHtml += "</li>";
				}
		    }
		}
		
		$(".lst_talk").empty();
		$(".lst_talk").append(innerHtml);
		
	}).fail(function(result) {
		console.log("Show Dialog error");
	});
}
</script>

</body>
</html>
