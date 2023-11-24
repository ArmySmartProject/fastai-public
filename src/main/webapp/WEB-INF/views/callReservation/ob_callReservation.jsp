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
		<input type="hidden" id="headerName" value="${_csrf.headerName}" />
		<input type="hidden" id="token" value="${_csrf.token}" />
		<input type="hidden" id="saveType" value="" />
		<input type="hidden" id="insertCustDetail" />
		<input type="hidden" id="autoCallConditionId" />
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
                <!-- .jqGridBox -->
                <!-- <a href="#lyr_callReservation" class="btnS_line btn_lyr_open">call 수정</a> -->
                <div class="jqGridBox" style="box-shadow: none;">
                    <div class="btnBox sz_small" style="background: #dce1ea;">
                    	<div class="fl">
                            <button type="button" class="btnS_basic btn_clr" onclick="deleteReservation();">삭제</button>
                        </div>
                        <div class="fr">
                        	<button type="button" class="btnS_basic btn_lyr_open" onclick="insertReservation();">등록</button>
                        </div>
                    </div>

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

<!-- 추가 200710 예약콜 관리 -->
<div id="lyr_callReservation" class="lyrBox movable">
    <div class="lyr_top" id="lyr_callReservationheader">
        <h3>예약콜 관리</h3>
        <button class="btn_lyr_close">닫기</button>
    </div>

    <div class="lyr_mid" style="max-height: 655px;">
        <!-- 검색조건 -->
        <div class="srchArea">
            <button type="button" class="btnS_line tbody_folding_toggle">상세 검색</button>
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
                                <input type="text" class="ipt_txt" id="reservationNm" autocomplete="off">
                            </div>
                        </td>
                        <th>상세설명</th>
                        <td colspan="3">
                            <div class="iptBox">
                                <input type="text" class="ipt_txt" id="reservationExp" autocomplete="off">
                            </div>
                        </td>
                    </tr>

                    <tr class="tr_title">
                        <th class="hide">검색 상세 분류</th>
                        <td colspan="6">발송기간</td>
                    </tr>
                    <tr>
                        <th scope="row">시작 - 종료 일자</th>
                        <td colspan="3">
                            <div class="iptBox">
                                <input type="text" name="fromDate" id="fromDate" class="ipt_dateTime" autocomplete="off">
                                <span>-</span>
                                <input type="text" name="toDate" id="toDate"  class="ipt_dateTime" autocomplete="off">
                            </div>
                        </td>
                        <!-- <th>종료일자</th>
                        <td>
                            <div class="iptBox">
                                <input type="text" class="ipt_txt" autocomplete="off"><span>초 이상</span>
                            </div>
                        </td> -->
                        <th>발송시간</th>
                        <td>
                            <div class="select_custom">
                                <div class="custom_box">
                                    <select class="select" id="dispatchTime">
                                        <option selected>--</option>
                                        <option value="00">00</option>
                                        <option value="01">01</option>
                                        <option value="02">02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07">07</option>
                                        <option value="08">08</option>
                                        <option value="09">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>
                                        <option value="17">17</option>
                                        <option value="18">18</option>
                                        <option value="19">19</option>
                                        <option value="20">20</option>
                                        <option value="21">21</option>
                                        <option value="22">22</option>
                                        <option value="23">23</option>
                                    </select>
                                    <span>시</span>
                                </div>
                                <div class="custom_box">
                                    <select class="select" id="dispatchMin"> 
                                        <option selected>--</option>
                                        <option value="00">00</option>
                                        <option value="10">10</option>
                                        <option value="20">20</option>
                                        <option value="30">30</option>
                                        <option value="40">40</option>
                                        <option value="50">50</option>
                                    </select>
                                    <span>분</span>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>요일선택</th>
                        <td colspan="5">
                            <div class="checkBox card_type">
                                <!-- [D] AMR 요일 클릭 시 주중, 주말도 표시가 되어야 합니다
					                                      월,화,수,목,금 check = 주중 check
					                                      토,일 check = 주말 check
					                                      주중과 주말에 해당되지 않는 check = 주중, 주말 모두 uncheck 
                                -->
                                <div class="box">
                                    <input type="checkbox" name="ipt_check_1" id="ipt_check_1" class="ipt_check weekendChk" value="1" onclick="cancelWeekendChk(this);">
                                    <label for="ipt_check_1">일</label>
                                    <input type="checkbox" name="ipt_check_2" id="ipt_check_2" class="ipt_check weekdayChk" value="2" onclick="cancelWeekdayChk(this);">
                                    <label for="ipt_check_2">월</label>                                                         
                                    <input type="checkbox" name="ipt_check_3" id="ipt_check_3" class="ipt_check weekdayChk" value="3" onclick="cancelWeekdayChk(this);">
                                    <label for="ipt_check_3">화</label>                                                         
                                    <input type="checkbox" name="ipt_check_4" id="ipt_check_4" class="ipt_check weekdayChk" value="4" onclick="cancelWeekdayChk(this);">
                                    <label for="ipt_check_4">수</label> 
                                    <input type="checkbox" name="ipt_check_5" id="ipt_check_5" class="ipt_check weekdayChk" value="5" onclick="cancelWeekdayChk(this);">
                                    <label for="ipt_check_5">목</label>                                                         
                                    <input type="checkbox" name="ipt_check_6" id="ipt_check_6" class="ipt_check weekdayChk" value="6" onclick="cancelWeekdayChk(this);">
                                    <label for="ipt_check_6">금</label>                                                         
                                    <input type="checkbox" name="ipt_check_7" id="ipt_check_7" class="ipt_check weekendChk" value="7" onclick="cancelWeekendChk(this);">
                                    <label for="ipt_check_7">토</label>
                                    <!-- [D] <label>의 for값과 <input>의 ID 값을 동일하게 작성해야 함 -->
                                </div>

                                <div class="box">
                                    <!-- [D] AMR 주중, 주말 클릭 시 요일에 표시가 되어야 합니다 월,화,수,목,금 check = 주중 check 토,일 check = 주말 check -->
                                    <input type="checkbox" name="ipt_check1_weekday" id="ipt_check1_weekday" class="ipt_check ipt_checkbox_weekdayCheck" onclick="checkWeekday();">
                                    <label for="ipt_check1_weekday">주중</label>
                                    <input type="checkbox" name="ipt_check1_weekend" id="ipt_check1_weekend" class="ipt_check ipt_checkbox_weekendCheck" onclick="checkWeekend();">
                                    <label for="ipt_check1_weekend">주말</label>
                                    <!-- [D] <label>의 for값과 <input>의 ID 값을 동일하게 작성해야 함 -->
                                </div>
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
                            <select id="multiple_select01" class="select" multiple="multiple">
                                <option value="0">0</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3이상</option>
                            </select>
                        </td>
                        <th>대상상태</th>
                        <td colspan="3">
                            <select id="multiple_select02" class="select" multiple="multiple">
                                <option value="notRun">미실행</option>
                                <option value="failMissing">통화실패 / 결번</option>
                                <option value="failOther">통화실패 / 기타</option>
                                <option value="YN">통화성공 / 안내 실패</option>
                                <option value="YY">통화성공 / 안내 성공</option>
                            </select>
                        </td>
                    </tr>
                </tbody>

                <tbody class="tbody_folding hide">
                    <!-- <tr>
                        <th>성별</th>
                        <td>
                            <div class="checkBox card_type">
                                <div class="box">
                                    <input type="checkbox" name="ipt_check2_1" id="ipt_check2_1" class="ipt_check genderChk" onclick="genderChk(this);">
                                    <label for="ipt_check2_1">남</label>
                                    <input type="checkbox" name="ipt_check2_2" id="ipt_check2_2" class="ipt_check genderChk" onclick="genderChk(this);">
                                    <label for="ipt_check2_2">여</label>
                                </div>
                                <div class="box">
                                    <input type="checkbox" name="ipt_check2_all" id="ipt_check2_all" class="ipt_check ipt_checkbox_allCheck" onclick="allGenderChk();">
                                    <label for="ipt_check2_all">전체</label>
                                </div>
                            </div>
                        </td>
                        <th>연령대</th>
                        <td>
                            <select id="multiple_select03" class="select" multiple="multiple">
                                <option>option1</option>
                                <option>option2</option>
                                <option>option3</option>
                                <option>option4</option>
                                <option>option5</option>
                                <option>option6</option>
                                <option>option7</option>
                            </select>
                        </td>
                        <th>대상1</th>
                        <td>
                            <div class="iptBox">
                                <input type="text" class="ipt_txt" autocomplete="off">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>대상2</th>
                        <td>
                            <div class="iptBox">
                                <input type="text" class="ipt_txt" autocomplete="off">
                            </div>
                        </td>
                        <th>대상3</th>
                        <td>
                            <div class="iptBox">
                                <input type="text" class="ipt_txt" autocomplete="off">
                            </div>
                        </td>
                        <th>대상4</th>
                        <td>
                            <div class="iptBox">
                                <input type="text" class="ipt_txt" autocomplete="off">
                            </div>
                        </td>
                    </tr> -->
                </tbody>
            </table>
            <div class="btnBox sz_small line">
                <button type="button" class="btnS_basic" onclick="lyrGridSearch(1);">검색</button>
            </div>
        </div>
        <!-- //검색조건 -->

        <!-- .jqGridBox -->
        <div class="jqGridBox" style="box-shadow: none;">
            <div class="infoTxt">총 <span>10</span> 명</div>
            <table id="jqGrid_layer"></table>
            <div id="jqGridPager_layer"></div>
        </div>
        <!-- //.jqGridBox -->
    </div>
    <!-- //lyr_mid -->

    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button onclick="saveReservation();">저장</button>
            <button class="btn_lyr_close">취소</button>
        </div>
    </div>
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
        
		//datepicker
		$('#fromDate').datepicker({
			format : "yyyy-mm-dd",
			language : "ko",
			defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
			autoclose : true,
			todayHighlight : true,
		});
	
		$('#toDate').datepicker({
			format : "yyyy-mm-dd",
			language : "ko",
			defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
			autoclose : true,
			todayHighlight : true
		});
        
        //AMR 검색 박스 테이블 접기/펴기
        $('.tbody_folding_toggle').on('click', function(){
            setTimeout(
                $('.tbody_folding').toggleClass('hide')
            , 100);
        });
        createJqGrid();

        //추가 AMR 200714 multiple_select
        $('#multiple_select01, #multiple_select02, #multiple_select03').multiselect({
          includeSelectAllOption: true,
        });
        scResize();
	});
});

