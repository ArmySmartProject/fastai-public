<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2022-02-15
  Time: 오후 7:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<div id="wrap">
  <!-- .page loading -->
  <div id="pageldg" class="page_loading">
		<span class="out_bg"> <em> <strong>&nbsp;</strong> <strong>&nbsp;</strong>
				<strong>&nbsp;</strong> <b>&nbsp;</b>
		</em>
		</span>
  </div>
  <!-- //.page loading -->

  <!-- #header -->
  <jsp:include page="../common/inc_header.jsp">
    <jsp:param name="titleCode" value="A0504"/>
    <jsp:param name="titleTxt" value="Setting"/>
  </jsp:include>
  <!-- //#header -->
  <!-- #container -->
  <div id="container">
    <div id="contents" class="log_view">
      <div class="content">
        <div class="titArea">
          <select id="select_log_name" class="select">
          <!-- 디렉토리 목록 추가 부분 이 부분 value와 application-~~의 logging.file , logging.name의 key값이 일치해야함 -->
            <option value="default">로그 카테고리를 선택해주세요</option>
            <option value="fast">fast</option>
            <option value="sds">SDS</option>
            <option value="da">DA</option>
            <option value="cm">call manager</option>
          </select>
          <div id="log_view_type" class="btn_viewer">
            <button type="button" data-view="RealTime" class="btn_primary" disabled>실시간 보기</button>
            <button type="button" data-view="File" class="btn_primary" disabled>파일로 보기</button>
          </div>
        </div>

        <div id="view_area">
          <div class="view_bg"></div>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="../common/inc_footer.jsp"%>

<script type="text/javascript">
  var eventSource = null;

  function logView(viewer, name) {

    $('#view_area .view_bg').remove();

    $.ajax({
      url: 'log' + viewer,
      type: "POST",
      data: name,
      contentType: 'application/json',
      beforeSend : function(xhr) {
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
    }).then(function (result) {
      $('#view_area').empty();
      $('#view_area').append(result);

      //가져온 jsp 내용에 맞게 바꾸기

    }).catch(function() {
      alert('로그 화면을 불러오지 못했습니다.');
      console.log('[logView error]');
    });
  }

  $(window).load(function () {
    //page loading delete
    $('#pageldg').addClass('pageldg_hide').delay(300).queue(function () {
      $(this).remove();
    });
  });

  $(document).ready(function () {
    $('#select_log_name').on('change', function() {

      if(eventSource!=null){
        eventSource.close();
      }

      let logName = $(this).val();
      if ( logName !== 'default' ) {
        $('.btn_viewer button').removeAttr('disabled');
      } else {
        $('.btn_viewer button').attr('disabled', '');
      }

      let viewer = $('#log_view_type button.active').attr('data-view');
      if ( viewer !== undefined ) {
        logView(viewer, logName);
      }
    });

    $('#log_view_type button').on('click', function() {

      let $this = $(this);
      $('#log_view_type button').removeClass('active');
      $this.addClass('active');

      let viewer = $this.attr('data-view');
      let logName = $('#select_log_name').val();
      logView(viewer, logName);
    })


  });

</script>
</body>

</html>
