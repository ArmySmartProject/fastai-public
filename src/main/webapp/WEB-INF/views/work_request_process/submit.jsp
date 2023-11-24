<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2022-12-16
  Time: 오후 1:15
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
  <%--titleCode, titleTxt 등록 필요 > 작업의뢰 기안 현황 --%>
  <jsp:include page="../common/inc_header.jsp">
    <jsp:param name="titleCode" value="A0920"/>
    <jsp:param name="titleTxt" value="O/B 예약콜 관리"/>
  </jsp:include>
  <!-- #container -->
  <div id="container">
    <div id="contents">
      <!-- .content -->
      <div class="content">
        <div style="margin: 20px 0;">
          <a class="btnM_line" style="border-radius: 2px;" onclick="goInsetWorkRequest();">작업의뢰 등록</a>
          <a class="btnM_line" style="float: right; border-radius: 2px;" onclick="workRequestFormPopup();">작업의뢰서 양식 등록</a>
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
<%--              <th>제목</th>--%>
<%--              <th>기안자</th>--%>
<%--              <th>기안일</th>--%>
<%--              <th>결재자</th>--%>
<%--              <th>상태</th>--%>
<%--            </tr>--%>
<%--            </thead>--%>
<%--            <tbody id="workRequestProcessTbody">--%>
<%--            <tr>--%>
<%--              <td>1</td>--%>
<%--              <td><a href="">20221108-0001</a></td>--%>
<%--              <td>시나리오 수정</td>--%>
<%--              <td>요청자</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>결재자</td>--%>
<%--              <td>--%>
<%--                결재중--%>
<%--                <button type="button" class="btnS_basic">기안취소</button>--%>
<%--              </td>--%>
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

    <!-- .jqGridBox -->

    <!-- //.jqGridBox -->
  </div>

  <!-- #footer -->
  <div id="footer">
    <div class="cyrt"><span>&copy; MINDsLab. All rights reserved.</span></div>
  </div>
  <!-- //#footer -->
</div>

<%--  작업의뢰 등록/임시저장 팝업 --%>
<div class="lyrBox" style="width: 800px;" id="lyr_insert_work_request">
  <div class="lyr_top">
    <h3>작업의뢰 등록</h3>
    <button class="btn_lyr_close">닫기</button>
  </div>

  <div class="lyr_mid" style="max-height: 655px;">
    <div class="dl_work_process_wrap">
      <dl class="col_half">
        <dt>작업의뢰 유형</dt>
        <dd class="narrow_space">
          <select name="workRequestCamp" id="workRequestCamp" class="select">
            <option value="">선택</option>
          </select>
        </dd>
        <dt>결재자</dt>
        <dd class="narrow_space">
          <select name="signerList" id="signerList" class="select">
            <option value="">선택</option>
          </select>
        </dd>
      </dl>

      <dl>
        <dt>작업의뢰 제목</dt>
        <dd class="narrow_space iptBox">
          <input type="text" class="ipt_txt" id="workRequestTitle" />
        </dd>
      </dl>
      <dl>
        <dt>완료 요청일</dt>
        <dd class="narrow_space iptBox">
          <input type="text"  class="ipt_date" name="workRequestCompleteDate" id="workRequestCompleteDate" autocomplete="off">
        </dd>
      </dl>
      <dl>
        <dt>사전협의 유무</dt>
        <dd>
          <div class="radioBox">
            <input type="radio" id="radio_id1" name="radio_name1" value="Y"/>
            <label for="radio_id1">유</label>
            <input type="radio" id="radio_id2" name="radio_name1" value="N"/>
            <label for="radio_id2">무</label>
          </div>
        </dd>
      </dl>
      <dl>
        <dt>요청내용 (요약)</dt>
        <dd class="narrow_space iptBox">
          <textarea class="ipt_txt" style="height: 104px; padding: 5px;" id="workContents"></textarea>
        </dd>
      </dl>
      <dl>
        <dt>요청내용 (상세)</dt>
        <dd class="narrow_space">
          <button type="button" id="workRequestFormDown" style="margin: 0; padding: 0; border: none; background: none; color: #5e77ff; text-decoration: underline; font-size: 14px;" onclick="location.href='/workRequestFormDown'">
            작업의뢰서 양식 다운로드
          </button>
          <form id="uploadWorkRequestFile" name="uploadWorkRequestFile" method="post" enctype="multipart/form-data">
            <input type="file" name="file_id1" id="file_id1" style="margin-top: 10px;">
          </form>
        </dd>
      </dl>
    </div>
  </div>

  <div class="lyr_btm">
    <div class="btnBox sz_small" id="work_insert_btns">
      <button onclick="insertWorkRequest('requestSign','','');">결제상신</button>
      <button onclick="insertWorkRequest('temporarySave','','');" style="color: #5e77ff; border: 1px solid #5e77ff; background: #fff;">임시저장</button>
      <button class="btn_lyr_close">닫기</button>
    </div>
  </div>