function scResize() {
	var resizeWidth = $('.jqGridBox').width()-1; //jQuery-ui의 padding 설정 및 border-width값때문에 넘치는 걸 빼줌.
	var searchBoxHeight = $("#container .titArea").outerHeight(true);
	var gridSubHeight = $(".jqGridBox").outerHeight(true) - parseInt($(".ui-jqgrid-bdiv").css("height"));
	var resizeHeight = $("#container").height() - searchBoxHeight - gridSubHeight; // 전체 container높이 - 검색박스높이 - 그리드(헤더,페이지,margin)높이

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
        scResize();
		
	}).fail(function(result) {
		console.log("ajax connection error: getObReservationCompanyIdList");
	});
}
function createJqGrid(){
	
	var gridOption = {
        	url: "${pageContext.request.contextPath}/getCallReservationList",
			datatype: "local",
			mtype: "POST",
			ajaxGridOptions: { contentType: "application/json" },
			loadBeforeSend: function(jqXHR) {
				jqXHR.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
			},
            colNames:[
            	'<div class="checkBox"><input type="checkbox" id="total_chk" class="ipt_jqCheckbox_allCheck" onclick="checkAll();"><label for="total_chk"></label></div>' , 
            	'NO.', 
            	'예약콜명', 
            	'상세설명', 
            	'예약일시', 
            	'등록일', 
            	'등록자', 
            	'수정일', 
            	'수정자', 
            	'수정'
            ],
            colModel:[
            	{name:'checkbox', index:'checkbox', width: 40, align:'center', sortable: false, formatter:addCheckbox},
				{name:'RNUM', index:'RNUM', width: 30, align:'center', sortable: false},
				{name:'cdName', index:'cdName', align:'center', sortable: false},
				{name:'cdDesc', index:'cdDesc', align:'center', sortable: false},
                {name:'reservationDate', index:'reservationDate', width: 200, align:'center', sortable: false, formatter:reservationDate},
				{name:'createDtm', index:'createDtm', align:'center', sortable: false},
                {name:'creator', index:'creator', align:'center', sortable: false},
				{name:'updateDtm', index:'updateDtm', align:'center', sortable: false},
				{name:'updater', index:'updater', align:'center', sortable: false},
                {name:'modifyMode', index:'modifyMode', width:70, align:'center', sortable: false, formatter:addButton}
            ],
            pager: "#jqGridPager",
            height: 'auto',
            rowNum: 30,
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
                $('.ipt_jqCheckbox_allCheck').parent().parent().removeClass('ui-jqgrid-sortable');
                    
                 // 추가 AMR 200710 jqGrid 내 th (name: checkbox)를 체크박스 태그로 수정
//                     $('#jqgh_jqGrid_checkbox').html('<div class="checkBox"><input type="checkbox" id="total_chk" class="ipt_jqCheckbox_allCheck"><label for="total_chk"></label></div>'
//                     )

                    // [D] AMR 콜예약일시가 지나면 해당 row가 disabled가 되어야 합니다
                    // $('#1').addClass('disabled')

                    scResize();
            }
      }
	
	$('.ipt_jqCheckbox_allCheck').parent().parent().removeClass('ui-jqgrid-sortable');
	$("#jqGrid").jqGrid(gridOption);
	scResize();
}

