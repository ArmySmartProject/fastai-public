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
       <strong>사용자님!<br>권한이 없는 메뉴에 접근하셨습니다.</strong>
    </div>
	<div class="error_cnt">
        <p>권한이 없는 메뉴는 접근하실 수 없습니다.</p>
        <p>관리자에게 해당 메뉴의 권한을 요청해 주세요.</p>
    </div>
    <div class="error_btn">
        <a class="btn_clr" href="${pageContext.request.contextPath}/">돌아가기</a>
    </div>
</div>
<div class="copyRight"><span>MINDsLab © 2022</span></div>
    
<!-- 공통 script -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/all.js"></script>
<!-- page Landing -->  
<script type="text/javascript">   
$(window).load(function() { 
    //page loading delete  
	$('#pageldg').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });

}); 
</script> 
</body>
</html>
