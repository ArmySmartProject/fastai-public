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
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="format-detection" content="telephone=no">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <!-- Cache reset -->
    <meta http-equiv="Expires" content="Mon, 06 Jan 2016 00:00:01 GMT">
    <meta http-equiv="Expires" content="-1">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">

    <!-- Open Graph Tag -->
    <meta property="og:title"            content="redtie.ai"/>
    <meta property="og:type"             content="website"/><!-- 웹 페이지 타입 -->
    <meta property="og:url"              content="https://fast-aicc-dev.maum.ai/redtie/login"/>
    <meta property="og:image"            content="${pageContext.request.contextPath}/resources/images/logo_redtie_thumbnail.png"/>
    <meta property="og:description"      content="호텔, 게스트하우스, 펜션 등 숙박사업체에 인공지능기반 다국어 컨시어지 챗봇 플랫폼 제공"/>

    <!-- icon_favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/ico_favicon_60x60.png"><!-- 윈도우즈 사이트 아이콘, HiDPI/Retina 에서 Safari 나중에 읽기 사이드바 -->
    <!-- css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/font.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/all.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/sublanding.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/sublanding_redtie.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"
          integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">

    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>

    <!--[if lte IE 9]>
    <script src="${pageContext.request.contextPath}/js/html5shiv.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/respond.min.js"></script>

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
    <title>FAST 대화형 AI 서비스</title>
    <script>


      //locale return
      function cookieToLocale(defaultValue) {

        var str = document.cookie;
        var locale = defaultValue||"ko";
        var result = {};
        if(str.match("lang") != null && str.match("lang") != ""){
          str = str.split(";");
          str.forEach(function(val){
            val = val.split("=");
            result[val[0].trim()] = decodeURIComponent(val[1] || '');
          });
          locale = result.lang;
        }


        return locale;
      }
      var locale= cookieToLocale("none");
      console.log(locale);
      if(locale=='none'){
        var blang = navigator.language || navigator.userLanguage;
        if(blang.indexOf("ko")>-1)
          window.location.href="/login?lang=ko";
        else
          window.location.href="/login?lang=en";
      }
    </script>
</head>

<body class="loginWrap">

