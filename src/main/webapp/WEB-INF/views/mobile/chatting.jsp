<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" type="image/x-icon" href="/image/circle_bg.png">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"
          integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <%@ include file="../common/inc_head_resources.jsp"%>
    <title>chatting</title>
    <script>
      var message = {
        상담요청:'<spring:message code="A0705" text="상담요청"/>',
        상담중:'<spring:message code="A0167" text="상담중"/>',
        챗봇:'<spring:message code="A0704" text="챗봇"/>',
        오후:'<spring:message code="A0707" text="오후"/>',
        오전:'<spring:message code="A0708" text="오전"/>',
        어제:'<spring:message code="A0711" text="어제"/>'
      }
    </script>
</head>

<body class="mobile">
<!-- m_wrap -->
<div id="m_wrap">
    <input type="hidden" id= "headerName"  value="${_csrf.headerName}" />
    <input type="hidden" id= "token"  value="${_csrf.token}" />
    <input type="hidden" id= "csType"  value="${csType}" />
    <input type="hidden" id="OP_LOGIN_ID">
    <input type="hidden" id="voiceUrl" value="${voiceUrl}">
    <input type="hidden" id="proxyUrl" value="${proxyUrl}">
    <input type="hidden" id="handleCsInfoType" value="update"/>
    <input type="hidden" id="selectDate">
    <div id="m_header">
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/mobileCbCsMain'" id="btnPrev" class="chevron_prev text_hide">이전으로 가기</button>
        <div class="title">
        </div>
        <div class="fr multiSelector" style="display:none">
            <select id="multiple_select01" class="select" multiple="multiple" onchange="changeDate();">
            </select>
        </div>
    </div>
    <!-- //m_header -->

    <div id="m_ct" class="m_chatting">
        <div class="chatUI_mid btmUi">
            <ul class="lst_talk">
            </ul>
        </div>
        <!-- .chatUI_btm -->
        <div class="chatUI_btm">
            <div class="unb">
                <button type="button" class="btn_potal_menu"><em class="ico_ham">채팅메뉴</em></button>
                <ul class="menu">
                    <!-- [D] AMR 상담개입과 상담종료는 'on' class가 붙으면 보여집니다.
                      처음에는 상담개입만 보이고, 상담개입을 하면 상담종료만 보여집니다.

                      상담종료 시 상담 종료 문구가 생기고 메뉴버튼은 비활성화가 됩니다
                    -->
                    <li><a href="#lyr_intervention" class="btn_lyr_open on">상담개입</a>
                    <li><button type="button" id="btn_call_end" class="chat_end on">상담종료</button></li>
                </ul>
            </div>
            <form method="post" action="" id="formChat" name="formChat">
                <textarea class="textArea" rows="1" placeholder="메세지를 입력해 주세요" disabled name="user_message"></textarea>
                <input type="button" name="btn_chat" id="btn_chat" class="btn_chat" title="전송" value="전송">
            </form>
        </div>
        <!-- //#chatUI_btm -->
    </div>
</div>
<!-- //m_wrap -->

<!-- ===== layer popup ===== -->
<!-- 상담 개입하기 -->
<div id="lyr_intervention" class="lyrBox">
    <div class="lyr_top">
        <h3>상담 개입하기</h3>
        <button class="btn_lyr_close">닫기</button>
    </div>
    <div class="lyr_mid" style="max-height: 644px;">
        <div class="transferBox">
            <div class="imgBox">
                <img src="${pageContext.request.contextPath}/resources/images/ico_api_bot.png" alt="봇">
                <span>변경</span>
                <img src="${pageContext.request.contextPath}/resources/images/ico_agent_bk.png" alt="상담사">
            </div>
            <p class="txt">해당 상담을 진행하시겠습니까?</p>
        </div>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <!-- [D] AMR 200924 모바일에서 개입할 경우
              $('.chatUI_btm .menu').removeClass('on') 적용필요
            -->
            <button id="btn_transfer_cslor" class="btn_lyr_close">개입하기</button>
        </div>
    </div>
</div>

<div id="lyr_intervention_stop" class="lyrBox">
    <div class="lyr_top">
        <h3><spring:message code="A0703" text="상담 종료하기"/></h3>
        <button class="btn_lyr_close"><spring:message code="A0631" text="닫기"/></button>
    </div>
    <div class="lyr_mid">
        <div class="transferBox">
            <div class="imgBox">
                <img src="${pageContext.request.contextPath}/resources/images/ico_call_n.png" alt="상담종료">
            </div>
            <p class="txt"><spring:message code="A0256" text="상담을 종료하시겠습니까?"/></p>
        </div>
    </div>
    <%--<div class="lyr_btm">--%>
        <%--<div class="btnBox sz_small">--%>
            <%--<button id="btn_call_end" class="btn_lyr_close"><spring:message code="A0703" text="상담종료"/></button>--%>
        <%--</div>--%>
    <%--</div>--%>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.0.1/socket.io.js"></script>
