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

<body class="gcsWrap">
	<c:forEach end="5" items="${phoneListResult}" var="botToAudio" varStatus="audioCnt">
		<audio id="alarmAudio_${botToAudio.sipUser}" src="${pageContext.request.contextPath}/resources/audio/telephone-ring-10sec.wav" muted="muted" autoplay ></audio>
	</c:forEach>
	<!-- .page loading -->
	<div id="pageldg" class="page_loading">
		<span class="out_bg"> <em> <strong>&nbsp;</strong> <strong>&nbsp;</strong> <strong>&nbsp;</strong> <b>&nbsp;</b>
		</em>
		</span>
	</div>
	<!-- //.page loading -->
	<!-- #wrap -->
	<div id="wrap">
	<input type="hidden" id= "headerName"  value="${_csrf.headerName}" />
	<input type="hidden" id= "token"  value="${_csrf.token}" />
	<input type="hidden" id= "csType"  value="${csType}" />
	<input type="hidden" id="OP_LOGIN_ID">
	<input type="hidden" id="voiceUrl" value="${voiceUrl}">
	<input type="hidden" id="proxyUrl" value="${proxyUrl}">
	<input type="hidden" id="handleCsInfoType" value="update"/>
	<input type="hidden" id="selectDate">
	<input type="hidden" id="selectHost">
	<input type="hidden" id="selectRoomId">
		<%@ include file="../common/inc_header_chat.jsp"%>
		<!-- #container -->
		<div id="container">
        <!-- .section -->
        <div class="section">
            <!-- //.tab_calling -->
            <div class="tab_calling_view2">
                <div class="tbl_cell" style="width:40%;">
                    <!-- .callView -->
                    <div class="callView">
                        <!-- .callView_tit -->
                        <div class="callView_tit">
                            <h3><spring:message code="A0700" text="상담목록" /></h3>
                            <div class="fr multiSelector">
	                            <select id="multiple_select01" class="select" multiple="multiple" onchange="changeDate();">
	                            </select>
                        	</div>
                            <div class="fr">
                                <select style="display:none" class="select">
                                    <option><spring:message code="A0903" text="상담 및 대기" /></option>
                                    <option><spring:message code="A0530" text="전체" /></option>
                                    <option><spring:message code="A0704" text="챗봇" /></option>
                                </select>
                            </div>
                        </div>
                        <!-- //.callView_tit -->
                        <!-- .callView_cont -->
                        <div class="callView_cont" style="height:auto;">
                            <ul class="lst_dialogue scroll">
