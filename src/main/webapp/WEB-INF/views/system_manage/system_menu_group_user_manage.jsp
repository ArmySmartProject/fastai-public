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
		<input type="hidden" id= "checkId"  value="false" />
		<input type="hidden" id= "addType"  value="I" />
		<input type="hidden" id= "enabledYn" value="Y" />
		
		<!-- #header -->
		<jsp:include page="../common/inc_header.jsp">
		<jsp:param name="titleCode" value="A0013"/>
		<jsp:param name="titleTxt" value="사용자관리"/>
		</jsp:include>
		<!-- //#header -->
		
		<!-- #container -->
		<div id="container">
			<input type="hidden" id="insUptType">
	        <!-- #contents -->
	        <div id="contents">
	        <div id="super_admin" class="content">
                <!-- .section -->
                <div class="stn">
                    <div class="tblBox_r"></div>
                    <div class="tbl_top_info">                    
                        <div class="condition_box"> 
                           <div class="use_slt_group">
                                <span class="group_title"><spring:message code="A0557" text="사용여부" /></span>
                                <div class="radioBox">
                                    <input type="radio" name="system_use_slt" id="used" checked="checked" value="useY">
                                    <label for="used"><spring:message code="A0535" text="사용"/></label>
                                    <input type="radio" name="system_use_slt" id="not_used" value="useN">
                                    <label for="not_used"><spring:message code="A0536" text="미 사용"/></label>
                                </div>
                            </div>
                            <div class="srch_group">
                                <span class="group_title"><spring:message code="A0806" text="사용자 검색" /> </span>
                                <div class="srchBox">
                                    <select class="select" id="ipt_select1"> 
                                        <option selected="selected" value="userNm"><spring:message code="A0032" text="이름"/></option> 
                                        <option value="userId"><spring:message code="A0547" text="사용자 ID"/></option> 
                                    </select>
                                    <input type="text" class="ipt_srch" placeholder="<spring:message code="A0558" text="검색어를 입력해주세요"/>" id="ipt_srchtxt">
                                    <input type="text" class="ipt_srch" placeholder="<spring:message code="A0558" text="검색어를 입력해주세요"/>" id="ipt_srchtxt" style="opacity: 0; pointer-events: none;">
                                    <button type="submit" class="btn_srch" id="search"><spring:message code="A0180" text="검색"/></button>
                                </div>                                
                            </div>
                        </div>
                        <div class="btnBox sz_small line">
                            <!-- [D] 등록관련 UI script는 하단script 영역에 있음 -->
                                <a class="btnS_basic btn_lyr_open" id="addUser"><spring:message code="A0538" text="등록"/></a>
                                <a class="btnS_basic btn_clr" id="deleteUser"><spring:message code="A0541" text="삭제"/></a>     
                        </div>
                    </div>
                    
                    <div class="tbl_box">
                        <table summary="No, 이름, 사용자ID, 권한그룹, 사용여부, 연락처, 권한유형, 등록, 등록일,수정자,수정일,수정으로 구성됨">
                            <colgroup>
                                <col width="60"><col><col><col>
                                <col><col><col><col><col>
                                <col><col width="100"><col width="100"><col width="100">
                                <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                            </colgroup> 
                            <thead>
                                <tr>
                                    <th scope="col">
                                        <div class="checkBox">
                                            <input type="checkbox" name="sstm_userAll_chk" id="ipt_check00" class="ipt_check">
                                            <label for="ipt_check00"><spring:message code="A0135" text="No."/></label>
                                        </div>                                        
                                    </th>
                                    <th scope="col"><spring:message code="A0032" text="이름"/></th>
                                    <th scope="col"><spring:message code="A0547" text="사용자 ID" /></th>
                                    <th scope="col"><spring:message code="A0807" text="권한그룹" /></th>
                                    <th scope="col"><spring:message code="A0557" text="사용여부" /></th>
                                    <th scope="col"><spring:message code="A0074" text="연락처"/></th>
                                    <th scope="col"><spring:message code="A0544" text="권한유형"/></th>
                                    <th scope="col"><spring:message code="A0813" text="둥록자" /></th>
                                    <th scope="col"><spring:message code="A0542" text="등록일"/></th>
                                    <th scope="col"><spring:message code="A0808" text="수정자" /></th>
                                    <th scope="col"><spring:message code="A0574" text="수정일" /></th>
                                    <th scope="col"><spring:message code="A0809" text="수정" /></th>
                                    <th scope="col"><spring:message code="A0980" text="잠김" />
                                        <div class="help">?<div class="help_desc"><i><spring:message code="A0983" text="잠김 툴팁" /></i></div></div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
	                            	<td scope="row" colspan="12" class="data_none"><spring:message code="A0257" text="등록된 데이터가 없습니다."/></td>
	                            </tr>
                            </tbody>
                        </table>
                    </div>                
                    <div class="tbl_btm_info">
                        <div class="paging">
                            <a class="btn_paging_prev" href="#none" ><spring:message code="A0580" text="이전 페이지로 이동 "/></a>
                            <span class="list">
                                <strong>1</strong>
                            </span>
                            <a class="btn_paging_next" href="#none"><spring:message code="A0581" text="다음 페이지로 이동 "/></a>
                        </div>
                    </div>
                </div>
            </div>
	        </div>
	        <!-- //#contents -->
	    </div><!-- //#container -->
	
		<hr>
		
		<!-- #footer -->
		<div id="footer">
		    <div class="cyrt"><span>&copy; MINDsLab. All rights reserved.</span></div>
		</div>
		<!-- //#footer -->
	</div>
	<!-- //#wrap -->