<!-- .page loading -->
<div id="wrap">
    <!-- #header -->
    <div id="header">
        <!-- .group_flex -->
        <div class="group_flex">
            <h1>
                <a href="https://www.redtiebutler.co.kr/" target="_blank"><img src="${pageContext.request.contextPath}/resources/images/logo_redtie.png" alt="redtie logo"></a>
            </h1>
            <!-- .sta -->
            <div class="sta">

                <!-- #menu(service menu) -->
                <div id="menu">
                    <ul>
                        <li>
                            <p class="service_btn">서비스 바로가기 &nbsp;&nbsp;
                                <em class="fas fa-angle-down"></em>
                                <em class="fas fa-angle-up"></em>
                            </p>
                            <ul class="dropdown-menu">
                                <li><a href="${pageContext.request.contextPath}/resources/pdf/solution_hotel.pdf" title="호텔 통합 솔루션" target="_blank">호텔 통합 솔루션</a></li>
                                <li><a href="${pageContext.request.contextPath}/resources/pdf/redtie_butler.pdf" title="호텔 챗봇" target="_blank">호텔 챗봇</a></li>
                                <li><a href="${pageContext.request.contextPath}/resources/pdf/redtie_space.pdf" title="호텔 연회장 예약대행" target="_blank">호텔 연회장 예약대행</a></li>
                                <li><a href="${pageContext.request.contextPath}/resources/pdf/solution_pension.pdf" title="펜션 통합 솔루션" target="_blank">펜션 통합 솔루션</a></li>
                                <li><a href="${pageContext.request.contextPath}/resources/pdf/whitetie_butler.pdf" title="병원 챗봇" target="_blank">병원 챗봇</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <!-- //#menu(service menu) -->

                <!-- language -->
                <div class="lang_box" style="display:none;">
                </div>
                <!-- //language -->
            </div>
            <!-- //.sta -->
        </div>
    </div>
    <!-- //#header -->

    <!-- #container -->
    <div id="container">
        <!-- .contents -->
        <div class="contents">
            <!-- .sloganBox  -->
            <dl class="sloganBox">
                <dt>클라우드 기반 하이브리드 챗봇 서비스</dt>
                <dd><strong>챗봇과 상담사</strong>가 함께 대응하여 고객과의 소통을 쉽게!</dd>
            </dl>
            <!-- //.sloganBox  -->
            <!-- .stn  -->
            <div class="stn">
                <!-- .stn_cnt -->
                <div class="stn_cnt">
                    <!-- .fl -->
                    <div class="fl">
                        <div class="introBox fastAi">
                            <span class="item_mobile">모바일</span>
                            <span class="item_woman">여자</span>
                            <span class="item_ai">로봇</span>
                        </div>
                    </div>
                    <!-- //.fl_box -->

                    <!-- .fr -->
                    <div class="fr">
                        <p class="msg"></p>
                        <ol class="lst">
                            <li>24/7 운영하여 고객 만족도 상승</li>
                            <li>반복적인 상담 업무 대행으로 생산적 업무에 집중</li>
                            <li>실시간 고객 상담으로 구매 전환율 상승</li>
                        </ol>

                        <!-- [D] AMR form 태그 안은 spring:message 만 지우고 나머지는 동일 -->
                        <form action="${pageContext.request.contextPath}/loginProcess" method="POST" class="loginForm" id="login_form" name="form-login">
                            <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
                            <input id="mainPage" name="mainPage" type="hidden" value=""/>
                            <legend class="hide">로그인</legend>
                            <h3>FAST 대화형 AI 시작하기</h3>
                            <div class="ipt_login">
                                <div class="iptBox id">
                                    <span class="fas fa-user"></span>
                                    <input type="text" class="ipt_txt" placeholder="아이디" name="username">
                                </div>
                                <div class="iptBox pw">
                                    <span class="fas fa-lock"></span>
                                    <input type="password" class="ipt_txt" placeholder="비밀번호" name="password">
                                </div>
                                <!--                <c:if test="${not empty error_msg}">-->
                                <span>
                    <em style="color:#ff0000;display: block;margin-bottom: 7px;" class="txt_error">
                      아이디 또는 비밀번호를 다시 확인하세요.<br>등록되지 않은 이메일이거나, 이메일 또는 비밀번호를 잘못 입력하셨습니다.
                    </em>
                  </span>

                                <!--                </c:if>-->
                                <a class="btn_line_purple" id="ClickLogin">
                                    <strong>로그인</strong>
                                </a>
                                <a class="btn_line_purple" id="oauth">
                                    <span>Sign in with Google</span>
                                </a>
                            </div>
                            <div class="soc_login" style="display:none">
                                <a class="btn_bg_purple btn_lyr_open" href="#lyr_join">
                                    <strong>서비스 신청 및 문의하기</strong>
                                </a>
                            </div>
                        </form>

                    </div>
                    <!-- //.fr -->
                </div>
                <!-- //.stn_cnt -->
            </div>
            <!-- //.stn  -->
        </div>
        <!-- //.contents -->
    </div>
    <!-- //#container -->

    <div id="footer">
        <div class="btm_menu">
            <div class="cont_box">
                <div class="menu_area">
                    <div class="contact">
                        <p>Contact Us</p>
                        <a href="mailto:hello@redtie.ai"><span class="far fa-envelope"></span>hello@redtie.ai</a>
                        <a href="tel:+8207040406229"><span class="far fa-comment-dots"></span>070-4040-6229</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="copyright">
            <div class="cont_box">
                <span>© Copyright 2022</span>
                <span>(주) 레드타이</span>
                <span>경기도 성남시 분당구 대왕판교로644번길 49 다산타워 5층</span>
                <span>대표 정승환</span>
                <span>사업자 등록번호 211-88-51766</span>
                <p>
                    <a href="https://www.redtiebutler.co.kr/" target="_blank">회사소개</a>
                    <!-- [D] AMR maum.ai 약관과 동일 / 이용약관, 개인정보처리방침-->
                    <a href="https://maum.ai/home/krTermsMain" class="co_link " target="_blank">이용약관</a>
                    <a href="https://maum.ai/home/krTermsMain#conditions" class="co_link " target="_blank">개인정보처리방침</a>
                </p>
            </div>
        </div>
    </div>
</div>
<!-- //#wrap -->

<!-- 서비스 신청 및 문의하기 -->
<div id="lyr_join" class="lyrBox contactBox">
    <div class="contact_tit">
        <h3>서비스 신청 및 문의하기</h3>
    </div>
    <div class="contact_cnt">
        <p class="info_txt">서비스에 관련된 문의를 남겨 주시면 담당자가 확인 후 연락 드리겠습니다.</p>
        <ul class="contact_lst">
            <li><a href="tel:070-4040-6229">070-4040-6229</a></li>
            <li><span>hello@redtie.ai</span></li>
        </ul>
        <form id="sendmailForm">
            <div class="contact_form">
                <div class="contact_item">
                    <input type="text" id="user_name" class="ipt_txt" autocomplete="off">
                    <label for="user_name">
                        <span class="fas fa-user"></span>이름
                    </label>
                </div>
                <div class="contact_item">
                    <input type="text" id="user_email" class="ipt_txt" autocomplete="off">
                    <label for="user_email">
                        <span class="fas fa-envelope"></span>이메일
                    </label>
                </div>
                <div class="contact_item">
                    <input type="text" id="user_phone" class="ipt_txt" autocomplete="off">
                    <label for="user_phone">
                        <span class="fas fa-mobile-alt"></span>연락처
                    </label>
                </div>
                <div class="contact_item_block">
                    <textarea id="user_txt" class="textArea" rows="6"></textarea>
                    <label for="user_txt">
                        <span class="fas fa-align-left"></span>문의내용
                    </label>
                </div>
            </div>
        </form>
    </div>
    <div class="contact_btn">
        <button id="btn_sendMail" class="btn_inquiry">문의하기</button>
        <button class="btn_lyr_close">닫기</button>
    </div>
