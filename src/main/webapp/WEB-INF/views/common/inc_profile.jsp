<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String lang = (String)request.getAttribute("lang");
	String langTxt = lang.equals("ko")?"한국어":"English";
	String enabledYn =(String)request.getAttribute("enabledYn");
	
%>
<c:set value="<%=lang%>" var="lang"  />
<c:set value="<%=langTxt%>" var="langTxt"/>
<c:set value="<%=enabledYn%>" var="enabledYn"/>
<!-- etc -->
<div class="etc">
	<!-- [D] 검색기능은 IB,OB상담 화면에만 들어갑니다 --> 
<!-- 	<ul class="nav_etc"> -->
<!-- 	    <li class="ico_srch"> -->
<!-- 	       <a href="#lyr_searsh" class="btn_lyr_open" title="고객검색" ><span>고객검색</span></a> -->
<!-- 	    </li> -->
<!-- 	</ul> -->
	<!-- //.nav_etc -->
    <!-- .nav_etc -->
    <ul class="nav_etc">
        <li class="ico_lang">
            <div class="lang_selected"><a class="${lang}" title="${langTxt}"><span>${langTxt}</span></a></div>
            <ul class="lang_lst">
                <li><a class="ko <%if(lang.equals("ko")){%>selected<%}%>" href="javascript:chLocale('ko');" title="한국어"><span>한국어</span></a></li>
                <li><a class="en <%if(lang.equals("en")){%>selected<%}%>" href="javascript:chLocale('en');" title="English"><span>English</span></a></li>
            </ul>
        </li>
        <!-- [D] 프로필 수정 UI는 common.js에 있음 --> 
        <%if(enabledYn.equals("N")) {%>
        <li class="ico_profile delHover">
            <a title="내정보"><span><spring:message code="A0635" text="내정보"/></span></a>
            <div class="profile_cnt">
                <div class="user_info">
                    <span class="thumb">
                        <!-- [D] 이미지가 없을 시 이미지태그 삭제 
                        <img src="resources/images/sample/img_profile.png" alt="프로필사진">-->
                    </span>                                
                    <span class="userName">${user.userNm}</span>
                    <span class="userLavel">${user.userAuthTyNm}</span>
                    <span class="loginTime"><em>${user.recentConectDt}</em></span>
                </div>
                <c:if test="${!(user.companyId eq 'comp007' and user.sbscrbTy eq 'S')}">
                    <div class="btnBox">
                        <a href="#lyr_profile" class="btn_lyr_open"><spring:message code="A0634" text="비밀번호 변경"/></a>
                        <span><spring:message code="A0842" text="비밀번호를 변경해주세요." /></span>
                    </div>
                </c:if>
            </div>
        </li> 
        <% }else {%>
        <li class="ico_profile">
            <a title="내정보"><span><spring:message code="A0635" text="내정보"/></span></a>
            <div class="profile_cnt">
                <div class="user_info">
                    <span class="thumb">
                        <!-- [D] 이미지가 없을 시 이미지태그 삭제 
                        <img src="resources/images/sample/img_profile.png" alt="프로필사진">-->
                    </span>                                
                    <span class="userName">${user.userNm}</span>
                    <span class="userLavel">${user.userAuthTyNm}</span>
                    <span class="loginTime"><em>${user.recentConectDt}</em></span>
                </div>
                <c:if test="${!(user.companyId eq 'comp007' and user.sbscrbTy eq 'S')}">
                    <div class="btnBox">
                        <a href="#lyr_profile" class="btn_lyr_open"><spring:message code="A0634" text="비밀번호 변경"/></a>
                    </div>
                </c:if>
            </div>
        </li> 
        <%}%> 
        <li class="ico_help"><a title="도움말" href="#lyr_help" class="btn_lyr_open"><span>도움말</span></a></li>
    </ul>
    <!-- //.nav_etc -->
    <a class="btn_lyr_open btn_join" onclick="openPopup('mailForm')"><spring:message code="A0327" text="문의하기" /></a>
    <ul class="nav_etc">
        <li class="ico_logout"><a title="로그아웃"  onclick="logout()"><span>로그아웃</span></a></li>
    </ul>
</div>


<!-- //etc -->

