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
		    <jsp:param name="titleCode" value="A0537"/>
		    <jsp:param name="titleTxt" value="COMPANY 및 권한관리"/>
		</jsp:include>
        <!-- //#header -->
        <!-- #container -->
        <div id="container">
            <!-- #contents -->
	        <div id="contents">
	            <!-- .content -->
	            <div class="content">
	                <!-- .section -->
	                <div class="stn">
	                    <div class="tblBox_r"></div>
	                    <div class="tbl_top_info">
	                        <div class="condition_box">

		                            <div class="use_slt_group">
		                                <span class="group_title"><spring:message code="A0534" text="시스템 사용여부"/></span>
		                                <div class="radioBox">
		                                    <input type="radio" name="system_use_slt" id="used" checked="checked" value="useY">
		                                    <label for="used"><spring:message code="A0535" text="사용"/></label>
		                                    <input type="radio" name="system_use_slt" id="not_used" value="useN">
		                                    <label for="not_used"><spring:message code="A0536" text="미 사용"/></label>
		                                </div>
		                            </div>

		                            <div class="srch_group">
		                                <span class="group_title"><spring:message code="A0539" text="조건선택"/></span>
		                                <div class="srchBox">
		                                    <select class="select" id="ipt_select1_1">
		                                        <option value="companyKoNm"><spring:message code="A0313" text="회사명"/></option>
		                                        <option value="companyEnNm"><spring:message code="A0313" text="회사명"/>(<spring:message code="A0560" text="영문" />)</option>
		                                        <option value="companyId"><spring:message code="A0533" text="회사ID"/></option>
		                                    </select>
		                                    <input type="text" class="ipt_srch" placeholder="<spring:message code='A0558' text='검색어 입력'/>" id="ipt_txt" autocomplete="off">
		                                    <input style="opacity:0;pointer-events:none;"type="text" class="ipt_srch" placeholder="<spring:message code='A0558' text='검색어 입력'/>" id="ipt_txt Auto" autocomplete="off">
		                                    <button type="submit" class="btn_srch" id="search"><spring:message code="A0180" text="검색"/></button>
		                                </div>
		                            </div>
	                        </div>

	                        <div class="btnBox sz_small">
	                            <a href="#lyr_company_add" class="btnS_basic" id="addComp"><spring:message code="A0538" text="등록"/></a>
	                        </div>
                    	</div>
            			<!-- //검색조건 -->

			            <!-- .jqGridBox -->
			            <!-- <div class="jqGridBox">
			                <table id="jqGrid"></table>
			                <div id="jqGridPager"></div>
			            </div> -->
			            <!-- //.jqGridBox -->

			            <div class="tbl_box">
	                        <table summary="No, 회사ID, 회사명(국문), 회사명(영문), 연락처, 시스템 사용여부, 등록일, 권한 관리로 구성됨">
	                            <colgroup>
	                                <col><col><col><col>
	                                <col><col><col><col><col>
	                                <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
	                            </colgroup>

	                            <thead>
	                                <tr>
	                                    <th><spring:message code="A0135" text="No."/></th>
	                                    <th><spring:message code="A0533" text="회사 ID"/></th>
	                                    <th><spring:message code="A0313" text="회사명"/></th>
	                                    <th><spring:message code="A0313" text="회사명"/>(<spring:message code="A0560" text="영문"/>)</th>
	                                    <th><spring:message code="A0074" text="연락처 "/></th>
	                                    <th><spring:message code="A0534" text="시스템 사용여부 "/></th>
	                                    <th><spring:message code="A0542" text="등록일 "/></th>
	                                    <th><spring:message code="A0543" text="권한 관리 "/></th>
	                                    <th><spring:message code="A1052" text="캠페인 관리 "/></th>
	                                </tr>
	                            </thead>

	                            <tbody>
										<tr>
		                                    <td scope="row" colspan="9" class="data_none"><spring:message code="A0257" text="등록된 데이터가 없습니다."/></td>
		                                </tr>
	                            </tbody>
	                        </table>
	                    </div>

						<div class="tbl_btm_info">
                        <div class="tbl_path"><spring:message code="172" text="전체"/><strong>1</strong> / 0</div>
                        <div class="paging">
                            <a class="btn_paging_first" href="#none" ><spring:message code="A0579" text="처음 페이지로 이동 "/></a>
                            <a class="btn_paging_prev" href="#none" ><spring:message code="A0580" text="이전 페이지로 이동 "/></a>
                            <span class="list">
                                <strong>1</strong>
                            </span>
                            <a class="btn_paging_next" href="#none"><spring:message code="A0581" text="다음 페이지로 이동 "/></a>
                            <a class="btn_paging_last" href="#none"><spring:message code="A0582" text="마지막 페이지로 이동 "/></a>
                        </div>
                    </div>

	                </div>
	            </div><!-- //.content -->
	         </div> <!-- //#contents -->
        </div><!-- //#container -->

        <hr>

        <!-- #footer -->
        <div id="footer">
            <div class="cyrt"><span>&copy; MINDsLab. All rights reserved.</span></div>
        </div>
        <!-- //#footer -->
</div>
<!-- //#wrap -->



