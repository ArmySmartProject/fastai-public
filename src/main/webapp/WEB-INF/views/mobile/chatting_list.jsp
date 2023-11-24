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
          integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf"
          crossorigin="anonymous">
    <%@ include file="../common/inc_head_resources.jsp"%>
    <title>chatting list</title>
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
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/mobile/login'" id="btnPrev" class="chevron_prev text_hide">이전으로 가기</button>
        <div class="title">
            <em>채팅상담</em>
        </div>
        <div class="fr multiSelector" style="display:none">
            <select id="multiple_select01" class="select" multiple="multiple" onchange="changeDate();">
            </select>
        </div>
    </div>
    <!-- //connect_top -->
    <div id="m_ct" class="m_chatting">
        <ul class="lst_dialogue scroll">
            <%--<!-- [D] AMR 200921 li에 상담 상태 추가--%>
            <%--li.alarm -> 상담요청 (상담사에게 상담요청 +백그라운드 반짝임 효과)--%>
            <%--li.calling -> 상담중 (상담사와 상담중)--%>
            <%--li -> 챗봇 (쳇봇과 상담중)--%>
            <%---->--%>
            <%--<li class="alarm">--%>
            <%--<!-- [D] 새로운 메세지가 0일 때는--%>
            <%--.new_message 에 .hide 추가해주세요 -->--%>
            <%--<div class="new_message"><span class="text_hide">새로운 메세지</span><em class="message_num">2</em><span class="text_hide">개</span></div>--%>
            <%--<!-- [D] .chat_time format--%>
            <%--오늘 : 오전/오후 HH:MM--%>
            <%--하루 전 : 어제--%>
            <%--이번연도 : MM월 DD일--%>
            <%--이전연도 : YYYY.MM.DD--%>
            <%---->--%>
            <%--<span class="status">--%>
            <%--<em class="chat_time">오후 4:33</em>--%>
            <%--<span class="state">상담요청</span>--%>
            <%--</span>--%>

            <%--<div class="image">--%>
            <%--<em>M</em>--%>
            <%--</div>--%>
            <%--<a href="#none">--%>
            <%--<em class="label">maum.ai</em>--%>
            <%--<span class="last_text ">고객님 팬심 서비스 답변입니다.</span>--%>
            <%--</a>--%>
            <%--</li>--%>

            <%--<li class="calling">--%>
            <%--<div class="new_message"><span class="text_hide">새로운 메세지</span><em class="message_num">99+</em><span class="text_hide">개</span></div>--%>

            <%--<div class="status">--%>
            <%--<em class="chat_time">어제</em>--%>
            <%--<span class="state">상담중</span>--%>
            <%--</div>--%>

            <%--<div class="image">--%>
            <%--<em>온</em>--%>
            <%--</div>--%>
            <%--<a href="chat_user.html">--%>
            <%--<em class="label">온누리</em>--%>
            <%--<span class="last_text">제가 그 때 마이페이지에서 설정을 바꿨는데 그 이후로 즐겨찾기한 기업이 뜨지를 않아요. 어떻게 해야 하나요?</span>--%>
            <%--</a>--%>
            <%--</li>--%>

            <%--<li>--%>
            <%--<div class="new_message hide"><span class="text_hide">새로운 메세지</span><em class="message_num">0</em><span class="text_hide">개</span></div>--%>

            <%--<div class="status">--%>
            <%--<em class="chat_time">09월 18일</em>--%>
            <%--<span class="state">챗봇</span>--%>
            <%--</div>--%>

            <%--<div class="image">--%>
            <%--<em>포</em>--%>
            <%--</div>--%>
            <%--<a href="chat_user.html">--%>
            <%--<em class="label">포몽드</em>--%>
            <%--<span class="last_text">https://annette-an.github.io/</span>--%>
            <%--</a>--%>
            <%--</li>--%>

            <%--<li>--%>
            <%--<div class="new_message hide"><span class="text_hide">새로운 메세지</span><em class="message_num">0</em><span class="text_hide">개</span></div>--%>

            <%--<div class="status">--%>
            <%--<em class="chat_time">2019.12.12</em>--%>
            <%--<span class="state">챗봇</span>--%>

            <%--</div>--%>
            <%--<div class="image">--%>
            <%--<em>팬</em>--%>
            <%--</div>--%>
            <%--<a href="chat_user.html">--%>
            <%--<em class="label">팬심</em>--%>
            <%--<span class="last_text">고객님 팬심 서비스 관련 어떤 내용이 궁굼하신가요??<br> 상담을 도와드리겠습니다.<br> 상담을 도와드리겠습니다.</span>--%>
            <%--</a>--%>
            <%--</li>--%>
        </ul>
        <!-- //chatting_list -->

    </div>
    <!-- //content -->
    <!-- //connect_btm -->
</div>
<!-- //m_wrap -->
<script type="text/javascript">
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

  function sendMail(){

    var ckInput = $("#sendmailForm > div > div > input, #sendmailForm > div > div > textarea");
    var confirmYn = true;

    $.each(ckInput, function(i, v){
      if(v.value == null || v.value == ""){
        alert("내용을 모두 입력해야 이메일을 전달 할 수 있어요!");
        confirmYn = false;
        return false;
      }
    });

    var user_name = $("#send_user_name").val();
    var user_phone = $("#send_user_phone").val();
    var user_text = $("#send_user_text").val();
    var user_email = $("#send_user_email").val();

    var title = user_name + " (" + user_phone + ") 님의 문의 사항입니다.";
    var msg = "이름 : " + user_name + "\n연락처 : " + user_phone + "\n문의 내용 : " + user_text;

    var data = '{"fromaddr":"'+user_email+'", "toaddr":"fastai@maum.ai", "subject":"'+title+'", "message":"'+msg+'"}';


    if(confirmYn){
      httpSend('/service/sendReqMail', $("#headerName").val(), $("#token").val(), data
          ,function(res){
            res = JSON.parse(res);
            if(res == "SUCC"){
              alert("이메일을 보냈습니다. 담당자 확인 후 연락 드리겠습니다 :)");
            }else{
              alert("Contact Us 메일발송 요청 실패하였습니다.");
            }
            console.log(res);
          });

      $.each(ckInput, function(i, v){
        if(v.value != null && v.value != ""){
          v.value = "";
          $(this).siblings('label').show();
        }
      });

      $("#close_sendmail_form").trigger("click");
    }

  }

</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.0.1/socket.io.js"></script>
<script type="text/javascript">
  var serverIp = '${domain}';
  var serverPort = '90';
  var serverURL = serverIp + ':' + serverPort;
  console.log('serverURL is ' + serverURL);

  // var userId = 'GCS 채팅상담사';
  var userType = 'supporter';
  var userOption = 'gcs';

  var chatbotInfos = ${chatbotInfos};

  $(document).ready(function() {

    var referrer = document.referrer;
    if (referrer.includes('mobile/redtie/login') || referrer.includes('redtie/mobileChatting')) {
      document.getElementById('btnPrev').setAttribute('onClick', "location.href='${pageContext.request.contextPath}/mobile/redtie/login'");
    }

  });
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/chatbot/mobile_chat.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/chatbot/socket_client.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/chatbot/chatbot_monitor_socket.js"></script>
</body>
</html>