<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
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
<!-- #wrap -->
<div id="wrap" class="">
    <!-- #header -->
    <jsp:include page="../common/inc_header.jsp">
        <jsp:param name="titleCode" value="A0505"/>
        <jsp:param name="titleTxt" value="Recoding Monitor"/>
    </jsp:include>
    <!-- //#header -->
    <!-- #container -->
    <div id="container">
        <div id="contents">
            <!-- .content -->
            <div class="content">
                <!-- 검색조건 -->
                <div class="srchArea">
                    <table class="tbl_line_view" summary="Company, 콜넘버, 검색일자로 구성됨">
                        <caption class="hide">검색조건</caption>
                        <colgroup>
                            <col width="80">
                            <col>
                            <col width="100">
                            <col width="27%">
                            <col width="80">
                            <col width="27%">
                            <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                        </colgroup>
                        <tbody>
                        <tr>
                            <th scope="row">Company</th>
                            <td>
                                <%-- <select class="select">
                                     <option>1-800-XXXX</option>
                                 </select>--%>
                                <div class="iptBox">
                                    <input type="text" id="company_name" class="ipt_txt" autocomplete="off">
                                </div>

                            </td>
                            <th scope="row">Recording Server</th>
                            <td>
                                <dl>
                                    <dt>
                                        <label for="rs_ip">IP</label>
                                    </dt>
                                    <dd>
                                        <select id="rs_ip" class="select">
                                            <option value="127.0.0.1">127.0.0.1</option>
                                        </select>
                                    </dd>
                                </dl>
                                <dl>
                                    <dt>
                                        <label for="rs_port">Port</label>
                                    </dt>
                                    <dd>
                                        <div class="iptBox">
                                            <input type="text" id="rs_port" class="ipt_txt" value="8080" placeholder="8080" autocomplete="off">
                                        </div>
                                    </dd>
                                </dl>
                            </td>
                            <th scope="row">DB Server</th>
                            <td>
                                <dl>
                                    <dt>
                                        <label for="db_ip">IP</label>
                                    </dt>
                                    <dd>
                                        <select id="db_ip" class="select">
                                            <option value="10.122.64.152">10.122.64.152</option>
                                        </select>
                                    </dd>
                                </dl>
                                <dl>
                                    <dt>
                                        <label for="db_port">Port</label>
                                    </dt>
                                    <dd>
                                        <div class="iptBox">
                                            <input type="text" id="db_port" class="ipt_txt" value="3306" placeholder="3306" autocomplete="off">
                                        </div>
                                    </dd>
                                </dl>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Phone No.</th>
                            <td>
                                <%--<select class="select">
                                    <option value="201-123-2456">201-123-2456</option>
                                </select>--%>
                                <div class="iptBox">
                                    <input type="text" id="phone_no" class="ipt_txt" autocomplete="off">
                                </div>
                            </td>
                            <th scope="row">Campaign Name</th>
                            <td>
                                <%-- <select class="select">
                                    <option value="테스트캠페인">테스트캠페인</option>
                                </select> --%>
                                <div class="iptBox">
                                    <input type="text" id="campaign_name" class="ipt_txt" autocomplete="off">
                                </div>
                            </td>
                            <th scope="row">Date Time</th>
                            <td>
                                <div class="iptBox">
                                    <input type="text" name="fromDate" id="fromDate" class="ipt_dateTime" autocomplete="off"/>
                                    <span>-</span>
                                    <input type="text" name="toDate" id="toDate" class="ipt_dateTime" autocomplete="off"/>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="btnBox sz_small line">
                        <button type="button" class="btnS_basic" onclick="search()">Search</button>
                    </div>
                </div>
                <!-- //검색조건 -->

                <!-- .stn -->
                <div class="stn allBoxType">
                    <div class="stn_cont">
                        <table class="tbl_bg_lst03">
                            <caption class="hide">Call Recording List</caption>
                            <colgroup>
                                <col>
                                <col>
                                <col>
                                <col>
                                <col>
                                <col>
                                <col>
                            </colgroup>
                            <thead>
                            <tr>
                                <th scope="col">Call ID</th>
                                <th scope="col">Call Type</th>
                                <th scope="col">Starting Date Time</th>
                                <th scope="col">End Date Time</th>
                                <th scope="col">Duration (Sec)</th>
                                <th scope="col">Phone No.</th>
                                <th scope="col">Campaign Name</th>
                            </tr>
                            </thead>
                            <tbody id="result-tbody">
                            <tr>
                                <td class="dataNone" colspan="7"><spring:message code="A0257" text="등록된 데이터가 없습니다." /></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <%@ include file="./callRecordPaging.jsp"%>
                </div>
            </div>
            <!-- //.stn -->
        </div>
        <!-- //.content -->
        <!-- #aside -->
        <div id="aside">
            <div class="player">
                <div id="playerBox" class="playerBox">
                </div>
            </div>
            <div class="aside_tit">
                <h3>Speaker</h3>
            </div>
            <div class="aside_cont pd_t0">
                <div id="radioBox" class="radioBox">
                    <input type="radio" id="asideRadio01" class="ipt_radio" value="all" checked="">
                    <label for="asideRadio01">All</label>
                    <input type="radio" id="asideRadio02" class="ipt_radio" value="user">
                    <label for="asideRadio02">Caller</label>
                    <input type="radio" id="asideRadio03" class="ipt_radio" value="bot">
                    <label for="asideRadio03">Agent</label>
                </div>
            </div>
            <div class="aside_tit">
                <h3>Keyword</h3>
            </div>
            <div class="aside_cont pd_t0">
                <div class="iptBox">
                    <input type="text" id="stt-keyword" class="ipt_txt_btn">
                    <button type="button" id="stt-move" class="btnS_basic">Move</button>
                </div>
            </div>
            <!-- .chatBox -->
            <div class="chatBox" style="margin:10px 0 0 0;">
                <div class="chatUI_mid" style="height:600px;">
                    <ul id="dialogList" class="lst_talk">
                        <!-- bot UI -->
                        <%-- <li class="bot">
                            <div class="bot_msg">
                                <em class="txt">안녕하세요 마음에이아이 음성봇 설리입니다 무엇을 도와드릴까요</em>
                                <div class="date">2019.08.14 12:00</div>
                            </div>
                        </li> --%>
                        <!-- //bot UI -->
                        <!-- 사용자 UI -->
                        <%-- <li class="user">
                            <div class="bot_msg">
                                <em class="txt">제품을 좀 알아보려고 하는데요</em>
                                <div class="date">2019.08.14 12:00</div>
                            </div>
                        </li> --%>
                        <!-- //사용자 UI -->
                    </ul>
                </div>
            </div>
            <!-- //.chatBox -->
            <div class="btnBox asideBtm">
                <button type="button" id="btn_aside_close" class="btnS_basic">Close</button>
            </div>
        </div>
        <!-- //.aside -->
    </div>
    <!-- //#container -->

    <hr>

    <!-- #footer -->
    <div id="footer">
        <div class="cyrt"><span>© MINDsLab. All rights reserved.</span></div>
    </div>
    <!-- //#footer -->