<div id="lyr_company_add" class="lyrBox lyr_super">
    <div class="lyr_top">
        <h3>Company <spring:message code="A0830" text="정보" /></h3>
        <button class="btn_lyr_close"><span class="fas fa-times"></span></button>
     </div>
    <div class="lyr_mid">
        <p><em>&ast;</em><spring:message code="A0583" text="는 필수 입력 사항 입니다."/></p>
        <input type="hidden" id="chkCompName" name="chkCompName">
        <div class="info_edit_tbl">
        <form id="UserEdtForm">
            <table>
                <colgroup>
                    <col width="115"><col><col width="115"><col>
                </colgroup>

                <tbody>
                    <tr>
                        <th><em>&ast;<spring:message code="A0313" text="회사명"/></em></th>
                        <td>
                            <div class="iptBox short">
                            	<input type="hidden" id="company_id" name="company_id">
                                <input type="text" class="ipt_txt" id="company_name" name="company_name"  maxlength="20">
								<button type="button" class="btn_srch name_chk"><spring:message code="A0546" text="중복확인"/></button>
                            </div>
                        </td>
                        <th><spring:message code="A0313" text="회사명"/>&lpar;<spring:message code="A0560" text="영문"/>&rpar;</th>
                        <td>
                            <div class="iptBox">
                                <input type="text" class="ipt_txt"  id="company_name_en" name="company_name_en"  maxlength="20">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th><spring:message code="A0561" text="대표자명"/></th>
                        <td colspan="3">
                            <div class="iptBox">
                                <input type="text" class="ipt_txt"   id="rprsntv_nm" name="rprsntv_nm" >
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th><spring:message code="A0562" text="사업자등록번호"/></th>
                        <td>
                            <div class="iptBox">
                                <input type="text" class="ipt_txt"  id="bizrno" name="bizrno" maxlength="10" onkeyup="bizrnoHypen();">
                            </div>
                        </td>
                        <th><spring:message code="A0563" text="법인등록번호"/></th>
                        <td>
                            <div class="iptBox">
                                <input type="text" class="ipt_txt"  id="jurirno" name="jurirno" maxlength="13" onkeyup="jurirnoHypen();">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th><spring:message code="A0816" text="주소"/></th>
                        <td colspan="3">
                            <div class="iptBox long">
                                <input type="text" class="ipt_txt" id="bass_adres" name="bass_adres" maxlength="100">
								<button type="button" class="btn_srch adrs_srch" id="srch_addr" name="srch_addr"><spring:message code="A0180" text="검색"/></button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th></th>
                        <td colspan="3">
                            <div class="iptBox long">
                                <input type="text" class="ipt_txt" placeholder="<spring:message code="A0556" text="상세주소를 입력해주세요"/>" id="detail_adres" name="detail_adres" maxlength="100">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <%-- <th><spring:message code="A0564" text="대표 전화번호"/></th>
                        <td>
                            <div class="iptBox three_box">
                                <input type="number" class="ipt_txt"   id="bizrno1" name="bizrno1" maxlength="3" oninput="maxLengthCheck(this)">
								-
							</div>
							<div class="iptBox three_box">
								<input type="number" class="ipt_txt"   id="bizrno2" name="bizrno2" maxlength="2" oninput="maxLengthCheck(this)">
								-
							</div>
							<div class="iptBox three_box">
								<input type="number" class="ipt_txt"   id="bizrno3" name="bizrno3" maxlength="5" oninput="maxLengthCheck(this)">
                            </div>
                        </td> --%>
                        <th><spring:message code="A0565" text="팩스번호"/></th>
                        <td>
                            <div class="iptBox three_box">
                                <input type="number" class="ipt_txt"   id="fxnum1" name="fxnum1" maxlength="4" oninput="maxLengthCheck(this)">
								-
							</div>
							<div class="iptBox three_box">
								<input type="number" class="ipt_txt"   id="fxnum2" name="fxnum2" maxlength="4" oninput="maxLengthCheck(this)">
								-
							</div>
							<div class="iptBox three_box">
								<input type="number" class="ipt_txt"   id="fxnum3" name="fxnum3" maxlength="4" oninput="maxLengthCheck(this)">
                            </div>
                        </td>
                        <th><spring:message code="A0085" text="담당자"/><spring:message code="A0074" text="연락처"/></th>
                        <td>
                            <div class="iptBox three_box">
                                <input type="number" class="ipt_txt"   id="moblphon_no1" name="moblphon_no1" maxlength="3" oninput="maxLengthCheck(this)">
								-
							</div>
							<div class="iptBox three_box">
								<input type="number" class="ipt_txt"   id="moblphon_no2" name="moblphon_no2" maxlength="4" oninput="maxLengthCheck(this)">
								-
							</div>
							<div class="iptBox three_box">
								<input type="number" class="ipt_txt"   id="moblphon_no3" name="moblphon_no3" maxlength="4" oninput="maxLengthCheck(this)">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th><spring:message code="A0534" text="시스템 사용여부"/></th>
                        <td colspan="3">
                            <div class="radioBox">
                                <input type="radio" name="system_use_slt2" id="used2" checked="checked" value="N">
                                <label for="used2"><spring:message code="A0535" text="사용"/></label>
                                <input type="radio" name="system_use_slt2" id="not_used2" value="Y">
                                <label for="not_used2"><spring:message code="A0536" text="미사용"/></label>
                            </div>
                        </td>
                    </tr>

                    <tr>
                      <th><spring:message code="A0723" text="운영시간"/></th>
                      <td>
                        <div class="iptBox">
                          <select name="op_start_tm" id="op_start_tm" class="select">
                              <c:forEach var="i" begin="0"  end="23" varStatus="varStatus">
                                  <option value="${i>9?i:'0'}${i>9?'':i}" >${i>9?i:'0'}${i>9?'':i}</option>
                              </c:forEach>
                          </select>
                          <span>-</span>
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
            </form>
        </div>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button class="btn_lyr_close" id="cancel"><spring:message code="A0532" text="취소"/></button>
            <button id="insertComp"><spring:message code="A0320" text="저장"/></button>
            <button id="deleteComp"><spring:message code="A0541" text="삭제"/></button>
        </div>
    </div>
