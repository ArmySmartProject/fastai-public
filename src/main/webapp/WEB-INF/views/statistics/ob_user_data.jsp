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

    <title>이력조회 &gt; FAST AICC</title>
</head>

<body class="gcsWrap">
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
        <jsp:param name="titleCode" value="A0402"/>
        <jsp:param name="titleTxt" value="I/B 콜 이력조회"/>
    </jsp:include>
    <!-- //#header -->
    <!-- #container -->
    <%-- <form id="excelForm"></form> --%>

    <div id="container">
        <!-- 검색조건 -->
        <div class="srchArea">
            <input type="hidden" id="cPage" value="1"/>
            <form id="searchForm">
                <table class="tbl_line_view" summary="채널유형/제외여부/검색일자/개인지정으로 구성됨">
                    <caption class="hide">검색조건</caption>
                    <colgroup>
                        <col width="100"><col width="470"><col width="100"><col><col width="100">
                        <col>
                        <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                    </colgroup>
                    <tbody>
                    <tr>
                        <th scope="row"><spring:message code="A0177" text="검색일시"/></th>
                        <td>
                            <div class="iptBox">
                                <input type="text" name="fromDate" id="fromDate" class="ipt_dateTime">
                                <span>-</span>
                                <input type="text" name="toDate" id="toDate"  class="ipt_dateTime">
                            </div>
                            <%-- <div class="checkBox">
                                <!-- <input type="checkbox" name="checkBox2" id="ipt_check1_1" class="ipt_check" value="call" disabled="disabled">
                                <label for="ipt_check1_1"><spring:message code="A0151" text="Call"/></label>
                                <input type="checkbox" name="checkBox2" id="ipt_check1_2" class="ipt_check" value="chat" disabled="disabled">
                                <label for="ipt_check1_2"><spring:message code="A0152" text="Chat"/></label>  -->
                                <input type="checkbox" name="checkBox2" id="ipt_check1_3" class="ipt_check" value="all" checked="checked" onclick="return false;">
                                <label for="ipt_check1_3"><spring:message code="A0172" text="전체"/></label>
                                <!-- [D] <label>의 for값과 <input>의 ID 값을 동일하게 작성해야 함 -->
                            </div> --%>
                        </td>
                        <th><spring:message code="A0173" text="총응대시간"/></th>
                        <td>
                            <div class="iptBox">
                                <input type="text" class="ipt_txt" id="ipt_text_1"><span><spring:message code="A0174" text="초 이상"/></span>
                            </div>
                        </td>
                        <th><spring:message code="A0175" text="제외여부"/></th>
                        <td>
                            <div class="checkBox">
                                <input type="checkbox" name="checkBox3" id="ipt_check3_1" value="exception" class="ipt_check" checked="checked">
                                <label for="ipt_check3_1"><spring:message code="A0176" text="주말 제외"/></label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th><spring:message code="A0408" text="인입 전화번호"/></th>
                        <td>
                            <div class="iptBox">
                                <input type="text" class="ipt_txt" id="telNo" name="telNo">
                            </div>
                        </td>
                        <th><spring:message code="A0325" text="고객명"/></th>
                        <td colspan="3">
                            <div class="iptBox">
                                <input type="text" class="ipt_txt" id="custNm" name="custNm">
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </form>
            <div class="btnBox sz_small line">
                <button type="button" class="btnS_basic" id="search"><spring:message code="A0180" text="검색"/></button>
                <%-- <button type="button" class="btnS_basic"><spring:message code="A0181" text="출력"/></button> --%>
                <button type="button" class="btnS_basic" id="export" ><spring:message code="A0182" text="다운로드"/></button>
            </div>
        </div>
        <!-- //검색조건 -->

        <!-- .jqGridBox -->
        <div class="jqGridBox">
            <table id="jqGrid"></table>
            <div id="jqGridPager"></div>
        </div>
        <div style="display:none;">
            <table id="jqGrid_excel"></table>
            <div id="jqGrid_excel_Pager"></div>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/setColWidth.js"></script>