<!-- ===== layer popup ===== -->
<div id="lyr_userAdd" class="lyrBox" style="width:700px;">
    <div class="lyr_top">
        <h3><spring:message code="A0013" text="사용자 관리 "/></h3>
        <button class="btn_lyr_close"><spring:message code="A0631" text="닫기" /></button>
     </div>
    <div class="lyr_mid" style="max-height: 527px;">        
        <p><em class="ft_clr_1st">*</em><spring:message code="A0583" text="는 필수 입력 사항 입니다." /></p>
        
        <div class="info_edit_tbl">
        <form id="UserEdtForm">
            <table summary="사용자ID, 비밀번호, 사용자 권한유형, 성별, 이름, 생년월일, 이메일, 휴대폰 번호, 직급, 부서, 주소, 권한그룹,사용여부로 구성됨">
                <caption class="hide">사용자 정보 입력</caption>
                <colgroup>
                    <col width="115"><col><col width="115"><col>
                </colgroup>
                
                <tbody>
                    <tr>
                        <th scope="row"><em>*</em><spring:message code="A0547" text="사용자ID"/></th>
                        <td>
                            <div class="iptBox short">
                            	<input type="hidden" id="chk_userid" name="chk_userid">
                                <input type="text" class="ipt_txt" id="user_id" name="user_id">
                                <input type="text" class="ipt_txt" id="user_id" name="user_id" style="display: none; opacity: 0; pointer-events: none;">
                                <button type="button" class="btn_srch name_chk" id="id_Chk"><spring:message code="A0546" text="중복확인"/></button>
                            </div>                                               
                        </td>
                        <th><spring:message code="A0033" text="비밀번호"/></th>
                        <td>
                            <div class="iptBox">
                                <input type="password" class="ipt_txt" id="user_pw1" name="user_pw1" style="display: none; opacity: 0; pointer-events: none;">
                                <input type="hidden" class="ipt_txt" id="user_pw" name="user_pw">
                                <button type="button" class="btn_srch password_reset" id="password_reset"><spring:message code="A0845" text="비밀번호 초기화" /></button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><em>*</em><spring:message code="A0544" text="권한유형"/></th>
                        <td>
                            <select class="select" id="user_auth_ty">
                                <option value="" selected="selected"><spring:message code="A0069" text="선택"/></option>
                                <option value="A">ADMIN</option>
	                            <option value="N">CONSULTANT</option>
                            </select>
                        </td>
                        <th><spring:message code="A0548" text="성별"/></th>
                        <td>
                            <div class="radioBox">
                                <input type="radio" name="sexdstn" id="male" checked="checked" value="0">
	                            <label for="male"><spring:message code="A0549" text="남"/></label>
	                            <input type="radio" name="sexdstn" id="female" value="1">
	                            <label for="female"><spring:message code="A0550" text="여"/></label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><em>*</em><spring:message code="A0032" text="이름"/></th>
                        <td>
                            <div class="iptBox">
                                <input type="text" class="ipt_txt"  id="user_nm" name="user_nm">
                            </div>
                        </td>
                        <th><spring:message code="A0551" text="생년월일"/></th>
                        <td>
                            <div class="iptBox">
                                <input type="number" class="ipt_txt" id="brthdy" name="brthdy" maxlength="10" oninput="maxLengthCheck(this)">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><spring:message code="A0048" text="이메일"/></th>
                        <td colspan="3">
                            <div class="iptBox email">
                                <input type="text" name="email1" id="email1" class="ipt_txt">
                                <span class="hyphen">@</span>
                                <input type="text" name="email2" id="email2" class="ipt_txt">
                                <select name="selectBoxMail" id="selectBoxMail" class="select mail"> 
	                                <option value="none" selected="selected">-<spring:message code="A0552" text="직접 입력"/>-</option> 
	                                <option value="naver.com">naver.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="daum.net">daum.net</option>
									<option value="nate.com">nate.com</option>
									<option value="hotmail.com">hotmail.com</option>
									<option value="chollian.net">chollian.net</option>
									<option value="empal.com">empal.com</option>
									<option value="hanmir.com">hanmir.com</option>
									<option value="korea.com">korea.com</option>
									<option value="msn.com">msn.com</option>
									<option value="paran.com">paran.com</option>
									<option value="sayclub.com">sayclub.com</option>
									<option value="yahoo.co.kr">yahoo.co.kr</option>
	                            </select>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th><spring:message code="A0553" text="휴대폰 번호"/></th>
                        <td colspan="3">
                            <div class="iptBox number">
                            	<input type="number" class="ipt_txt" id="moblphon_no1" name="moblphon_no1" maxlength="3" oninput="maxLengthCheck(this)">
                                <span class="hyphen">-</span>
                                <input type="number" class="ipt_txt" id="moblphon_no2" name="moblphon_no2" maxlength="4" oninput="maxLengthCheck(this)">
                                <span class="hyphen">-</span>
                                <input type="number" class="ipt_txt" id="moblphon_no3" name="moblphon_no3" maxlength="4" oninput="maxLengthCheck(this)">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><spring:message code="A0554" text="직급"/></th>
                        <td>
                            <div class="iptBox">
                                <input type="text" class="ipt_txt" id="position_cd" name="position_cd">
                            </div>
                        </td>
                        <th><spring:message code="A0555" text="부서"/></th>
                        <td>
                            <div class="iptBox">
                                <input type="text" class="ipt_txt" id="dept_cd" name="dept_cd">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><spring:message code="A0046" text="주소"/></th>
                        <td colspan="3">
                            <div class="ipt_address">
                                <div class="iptBox">
                                    <input type="text" class="ipt_txt" id=bass_adres name="bass_adres">
                                    <button type="button" id="srch_addr" name="srch_addr"><spring:message code="A0801" text="주소찾기" /></button>
                                </div>
                                <div class="iptBox">
                                    <input type="text" class="ipt_txt" placeholder="<spring:message code="A0556" text="상세주소를 입력해주세요"/>" id="detail_adres" name="detail_adres" maxlength="100">
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr id="AuthGroup">
                        <th><em>*</em><spring:message code="A0807" text="권한그룹" /></th>
                        <td colspan="3">
                            <select class="select" id="menu_auth_group" style="width:215px;">
                            	<option value="" selected="selected"><spring:message code="A0069" text="선택"/></option>
                                <c:forEach items="${MenuAuthGroup}" var="MenuAuthGroup">
	                            <option value="${MenuAuthGroup.COMPANY_GROUP_ID}">${MenuAuthGroup.GOUP_NM}</option>
	                            </c:forEach> 
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>캠페인</th>
                        <td colspan="3">
                            <c:forEach items="${companyCampaigns}" var="companyCampaigns" varStatus="status">
                                <div class="checkBox">
                                    <input type="checkbox" class='ipt_check' name="user_camp_chk" id="sstm_camp_${companyCampaigns.campaignId}" value="${companyCampaigns.campaignId}">
                                    <label for="sstm_camp_${companyCampaigns.campaignId}">${companyCampaigns.campaignNm}</label>

                                </div>
                            </c:forEach>
                        </td>
                    </tr>
                    <tr>
                        <th><em>*</em><spring:message code="A0557" text="사용여부"/></th>
                        <td colspan="3">
                            <div class="radioBox">
                                <input type="radio" name="system_use_slt1" id="pop_used" checked="checked" value="Y">
                                <label for="pop_used"><spring:message code="A0535" text="사용"/></label>
                                <input type="radio" name="system_use_slt1" id="pop_not_used" value="N">
                                <label for="pop_not_used"><spring:message code="A0536" text="미 사용"/></label>
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
            <button id="insertUser"><spring:message code="A0320" text="저장"/></button>  
        	<button class="btn_lyr_close"><spring:message code="A0532" text="취소"/></button>
        </div>
    </div>
