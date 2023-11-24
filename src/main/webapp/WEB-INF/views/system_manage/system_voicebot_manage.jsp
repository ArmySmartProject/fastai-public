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

<!-- #wrap -->
<div id="wrap">
    <input type="hidden" id="headerName" value="${_csrf.headerName}" />
    <input type="hidden" id="token" value="${_csrf.token}" />
    <input type="hidden" id="OP_LOGIN_ID">
    <input type="hidden" id="autoCallYn" value="N">
    <jsp:include page="../common/inc_header.jsp">
        <jsp:param name="titleCode" value="A0860"/>
        <jsp:param name="titleTxt" value="고객데이터 관리"/>
    </jsp:include>

    <!-- #container -->
    <div id="container">
        <div class="srchArea">
            <table class="tbl_line_view" summary="검색일자,고객조회,유형검색,DB별 최종 값 기준으로 구성됨">
                <caption class="hide">검색조건</caption>
                <colgroup>
                    <col width="100">
                    <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row">음성봇명</th>
                    <td>
                        <div class="iptBox" style="width: 55%;">
                            <input type="text" id="voicebotNameCol" class="ipt_txt" onkeydown="onKeyDown()" autocomplete="off" style="width: 100%;">
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="btnBox sz_small line">
                <button type="button" class="btnS_basic" onclick="getVoiceBotList('update', 'true')">검색</button>
            </div>
        </div>

        <!-- .jqGridBox -->
        <div class="jqGridBox">
            <!-- [D] jqGrid 내 수정버튼에 들어갈 tag입니다 -->
            <!-- <a href="#lyr_voicebotManagement" class="btnS_line btn_lyr_open">수정</a> -->

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

<!-- 파일 선택 팝업 -->
<div id="lyr_select_file" class="lyrBox lyr_alert">
    <div class="lyr_cont">
        <p>선택한 파일을 적용하시겠습니까?</p>
        <form id="uploadExcelForm" name="uploadExcelForm" method="post" enctype="multipart/form-data">
            <input type="file" id="select_file" name="select_file" class="hide" accept=".xls, .xlsx">
            <label for="select_file">파일선택</label>
        </form>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button class="btn_close">취소</button>
            <button class="btn_close" onclick="uploadExcel()">적용</button>
        </div>
    </div>
