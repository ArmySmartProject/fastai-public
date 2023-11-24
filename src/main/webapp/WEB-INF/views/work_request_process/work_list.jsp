<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2022-12-16
  Time: 오후 6:33
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
                <select class="select" style="width: 150px;" id="workingStat">
                  <option value="all">전체</option>
                  <option value="working">작업중</option>
                  <option value="workComplete">작업완료</option>
                </select>
              </td>
            </tr>
            </tbody>
          </table>
          <!-- //검색조건 -->
          <div class="btnBox sz_small line">
            <button type="button" class="btnS_basic" onclick="gridSearch(1)" id="search"><spring:message code="A0528" text="검색" /></button>
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
<%--              <th>요청일</th>--%>
<%--              <th>완료 요청일</th>--%>
<%--              <th>작업 완료일</th>--%>
<%--              <th>테스트 진행</th>--%>
<%--            </tr>--%>
<%--            </thead>--%>
<%--            <tbody>--%>
<%--            <tr>--%>
<%--              <td>1</td>--%>
<%--              <td><a href="">20221108-0001</a></td>--%>
<%--              <td>작업중</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>2022-11-11</td>--%>
<%--              <td>-</td>--%>
<%--              <td>-</td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--              <td>2</td>--%>
<%--              <td><a href="">20221108-0002</a></td>--%>
<%--              <td>작업중</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>2022-11-11</td>--%>
<%--              <td>-</td>--%>
<%--              <td>-</td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--              <td>3</td>--%>
<%--              <td><a href="">20221108-0003</a></td>--%>
<%--              <td>작업중</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>-</td>--%>
<%--              <td>-</td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--              <td>4</td>--%>
<%--              <td><a href="">20221108-0004</a></td>--%>
<%--              <td>작업중</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>2022-11-10</td>--%>
<%--              <td>-</td>--%>
<%--              <td>-</td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--              <td>5</td>--%>
<%--              <td><a href="">20221108-0005</a></td>--%>
<%--              <td>작업완료</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>--%>
<%--                <a href="" class="btnS_basic" style="display: inline-block; width: 100px; padding: 5px; border-radius: 2px;">테스트 등록</a>--%>
<%--              </td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--              <td>6</td>--%>
<%--              <td><a href="">20221109-0001</a></td>--%>
<%--              <td>작업완료</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>--%>
<%--                <a href="" class="btnS_basic" style="display: inline-block; width: 100px; padding: 5px; border-radius: 2px; border-color: #BEC1CC; background: #BEC1CC;">테스트 비정상</a>--%>
<%--              </td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--              <td>7</td>--%>
<%--              <td><a href="">20221109-0002</a></td>--%>
<%--              <td>작업완료</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>2022-11-08</td>--%>
<%--              <td>--%>
<%--                <a href="" class="btnS_basic" style="display: inline-block; width: 100px; padding: 5px; border-radius: 2px; border-color: #FFA25E; background: #FFA25E;">테스트 정상</a>--%>
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
        <dd id="workCompleteDateDetail">2022-11-18</dd>
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

