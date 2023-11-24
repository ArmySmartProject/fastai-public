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
	<div id="pageldg" class="page_loading">
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
		    <jsp:param name="titleCode" value="A0248"/>
		    <jsp:param name="titleTxt" value="문의유형별통계"/>
		</jsp:include>
        <!-- //#header -->
        <!-- #container -->
        <div id="container">
        <input type="hidden" id="cPage" value="1"/>
            <!-- 검색조건 -->
            <div class="srchArea">
                <table class="tbl_line_view" summary="검색유형/채널유형/제외여부/검색일자/개인지정으로 구성됨">
                    <caption class="hide">검색조건</caption>
                    <colgroup>
                        <col width="100"><col width="470"><col width="100"><col><col width="100">
                        <col>
                        <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                    </colgroup>
                    <tbody>
                    <tr>
                        <th scope="row"><spring:message code="A0206" text="검색유형"/></th>
                        <td>
                            <div class="checkBox">                                            
                                <input type="checkbox" name="checkBox1" id="ipt_check1_1" value="daily" class="ipt_check" checked>
                                <label for="ipt_check1_1"><spring:message code="A0209" text="일 단위"/></label>
                                <input type="checkbox" name="checkBox1" id="ipt_check1_2" value="weekly" class="ipt_check">
                                <label for="ipt_check1_2"><spring:message code="A0239" text="요일 단위"/></label>
                                <input type="checkbox" name="checkBox1" id="ipt_check1_3" value="monthly" class="ipt_check">
                                <label for="ipt_check1_3"><spring:message code="A0210" text="월 단위"/></label>
                                <!-- [D] <label>의 for값과 <input>의 ID 값을 동일하게 작성해야 함 -->
                            </div>
                        </td>
                        <th><spring:message code="A0171" text="채널유형"/></th>
                        <td>
                            <div class="checkBox">                                            
                                <!-- <input type="checkbox" name="checkBox2" id="ipt_check2_1" value="call" class="ipt_check" disabled="disabled">
                                <label for="ipt_check2_1"><spring:message code="A0151" text="Call"/></label>
                                <input type="checkbox" name="checkBox2" id="ipt_check2_2" value="chat" class="ipt_check" disabled="disabled">
                                <label for="ipt_check2_2"><spring:message code="A0152" text="Chat"/></label> -->
                                <input type="checkbox" name="checkBox2" id="ipt_check2_3" value="all" class="ipt_check" checked="checked" onclick="return false;">
                                <label for="ipt_check2_3"><spring:message code="A0172" text="전체"/></label>
                            </div>
                        </td>
                        <th><spring:message code="A0175" text="제외여부"/></th>
                        <td>
                            <div class="checkBox">                                            
                                <input type="checkbox" name="checkBox3" id="ipt_check3_1" value="exception" class="ipt_check" checked>
                                <label for="ipt_check3_1"><spring:message code="A0176" text="공휴일 제외"/></label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><spring:message code="A0211" text="검색일자"/></th>
                        <td>
                            <div class="iptBox">
                                <input type="text" name="fromDate" id="fromDate" class="ipt_dateTime">
                                <span>-</span>
                                <input type="text" name="toDate" id="toDate"  class="ipt_dateTime">
                            </div>
                        </td>
                        <th><spring:message code="A0243" text="개인지정"/></th>
                        <td colspan="3">
                            <select class="select" id="ipt_select1_1">
                                <option><spring:message code="A0172" text="전체"/></option>
                            </select>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div class="btnBox sz_small line">
                <button type="button" class="btnS_basic" id="search"><spring:message code="A0180" text="검색"/></button>
                <%-- <button type="button" class="btnS_basic"><spring:message code="A0181" text="출력"/></button> --%>
                <button type="button" class="btnS_basic" id="export"><spring:message code="A0182" text="다운로드"/></button>
            </div>
            </div>
            <!-- //검색조건 -->
            
            <!-- .jqGridBox -->
            <div class="jqGridBox">
                <table id="jqGrid"></table>
                <div id="jqGridPager"></div>
            </div>
            <!-- //.jqGridBox -->
            <div style="display:none;">
            	<table id="jqGrid_excel"></table>
            	<div id="jqGrid_excel_Pager"></div>
            </div>
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
<!-- //#wrap -->

<%@ include file="../common/inc_footer.jsp"%>     
<!-- script -->  
<script type="text/javascript">

var myChart = null;