</div>
 

<!-- 안내 팝업 -->
<div id="lyr_infomation" class="lyrBox lyr_super lyr_alert">
    <div class="lyr_cont">
        <p></p>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button class="btn_close"><spring:message code="A0037" text="확인"/></button>            
        </div>
    </div>
</div>
<!-- //안내 팝업 --> 

<%@ include file="../common/inc_footer.jsp"%>

<script type="text/javascript">   
$(window).load(function() { 
    //page loading delete  
	$('#pageldg').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });
}); 

$(document).ready(function (){
	//첫 화면 이동 시 조회
	userSearch(1);
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
        
      //회사 검색, 안내, 주소 팝업
        $('#lyr_userAdd .btn_company_srch').on('click',function(){
        	//openPopup("lyr_company_srch"); 
        	$("#srchCompTxt").val('');
        	$('#lyr_company_srch').css('display', 'block');
        	srchComp(1);
        });
      
        $('#lyr_userAdd .name_chk').on('click',function(){
        	getUserId();
        });
        
        $('.lyr_alert .btn_close').on('click',function(){
            $('.lyr_alert').hide();
        });
        
        //시스템 메뉴 선택
        $('.menu_slt_lst .lst_bd > li > .menu_name').on('click',function(){						
        	$('.sub').toggleClass('active');			
        });
        $('.menu_slt_lst .lst_bd .sub > li > .menu_name').on('click',function(){						
        	$('.third').toggleClass('active');		
        });	

        $("#search").on("click", function(){
        	userSearch(1);
		});
        
        $("#srch_addr").on("click", function(){
        	srchAddress();
		});
        
        $('#addUser').on('click',function(){
        	$("#insUptType").val("insert");
        	$("#UserEdtForm")[0].reset();
        	$("#user_auth_ty > option").attr('selected', false);
        	$("#menu_auth_group > option").attr('selected', false);
        	$("#addType").val("I");
        	$("#pwText").remove();
        	document.getElementById("user_id").readOnly = false;
        	$("#id_Chk").show();
        	openPopup("lyr_userAdd");
        });
 
        $("#insertUser").on("click", function(){
        	insertUserInfo();
		});
        
        $("#srchComp").on("click", function(){
        	srchComp(1);
		});
        
        $("#selectComp").on("click", function(){
        	chkSelectComp();
        	//hidePopup("lyr_company_srch");
        	$('.lyr_alert').hide();
		});
        
        $("#deleteUser").on("click", function(){
        	var yn = confirm('<spring:message code="A0586" text="삭제하시겠습니까?"/>');
            if(yn){
            	deleteUserInfo();
            }
		});
        $("#password_reset").on("click",function(){
        	$("#pwText").remove();
        	$("#user_pw").val("minds12#$");
        	$("#enabledYn").val("N");
        	$("#password_reset").after("<span id='pwText'><br /><spring:message code='A0843' text='비밀번호가' /> <span style='font-weight:bold; color:red;'>minds12#$ </span><spring:message code='A0844' text='으로 초기화되었습니다.' /></span>");
        });

        $("#user_auth_ty").on('change', function(){
           if(this.value == "A"){
               $('input[name="user_camp_chk"]').prop('checked', true);
               $('input[name="user_camp_chk"]').attr('disabled', true);
           }else {
               $('input[name="user_camp_chk"]').prop('checked', false);
               $('input[name="user_camp_chk"]').attr('disabled', false);
           }
        });
        
	});
});	