<!--                                 <li> -->
<!--                                     <p>상담 가능한 목록이 없습니다.</p> -->
<!--                                 </li> -->
                            </ul>
                        </div>
                        <!-- //.callView_cont -->
                    </div>
                    <!-- //.callView -->
                </div>
                <!-- //.tbl_cell -->
                <!-- .tbl_cell -->
                <div class="tbl_cell callDetail" style="width:60%;">
                    <!-- .callView -->
                    <div class="callView">
                        <!-- .callView_tit -->
                        <div class="callView_tit">
                            <h3><spring:message code="A0701" text="고객상담" /> <span></span></h3>

                        </div>
                        <!-- //.callView_tit -->
                        <!-- .callView_cont -->
                        <div class="callView_cont">
                            <!-- .cont_cell -->
                            <div class="cont_cell">
                                <div class="chatUI_mid btmUi" style="width:526px;height:625px">
                                    <ul class="lst_talk">
                                    </ul>
                                </div>
                                <!-- .chatUI_btm -->
                                <div class="chatUI_btm">
                                    <form method="post" action="" id="formChat" name="formChat">
                                        <textarea disabled class="textArea" rows="1" placeholder="<spring:message code="A0901" text="메세지를 입력해 주세요" />" name="user_message"></textarea>
                                        <input type="button" name="btn_chat" id="btn_chat" class="btn_chat" title="전송" value="전송">
                                    </form>
                                </div>
                                <!-- //#chatUI_btm -->
                            </div>
                            <!-- //.cont_cell -->
                            <!-- .cont_cell -->
                            <div class="cont_cell">
                                <h4 class="tbl_tit" style="padding:0 0 3px 0;"><spring:message code="A0014" text="고객정보" /></h4>
                                <table class="tbl_line_view chatbot_info_table" summary="인입채널/세션ID/성명으로 구성됨">
                                    <caption class="hide">고객정보</caption>
                                    <colgroup>
                                        <col width="70"><col>
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th scope="row"><spring:message code="A0702" text="인입채널" /></th>
                                            <td class="cs_service"></td>
                                        </tr>
                                        <tr>
                                          <th scope="row"><spring:message code="A0702_1" text="카테고리" /></th>
                                          <td class="cs_category"></td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><spring:message code="A0706" text="세션 ID" /></th>
                                            <td class="session_id"></td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><spring:message code="A0039" text="성명"/></th>
                                            <td class="user_id"></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <h4 class="tbl_tit" style="display:block; padding:20px 0 3px 0;"><spring:message code="A0065" text="상담내용"/></h4>
                                <table class="tbl_line_view" style="display:block;" summary="인입채널/세션ID/성명으로 구성됨">
                                    <caption class="hide">고객정보</caption>
                                    <colgroup>
                                        <col width="70"><col>
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th scope="row"><spring:message code="A0070" text="상담내용 메모"/></th>
                                            <td>
                                                <div class="textareaBox">
                                                    <textarea id="consultTxt" class="textArea" disabled></textarea>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!-- //.cont_cell -->
                        </div>
                        <!-- //.callView_cont -->
                        <div class="btnBox sz_small line">
                            <div class="fl">
                                <a href="#lyr_intervention" id="btn_intervention" class="btnS_basic btn_lyr_open hide"><spring:message code="A0107" text="상담개입"/></a>
                                <a href="#lyr_intervention_stop" id="btn_intervention_stop" class="btnS_red btn_lyr_open hide"><spring:message code="A0703" text="상담종료"/></a>
                            </div>
                            <div class="btnBox_consult fr">
                                <!-- 버튼 클래스선언: btnS_green(초록), btnS_red(빨강), btnS_basic(일반)  -->
                                <button type="button" id="work_break" class="btnS_basic" onclick="updateMemo();" disabled style="display:block;"><spring:message code="A0320" text="저장"/></button>
                            </div>
                        </div>
                    </div>
                    <!-- //.callView -->
                </div>
                <!-- //.tbl_cell -->

            </div>
        </div>
    </div>
		<!-- //#container -->

		<hr>

		<!-- #footer -->
		<div id="footer">
			<div class="cyrt">
				<span>&copy; MINDsLab. All rights reserved.</span>
			</div>
		</div>
		<!-- //#footer -->
	</div>
	<!-- //#wrap -->

    <%@ include file="../common/inc_footer.jsp" %>

	<!-- 상담 개입하기 -->
	<div id="lyr_intervention" class="lyrBox">
	    <div class="lyr_top">
	        <h3><spring:message code="A0107" text="상담 개입하기"/></h3>
	        <button class="btn_lyr_close"><spring:message code="A0631" text="닫기"/></button>
	     </div>
	    <div class="lyr_mid">
	        <div class="transferBox">
	            <div class="imgBox">
	                <img src="${pageContext.request.contextPath}/resources/images/ico_api_bot.png" alt="봇">
	                <span>변경</span>
	                <img src="${pageContext.request.contextPath}/resources/images/ico_agent_bk.png" alt="상담사">
	            </div>
	            <p class="txt"><spring:message code="A0902" text="해당 상담을 진행하시겠습니까?"/></p>
	        </div>
	    </div>
	    <div class="lyr_btm">
	        <div class="btnBox sz_small">
	            <button id="btn_transfer_cslor" class="btn_lyr_close"><spring:message code="A0107" text="개입하기"/></button>
	        </div>
	    </div>
	</div>
	<!-- //상담 개입하기 -->

	<!-- 상담 종료하기 -->
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
	    <div class="lyr_btm">
	        <div class="btnBox sz_small">
	            <button id="btn_call_end" class="btn_lyr_close"><spring:message code="A0703" text="상담종료"/></button>
	        </div>
	    </div>
	</div>
	<!-- //상담 종료하기 -->

	<!-- script -->
	<script type="text/javascript">
		$.event.add(window, "load", function() {
			$(document).ready(function() {
				
				//상담사 업무상태 button
				$('.consultStatus button').on('click',function(){
					$('.consultStatus button').removeClass('active');
					$(this).addClass('active');
		
					$('body').append(' \
			                 <div class="lyrWrap moment"> \
			                     <div class="lyr_bg"></div> \
			                     <div class="lyrBox" >\
			                        <div class="lyr_top"> \
			                        </div> \
			                        <div class="lyr_mid"> \
			                            <div class="icoBox"> \
			                                <img src="${pageContext.request.contextPath}/resources/images/img_status.png" alt="저장완료"> \
			                            </div> \
			                            <p class="massage"><spring:message code="A0722" text="업무상태가 변경 되었습니다." /></p> \
			                        </div> \
			                    </div> \
			                </div> \
			            ');
					$('.moment, .moment .lyrBox').show();
					setTimeout(function() {
						$('.moment').addClass('lyr_hide').delay(300).queue(function() { $(this).remove(); });
					}, 1000);
				});
				
				
			});
		});
	
		$("#multiple_select01").multiselect({
	        includeSelectAllOption: true,
	    });

		if($("#multiple_select01 option").length == 0){
			$(".multiselect-container").removeClass("dropdown-menu");
		}else{
			$(".multiselect-container").addClass("dropdown-menu");
		}

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

			if($("#multiple_select01 option").length == 0){
				$(".multiselect-container").removeClass("dropdown-menu");
			}else{
				$(".multiselect-container").addClass("dropdown-menu");
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

	   /*
		*  상단 상담사 상태변환
		*/
		function chOpStatus(STATUS){

			var json = new Object();
			var jsonObj= new Object();

			json.CHAT_CONSULT_STATUS = STATUS;
			jsonObj.CsDtlOpStatus=json;
			jsonObj.updateYn = "Y";

			ajaxCall("${pageContext.request.contextPath}/getOpChatState", $("#headerName").val(), $("#token").val(),	JSON.stringify(jsonObj), "N");
// 			updateOpStatusSocket("update");
		}
	   
	   function updateMemo(){
		   
		   var obj = new Object();
		   var consultTxt = $("#consultTxt").val();
		   var host = $("#selectHost").val();
		   var roomId = $("#selectRoomId").val();
		   
		   obj.supporterComment = consultTxt;
		   obj.host = host;
		   obj.roomId = roomId;
		   
		   if(consultTxt.length >= 500){
			   alert("글자수 500자 이상 쓰실 수 없습니다.");
			   return false;
		   }
		   
		   $.ajax({
				url : "${pageContext.request.contextPath}/updateChatMemo",
				data : JSON.stringify(obj),
				method : 'POST',
				contentType : "application/json; charset=utf-8",
				beforeSend : function(xhr) {
					xhr.setRequestHeader($("#headerName").val(),$("#token").val());
				},
			}).success(function(result) {
				alert("상담메모가 저장되었습니다.");
			}).fail(function(result) {
			});
		   
	   }

	</script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/2.0.1/socket.io.js"></script>
	<script type="text/javascript">
		var serverURL = '${chatServerURL}';
		console.log('chat server URL is ' + serverURL);

		// var userId = 'GCS 채팅상담사';
		var userType = 'supporter';
		var userOption = 'gcs';

    var chatbotInfos = ${chatbotInfos};
	</script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/chatbot/chat.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/chatbot/socket_client.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/chatbot/chatbot_monitor_socket.js"></script>
</body>
</html>
