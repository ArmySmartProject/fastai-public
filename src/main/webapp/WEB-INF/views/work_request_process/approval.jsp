<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2022-12-16
  Time: 오후 6:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
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

<div id="wrap">
  <input type="hidden" id="headerName" value="${_csrf.headerName}" />
  <input type="hidden" id="token" value="${_csrf.token}" />
  <input type="hidden" id="cPage" value="1" />
  <%--titleCode, titleTxt 등록 필요 > 작업의뢰 결재 현황 --%>
  <jsp:include page="../common/inc_header.jsp">
    <jsp:param name="titleCode" value="A0920"/>
    <jsp:param name="titleTxt" value="O/B 예약콜 관리"/>
  </jsp:include>
  <!-- #container -->
  <div id="container">
    <div id="contents">
      <!-- .content -->
      <div class="content">
<%--        검색--%>
        <div class="srchArea">
          <table class="tbl_line_view" summary="기간, 유형, 상태 기준으로 구성됨">
            <caption class="hide">검색조건</caption>
            <colgroup>
              <col width="120"><col><col width="120"><col><col width="120"><col>
            </colgroup>
            <tbody>
            <tr>
              <th scope="row">기간</th>
              <td>
                <div class="iptBox">
                  <input type="text" class="ipt_date" name="fromDate" id="fromDate" autocomplete="off">
                </div>
                <span>-</span>
                <div class="iptBox">
                  <input type="text" class="ipt_date" name="toDate" id="toDate" autocomplete="off">
                </div>
              </td>
              <th>유형</th>
              <td>
                <select class="select" style="width: 150px;" id="workRequestCamp">
                  <option value="">전체</option>
                  <option value="">캠페인1</option>
                  <option value="">캠페인2</option>
                </select>
              </td>
              <th>상태</th>
              <td>
                <select class="select" style="width: 150px;" id="workSignStat">
                  <option value="all">전체</option>
                  <option value="signing">결재중</option>
                  <option value="signComplete">결재완료</option>
                </select>
              </td>
            </tr>
            </tbody>
          </table>
          <!-- //검색조건 -->
          <div class="btnBox sz_small line">
            <button type="button" class="btnS_basic" onclick="gridSearch(1)" id="mainSearch"><spring:message code="A0528" text="검색" /></button>
          </div>
        </div>

<%--        <div class="table_wrap jqSt">--%>
<%--          <table id="tbl_work_process">--%>
<%--            <colgroup>--%>
<%--              <col style="width: 50px;">--%>
<%--              <col><col><col><col><col><col>--%>
<%--            </colgroup>--%>
<%--            <thead>--%>
<%--            <tr>--%>
<%--              <th>No</th>--%>
<%--              <th>작업의뢰 번호</th>--%>
<%--              <th>상태</th>--%>
<%--              <th>제목</th>--%>
<%--              <th>기안자</th>--%>
<%--              <th>기안일</th>--%>
<%--              <th>결재자</th>--%>
<%--              <th>결재일</th>--%>
<%--            </tr>--%>
<%--            </thead>--%>
<%--            <tbody>--%>
<%--            <tr>--%>
<%--              <td>1</td>--%>
<%--              <td><a href="">20221108-0001</a></td>--%>
<%--              <td>--%>
<%--                결재중--%>
<%--                <button type="button" class="btnS_basic">결제승인</button>--%>
<%--              </td>--%>
<%--              <td>시나리오 수정</td>--%>
<%--              <td>요청자</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>결재자</td>--%>
<%--              <td>-</td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--              <td>2</td>--%>
<%--              <td><a href="">20221108-0002</a></td>--%>
<%--              <td>--%>
<%--                결재중--%>
<%--                <button type="button" class="btnS_basic">결제승인</button>--%>
<%--              </td>--%>
<%--              <td>시나리오 수정</td>--%>
<%--              <td>요청자</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>결재자</td>--%>
<%--              <td>-</td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--              <td>3</td>--%>
<%--              <td><a href="">20221112-0001</a></td>--%>
<%--              <td>결재완료</td>--%>
<%--              <td>시나리오 수정</td>--%>
<%--              <td>요청자</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>결재자</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--              <td>4</td>--%>
<%--              <td><a href="">20221112-0002</a></td>--%>
<%--              <td>결재완료</td>--%>
<%--              <td>시나리오 수정</td>--%>
<%--              <td>요청자</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>결재자</td>--%>
<%--              <td>2022-11-10</td>--%>
<%--            </tr>--%>
<%--            </tbody>--%>
<%--          </table>--%>
<%--          <div class="jqSt_paging">--%>
<%--            <div class="jqSt_navi">--%>
<%--              <button type="button" title="First Page"><span class="ui-icon fas fa-angle-double-left" aria-hidden="true"></span></button>--%>
<%--              <button type="button" title="Previous Page"><span class="ui-icon fas fa-angle-left" aria-hidden="true"></span></button>--%>