</div>
<!-- //회사 등록 -->

<!-- 안내 팝업 -->
<div id="lyr_infomation" class="lyrBox lyr_super lyr_alert">
    <div class="lyr_cont">
        <p><spring:message code="A0584" text="사용 가능한 회사명 입니다."/></p>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button class="btn_close"><spring:message code="A0037" text="확인"/></button>
        </div>
    </div>
</div>
<!-- //안내 팝업 -->

<!-- 시스템 메뉴선택 팝업 -->
<div id="lyr_system_slt" class="lyrBox lyr_super">
	<input type="hidden" id="menuCompanyId" value="">
    <div class="lyr_top">
        <button class="btn_lyr_close"><span class="fas fa-times"></span></button>
     </div>
    <div class="lyr_mid">
        <p><spring:message code="A0585" text="사용할 시스템(메뉴)를 선택하세요."/></p>

        <div class="menu_slt_chk">
            <div class="lst_hd">
                <div class="checkBox">
                    <input type="checkbox" name="sstm_menu_chk" id="total_chk" class="checking all_sstm_menu">
                    <label for="total_chk"></label>
                </div>
                <div class="menu_name"><spring:message code="A0569" text="메뉴 명"/></div>
            </div>

            <ul class="lst_bd menu_lst">
            	<c:forEach var="menu1" items="${menuMap}" varStatus="status">
 					<c:set var="menu1" value="${menu1.value}"/>
					<c:if test="${empty menu1.topMenuCode}">
		                <li>
		                <div class="checkBox">
		                    <input type="checkbox" name="sstm_menu_chk" id="sstm_${menu1.menuCode}" class="checking ipt_check" value="${menu1.menuCode}">
		                    <label for="sstm_${menu1.menuCode}"></label>
		                </div>
		                <div class="menu_name"><a href="#none">${lang=="en"?menu1.menuNmEn:menu1.menuNmKo}<span class="menu1 fas fa-caret-up"></span></a></div>
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
				                        <div class="checkBox">
				                            <input type="checkbox" name="sstm_menu_chk" id="sstm_${menu2.menuCode}" class="checking ipt_check" value="${menu2.menuCode}">
				                            <label for="sstm_${menu2.menuCode}"></label>
				                        </div>
				                        <div class="menu_name"><a href="#none">${lang=="en"?menu2.menuNmEn:menu2.menuNmKo}<span class="menu2 fas fa-caret-up"></span></a></div>
				                            <c:if test="${not empty menu2.menuLinkedMap}">
					                            <ul class="third">
					                            	<c:forEach var="menu3" items="${menu2.menuLinkedMap}" varStatus="status">
														<c:set var="menu3" value="${menu3.value}"/>
							                                <li>
							                                    <div class="checkBox">
							                                        <input type="checkbox" name="sstm_menu_chk" id="sstm_${menu3.menuCode}" class="checking ipt_check" value="${menu3.menuCode}">
							                                        <label for="sstm_${menu3.menuCode}"></label>
							                                    </div>
							                                    <div class="menu_name"><a href="#none">${lang=="en"?menu3.menuNmEn:menu3.menuNmKo}</a></div>
							                                </li>
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
        </div>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button class="btn_lyr_close" id="cancel"><spring:message code="A0532" text="취소"/></button>
            <button class="btn_lyr_close" id="save" onclick="goSave();"><spring:message code="A0320" text="저장"/></button>
        </div>
    </div>
</div>
<!-- //시스템 메뉴선택 팝업 -->
<!-- 캠페인 팝업 -->
<div id="lyr_system_campaign_slt" class="lyrBox lyr_super">
    <input type="hidden" id="campaignCompanyId" value="">
    <div class="lyr_top">
        <button class="btn_lyr_close"><span class="fas fa-times"></span></button>
     </div>
    <div class="lyr_mid">
        <p>사용할 캠페인을 선택하세요.</p>
        <div class="menu_slt_chk">
            <div class="lst_hd">
                <div class="checkBox">
                    <input type="checkbox" name="sstm_campagin_chk" id="total_campaign_chk" class="checking all_sstm_campaign">
                    <label for="total_campaign_chk"></label>
                </div>
                <div class="campaign_name">캠페인 명</div>
            </div>
            <ul class="lst_bd campaign_lst">
                <c:forEach var="campaignListMap" items="${campaignListMap}" varStatus="status">
                    <li>
                        <div class="checkBox">
                            <input type="checkbox" name="sstm_campaign_chk" id="sstm_camp_${campaignListMap.campaignId}" class="checking ipt_check" value="${campaignListMap.campaignId}">
                            <label for="sstm_camp_${campaignListMap.campaignId}"></label>
                        </div>
                        <div class="campaign_name">${campaignListMap.campaignNm}</div>
                    </li>
                </c:forEach>

            </ul>
        </div>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button class="btn_lyr_close"><spring:message code="A0532" text="취소"/></button>
            <button class="btn_lyr_close"onclick="goCompanyCampaignsSave();"><spring:message code="A0320" text="저장"/></button>
        </div>
    </div>