<%--  테스트 등록/임시저장 팝업 --%>
<div class="lyrBox" style="width: 800px;" id="lyr_insert_test">
  <div class="lyr_top">
    <h3>작업의뢰 테스트 등록</h3>
    <button class="btn_lyr_close">닫기</button>
  </div>

  <div class="lyr_mid" style="max-height: 655px;">
    <div class="dl_work_process_wrap">
      <dl class="col_half">
        <dt>작업의뢰 번호</dt>
        <dd id="workRequestNoTest">20221108-0001</dd>
        <dt>테스트 일자</dt>
        <dd id="testDate">-</dd>
      </dl>

      <dl>
        <dt>작업의뢰 유형</dt>
        <dd id="workCategoryTest">캠페인명1</dd>
      </dl>

      <dl>
        <dt>작업의뢰 제목</dt>
        <dd id="workRequestTitleTest">시나리오 수정</dd>
      </dl>
      <dl>
        <dt>완료 요청일</dt>
        <dd id="workCompleteRequestDateTest">2022-11-18</dd>
      </dl>
      <dl>
        <dt>테스트 결과</dt>
        <dd>
          <div class="radioBox">
            <input type="radio" id="radio_id1" name="radio_name1" value="Y" checked/>
            <label for="radio_id1">정상</label>
            <input type="radio" id="radio_id2" name="radio_name1" value="N" />
            <label for="radio_id2">비정상</label>
          </div>
        </dd>
      </dl>
      <dl>
        <dt>테스트 이력</dt>
        <dd style="overflow-y: auto; max-height: 300px;" id="testHistory">
          -
        </dd>
      </dl>
      <dl>
        <dt>테스트 내용</dt>
        <dd class="narrow_space iptBox">
          <textarea class="ipt_txt" style="height: 104px; padding: 5px;" id="testContents"></textarea>
        </dd>
      </dl>
    </div>
  </div>

  <div class="lyr_btm">
    <div class="btnBox sz_small" id="testBtnBox">
      <button>확정</button>
      <button style="color: #5e77ff; border: 1px solid #5e77ff; background: #fff;">임시저장</button>
      <button class="btn_lyr_close">닫기</button>
    </div>
  </div>
</div>