<%--              <div class="page_num">--%>
<%--                <span class="page_num">Page--%>
<%--                  <input aria-label="Page No." type="text" size="2" maxlength="7" value="1"> of--%>
<%--                  <span>1</span>--%>
<%--                </span>--%>
<%--              </div>--%>

<%--              <button type="button" title="Next Page"><span class="ui-icon fas fa-angle-right" aria-hidden="true"></span></button>--%>
<%--              <button type="button" title="Last Page"><span class="ui-icon fas fa-angle-double-right" aria-hidden="true"></span></button>--%>
<%--            </div>--%>
<%--          </div>--%>
<%--        </div>--%>
        <div class="jqGridBox">
          <table id="jqGrid"></table>
          <div id="jqGridPager"></div>
        </div>
      </div>
    </div>
  </div>

  <!-- #footer -->
  <div id="footer">
    <div class="cyrt"><span>&copy; MINDsLab. All rights reserved.</span></div>
  </div>
  <!-- //#footer -->
</div>

<%--  작업의뢰 보기 팝업 --%>
<div class="lyrBox" style="width: 800px;" id="lyr_work_proccess_detail">
  <div class="lyr_top">
    <h3>작업의뢰 보기</h3>
    <button class="btn_lyr_close">닫기</button>
  </div>

  <div class="lyr_mid" style="max-height: 655px;">
    <div class="dl_work_process_wrap">
      <dl class="col_half">
        <dt>작업의뢰 번호</dt>
        <dd id="workRequestNo">20221108-0001</dd>
        <dt>등록 일자</dt>
        <dd id="createDate">2022-11-12</dd>
      </dl>

      <dl class="col_half">
        <dt>작업의뢰 유형</dt>
        <dd id="workCategory">캠페인명1</dd>
        <dt>결재자</dt>
        <dd id="workSigner">결재자1</dd>
      </dl>

      <dl>
        <dt>작업의뢰 제목</dt>
        <dd id="workRequestTitleDetail">시나리오 수정</dd>
      </dl>
      <dl class="col_half">
        <dt>완료 요청일</dt>
        <dd id="workRequestCompleteDateDetail">2022-11-18</dd>
        <dt>요청자</dt>
        <dd id="workPlaner">요청자</dd>
      </dl>
      <dl>
        <dt>사전협의 유무</dt>
        <dd id="preConference">유</dd>
      </dl>
      <dl>
        <dt>요청내용 (요약)</dt>
        <dd class="narrow_space" style="overflow-y: auto; height: 115px;" id="workRequestContents">
          요청내용 입니다.
        </dd>
      </dl>
      <dl>
        <dt>요청내용 (상세)</dt>
        <dd id="uploadFileNm">
          <button type="button" style="margin: 0; padding: 0; border: none; background: none; text-decoration: underline; font-size: 14px; color: #35384d;">
            파일이름
          </button>
        </dd>
      </dl>
    </div>
  </div>

  <div class="lyr_btm">
    <div class="btnBox sz_small">
      <button class="btn_lyr_close">닫기</button>
    </div>
  </div>
</div>

