<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<!-- icon_favicon -->
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/ico_favicon_60x60.png"><!-- 윈도우즈 사이트 아이콘, HiDPI/Retina 에서 Safari 나중에 읽기 사이드바 -->
<!-- css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/font.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/all.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/fast_aicc.css">

<!--[if lte IE 9]>
<script src="${pageContext.request.contextPath}/resources/js/html5shiv.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/respond.min.js"></script>

<div class="lyrWrap"> 
    <div class="lyr_bg ie9"></div>
    <div class="lyrBox">
        <div class="lyr_top">
            <h3>브라우저 업데이트 안내</h3>
         </div> 
        <div class="lyr_mid"> 
            <div class="legacy-browser">
현재 사용중인 브라우저는 지원이 중단된 브라우저입니다.<br>
원활한 온라인 서비스를 위해 브라우저를 <a href="http://windows.microsoft.com/ko-kr/internet-explorer/ie-11-worldwide-languages" target="_blank">최신 버전</a>으로 업그레이드 해주세요.
            </div>
        </div> 
        <div class="lyr_btm">
            <div class="btnBox sz_small">
                <button class="btn_win_close">창 닫기</button>
            </div>
        </div> 
    </div> 
</div>
<![endif]-->

<title>Error &gt; FAST AICC</title>
</head>

<body class="errorWrap">
    
<div class="service_tit">
	<h1>FAST Conversation AI</h1>
</div>
<div class="errorBox">
	<div class="error_tit2">
       <strong><spring:message code="A0853" text="사용자님" />!<br><spring:message code="A0854" text="중복 로그인이 발생 하였습니다." /></strong>
    </div>
	<div class="error_cnt">
        <p><spring:message code="A0852" text="중복된 사용자의 로그인으로, 로그아웃 되셨습니다." /></p>
        <p><spring:message code="A0851" text="재 로그인후 다시 이용해 보시면 정상 접속하실 수 있습니다." /></p>
    </div>
    <div class="error_btn">
        <a class="btn_clr" onclick="reLogin()"><spring:message code="A0850" text="다시 로그인하기" /></a>
    </div>
</div>
<div class="copyRight"><span>MINDsLab © 2022</span></div>

<!-- ===== layer popup ===== -->   
<!-- 서비스 신청 및 문의하기 -->  
<div id="lyr_join" class="lyrBox contactBox">
    <div class="contact_tit">
        <h3><spring:message code="A0327" text="문의하기" /></h3>
    </div>
    <div class="contact_cnt">
        <p class="info_txt"><spring:message code="A0632" text="서비스에 관련된 문의를 남겨 주시면 담당자가 확인 후 연락 드리겠습니다." /></p>
        <ul class="contact_lst">
            <li><a href="tel:1661-3222">1661-3222</a></li>
            <li><span>fastai@maum.ai</span></li>
        </ul>
        <div class="contact_form">
            <div class="contact_item">
                <input type="text" id="user_name" class="ipt_txt" autocomplete="off">
                <label for="user_name">
                    <span class="fas fa-user"></span><spring:message code="A0032" text="이름" />
                </label>
            </div>
            <div class="contact_item">
                <input type="text" id="user_email" class="ipt_txt" autocomplete="off">
                <label for="user_email">
                    <span class="fas fa-envelope"></span><spring:message code="A0048" text="이메일" />
                </label>
            </div>
            <div class="contact_item">
                <input type="text" id="user_phone" class="ipt_txt" autocomplete="off">
                <label for="user_phone">
                    <span class="fas fa-mobile-alt"></span><spring:message code="A0074" text="연락처" />
                </label>
            </div>
            <div class="contact_item_block">
                <textarea id="user_txt" class="textArea" rows="6"></textarea>
                <label for="textArea">
                    <span class="fas fa-align-left"></span><spring:message code="A0633" text="문의내용" />
                </label>
            </div>
        </div>
    </div>
    <div class="contact_btn">
        <button id="btn_sendMail" class="btn_inquiry"><spring:message code="A0327" text="문의하기" /></button>
        <button class="btn_lyr_close"><spring:message code="A0631" text="닫기" /></button>
    </div>
</div>
<!-- //서비스 신청 및 문의하기 -->  
    
<!-- 공통 script -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/all.js"></script>
<!-- page Landing -->  
<script type="text/javascript">   
$(window).load(function() { 
    //page loading delete  
	$('#pageldg').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });

});

function reLogin() {
  var referrer = document.referrer;
  if (referrer.includes('redtie/mobileCbCsMain') || referrer.includes('redtie/mobileChatting')) {
    location.href = "${pageContext.request.contextPath}/mobile/redtie/login"
  } else if (referrer.includes('mobileCbCsMain') || referrer.includes('mobileChatting')) {
    location.href = "${pageContext.request.contextPath}/mobile/login"
  } else {
    location.href = "${pageContext.request.contextPath}/"
  }
}
</script> 
</body>
</html>