</div>
<!-- //캠페인 선택 팝업 -->

<%@ include file="../common/inc_footer.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/setColWidth.js"></script>
<script type="text/javascript">
$(window).load(function() {
    //page loading delete
	$('#pageldg').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });

    $("#op_start_tm > option[value='${systemCompany[0].OP_START_TM}']").attr("selected","selected");
    $("#op_end_tm > option[value='${systemCompany[0].OP_END_TM}']").attr("selected","selected");
});
$(document).ready(function (){

	//상세조회 팝업 삭제 버튼
	document.getElementById("deleteComp").style.backgroundColor = "#fd5353";
	$("#deleteComp").hide();

	if($.cookie("lang") == "en"){
		$("#super_admin .tbl_top_info .condition_box .use_slt_group .radioBox input[type='radio'] + label").css("margin-right", "20px");
	}

	//첫 화면 이동 시 조회
	gridSearch(1);
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

        // 중복 확인 버튼
        $('#lyr_company_add .name_chk').on('click',function(){
        	getCompNm();
        });

        $('#addComp').on('click',function(){
        	$("#checkName").val(false);
        	$("#UserEdtForm")[0].reset();
        	openPopup("lyr_company_add");
        	$("#deleteComp").hide();
        	$("#addType").val("I");

        	var compId = 'comp';
        	var obj = new Object();
    		obj.companyId = "00";

    		$.ajax(
    				{
    					url : "${pageContext.request.contextPath}/getCompanyIdInfo",
    					data : JSON.stringify(obj),
    					method : 'POST',
    					contentType : "application/json; charset=utf-8",
    					beforeSend : function(xhr) {
    						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    					},
    				}).success(function(result) {
    					var compId = 'comp' + result;
	    				$("#company_id").val(compId);
    		}).fail(function(result) {
    			console.log("회사ID 생성 error");
    		});

        });

        $('.lyr_alert .btn_close').on('click',function(){
            $('.lyr_alert').hide();
        });

      //시스템 메뉴 선택
        $('.menu_slt_chk .menu_lst > li > .menu_name').on('click',function(){
 	   	   if($(this).parent().find('.sub').css("display") == 'block'){
 	   	   	   $(this).parent().find('.sub').css("display", "none");
 	   	   	   $(this).parent().find('.sub').find('.third').css("display", "none");
 		   	   $(this).parent().find('.menu1').attr('class','menu1 fas fa-caret-up');
 		   	   $(this).parent().find('.sub').find('.menu2').attr('class','menu2 fas fa-caret-up');
 	   	   }else{
 		   	   $(this).parent().find('.menu1').attr('class','menu1 fas fa-caret-down');
 		   	   $(this).parent().find('.sub').show();
 	   	   }
        });
        $('.menu_slt_chk .menu_lst .sub > li > .menu_name').on('click',function(){
     	   if($(this).parent().find('.third').css("display") == 'block'){
     		   $(this).parent().find('.third').css("display", "none");
 	       	   $(this).parent().find('.menu2').attr('class','menu2 fas fa-caret-up');
     	   }else {
 	       	   $(this).parent().find('.menu2').attr('class','menu2 fas fa-caret-down');
 	       	   $(this).parent().find('.third').show();
     	   }
        });
        // 시스템 메뉴 선택 - input[type="check"] 전체선택 / 해제
        $('.ipt_check').click(function(){
            $('.all_sstm_menu').prop('checked',true);
        });
        $('.all_sstm_menu').click(function(){
            if($('.all_sstm_menu').prop('checked')){
                $('.ipt_check').prop('checked',true);
            } else {
                $('.ipt_check').prop('checked',false);
            }
        });

        //권한관리 1뎁스  - 선택 뎁스 하위 메뉴 전체 체크
        $('.menu_slt_chk .menu_lst > li').find('input[name=sstm_menu_chk]').on('click',function(){
        	var chk = $(this).prop('checked');
        	if(chk){
        		$(this).parent().parent().find('input[name=sstm_menu_chk]').prop('checked',true);
            } else {
            	$(this).parent().parent().find('input[name=sstm_menu_chk]').prop('checked',false);
            }
        });

        //권한관리 2뎁스  - 선택 뎁스 상위 메뉴와 하위메뉴전체 체크
        $('.menu_slt_chk .menu_lst .sub > li').find('input[name=sstm_menu_chk]').on('click',function(){
        	var chk = $(this).prop('checked');
        	if(chk){
        		$(this).parent().parent().parent().siblings('.checkBox').find('input[name=sstm_menu_chk]').prop('checked',true);
            	$(this).parent().parent().find('.third input[name=sstm_menu_chk]').prop('checked',true);
            }
        });

        //권한관리 3뎁스 - 선택 뎁스 직속 상위 메뉴들 체크
        $('.menu_slt_chk .menu_lst .third > li').find('input[name=sstm_menu_chk]').on('click',function(){
        	var chk = $(this).prop('checked');
        	if(chk){
        		$(this).parent().parent().parent().siblings('.checkBox').find('input[name=sstm_menu_chk]').prop('checked',true)
            	$(this).parent().parent().parent().parent().parent().siblings('.checkBox').find('input[name=sstm_menu_chk]').prop('checked',true);
            }
        });

        $("#search").on("click", function(){
        	gridSearch(1);
		});

        $("#insertComp").on("click", function(){
        	insertCompany();
		});

        $("#deleteComp").on("click", function(){
        	var yn = confirm('<spring:message code="A0586" text="삭제하시겠습니까?"/>');
            if(yn){
            	deleteCompany();
            }
		});

        $("#srch_addr").on("click", function(){
        	srchAddress();
		});
        // 캠페인 관리 CheckBox 전체 선택 및 해제
        $("#total_campaign_chk").on("click", function(){
            if($("#total_campaign_chk").is(":checked") == true){
                $('input[name="sstm_campaign_chk"]').prop("checked", true);
            }else {
                $('input[name="sstm_campaign_chk"]').prop("checked", false);
            }
        });
	});
});
//사업자번호 하이픈
function bizrnoHypen(){
   var bizrno = $("#bizrno").val();
   bizrno = bizrno.replace(/([0-9]{3})([0-9]{2})([0-9]{5})/,"$1-$2-$3");
   $("#bizrno").val(bizrno);
}
//법인번호 하이픈
function jurirnoHypen(){
   var jurirno = $("#jurirno").val();
   jurirno = jurirno.replace(/([0-9]{6})([0-9]{7})/,"$1-$2");
   $("#jurirno").val(jurirno);
}