<script type="text/javascript">
  var serverIp = '${domain}';
  var serverPort = '90';
  var serverURL = serverIp + ':' + serverPort;
  var userType = 'supporter';
  var userOption = 'gcs';
  var chatRoomVO = ${chatRoomVO};
  console.log('serverURL is ' + serverURL);
  var gLocale = "ko";
  $("#multiple_select01").multiselect({
    includeSelectAllOption: true,
  });

  //css overflow 임시 변경  2020-09-21에 물어보고 다시 수정하기
  $(".callView").css("overflow","initial");
  $(".callView_tit").css("overflow","initial");

  function getSelectTime(){

    var innerHtml = "";
    innerHtml += "<select id='multiple_select01' class='select' multiple='multiple' onchange='changeDate();'>";
    //상담 목록 li id값으로 multiple_select 날짜 생성
    for (var i = 0; i < $("li[id*=session]").length; i++) {

      eval("var chatTime_"+i+"=parseInt("+$("li[id*=session]:eq("+i+")").attr("time")+")");
      eval("var chatDate_"+i+"= new Date(eval(chatTime_"+i+"))");

      eval("chatDate_"+i+"=chatDate_"+i+".toISOString().substr(0,10)")

      innerHtml += "<option value="+eval("chatDate_"+i)+">"+eval("chatDate_"+i)+"</option>";
    }
    innerHtml += "</select>";

    $(".multiSelector").empty();
    $(".multiSelector").append(innerHtml);

    //selectBox Option 중복제거
    var dupSelect = document.getElementById("multiple_select01");
    for(var i = 0; i < dupSelect.length; i++){
      for(var j = 0; j < dupSelect.length; j++){
        if(j != i && dupSelect.options[i].value == dupSelect.options[j].value){
          dupSelect.remove(j);
        }
      }
    }

    $("#multiple_select01").multiselect({
      includeSelectAllOption: true,
    });

    var splitDate = $("#selectDate").val().split(",");

    for (var j = 0; j < splitDate.length; j++) {
      $("#multiple_select01 option").each(function(){
        if(splitDate[j] == $(this).val()){
          $("#multiple_select01").multiselect("select", $(this).val());
        }
      });
    }
    changeDate();

  }

  function changeDate(){
    var dateArray = new Array();
    $("#multiple_select01 option:selected").each(function(){
      dateArray.push($(this).val());
    });
    $("#selectDate").val(dateArray);

    if(dateArray != "") {
      $(".lst_dialogue").find("li").hide();
    }else{
      $(".lst_dialogue").find("li").show();
    }
    $(".lst_dialogue").find("li").each(function(x){
      var timeStamp = $(this).attr("time");
      var liDate = new Date(parseInt(timeStamp));
      liDate = liDate.toISOString().substr(0,10);
      var splitDate = $("#selectDate").val().split(",");

      for (var i = 0; i < splitDate.length; i++) {
        if(liDate == splitDate[i]){
          $(this).show();
        }
      }
    });
  };

  $(document).ready(function(){

    // swiper
    var swiper = new Swiper('.botMsg_swiper', {
      speed : 200,
      slidesPerView:2,
      spaceBetween: 10,
      centeredSlides: false,
      pagination: {
        el: '.swiper-pagination',
        clickable: true,
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });

    //Layer popup open
    $('a.btn_lyr_open').on('click', function () {
      var winHeight = $(window).height() * 0.7,
          hrefId = $(this).attr('href');

      $('body').css('overflow', 'hidden');
      $('body').find(hrefId).wrap('<div class="lyrWrap"></div>');
      $('body').find(hrefId).before('<div class="lyr_bg"></div>');

      //대화 UI
      $('.lyrBox .lyr_mid').each(function () {
        $(this).css('max-height', Math.floor(winHeight) + 'px');
      });

      //Layer popup close
      $('.btn_lyr_close, .lyr_bg').on('click', function () {
        $('body').css('overflow', '');
        $('body').find(hrefId).unwrap();
        //'<div class="lyrWrap"></div>'
        $('.lyr_bg').remove();
      });
    });

    //AMR 채팅 메뉴버튼 열기 닫기
    $('.btn_potal_menu').on('click', function(){
      var $thisBtn = $(this)
      if ( $thisBtn.hasClass('disabled') ) return; //상담종료를 한 채팅일 경우
      $thisBtn.next('.menu').toggleClass('on');
    });

    //AMR 상담종료 시
    $('.chat_end').on('click', function(){
      var temp = '<li class="stmMessage">\n' + '<span>상담이 종료되었습니다.</span>\n' + '</li>'
      $('.menu').removeClass('on');
      $('.lst_talk').append(temp);
      $('.btn_potal_menu').addClass('disabled');
    });

    var referrer = document.referrer;
    if (referrer.includes('redtie/mobileCbCsMain')) {
      document.getElementById('btnPrev').setAttribute('onClick', "location.href='${pageContext.request.contextPath}/redtie/mobileCbCsMain'");
    }

  });

</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/chatbot/mobile_chat.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/chatbot/socket_client.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/chatbot/chatbot_monitor_socket.js"></script>
</body>

</html>