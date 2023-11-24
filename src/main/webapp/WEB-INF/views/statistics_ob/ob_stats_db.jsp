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
<!-- .potalWrap -->
<div class="potalWrap">
	<!-- #header -->
	<jsp:include page="../common/inc_header.jsp">
		<jsp:param name="titleCode" value="A0311"/>
		<jsp:param name="titleTxt" value="콜 통계(DB기준)"/>
	</jsp:include>
	<!-- .#header -->

    <!-- #container -->
    <div id="container">
        <!-- 검색조건 -->
        <div class="srchArea">
            <table class="tbl_line_view" summary="검색유형/모음기준/제외여부/검색일자/개인지정으로 구성됨">
                <caption class="hide">검색조건</caption>
                <colgroup>
                    <col width="100"><col><col width="100"><col>
                    <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row">검색유형</th>
                    <td>
                        <div class="radioBox">
                            <input type="radio" name="ipt_radio1" id="ipt_radio1_1" value="30min" class="ipt_radio">
                            <label for="ipt_radio1_1">30분 단위</label>
                            <input type="radio" name="ipt_radio1" id="ipt_radio1_2" value="hourly" class="ipt_radio">
                            <label for="ipt_radio1_2">시간 단위</label>
                            <input type="radio" name="ipt_radio1" id="ipt_radio1_3" value="daily" class="ipt_radio" checked>
                            <label for="ipt_radio1_3">일 단위</label>
                            <input type="radio" name="ipt_radio1" id="ipt_radio1_4" value="weekdays" class="ipt_radio">
                            <label for="ipt_radio1_4">요일 단위</label>
                            <input type="radio" name="ipt_radio1" id="ipt_radio1_5" value="monthly" class="ipt_radio">
                            <label for="ipt_radio1_5">월 단위</label>
                            <!-- [D] <label>의 for값과 <input>의 ID 값을 동일하게 작성해야 함 -->
                        </div>
                    </td>
                    <th scope="row">검색일자</th>
                    <td>
                        <div class="iptBox">
                            <input type="text" name="fromDate" id="fromDate" class="ipt_date"  autocomplete="off">
                        </div>
                        <select class="select" id="fromHour">
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
                        <select class="select" id="fromMin">
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
                        <select class="select" id="toHour">
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
                        <select class="select" id="toMin">
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
        <!-- .chartBox -->
        <div class="chartBox">
            <canvas id="barChart"></canvas>
        </div>
        <!-- //.chartBox -->
    </div>
    <!-- //#container -->

    <hr>
    <!-- #footer -->
    <div id="footer">
        <div class="cyrt"><span>&copy; MINDsLab. All rights reserved.</span></div>
    </div>
    <!-- //#footer -->