</div>
<!-- //#wrap -->

<!-- ===== layer popup ===== -->
<!-- 사용자 비밀번호 변경 -->
<div id="lyr_profile" class="lyrBox">
    <div class="lyr_top">
        <h3>사용자 정보</h3>
        <button class="btn_lyr_close">닫기</button>
    </div>
    <div class="lyr_mid">
        <dl class="dlBox">
            <dt>아이디</dt>
            <dd>
                <div class="iptBox">
                    <input type="text" class="ipt_txt" value="adsf2355@naver.com" disabled="">
                </div>
            </dd>
        </dl>
        <dl class="dlBox">
            <dt>이름</dt>
            <dd>
                <div class="iptBox">
                    <input type="text" class="ipt_txt" value="홍길동" disabled="">
                </div>
            </dd>
        </dl>
        <dl class="dlBox">
            <dt>비밀번호</dt>
            <dd>
                <div class="iptBox" style="margin-bottom:7px;">
                    <input type="password" class="ipt_txt" placeholder="비밀번호">
                </div>
                <div class="iptBox">
                    <input type="password" class="ipt_txt" placeholder="비밀번호 확인">
                    <!-- [D] 에러메세지
                    <p class="error_msg">패스워드가 일치하지 않습니다.</p> -->
                </div>
            </dd>
        </dl>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button class="btn_lyr_close">저장</button>
            <button class="btn_lyr_close">취소</button>
        </div>
    </div>
