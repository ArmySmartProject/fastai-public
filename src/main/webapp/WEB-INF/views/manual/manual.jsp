<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 3:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/fast_manual.css">
  <title>manual</title>
</head>
<body>
<div id="wrap">
  <div id="header">
    <h1 class="text_hide">매뉴얼</h1>
    <div class="depth1">
      <h2 class="menu">상담관리</h2>
      <div class="depth2">
        <h3 class="menu">음성봇 상담</h3>
        <div class="depth3">
<%--          <h4><a href="" data-menu="" class="menu"><span>음성봇 콜 이력 조회 (O/B)</span></a></h4>--%>
          <h4><a href="/manual?page=ib03" data-menu="ib03" class="menu"><span>음성봇 콜 이력 조회</span></a></h4>
          <h4><a href="/manual?page=ib02" data-menu="ib02" class="menu"><span>음성봇 상담화면 (I/B)</span></a></h4>
          <h4><a href="/manual?page=ob01" data-menu="ob01" class="menu"><span>음성봇 상담화면 (O/B)</span></a></h4>
          <h4><a href="/manual?page=voicebotStatistics" data-menu="voicebotStatistics" class="menu"><span>음성봇 통계</span></a></h4>
          <h4><a href="/manual?page=reservationCallHistory" data-menu="reservationCallHistory" class="menu"><span>음성봇 예약콜 이력조회</span></a></h4>
<%--          <hr>--%>
<%--          <h4><a href="/manual?page=ob02" data-menu="ob02" class="menu"><span>O/B콜 통계</span></a></h4>--%>
<%--          <h4><a href="/manual?page=ib01" data-menu="ib01" class="menu"><span>대시보드</span></a></h4>--%>
<%--          <h4><a href="/manual?page=ib04" data-menu="ib04" class="menu"><span>I/B콭 통계</span></a></h4>--%>
<%--          <h4><a href="/manual?page=ib05" data-menu="ib05" class="menu"><span>I/B 상담원별 통계</span></a></h4>--%>
        </div>
        <h3 class="menu">챗봇 상담</h3>
        <div class="depth3">
<%--          <h4><a href="" data-menu="" class="menu"><span>채팅상담 이력조회</span></a></h4>--%>
          <h4><a href="/manual?page=cbConsult" data-menu="cbConsult" class="menu"><span>채팅상담</span></a></h4>
          <h4><a href="/manual?page=chatbotStatistics" data-menu="chatbotStatistics" class="menu"><span>챗봇통계</span></a></h4>
        </div>
        <h3 class="menu">서비스관리</h3>
        <div class="depth3">
          <h4><a href="/manual?page=reservationCall" data-menu="reservationCall" class="menu"><span>음성봇 예약콜 관리</span></a></h4>
<%--          <h4><a href="" data-menu="" class="menu"><span>음성봇 상담사 관리</span></a></h4>--%>
<%--          <h4><a href="" data-menu="" class="menu"><span>챗봇 이벤트 관리</span></a></h4>--%>
<%--          <h4><a href="" data-menu="" class="menu"><span>고객데이터 관리</span></a></h4>--%>
        </div>
      </div>
<%--      <h2 class="menu">챗봇빌더</h2>--%>
<%--      <div class="depth2">--%>
<%--        <h3><a href="/manual?page=chatbotBd01" data-menu="chatbotBd01" class="menu"><span>서비스 현황</span></a></h3>--%>
<%--        <h3><a href="/manual?page=chatbotBd02" data-menu="chatbotBd02" class="menu"><span>챗봇관리</span></a></h3>--%>
<%--        <h3 class="menu">도메인관리</h3>--%>
<%--        <div class="depth3">--%>
<%--          <h4><a href="/manual?page=chatbotBd03" data-menu="chatbotBd03" class="menu"><span>BQA</span></a></h4>--%>
<%--        </div>--%>
<%--        <h3 class="menu">대화모니터링</h3>--%>
<%--        <div class="depth3">--%>
<%--          <h4><a href="/manual?page=chatbotBd04" data-menu="chatbotBd04" class="menu"><span>대화 이력 조회</span></a></h4>--%>
<%--          <h4><a href="/manual?page=chatbotBd05" data-menu="chatbotBd05" class="menu"><span>답변불가 대화현황 조회</span></a></h4>--%>
<%--        </div>--%>
<%--      </div>--%>
      <h2 class="menu">봇빌더</h2>
      <div class="depth2">
        <h3><a href="/manual?page=smChatbotBd" data-menu="smChatbotBd" class="menu"><span>챗봇빌더(유저 or 회사)</span></a></h3>
<%--        <h3><a href="" data-menu="" class="menu"><span>음성봇빌더 V2</span></a></h3>--%>
      </div>
      <h2 class="menu">FAST 대화형 AI 관리</h2>
      <div class="depth2">
        <h3 class="menu">FAST 대화형 AI 관리(SUPER ADMIN용 화면)</h3>
        <div class="depth3">
          <h4><a href="/manual?page=fastSuper01" data-menu="fastSuper01" class="menu"><span>회사 및 권한관리</span></a></h4>
          <h4><a href="/manual?page=fastSuper03" data-menu="fastSuper03" class="menu"><span>시스템 메뉴 관리</span></a></h4>
          <h4><a href="/manual?page=fastSuper02" data-menu="fastSuper02" class="menu"><span>사용자 관리</span></a></h4>
          <h4><a href="" data-menu="" class="menu"><span>챗봇 관리</span></a></h4>
        </div>
        <h3 class="menu">시스템관리(ADMIN용 화면)</h3>
        <div class="depth3">
          <h4><a href="/manual?page=fastAdmin01" data-menu="fastAdmin01" class="menu"><span>회사 및 서비스 정보</span></a></h4>
          <h4><a href="/manual?page=fastAdmin02" data-menu="fastAdmin02" class="menu"><span>사용자 관리</span></a></h4>
          <h4><a href="/manual?page=fastAdmin03" data-menu="fastAdmin03" class="menu"><span>메뉴 그룹 권한 관리</span></a></h4>
        </div>
<%--        <h3 class="menu">사이트</h3>--%>
<%--        <div class="depth3">--%>
<%--          <h4><a href="/manual?page=log" data-menu="log" class="menu"><span>로그 관리</span></a></h4>--%>
<%--        </div>--%>
      </div>



    </div>
  </div>
  <div id="container">
    <div id="contents">
      <jsp:include page="pages/${menu}.jsp"></jsp:include>
    </div>
  </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
  var locate = window.location.href;
  var split = locate.split('manual?page=');
  var page = split[1];

  $('a.menu').each(function(){
      var thisMenu = $(this);
      var menuData = $(this).attr('data-menu');
      if (menuData == page) {
          thisMenu.addClass('active');
      }
  });
</script>
</body>
</html>