function createLayerJqGrid(colLayerNames, colLayerModels){
	
	var gridLayerOption = {
			url: "${pageContext.request.contextPath}/getReservationCustList",
			datatype: "local",
			mtype: "POST",
			autowidth: false,
			ajaxGridOptions: { contentType: "application/json" },
			loadBeforeSend: function(jqXHR) {
				jqXHR.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
			},
			
			colNames:colLayerNames,
			colModel:colLayerModels,
            pager: "#jqGridPager_layer",
            height: 'auto',
            rowNum: 30,
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
				lyrGridSearch(gridPage);
			},
            loadComplete : function(data) {
                $(".ui-pg-input").attr("readonly", true);
                
              	//layer_grid 유저 리스트 총 갯수
  				$(".infoTxt > span").text($("#jqGrid_layer").getGridParam("records"));
                	
            }
      }
	$("#jqGrid_layer").jqGrid(gridLayerOption);
}
function checkAll() {
	
	if($("input[id=total_chk]").is(":checked") == true){
		$("input[id=total_chk]").prop("checked",true);
		$("input[id*=checkbox]").prop("checked",true);
	}else{
		$("input[id=total_chk]").prop("checked",false);
		$("input[id*=checkbox]").prop("checked",false);
	}
	
}
//Jqgrid Checkbox 추가
function addCheckbox(cellValue, options, rowdata, action){
	var checkboxHtml = "";
        checkboxHtml += '<div class="checkBox">';
        checkboxHtml += '<input type="checkbox" id="checkbox'+rowdata.RNUM+'" class="ipt_jqCheckbox" value="'+rowdata.id+'"><label for="checkbox'+rowdata.RNUM+'"></label>';
        checkboxHtml += '</div>';

    return checkboxHtml;
}	