<!-- script -->
<script type="text/javascript">

  jQuery.event.add(window,"load",function(){
    $(document).ready(function (){
      $(window).bind('resize', function() {
        scResize();
      }).trigger('resize');

      var lang = $.cookie("lang");
      //고객정보 변경
      $('.btn_userInfoModify.btn_lyr_open').on('click',function(){
        $('.lyr_userInfoModify').show();
      });
      if(lang == "ko" || lang == null){
        //datetimepicker
        $('#fromDate').datetimepicker({
          language : 'ko', // 화면에 출력될 언어를 한국어로 설정합니다.
          pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
          defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
          autoclose: 1
        });

        $('#toDate').datetimepicker({
          language : 'ko', // 화면에 출력될 언어를 한국어로 설정합니다.
          pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
          defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
          autoclose: 1
        });
      }else if(lang == "en"){
        //datetimepicker
        $('#fromDate').datetimepicker({
          language : 'en', // 화면에 출력될 언어를 한국어로 설정합니다.
          pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
          defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
          autoclose: 1
        });

        $('#toDate').datetimepicker({
          language : 'en', // 화면에 출력될 언어를 한국어로 설정합니다.
          pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
          defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
          autoclose: 1
        });
      }

      var tDate = new Date();
      var tMinute = tDate.getMinutes().toString().substr(1,2);
      if(tDate.getMinutes() < 10){
        var fMinute = "0";
      }else {
        var fMinute = tDate.getMinutes().toString().substr(0,1);
      }
      var fDate = "";
      var aa =parseInt(tMinute);
      if(aa >=0 && aa <5){
        fDate = getFormatDate(tDate) +" "+ tDate.getHours()+":"+ fMinute + "0";
      }else {
        fDate = getFormatDate(tDate) +" "+ tDate.getHours()+":"+ fMinute + "5";
      }
      tDate = getFormatDate(tDate)+" 09:00";//오늘 특정시간
      $("#fromDate").val(tDate);
      $("#toDate").val(fDate);

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

      //jqGrid(data)

      //jqGrid
      //var jqGridBoxWidth = $('.jqGridBox').width()-1;
      var jqGridBoxWidth = $('.jqGridBox').width();

      var gridOption = {
        search: true,
        url: "${pageContext.request.contextPath}/getIbStatsRecordJQList",
        datatype: "local",
        mtype: "POST",
        ajaxGridOptions: { contentType: "application/json" },
        loadBeforeSend: function(jqXHR) {
          jqXHR.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
        },
        /* colNames:['NO.', '유형', '콜유형', '고객번호(CID)', '고객번호(식별ID)', '응대인원', '응대시작시간', '응대종료시간', 'Bot응대시간', 'CSR응대시간', '총 시간', '큐대기시간', '큐포기여부','가격문의','사용법문의','가입절차문의','기타1','기타2','기타3','기타4','기타5'], */
        colNames:[
          'NO',
          //'<spring:message code="A0183" text="유형"/>',
          //'<spring:message code="A0184" text="콜유형"/>',
          '<spring:message code="A0188" text="응대시작시간"/>',
          '<spring:message code="A0189" text="응대종료시간"/>   ',
          '<spring:message code="A0408" text="고객 전화번호"/>',
          '<spring:message code="A0325" text="고객명"/>',
          '<spring:message code="A0410" text="담당 상담사명"/>',
          '<spring:message code="A0192" text="총 시간"/>',
          '<spring:message code="A0190" text="Bot응대시간"/>',
          '<spring:message code="A0191" text="CSR응대시간"/>',
          //'<spring:message code="A0193" text="큐대기시간"/>',
          //'<spring:message code="A0194" text="큐포기여부"/>',
          '<spring:message code="A0066" text="상담유형1"/>',
          '<spring:message code="A0067" text="상담유형2"/>',
          '<spring:message code="A0068" text="상담유형3"/>'
        ],
        colModel:[
          {name:'RNUM', index:'RNUM', width:30, align:'center', sortable:true, search:true, searchoptions: { sopt: ["eq"] }},
          //{name:'CUST_TYPE', index:'CUST_TYPE', width:50, align:'center'},
          //{name:'CALL_TYPE_CODE_DESC', index:'CALL_TYPE_CODE_DESC', width:50, align:'center'},
          {name:'START_TIME', index:'START_TIME', width:130, align:'center'},
          {name:'END_TIME', index:'END_TIME', width:130, align:'center'},
          {name:'TEL_NO', index:'TEL_NO', width:100, align:'center'},
          {name:'CUST_NM', index:'CUST_NM', width:100, align:'center'},
          {name:'CUST_OP_NM', index:'CUST_OP_NM', width:70, align:'center'},
          {name:'DURATION', index:'DURATION', width:70, align:'center'},
          {name:'BOT_DURATION', index:'BOT_DURATION', width:70, align:'center'},
          {name:'ansCsrTime', index:'ansCsrTime', width:70, align:'center'},
          //{name:'standTime', index:'standTime', width:70, align:'center'},
          //{name:'standAbandon', index:'standAbandon', width:70, align:'center'},
          {name:'CONSULT_TYPE1_DEPTH1_NM',index:'CONSULT_TYPE1_DEPTH1_NM', width:70, align:'center'},
          {name:'CONSULT_TYPE2_DEPTH1_NM',index:'CONSULT_TYPE2_DEPTH1_NM', width:70, align:'center'},
          {name:'CONSULT_TYPE3_DEPTH1_NM',index:'CONSULT_TYPE3_DEPTH1_NM', width:70, align:'center'}

        ],
        //pager: "#jqGridPager",
        width: jqGridBoxWidth,
        height: 'auto',
        height: 500,
        search: true,
        //loadonce: false,
        loadonce: true,
        viewrecords: true,
        gridview: true,
        footerrow: false,
        rowNum: 30,
        userDataOnFooter: false, // use the userData parameter of the JSON response to display data on footer
        jsonReader : {
          repeatitems: false,
          page: "page",    // 현제 페이지, 하단의 navi에 출력됨.
          total: "total",    // 총 페이지 수
          records: "record",
          root: "rows",
        },
        onPaging: function(pgButton){     //페이징 처리

          //var gridPage = $("#jqGrid").getGridParam("page");                     // 현재 페이지 번호
          //var totalPage = $("#jqGrid").getGridParam("rowNum");                // 현재 레코드 갯수

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
          $(".ui-pg-input").attr("readonly", true);
        }
        /* grouping:true */
      };

      gridOption.pager = "#jqGrid_excel_Pager";
      $("#jqGrid_excel").jqGrid(gridOption);
      gridOption.pager = "#jqGridPager";
      $("#jqGrid").jqGrid(gridOption);

      $(".ui-pg-input").attr("readonly", true);
      scResize();
      /* $("#jqGrid").jqGrid('setGroupHeaders', {
          useColSpanStyle: false,
          groupHeaders:[
              {startColumnName:'ansBotTime', numberOfColumns:3, titleText:'총응대시간'},
              {startColumnName:'iqPrice', numberOfColumns:8, titleText:'문의유형'}
          ]
      }); */
      /*
      jQuery("#jqGrid").jqGrid('navGrid','#jqGridPager',
                  {edit:false,add:false,del:false,search:false,refresh:true},
                  {}, // edit options
                  {}, // add options
                  {} //del options
       );
      */
      $("#search").on("click", function(){
        //gridSearch($('#jqGrid').getGridParam('page'));
        gridSearch(1);
        console.log("실행순서 1");
      });

      //다운로드 클릭시 엑셀다운로드
      $("#export").on("click", function(){
        //검색할때 loadComplet 날림
        gridSearch($("#cPage").val(), "Y");
      });

    });
  });

  function gridSearch(currentPage, excelYn) {

    console.log("실행순서 2");

    console.log(currentPage);
    var endPageCnt = jQuery("#jqGrid").getGridParam('records').toString();

    var obj = new Object();
    obj.checkBox3 = $("input[name=checkBox3]:checked").val();
    obj.ipt_text_1 = $("#ipt_text_1").val();
    obj.toDate =  $("#toDate").val();
    obj.ipt_check3_1 = "on";
    obj.fromDate = $("#fromDate").val();
    obj.telNo = $("#telNo").val();
    obj.custNm = $("#custNm").val();
    obj.page = currentPage; // current page
    obj.lastpage =  $('#jqGrid').getGridParam('lastpage'); // current page
    obj.rowNum = jQuery("#jqGrid").getGridParam('rowNum'); //페이지 갯수
    obj.allRecords = jQuery("#jqGrid").getGridParam('records');
    obj.endPageCnt = jQuery("#jqGrid").getGridParam('rowNum');//마지막페이지 cnt
    obj.offset = (obj.page * obj.rowNum)-obj.rowNum;


    if(excelYn == "Y"){
      if($("[id^=jqGridghead]").length > 0){
        console.log("실행순서 3");
        $("#jqGrid_excel").setGridParam({loadComplete:excelFn.fn, loadonce : true, datatype:"json",postData	: JSON.stringify(obj)}).trigger("reloadGrid");

        //$("#jqGrid_excel");
        return;
        setTimeout(function() {
          excelFn();
        }, 300);
      }else {
        alert("<spring:message code='A0600' text='다운로드 할 데이터가 있습니다.' />");
      }
    }else{
      $("#jqGrid").setGridParam({loadonce:false, datatype	: "json",postData	: JSON.stringify(obj)}).trigger("reloadGrid");
      $("#jqGrid_excel").setGridParam({loadComplete:"", loadonce:false, datatype	: "json",postData	: JSON.stringify(obj)}).trigger("reloadGrid");
    }

    //$("#jqGrid").setGridParam({datatype	: "json",postData	: JSON.stringify(obj)}).trigger("reloadGrid");

  }

  var excelFn = {fn:function(){
      setTimeout(function() {
        console.log("실행순서 4");
        $("#jqGrid_excel").jqGrid("exportToExcel",{
          includeLabels : true,
          includeGroupHeader : true,
          includeFooter: true,
          fileName : "<spring:message code="A0402" text="I/B 콜 이력조회"/>.xlsx",
          mimetype : "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
          maxlength : 40,
          onBeforeExport : "",
          replaceStr : null,
          loadIndicator : true
        });
      }, 300);
    }};

  function scResize() {
    var resizeWidth = $('.jqGridBox').width()-1; //jQuery-ui의 padding 설정 및 border-width값때문에 넘치는 걸 빼줌.
    var headerHeight = $("#header").height();
    var searchBoxHeight = $("#container .srchArea").outerHeight();
    var gridSubHeight = $(".jqGridBox").outerHeight(true) - parseInt($(".ui-jqgrid-bdiv").css("height"));
    var resizeHeight = $("#container").height() - headerHeight - searchBoxHeight - gridSubHeight; // 전체 container높이 - 헤더높이 - 검색박스높이 - 그리드(헤더,페이지,margin)높이

    // 그리드의 width를 div 에 맞춰서 적용
    $('#jqGrid').setGridWidth( resizeWidth , true); //Resized to new width as per window.
    $('#jqGrid').setGridHeight( resizeHeight , true);
    $('#jqGrid').css("width", '');
  }
</script>
</body>
</html>
