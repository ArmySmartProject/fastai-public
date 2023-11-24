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

<body id="super_admin">

<!-- .page loading -->
<div id="pageldg">
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
		<input type="hidden" id= "headerName"  value="${_csrf.headerName}" />
		<input type="hidden" id= "token"  value="${_csrf.token}" />
		<input type="hidden" id= "checkName"  value="false" />
		<input type="hidden" id= "addType"  value="I" />
        <!-- #header -->
        <jsp:include page="../common/inc_header.jsp">
		    <jsp:param name="titleCode" value="A0800"/>
		    <jsp:param name="titleTxt" value="회사 및 서비스 정보"/>
		</jsp:include>
        <!-- //#header -->
        <!-- #container -->
        <div id="container">
            <!-- #contents -->
            <div class="content">
            <!-- .section -->
            <div class="stn" style="margin:20px 0 0 0;">
                <div class="stn_cont">
                    <div class="infoTxt">
                        <ul class="lst_dot">
                            <li><spring:message code="A0803" text="서비스 신청 시 등록된 고객님의 회사 정보와 서비스 메뉴를 확인하실 수 있으며, 주소 및 전화번호를 수정을 하실 수 있습니다."/></li>
                            <li><spring:message code="A0804" text="서비스 변경 및 추가 신청은 마인즈랩 고객센터 1661-3222로 연락 주시기 바랍니다." /></li>
                        </ul>
                    </div>
                    <div class="tbl_box">
                        <table class="tbl_line_view2" summary="회사명(국,영문),대표자명 사업자등록번호,법인등록번호,주소,대표 전화번호,팩스번호,담당자 연락처로 구성됨">
                        <colgroup>
                            <col width="10%"><col><col width="10%"><col>
                        </colgroup>
                        <tbody>
                        <tr>
                            <th><em>&ast;<spring:message code="A0313" text="회사명"/></em></th>
                            <td>
				                <input type="hidden" id="company_id" name="company_id" value="${systemCompany[0].COMPANY_ID}">
				                ${systemCompany[0].COMPANY_NAME}
							</td>
                            <th><spring:message code="A0313" text="회사명"/>&lpar;<spring:message code="A0560" text="영문"/>&rpar;</th>
                            <td>
                            	${systemCompany[0].COMPANY_NAME_EN}
                            </td>
                        </tr>
                        <tr>
                            <th><spring:message code="A0561" text="대표자명"/></th>
                            <td colspan="3">${systemCompany[0].RPRSNTV_NM}</td>
                        </tr>
                        <tr>
                            <th scope="row"><spring:message code="A0046" text="주소"/></th>
                            <td colspan="3">
                                <div class="ipt_address">
                                    <div class="iptBox">
                                        <input type="text" class="ipt_txt" id="bass_adres" value="${systemCompany[0].BASS_ADRES}" name="bass_adres" maxlength="100">
                                        <button type="button" id="srch_addr" name="srch_addr"><spring:message code="A0801" text="주소찾기" /></button>
                                    </div>
                                    <div class="iptBox">
                                        <input type="text" class="ipt_txt" placeholder="<spring:message code="A0556" text="상세주소를 입력해주세요"/>" id="detail_adres" value="${systemCompany[0].DETAIL_ADRES}" name="detail_adres" maxlength="100">
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <%-- <th scope="row"><spring:message code="A0564" text="대표 전화번호"/></th>
                            <td>
                                <div class="iptBox number">
                                    <input type="number" class="ipt_txt" id="bizrno1" value="${systemCompany[0].BIZRNO1}" name="bizrno1" maxlength="3" oninput="maxLengthCheck(this)">
                                    <span class="hyphen">-</span>
                                    <input type="number" class="ipt_txt" id="bizrno2" value="${systemCompany[0].BIZRNO2}" name="bizrno2" maxlength="2" oninput="maxLengthCheck(this)">
                                    <span class="hyphen">-</span>
                                    <input type="number" class="ipt_txt" id="bizrno3" value="${systemCompany[0].BIZRNO3}" name="bizrno3" maxlength="5" oninput="maxLengthCheck(this)">
                                </div>
                            </td> --%>
                            <th><spring:message code="A0565" text="팩스번호"/></th>
                            <td>
                                <div class="iptBox number">
                                    <input type="number" class="ipt_txt" id="fxnum1" value="${systemCompany[0].FXNUM1}" name="fxnum1" maxlength="4" oninput="maxLengthCheck(this)">
                                    <span class="hyphen">-</span>
                                    <input type="number" class="ipt_txt" id="fxnum2" value="${systemCompany[0].FXNUM2}" name="fxnum2" maxlength="4" oninput="maxLengthCheck(this)">
                                    <span class="hyphen">-</span>
                                    <input type="number" class="ipt_txt" id="fxnum3" value="${systemCompany[0].FXNUM3}" name="fxnum3" maxlength="4" oninput="maxLengthCheck(this)">
                                </div>
                            </td>
                            <th scope="row"><spring:message code="A0085" text="담당자"/><spring:message code="A0074" text="연락처"/></th>
                            <td>
                                <div class="iptBox number">
                                    <input type="number" class="ipt_txt" id="moblphon_no1" value="${systemCompany[0].MOBLPHON_NO1}" name="moblphon_no1" maxlength="4" oninput="maxLengthCheck(this)">
                                    <span class="hyphen">-</span>
                                    <input type="number" class="ipt_txt" id="moblphon_no2" value="${systemCompany[0].MOBLPHON_NO2}" name="moblphon_no2" maxlength="4" oninput="maxLengthCheck(this)">
                                    <span class="hyphen">-</span>
                                    <input type="number" class="ipt_txt" id="moblphon_no3" value="${systemCompany[0].MOBLPHON_NO3}" name="moblphon_no3" maxlength="4" oninput="maxLengthCheck(this)">
                                    <input type="number" class="ipt_txt" id="moblphon_no3" value="${systemCompany[0].MOBLPHON_NO3}" name="moblphon_no3" maxlength="4" oninput="maxLengthCheck(this)" style="opacity: 0; pointer-events: noen;">
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <th><spring:message code="A0723" text="운영시간"/> </th>
                            <td>
                                <div class="iptBox">
                                    <select name="op_start_tm" id="op_start_tm" class="select">
                                        <c:forEach var="i" begin="0"  end="23" varStatus="varStatus">
                                            <option value="${i>9?i:'0'}${i>9?'':i}">${i>9?i:'0'}${i>9?'':i}</option>
                                        </c:forEach>
                                    </select>
                                    <span style="display: inline-block; margin: 0 2px;">-</span>
                                    <select name="op_end_tm" id="op_end_tm" class="select">
                                        <c:forEach var="i" begin="0"  end="23" varStatus="varStatus">
                                            <option value="${i>9?i:'0'}${i>9?'':i}">${i>9?i:'0'}${i>9?'':i}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                        </table>
                    </div>
                </div>
                <div class="btnBox sz_small" style="margin:10px 0 0 0;">
                    <div class="fl">
                        <a class="btn_lyr_open btnS_basic btn_clr" onclick="showMenuService();"><spring:message code="A0802" text="신청 서비스 메뉴 보기" /></a>
                    </div>
                    <div class="fr">
                        <button type="button" class="btnS_basic" onclick="goSave();"><spring:message code="A0320" text="저장" /></button>
                    </div>
                </div>
                <!-- //.stn_cont -->
            </div>
            <!-- //.section -->
        </div>
           <%--
	        <div id="contents">
	            <!-- .content -->
	            <div class="content">
	                <!-- .section -->
	                <div class="stn">
	                    <div class="tblBox_r"></div>
	                    <div class="tbl_top_info">
	                        <div class="condition_box">
	                        </div>
                    	</div>
	                    	<div class="info_edit_tbl">
				        <form id="UserEdtForm">
				            <table>
				                <colgroup>
				                    <col width="115"><col><col width="115"><col>
				                </colgroup>

				                <tbody>
				                    <tr>
				                        <th><em>&ast;<spring:message code="A0313" text="회사명"/></th>
				                        <td>
				                            <div class="iptBox short">
				                            	<input type="hidden" id="company_id" name="company_id" value="${systemCompany[0].COMPANY_ID}">
				                                <input type="text" class="ipt_txt" id="company_name" value="${systemCompany[0].COMPANY_NAME}" name="company_name" maxlength="8" readonly="readonly">
				                            </div>
				                        </td>
				                        <th><spring:message code="A0313" text="회사명"/>&lpar;<spring:message code="A0560" text="영문"/>&rpar;</th>
				                        <td>
				                            <div class="iptBox">
				                                <input type="text" class="ipt_txt"  id="company_name_en" value="${systemCompany[0].COMPANY_NAME_EN}" name="company_name_en"  maxlength="8" readonly="readonly">
				                            </div>
				                        </td>
				                    </tr>
				                    <tr>
				                        <th><spring:message code="A0561" text="대표자명"/></th>
				                        <td colspan="3">
				                            <div class="iptBox">
				                                <input type="text" class="ipt_txt" id="rprsntv_nm" value="${systemCompany[0].RPRSNTV_NM}" name="rprsntv_nm" readonly="readonly">
				                            </div>
				                        </td>
				                    </tr>
				                    <tr>
				                        <th><spring:message code="A0562" text="사업자등록번호"/></th>
				                        <td>
				                            <div class="iptBox">
				                                <input type="text" class="ipt_txt"  id="jurirno1" value="${systemCompany[0].JURIRNO1}" name="jurirno1" maxlength="6" oninput="maxLengthCheck(this)" readonly="readonly">
				                            </div>
				                        </td>
				                        <th><spring:message code="A0563" text="법인등록번호"/></th>
				                        <td>
				                            <div class="iptBox">
				                                <input type="text" class="ipt_txt"  id="jurirno2" value="${systemCompany[0].JURINO2}" name="jurirno2" maxlength="7" oninput="maxLengthCheck(this)" readonly="readonly">
				                            </div>
				                        </td>
				                    </tr>
				                    <tr>
				                        <th><spring:message code="A0046" text="주소"/></th>
				                        <td colspan="3">
				                            <div class="iptBox long">
				                                <input type="text" class="ipt_txt" id="bass_adres" value="${systemCompany[0].BASS_ADRES}" name="bass_adres" maxlength="100">
												<button type="button" class="btn_srch adrs_srch" id="srch_addr" name="srch_addr"><spring:message code="A0180" text="검색"/></button>
				                            </div>
				                        </td>
				                    </tr>
				                    <tr>
				                        <th></th>
				                        <td colspan="3">
				                            <div class="iptBox long">
				                                <input type="text" class="ipt_txt" placeholder="<spring:message code="A0556" text="상세주소를 입력해주세요"/>" id="detail_adres" value="${systemCompany[0].DETAIL_ADRES}" name="detail_adres" maxlength="100">
				                            </div>
				                        </td>
				                    </tr>
				                    <tr>
				                        <th><spring:message code="A0564" text="대표 전화번호"/></th>
				                        <td>
				                            <div class="iptBox three_box">
				                                <input type="number" class="ipt_txt"   id="bizrno1" value="${systemCompany[0].BIZRNO1}" name="bizrno1" maxlength="3" oninput="maxLengthCheck(this)">
												-
											</div>
											<div class="iptBox three_box">
												<input type="number" class="ipt_txt"   id="bizrno2" value="${systemCompany[0].BIZRNO2}" name="bizrno2" maxlength="2" oninput="maxLengthCheck(this)">
												-
											</div>
											<div class="iptBox three_box">
												<input type="number" class="ipt_txt"   id="bizrno3" value="${systemCompany[0].BIZRNO3}" name="bizrno3" maxlength="5" oninput="maxLengthCheck(this)">
				                            </div>
				                        </td>
				                        <th><spring:message code="A0565" text="팩스번호"/></th>
				                        <td>
				                            <div class="iptBox three_box">
				                                <input type="number" class="ipt_txt"   id="fxnum1" value="${systemCompany[0].FXNUM1}" name="fxnum1" maxlength="4" oninput="maxLengthCheck(this)">
												-
											</div>
											<div class="iptBox three_box">
												<input type="number" class="ipt_txt"   id="fxnum2" value="${systemCompany[0].FXNUM2}" name="fxnum2" maxlength="4" oninput="maxLengthCheck(this)">
												-
											</div>
											<div class="iptBox three_box">
												<input type="number" class="ipt_txt"   id="fxnum3" value="${systemCompany[0].FXNUM3}" name="fxnum3" maxlength="4" oninput="maxLengthCheck(this)">
				                            </div>
				                        </td>
				                    </tr>
				                    <tr>
				                        <th><spring:message code="A0085" text="담당자"/><spring:message code="A0074" text="연락처"/></th>
				                        <td colspan="3">
				                            <div class="iptBox three_box">
				                                <input type="number" class="ipt_txt"   id="moblphon_no1" value="${systemCompany[0].MOBLPHON_NO1}" name="moblphon_no1" maxlength="4" oninput="maxLengthCheck(this)">
												-
											</div>
											<div class="iptBox three_box">
												<input type="number" class="ipt_txt"   id="moblphon_no2" value="${systemCompany[0].MOBLPHON_NO2}" name="moblphon_no2" maxlength="4" oninput="maxLengthCheck(this)">
												-
											</div>
											<div class="iptBox three_box">
												<input type="number" class="ipt_txt"   id="moblphon_no3" value="${systemCompany[0].MOBLPHON_NO3}" name="moblphon_no3" maxlength="4" oninput="maxLengthCheck(this)">
				                            </div>
				                        </td>
				                    </tr>
				                </tbody>
				            </table>
				            </form>
				        </div>
				        <button type="button" onclick="showMenuService();">신청 서비스 메뉴 보기</button>
				        <button type="button" onclick="goSave();">저장</button>
	                </div>
	            </div><!-- //.content -->
	         </div> <!-- //#contents --> --%>
        </div><!-- //#container -->
        <hr>
        <!-- #footer -->
        <div id="footer">
            <div class="cyrt"><span>&copy; MINDsLab. All rights reserved.</span></div>
        </div>
        <!-- //#footer -->