/** 신규등록  저장  */
function insertCompany() {
	// 사업자번호 하이픈 제거
	var bizrno1 = $("#bizrno").val().split("-")[0];
	var bizrno2 = $("#bizrno").val().split("-")[1];
	var bizrno3 = $("#bizrno").val().split("-")[2];
	// 법인번호 하이픈 제거
	var jurirno1 = $("#jurirno").val().split("-")[0];
	var jurirno2 = $("#jurirno").val().split("-")[1];
	if($("#addType").val() == 'U'){ //상세페이지 수정일때
		if($("#chkCompName").val() != $("#company_name").val()){
			var checkNm = $("#checkName").val() == "true" ? "true" : "false";
			$("#checkName").val(checkNm);
		} else {
			$("#checkName").val(true);
		}
	}

	var chk = $("#checkName").val();
	if (chk == "false") {
		if($("#company_name").val() == ""){
			alert('<spring:message code="A0587" text="회사명을 입력해주세요"/>');
		} else {
			alert('<spring:message code="A0588" text="중복체크를 해주세요"/>');
		}
	} else {
		if($("#company_name").val() == ''){
			$("#checkName").val(false);
			alert('<spring:message code="A0587" text="회사명을 입력해주세요"/>');
		} else {
			var obj = new Object();
			var jsonObj = new Object();

			obj.companyId = $("#company_id").val();
			obj.companyName = $("#company_name").val();
			obj.companyNameEn = $("#company_name_en").val();
			obj.jurirno1 = jurirno1;
			obj.jurirno2 = jurirno2;
			obj.bizrno1 = bizrno1;
			obj.bizrno2 = bizrno2;
			obj.bizrno3 = bizrno3;
			obj.moblphonNo1 = $("#moblphon_no1").val();
			obj.moblphonNo2 = $("#moblphon_no2").val();
			obj.moblphonNo3 = $("#moblphon_no3").val();
			obj.fxnum1 = $("#fxnum1").val();
			obj.fxnum2 = $("#fxnum2").val();
			obj.fxnum3 = $("#fxnum3").val();
			obj.rprsntvNm = $("#rprsntv_nm").val();
			obj.bassAdres = $("#bass_adres").val();
			obj.detailAdres = $("#detail_adres").val();
			obj.deleteAt = $("input[name=system_use_slt2]:checked").val();
            obj.opstarttm = $("#op_start_tm").val();
            obj.opendtm = $("#op_end_tm").val();

			jsonObj.setSpComp = obj;

			$.ajax({url : "${pageContext.request.contextPath}/insertCompanyInfo",
					data : JSON.stringify(jsonObj),
					method : 'POST',
					contentType : "application/json; charset=utf-8",
					beforeSend : function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
					}).success(function(result) {
                       //console.log('jsonObj', JSON.stringify(jsonObj));
						alert('<spring:message code="A0589" text="등록이 완료되었습니다."/>');
						hidePopup("lyr_company_add");

						var curPage = $("#contents .paging .list strong").text();
						gridSearch(curPage);
						//resultProcess(result,data);
					}).fail(function(result) {
						alert('<spring:message code="A0590" text="등록이 완료되지 않았습니다."/>');
						console.log("회사 등록 error");
					});
		}
	}
}