<%--  테스트 보기 팝업 --%>
<div class="lyrBox" style="width: 800px;" id="lyr_detail_test">
    <div class="lyr_top">
      <h3>작업의뢰 테스트 보기</h3>
      <button class="btn_lyr_close">닫기</button>
    </div>

    <div class="lyr_mid" style="max-height: 655px;">
      <div class="dl_work_process_wrap">
        <dl class="col_half">
          <dt>작업의뢰 번호</dt>
          <dd id="workRequestNoTestDetail">20221108-0001</dd>
          <dt>테스트 일자</dt>
          <dd id="testDateDetail">-</dd>
        </dl>

        <dl>
          <dt>작업의뢰 유형</dt>
          <dd id="workCategoryTestDetail">캠페인명1</dd>
        </dl>

        <dl>
          <dt>작업의뢰 제목</dt>
          <dd id="workRequestTitleTestDetail">시나리오 수정</dd>
        </dl>
        <dl>
          <dt>완료 요청일</dt>
          <dd id="workCompleteRequestDateTestDetail">2022-11-18</dd>
        </dl>
        <dl>
          <dt>테스트 결과</dt>
          <dd id="testResultDetail">정상</dd>
        </dl>
        <dl>
          <dt>테스트 이력</dt>
          <dd style="overflow-y: auto; height: 300px;" id="testHistoryDetail">
            -
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
            '요청일',
            '완료 요청일',
            '작업 완료일',
            '테스트 진행',
            '상태 코드');
    colModels.push({name:'RNUM', index:'RNUM', width:30, align:'center', sortable: false, formatter: rowNumber});
    colModels.push({name:'workRequestNo', index:'workRequestNo', width:100, align:'center', formatter:workRequestNoLink});
    colModels.push({name:'workStatCodeNm', index:'workStatCodeNm', width:70, align:'center', sortable: false});
    colModels.push({name:'workPlanDtm',index:'workPlanDtm', width:70, align:'center', sortable: false, sorttype:'date'});
    colModels.push({name:'workCompleteRequestDtm', index:'workCompleteRequestDtm', width:70, align:'center', sortable: false, sorttype:'date'});
    colModels.push({name:'workCompleteDtm', index:'workCompleteDtm', width:70, align:'center', sortable: false, sorttype:'date'});
    colModels.push({name:'testStatCodeNm', index:'testStatCodeNm', width:100, align:'center', sortable: false, formatter:testing});
    colModels.push({name:'statCode', index:'statCode', width:70, align:'center',hidden:true, sortable: false});

    createSearchJqGrid(colNames, colModels);
  }

  function createSearchJqGrid(colNames, colModels) {
    //jqGrid
    var gridOption = {
      url: "${pageContext.request.contextPath}/getWorkRequestTestList",
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
    obj.workSignStat = $("#workingStat").val();

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

  function testing(cellvalue, options, rowObject){
    var testBtnHtml = "";

    if(rowObject.statCode == "WR06"){
      testBtnHtml = '<a class="btnS_basic" style="display: inline-block; width: 100px; padding: 5px; border-radius: 2px;" onclick="insertTestPopup(\''+rowObject.workRequestNo+'\');">'+rowObject.testStatCodeNm+'</a>';
    }else if(rowObject.statCode == "WR07"){
      testBtnHtml = '<a class="btnS_basic" style="display: inline-block; width: 100px; padding: 5px; border-radius: 2px;" onclick="insertTestPopup(\''+rowObject.workRequestNo+'\');">'+rowObject.testStatCodeNm+'</a>';
    }else if(rowObject.statCode == "WR08") {
      testBtnHtml = '<a class="btnS_basic" style="display: inline-block; width: 100px; padding: 5px; border-radius: 2px; border-color: #BEC1CC; background: #BEC1CC;" onclick="showTestDetail(\''+rowObject.workRequestNo+'\');">'+rowObject.testStatCodeNm+'</a>';
    }else if(rowObject.statCode == "WR09" || rowObject.statCode == "WR10"){
      testBtnHtml = '<a class="btnS_basic" style="display: inline-block; width: 100px; padding: 5px; border-radius: 2px; border-color: #FFA25E; background: #FFA25E;" onclick="showTestDetail(\''+rowObject.workRequestNo+'\');">'+rowObject.testStatCodeNm+'</a>';
    }else {
      testBtnHtml = rowObject.testStatCodeNm;
    }
    return testBtnHtml;
  }

  function workRequestNoLink(cellvalue, options, rowObject){
    var workNoHtml = "<a onclick='workRequestProcessDetail(\""+rowObject.workRequestNo+"\",\""+rowObject.statCode+"\")'>"+rowObject.workRequestNo+"</a>";

    return workNoHtml;
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
      $("#workCompleteDateDetail").text(result.workCompleteRequestDtm);
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

  function insertTestPopup(workRequestNo){
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

      goTempSave(result.workRequestNo);

      $("#workRequestNoTest").text(result.workRequestNo);
      $("#testDate").text(curDate);
      $("#workCategoryTest").text(result.workCategory);
      $("#workRequestTitleTest").text(result.workRequestTitle);
      $("#workCompleteRequestDateTest").text(result.workCompleteRequestDtm);

      $("#testBtnBox").empty();
      var testBtnHtml = "";
      testBtnHtml += "<button onclick='insertTest(\"save\",\""+result.workRequestNo+"\",\""+result.workCompleteDtm+"\");'>확정</button>";
      testBtnHtml += "<button style='color: #5e77ff; border: 1px solid #5e77ff; background: #fff;' onclick='insertTest(\"tempSave\",\""+result.workRequestNo+"\",\""+result.workCompleteDtm+"\");'>임시저장</button>";
      testBtnHtml += "<button class='btn_lyr_close'>닫기</button>";
      $("#testBtnBox").append(testBtnHtml);


      openPopup("lyr_insert_test");

    }).fail(function(result) {
      console.log("ajax connection error: get Work Request Process List");
    });

  }

  function insertTest(insertType, workRequestNo, workCompleteDtm){

    var testResult = $('input[name="radio_name1"]:checked').val();

    var obj = new Object();
    obj.workRequestNo = workRequestNo;
    obj.workCompleteDtm = workCompleteDtm;
    obj.testContents = $("#testContents").val();
    obj.testResultYn = testResult;

    if(insertType == "save"){
      // 테스트 확정 시
      if(testResult == "Y"){
        obj.statCode = 'WR09';
        obj.testCompleteYn = testResult;
      }else {
        obj.statCode = 'WR08';
        obj.testCompleteYn = testResult;
      }
      obj.tempSaveYn = "N";
    }else if(insertType == "tempSave"){
      // 테스트 임시저장 코드
      obj.statCode = 'WR06';
      obj.testCompleteYn = '';
      obj.tempSaveYn = "Y";
    }

    $.ajax({
      url : "${pageContext.request.contextPath}/insertWorkTest",
      data : JSON.stringify(obj),
      method : 'POST',
      contentType : "application/json; charset=utf-8",
      beforeSend : function(xhr) {
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
    }).success(function(result) {
        if(insertType == "save"){
          alert("테스트 등록이 완료 되었습니다.");
        }else {
          alert("테스트내용이 임시 저장 되었습니다.");
        }
        gridSearch($("#cPage").val());
        hidePopup("lyr_insert_test");
    }).fail(function(result) {
      console.log("ajax connection error: insert Work Test");
    });

  }

  function goTempSave(workRequestNo){

    var obj = new Object();
    obj.workRequestNo = workRequestNo;

    $.ajax({
      url : "${pageContext.request.contextPath}/getWorkTempTestInfo",
      data : JSON.stringify(obj),
      method : 'POST',
      contentType : "application/json; charset=utf-8",
      beforeSend : function(xhr) {
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
    }).success(function(result) {
      var testInfoList = result;
      var testHistory = "";
      $("#testHistory").empty();

      for(var i = 0; i < testInfoList.length; i++){
        if(testInfoList[i].tempSaveYn == "N"){
          testHistory += "" + testInfoList[i].testContents + "<br/>" + testInfoList[i].createdDtm + " <<<<<<< <br/><br/>";
        }else {
          $("input[name=radio_name1]").each(function(e){
            if($(this).val() == testInfoList[i].testResultYn){
              $(this).prop("checked",true);
            }
          });
          $("#testContents").val(testInfoList[i].testContents);
        }
      }
      $("#testHistory").append(testHistory);
    }).fail(function(result) {
      console.log("ajax connection error: insert Work Test");
    });

  }

  function showTestDetail(workRequestNo){
    var obj = new Object();
    obj.workRequestNo = workRequestNo;

    $.ajax({
      url : "${pageContext.request.contextPath}/getTestInfoDetail",
      data : JSON.stringify(obj),
      method : 'POST',
      contentType : "application/json; charset=utf-8",
      beforeSend : function(xhr) {
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
    }).success(function(result) {
      var workRequestProcessDetailMap = result.workRequestProcessDetailMap;
      var workTempTestInfoList = result.workTempTestInfoListMap;

      $("#workRequestNoTestDetail").text(workRequestProcessDetailMap.workRequestNo);
      $("#workCategoryTestDetail").text(workRequestProcessDetailMap.workCategory);
      $("#workRequestTitleTestDetail").text(workRequestProcessDetailMap.workRequestTitle);
      $("#workCompleteRequestDateTestDetail").text(workRequestProcessDetailMap.workCompleteRequestDtm);


      $("#testDateDetail").text(workTempTestInfoList[workTempTestInfoList.length-1].createdDtm);
      $("#testResultDetail").text(workTempTestInfoList[workTempTestInfoList.length-1].testResultYn == "Y" ? "정상" : "비정상");

      var testHistoryHtml = "";
      $("#testHistoryDetail").empty();

      for(var i = 0; i < workTempTestInfoList.length; i++){
        testHistoryHtml += "" + workTempTestInfoList[i].testContents + "<br/>" + workTempTestInfoList[i].createdDtm + " <<<<<<< <br/><br/>";
      }

      $("#testHistoryDetail").append(testHistoryHtml);

      openPopup("lyr_detail_test");
    }).fail(function(result) {
      console.log("ajax connection error: insert Work Test");
    });



  }

</script>
</body>
</html>