</div>
<!-- //#wrap -->
<div id="lyr_serviceMenu" class="lyrBox">
    <div class="lyr_top">
        <h3><spring:message code="A0805" text="사용중인 서비스 메뉴" /></h3>
        <button class="btn_lyr_close"><spring:message code="A0631" text="닫기" /></button>
     </div>
     <div class="lyr_mid" style="max-height: 527px;">
        <div class="menu_slt_box2">
            <ul class="lst_bd menu_lst">
                <li onclick="firstMenu();"><a href="#none"><span class="fas fa-caret-down"> <spring:message code="A0566" text="메뉴 목록"/></span></a>
                    <ul class="sub">
                    	<c:forEach var="menu1" items="${user.menuLinkedMap}" varStatus="status">
						<c:set var="menu1" value="${menu1.value}"/>
						<c:if test="${empty menu1.topMenuCode}">
                         <li onclick="subMenu(event);"><a href="#none"><span class="fas fa-caret-down">${lang=="en"?menu1.menuNmEn:menu1.menuNmKo}</a>
                              <c:if test="${not empty menu1.menuLinkedMap}">
							  <c:forEach var="menu2" items="${menu1.menuLinkedMap}" varStatus="status">
						   	  <c:set var="menu2" value="${menu2.value}"/>
                              <ul class="third" style="display: none;">
                              	  <c:if test="${menu2.menuLinkedMap.size()>0}">
								  	<c:set var="arrow" value="arrow"/>
								  </c:if>
								  <c:if test="${topMenuCode eq menu2.menuCode}">
								  <c:set var="selected" value="selected"/>
								  </c:if>
                                  <li onclick="thirdMenu(event);"><a href="#none"><span class="fas fa-caret-down">${lang=="en"?menu2.menuNmEn:menu2.menuNmKo}</a>
                                      <c:if test="${not empty menu2.menuLinkedMap}">
                                      <ul class="fourth" style="display: none;">
                                      	  <c:forEach var="menu3" items="${menu2.menuLinkedMap}" varStatus="status">
										  <c:set var="menu3" value="${menu3.value}"/>
                                          <li onclick="fourthMenu(event);"><a href="#none">${lang=="en"?menu3.menuNmEn:menu3.menuNmKo}</a></li>
                                          </c:forEach>
                                      </ul>
                                      </c:if>
                                  </li>
                              </ul>
                             </c:forEach>
							 </c:if>
                         </li>
                     </c:if>
					</c:forEach>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button class="btn_lyr_close"><spring:message code="A0631" text="닫기" /></button>
        </div>
    </div>