</div>
<div id="lyr_voicebotManagement" class="lyrBox">
    <div class="lyr_top">
        <h3>음성봇 상담사 관리</h3>
        <button class="btn_lyr_close">닫기</button>
    </div>
    <div class="lyr_mid" style="max-height: 655px;">
        <div class="titArea">
            <div id="voicebotName">
                <h3>음성봇명 : <span></span></h3>
            </div>
            <dl class="fr">
                <dt>시나리오명</dt>
                <dd>
                    <select class="select" id="scenarioList">
                        <option>시나리오1</option>
                        <option>시나리오2</option>
                        <option>시나리오3</option>
                    </select>
                </dd>
            </dl>
        </div>
        <div class="lot_row">
            <div class="lot_cell">
                <div class="stn tbl_dropdown radio_type">
                    <span class="stn_tit">
                        회선 목록
                    </span>

                    <div class="stn_cont">
                        <div class="tbl_customTd scroll" style="height: 430px;">
                            <table class="tbl_line_lst" summary="번호/고객명/고객구분/연락처1(대표)/연락처2/연락처3으로 구성됨">
                                <caption class="hide">DB List</caption>
                                <colgroup>
                                    <col width="30"><col><col><col><col>
                                </colgroup>
                                <thead>
                                <tr>
                                    <th scope="col">
                                        <div class="ipt_check_only hide">
                                            <input type="checkbox" class="ipt_tbl_allCheck">
                                        </div>
                                    </th>
                                    <th scope="col">
                                        <span>No.</span>
                                    </th>
                                    <!-- [D] dropbox를 가지는 th에는 "th_sort" class를 추가해야 합니다. -->
                                    <th scope="col">
                                        <span>회선번호</span>
                                        <!-- [D]
                                            체크박스를 가질 때 : th_dropbox와 th_check_box 클래스를 적용해야합니다.
                                            검색창을 가질 때 : th_dropbox와 th_search_box 클래스를 적용해야합니다.
                                        -->
                                    </th>
                                    <th scope="col">타입</th>
                                    <th scope="col">
                                        <span>배정 상담사 ID</span>
                                    </th>
                                </tr>
                                </thead>
                                <tbody id="linesBody">
                                </tbody>
                            </table>
                        </div>
                        <span id="assignedCount" class="infoTxt"></span>
                    </div>
                </div>
            </div>
            <div class="lot_cell">
                <div class="stn tbl_dropdown radio_type">
                    <span id="assignedSipAccount" class="stn_tit">
                        상담사 목록 :
                    </span>
                    <div class="stn_cont">
                        <div class="tbl_customTd scroll" style="height: 430px;">
                            <table class="tbl_line_lst" summary="번호/고객명/고객구분/연락처1(대표)/연락처2/연락처3으로 구성됨">
                                <caption class="hide">DB List</caption>
                                <colgroup>
                                    <col width="30"><col><col><col><col>
                                    <col>
                                </colgroup>
                                <thead>
                                <tr>
                                    <th scope="col">
                                        <div class="ipt_check_only hide">
                                            <input type="checkbox" class="ipt_tbl_allCheck">
                                        </div>
                                    </th>
                                    <!-- [D] dropbox를 가지는 th에는 "th_sort" class를 추가해야 합니다. -->
                                    <th scope="col">
                                        <span>이름</span>
                                        <!-- [D]
                                            체크박스를 가질 때 : th_dropbox와 th_check_box 클래스를 적용해야합니다.
                                            검색창을 가질 때 : th_dropbox와 th_search_box 클래스를 적용해야합니다.
                                        -->
                                    </th>
                                    <th scope="col">
                                        <span>사용자 ID</span>
                                    </th>
                                    <th scope="col">배정현황</th>
                                </tr>
                                </thead>
                                <tbody id="consultantBody">
                                </tbody>
                            </table>
                        </div>
                        <span id="consultantCount" class="infoTxt"></span>
                        <input type="hidden" id="campaignId" value="1">
                        <input type="hidden" id="companyId" value="1">
                        <input type="hidden" id="consultantId" value="1">
                        <input type="hidden" id="sipId" value="1">
                        <input type="hidden" id="checkAccount" value="1">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <%--<button id="btnSave" class="system_alert_save" disabled>저장</button>--%>
            <button id="btnSave" class="system_alert_save">저장</button>
            <button class="btn_lyr_close">취소</button>
        </div>
    </div>

</div>
<input type="hidden" id="voicebotNameTemp">
<!-- 공통 script -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>
<!-- fontAwesome -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/all.js"></script>
<!-- datepicker -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap-datepicker.js"></script>
<!-- 공통 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script type="text/javascript"  src="${pageContext.request.contextPath}/resources/js/jquery.jqgrid.src.pub.js"></script>

<!-- page Landing -->
<script type="text/javascript">
  $(window).load(function() {
    //page loading delete
    $('#pageldg').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });
  });