//추가 유라 김가영매니저님 jqGrid 내 버튼 추가 
function addButton(cellValue, options, rowdata, action){
    var buttonHtml = '<button type="button" class="btnS_line btn_lyr_open" onclick=updateReservation('+rowdata.id+','+rowdata.campaignId+');>수정</button>';
    return buttonHtml;
}
//Task감지 안내결과 추가
function scenarioResult(cellValue, options, rowdata, action){
	var scenarioResultHtml = '';	
	if(rowdata.scenarioResult == 'Y'){
		scenarioResultHtml = '<span class="call_status color_guide_success">SUCCESS</span>';
	}else if(rowdata.scenarioResult == 'N'){
		scenarioResultHtml = '<span class="call_status color_guide_warning">FAIL</span>';
	}else{
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
	 
	var reservationDate = rowdata.startDtm + " ~ " + rowdata.endDtm +"<br />" + "(" + weekDayArr + ")" + "&nbsp"+rowdata.dispatchTime;
	return reservationDate;
}

function changeCampaign(){
	createJqGrid();
	gridSearch(1,"N");
}

function gridSearch(currentPage, excelYn) {

	var obj = new Object();
	
	obj.campaignId = $("#campaignIdSelect option:selected").val();
	
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

//주중 클릭시 월,화,수,목,금 check
function checkWeekday() {
	if($("input:checkbox[id=ipt_check1_weekday]").is(":checked") == true){
		$(".weekdayChk").prop("checked", true);
	}else{
		$(".weekdayChk").prop("checked", false);
	}
}

//주말 클릭시 토,일 check
function checkWeekend() {
	if($("input:checkbox[id=ipt_check1_weekend]").is(":checked") == true){
		$(".weekendChk").prop("checked", true);
	}else{
		$(".weekendChk").prop("checked", false);
	}
}
// 월,화,수,목,금 중 체크해제시 주중 체크해제
function cancelWeekdayChk(el){
	if($(".weekdayChk:checked").length == 5){
		$("#ipt_check1_weekday").prop("checked", true);
	}else {
		$("#ipt_check1_weekday").prop("checked", false);
	}
}
// 토,일 중 체크해제시 주말 체크해제
function cancelWeekendChk(el){
	if($(".weekendChk:checked").length == 2){
		$("#ipt_check1_weekend").prop("checked", true);
	}else{
		$("#ipt_check1_weekend").prop("checked", false);
	}
}
// 전체 체크시 남,여 체크
function allChk() {
	if($("input:checkbox[id='ipt_checkAllChk']").is(":checked") == true){
		$("input:checkbox[id*='ipt_check2_']").prop("checked", true);
	}else{
		$("input:checkbox[id*='ipt_check2_']").prop("checked", false);
	}
}
// 남,여 중 체크해제시 전체 체크해제
function eachChk(el) {
	if($("input:checkbox[id*='ipt_check2_']:checked").length == $("input:checkbox[id*='ipt_check2_']").length){
		$("#ipt_checkAllChk").prop("checked", true);
	}else if($("input:checkbox[id*='ipt_check2_']:checked").length < $("input:checkbox[id*='ipt_check2_']").length){
		$("#ipt_checkAllChk").prop("checked", false);
	}
}

//등록 팝업창
function insertReservation(){
	$("#saveType").val("insert");
	 
	var obj = new Object();
	
	obj.campaignId = $("#campaignIdSelect option:selected").val();
	
	$.ajax({url : "${pageContext.request.contextPath}/getObReservationInsForm",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		
		//예약콜 등록 시작-종료 날짜 오늘 날짜로 수정
		var date = new Date();
	    var curDate = getFormatDate(date);
	    $("#toDate").val(curDate);
	    $("#fromDate").val(curDate);
		
		$("#reservationNm").val("");
		$("#reservationExp").val("");
		$("#dispatchTime option:eq(0)").prop("selected",true);
		$("#dispatchMin option:eq(0)").prop("selected",true);
		$("input[id*=ipt_check_]").prop("checked",false);
		$("input[id*=ipt_check1_]").prop("checked",false);
		//시도횟수 초기화
		$("#multiple_select01").multiselect("clearSelection");
		$("#multiple_select02").multiselect("clearSelection");
		
		//방송대상 검색조건 동적 생성
		var callReservationCustData = result.callReservationCustData;
		var colLayerNames = [];
		var colLayerModels = [];
		
		//상세검색 발송 대상 관련
		var innerHtml = "";
		colLayerNames.push("NO.", "이름", "전화번호", "안내 결과");
		colLayerModels.push({name:'layer_no', index:'layer_no', width: 30, align:'center', sortable: false});
		colLayerModels.push({name:'custNm', index:'custNm', align:'center', sortable: false});
		colLayerModels.push({name:'custTelNo', index:'custTelNo', align:'center', sortable: false});
		colLayerModels.push({name:'scenarioResult', index:'scenarioResult', align:'center', sortable: false,formatter:scenarioResult});
		
		//발송대상 검색조건 동적 생성
		var trIdx = 0;
		for(var j = 0; j < callReservationCustData.length; j++){
			//Jqgrid 컬럼 동적 생성
			if(callReservationCustData[j].columnKor != "이름" && callReservationCustData[j].columnKor != "전화번호" && callReservationCustData[j].columnKor != "시도횟수" && callReservationCustData[j].columnKor != "대상상태"){
				colLayerNames.push(callReservationCustData[j].columnKor);
				colLayerModels.push({name:'layer_data'+(j+1), index:'layer_data'+(j+1), align:'center', sortable: false});
			}
			if(callReservationCustData[j].columnKor != "시도횟수" && callReservationCustData[j].columnKor != "대상상태"){
				if((trIdx % 3) == 0){
					innerHtml += "<tr>";
				}
				if(callReservationCustData[j].typeName == "radiobox"){
					
					innerHtml += "<th>"+callReservationCustData[j].columnKor+"</th>";
					innerHtml += "<td>";
					innerHtml += "<div class='checkBox card_type'>";
					innerHtml += "<div class='box'>";
					for(var k = 0; k < callReservationCustData[j].caseType.split(",").length; k++){
						innerHtml += "<input type='checkbox' name='ipt_check2_"+k+"' id='ipt_check2_"+k+"' class='ipt_check' value="+callReservationCustData[j].caseType.split(",")[k]+" onclick='eachChk(this);'>";
						innerHtml += "<label for='ipt_check2_"+k+"'>"+callReservationCustData[j].caseType.split(",")[k]+"</label>";
					}
					innerHtml += "</div>";
					innerHtml += "<div class='box'>";
					innerHtml += "<input type='checkbox' name='ipt_checkAllChk' id='ipt_checkAllChk' class='ipt_check ipt_checkbox_allCheck' onclick='allChk();'>";
					innerHtml += "<label for='ipt_checkAllChk'>전체</label>";
					innerHtml += "</div></div></td>";
					
				}else if(callReservationCustData[j].typeName == "selectbox"){
					if(callReservationCustData[j].caseType != null && callReservationCustData[j].caseType != ""){
						innerHtml += "<th>"+callReservationCustData[j].columnKor+"</th>";
						innerHtml += "<td><select id='multiple_select03_"+callReservationCustData[j].custDataClassId+"' class='select' multiple='multiple'>";
						for(var k = 0; k < callReservationCustData[j].caseType.split(",").length; k++){
							innerHtml += "<option value="+callReservationCustData[j].caseType.split(",")[k]+">"+callReservationCustData[j].caseType.split(",")[k]+"</option>";
						}
						innerHtml += "</select></td>"
					}	
				}else{
					innerHtml += "<th>"+callReservationCustData[j].columnKor+"</th>";
					innerHtml += "<td><div class='iptBox'><input type='text' class='ipt_txt' id="+callReservationCustData[j].columnEng+" autocomplete='off'></div></td>";
				}
				
				if((trIdx % 3) == 2 ){
					innerHtml += "</tr>";
				}
				trIdx= trIdx+1;
			}
		}
		$(".tbody_folding").empty();
		$(".tbody_folding").append(innerHtml);
		
		$('select[id*="multiple_select03_"').multiselect({
        	includeSelectAllOption: true,
     	});
		$.jgrid.gridUnload('#jqGrid_layer');
		createLayerJqGrid(colLayerNames, colLayerModels);
		$(".tbody_folding").addClass('hide');
		
		dragElement(document.getElementById("lyr_callReservation"));
		openPopup("lyr_callReservation");
	}).fail(function(result) {
		console.log("ajax connection error: getObReservationDetail");
	});
	
	
}

//수정 팝업
function updateReservation(autoCallConditionId, campaignId){
	$("#saveType").val("update");
	$("#autoCallConditionId").val(autoCallConditionId);
	var obj = new Object();
	
	obj.id = autoCallConditionId;
	obj.campaignId = campaignId;
	
	
	$.ajax({url : "${pageContext.request.contextPath}/getObReservationDetail",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		//예약콜명 및 발송기간 데이터
		var callReservationDetail = result.callReservationDetail;
		//발송대상 동적 검색조건 데이터
		var callReservationCustData = result.callReservationCustData;
		//발송대상 저장된 검색 조건 value
		var obReservationValue = result.obReservationValue;
		
		var colLayerNames = [];
		var colLayerModels = [];
		//예약콜 명, 상세설명, 발송 기간 관련
		if(callReservationDetail[0].cdName == "-"){
			$("#reservationNm").val("");
		}else{
			$("#reservationNm").val(callReservationDetail[0].cdName);
		}
		if(callReservationDetail[0].cdDesc == "-"){
			$("#reservationExp").val("");
		}else{
			$("#reservationExp").val(callReservationDetail[0].cdDesc);
		}
		$("#fromDate").val(callReservationDetail[0].startDtm);
		$("#toDate").val(callReservationDetail[0].endDtm);
		
		$("select[id=dispatchTime] option[value="+callReservationDetail[0].dispatchTime.split(':')[0]+"]").prop("selected","selected");
		$("select[id=dispatchMin] option[value="+callReservationDetail[0].dispatchTime.split(':')[1]+"]").prop("selected","selected");
		//주중 check
		var weekDay =callReservationDetail[0].weekDay.split(',');
		// 요일선택 초기화
		$("input[id*=ipt_check_]").prop("checked",false);
		$("input[id*=ipt_check1_]").prop("checked",false);
		for(var i = 0; i < weekDay.length; i++){
			$("#ipt_check_"+weekDay[i]+"").prop("checked", true);
		}
		if($(".weekdayChk:checked").length == 5){
			$("#ipt_check1_weekday").prop("checked", true);
		}else {
			$("#ipt_check1_weekday").prop("checked", false);
		}
		if($(".weekendChk:checked").length == 2){
			$("#ipt_check1_weekend").prop("checked", true);
		}else {
			$("#ipt_check1_weekend").prop("checked", false);
		}
		
		//상세검색 발송 대상 관련
		var innerHtml = "";
		
		colLayerNames.push("NO.", "이름", "전화번호", "안내 결과");
		colLayerModels.push({name:'layer_no', index:'layer_no', width: 30, align:'center', sortable: false});
		colLayerModels.push({name:'custNm', index:'custNm', align:'center', sortable: false});
		colLayerModels.push({name:'custTelNo', index:'custTelNo', align:'center', sortable: false});
		colLayerModels.push({name:'scenarioResult', index:'scenarioResult', align:'center', sortable: false, formatter:scenarioResult});
		
		//타입별 검색조건 동적 생성
		var trIdx = 0;
		for(var j = 0; j < callReservationCustData.length; j++){
			//Jqgrid 컬럼 동적 생성
			if(callReservationCustData[j].columnKor != "이름" && callReservationCustData[j].columnKor != "전화번호" && callReservationCustData[j].columnKor != "시도횟수" && callReservationCustData[j].columnKor != "대상상태"){
				colLayerNames.push(callReservationCustData[j].columnKor);
				colLayerModels.push({name:'layer_data'+(j+1), index:'layer_data'+(j+1), align:'center', sortable: false});
			}
			if(callReservationCustData[j].columnKor != "시도횟수" && callReservationCustData[j].columnKor != "대상상태"){
				if((trIdx % 3) == 0){
					innerHtml += "<tr>";
				}
				if(callReservationCustData[j].typeName == "radiobox"){
					innerHtml += "<th>"+callReservationCustData[j].columnKor+"</th>";
					innerHtml += "<td>";
					innerHtml += "<div class='checkBox card_type'>";
					innerHtml += "<div class='box'>";
					for(var k = 0; k < callReservationCustData[j].caseType.split(",").length; k++){
						innerHtml += "<input type='checkbox' name='ipt_check2_"+k+"' id='ipt_check2_"+k+"' class='ipt_check' value="+callReservationCustData[j].caseType.split(",")[k]+" onclick='eachChk(this);'>";
						innerHtml += "<label for='ipt_check2_"+k+"'>"+callReservationCustData[j].caseType.split(",")[k]+"</label>";
					}
					innerHtml += "</div>";
					innerHtml += "<div class='box'>";
					innerHtml += "<input type='checkbox' name='ipt_checkAllChk' id='ipt_checkAllChk' class='ipt_check ipt_checkbox_allCheck' onclick='allChk();'>";
					innerHtml += "<label for='ipt_checkAllChk'>전체</label>";
					innerHtml += "</div></div></td>";
					
				}else if(callReservationCustData[j].typeName == "selectbox"){
					if(callReservationCustData[j].caseType != null && callReservationCustData[j].caseType != ""){
						innerHtml += "<th>"+callReservationCustData[j].columnKor+"</th>";
						innerHtml += "<td><select id='multiple_select03_"+callReservationCustData[j].custDataClassId+"' class='select' multiple='multiple'>";
						for(var k = 0; k < callReservationCustData[j].caseType.split(",").length; k++){
							innerHtml += "<option value="+callReservationCustData[j].caseType.split(",")[k]+">"+callReservationCustData[j].caseType.split(",")[k]+"</option>";
						}
						innerHtml += "</select></td>"
					}
				}else{
					innerHtml += "<th>"+callReservationCustData[j].columnKor+"</th>";
					innerHtml += "<td><div class='iptBox'><input type='text' class='ipt_txt' id="+callReservationCustData[j].columnEng+" autocomplete='off'></div></td>";
				}
				
				if((trIdx % 3) == 2){
					innerHtml += "</tr>";
				}
				trIdx = trIdx+1;
			}
		}
		$(".tbody_folding").empty();
		$(".tbody_folding").append(innerHtml);
		$('select[id*="multiple_select03_"').multiselect({
        	includeSelectAllOption: true,
     	});
		//시도횟수 초기화
		$("#multiple_select01").multiselect("clearSelection");
		$("#multiple_select02").multiselect("clearSelection");
		for(var b =0; b < obReservationValue.length; b++){
				//동적 multiSelect select
				for(var a = 0; a < $("#multiple_select03_"+obReservationValue[b].custDataClassId+" option").length; a++) {
					if($("#multiple_select03_"+obReservationValue[b].custDataClassId+" option:eq("+a+")").val() == obReservationValue[b].dataValue) {
						$("#multiple_select03_"+obReservationValue[b].custDataClassId).multiselect("select", obReservationValue[b].dataValue);
					}
				}
				//시도 횟수 select
				for(var d = 0; d < $("#multiple_select01 option").length; d++){
					if($("#multiple_select01 option:eq("+d+")").val() == obReservationValue[b].dataValue) {
						$("#multiple_select01").multiselect("select", obReservationValue[b].dataValue);
					}
				}
				//대상상태 select
				for(var e = 0; e < $("#multiple_select02 option").length; e++){
					if($("#multiple_select02 option:eq("+e+")").val() == obReservationValue[b].dataValue) {
						$("#multiple_select02").multiselect("select", obReservationValue[b].dataValue);
					}
				}
				//체크박스 checked
				for(var c= 0; c< $("input:checkbox[id*='ipt_check2_']").length; c++){
					if(obReservationValue[b].dataValue == $("input:checkbox[id='ipt_check2_"+c+"']").val()){
						$("input:checkbox[id='ipt_check2_"+c+"']").prop("checked", true);
					}
				}
				
				$("#"+obReservationValue[b].columnEng+"").val(obReservationValue[b].dataValue);
		}
		
		if($("input:checkbox[id*='ipt_check2_']:checked").length == $("input:checkbox[id*='ipt_check2_']").length){
			$("#ipt_checkAllChk").prop("checked", true);
		}else if($("input:checkbox[id*='ipt_check2_']:checked").length < $("input:checkbox[id*='ipt_check2_']").length){
			$("#ipt_checkAllChk").prop("checked", false);
		}
		
		
		$(".tbody_folding").removeClass('hide');
		
		$.jgrid.gridUnload('#jqGrid_layer');
		createLayerJqGrid(colLayerNames, colLayerModels);
		lyrGridSearch(1);
		dragElement(document.getElementById("lyr_callReservation"));
		openPopup("lyr_callReservation");
		
	}).fail(function(result) {
		console.log("ajax connection error: getObReservationDetail");
	});
}
//팝업 내 고객정보 조회
function lyrGridSearch(cPageLayer){

	var obj = new Object();
	
	obj.campaignId = $("#campaignIdSelect option:selected").val();
	
	$.ajax({
		url : "${pageContext.request.contextPath}/obReservationSearch",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		// 발송대상 상세 검색
		var callReservationCustData = result.callReservationCustData;
		
		var tempStr = "";
		var checkStr = "";
		var countStr = "";
		var statusStr = "";
		
		var detail = [];
		var insertDetail = [];
		var colLayerNames = [];
		var colLayerModels = [];
		colLayerNames.push("NO.", "이름", "전화번호", "안내 결과");
		colLayerModels.push({name:'layer_no', index:'layer_no', width: 30, align:'center', sortable: false});
		colLayerModels.push({name:'custNm', index:'custNm', align:'center', sortable: false});
		colLayerModels.push({name:'custTelNo', index:'custTelNo', align:'center', sortable: false});
		colLayerModels.push({name:'scenarioResult', index:'scenarioResult', align:'center', sortable: false, formatter:scenarioResult});
		
		//체크된 예약콜 리스트
		$("input:checkbox[id*='ipt_check2_']:checked").each(function(i){
			if(i == 0){
				checkStr = this.value;
			}else{
				checkStr = checkStr+","+this.value;
			}
		});
		
		//이름, 전화번호, 시도횟수, 대상상태를 제외한 JqGrid 칼럼 동정생성
		var lyrIdx = 0;
		for(var e = 0; e < callReservationCustData.length; e++){
			if(callReservationCustData[e].columnKor != "이름" && callReservationCustData[e].columnKor != "전화번호" && callReservationCustData[e].columnKor != "시도횟수" && callReservationCustData[e].columnKor != "대상상태"){
				colLayerNames.push(callReservationCustData[e].columnKor);
				colLayerModels.push({name:'layer_data'+(lyrIdx+1), index:'layer_data'+(lyrIdx+1), align:'center', sortable: false});
				lyrIdx++;
			}else{
				lyrIdx = 0;
			}
		//동정 생성된 multiSelect 값 리스트
		if($("#multiple_select03_"+callReservationCustData[e].custDataClassId).val() != "" && $("#multiple_select03_"+callReservationCustData[e].custDataClassId).val() != null && $("#multiple_select03_"+callReservationCustData[e].custDataClassId).val().length > 0){
			$.each($("#multiple_select03_"+callReservationCustData[e].custDataClassId).val(), function(i, v){
				if(i == 0){
					tempStr = v;	
				}else{
					tempStr = tempStr+","+v;
				}
			});
		}else{
			tempStr = "";
		}
		//시도횟수 값 리스트
		if($("#multiple_select01").val() != "" && $("#multiple_select01").val() != null && $("#multiple_select01 option:selected").length > 0){
			$.each($("#multiple_select01").val(), function(i, v){
				if(i == 0){
					countStr = v;
				}else{
					countStr = countStr+","+v;
				}
			});
		}else{
			countStr = "";
		}
		
		//대상상태 값 리스트
		if($("#multiple_select02").val() != "" && $("#multiple_select02").val() != null && $("#multiple_select02 option:selected").length > 0) {
			$.each($("#multiple_select02").val(), function(i, v){
				if( i == 0){
					statusStr = v;
				}else{
					statusStr = statusStr + "," + v;
				}
			});
		}else{
			statusStr = "";
		}
		
		var temp = {};
		var insertTemp = {};
			if(callReservationCustData[e].typeName == "selectbox"){
				if(callReservationCustData[e].columnKor != "시도횟수" && callReservationCustData[e].columnKor != "대상상태"){
					insertTemp.keyName = callReservationCustData[e].custDataClassId;
					insertTemp.keyValue = tempStr;
					temp.keyName = "$.\""+callReservationCustData[e].custDataClassId+"\"";
					temp.keyValue = tempStr;
				}else if(callReservationCustData[e].columnKor == "시도횟수"){
					temp.keyName = callReservationCustData[e].columnKor;
					temp.keyValue = countStr;
					insertTemp.keyName = callReservationCustData[e].custDataClassId;
					insertTemp.keyValue = countStr;
				}else if(callReservationCustData[e].columnKor == "대상상태"){
					temp.keyName = callReservationCustData[e].columnKor;
					temp.keyValue = statusStr;
					insertTemp.keyName = callReservationCustData[e].custDataClassId;
					insertTemp.keyValue = statusStr;
				}
			}else if(callReservationCustData[e].typeName == "radiobox"){
					insertTemp.keyName = callReservationCustData[e].custDataClassId;
					insertTemp.keyValue = checkStr;
					temp.keyName = "$.\""+callReservationCustData[e].custDataClassId+"\"";
					temp.keyValue = checkStr;
			}else{
				if($("#"+callReservationCustData[e].columnEng+"").val() != null || $("#"+callReservationCustData[e].columnEng+"").val() != ""){
						insertTemp.keyName = callReservationCustData[e].custDataClassId;
						insertTemp.keyValue = $("#"+callReservationCustData[e].columnEng+"").val();
						temp.keyName = "$.\""+callReservationCustData[e].custDataClassId+"\"";
						temp.keyValue = $("#"+callReservationCustData[e].columnEng+"").val();
				}
				if(callReservationCustData[e].columnKor == "이름" || callReservationCustData[e].columnKor == "전화번호"){
						temp.keyName = callReservationCustData[e].columnKor;
						temp.keyValue = $("#"+callReservationCustData[e].columnEng+"").val();
				}
			}
			detail[e] = temp;
			insertDetail[e] = insertTemp;
		}
		
		$.jgrid.gridUnload('#jqGrid_layer');
		createLayerJqGrid(colLayerNames, colLayerModels);
		
		$("#insertCustDetail").val(JSON.stringify(insertDetail));
		lyrSearch(cPageLayer ,detail, countStr, statusStr);
		
	}).fail(function(result) {
		console.log("ajax connection error: getObReservationDetail");
	});
	
}

function lyrSearch(cPageLayer, detail, countStr, statusStr) {
	
	var obj = new Object();
	
	obj.campaignId = $("#campaignIdSelect option:selected").val();
	obj.custDataArray = detail;
	obj.callTryCount = countStr;
	obj.objectStatus = statusStr;
	
	obj.page = cPageLayer; // current page 
	obj.lastpage =  $('#jqGrid_layer').getGridParam('lastpage'); // current page 
	obj.rowNum = jQuery("#jqGrid_layer").getGridParam('rowNum'); //페이지 갯수
	obj.allRecords = jQuery("#jqGrid_layer").getGridParam('records'); 
	obj.endPageCnt = jQuery("#jqGrid_layer").getGridParam('rowNum');//마지막페이지 cnt
	obj.offset = (obj.page * obj.rowNum)-obj.rowNum;
		
	$("#jqGrid_layer").setGridParam({loadonce:false, datatype	: "json",postData	: JSON.stringify(obj)}).trigger("reloadGrid");
	
}

function saveReservation(){
	var saveType = $("#saveType").val();
	
	if(saveType == "insert"){
		
		var custData = $("#insertCustDetail").val();
		var reservationNm = $("#reservationNm").val();
		var reservationExp = $("#reservationExp").val();
		var startDtm = $("#fromDate").val();
		var endDtm = $("#toDate").val();
		var reservationTime = $("#dispatchTime option:selected").val();
		var reservationMin = $("#dispatchMin option:selected").val();
		
		var checkWeek = "";
		for(var i = 0; i< $("input[id*=ipt_check_]").length; i++){
		    if($("input[id=ipt_check_"+i+"]").is(":checked") == true){
		        if ($("input[id*=ipt_check_]:checked").length == 1){
		       	    checkWeek = $("input[id=ipt_check_"+i+"]:checked").val();
		        }else{
		       	    checkWeek = checkWeek + "," + $("input[id=ipt_check_"+i+"]:checked").val();
   				}
		    }
		}
		if(checkWeek.length > 1){
			checkWeek = checkWeek.substr(1,checkWeek.length);
		}
		
		var obj = new Object();
		
		obj.campaignId = $("#campaignIdSelect option:selected").val();
		obj.cdName = reservationNm;
		obj.cdDesc = reservationExp;
		obj.startDtm = startDtm;
		obj.endDtm = endDtm;
		obj.dispatchTime = reservationTime + ":" + reservationMin;
		obj.weekDay = checkWeek;
		obj.custData = custData;
		
		$.ajax({
			url : "${pageContext.request.contextPath}/insertObReservation",
			data : JSON.stringify(obj),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
		}).success(function(result) {
			alert("등록이 완료 되었습니다.");
			hidePopup("lyr_callReservation");
			$.jgrid.gridUnload('#jqGrid');
			createJqGrid();
			gridSearch($("#cPage").val(), "N");
		}).fail(function(result) {
			console.log("ajax connection error: getObReservationDetail");
		});
		
		
	}else if(saveType == "update"){
		
		var custData = $("#insertCustDetail").val();
		var reservationNm = $("#reservationNm").val();
		var reservationExp = $("#reservationExp").val();
		var startDtm = $("#fromDate").val();
		var endDtm = $("#toDate").val();
		var reservationTime = $("#dispatchTime option:selected").val();
		var reservationMin = $("#dispatchMin option:selected").val();
		
		var checkWeek = "";
		for(var i = 0; i< $("input[id*=ipt_check_]").length; i++){
		    if($("input[id=ipt_check_"+i+"]").is(":checked") == true){
		        if ($("input[id*=ipt_check_]:checked").length == 1){
		       	    checkWeek = $("input[id=ipt_check_"+i+"]:checked").val();
		        }else{
		       	    checkWeek = checkWeek + "," + $("input[id=ipt_check_"+i+"]:checked").val();
   				}
		    }
		}
		if(checkWeek.length > 1){
			checkWeek = checkWeek.substr(1,checkWeek.length);
		}
		var obj = new Object();
		
		obj.id = $("#autoCallConditionId").val();
		obj.campaignId = $("#campaignIdSelect option:selected").val();
		obj.cdName = reservationNm;
		obj.cdDesc = reservationExp;
		obj.startDtm = startDtm;
		obj.endDtm = endDtm;
		obj.dispatchTime = reservationTime + ":" + reservationMin;
		obj.weekDay = checkWeek;
		obj.custData = custData;
		
		$.ajax({
			url : "${pageContext.request.contextPath}/updateObReservation",
			data : JSON.stringify(obj),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
		}).success(function(result) {
			alert("수정이 완료 되었습니다.");
			hidePopup("lyr_callReservation");
			$.jgrid.gridUnload('#jqGrid');
			createJqGrid();
			gridSearch($("#cPage").val(), "N");
		}).fail(function(result) {
			console.log("ajax connection error: getObReservationDetail");
		});
		
		
	}
}
//예약콜 리스트 삭제
function deleteReservation(){
	
	var idArr = new Array();
	
	$("input[id*=checkbox]:checked").each(function() {
		idArr.push($(this).val());
	});

	var obj = new Object();
	
	obj.idArr = idArr;
	
	$.ajax({
		url : "${pageContext.request.contextPath}/deleteObReservation",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		alert("삭제가 완료 되었습니다.");
		$.jgrid.gridUnload('#jqGrid');
		createJqGrid();
		gridSearch($("#cPage").val(), "N");
	}).fail(function(result) {
		console.log("ajax connection error: getObReservationDetail");
	});
	
	
}

</script>
</body>
</html>