</div>

<%@ include file="../common/inc_footer.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/setColWidth.js"></script>
<script type="text/javascript">
$(window).load(function() {
    //page loading delete
	$('#pageldg').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });
});
$(document).ready(function (){

	if($.cookie("lang") == "en"){
		$("#super_admin .tbl_top_info .condition_box .use_slt_group .radioBox input[type='radio'] + label").css("margin-right", "20px");
	}

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

	    //첫 메뉴 화면 보이게
		$('.menu_slt_box2 .menu_lst > li').find('.sub').css("display","block");

       	$('.menu_slt_box2 .menu_lst > li').on('click',function(){
        	$(this).addClass('active').find('.sub').stop().slideDown(300);
        });
        $('.menu_slt_box2 .menu_lst .sub > li').on('click',function(){
        	if($(this).find('.third').css('display') == "block"){
            	$(this).find('.third').css("display" , "none");
            	$(this).find('.fourth').css("display" , "none");
	        	$('.menu_slt_box2 .menu_lst .sub > li').removeClass('active');
	        	$('.menu_slt_box2 .menu_lst .third > li').removeClass('active');
	        	$('.menu_slt_box2 .menu_lst .fourth > li').removeClass('active');
            }else {
	        	$('.menu_slt_box2 .menu_lst .sub > li').removeClass('active');
	        	$('.menu_slt_box2 .menu_lst .third > li').removeClass('active');
	        	$('.menu_slt_box2 .menu_lst .fourth > li').removeClass('active');
	        	$(this).addClass('active').find('.third').stop().slideDown(300);
            }
         	/* $('.menu_slt_box2 .menu_lst .sub > li').removeClass('active');
         	$('.menu_slt_box2 .menu_lst .third > li').removeClass('active');
         	$('.menu_slt_box2 .menu_lst .fourth > li').removeClass('active');
      		$(this).addClass('active').find('.third').stop().slideDown(300); */
        });
        $('.menu_slt_box2 .menu_lst .third > li').on('click',function(){
        	if($(this).find('.fourth').css('display') == "block"){
            	$(this).find('.fourth').css("display" , "none");
	        	$('.menu_slt_box2 .menu_lst .third > li').removeClass('active');
	        	$('.menu_slt_box2 .menu_lst .fourth > li').removeClass('active');
        	}else{
	        	$('.menu_slt_box2 .menu_lst .sub > li').removeClass('active');
	        	$('.menu_slt_box2 .menu_lst .third > li').removeClass('active');
	        	$('.menu_slt_box2 .menu_lst .fourth > li').removeClass('active');
	        	$(this).parent().parent().addClass('active');
	        	$(this).addClass('active').find('.fourth').stop().slideDown(300);
        	}
        	/* $('.menu_slt_box2 .menu_lst .sub > li').removeClass('active');
        	$('.menu_slt_box2 .menu_lst .third > li').removeClass('active');
        	$('.menu_slt_box2 .menu_lst .fourth > li').removeClass('active');
        	$(this).parent().parent().addClass('active');
        	$(this).addClass('active').find('.fourth').stop().slideDown(300); */
        });
        $('.menu_slt_box2 .menu_lst .fourth > li').on('click',function(){
        	$('.menu_slt_box2 .menu_lst .fourth > li').removeClass('active');
        	$('.menu_slt_box2 .menu_lst .third > li').removeClass('active');
        	$('.menu_slt_box2 .menu_lst .sub > li').removeClass('active');
        	$(this).parent().parent().addClass('active');
        	$(this).parent().parent().parent().parent().addClass('active');
        	$(this).addClass('active');
        });

        $("#srch_addr").on("click", function(){
        	srchAddress();
		});

	});
    $("#op_start_tm > option[value='${systemCompany[0].OP_START_TM}']").attr("selected","selected");
    $("#op_end_tm > option[value='${systemCompany[0].OP_END_TM}']").attr("selected","selected");
});
// 이벤트 상위 전파 중단
function subMenu(event) {
					event.stopPropagation();
}
//이벤트 상위 전파 중단
function thirdMenu(event) {
					event.stopPropagation();
}
//이벤트 상위 전파 중단
function fourthMenu(event) {
					event.stopPropagation();
}