/** 조회  */
function gridSearch(currentPage) {
	var lang = $.cookie("lang");

	var obj = new Object();
	obj.page = currentPage;
	obj.rdoVal = $("input[name=system_use_slt]:checked").val();
	obj.ipt_select = $("#ipt_select1_1 option:selected").val(); // 조건선택 selectbox
	obj.ipt_text = $("#ipt_txt").val();
	obj.rowNum = 20;
	obj.offset = (obj.page * obj.rowNum) - obj.rowNum;

	$.ajax({url : "${pageContext.request.contextPath}/getSUPERCompanyJQList",
			data : JSON.stringify(obj),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}",
						"${_csrf.token}");
			},
			jsonReader : {
				repeatitems : false,
				paging : "paging", // 현제 페이지, 하단의 navi에 출력됨.
				superCompList : "superCompList", // 총 페이지 수
				frontMnt : "fronMnt",
			},
		}).success(function(result) {
				var jObj = JSON.parse(result);
				var jSPCList = jObj.superCompList;
				var jPaging = jObj.paging;

				console.log(jPaging);

				inerHtml = "";
				pagingHtml = "";

				if (jSPCList.length > 0) {
					for ( var key in jSPCList) {

						inerHtml += "<tr><td>" +  (parseInt(key) + parseInt(JSON.stringify(jPaging.startRow)) + 1) + "</td>";
						inerHtml += '<td>' + jSPCList[key].COMPANY_ID + '</td>';
						if(jSPCList[key].COMPANY_NAME == "None" || jSPCList[key].COMPANY_NAME == null){
							inerHtml += "<td><a href=javascript:selectDetailCompany('" + jSPCList[key].COMPANY_ID + "') class='btn_lyr_open'>-</a></td>";
						}else{
							inerHtml += "<td><a href=javascript:selectDetailCompany('" + jSPCList[key].COMPANY_ID + "') class='btn_lyr_open'>" + jSPCList[key].COMPANY_NAME + "</a></td>";
						}

						if (jSPCList[key].COMPANY_NAME_EN == null) {
							inerHtml += "<td>-</td>";
						} else {
							inerHtml += "<td>" + jSPCList[key].COMPANY_NAME_EN + "</td>";
						}

						if (jSPCList[key].MOBLPHON_NO == null || jSPCList[key].MOBLPHON_NO == "--") {
							inerHtml += "<td>-</td>";
						} else {
							inerHtml += "<td>" + jSPCList[key].MOBLPHON_NO + "</td>";
						}

						if(lang == "en"){
							if(jSPCList[key].DELETE_AT == "사용"){
								inerHtml += "<td>use</td>";
							}else{
								inerHtml += "<td>not use</td>";
							}
						}else{
							inerHtml += "<td>"+ jSPCList[key].DELETE_AT + "</td>";
						}

						inerHtml += "<td>"+ jSPCList[key].REGIST_DT + "</td>";
						inerHtml += "<td><a href='#lyr_system_slt' class='btn_authority btn_lyr_open' onclick='adminpower("+JSON.stringify(jSPCList[key].COMPANY_ID)+");'><span class='fas fa-user-cog'></span></a></td>";
						inerHtml += "<td><a href='#lyr_system_campaign_slt' class='btn_authority btn_lyr_open' onclick='campaignpower("+JSON.stringify(jSPCList[key].COMPANY_ID)+");'><span class='fas fa-user-cog'></span></a></td></tr>";
					}

					console.log("key : " + JSON.stringify(jPaging.currentPage));

					pagingHtml += "<div class='tbl_path'><spring:message code='A0172' text='전체'/> <strong>" + JSON.stringify(jPaging.currentPage) + "</strong> / " + JSON.stringify(jPaging.totalPage) + "</div>";
					pagingHtml += "<div class='paging'>";
					pagingHtml += "<a class='btn_paging_first' href='javascript:gridSearch(" + JSON.stringify(jPaging.pageRangeStart) + ")' ><spring:message code='A0579' text='처음 페이지로 이동 '/></a>";
					pagingHtml += "<a class='btn_paging_prev' href='javascript:gridSearch(" + JSON.stringify(jPaging.prevPage) + ")' ><spring:message code='A0580' text='이전 페이지로 이동 '/></a>";
					pagingHtml += "<span class='list'>";

					for (var i = JSON.stringify(jPaging.pageRangeStart); i <= JSON.stringify(jPaging.pageRangeEnd); i++) {
						if (JSON.stringify(jPaging.currentPage) == i) {
							pagingHtml += "<strong>" + i + "</strong>";
						} else {
							pagingHtml += "<a href='javascript:gridSearch(" + i + ")'>" + i + "</a>";
						}
					}

					pagingHtml += "</span>";
					pagingHtml += "<a class='btn_paging_next' href='javascript:gridSearch(" + JSON.stringify(jPaging.nextPage) + ")'><spring:message code='A0581' text='다음 페이지로 이동 '/></a>";
					pagingHtml += "<a class='btn_paging_last' href='javascript:gridSearch(" + JSON.stringify(jPaging.pageRangeEnd) + ")'><spring:message code='A0582' text='마지막 페이지로 이동 '/></a>";
					pagingHtml += "</div>";

				} else {
					inerHtml += "<tr><td scope='row' colspan='8' class='data_none'><spring:message code='A0257' text='등록된 데이터가 없습니다.'/></td></tr>";
					pagingHtml += "<div class='tbl_path'><spring:message code='A0172' text='전체'/> <strong>1</strong> / 0</div>";
					pagingHtml += "<div class='paging'>";
					pagingHtml += "<a class='btn_paging_first' href='#none' ><spring:message code='A0579' text='처음 페이지로 이동 '/></a>";
					pagingHtml += "<a class='btn_paging_prev' href='#none' ><spring:message code='A0580' text='이전 페이지로 이동 '/></a>";
					pagingHtml += "<span class='list'>";
					pagingHtml += "<strong>1</strong>";
					pagingHtml += "</span>";
					pagingHtml += "<a class='btn_paging_next' href='#none'><spring:message code='A0581' text='다음 페이지로 이동 '/></a>";
					pagingHtml += "<a class='btn_paging_last' href='#none'><spring:message code='A0582' text='마지막 페이지로 이동 '/></a>";
					pagingHtml += "</div>";
				}

				$(".tbl_box").find('tbody').empty();
				$(".tbl_box").find('tbody').append(inerHtml);

				$(".tbl_btm_info").empty();
				$(".tbl_btm_info").append(pagingHtml);
			}).fail(function(result) {
	});
}

