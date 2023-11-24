<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko" xmlns:th="http://www.thymeleaf.org"
      xmlns="http://www.w3.org/1999/xhtml"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" type="image/x-icon" href="/image/circle_bg.png">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"
          integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <meta name="google-signin-client_id" content="996588778775-7ht50odm9h212noi17tl3lsqv3o3pt3o.apps.googleusercontent.com">
    <%@ include file="../common/inc_head_resources.jsp"%>
    <title>Login</title>
</head>
<body class="mobile">
<!-- m_wrap -->
<div id="m_wrap" class="m_chatting">
    <div class="loginWrap">
        <div class="mainlogo"><img src="${pageContext.request.contextPath}/resources/images/ico_chat_b.png" alt="말풍선"></div>

        <form action="${pageContext.request.contextPath}/loginProcess" method="POST" class="loginForm" id="login_form" name="form-login">
            <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
            <input id="mainPage" name="mainPage" type="hidden" value=""/>
            <legend class="hide">로그인</legend>
            <h3>FAST 대화형 AI 채팅상담</h3>
            <div class="ipt_login">
                <div class="iptBox id">
                    <span class="fas fa-user"></span>
                    <input type="text" class="ipt_txt" name="username" placeholder="아이디">
                </div>
                <div class="iptBox pw">
                    <span class="fas fa-lock"></span>
                    <input type="password" class="ipt_txt" name="password" placeholder="비밀번호">
                    <c:if test="${not empty error_msg}">
                        <em style="color:#ff0000;display: block;margin-bottom: 7px;" class="txt_error">
                            아이디 또는 비밀번호를 다시 확인하세요.<br>등록되지 않은 이메일이거나, 이메일 또는 비밀번호를 잘못 입력하셨습니다.
                        </em>
                    </c:if>
                </div>
                <a class="btn_line_purple" id="ClickLogin" target="_parent">
                    <strong>로그인</strong>
                </a>
                <a class="btn_line_purple" target="_parent">
                    <span>Sign in with Google</span>
                </a>
            </div>
        </form>
    </div>
</div>
<!-- //m_wrap -->
<script type="text/javascript">
  $(document).ready(function() {

    $("#ClickLogin").click(function() {
      login();
    });

    $("#oauth").click(function() {
      window.location="/oauth/login";
    });

    $("input[name=loginId]").keydown(function(e){
      if(e.keyCode==13){
        $("input[name=password]").focus();
      }
    });

    $("input[name=password]").keydown(function(e){
      if(e.keyCode==13){
        login();
      }
    });

    var placeholderLabel = $("#sendmailForm > div > div > input, #sendmailForm > div > div > textarea");

    placeholderLabel.on('focus', function(){
      $(this).siblings('label').hide();
    });
    placeholderLabel.on('focusout', function(){
      if($(this).val() === ''){
        $(this).siblings('label').show();
      }
    });

    var href = window.location.href;
    var referrer = document.referrer;
    if (href.includes('/mobile/redtie/login') || referrer.includes('/redtie/mobileCbCsMain')) {
      $('.mobile').attr('class', 'redtie');
      $('.mainlogo').empty();
      var innerHtml = "";
      innerHtml = '<img src="${pageContext.request.contextPath}/resources/images/ico_chat_red.png" alt="말풍선">';
      $(".mainlogo").append(innerHtml);
    }

  });

  function login(){
    if( $("#userId").val() == ""){
      alert('아이디를 입력해주세요.');
      $("#userId").focus();
      return false;
    }
    if( $("#userPw").val() == "" ){
      alert('비밀번호를 입력해주세요.');
      $("#userPw").focus();
      return false;
    }

    // 추가로 클릭 못하게 이벤트 삭제
    $("#ClickLogin").off();
    login_form.submit();
  }

</script>
</body>
</html>