//리스트 체크 박스 전체 선택 /전체 해제
	$("input[name=sstm_userAll_chk]").on('click', function(){
		if($("input[name=sstm_userAll_chk]:checked").is(":checked") == true){
  		$("input[name=sstm_menu_chk]").prop('checked', true);
		}else {
  		$("input[name=sstm_menu_chk]").prop('checked', false);
		}
	});

/** 조회  */
function userSearch(currentPage) {
	var lang = $.cookie("lang");

	// console.log(currentPage);

	var obj = new Object();
	obj.page = currentPage;
	obj.rdoVal = $("input[name=system_use_slt]:checked").val();
	obj.ipt_select = $("#ipt_select1 option:selected").val(); // 조건선택 selectbox 
	obj.ipt_srchtext = $("#ipt_srchtxt").val();
	obj.authTy = $("#authTy option:selected").val();
	obj.rowNum = 20;
	obj.offset = (obj.page * obj.rowNum) - obj.rowNum;

	$.ajax({url : "${pageContext.request.contextPath}/getMenuGroupUserMainList",
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
				MenuGroupUserList : "MenuGroupUserList", // 총 페이지 수
				frontMnt : "frontMnt",
			},
		}).success(function(result) {
				//console.log(result);

				var jObj = JSON.parse(result);
				var jSPUList = jObj.MenuGroupUserList;
				var jPaging = jObj.paging;

				//console.log(jPaging);

				inerHtml = "";
				pagingHtml = "";

				if (jSPUList.length > 0) {
					for ( var key in jSPUList) {
						
						inerHtml += "<tr><td><div class='checkBox'><input type='checkbox' name='sstm_menu_chk' id='user_chk" + (parseInt(key) + parseInt(JSON.stringify(jPaging.startRow)) + 1) + "' class='checking ipt_check'><label for='user_chk" + (parseInt(key) + parseInt(JSON.stringify(jPaging.startRow)) + 1) + "'>" + (parseInt(key) + parseInt(JSON.stringify(jPaging.startRow)) + 1) + "</label></div></td>";
						
						if (jSPUList[key].USER_NM == null) {
							inerHtml += "<td>-</td>";
						} else {
							inerHtml += "<td>" + jSPUList[key].USER_NM + "</td>";
						}
						
						inerHtml += "<td>"+ jSPUList[key].USER_ID + "</td>";
						
						if (jSPUList[key].GOUP_NM == null) {
							inerHtml += "<td>-</td>";
						} else {
							inerHtml += "<td>" + jSPUList[key].GOUP_NM + "</td>";
						}
						
						if(lang == "en"){
							if(jSPUList[key].USE_AT == "사용"){
								inerHtml += "<td>use</td>";
							}else{
								inerHtml += "<td>not use</td>";
							}
						}else{
							inerHtml += "<td>" + jSPUList[key].USE_AT + "</td>";
						}
						
						if (jSPUList[key].MOBLPHON_NO == null || jSPUList[key].MOBLPHON_NO == "--"){
							inerHtml += "<td>-</td>";
						} else {
							inerHtml += "<td>" + jSPUList[key].MOBLPHON_NO + "</td>";
						}
						if(lang == "en"){
							if(jSPUList[key].USER_AUTH_NM == "슈퍼어드민"){
								inerHtml += "<td>SuperAdmin</td>";
							}else if(jSPUList[key].USER_AUTH_NM == "관리자"){
								inerHtml += "<td>Admin</td>";
							}else if(jSPUList[key].USER_AUTH_NM == "상담사"){
								inerHtml += "<td>Consultant</td>";
							}else{
								inerHtml += "<td>Guest</td>";
							}
						}else{
							inerHtml += "<td>" + jSPUList[key].USER_AUTH_NM + "</td>";
						}
						
						if(jSPUList[key].REGISTER_ID == null){
							inerHtml += "<td>-</td>";
						}else{
							inerHtml += "<td>" + jSPUList[key].REGISTER_ID + "</td>";
						}
						
						inerHtml += "<td>" + jSPUList[key].REGIST_DT + "</td>";
						if (JSON.stringify(jSPUList[key].UPDUSR_ID) == null) {
							inerHtml += "<td>-</td>";
						} else {
							inerHtml += "<td>" + JSON.stringify(jSPUList[key].UPDUSR_ID).replace(/\"/g, "") + "</td>";
						} 
						if (JSON.stringify(jSPUList[key].UPDT_DT) == null) {
							inerHtml += "<td>-</td>";
						} else {
							inerHtml += "<td>" + JSON.stringify(jSPUList[key].UPDT_DT).replace(/\"/g, "") + "</td>";
							
						}
						inerHtml += "<td><div class='btnBox'><a class='btn_lyr_open' onclick='javascript:selectDetailUser(" + JSON.stringify(jSPUList[key].USER_ID) + ")'><spring:message code='A0809' text='상태' /></a></div></td>";

						if (jSPUList[key].nowLock == null) {
                          inerHtml += "<td style=\"color:#14C26F\"><spring:message code='A0982' text='정상' /></td></tr>";
                        } else {
                          inerHtml += "<td><div class='btnBox'><a class='btn_lyr_open'  style=\"color:#EC3C3C; width:90px\" onclick='javascript:resetPwLock(" + JSON.stringify(jSPUList[key].USER_ID) + ")'><spring:message code='A0981' text='잠금해제' /></a></div></td></tr>";;
                        }
					}

					// console.log("key : " + JSON.stringify(jPaging.currentPage));

					pagingHtml += "<div class='tbl_path'><spring:message code='A0172' text='전체'/><strong> <strong>" + JSON.stringify(jPaging.currentPage) + "</strong> / " + JSON.stringify(jPaging.totalPage) + "</div>";
					pagingHtml += "<div class='paging'>";
					
					pagingHtml += "<a class='btn_paging_prev' href='javascript:userSearch(" + JSON.stringify(jPaging.prevPage) + ")' ><spring:message code='A0580' text='이전 페이지로 이동 '/></a>";
					pagingHtml += "<span class='list'>";

					for (var i = JSON.stringify(jPaging.pageRangeStart); i <= JSON.stringify(jPaging.pageRangeEnd); i++) {
						if (JSON.stringify(jPaging.currentPage) == i) {
							pagingHtml += "<strong>" + i + "</strong>";
						} else {
							pagingHtml += "<a href='javascript:userSearch(" + i + ")'>" + i + "</a>";
						}
					}

					pagingHtml += "</span>";
					pagingHtml += "<a class='btn_paging_next' href='javascript:userSearch(" + JSON.stringify(jPaging.nextPage) + ")'><spring:message code='A0581' text='다음 페이지로 이동 '/></a>";
					pagingHtml += "</div>";

				} else {
					inerHtml += "<tr><td scope='row' colspan='13' class='data_none'><spring:message code='A0257' text='등록된 데이터가 없습니다.'/></td></tr>";
					/* pagingHtml += "<div class='tbl_path'><spring:message code='A0172' text='전체'/><strong> <strong>1</strong> / 0</div>"; */
					pagingHtml += "<div class='paging'>";
					pagingHtml += "<a class='btn_paging_prev' href='#none' ><spring:message code='A0580' text='이전 페이지로 이동 '/></a>";
					pagingHtml += "<span class='list'>";
					pagingHtml += "<strong>1</strong>";
					pagingHtml += "</span>";
					pagingHtml += "<a class='btn_paging_next' href='#none'><spring:message code='A0581' text='다음 페이지로 이동 '/></a>";
					pagingHtml += "</div>";
				}

				$(".tbl_box").find('tbody').empty();
				$(".tbl_box").find('tbody').append(inerHtml);

				$(".tbl_btm_info").empty();
				$(".tbl_btm_info").append(pagingHtml);
			}).fail(function(result) {
	});
}
/** 주소 찾기  */
function srchAddress(){
	 new daum.Postcode({
	        oncomplete: function(data) {
	            $("#bass_adres").val(data.address);
	        }
	    }).open();
}

/** 사용자ID 중복 조회  */
function getUserId() {
	var user_id = $("#user_id").val();

	if (user_id == "") {
		alert("<spring:message code='A0595' text='사용자ID를 입력해주세요.'/>");
		$("#user_id").focus();
		return;
	} else {
		var obj = new Object();
		obj.ipt_srchId = user_id;

		$.ajax(
				{
					url : "${pageContext.request.contextPath}/getUserId",
					data : JSON.stringify(obj),
					method : 'POST',
					contentType : "application/json; charset=utf-8",
					beforeSend : function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
				}).success(function(result) {
			if (result.length > 0) {
				console.log(result[0].USER_ID);
				idCheck(result[0].USER_ID);
			} else {
				idCheck();
				$("#chk_userid").val(user_id);
			}
			
			$('#lyr_infomation').css('display', 'block');
			//resultProcess(result,data);
		}).fail(function(result) {
			console.log("회사명 중복체크 error");
		});
	}
}

function idCheck(userId) {
	
	if ($("#user_id").val() == userId) {
		$("#lyr_infomation .lyr_cont").find('p').empty();
		$("#lyr_infomation .lyr_cont").find('p').append('<spring:message code="A0592" text="이미 등록된 아이디입니다."/>');

		$("#checkId").val(false);
		//$('input[name=id_check]').val("");
		$("#user_id").focus();
		return;
	} else {
		//$('input[name=id_check]').val('check');
		var innerHTML = "<span>" + $("#user_id").val() + "</span>&nbsp<spring:message code='A0818' text='은 사용 가능한 아이디 입니다.' />";
		$("#lyr_infomation .lyr_cont").find('p').empty();
		$("#lyr_infomation .lyr_cont").find('p').append(innerHTML);

		$("#user_pw").focus();
		$("#checkId").val(true);
	}
}

function saveUser(){
	
	// 사용자ID 체크
	if($("#user_id").val() == ""){
		alert("<spring:message code='A0595' text='사용자ID를 입력해주세요.'/>");
		return false;
	}
	
	// 중복체크 확인
	if ($("#checkId").val() == "false" && $("#addType").val() == "I") {
		alert("<spring:message code='A0588' text='중복체크를 해주세요'/>");	
		return false;
	} 

	// 중복체크한 ID와 input text에 입력된 ID 같은지 체크
	if($("#chk_userid").val() != $("#user_id").val()){
		if($("#addType").val() == "U"){
			alert("<spring:message code='A0597' text='등록한 ID와 다릅니다.'/>");
		} else {
			alert("<spring:message code='A0598' text='중복체크한 ID와 다릅니다.'/>");
		}
		return false;
	}
	
	// 비밀번호 체크
	if($("#insUptType").val() == "insert"){
		if($("#user_pw").val() == ""){
			alert("<spring:message code='A0841' text='비밀번호 초기화 버튼을 클릭해주세요.' />");
			return false;
		} 
	} 
// 	if($("#user_pw").val() != null && $("#user_pw").val() != ""){
// 		if($("#user_pw").val().length <= 8 || $("#user_pw").val().length >= 16){
// 			alert("<spring:message code='A0838' text='비밀번호 8자리 이상 16자리 이하로 입력해주세요.' />");
// 			return false;
// 		}
// 		var pwCheck = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,16}$/; 
// 		if(!pwCheck.test($("#user_pw").val())){
// 			alert("<spring:message code='A0839' text='영문,숫자,특수문자의 조합으로 입력해주세요.' />");
// 			return false;
// 		}
// 	}	
	
	// 권한유형 체크
	if($("#user_auth_ty").val() == ""){
		alert("<spring:message code='A0819' text='권한 유형을 체크해주세요.' />");
		return false;
	}
	
	// 권한그룹 체크
	if($("#menu_auth_group").val() == ""){
		alert("<spring:message code='A0820' text='권한 그룹을 설정해주세요.' />");
		return false;
	}
	
	// 권한그룹 체크
	if($("#user_nm").val() == ""){
		alert("<spring:message code='A0821' text='이름을 입력해주세요.' />");
		return false;
	}
	
	return true;
}
/** 등록  저장  */
function insertUserInfo() {
	if(saveUser()){
		if($("#user_id").val() == ""){
			alert("<spring:message code='A0595' text='사용자ID를 입력해주세요.'/>");
			return false;
		} 
		var obj = new Object();
		var jsonObj = new Object();

		//obj.companyId = $("#company_id").val();
		
		obj.userId = $("#user_id").val();
		obj.userPw = $("#user_pw").val();
		obj.userNm = $("#user_nm").val();
		
		obj.userAuthTy = $("#user_auth_ty option:selected").val(); // 조건선택 selectbox 
		obj.sexdstn    = $("input[name=sexdstn]:checked").val();
		obj.brthdy     = $("#brthdy").val();
		obj.companyGroupId = $("#menu_auth_group option:selected").val();
		
		var email1    = $("#email1").val();
		var email2    = $("#email2").val();
		var emailSelect = $("#selectBoxMail option:selected").val();
		
		if(email1 != ""){
			if(emailSelect != "none"){
				if(email2 != ""){
					obj.email = $("#email1").val() + "@" + $("#email2").val();
				} else {
					obj.email = $("#email1").val() + "@" + $("#selectBoxMail option:selected").val(); // 조건선택 selectbox 
				}
			} else {
				if(email2 != ""){
					obj.email = $("#email1").val() + "@" + $("#email2").val();
				}
			}
		}

		obj.moblphonNo1 = $("#moblphon_no1").val();
		obj.moblphonNo2 = $("#moblphon_no2").val();
		obj.moblphonNo3 = $("#moblphon_no3").val();
		obj.positionCd  = $("#position_cd").val();
		obj.deptCd      = $("#dept_cd").val();
		obj.bassAdres   = $("#bass_adres").val();
		obj.detailAdres = $("#detail_adres").val();
		obj.useAt       = $("input[name=system_use_slt1]:checked").val();
		obj.sbscrbTy    = "I";
		obj.enabledYn   = $("#enabledYn").val();
        var userCampaignList = new Array();

        $('input[id*="sstm_camp_"]').each(function(){
            if(this.checked == true){
                userCampaignList.push(this.value);
            }
        });
        obj.userCampaignList = userCampaignList;

		
		jsonObj.setSpUser = obj;

		$.ajax({url : "${pageContext.request.contextPath}/insertMenuAuthUserInfo",
			data : JSON.stringify(jsonObj),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
		}).success(function(result) {
			hidePopup("lyr_userAdd");
			$("#enabledYn").val("Y");
			//$('.lyrWrap').hide();
			alert("<spring:message code='A0589' text='등록이 완료되었습니다.'/>");
			var curPage = $("#contents .paging .list strong").text();
			userSearch(curPage);
			
		}).fail(function(result) {
			
		});
	}	
}
/** 선택한 USER 상세 조회 */
function selectDetailUser(userId) {
	$("#insUptType").val("update");
	$("#addType").val("U");
	$("#UserEdtForm")[0].reset();  //등록창 초기화
	$("#user_auth_ty > option").attr('selected', false);
	$("#pwText").remove();
	var obj = new Object();
	obj.ipt_srchId = userId;

	$.ajax({
		url : "${pageContext.request.contextPath}/getMenuGroupUserId",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(
			function(result) {
				var innerHtml = "";
				if(result[0].EMAIL != undefined){
					var email = result[0].EMAIL.split("@");
					
					$("#email2").val(email[1]);
					$("#email1").val(email[0]);
				}
				console.log(result[0].COMPANY_NAME);
				$("#user_id").val(result[0].USER_ID);  
				//$("#user_pw").val(result[0].USER_PW);  
				$("#user_pw").val("");
				$("#user_nm").val(result[0].USER_NM);  
				$("#brthdy").val(result[0].BRTHDY);
				
				$("#position_cd").val(result[0].POSITION_CD);
				$("#dept_cd").val(result[0].DEPT_CD);
				$("#company_id").val(result[0].COMPANY_ID);
				$("#company_name").val(result[0].COMPANY_NAME);
				$("#moblphon_no1").val(result[0].MOBLPHON_NO1);
				$("#moblphon_no2").val(result[0].MOBLPHON_NO2);
				$("#moblphon_no3").val(result[0].MOBLPHON_NO3);
				$("#bass_adres").val(result[0].BASS_ADRES); 
				$("#detail_adres").val(result[0].DETAIL_ADRES);
				$("#enabledYn").val(result[0].ENABLED_YN);
				
				$("#user_auth_ty option[value='" + result[0].USER_AUTH_TY + "']").prop('selected', true);

                if($("#user_auth_ty").val() == "A"){
                    $('input[name="user_camp_chk"]').attr("disabled", true);
                }else{
                    $('input[name="user_camp_chk"]').attr("disabled", false);
                }


				if (result[0].USE_AT == "Y") {
					$("input[name=system_use_slt1][id='pop_used']").prop('checked', true);
				} else {
					$("input[name=system_use_slt1][id='pop_not_used']").prop('checked', true);
				}
				
				if (result[0].SEXDSTN == "0") {
					$("input[name=sexdstn][id='id=male']").prop('checked', true);
				} else {
					$("input[name=sexdstn][id='female']").prop('checked', true);
				}
				
                $("#AuthGroup").empty();
                innerHtml += "<th><spring:message code='A0807' text='권한그룹' /></th>";
            	innerHtml += "<td colspan='3'>";
                innerHtml += "<select class='select' id='menu_auth_group'>";  
                innerHtml += "<option value=''><spring:message code='A0069' text='선택'/></option>";
                <c:forEach items="${MenuAuthGroup}" var="MenuAuthGroup">
                	if(${MenuAuthGroup.COMPANY_GROUP_ID} == result[0].COMPANY_GROUP_ID){
	                	innerHtml += "<option value='${MenuAuthGroup.COMPANY_GROUP_ID}' selected='selected'>${MenuAuthGroup.GOUP_NM}</option>";
                	}else {
	                	innerHtml += "<option value='${MenuAuthGroup.COMPANY_GROUP_ID}'>${MenuAuthGroup.GOUP_NM}</option>";
                	}
                </c:forEach> 
                innerHtml +="</select></td>";
                $("#AuthGroup").append(innerHtml);
				
				document.getElementById("user_id").readOnly = true;
				$("#id_Chk").hide();
				$("#chk_userid").val(result[0].USER_ID);

                //CM_COMPANY_USER_CAMPAIGNS의 User별 campaign 체크
                var userCampaignsList = result[1].userCampaignsList;
                // $('input[name="user_camp_chk"]').prop("checked", false);
                for(var i = 0; i < userCampaignsList.length; i++){
                    $('input[id*="sstm_camp_"]').each(function(){
                       if(userCampaignsList[i].campaignId == this.value){
                           this.checked = true;
                       }
                    });
                }
				openPopup("lyr_userAdd");
			}).fail(function(result) {
		console.log("회사명 상세조회 error");
	});
}

function resetPwLock(userID){
  var nowJson = {"idToCheck": userID}
  $.ajax({
    url: "resetPwLock",
    type:"post",
    data: JSON.stringify(nowJson),
    contentType: "application/json",
    success: function(data) {
      alert("아이디와 동일하게 비밀번호가 설정되었습니다. (" + userID + ")");
      $("#search").click();
    }
  })
}

/** INPUT TYPE NUMBER 글자수 제한 */
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }
}

function deleteUserInfo(){
	var count = $("input[name=sstm_menu_chk]:checked").length;
	var list = new Array();
	
	if(count > 0){
		for(var i = 0; i < count; i++){
			// 컬럼 순서 바뀌면 바뀐거에 맞게 잡아줘야됨
			var userId = $("input[name=sstm_menu_chk]:checked").parent().parent().next().next().eq(i).text();
			list.push(userId);
		}
	}
	console.log("list : " + list);
	
	var obj = new Object();
	obj.userId = list;

	$.ajax({
		url : "${pageContext.request.contextPath}/deleteMenuGroupUserInfo",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(
			function(result) {
				alert('<spring:message code="A0594" text="삭제가 완료되었습니다."/>');
				var curPage = $("#contents .paging .list strong").text();
				userSearch(curPage);
			}).fail(function(result) {
		console.log("삭제 error");
	});
}
</script>
</body>
</html>