<%@ include file="../common/inc_footer.jsp"%>
<!-- page Landing -->
<script type="text/javascript">
  var date = new Date();
  var curDate = getFormatDate(date);
  $(window).load(function() {
    //page loading delete
    $('#pageldg').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });

    $(document).ready(function (){
      var year = date.getFullYear();
      var month = date.getMonth();
      var day = date.getDate();
      var beforeWeek = getFormatDate(new Date(year, month, day - 7));
      $("#fromDate").val(beforeWeek);
      $("#toDate").val(curDate);

      $('#fromDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : 1,
        defalutDate : new Date(),
        endDate: $("#toDate").val(),
      }).on('changeDate', function(selectedDate){
        $("#toDate").datepicker('setStartDate',selectedDate.date);
      });

      $('#toDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : 1,
        defalutDate : new Date(),
        startDate: $("#fromDate").val()
      }).on('changeDate', function(selectedDate){
        $("#fromDate").datepicker('setEndDate',selectedDate.date);
      });

      getCategoryAndSigner();
      createColumn();
      gridSearch(1);
    });
  });

  function createColumn(type) {
    var colNames = [];
    var colModels = [];
    colNames.push('NO.',
            '작업의뢰 번호',
            '상태',
            '제목',
            '기안자',
            '기안일',
            '결재자',
            '결재일',
            '상태 코드');
    colModels.push({name:'RNUM', index:'RNUM', width:30, align:'center', sortable: false, formatter: rowNumber});
    colModels.push({name:'workRequestNo', index:'workRequestNo', width:100, align:'center', formatter:workRequestNoLink});
    colModels.push({name:'signStatCodeNm', index:'signStatCodeNm', width:70, align:'center', sortable: false, formatter:addButton});
    colModels.push({name:'workRequestTitle', index:'workRequestTitle', width:100, align:'center'});
    colModels.push({name:'planerId', index:'planerId', width:100, align:'center', sortable: false});
    colModels.push({name:'workPlanDtm',index:'workPlanDtm', width:70, align:'center', sortable: false, sorttype:'date'});
    colModels.push({name:'signerId', index:'signerId', width:100, align:'center', sortable: false});
    colModels.push({name:'workSignDtm',index:'workSignDtm', width:70, align:'center', sortable: false, sorttype:'date'});
    colModels.push({name:'statCode', index:'statCode', width:70, align:'center',hidden:true, sortable: false});


    createSearchJqGrid(colNames, colModels);
  }

  function createSearchJqGrid(colNames, colModels) {
    //jqGrid
    var gridOption = {
      url: "${pageContext.request.contextPath}/getWorkRequestApprovalProcessList",
      datatype: "local",
      mtype: "POST",
      autowidth: false,
      ajaxGridOptions: { contentType: "application/json" },
      loadBeforeSend: function(jqXHR) {
        jqXHR.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")
      },
      height: 'auto',
      colNames: colNames,
      colModel: colModels,
      pager: "#jqGridPager",
      loadonce: false,
      viewrecords: true,
      gridview: true,
      footerrow: false,
      rowNum: 15,
      userDataOnFooter: false, // use the userData parameter of the JSON response to display data on footer
      jsonReader : {
        repeatitems: false,
        page: "page",	// 현제 페이지, 하단의 navi에 출력됨.
        total: "total",	// 총 페이지 수
        records: "record",
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
        gridSearch(gridPage);
      },
      loadComplete : function(data){
        $(".ui-pg-input").attr("readonly", true);

      },
    };

    $("#jqGrid").jqGrid(gridOption);

    // 엑셀 버튼항목 숨기기
    $("#jqGrid_excel").jqGrid('hideCol', ["CONVERSATION_HISTORY"]);

    // 페이지 수정막기
    $(".ui-pg-input").attr("readonly", true);
  }

  function gridSearch(currentPage) {
    var obj = new Object();

    obj.fromDate = $("#fromDate").val();
    obj.toDate = $("#toDate").val();
    obj.workCategory = $("#workRequestCamp").val();
    obj.workSignStat = $("#workSignStat").val();

    obj.page = currentPage; // current page
    obj.lastpage =  $('#jqGrid').getGridParam('lastpage'); // current page
    obj.rowNum = jQuery("#jqGrid").getGridParam('rowNum'); //페이지 갯수
    obj.allRecords = jQuery("#jqGrid").getGridParam('records');
    obj.endPageCnt = jQuery("#jqGrid").getGridParam('rowNum');//마지막페이지 cnt
    obj.offset = (obj.page * obj.rowNum)-obj.rowNum;

    $("#jqGrid").setGridParam({loadonce:false, datatype	: "json",postData	: JSON.stringify(obj)}).trigger("reloadGrid");
  }
  //jqGrid list rowNumber
  function rowNumber(cellvalue, options, rowObject){
    var nTotalCnt = $('#jqGrid').getGridParam('records');
    var nPage     = $('#jqGrid').getGridParam('page');
    var nRows     = $('#jqGrid').getGridParam('rowNum');
    var rowNum = null;
    rowNum = ( nPage-1 ) * nRows + (parseInt(options.rowId));
    return rowNum;
  }

  function addButton(cellvalue, options, rowObject){
    var buttonHtml = "";
    if(rowObject.statCode == 'WR02'){
      buttonHtml = rowObject.signStatCodeNm + " <button type='button' class='btnS_basic' onclick='approvalSign(\""+rowObject.workRequestNo+"\");'>결재승인</button>";
    }else{
      buttonHtml = rowObject.signStatCodeNm;
    }
    return buttonHtml;
  }

  function workRequestNoLink(cellvalue, options, rowObject){
    var workNoHtml = "<a onclick='workRequestProcessDetail(\""+rowObject.workRequestNo+"\",\""+rowObject.statCode+"\")'>"+rowObject.workRequestNo+"</a>";

    return workNoHtml;
  }

  function approvalSign(workRequestNo) {
      var obj = new Object();
      obj.workRequestNo = workRequestNo;
    if(confirm("결재를 승인 하시겠습니까?")){
      $.ajax({
        url : "${pageContext.request.contextPath}/updateApprovalSign",
        data : JSON.stringify(obj),
        method : 'POST',
        contentType : "application/json; charset=utf-8",
        beforeSend : function(xhr) {
          xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
      }).success(function(result) {
        gridSearch($("#cPage").val());
      }).fail(function(result) {
        console.log("ajax connection error: get Work Category And Signer List");
      });
    }
  }

  function getCategoryAndSigner(){
    $.ajax({
      url : "${pageContext.request.contextPath}/getWorkCategoryAndSigner",
      data : JSON.stringify({}),
      method : 'POST',
      contentType : "application/json; charset=utf-8",
      beforeSend : function(xhr) {
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
    }).success(function(result) {
      var campaignList = result.getCampaignList;

      var campaignHtml = "";

      $("#workRequestCamp").empty();

      campaignHtml += "<option value='all'>전체</option>";
      $.each(campaignList, function(idx,value){
        campaignHtml += "<option value="+value.CAMPAIGN_ID+">"+value.CAMPAIGN_NM+"</option>";
      });

      $("#workRequestCamp").append(campaignHtml);
    }).fail(function(result) {
      console.log("ajax connection error: get Work Category And Signer List");
    });
  }

  function workRequestProcessDetail(workRequestNo,statCode){
    var obj = new Object();
    obj.workRequestNo = workRequestNo;
    $.ajax({
      url : "${pageContext.request.contextPath}/getWorkRequestProcessDetail",
      data : JSON.stringify(obj),
      method : 'POST',
      contentType : "application/json; charset=utf-8",
      beforeSend : function(xhr) {
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
    }).success(function(result) {

        $("#workRequestNo").text(result.workRequestNo);
        $("#createDate").text(result.createdDtm);
        $("#workCategory").text(result.workCategory);
        $("#workSigner").text(result.signerId);
        $("#workRequestTitleDetail").text(result.workRequestTitle);
        $("#workRequestCompleteDateDetail").text(result.workCompleteRequestDtm);
        $("#workPlaner").text(result.planerId);
        $("#preConferenceYn").text(result.preConferenceYn == 'Y' ? '유' : '무');
        $("#workRequestContents").text(result.workContents);
        $("#uploadFileNm").empty();
        var fileBtnHtml = '<button type="button" style="margin: 0; padding: 0; border: none; background: none; text-decoration: underline; font-size: 14px; color: #35384d;" onclick="location.href=\'/workRequestFileDown?workRequestNo='+result.workRequestNo+'&fileNm='+result.workFileNm+'\'">' + result.workFileNm + '</button>';
        $("#uploadFileNm").append(fileBtnHtml);
        openPopup('lyr_work_proccess_detail');

    }).fail(function(result) {
      console.log("ajax connection error: get Work Request Process List");
    });

  }

</script>
</body>
</html>