jQuery.event.add(window,"load",function(){
	$(document).ready(function (){
        //고객정보 변경
        $('.btn_userInfoModify.btn_lyr_open').on('click',function(){	
            $('.lyr_userInfoModify').show();    
        });	
        
        //오늘 날짜를 출력
        //$("#today").text(new Date().toLocaleDateString());

        //datepicker 한국어로 사용하기 위한 언어설정
        //$.datepicker.setDefaults($.datepicker.regional['ko']); 

        // 시작일(fromDate)은 종료일(toDate) 이후 날짜 선택 불가
        // 종료일(toDate)은 시작일(fromDate) 이전 날짜 선택 불가        
        
        //datepicker
		$('#fromDate').datepicker({
			format : "yyyy-mm-dd",
			language : "ko",
			autoclose : true,
			todayHighlight : true,
		});
	
		$('#toDate').datepicker({
			format : "yyyy-mm-dd",
			language : "ko",
			autoclose : true,
			todayHighlight : true
		});
		
		var tDate = new Date();
        tDate = getFormatDate(tDate);
		$("#fromDate").val(tDate);
		$("#toDate").val(tDate);
		
		//$('#fromDate').datepicker('setDate', '-7D');
        //$('#toDate').datepicker('setDate', 'today');             
        
        // 체크박스 1
		$(document).ready(function() {
		    //radio버튼처럼 checkbox name값 설정
		    $('input[type="checkbox"][name="checkBox1"]').click(function(){
		        //click 이벤트가 발생했는지 체크
		        if ($(this).prop('checked')) {
		            //checkbox 전체를 checked 해제후 click한 요소만 true지정
		            $('input[type="checkbox"][name="checkBox1"]').prop('checked', false);
		            $(this).prop('checked', true);
		        }
		    });
		});
        
        //체크박스 2
		$(document).ready(function() {
		    //radio버튼처럼 checkbox name값 설정
		    $('input[type="checkbox"][name="checkBox2"]').click(function(){
		        //click 이벤트가 발생했는지 체크
		        if ($(this).prop('checked')) {
		            //checkbox 전체를 checked 해제후 click한 요소만 true지정
		            $('input[type="checkbox"][name="checkBox2"]').prop('checked', false);
		            $(this).prop('checked', true);
		        }
		    });
		});
        
        //jqGrid(data) 

        //jqGrid
        var jqGridBoxWidth = $('.jqGridBox').width()-1;
        
        var gridOption = {
            	url: "${pageContext.request.contextPath}/getIbStatsTypeJQList",
            	//data: jqGridData,
        	    datatype: "local",    		
        	    height: 'auto',
        	    height: 300,
                rowNum: 30,
                //rowList: [10,20,30],
                colNames:[
                	'<spring:message code="A0225" text="날짜"/>', 
                	'<spring:message code="A0195" text="VOC"/>',
                	'<spring:message code="A0196" text="직원의 소리"/>',
                	'-',
                	'<spring:message code="A0197" text="기타문의"/>',
                	'<spring:message code="A0198" text="세제/법규/기타 등"/>',
                	'<spring:message code="A0199" text="기타 일반상담"/>',
                	'<spring:message code="A0200" text="부품관련문의"/>',
                	'<spring:message code="A0201" text="부품결품"/>',
                	'<spring:message code="A0202" text="구동계통 결품 불만"/>'
                	],
                colModel:[
                    {name:'DATE',index:'DATE', width:90, align:'center', sorttype:'date', formatoptions:{newformat:'M-d'}, datefmt:'M-d'},
                    {name:'TYPE01',index:'TYPE01', width:50, align:'center', summaryType:'sum'},                
                    {name:'TYPE0102', index:'TYPE0102', width:50, align:'center', summaryType:'sum'},
                    {name:'TYPE010203',index:'TYPE010203', width:50, align:'center', summaryType:'sum'},
    				{name:'TYPE02',index:'TYPE02', width:50, align:'center', summaryType:'sum'},
    				{name:'TYPE0201',index:'TYPE0201', width:50, align:'center', summaryType:'sum'},
    				{name:'TYPE020103',index:'TYPE020103', width:50, align:'center', summaryType:'sum'},
    				{name:'TYPE03',index:'TYPE03', width:50, align:'center', summaryType:'sum'},
    				{name:'TYPE0301',index:'TYPE0301', width:50, align:'center', summaryType:'sum'},
    				{name:'TYPE030102',index:'TYPE030102', width:50, align:'center', summaryType:'sum'},
    				//{name:'etc05',index:'etc05', width:50, align:'center', summaryType:'sum'}
                ],
                pager: "#jqGridPager",            
    			viewrecords: true,
    			sortname: 'DATE',
    			grouping:true,
    			groupingView : {
                    groupField : ['DATE'],
                    groupSummary : [true, true],
                    groupColumnShow : [true, true],
                    groupText : ['<b>{0}</b>'],
                    groupOrder: ['asc'],
    		        groupCollapse: false
            
                },
                               	    
        	    mtype: 'POST',
        	    ajaxGridOptions: { contentType: "application/json" },
        	    loadBeforeSend: function(jqXHR) {
                	jqXHR.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
        	    },
        	    
        	    gridview: true,
        	    loadonce: false,
        	    width: jqGridBoxWidth,
                //footerrow: true,
                //userDataOnFooter: true, // use the userData parameter of the JSON response to display data on footer
                
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
            	},
            	
            	loadComplete: function (data) {
            		console.log(data.rows.length);
    	    		if(data.rows.length > 0){
        				//var arrLabels = new Array(); 
        				var arrType01 = new Array();
        				var arrType0102 = new Array();
        				var arrType010203 = new Array();
        				var arrType02 = new Array();
        				var arrType0201 = new Array();
        				var arrType020103 = new Array();
        				var arrType03 = new Array();
        				var arrType0301 = new Array();
        				var arrType030102 = new Array();
    	    		
        				$.each(data.rows, function(key, value){
        					console.log(value);
        					//arrLabels[key] = value.DATE;
        					arrType01[key] = value.TYPE01;
        					arrType0102[key] = value.TYPE0102;
        					arrType010203[key] = value.TYPE010203;
        					arrType02[key] = value.TYPE02;
        					arrType0201[key] = value.TYPE0201;
        					arrType020103[key] = value.TYPE020103;
        					arrType03[key] = value.TYPE03;
        					arrType0301[key] = value.TYPE0301;
        					arrType030102[key] = value.TYPE030102;    					
        				});
        				
        				function sum(array) {
     						var result = 0;
     					 	for (var i = 0; i < array.length; i++)
     							result += array[i];
     					  	return result;
        				};
        				
        				var barChartData = {
        					    type: 'bar',
        					    data: {  
        					        labels: [
        				            	'<spring:message code="A0195" text="VOC"/>',
        				            	'<spring:message code="A0196" text="직원의 소리"/>',
        				            	'-',
        				            	'<spring:message code="A0197" text="기타문의"/>',
        				            	'<spring:message code="A0198" text="세제/법규/기타 등"/>',
        				            	'<spring:message code="A0199" text="기타 일반상담"/>',
        				            	'<spring:message code="A0200" text="부품관련문의"/>',
        				            	'<spring:message code="A0201" text="부품결품"/>',
        				            	'<spring:message code="A0202" text="구동계통 결품 불만"/>'
        				            	],
        					        datasets: [{
        					            label: '문의유형별',
        								backgroundColor: [
        									window.chartColors.red,
        									window.chartColors.orange,
        									window.chartColors.yellow,
        									window.chartColors.green,
        									window.chartColors.blue,
        									window.chartColors.purple,
        									window.chartColors.grey,
        									window.chartColors.red,
        									window.chartColors.orange
        								],
        								borderColor: [
        									window.chartColors.red,
        									window.chartColors.orange,
        									window.chartColors.yellow,
        									window.chartColors.green,
        									window.chartColors.blue,
        									window.chartColors.purple,
        									window.chartColors.grey,
        									window.chartColors.red,
        									window.chartColors.orange
        								],
        					            data: [
        					            	sum(arrType01),
        					            	sum(arrType0102),
        					            	sum(arrType010203),
        					            	sum(arrType02),
        					            	sum(arrType0201),
        					            	sum(arrType020103),
        					            	sum(arrType03),
        					            	sum(arrType0301),
        					            	sum(arrType030102)
        					            	
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
        								display: false
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
        					                },
        					                ticks: {
        										beginAtZero: true,
        										//stepSize : 1,
        										//fontSize : 14,
        									}
        					                
        					            }]
        					        }
        					    }
        					};
        					var barChart = document.getElementById('barChart').getContext('2d');
        					//window.myLine = new Chart(barChart, barChartData);
        					
        					if(myChart == null){
        						myChart = new Chart(barChart, barChartData);	
        					}else{
        						myChart.destroy();
        						myChart = new Chart(barChart, barChartData);
        					}
        					
    	    		}
    	    		
    	    		/* var footSum = $("#jqGrid").jqGrid('getCol','INCOMING_COUNT', false, 'sum');
    	            console.log(footSum);
    	            $('#jqGrid').jqGrid('footerData', 'set', { DATE:'합계', INCOMING_COUNT:footSum });
    	            $('table.ui-jqgrid-ftable tr:first').children("td").css("background-color", "#dfeffc");
    	            $('table.ui-jqgrid-ftable tr:first td:eq(0), table.ui-jqgrid-ftable tr:first td:eq(4)').css("padding-top","8px");
    	            $('table.ui-jqgrid-ftable tr:first td:eq(0), table.ui-jqgrid-ftable tr:first td:eq(4)').css("padding-bottom","8px");
    	            $("table.ui-jqgrid-ftable tr:first td:eq(0)").css("text-align", "center"); */
    	            
            	},
        					
        		        	
            };
        
        
        gridOption.pager = "#jqGridPager";
        $("#jqGrid").jqGrid(gridOption);
        gridOption.pager = "#jqGrid_excel_Pager";
        gridOption.loadComplete = "";
        $("#jqGrid_excel").jqGrid(gridOption);
        
        //$("#jqGrid").jqGrid(gridOption);
        
        jQuery("#jqGrid").jqGrid('navGrid','#jqGridPager',
     	       {edit:false,add:false,del:false,search:false,refresh:true},
     	       {}, // edit options
     	       {}, // add options
     	       {} //del options
		);
        
        $("#search").on("click", function(){
			//gridSearch( $('#jqGrid').getGridParam('page'));
        	gridSearch(1);
		});
     			      
        $("#export").on("click", function(){
        	
        	gridSearch($("#cPage").val(), "Y");
        	
		});             
        
	});
	
});	