</div>
<!-- //사용자 비밀번호 변경 -->
<!-- 서비스 신청 및 문의하기 -->
<div id="lyr_join" class="lyrBox contactBox">
    <div class="contact_tit">
        <h3>서비스 신청 및 문의하기</h3>
    </div>
    <div class="contact_cnt">
        <p class="info_txt">서비스에 관련된 문의를 남겨 주시면 담당자가 확인 후 연락 드리겠습니다.</p>
        <ul class="contact_lst">
            <li><a href="tel:1661-3222">1661-3222</a></li>
            <li><span>hello@maum.ai</span></li>
        </ul>
        <div class="contact_form">
            <div class="contact_item">
                <input type="text" id="user_name" class="ipt_txt" autocomplete="off">
                <label for="user_name">
                    <span class="fas fa-user" aria-hidden="true"></span>이름
                </label>
            </div>
            <div class="contact_item">
                <input type="text" id="user_email" class="ipt_txt" autocomplete="off">
                <label for="user_email">
                    <span class="fas fa-envelope" aria-hidden="true"></span>이메일
                </label>
            </div>
            <div class="contact_item">
                <input type="text" id="user_phone" class="ipt_txt" autocomplete="off">
                <label for="user_phone">
                    <span class="fas fa-mobile-alt" aria-hidden="true"></span>연락처
                </label>
            </div>
            <div class="contact_item_block">
                <textarea id="user_txt" class="textArea" rows="6"></textarea>
                <label for="user_txt">
                    <span class="fas fa-align-left" aria-hidden="true"></span>문의내용
                </label>
            </div>
        </div>
    </div>
    <div class="contact_btn">
        <button id="btn_sendMail" class="btn_inquiry">문의하기</button>
        <button class="btn_lyr_close">닫기</button>
    </div>
</div>
<!-- //서비스 신청 및 문의하기 -->

<%@ include file="../common/inc_footer.jsp"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/player.js"></script>

