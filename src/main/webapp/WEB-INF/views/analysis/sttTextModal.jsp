<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 청취 -->
<div id="lyr_sttplayer" class="lyrBox">
    <div class="lyr_top">
        <h3><spring:message code="A0709" text="청취" /></h3>
        <button class="btn_lyr_close"><spring:message code="A0631" text="닫기" /></button>
    </div>
    <div class="lyr_mid">
        <div class="player">
            <div class="playerBox" id="playerBox">
               <%-- <audio preload="auto" controls="true" style="width:100%;">
                    <source src="http://10.122.64.152:5000/call/record/7040/5249/115">
                </audio>--%>
            </div>
        </div>
        <div class="chatBox">
            <div class="chatUI_mid">
                <ul class="lst_talk" id="dialogList">
                </ul>
            </div>
        </div>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button class="btn_lyr_close"><spring:message code="A0631" text="닫기" /></button>
        </div>
    </div>
</div>