/** 회사명(국문) 중복 조회  */
function getCompNm() {
	var comp_name = $("#company_name").val();

	if (comp_name == "") {
		alert("<spring:message code='A0591' text='회사명을 입력해주세요.'/>");
		$("#company_name").focus();
		return;
	} else {
		var obj = new Object();
		obj.companyName = comp_name;

		$.ajax(
				{
					url : "${pageContext.request.contextPath}/getCompanyName",
					data : JSON.stringify(obj),
					method : 'POST',
					contentType : "application/json; charset=utf-8",
					beforeSend : function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}",
								"${_csrf.token}");
					},
				}).success(function(result) {
			if (result.length > 0) {
				console.log(result[0].COMPANY_NAME);
				idCheck(result[0].COMPANY_NAME);
			} else {
				idCheck();
			}
			//resultProcess(result,data);
		}).fail(function(result) {
			console.log("회사명 중복체크 error");
		});
	}
}

function idCheck(compNm) {
	$('#lyr_infomation').css('display', 'block');
	if ($("#company_name").val() == compNm) {
		$("#lyr_infomation .lyr_cont").find('p').empty();
		$("#lyr_infomation .lyr_cont").find('p').append('<spring:message code="A0592" text="이미 등록된 아이디입니다."/>');

		$("#checkName").val(false);
		//$('input[name=id_check]').val("");
		$("#company_name").focus();
		return;
	} else {
		//$('input[name=id_check]').val('check');
		$("#lyr_infomation .lyr_cont").find('p').empty();
		$("#lyr_infomation .lyr_cont").find('p').append('<spring:message code="A0593" text="사용 가능한 회사명 입니다."/>');
		$("#company_name_en").focus();
		$("#checkName").val(true);
	}
}