</div>
<!-- //서비스 신청 및 문의하기 -->

<!-- page Landing -->
<script type="text/javascript">
  $(window).load(function() {

    //Layer popup open
    $('a.btn_lyr_open').on('click',function(){
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
        $('body').css('overflow','');
        $('body').find(hrefId).unwrap();
        //'<div class="lyrWrap"></div>'
        $('.lyr_bg').remove();
      });
    });
  });
</script>

<script type="text/javascript">

  $(function(){
    var loginId = getCookie("Cookie_loginId");
    $("#ipt_id").val(loginId);

    if($("#ipt_id").val() != "")
      $("#saveId").attr("checked", true);
  });

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

  });

  function login(){
    if( $("#ipt_id").val() == ""){
      alert('아이디를 입력해주세요.');
      $("#ipt_id").focus();
      return false;
    }
    if( $("#ipt_pw").val() == "" ){
      alert('비밀번호를 입력해주세요.');
      $("#ipt_pw").focus();
      return false;
    }

    if($("#saveId").is(":checked")){
      var loginId = $("#ipt_id").val();
      setCookie("Cookie_loginId", loginId, 30);
    }else{
      deleteCookie("Cookie_loginId");
    }

    // 추가로 클릭 못하게 이벤트 삭제
    $("#ClickLogin").off();
    login_form.submit();
  }
  function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
  }

  function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
      start += cookieName.length;
      var end = cookieData.indexOf(';', start);
      if(end == -1)end = cookieData.length;
      cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
  }

  function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
  }



  //send mail
  $('#btn_sendMail').on('click', function(){

    var title = "[FAST AI] 문의하기가 접수되었습니다.";
    var msg = "[FAST-AICC]\n이름 : " + $("#user_name").val() + "\n연락처 : " + $("#user_phone").val() + "\n문의 내용 : " + $("#user_txt").val();

    var formData = new FormData();

    formData.append('fromaddr', $('#user_email').val());
    formData.append('toaddr', 'hello@maum.ai');
    formData.append('subject', title);
    formData.append('message', msg);

    if($('.contact_form input').val()==='' || $('.contact_form textarea').val()==='') {
      alert("내용을 모두 입력해야 이메일을 전달 할 수 있어요!");
    }else{

      var data = '{"fromaddr":"'+$('#user_email').val()+'", "toaddr":"hello@maum.ai", "subject":"'+title+'", "message":"'+msg+'"}';
      sendMail(data,function(data){
        $("#user_name").val("");
        $("#user_email").val("");
        $("#user_phone").val("");
        $("#user_txt").val("");
        $(".lyrWrap").hide();
      });
    }




  });

  function sendMail(data,callback){
    httpSend('/service/sendReqMail', $("#headerName").val(), $("#token").val(), data
        ,function(res){
          res = JSON.parse(res);
          if(res == "SUCC"){
            alert("이메일을 보냈습니다. 담당자 확인 후 연락 드리겠습니다 :)");
          }else{
            alert("Contact Us 메일발송 요청 실패하였습니다.");
          }
          console.log(res);
          callback();
        });
  }

  // header(service menu)
  $(".service_btn").on('click', function () {
    $(this).parent().parent().toggleClass('active');
    $(".dropdown-menu").slideToggle(200);
  });

  // header(user)
  $('.userBox dl').on('click', function () {
    $(this).parent().addClass('active');
  });

  $(document).on('click', function (e) {
    if (!$('.userBox').has(e.target).length) {
      $('.userBox').removeClass('active');
    }
  });

  //화면 로드 시 lang 체크
  $('html').each(function () {
    var thisURL = $(location).attr('href'),
        urlStr = thisURL.substring(thisURL.indexOf('/login'));

    if (urlStr == '/login?lang=en' || urlStr == '/login?lang=en#none') {
      //lang_box ui
      $('.lang_box').children().remove();
      $('.lang_box').append('\
                    <span>English</span> \
                    <span><a href="?lang=ko">Korean</a></span>'
      );

      //html language
      $('html').attr('lang', 'en');

      //Live chat close
      $('body').addClass('lot_en');

      //200807 AMR footer
      $('iframe[name="footerFrame"]').attr("src", "https://maum.ai/serviceLanding/enFooter");
    } else {
      //lang_box ui
      $('.lang_box').children().remove();
      $('.lang_box').append('\
                    <span>한국어</span> \
                    <span><a href="?lang=en">English</a></span>'
      );

      //html language
      $('html').attr('lang', 'ko');

      //Live chat open
      $('body').removeClass('lot_en');

      //200807 AMR footer
      $('iframe[name="footerFrame"]').attr("src", "https://maum.ai/serviceLanding/krFooter");
    }
  });

  //서비스 구조 보기 웹
  $('.layer_btn').on('click', function () {
    $('.lyr_service').fadeIn();
    $('body').css({
      'overflow': 'hidden'
    });
  });
</script>

</body>
</html>
