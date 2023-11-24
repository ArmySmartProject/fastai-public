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
</head>

<body>
<!-- .page loading -->
<div id="pageldg" class="page_loading">
    <span class="out_bg">
        <em>
            <strong>&nbsp;</strong>
            <strong>&nbsp;</strong>
            <strong>&nbsp;</strong>
            <b>&nbsp;</b>
        </em>
    </span>
</div>
<!-- //.page loading -->

<!-- #wrap -->
<div id="wrap">
    <!-- #header -->
    <jsp:include page="../common/inc_header.jsp">
        <jsp:param name="titleCode" value="A0503"/>
        <jsp:param name="titleTxt" value="VOC 분석"/>
    </jsp:include>
    <!-- //#header -->

    <!-- #container -->
    <div id="container">
    </div>
    <!-- //#container -->

    <hr>

    <!-- #footer -->
    <div id="footer">
        <div class="cyrt"><span>&copy; MINDsLab. All rights reserved.</span></div>
    </div>
    <!-- //#footer -->
</div>
<!-- //#wrap -->

<%@ include file="../common/inc_footer.jsp"%>

<!-- script -->
<script type="text/javascript">
    var pageContents = "${pageContents}";

    $(document).ready(function () {
        if(pageContents == "keyword") {
            $("#container").load("${pageContext.request.contextPath}/analysis/highFrequencyKeyword");
        } else if(pageContents == "classification"){
            $("#container").load("${pageContext.request.contextPath}/analysis/inputReasonClassification");
        } else if(pageContents == "management"){
            $("#container").load("${pageContext.request.contextPath}/analysis/negativeCustomerManagement");
        } else {
            $("#container").load("${pageContext.request.contextPath}/analysis/highFrequencyKeyword");
        }
    });

    function setDate() {
        var nowDate = new Date();
        var stDate = new Date(nowDate.getFullYear(), nowDate.getMonth(), nowDate.getDate() - 7);

        $('#fromDate').datepicker('setDate', stDate);
        $('#toDate').datepicker('setDate', nowDate);
    }

    function openPopup(callId) {
        var winHeight = $(window).height()*0.7,
            hrefId = '#lyr_sttplayer';

        $('body').css('overflow','hidden');
        $('body').find(hrefId).wrap('<div class="lyrWrap"></div>');
        $('body').find(hrefId).before('<div class="lyr_bg"></div>');

        //대화 UI
        $('.lyrBox .lyr_mid').each(function(){
            $(this).css('max-height', Math.floor(winHeight) +'px');
        });


        $.ajax({
            url: "${pageContext.request.contextPath}/getAudioInfo",
            method : 'POST',
            data: {callId: callId},
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            }
        }).done(function (data) {
            var audioDiv = document.getElementById('playerBox');
            var audio = document.createElement("audio");
            audio.controls = true;
            audio.style.width = '100%';

            var source = document.createElement("source");
            source.src = 'http://' + data['audioUrl'] + '/call/record/' + data['callId'] + '/' + data['contractNo'] + '/' + data['campaignId'];

            audio.appendChild(source);
            audioDiv.appendChild(audio);
        });

        $.ajax({
            url: "${pageContext.request.contextPath}/getSttText",
            method : 'POST',
            data: {callId: callId},
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            }
        }).done(function (data) {
            var template = "";
            data.forEach(function(item, idx){
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

                if(data.length -1 === idx) {
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
</body>
</html>
