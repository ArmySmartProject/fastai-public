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
	<!-- #header -->
	<jsp:include page="../common/inc_header.jsp">
		<jsp:param name="titleCode" value="A0009"/>
		<jsp:param name="titleTxt" value="콜 이력조회"/>
	</jsp:include>
	<!-- .#header -->

    <!-- #container -->
    <div id="container">
        <!-- 검색조건 -->
        <div class="srchArea">
            <table class="tbl_line_view" summary="검색일자,고객조회,유형검색,DB별 최종 값 기준으로 구성됨">
                <caption class="hide">검색조건</caption>
                <colgroup>
                    <col width="100"><col><col width="100"><col>
                    <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row">검색일자</th>
                    <td>
                        <div class="iptBox">
                            <input type="text" name="fromDate" id="fromDate" class="ipt_date" autocomplete="off">
                        </div>
                        <select class="select">
                            <option>00</option>
                            <option>01</option>
                            <option>02</option>
                            <option>03</option>
                            <option>04</option>
                            <option>05</option>
                            <option>06</option>
                            <option>07</option>
                            <option>08</option>
                            <option>09</option>
                            <option>10</option>
                            <option>11</option>
                            <option>12</option>
                            <option>13</option>
                            <option>14</option>
                            <option>15</option>
                            <option>16</option>
                            <option>17</option>
                            <option>18</option>
                            <option>19</option>
                            <option>20</option>
                            <option>21</option>
                            <option>22</option>
                            <option>23</option>
                        </select>
                        <span>시</span>
                        <select class="select">
                            <option>00</option>
                            <option>05</option>
                            <option>10</option>
                            <option>15</option>
                            <option>20</option>
                            <option>25</option>
                            <option>30</option>
                            <option>35</option>
                            <option>40</option>
                            <option>45</option>
                            <option>50</option>
                            <option>55</option>
                        </select>
                        <span>분</span>
                        <span>-</span>
                        <div class="iptBox">
                            <input type="text" name="toDate" id="toDate" class="ipt_date" autocomplete="off">
                        </div>
                        <select class="select">
                            <option>00</option>
                            <option>01</option>
                            <option>02</option>
                            <option>03</option>
                            <option>04</option>
                            <option>05</option>
                            <option>06</option>
                            <option>07</option>
                            <option>08</option>
                            <option>09</option>
                            <option>10</option>
                            <option>11</option>
                            <option>12</option>
                            <option>13</option>
                            <option>14</option>
                            <option>15</option>
                            <option>16</option>
                            <option>17</option>
                            <option>18</option>
                            <option>19</option>
                            <option>20</option>
                            <option>21</option>
                            <option>22</option>
                            <option>23</option>
                        </select>
                        <span>시</span>
                        <select class="select">
                            <option>00</option>
                            <option>05</option>
                            <option>10</option>
                            <option>15</option>
                            <option>20</option>
                            <option>25</option>
                            <option>30</option>
                            <option>35</option>
                            <option>40</option>
                            <option>45</option>
                            <option>50</option>
                            <option>55</option>
                        </select>
                        <span>분</span>
                    </td>
                    <th>고객조회</th>
                    <td>
                        <select class="select" name="ipt_select1_1" id="ipt_select1_1">
                            <option>성명</option>
                            <option>전화번호</option>
                            <option>주민번호6자리</option>
                            <option>메일주소</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>유형검색</th>
                    <td>
                        <select id="multiple_select" class="select" multiple="multiple">
                            <option>전체</option>
                            <option>연결성공 (목적성공)</option>
                            <option>연결성공 (부재중)</option>
                        </select>
                    </td>
                    <td colspan="2">
                        <div class="checkBox">
                            <input type="checkbox" name="ipt_check1_1" id="ipt_check1_1" class="ipt_check" checked="checked">
                            <label for="ipt_check1_1">DB별 최종값 기준</label>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
	            <div class="btnBox sz_small line">
	            	<button type="button" class="btnS_basic" id="search">검색</button>
	            	<button type="button" class="btnS_basic" id="export">다운로드</button>
	        	</div>
        </div>
        <!-- //검색조건 -->

        <!-- .jqGridBox -->
        <div class="jqGridBox">
            <table id="jqGrid"></table>
            <div id="jqGridPager"></div>
        </div>
        <!-- //.jqGridBox -->
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