</script>
<!-- script -->
<script type="text/javascript">
//   var scenarioList;

  jQuery.event.add(window,"load",function(){
    $(document).ready(function (){
      // GCS iframe
      $('.gcsWrap', parent.document).each(function(){
        //header 화면명 변경
        var pageTitle = $('title').text().replace('> FAST AICC', '');

        $(top.document).find('#header h2 a').text(pageTitle);
      });

      //시스템 메뉴 선택
      $('.menu_slt_box .menu_lst > li').on('click',function(){
        $(this).find('.sub').stop().slideDown(300);
      });
      $('.menu_slt_box .menu_lst .sub > li').on('click',function(){
        $(this).find('.third').stop().slideDown(300);
      });
      $('.menu_slt_box .menu_lst .third > li').on('click',function(){
        $(this).addClass('active').find('.fourth').stop().slideDown(300);
      });

      //추가 유라 김가영매니저님 jqGrid 내 버튼 추가
      function addButton(cellValue, options, rowdata, action){
        var buttonHtml = '<a onclick="openInfoLayer('+rowdata.campaignId+',\''+rowdata.voiceBotName+'\',\''+rowdata.companyId+'\');" class="btnS_line btn_lyr_open">수정</a>';
        return buttonHtml;
      }

      //AMR jqGrid 200624
      $("#jqGrid").jqGrid({
        // data: jqGridData,
        datatype: "local",
        autowidth: true,
        height: 'auto',
        rowNum: 30,
        rowList: [10,20,30],
        colNames:['NO.', 'CampaignId', 'CompanyId', '음성봇명', '상세설명', '언어', '회선수',
          '할당된 상담사 수', 'IB/OB', '시나리오 명','수정자', '수정일', '수정'
        ],
        colModel:[
          {name:'no', index:'no', width: 50, align:'center'},
          {name:'campaignId', index:'campaignId', hidden:true},
          {name:'companyId', index:'companyId', hidden:true},
          {name:'voiceBotName', index:'voiceBotName', align:'center'},
          {name:'description', index:'description', align:'center'},
          {name:'language', index:'language', align:'center'},
          {name:'lines', index:'lines', align:'center'},

          {name:'lineAssigned', index:'lineAssigned', align:'center'},
          {name:'isInbound', index:'isInbound', align:'center'},
          {name:'scenarioName', index:'scenarioName', align:'center'},
          {name:'modifyUser', index:'modifyUser', align:'center'},
          {name:'modifyTime', index:'modifyTime', align:'center'},
          {name:'modifyStart', index:'modifyStart', width:70, align:'center', sortable: false, formatter:addButton}
        ],
        pager: "#jqGridPager",
        height: 600,
        viewrecords: true,
        sortname: 'name',
        loadComplete : function(data) {
          $(".ui-pg-input").attr("readonly", true);

          $('.btn_lyr_open').on('click',function(){
            var winHeight = $(window).height()*0.7,
                hrefId = $(this).attr('href');

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
              $('body').find(hrefId).unwrap('<div class="lyrWrap"></div>');
              $('.lyr_bg').remove();
            });
          });
        }
      });

      getVoiceBotList('new', '');

      // 추가 AMR 레이어에서 저장버튼 클릭 시 시스템 얼럿으로 한번 더 확인
      $('.system_alert_save').on('click', function(e){
        var hrefId = $(this).parents('.lyrBox');
        console.log(hrefId);
        if (confirm("저장하시겠습니까?")) {
          var sipId = $('#checkSipAccount:checked').val();
          var consultantId = $('#checkconsultant:checked').val();
          var campaignId = $('#campaignId').val();
          var companyId = $('#companyId').val();

          updateAssignedCst(sipId,consultantId,campaignId,companyId);
          updateAssignedScenario(campaignId);
        }
      });
      // 추가 AMR 레이어에서 저장버튼 클릭 시 시스템 얼럿으로 한번 더 확인
    });
  });

  function getVoiceBotList(type, search) {

    var obj = new Object();
    if (search == 'true') {
      $('#voicebotNameTemp').val($('#voicebotNameCol').val());
    }
    obj.voicebotName = $('#voicebotNameTemp').val();
    $.ajax({
      type: "POST",
      url: "${pageContext.request.contextPath}/getVoiceBotList",
      data: JSON.stringify(obj),
      contentType: "application/json; charset=utf-8",
      beforeSend: function (xhr) {
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
      success: function (data) {
        console.log(data);
        console.log(data.length);
        if (type == 'update') {
          $('#jqGrid').jqGrid('clearGridData'); // 혹시라도 테이블 초기화해야할 경우 사용
          // $("#jqGrid").getGridParam("reccount"); // 페이징 처리 시 현 페이지의 Max RowId 값
        }
        for (var i = 0; i < data.voiceBotList.length; i++) {
          var ibob = data.voiceBotList[i].isInbound.replace('Y', 'I/B').replace('N', 'O/B');
          $('#jqGrid').addRowData(i, {
            no: (i + 1).toString(),
            voiceBotName: data.voiceBotList[i].campaignNm,
            description: data.voiceBotList[i].description,
            language: data.voiceBotList[i].lang,
            lines: data.voiceBotList[i].linesCount,
            lineAssigned: data.voiceBotList[i].lineAssigned,
            isInbound: ibob,
            scenarioName: data.voiceBotList[i].scenarioName,
            modifyUser: data.voiceBotList[i].updaterId,
            modifyTime: data.voiceBotList[i].updatedDtm,
            modifyStart: '수정버튼',
            campaignId: data.voiceBotList[i].campaignId,
            companyId: data.voiceBotList[i].companyId
          });
        }
        $('#jqGrid').trigger('reloadGrid');
      },
      error: function () {
        console.log("updateResultByKeyword error");
      }
    });
  }

  function getConsultantList(companyId, consultantId, sipId, campaignId){

    var obj = new Object();

    obj.COMPANY_ID = companyId;
    obj.CONSULTANT_ID = consultantId;
    $('#consultantId').val(consultantId);
    $('#sipId').val(sipId);
    $.ajax(
        {
          url: "${pageContext.request.contextPath}/getVoiceConsultantList",
          data: JSON.stringify(obj),
          method: 'POST',
          contentType: "application/json; charset=utf-8",
          beforeSend: function (xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
          },
        }).success(function (result) {

      var cnt = 0;
      var consultantList = result.consultantList;
      var consultantCount = result.consultantCount;

      var innerHTML = "";

      // $("#btnSave").prop("disabled",true);
      $("#assignedSipAccount").empty();
      innerHTML += '상담사 목록 : ' + sipId;
      $("#assignedSipAccount").append(innerHTML);

      innerHTML = "";

      $("#consultantCount").empty();
      innerHTML += '총 <span>' + consultantCount + '</span> 명';
      $("#consultantCount").append(innerHTML);

      innerHTML = "";
      $("#consultantBody").empty();

      $.each(consultantList, function (i, v) {

        var obj = [];
        obj.push(v.userId);
        obj.push(v.userNm);
        obj.push(v.assignedCt);

        innerHTML += '<tr>';
        innerHTML += '<td scope="row">';
        innerHTML += '<div class="ipt_check_only">';
        innerHTML += '<input type="checkbox" id="checkconsultant" name="checkconsultant" value="' + obj[0] + '">';
        innerHTML += '</div>';
        innerHTML += '</td>';
        innerHTML += '<td>' + obj[1] + '</td>';
        innerHTML += '<td id="AssignedCtId">' + obj[0] + '</td>';
        innerHTML += '<td><em>' + obj[2] + '</em>개</td>';
        innerHTML += '</tr>';

        cnt++;
      });

      $("#consultantBody").append(innerHTML);
      $('#consultantBody tr:eq(0)').toggleClass('active');
      $('#consultantBody tr:eq(0) td:eq(0)').find('input:checkbox').prop('checked', true);

      // 추가 AMR 200630 테이블 셀 다중 클릭 가능, tr 클릭 시 그 라인에 있는 체크박스가 체크된다.
      $('.tbl_dropdown tbody tr').on('click', function(){
        if ( $(this).hasClass('admin_active') || $(this).parents('.tbl_dropdown').hasClass('radio_type') ) {
          return;
        }

        $(this).toggleClass('active');

        if ( $(this).hasClass('active') ) {
          $(this).find('input:checkbox').prop('checked', true);
        } else {
          $(this).find('input:checkbox').prop('checked', false);
        }
      });

      // 추가 AMR 200630 테이블 셀 하나만 클릭 가능, tr 클릭 시 그 라인에 있는 체크박스가 체크된다.
      $('.tbl_dropdown.radio_type tbody tr').on('click', function(){
        if ( $(this).hasClass('admin_active') ) {
          return;
        } else if ( $(this).hasClass('active') ) {
          $(this).removeClass('active');
          $(this).find('input:checkbox').prop('checked', true);
          // $("#btnSave").prop("disabled",false);
          return;
        }

        var consultantId = $(this).parent().find('#consultantId').text();
        $(this).parents('.tbl_dropdown.radio_type').find('tbody tr').removeClass('active');
        $(this).parents('.tbl_dropdown.radio_type').find('input:checkbox').prop('checked', false);
        $(this).addClass('active');
        $(this).find('input:checkbox').prop('checked', true);
        // $("#btnSave").prop("disabled",false);

      });

    }).fail(function (result) {
      console.log("고객정보 불러오기 error");
    });
  }


  function openInfoLayer(campaignId, campaignNm, companyId, type){

    var obj = new Object();

    $('#campaignId').val(campaignId);
    $('#companyId').val(companyId);
    obj.CAMPAIGN_ID = campaignId;
    obj.CAMPAIGN_NM = campaignNm;
    obj.COMPANY_ID = companyId;

    $.ajax(
        {
          url: "${pageContext.request.contextPath}/getSipActList",
          data: JSON.stringify(obj),
          method: 'POST',
          contentType: "application/json; charset=utf-8",
          beforeSend: function (xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
          },
        }).success(function (result) {

      var cnt = 1;
      var assigned = 0;
      var sipAccountList = result.sipAccountList;
	  var scenarioList = result.scenarioList;
      var innerHTML = "";

      if (type != 'update') {

        $("#voicebotName").empty();

        innerHTML += '<h3>음성봇명 : <span>'+ campaignNm +'</span></h3>';
        $("#voicebotName").append(innerHTML);
        $("#consultantBody").empty();
        $("#consultantCount").empty();
        $("#assignedSipAccount").empty();
      } else {

        var sipId = $('#checkSipAccount:checked').val();
        $('#checkAccount').val(sipId);
        var consultantId = $('#checkconsultant:checked').val();
        getConsultantList(companyId, consultantId, sipId, campaignId);
      }

      innerHTML = "";
      $("#linesBody").empty();

      $.each(sipAccountList, function (i, v) {

        var obj = [];
        obj.push(v.sipUser);
        obj.push(v.custOpId);
        obj.push(v.isInbound);
        var isInbound = obj[2].replace('Y', 'I/B').replace('N', 'O/B');

        innerHTML += '<tr>';
        innerHTML += '<td scope="row">';
        innerHTML += '<div class="ipt_check_only">';
        if (sipId == obj[0]) {
          innerHTML += '<input type="checkbox" id="checkSipAccount" value="' + obj[0] + '" checked>';
        } else {
          innerHTML += '<input type="checkbox" id="checkSipAccount" value="' + obj[0] + '">';
        }
        innerHTML += '</div>';
        innerHTML += '</td>';
        innerHTML += '<td scope="row">' + cnt + '</td>';
        innerHTML += '<td id="sipId">' + obj[0] + '</td>';
        innerHTML += '<td>' + isInbound + '</td>';
        innerHTML += '<td id="consultantId">' + obj[1] + '</td>';
        innerHTML += '<input type="hidden" id="companyId" value="'+  companyId +'">';
        innerHTML += '</tr>';

        if (obj[1] != null && obj[1] != "") {
          assigned++;
        }

        cnt++;
      });

      // 음성봇 시나리오 목록 조회
      var scenarioHtml = "";
      $("#scenarioList").empty();
	  $.each(scenarioList, function (i, v) {
		  var obj = [];
		  obj.push(v.id);
		  obj.push(v.name);
		  if(sipAccountList[0].simplebotId == obj[0]){
		  	 scenarioHtml += "<option value="+obj[0]+" selected='selected'>"+obj[1]+"</option>";
		  }else{
		     scenarioHtml += "<option value="+obj[0]+">"+obj[1]+"</option>";
		  }
	  });
	  $("#scenarioList").append(scenarioHtml);


      $("#linesBody").append(innerHTML);

      // 회선이 존재하는 경우 첫번째 회선 선택되어 보여지도록 수정
      if (cnt > 1) {
        $('#linesBody tr:eq(0)').toggleClass('active');
        $('#linesBody tr:eq(0) td:eq(0)').find('input:checkbox').prop('checked', true);
        var firstConsultantId = $('#linesBody tr:eq(0)').find('#consultantId').text();
        var firstSipId = $('#linesBody tr:eq(0)').find('#sipId').text();
        getConsultantList(companyId, firstConsultantId, firstSipId, campaignId);
      }

      innerHTML = "";
      $("#assignedCount").empty();
      innerHTML = '배정 현황 <span>' + assigned +'/'+ (cnt-1) +'</span>';
      $("#assignedCount").append(innerHTML);

      getVoiceBotList('update', '');
      // 추가 AMR 200618
      $('.tbl_dropdown .th_dropbox').on('click', function(e){
        e.stopPropagation();
      })

      // 추가 AMR 200630 테이블 셀 다중 클릭 가능, tr 클릭 시 그 라인에 있는 체크박스가 체크된다.
      $('.tbl_dropdown tbody tr').on('click', function(){
        if ( $(this).hasClass('admin_active') || $(this).parents('.tbl_dropdown').hasClass('radio_type') ) {
          return;
        }

        $(this).toggleClass('active');

        if ( $(this).hasClass('active') ) {
          $(this).find('input:checkbox').prop('checked', true);
        } else {
          $(this).find('input:checkbox').prop('checked', false);
        }
      });

      // 추가 AMR 200630 테이블 셀 하나만 클릭 가능, tr 클릭 시 그 라인에 있는 체크박스가 체크된다.
      $('.tbl_dropdown.radio_type tbody tr').on('click', function(){
        if ( $(this).hasClass('admin_active') ) {
          return;
        } else if ( $(this).hasClass('active') ) {
          $(this).removeClass('active');
          $(this).find('input:checkbox').prop('checked', true);
          return;
        }

        var consultantId = $(this).find('#consultantId').text();
        var sipId = $(this).find('#sipId').text();
        $(this).parents('.tbl_dropdown.radio_type').find('tbody tr').removeClass('active');
        $(this).parents('.tbl_dropdown.radio_type').find('input:checkbox').prop('checked', false);
        $(this).find('input:checkbox').prop('checked', true);
        getConsultantList(companyId, consultantId, sipId, campaignId);
      });

      // 추가 AMR 200618 table th를 클릭하면 검색할 수 있는 dropbox가 보여진다.
      $('.tbl_dropdown .th_sort').on('click', function(){
        if ( $(this).children('.th_dropbox').hasClass('show') ) {
          $('.tbl_dropdown .th_sort').removeClass('active');
          $('.tbl_dropdown .th_dropbox').removeClass('show');
          return;
        }
        $('.tbl_dropdown .th_dropbox').removeClass('show');
        $('.tbl_dropdown .th_sort').removeClass('active');
        $(this).addClass('active');
        $(this).children('.th_dropbox').addClass('show');
      });

      // 추가 AMR 200618 검색 dropbox에서 확인 버튼을 클릭하면 dropbox가 닫힌다.
      $('.tbl_dropdown .btn_dropbox_confirm').on('click', function(){
        $('.tbl_dropdown .th_dropbox').removeClass('show');
        $('.tbl_dropdown .th_sort').removeClass('active');
      });

      // 추가 AMR 200618 table th 안에 있는 input이 focus되어 있을 때 enter 키를 누르면 확인이 클릭된다.
      $('.th_dropbox .ipt_txt, .ipt_check_only input[type="checkbox"]').on('keydown', function(e){
        var keyCode = e.which?e.which:e.keyCode;
        if ( keyCode === 13 ) {
          $('.th_dropbox.show').find('.btn_dropbox_confirm').trigger('click');
        }
      });

      // 추가 AMR 200617 table th안에 있는 전체선택 checkbox를 클릭하면 전체선택이 된다.
      $('.ipt_dropbox_allCheck').on('click',function(){
        var iptDropboxAllCheck = $(this).is(":checked");
        if ( iptDropboxAllCheck ) {
          $(this).prop('checked', true);
          $(this).parents('.th_dropbox').find('input:checkbox').prop('checked', true);
        } else {
          $(this).prop('checked', false);
          $(this).parents('.th_dropbox').find('input:checkbox').prop('checked', false);
        }
      });

    }).fail(function (result) {
      console.log("고객정보 불러오기 error");
    });
    if (type != 'update') {
      openPopup("lyr_voicebotManagement");
    }
  }

  function updateAssignedCst(sipId,consultantId,campaignId,companyId){

    var obj = new Object();

    obj.SIP_ID = sipId;
    obj.CONSULTANT_ID = consultantId;
    obj.CAMPAIGN_ID = campaignId;

    $.ajax({
      url : "${pageContext.request.contextPath}/updateAssignedCst",
      data : JSON.stringify(obj),
      method : 'POST',
      contentType : "application/json; charset=utf-8",
      beforeSend : function(xhr) {
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
    }).success(
        function(result) {

          alert("수정 완료");
          openInfoLayer(campaignId, '', companyId, 'update');


        }).fail(function(result) {
      console.log("OB Call Queue Delete Error");
    });

  }

    function updateAssignedScenario(campaignId) {

		var simplebotId = $("#scenarioList option:selected").val();

        $.ajax({
            url : "${pageContext.request.contextPath}/updateAssignedScenario",
            data : JSON.stringify({simplebotId: simplebotId, campaignId:campaignId}),
            method : 'POST',
            contentType : "application/json; charset=utf-8",
            beforeSend : function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
        }).success(
            function(result) {
                console.log('simplebotId update success!');
            }).fail(function(result) {
            console.log("updateAssignedScenario Error");
        });

    }

  function onKeyDown() {
    if(event.keyCode == 13)
    {
      getVoiceBotList('update', 'true');
    }
  }

</script>
</body>
</html>