<script type="text/javascript">
    $(document).ready(function(){
        //setDate();
        //화자 선택에 따른 텍스트 처리
        selectSpeaker();
        //stt 텍스트 키워드 하이라이트
        sttHighlight();


        var lang = $.cookie("lang");
        var tDate = new Date();
        tDate.setHours(-(24*7))
        tDate = getFormatDate(tDate);

        $("#fromDate").val(tDate);//기본값 오늘

        var tDate = new Date();
        tDate = getFormatDate(tDate);
        $("#toDate").val(tDate);//기본값 오늘

        if(lang == "ko"){
            //datepicker
            $('#fromDate').datetimepicker({
                language : 'ko', // 화면에 출력될 언어를 한국어로 설정합니다.
                pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
                defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
                autoclose: 1,
            }).on('changeDate', function(selectedDate){
                $("#toDate").datetimepicker('setStartDate',selectedDate.date);
            });



            $('#toDate').datetimepicker({
                language : 'ko', // 화면에 출력될 언어를 한국어로 설정합니다.
                pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
                defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
                autoclose: 1,
            }).on('changeDate', function(selectedDate){
                $("#fromDate").datetimepicker('setEndDate',selectedDate.date);
            });
        }else if(lang == "en"){
            //datepicker
            $('#fromDate').datetimepicker({
                language : 'ko', // 화면에 출력될 언어를 한국어로 설정합니다.
                pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
                defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
                autoclose: 1,
            }).on('changeDate', function(selectedDate){
                $("#toDate").datetimepicker('setStartDate',selectedDate.date);
            });

            $('#toDate').datetimepicker({
                language : 'ko', // 화면에 출력될 언어를 한국어로 설정합니다.
                pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
                defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
                autoclose: 1,
            }).on('changeDate', function(selectedDate){
                $("#fromDate").datetimepicker('setEndDate',selectedDate.date);
            });
        }

    });

    var highlightedIdx = -1;
    // TODO: move버튼 한번에 매칭되는 단어 한개만 하이라이팅 2020.04.29 - khs
    function sttHighlight(){

        $("#stt-move").off("click").on("click",function(e){

            var sttKeyword = $("#stt-keyword").val();

            //키워드가 빈 문자열인지 확인
            if(sttKeyword.replace(" ","") != ""){
                var lastMatchedTermIdx = 0; // 마지막 매칭된 단어의 index
                $("#dialogList em.txt").each(function(index){
                    if($(this).parent().parent().css("display") !== "none"){
                        var chatTxt = $(this).html();
                        var matchedTermIndex = chatTxt.indexOf(sttKeyword);

                        if(matchedTermIndex >= 0){
                            lastMatchedTermIdx = index;
                        }
                    }
                });


                $("#dialogList em.txt").each(function (index) {
                    //숨긴 안된 대화만 키워드 검색 대상에 포함
                    if($(this).parent().parent().css("display") !== "none"){
                        var chatTxt = $(this).text();
                        var matchedTermIndex = chatTxt.indexOf(sttKeyword);

                        console.log("sttHighlight> " + chatTxt + "[" + matchedTermIndex + "]");

                        if (matchedTermIndex >= 0) {
                            // 모든 하이라이트 제거
                            resetHighlight();
                            console.log("highlightedIdx: " + highlightedIdx + ", index: " + index);

                            // highlightedIdx >= lastMatchedTermIdx이면
                            // highlightedIdx = -1 초기화 해서 다시 처음부터 검색 시작
                            if (index > highlightedIdx) {
                                var html = chatTxt.substring(0, matchedTermIndex) + "<mark>"
                                    + chatTxt.substring(matchedTermIndex, matchedTermIndex + sttKeyword.length)
                                    + "</mark>" + chatTxt.substring(matchedTermIndex + sttKeyword.length, chatTxt.length);

                                $(this).html(html);

                                // 하이라이트된 단어가 포함된 텍스트로 스크롤바 위치시킴
                                scrollIntoTarget(this);

                                highlightedIdx = index;
                                if (highlightedIdx >= lastMatchedTermIdx) {
                                    highlightedIdx = -1;
                                }

                                return false;
                            }
                        }
                    }
                });
            }
        });
    }

    function scrollIntoTarget(target){
        var scrollPos = $(target).parent().parent().offset().top;
        var realScrollPos = $(".chatUI_mid").scrollTop() + scrollPos;
        var chatUITop = $(".chatUI_mid").offset().top;
        console.warn("scrollIntoTarget" + scrollPos + "," + realScrollPos);
        $(".chatUI_mid").animate({scrollTop: realScrollPos - chatUITop}, 500);
    }

    function resetHighlight(){
        $("#dialogList em.txt").each(function(index, item){
            var tmpTxt = $(this).text();
            $(this).remove("mark");
            $(this).text(tmpTxt);
        });
    }

    function search(){
        var company = $("#company_name").val();
        var recordingServerIp = $("#rs_ip option:selected").val();
        var recordingServerPort = $("#rs_port").val();
        var dbIp = $("#db_ip option:selected").val();
        var dbPort =$("#db_port").val();
        var phoneNo = $("#phone_no").val();
        var campaignName = $("#campaign_name").val();
        var fromDate = $("#fromDate").val();
        var toDate = $("#toDate").val();

        var page = $(".paging").find('input[name="cur-page"]').val();
        var amount = $(".paging").find('input[name="amount"]').val();

        var sendData = {
            "page":(page-1)*amount,
            "amount":amount,
            "company":company,
            "recordingServerIp":recordingServerIp,
            "recordingServerPort":recordingServerPort,
            "dbIp":dbIp,
            "dbPort":dbPort,
            "sipUser":phoneNo,
            "campaignName":campaignName,
            "startDateTime":fromDate,
            "endDateTime":toDate
        };

        //console.warn(sendData);

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/callRecording/getMonitorSearchResult",
            data: sendData,
            beforeSend:function(xhr){
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success:function(resp){
                console.log("getMonitorSearchResult");
                console.log(resp);

                var receivedData = JSON.parse(resp);

                var resultTbody = $("#result-tbody");
                resultTbody.empty();

                if(receivedData.list.length !== 0){

                    for(var i=0; i<receivedData.list.length; i++){
                        var html = '<tr>\n'+
                            '                                <th scope="row"><a class="link" href="#none" onclick="openPopup(' + receivedData.list[i].callId + ')">' + receivedData.list[i].callId + '</a>\n'+
                            '                                </th>\n'+
                            '                                <td>' + receivedData.list[i].callTypeCode + '</td>\n'+
                            '                                <td>' + receivedData.list[i].startTime + '</td>\n'+
                            '                                <td>' + receivedData.list[i].endTime + '</td>\n'+
                            '                                <td>' + receivedData.list[i].duration + '</td>\n'+
                            '                                <td>' + receivedData.list[i].sipUser + '</td>\n'+
                            '                                <td>' + receivedData.list[i].campaignName + '</td>\n'+
                            '                            </tr>\n'+
                            '                            </tr>';

                        resultTbody.append(html);
                    }
                    goPage(receivedData.pagingVO, "result");
                }
                else{
                    var html = '<tr>\n' +
                        '<td class="dataNone" colspan="7"><spring:message code="A0257" text="등록된 데이터가 없습니다." /></td>\n' +
                        '</tr>';

                    resultTbody.append(html);
                }
            },
            error:function(){
                console.error("getMonitorSearchResult error");
            }
        });

    }

    /*   function setDate() {
          var nowDate = new Date();
          var stDate = new Date(nowDate.getFullYear(), nowDate.getMonth(), nowDate.getDate() - 7);

          $('#fromDate').datepicker('setDate', stDate);
          $('#toDate').datepicker('setDate', nowDate);
      } */

    function selectSpeaker(){
        $("#aside .radioBox input:radio").off("click").on("click", function(e){
            $(".radioBox").change(function(){
                console.log("radioBox changed");
                highlightedIdx = -1;
                resetHighlight();
            });

            var radioBoxChecked = $(this).val();
            console.log(radioBoxChecked);

            $("#dialogList > li").each(function(){
                console.log(this + $(this).hasClass(radioBoxChecked));
                if(radioBoxChecked !== 'all'){
                    if(!$(this).hasClass(radioBoxChecked)){
                        $(this).attr("style","display:none");
                    }
                    else{
                        $(this).attr("style","");
                    }
                }
                else{
                    $(this).attr("style","");
                }
            });
        });
    }

    function openPopup(callId) {
        console.log("openPopup: " + callId);

        $.ajax({
            url: "${pageContext.request.contextPath}/callRecording/getAudioInfo",
            method : 'POST',
            data: {callId: callId},
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            }
        }).done(function (resp) {

            var audioDiv = document.getElementById('playerBox');
            var audio = document.createElement("audio");
            audio.controls = true;
            audio.style.width = '100%';

            var source = document.createElement("source");
            source.src = 'http://' + resp['audioUrl'] + '/call/record/' + resp['callId'] + '/' + resp['contractNo'] + '/' + resp['campaignId'];

            $("#playerBox").empty();
            audio.appendChild(source);
            audioDiv.appendChild(audio);
        })

        $.ajax({
            url: "${pageContext.request.contextPath}/callRecording/getSttText",
            method : 'POST',
            data: {callId: callId},
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            }
        }).done(function (resp) {
            var template = "";
            resp.forEach(function(item, idx){

                var speaker = '';
                if(item['speakerCode'] === 'ST0002') {
                    speaker = 'bot'; // 상담사
                } else if(item['speaker_code'] === 'ST0001') {
                    speaker = 'user'; //고객
                } else {
                    speaker = 'user';
                }

                template +=
                    "<li class='" + speaker + "'>" +
                    "<div class='bot_msg'>" +
                    "<em class='txt'>" + item['sentence'] + "</em>" +
                    "<div class='date'>" + item['createdDtm'] + "</div>" +
                    "</div>"
                "</li>"

                if(resp.length -1 === idx) {
                    $('#dialogList').empty();
                    $('#dialogList').append(template);
                }
            });
        });

        //Layer popup close
        $('.btn_lyr_close, .lyr_bg').on('click',function(){
            $('body').css('overflow','');
            $('body').find(hrefId).unwrap();
            $('#playerBox').empty();
            $('.lyr_bg').remove();

            $('.btn_lyr_close, .lyr_bg').off();
        });
    }