</div>
<!-- //#potalWrap -->
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

        $("#search").on("click", function(){
        	//gridSearch($('#jqGrid').getGridParam('page'));
        	gridSearch(1);
		});

        $("#export").on("click", function(){
			$("#jqGrid").jqGrid("exportToExcel",{
      		  includeLabels : true,
    		  includeGroupHeader : true,
    		  includeFooter: true,
    		  fileName : "O/B Call 통계-DB.xlsx",
    		  mimetype : "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    		  maxlength : 40,
    		  onBeforeExport : null,
    		  replaceStr : null,
    		  loadIndicator : true
    		});
		});

        //jqGrid(data)
        /* var mydata = [
            {divide:'00:00', dbNum:'70',
             callSuccess:'50', callEngaged:'5', missingNnumber:'5', callBlock:'10', total01:'70',
             aimSuccess:'20', recall:'5', callMissed:'5', cutOff:'10', callReject:'5', total02:'50',
			 connect:'71.4%',
             dbStandard:'28.6%', connectStandard:'40.0%',
			 totalCallTime01:'04:30:00', averageCallTime01:'00:05:24',
			 totalCallTime02:'04:30:00', averageCallTime02:'00:05:24'
			},
		] */

        //jqGrid
        $("#jqGrid").jqGrid({
        	url: "${pageContext.request.contextPath}/getObStatsDBJQList",
            //data: mydata,
            datatype: "local",
            rowNum: 30,
            //rowList: [10,20,30],
            colNames:['구분','사용DB수','연결성공','통화중','결번','수신거부','계','목적성공','재통화예약','부재중','통화중끊김','통화거부','계','연결율','DB기준','연결기준','총통화시간','평균통화시간','총통화시간','평균통화시간'],
            colModel:[
				{name:'divide', index:'divide', width:70, align:'center'},
                {name:'dbNum', index:'dbNum', width:70, align:'center'},
                {name:'callSuccess',index:'callSuccess', width:70, align:'center'},
				{name:'callEngaged',index:'callEngaged', width:50, align:'center'},
				{name:'missingNnumber',index:'missingNnumber', width:50, align:'center'},
				{name:'callBlock',index:'callBlock', width:60, align:'center'},
				{name:'total01',index:'total01', width:50, align:'center'},
				{name:'aimSuccess',index:'aimSuccess', width:70, align:'center'},
				{name:'recall',index:'recall', width:80, align:'center'},
				{name:'callMissed',index:'callMissed', width:50, align:'center'},
				{name:'cutOff',index:'cutOff', width:80, align:'center'},
				{name:'callReject',index:'callReject', width:60, align:'center'},
				{name:'total02', index:'total02', width:50, align:'center'},
				{name:'connect', index:'connect', width:60, align:'center'},
				{name:'dbStandard', index:'dbStandard', width:60, align:'center'},
                {name:'connectStandard', index:'connectStandard', width:60, align:'center'},
				{name:'totalCallTime01', index:'totalCallTime01', width:90, align:'center', formatoptions:{newformat:'H:i:s'}, datefmt:'H:i:s'},
				{name:'averageCallTime01', index:'averageCallTime01', width:90, align:'center', formatoptions:{newformat:'H:i:s'}, datefmt:'H:i:s'},
				{name:'totalCallTime02', index:'totalCallTime02', width:90, align:'center', formatoptions:{newformat:'H:i:s'}, datefmt:'H:i:s'}	,
                {name:'averageCallTime02', index:'averageCallTime02', width:90, align:'center', formatoptions:{newformat:'H:i:s'}, datefmt:'H:i:s'}
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
				{startColumnName:'callSuccess', numberOfColumns:5, titleText:'시도결과'},
				{startColumnName:'aimSuccess', numberOfColumns:6, titleText:'연결결과'},
				{startColumnName:'dbStandard', numberOfColumns:2, titleText:'성공율'},
                {startColumnName:'totalCallTime01', numberOfColumns:2, titleText:'연결성공건'},
                {startColumnName:'totalCallTime02', numberOfColumns:2, titleText:'목적성공건'}
			]
		});
		$("#jqGrid").jqGrid('setGroupHeaders', {
			useColSpanStyle: true,
			groupHeaders:[
				{startColumnName:'callEngaged', numberOfColumns:3, titleText:'연결실패'},
				{startColumnName:'recall', numberOfColumns:4, titleText:'목적실패'},
			]
		});

	});
});
</script>
<script>
// chart
var barChartData = {
    type: 'bar',
    data: {
        labels: ['00:00','00:30','01:00','01:30','02:00','02:30','03:00','02:30',],
        datasets: [{
            label: '통화시도',
            backgroundColor: 'rgba(178,180,195,1.0)',
            borderColor: 'rgba(178,180,195,1.0)',
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ],
            fill: false,
        },{
            label: '통화연결',
            backgroundColor: 'rgba(75,192,192,1.0)',
            borderColor: 'rgba(75,192,192,1.0)',
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ],
            fill: false,
        },{
            label: '통화성공(목적성공)',
            backgroundColor: 'rgba(54,162,235,1.0)',
            borderColor: 'rgba(54,162,235,1.0)',
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ],
            fill: false,
        }]
    },
    options: {
        maintainAspectRatio: false,
        responsive: true,
        title: {
            display: false,
        },
        tooltips: {
            mode: 'index',
            intersect: false,
        },
        hover: {
            mode: 'nearest',
            intersect: true
        },
		legend: {
			display: true,
            position: 'top',
		},
        scales: {
            xAxes: [{
                display: true,
                scaleLabel: {
                    display: false,
                    labelString: 'Time'
                },
                ticks: {
                    autoSkip: true,
                    maxRotation: 0,
                    minRotation: 0
                }
            }],
            yAxes: [{
                display: true,
                scaleLabel: {
                    display: false,
                    labelString: 'Value'
                }
            }]
        }
    }
};
var barChart = document.getElementById('barChart').getContext('2d');
window.myLine = new Chart(barChart, barChartData);


function gridSearch(currentPage) {

	console.log(currentPage);
	var endPageCnt = jQuery("#jqGrid").getGridParam('records').toString();

	var obj = new Object();
	//obj.checkBox1 = $("input[name=checkBox2]:checked").val(); // 채널유형  call / chat / all
	//obj.ipt_text_1 = $("#ipt_text_1").val();	   // 총응대시간
	//obj.checkBox3 = $("input[name=checkBox3]:checked").val(); // 제외여부

	obj.radioBox1 = $("input[name=ipt_radio1]:checked").val();

	obj.fromDate = $("#fromDate").val();
	obj.fromHour = $("#fromHour option:selected").val();
	obj.fromMin = $("#fromMin option:selected").val();

	obj.toDate = $("#toDate").val();
	obj.toHour = $("#toHour option:selected").val();
	obj.toMin = $("#toMin option:selected").val();

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