</div>

<%--  작업의뢰 보기 팝업 --%>
<div class="lyrBox" style="width: 800px;" id="lyr_work_request_detail">
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
          <dd id="preConferenceYn">유</dd>
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
            <button type="button" style="margin: 0; padding: 0; border: none; background: none; text-decoration: underline; font-size: 14px; color: #35384d;" onclick="location.href='/workRequestFileDown'">
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

<%--  작업의뢰서 양식 등록 팝업 --%>
<div class="lyrBox" style="width: 500px;" id="lyr_work_request_form">
    <div class="lyr_top">
      <h3>작업의뢰서 양식 등록</h3>
      <button class="btn_lyr_close">닫기</button>
    </div>

    <div class="lyr_mid" style="max-height: 655px;">
      <div class="iptBox" style="margin-top: 10px;">
        <form id="uploadWorkRequestForm" name="uploadWorkRequestForm" method="post" enctype="multipart/form-data">
          <input type="file" name="select_file" id="select_file">
        </form>
      </div>

      <span style="display: block; margin: 30px 0 5px 0; font-size: 14px;">작업의뢰서 등록 리스트 (최근 3건)</span>
      <div class="table_wrap jqSt">
        <table style="text-align: center;">
          <colgroup>
            <col style="width: 120px;">
            <col style="width: 80px;">
            <col>
          </colgroup>
          <thead>
          <tr>
            <th style="text-align: center;">등록일</th>
            <th style="text-align: center;">등록자</th>
            <th style="text-align: center;">등록한 파일명</th>
          </tr>
          </thead>
          <tbody id="workRequestFormListTbody">
          <tr>
            <td>2022-12-26</td>
            <td>홍길동</td>
            <td>작업의뢰서_221226.xlsx</td>
          </tr>
          <tr>
            <td>2022-12-25</td>
            <td>홍길동</td>
            <td>작업의뢰서_221225.xlsx</td>
          </tr>
          <tr>
            <td>2022-12-24</td>
            <td>홍길동</td>
            <td>작업의뢰서_221224.xlsx</td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
      <div class="lyr_btm">
        <div class="btnBox sz_small">
          <button onclick="uploadWorkRequestFormInsert();">등록</button>
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

      $("#workRequestCompleteDate").val(curDate);
      $("#insertDate").text(curDate);

      $('#workRequestCompleteDate').datepicker({
        format : "yyyy-mm-dd",
        language : "ko",
        autoclose : true,
        todayHighlight : true,
        defalutDate : new Date(),
      });
      getCategoryAndSigner();
      createColumn();
      gridSearch(1);
    });
  });

  function goInsetWorkRequest(){
    // 등록 팝업 내용 초기화.
    $("#workRequestCamp").val('');
    $("#signerList").val('');
    $("#workRequestTitle").val('');
    $("#workRequestCompleteDate").val(curDate);
    $("#radio_id1").prop('checked',true);
    $("#workContents").val('');
    $("#file_id1").attr('class','');
    $("#file_id1").val('');
    $("#fileLabel").remove();

    getCategoryAndSigner();
    $("#work_insert_btns").empty();

    var btnHtml = "";
    btnHtml += "<button onclick='insertWorkRequest(\"requestSign\",\"\",\"\");'>결제상신</button>";
    btnHtml += "<button onclick='insertWorkRequest(\"temporarySave\",\"\",\"\");' style='color: #5e77ff; border: 1px solid #5e77ff; background: #fff;'>임시저장</button>";
    btnHtml += "<button class='btn_lyr_close'>닫기</button>";
    $("#work_insert_btns").append(btnHtml);

    openPopup("lyr_insert_work_request");
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
        var signerList = result.getSignerList;

        var campaignHtml = "";
        var signerHtml = "";

        $("#workRequestCamp").empty();
        $("#signerList").empty();

        campaignHtml += "<option value=''>선택</option>";
        $.each(campaignList, function(idx,value){
          campaignHtml += "<option value="+value.CAMPAIGN_ID+">"+value.CAMPAIGN_NM+"</option>";
        });

        signerHtml += "<option value=''>선택</option>";
        $.each(signerList, function(idx,value){
          signerHtml += "<option value="+value.USER_ID+">"+value.USER_ID+"</option>";
        });

        $("#workRequestCamp").append(campaignHtml);
        $("#signerList").append(signerHtml);
      }).fail(function(result) {
        console.log("ajax connection error: get Work Category And Signer List");
      });
  }

  function insertWorkRequest(insertType,workRequestNo,workFileNm){
    var obj = new Object();
    //작업의뢰 번호
    obj.workRequestNo = workRequestNo;
    //작업의뢰 유형
    obj.workCategory = $("#workRequestCamp").val();
    //결재자
    obj.signerId = $("#signerList").val();
    //작업의뢰 제목
    obj.workRequestTitle = $("#workRequestTitle").val();
    //요청일
    obj.workCompleteRequestDtm = $("#workRequestCompleteDate").val();
    //사전 협의 유무
    obj.preConferenceYn = $("input[name=radio_name1]:checked").val();
    //작업의뢰 내용
    obj.workContents = $("#workContents").val();
    //작업의뢰 첨부파일
    obj.workFileNm = workFileNm;
    //작업의뢰 첨부파일

    if(insertType == 'requestSign'){
      //결재상신 CODE > WR02 = 결재중
    obj.statCode = 'WR02';
    }else {
      //임시저장 CODE > WR01 = 임시저장
      obj.statCode = 'WR01';
    }

    $.ajax({
      url : "${pageContext.request.contextPath}/insertWorkRequest",
      data : JSON.stringify(obj),
      method : 'POST',
      contentType : "application/json; charset=utf-8",
      beforeSend : function(xhr) {
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
    }).success(function(result) {
      alert("작업의뢰가 등록되었습니다.");
      gridSearch(1);
      hidePopup("lyr_insert_work_request");
      if(workRequestNo == ''){
        workRequestFileUpload(result);
      }else {
        workRequestFileUpload(workRequestNo);
      }

    }).fail(function(result) {
      console.log("ajax connection error: Insert Work Request List");
    });
  }

  function createColumn(type) {
    var colNames = [];
    var colModels = [];
    colNames.push('NO.',
            '작업의뢰 번호',
            '제목',
            '기안자',
            '기안일',
            '결재자',
            '상태',
            '상태 코드');
    colModels.push({name:'RNUM', index:'RNUM', width:30, align:'center', sortable: false, formatter: rowNumber});
    colModels.push({name:'workRequestNo', index:'workRequestNo', width:100, align:'center', formatter:workRequestNoLink});
    colModels.push({name:'workRequestTitle', index:'workRequestTitle', width:100, align:'center'});
    colModels.push({name:'planerId', index:'planerId', width:100, align:'center', sortable: false});
    colModels.push({name:'workPlanDate',index:'workPlanDate', width:70, align:'center', sortable: false, sorttype:'date'});
    colModels.push({name:'signerId', index:'signerId', width:100, align:'center', sortable: false});
    colModels.push({name:'statCodeNm', index:'statCodeNm', width:70, align:'center', sortable: false, formatter:addButton});
    colModels.push({name:'statCode', index:'statCode', width:70, align:'center',hidden:true, sortable: false});


    createSearchJqGrid(colNames, colModels);
  }

  function createSearchJqGrid(colNames, colModels) {
    //jqGrid
    var gridOption = {
      url: "${pageContext.request.contextPath}/getWorkRequestProcessList",
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

  <%--function createJqGrid() {--%>
  <%--  //jqGrid--%>
  <%--  var gridOption = {--%>
  <%--    url: "${pageContext.request.contextPath}/getWorkRequestProcessList",--%>
  <%--    datatype: "local",--%>
  <%--    mtype: "POST",--%>
  <%--    autowidth: false,--%>
  <%--    height: 'auto',--%>
  <%--    ajaxGridOptions: { contentType: "application/json" },--%>
  <%--    loadBeforeSend: function(jqXHR) {--%>
  <%--      jqXHR.setRequestHeader("${_csrf.headerName}", "${_csrf.token}")--%>
  <%--    },--%>
  <%--    colNames:[--%>
  <%--      'NO.',--%>
  <%--      '작업의뢰 번호',--%>
  <%--      '제목',--%>
  <%--      '기안자',--%>
  <%--      '기안일',--%>
  <%--      '결재자',--%>
  <%--      '상태',--%>
  <%--      '상태 코드'--%>
  <%--    ],--%>
  <%--    colModel:[--%>
  <%--      {name:'RNUM', index:'RNUM', width:30, align:'center', sortable: false, formatter:rowNumber},--%>
  <%--      {name:'workRequestNo', index:'workRequestNo', width:100, align:'center', formatter: workRequestNoLink},--%>
  <%--      {name:'workRequestTitle', index:'workRequestTitle', width:100, align:'center'},--%>
  <%--      {name:'planerId', index:'planerId', width:100, align:'center', sortable: false},--%>
  <%--      {name:'workPlanDate',index:'workPlanDate', width:70, align:'center', sortable: false, sorttype:'date'},--%>
  <%--      {name:'signerId', index:'signerId', width:100, align:'center', sortable: false},--%>
  <%--      {name:'statCodeNm', index:'statCodeNm', width:70, align:'center', sortable: false, formatter:addButton},--%>
  <%--      {name:'statCode', index:'statCode', width:70, align:'center', sortable: false,hidden: true},--%>
  <%--    ],--%>
  <%--    pager: "#jqGridPager",--%>
  <%--    loadonce: false,--%>
  <%--    viewrecords: true,--%>
  <%--    gridview: true,--%>
  <%--    footerrow: false,--%>
  <%--    rowNum: 15,--%>
  <%--    userDataOnFooter: false, // use the userData parameter of the JSON response to display data on footer--%>
  <%--    jsonReader : {--%>
  <%--      repeatitems: false,--%>
  <%--      page: "page",	// 현제 페이지, 하단의 navi에 출력됨.--%>
  <%--      total: "total",	// 총 페이지 수--%>
  <%--      records: "record",--%>
  <%--      root: "rows",--%>
  <%--    },--%>
  <%--    onPaging: function(pgButton){	 //페이징 처리--%>
  <%--      var gridPage = $("#jqGrid").getGridParam("page");				// 현재 페이지 번호--%>
  <%--      var rowNum = $("#jqGrid").getGridParam("rowNum");				// 뿌려줄 row 개수--%>
  <%--      var records = $("#jqGrid").getGridParam("records");				// 현재 레코드 갯수--%>
  <%--      var totalPage = Math.ceil(records/rowNum);						// 토탈갯수--%>

  <%--      if (pgButton == "next") {--%>
  <%--        if (gridPage < totalPage) {--%>
  <%--          gridPage += 1;--%>
  <%--        } else {--%>
  <%--          gridPage = page;--%>
  <%--        }--%>
  <%--      } else if (pgButton == "prev") {--%>
  <%--        if (gridPage > 1) {--%>
  <%--          gridPage -= 1;--%>
  <%--        } else {--%>
  <%--          gridPage = page;--%>
  <%--        }--%>
  <%--      } else if (pgButton == "first") {--%>
  <%--        gridPage = 1;--%>
  <%--      } else if (pgButton == "last") {--%>
  <%--        gridPage = totalPage;--%>
  <%--      } else if (pgButton == "user") {--%>
  <%--        var nowPage = Number($("pager .ui-pg-input").val());--%>

  <%--        if (totalPage >= nowPage && nowPage > 0) {--%>
  <%--          gridPage = nowPage;--%>
  <%--        } else {--%>
  <%--          $("#pager .ui-pg-input").val(page);--%>
  <%--          gridPage = page;--%>
  <%--        }--%>
  <%--      } else if (pgButton == "records") {--%>
  <%--        gridPage = 1;--%>
  <%--      }--%>

  <%--      $("#cPage").val(gridPage);--%>
  <%--      gridSearch(gridPage);--%>
  <%--    },--%>
  <%--    loadComplete : function(data){--%>
  <%--      $(".ui-pg-input").attr("readonly", true);--%>
  <%--    },--%>
  <%--  };--%>

  <%--  $("#jqGrid").jqGrid(gridOption);--%>

  <%--  // 엑셀 버튼항목 숨기기--%>
  <%--  $("#jqGrid_excel").jqGrid('hideCol', ["CONVERSATION_HISTORY"]);--%>

  <%--  // 페이지 수정막기--%>
  <%--  $(".ui-pg-input").attr("readonly", true);--%>
  <%--}--%>

  function gridSearch(currentPage, excelYn) {
    var obj = new Object();

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
    buttonHtml = rowObject.statCodeNm + " <button type='button' class='btnS_basic' onclick='updateWorkRequest(\""+rowObject.workRequestNo+"\");'>기안취소</button>";
  }else{
    buttonHtml = rowObject.statCodeNm;
  }
  return buttonHtml;
}

function workRequestNoLink(cellvalue, options, rowObject){
    var workNoHtml = "<a onclick='workRequestProcessDetail(\""+rowObject.workRequestNo+"\",\""+rowObject.statCode+"\")'>"+rowObject.workRequestNo+"</a>";

    return workNoHtml;
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
        if(statCode == "WR01" || statCode == "WR04"){
          $("#workRequestCamp").val(result.workCategory).attr("selected", true);
          $("#signerList").val(result.signerId).prop("selected", true);
          $("#workRequestTitle").val(result.workRequestTitle);
          $("#workRequestCompleteDate").datepicker('update',result.workCompleteDtm);
          $("input[name=radio_name1]").each(function(e){
            if($(this).val() == result.preConferenceYn){
              $(this).prop("checked",true);
            }
          });
          $("#workContents").val(result.workContents);

          $("#fileLabel").remove();
          if(result.workFileNm == ''){
            $("#uploadWorkRequestFile").append('<label id="fileLabel" for="file_id1">선택된 파일이 없습니다.</label>');
          }else {
            $("#uploadWorkRequestFile").append('<label id="fileLabel" for="file_id1">'+result.workFileNm+'</label>');
          }
          $("#file_id1").attr('class','hide');

          $('#file_id1').change(function(e){
            var fileName = e.target.files[0].name;
            $(this).next('label').text(fileName);
          });

          $("#work_insert_btns").empty();
          var btnHtml = "";
          btnHtml += "<button onclick='insertWorkRequest(\"requestSign\",\""+result.workRequestNo+"\",\""+result.workFileNm+"\");'>결제상신</button>";
          btnHtml += "<button onclick='insertWorkRequest(\"temporarySave\",\""+result.workRequestNo+"\",\""+result.workFileNm+"\");' style='color: #5e77ff; border: 1px solid #5e77ff; background: #fff;'>임시저장</button>";
          btnHtml += "<button class='btn_lyr_close'>닫기</button>";
          $("#work_insert_btns").append(btnHtml);
          openPopup('lyr_insert_work_request');
        }else {
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
          openPopup('lyr_work_request_detail');
        }

  }).fail(function(result) {
    console.log("ajax connection error: get Work Request Process List");
  });

}