function gridSearch(currentPage, excelYn) {
	
	var endPageCnt = jQuery("#jqGrid").getGridParam('records').toString();
	
	var obj = new Object();
	obj.checkBox1 = $("input[name=checkBox1]:checked").val(); // 검색유형  daily / weekly / monthly
	obj.checkBox2 = $("input[name=checkBox2]:checked").val(); // 채널유형  call / chat / all
	obj.checkBox3 = $("input[name=checkBox3]:checked").val(); // 제외여부  
	
	obj.fromDate = $("#fromDate").val();
	obj.toDate =  $("#toDate").val();	
	
	obj.ipt_select1_1 = $("#ipt_select1_1 option:selected").val(); // 개인지정    
	obj.custId = $("#custId").val();
	
	obj.page = currentPage;	
	obj.lastpage =  $('#jqGrid').getGridParam('lastpage'); 
	obj.rowNum = jQuery("#jqGrid").getGridParam('rowNum'); 
	obj.allRecords = jQuery("#jqGrid").getGridParam('records');
	obj.offset = (obj.page * obj.rowNum)-obj.rowNum;
	
	obj.endPageCnt = jQuery("#jqGrid").getGridParam('rowNum');
	
	//총 row수 - 마지막  (page - 1) * rowNum > 마지막페이지 cnt
	if(jQuery("#jqGrid").getGridParam('records')%jQuery("#jqGrid").getGridParam('rowNum') != 0){
		obj.endPageCnt = Number(endPageCnt) - jQuery("#jqGrid").getGridParam('rowNum')*($('#jqGrid').getGridParam('lastpage')-1);
	}
	
	//$("#jqGrid").setGridParam({datatype	: "json",postData	: JSON.stringify(obj)}).trigger("reloadGrid");
	
	
	if(excelYn == "Y"){
		console.log("실행순서 3");
		$("#jqGrid_excel").setGridParam({loadComplete:excelFn.fn, loadonce : true, datatype:"json",postData	: JSON.stringify(obj)}).trigger("reloadGrid");
		
		//$("#jqGrid_excel");
		return;
		setTimeout(function() {
			excelFn();
		}, 300);
		
	}else{
		$("#jqGrid").setGridParam({loadonce:false, datatype	: "json",postData	: JSON.stringify(obj)}).trigger("reloadGrid");
		$("#jqGrid_excel").setGridParam({loadonce:false, datatype	: "json",postData	: JSON.stringify(obj)}).trigger("reloadGrid");
	}
	
} 

var excelFn = {fn:function(){
	setTimeout(function() {
		console.log("실행순서 4");
		$("#jqGrid_excel").jqGrid("exportToExcel",{
			  includeLabels : true,
			  includeGroupHeader : true,
			  includeFooter: true,
			  fileName : "<spring:message code="A0170" text="이력조회"/>.xlsx",
			  mimetype : "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
			  maxlength : 40,
			  onBeforeExport : "",
			  replaceStr : null,
			  loadIndicator : true
			});
		}, 300);
}};

</script>


</body>
</html>