<!-- library -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap-multiselect.js"></script>


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

        //datetimepicker
        $('#fromDate').datepicker({
			format : "yyyy-mm-dd",
			language : "ko",
			autoclose : true,
			todayHighlight : true
        });

        $('#toDate').datepicker({
			format : "yyyy-mm-dd",
			language : "ko",
			autoclose : true,
			todayHighlight : true
        });

        //multiple_select
        $('#multiple_select').multiselect({
          includeSelectAllOption: true,
        });

        $("#search").on("click", function(){
        	//gridSearch($('#jqGrid').getGridParam('page'));
        	gridSearch(1);
		});

        $("#export").on("click", function(){
			$("#jqGrid").jqGrid("exportToExcel",{
      		  includeLabels : true,
    		  includeGroupHeader : true,
    		  includeFooter: true,
    		  fileName : "O/B 상담원별 Call 통계.xlsx",
    		  mimetype : "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    		  maxlength : 40,
    		  onBeforeExport : null,
    		  replaceStr : null,
    		  loadIndicator : true
    		});
		});

        //jqGrid(data)
        /*  var mydata = [
            {num:'1', customer:'홍길동', contact1:'010-****-5678',
             userId:'901212-1******', adviser:'음성봇1 (상담사1)', tryResult:'재통화예약', callResult:'목적성공',
             callStartTime:'2019-10-03 10:12:03', callEndTime:'2019-10-03 10:12:03',
             botCallTime:'04:30:00', csrCallTime:'04:30:00', totalTime:'04:30:00',
			 contact2:'010-****-5678', reserve:'2019-10-03 10:12:03',
			 memo:'ㄸㄸㄸㄸ',
			},
		] */

        //jqGrid
        $("#jqGrid").jqGrid({
        	url: "${pageContext.request.contextPath}/getObStatsCallListJQList",
            //data: mydata,
            datatype: "local",
            height: 'auto',
            rowNum: 30,
            //rowList: [10,20,30],
            colNames:['No.','고객명','연락처','고객번호<br>식별(ID등)','상담원','시도결과','통화결과','통화시작시간','통화종료시간','Bot통화시간','CSR통화시간','총 시간','연락처','예약 일시','상담메모'],
            colModel:[
				{name:'num', index:'num', width:50, align:'center'},
                {name:'customer', index:'customer', width:70, align:'center'},
                {name:'contact1', index:'contact1', width:100, align:'center'},
                {name:'userId',index:'userId', width:70, align:'center'},
				{name:'adviser',index:'adviser', width:100, align:'center'},
				{name:'tryResult',index:'tryResult', width:50, align:'center'},
				{name:'callResult',index:'callResult', width:60, align:'center',},
				{name:'callStartTime',index:'callStartTime', width:90, align:'center', formatoptions:{newformat:'H:i:s'}, datefmt:'H:i:s'},
				{name:'callEndTime',index:'callEndTime', width:90, align:'center', formatoptions:{newformat:'H:i:s'}, datefmt:'H:i:s'},
				{name:'botCallTime',index:'botCallTime', width:80, align:'center', formatoptions:{newformat:'H:i:s'}, datefmt:'H:i:s'},
				{name:'csrCallTime',index:'csrCallTime', width:50, align:'center', formatoptions:{newformat:'H:i:s'}, datefmt:'H:i:s'},
				{name:'totalTime',index:'totalTime', width:80, align:'center', formatoptions:{newformat:'H:i:s'}, datefmt:'H:i:s'},
				{name:'contact2', index:'contact2', width:60, align:'center',},
				{name:'reserve', index:'reserve', width:60, align:'center',},
                {name:'memo', index:'memo', width:60, align:'center',},
            ],
            pager: "#jqGridPager",
            height: 500,
            viewrecords: true,
            sortname: 'name',
            grouping:true,

            mtype: "POST",
            ajaxGridOptions: { contentType: "application/json" },
            loadBeforeSend: function(jqXHR) {
            	jqXHR.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
            },
            gridview: true,
            loadonce: false,
            jsonReader : {
            	root: "rows",
            	page: "page",
            	total: "total",
            	record: "records",
            	repeatitems: false,
            },

            onPaging: function(pgButton){     //페이징 처리
            	var gridPage = $("#jqGrid").getGridParam("page");                     // 현재 페이지 번호
                var rowNum = $("#jqGrid").getGridParam("rowNum");                // 뿌려줄 row 개수
                var records = $("#jqGrid").getGridParam("records");                //  총 레코드
                var totalPage = Math.ceil(records/rowNum);             	 // 총 페이지

                console.log(pgButton);
                console.log(gridPage);
                console.log(totalPage);

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
                	var nowPage = Number($("#jqGridPager.ui-pg-input").val());

                	if (totalPage >= nowPage && nowPage > 0) {
                		gridPage = nowPage;
                	} else {
                		$("#jqGridPager.ui-pg-input").val(page);
                		gridPage = page;
                	}
                } else if (pgButton == "records") {
                	gridPage = 1;
                }
                gridSearch(gridPage);
        	}

        });

		$("#jqGrid").jqGrid('setGroupHeaders', {
			useColSpanStyle: true,
			groupHeaders:[
				{startColumnName:'botCallTime', numberOfColumns:3, titleText:'총통화시간'},
				{startColumnName:'contact2', numberOfColumns:2, titleText:'재통화'},
			]
		});

	});
});

function gridSearch(currentPage) {

	console.log(currentPage);
	var endPageCnt = jQuery("#jqGrid").getGridParam('records').toString();

	var obj = new Object();
	//obj.checkBox1 = $("input[name=checkBox2]:checked").val(); // 채널유형  call / chat / all
	//obj.ipt_text_1 = $("#ipt_text_1").val();	   // 총응대시간
	//obj.checkBox3 = $("input[name=checkBox3]:checked").val(); // 제외여부

	obj.fromDate = $("#fromDate").val();
	obj.toDate = $("#toDate").val();

	obj.custId = $("#custId").val();

	obj.page = currentPage;
	obj.lastpage = $('#jqGrid').getGridParam('lastpage');
	obj.rowNum = jQuery("#jqGrid").getGridParam('rowNum');
	obj.allRecords = jQuery("#jqGrid").getGridParam('records');
	obj.offset = (obj.page * obj.rowNum)-obj.rowNum;

	obj.endPageCnt = Number(endPageCnt.substr(-1)); //마지막페이지 cnt

	$("#jqGrid").setGridParam({datatype : "json", postData : JSON.stringify(obj)}).trigger("reloadGrid");
}

</script>
</body>
</html>