function workRequestFormPopup(){

  $.ajax({
    url : "${pageContext.request.contextPath}/getWorkRequestUploadFormList",
    data : JSON.stringify({}),
    method : 'POST',
    contentType : "application/json; charset=utf-8",
    beforeSend : function(xhr) {
      xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    },
  }).success(function(result) {
    var workRequestFormList = result;
    $("#workRequestFormListTbody").empty();
    var tbodyHtml = "";
    $.each(workRequestFormList,function(idx,value){
      tbodyHtml += "<tr>";
      tbodyHtml += "<td>"+value.createdDtm+"</td>";
      tbodyHtml += "<td>"+value.id+"</td>";
      tbodyHtml += "<td>"+value.fileNm+"</td>";
      tbodyHtml += "</tr>";
    });

    $("#workRequestFormListTbody").append(tbodyHtml);

    openPopup('lyr_work_request_form');

  }).fail(function(result) {
    console.log("ajax connection error: get Work Request Process List");
  });

}

function uploadWorkRequestFormInsert(){
  var form = $('#uploadWorkRequestForm')[0];
  formData = new FormData(form);

  $.ajax({
    url: "${pageContext.request.contextPath}/uploadWorkRequestForm",
    data: formData,
    method: 'POST',
    processData: false,
    contentType: false,
    dataType:'json',
    beforeSend : function(xhr) {
      xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    },
    success: function (data) {
        alert("작업의뢰서 업로드가 완료되었습니다.");
        hidePopup('lyr_work_request_form');
    },
    error: function (data) {
      alert("작업 중 오류가 발생하였습니다.");
    }
  });
}

function workRequestFileUpload(workRequestNo){

  var form = $('#uploadWorkRequestFile')[0];
  formData = new FormData(form);
  formData.append("workRequestNo", workRequestNo);
  $.ajax({
    url: "${pageContext.request.contextPath}/uploadWorkRequestFile",
    data: formData,
    method: 'POST',
    processData: false,
    contentType: false,
    dataType:'json',
    beforeSend : function(xhr) {
      xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    },
    success: function (data) {

    },
    error: function (data) {
      alert("작업 중 오류가 발생하였습니다.");
    }
  });
}

function updateWorkRequest(workRequestNo){
  var obj = new Object();

  obj.workRequestNo = workRequestNo;
  if(confirm("취소하시겠습니까?")){
    $.ajax({
      url : "${pageContext.request.contextPath}/updateWorkRequest",
      data : JSON.stringify(obj),
      method : 'POST',
      contentType : "application/json; charset=utf-8",
      beforeSend : function(xhr) {
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
    }).success(function(result) {
      alert("기안이 취소되었습니다.");
      gridSearch(1);
    }).fail(function(result) {
      console.log("ajax connection error: delete Work Request List");
    });
  }

}

</script>
</body>
</html>