</script>


<!-- page Landing -->
<script type="text/javascript">
    $(window).load(function() {
        //page loading delete
        $('#pageldg').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });
    });
</script>
<!-- script -->
<script type="text/javascript">
    jQuery.event.add(window,"load",function(){
        $(document).ready(function (){
            // GCS iframe
            $('.gcsWrap', parent.document).each(function(){
                //header 화면명 변경
                var pageTitle = $('title').text().replace('> FAST AICC', '');

                $(top.document).find('#header h2 a').text(pageTitle);
            });

            /* //datetimepicker
            $('#fromDate').datetimepicker({
                language : 'ko', // 화면에 출력될 언어를 한국어로 설정합니다.
                pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
                defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
                autoclose: 1,
            });

            $('#toDate').datetimepicker({
                language : 'ko', // 화면에 출력될 언어를 한국어로 설정합니다.
                pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
                defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
                autoclose: 1,
            }); */

            //aside
            $('.tbl_bg_lst03 tbody').on('click','a.link',function(){
                $('#aside').addClass('show');
            });

            //player
            $('audio').audioPlayer();
            $('.btn_player_play').on('click',function(){
                $(this).toggleClass('pause');
            });

            //aside(radio)
            $('#aside .radioBox .ipt_radio').on('click',function(){
                var asideRadioChecked = $(this).prop('checked');

                if ( asideRadioChecked ) {
                    $('#aside .radioBox .ipt_radio').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });

            //aside close
            $('#btn_aside_close').on('click',function(){
                //reset highlightedIdx
                highlightedIdx = -1;
                //reset hightlighted terms
                resetHighlight();
                //키워드 초기화
                $("#stt-keyword").val("");

                $('#aside').removeClass('show');

                // radio box 초기화
                $("#radioBox input[type='radio']").removeAttr('checked');
                $("#radioBox input[type='radio']")[0].checked = true;

            });
        });
    });


</script>
</body>
</html>