/** 회사 수정  */
function goSave() {
		var obj = new Object();
		obj.companyId = $("#company_id").val();
		obj.bizrno1 = $("#bizrno1").val();
		obj.bizrno2 = $("#bizrno2").val();
		obj.bizrno3 = $("#bizrno3").val();
		obj.moblphonNo1 = $("#moblphon_no1").val();
		obj.moblphonNo2 = $("#moblphon_no2").val();
		obj.moblphonNo3 = $("#moblphon_no3").val();
		obj.fxnum1 = $("#fxnum1").val();
		obj.fxnum2 = $("#fxnum2").val();
		obj.fxnum3 = $("#fxnum3").val();
		obj.bassAdres = $("#bass_adres").val();
		obj.detailAdres = $("#detail_adres").val();
        obj.opstarttm = $("#op_start_tm").val();
        obj.opendtm = $("#op_end_tm").val();

		$.ajax({url : "${pageContext.request.contextPath}/updateSystemCompanyInfo",
				data : JSON.stringify(obj),
				method : 'POST',
				contentType : "application/json; charset=utf-8",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				}).success(function(result) {
					alert('<spring:message code="A0589" text="등록이 완료되었습니다."/>');
				}).fail(function(result) {
					alert('<spring:message code="A0590" text="등록이 완료되지 않았습니다."/>');
					console.log("회사 등록 error");
				});
	}



function srchAddress(){
	 new daum.Postcode({
	        oncomplete: function(data) {
	            $("#bass_adres").val(data.address);
	        }
	    }).open();
}

/** INPUT TYPE NUMBER 글자수 제한 */
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }
}

function showMenuService() {
	openPopup("lyr_serviceMenu");
}

function firstMenu(){
	$('.menu_slt_box2 .menu_lst .sub > li').removeClass('active');
	$('.menu_slt_box2 .menu_lst .third > li').removeClass('active');
	$('.menu_slt_box2 .menu_lst .fourth > li').removeClass('active');
}
</script>
</body>
</html>
