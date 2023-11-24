<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>

<div id="gnb" class="gnb">
<div class="btn_ham">
    <span>FAST ${lang=='ko'?"대화형":"Conversation"} AI <em>Ver 3.3.5</em></span>
    <button type="button" class="btn_potal_ham"><em class="ico_ham">주메뉴</em></button>  
</div>
<ul class="nav_gnb">
	<li>
		<a href="manual?page=ob01" target="_blank" class="btn_manual">매뉴얼</a>
	</li>
 	<c:forEach var="menu1" items="${user.menuLinkedMap}" varStatus="status">
 		<c:set var="menu1" value="${menu1.value}"/>
		<c:if test="${empty menu1.topMenuCode}">
			<li>
			 	<h2>${lang=="en"?menu1.menuNmEn:menu1.menuNmKo}</h2>
			 	<c:if test="${not empty menu1.menuLinkedMap}">
			 		<c:forEach var="menu2" items="${menu1.menuLinkedMap}" varStatus="status">
			 			<c:set var="menu2" value="${menu2.value}"/>
						<ul class="sub">
							<c:if test="${menu2.menuLinkedMap.size()>0}">
								<c:set var="arrow" value="arrow"/>
							</c:if>
							
							<c:if test="${topMenuCode eq menu2.menuCode}">
								<c:set var="selected" value="selected"/>
							</c:if>
							
							<li class="${menu2.menuOnImage} ${arrow} ${selected}">
								<a href="javascript:goMenu('${menu2.linkTy}','${menu2.cntntsTy}','${menu2.userMenuUrl}','${menu2.menuCode}');">
									<span>${lang=="en"?menu2.menuNmEn:menu2.menuNmKo}</span>
<%--									BETA VER 사용 예시--%>
<%--									<c:if test="${menu2.menuNmKo eq '챗봇빌더(회사)'}">--%>
<%--										<span class="icon_beta">BETA</span>--%>
<%--									</c:if>--%>
								</a>
								<c:if test="${not empty menu2.menuLinkedMap}">
									<ul class="third">
									<c:forEach var="menu3" items="${menu2.menuLinkedMap}" varStatus="status">
										<c:set var="menu3" value="${menu3.value}"/>
										<li <c:if test="${menuCode eq menu3.menuCode}">class="active"</c:if>>
											<a href="javascript:goMenu('${menu3.linkTy}','${menu3.cntntsTy}','${menu3.userMenuUrl}','${menu3.menuCode}');">
												<span>${lang=="en"?menu3.menuNmEn:menu3.menuNmKo}</span>
<%--												BETA VER 사용 예시--%>
<%--												<c:if test="${menu3.menuNmKo eq '챗봇빌더(유저)'}">--%>
<%--													<span class="icon_beta">BETA</span>--%>
<%--												</c:if>--%>
											</a>
										</li>
<%-- 								        	<c:if test="${menuId eq 'm12'}">class="active"</c:if> --%>
										</c:forEach>
									</ul>
								</c:if>
							</li>
							<c:set var="arrow" value=""/>
							<c:set var="selected" value=""/>
						</ul>
					</c:forEach>
				</c:if>
			</li>
		</c:if>
	</c:forEach>
</ul>
</div>