/** 선택한 회사 상세 조회 */
function selectDetailCompany(compId) {
	$("#checkName").val(false);
	$("#addType").val("U");
	$("#UserEdtForm")[0].reset();
	var obj = new Object();
	obj.companyId = compId;

	$.ajax({
		url : "${pageContext.request.contextPath}/getCompanyInfo",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(
			function(result) {

				console.log(result[0].COMPANY_NAME);
				$("#company_id").val(result[0].COMPANY_ID);

				$("#chkCompName").val(result[0].COMPANY_NAME);
				$("#company_name").val(result[0].COMPANY_NAME);
				$("#company_name_en").val(result[0].COMPANY_NAME_EN);

				$("#rprsntv_nm").val(result[0].RPRSNTV_NM);

				if(result[0].JURIRNO == null || result[0].JURIRNO == "-"){
					$("#jurirno").val("");
				}else{
					$("#jurirno").val(result[0].JURIRNO);
				}

				$("#bass_adres").val(result[0].BASS_ADRES);
				$("#detail_adres").val(result[0].DETAIL_ADRES);

				if(result[0].BIZRNO == null || result[0].BIZRNO == "--"){
					$("#bizrno").val("")
				}else{
					$("#bizrno").val(result[0].BIZRNO);
				}

				$("#fxnum1").val(result[0].FXNUM1);
				$("#fxnum2").val(result[0].FXNUM2);
				$("#fxnum3").val(result[0].FXNUM3);

				$("#moblphon_no1").val(result[0].MOBLPHON_NO1);
				$("#moblphon_no2").val(result[0].MOBLPHON_NO2);
				$("#moblphon_no3").val(result[0].MOBLPHON_NO3);
                $("#op_start_tm").val(result[0].OP_START_TM);
                $("#op_end_tm").val(result[0].OP_END_TM);

				console.log(result[0].DELETE_AT);
				if (result[0].DELETE_AT == "N") {
					$("input[name=system_use_slt2][id='used2']").prop('checked', true);
				} else {
					$("input[name=system_use_slt2][id='not_used2']").prop('checked', true);
				}
				$("#deleteComp").show();

				openPopup("lyr_company_add");
			}).fail(function(result) {
		console.log("회사명 상세조회 error");
	});
}

/** 회사 삭제  */
function deleteCompany() {
	var comp_id = $("#company_id").val();

	var obj = new Object();
	obj.companyId = comp_id;

	$.ajax({
		url : "${pageContext.request.contextPath}/deleteCompanyInfo",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		console.log(result);
		alert('<spring:message code="A0594" text="삭제가 완료되었습니다."/>');
		hidePopup("lyr_company_add");
		var curPage = $("#contents .paging .list strong").text();
		gridSearch(curPage);
	}).fail(function(result) {
		console.log("회사 삭제 error");
	});
}

function srchAddress(){
	 new daum.Postcode({
	        oncomplete: function(data) {
	            $("#bass_adres").val(data.address);
	        }
	    }).open();
}

function adminpower(companyId){
	var obj = new Object();
	$("#menuCompanyId").val(companyId);
	obj.companyId = companyId;

	$.ajax({
		url : "${pageContext.request.contextPath}/getCompanyMenu",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(
			function(result) {
				$('input[name=sstm_menu_chk]').prop("checked",false);
				for(var i = 0;  i < result.length; i++){

					$('#sstm_'+result[i].MENU_CODE).prop("checked", true);
					try{
						if(document.getElementById('sstm_'+result[i].MENU_CODE).checked == true) {
							$('.menu_slt_chk .menu_lst > li').find('.sub').show();
							$('.menu_slt_chk .menu_lst > li').find('.third').show();
							$('.all_sstm_menu').prop('checked',true);
							$('.menu_slt_chk .menu_lst > li').find('.menu1').attr('class','menu1 fas fa-caret-down');
							$('.menu_slt_chk .menu_lst .sub > li').find('.menu2').attr('class','menu2 fas fa-caret-down');
						}
					}catch(e){

					}
				}

				if(result == ""){
					$('.all_sstm_menu').prop('checked',false);
					$('.ipt_check').prop('checked',false);
					$('.menu_slt_chk .menu_lst > li').find('.sub').hide();
					$('.menu_slt_chk .menu_lst > li').find('.third').hide();
					$('.menu_slt_chk .menu_lst > li').find('.menu1').attr('class','menu1 fas fa-caret-up');
					$('.menu_slt_chk .menu_lst .sub > li').find('.menu2').attr('class','menu2 fas fa-caret-up');
				}
				openPopup("lyr_system_slt");
			}).fail(function(result) {
		console.log("company menu search error");
	});
}

function campaignpower(companyId){
    $("#campaignCompanyId").val(companyId);

    var obj = new Object();
    obj.companyId = companyId;

    $.ajax({
        url : "${pageContext.request.contextPath}/getCompanyCampaigns",
        data : JSON.stringify(obj),
        method : 'POST',
        contentType : "application/json; charset=utf-8",
        beforeSend : function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
    }).success(
        function(result) {
            var companyCampaignsList = result;
            //해당 company에 할당된 campaign check 전에 check 해제
            $('input[name="sstm_campaign_chk"]').prop("checked", false);
            //해당 company에 할당된 campaign check
            if(companyCampaignsList.length > 0){
                for(var i = 0; i < companyCampaignsList.length; i++){
                    $("#sstm_camp_" + companyCampaignsList[i].campaignId).prop("checked", true);
                }
                //campaign이 회사에 전체로 할당되었을시 전체 선택 및 그러지 않을경우 해제
                if($('input[id*="sstm_camp_"]:checked').length == $('input[id*="sstm_camp_"]').length){
                    $("#total_campaign_chk").prop("checked",true);
                    console.log("same");
                }else {
                    console.log("diff");
                    $("#total_campaign_chk").prop("checked",false);
                }
            }
            openPopup("lyr_system_campaign_slt");
        }).fail(function(result) {
        console.log("company campaigns search error");
    });
}

function goSave() {
	var companyId = $("#menuCompanyId").val();
	var list = new Array();
	var list1 = new Array();


	<c:forEach var="menu1" items="${user.menuLinkedMap}">
	<c:set var="menu1" value="${menu1.value}"/>
		list.push("${menu1.menuCode}");
	</c:forEach>

	var idx = 0;
	for(var i = 0; i < list.length; i++){
		var obj = new Object();
		try{
			if(document.getElementById('sstm_'+list[i]).checked == true){
				obj.companyId = companyId;
				obj.menuCode = list[i];
				idx++;
				list1.push(obj);
			}
		}catch(e){
		}
	}

	//권한관리 popup 창에서 선택한 메뉴가 없을때
	if(idx < 1){
		obj.companyId = companyId;
		list1.push(obj);
	}
	httpSend("${pageContext.request.contextPath}/insertCompanyMenu", $("#headerName").val(), $("#token").val(), JSON.stringify(list1));
	alert('<spring:message code="A0589" text="등록이 완료되었습니다."/>');
};

function goCompanyCampaignsSave(){
    console.log("goCompanyCampaignsSave!!");
    var companyId = $("#campaignCompanyId").val();
    var obj = new Object();
    obj.companyId = companyId

    var list = new Array();
    $('input:checkbox[id*="sstm_camp_"]').each(function(){
        if(this.checked == true){
            list.push(this.value);
        }
    });
    obj.campaignList = list;

    $.ajax({
        url : "${pageContext.request.contextPath}/insertCompanyCampaigns",
        data : JSON.stringify(obj),
        method : 'POST',
        contentType : "application/json; charset=utf-8",
        beforeSend : function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
    }).success(function(result) {
        alert("선택한 캠페인이 해당 회사에 저장되었습니다.");
    }).fail(function(result) {
    console.log("company campaigns search error");
    });

}

/** INPUT TYPE NUMBER 글자수 제한 */
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }
}
</script>
</body>
</html>
