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
	            <!-- .content -->
	            <div class="content" id="super_admin">
	                <!-- .section -->
	                <div class="stn">
	                    <div class="tblBox_r"></div>
	                    <div class="tbl_top_info">                    
	                        <div class="condition_box">
	                            <div class="srch_group" style="width: auto;" >
	                                <span class="group_title"><spring:message code="A0544" text="권한유형"/></span>
	                                <div class="srchBox" id="srchBox">
	                                	 <select class="select" id="authTy">
			                                <option value="" selected="selected"><spring:message code="A0069" text="선택"/></option>
			                                <option value="S">SUPERADMIN</option>
			                                <option value="A">ADMIN</option>
			                                <!--<option value="N">CONSULTANT</option>-->
			                                <!--<option value="G">GUEST</option>-->
			                            </select>
	                                </div>
	                            </div>
	                            
	                            <div class="srch_group">
	                                <span class="group_title"><spring:message code="A0539" text="조건 선택"/></span>
	                                <div class="srchBox">
	                                    <select class="select" id="ipt_select1">
		                                    <option value="userNm" selected="selected"><spring:message code="A0032" text="이름"/></option>
	                                        <option value="userId"><spring:message code="A0031" text="아이디"/></option>
		                                    <option value="companyId"><spring:message code="A0533" text="회사ID"/></option>
		                                    <option value="companyNmKo"><spring:message code="A0313" text="회사명"/></option>
		                                    <option value="companyNmEn"><spring:message code="A0313" text="회사명"/>(<spring:message code="A0560" text="영문"/>)</option>
	                                    </select>
	                                    <input type="text" class="ipt_srch" placeholder="<spring:message code="A0558" text="검색어를 입력해주세요"/>" id="ipt_srchtxt" autocomplete="off">
	                                    <input style="opacity:0;pointer-events:none;"type="text" class="ipt_srch" placeholder="<spring:message code='A0558' text='검색어 입력'/>" id="ipt_txt" autocomplete="off">
	                                    <button type="submit" class="btn_srch" id="search"><spring:message code="A0180" text="검색"/></button>
	                                </div>
	                            </div>
	                        </div>
	                        
	                        <div class="btnBox sz_small">
	                            <!-- [D] 등록관련 UI script는 하단script 영역에 있음 -->
	                            <a href="#lyr_user_add" class="btnS_basic" id="addUser"><spring:message code="A0538" text="등록"/></a>
	                            <a class="btnS_basic btn_user_dlt" id="deleteUser"><spring:message code="A0541" text="삭제"/></a>
	                        </div>
	                    </div>
	                    
	                    <div class="tbl_box user_lst">
	                        <table summary="No, 이름, 아이디, 회사 ID, 회사명, 연락처, 권한유형, 등록일로 구성됨">
	                            <caption class="hide">사용자 리스트</caption> 
	                            <colgroup>
	                                <col><col><col><col>
	                                <col><col><col><col><col><col>
	                                <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
	                            </colgroup>
	                            
	                            <thead>
	                                <tr>
	                                    <th>
	                                        <div class="checkBox">
	                                            <input type="checkbox" name="sstm_menu_chk" id="total_chk" class="checking ipt_tbl_allCheck">
	                                            <label for="total_chk"></label>
	                                        </div>
	                                    </th>
	                                    <th><spring:message code="A0135" text="No."/></th>
	                                    <th><spring:message code="A0032" text="이름"/></th>
	                                    <th><spring:message code="A0031" text="아이디"/></th>
	                                    <th><spring:message code="A0533" text="회사 ID"/></th>
	                                    <th><spring:message code="A0313" text="회사명"/></th>
	                                    <th><spring:message code="A0313" text="회사명"/>(<spring:message code="A0560" text="영문" />)</th>
	                                    <th><spring:message code="A0074" text="연락처"/></th>
	                                    <th><spring:message code="A0544" text="권한유형"/></th>
	                                    <th><spring:message code="A0542" text="등록일"/></th>
										<th scope="col"><spring:message code="A0980" text="잠김" />
											<div class="help">?<div class="help_desc"><i><spring:message code="A0983" text="잠김 툴팁" /></i></div></div>
										</th>
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
	            <!-- //.content -->
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
<!-- 사용자 등록 -->  
<div id="lyr_user_add" class="lyrBox lyr_super">
    <div class="lyr_top">
        <h3><spring:message code="A0013" text="사용자 관리 "/></h3>
        <button class="btn_lyr_close"><span class="fas fa-times"></span></button>
     </div>
    <div class="lyr_mid">        
        <div class="info_edit_tbl">
	        <form id="UserEdtForm">
	            <table>
	                <colgroup>
	                    <col width="115"><col><col width="115"><col>
	                </colgroup>
	                
	                <tbody>
	                    <tr>
	                        <th><em>*</em><spring:message code="A0313" text="회사명"/>&sol;<spring:message code="A0533" text="회사ID"/></th>
	                        <td colspan="3">
	                            <div class="iptBox">
	                                <input type="text" class="ipt_txt" id="company_name" name="company_name" readonly="readonly">        
	                            </div> 
	                            <div class="iptBox short">
	                                <input type="text" class="ipt_txt" id="company_id" name="company_id" readonly="readonly">        
	                                <button type="button" class="btn_srch btn_company_srch"><spring:message code="A0545" text="조회"/></button>
	                            </div>                                              
	                        </td>
	                    </tr>
	                    <tr>
	                        <th><em>*</em><spring:message code="A0547" text="사용자ID"/></th>
	                        <td>
	                            <div class="iptBox short">
	                            	<input type="hidden" id="chk_userid" name="chk_userid">
	                                <input type="text" class="ipt_txt" id="user_id" name="user_id" autocomplete="off">
	                                <input style="display: none; opacity: 0; pointer-events:none;" type="text" class="ipt_txt" id="user_id" autocomplete="off">
	                                <button type="button" class="btn_srch name_chk" id="id_Chk"><spring:message code="A0546" text="중복확인"/></button>
	                            </div>
	                        </td>
	                        <th><spring:message code="A0033" text="비밀번호"/></th>
	                        <td>
	                            <div class="iptBox">
	                                <input style="display: none; opacity: 0; pointer-events:none;" type="password" class="ipt_txt" id="user_pw1" name="user_pw1" autocomplete="off">                   
	                                <input type="hidden" class="ipt_txt" id="user_pw" name="user_pw" autocomplete="off">
	                                <button type="button" class="btn_srch password_reset" id="password_reset"><spring:message code="A0845" text="비밀번호 초기화" /></button>                   
	                            </div> 
	                        </td>
	                    </tr>
	                    <tr>
	                        <th><em>*</em><spring:message code="A0544" text="권한유형"/></th>
	                        <td>
	                            <select class="select user_type" id="user_auth_ty">  
	                                <option value="" selected="selected"><spring:message code="A0069" text="선택"/></option> 
	                                <option value="S">SUPERADMIN</option>
	                                <option value="A">ADMIN</option>
	                                <!--<option value="N">CONSULTANT</option>-->
	                                <!--<option value="G">GUEST</option>-->
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
	                        <th><em>*</em><spring:message code="A0032" text="이름"/></th>
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
	                        <th><spring:message code="A0048" text="이메일"/></th>
	                        <td>
	                            <div class="iptBox mail">
	                                <input type="text" class="ipt_txt" id="email1" name="email1"> &commat;               
	                            </div>
	                            <div class="iptBox mail">
	                                <input type="text" class="ipt_txt" id="email2" name="email2">                  
	                            </div>
	                            <select class="select mail" id="selectBoxMail"> 
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
	                        </td>
	                        <th><spring:message code="A0553" text="휴대폰 번호"/></th>
	                        <td>
	                            <div class="iptBox three_box">
	                                <input type="number" class="ipt_txt" id="moblphon_no1" name="moblphon_no1" maxlength="3" oninput="maxLengthCheck(this)"> -                 
	                            </div>
	                            <div class="iptBox three_box">
	                                <input type="number" class="ipt_txt" id="moblphon_no2" name="moblphon_no2" maxlength="4" oninput="maxLengthCheck(this)"> -                
	                            </div>
	                            <div class="iptBox three_box">
	                                <input type="number" class="ipt_txt" id="moblphon_no3" name="moblphon_no3" maxlength="4" oninput="maxLengthCheck(this)">                  
	                            </div>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th><spring:message code="A0554" text="직급"/></th>
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
	                        <th><spring:message code="A0816" text="주소"/></th>
	                        <td colspan="3">
	                            <div class="iptBox long">
	                                <input type="text" class="ipt_txt" id=bass_adres name="bass_adres"> 
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
	                        <th><em>*</em><spring:message code="A0557" text="사용여부"/></th>
	                        <td colspan="3">
	                            <div class="radioBox">
	                                <input type="radio" name="system_use_slt" id="used" checked="checked" value="Y">
	                                <label for="used"><spring:message code="A0535" text="사용"/></label>
	                                <input type="radio" name="system_use_slt" id="not_used" value="N">
	                                <label for="not_used"><spring:message code="A0536" text="미 사용"/></label>
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
            <button class="btn_lyr_close"><spring:message code="A0532" text="취소"/></button>
            <button id="insertUser"><spring:message code="A0320" text="저장"/></button>            
        </div>
    </div>
</div>
<!-- //사용자 등록 -->

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

<!-- 회사 검색 팝업 -->
<div id="lyr_company_srch" class="lyrBox lyr_super lyr_alert">
    <div class="lyr_top">
        <h3><spring:message code="A0313" text="회사명"/>&sol;<spring:message code="A0533" text="회사ID"/> <spring:message code="A0180" text="검색"/></h3>
        <button class="btn_close"><span class="fas fa-times"></span></button>
     </div>
    <div class="lyr_mid">
        <div class="srchBox">
            <select class="select" id="ipt_select2"> 
                <option value="companyKoNm" selected="selected"><spring:message code="A0313" text="회사명"/></option> 
                <option value="companyEnNm"><spring:message code="A0313" text="회사명"/>(<spring:message code="A0560" text="영문"/>)</option> 
		        <option value="companyId"><spring:message code="A0533" text="회사ID"/></option> 
            </select>
            <input type="text" class="ipt_srch" placeholder="<spring:message code="A0558" text="검색어를 입력해주세요"/>" id="srchCompTxt" onkeydown="enterSearch(event);">
            <button type="submit" class="btn_srch" id="srchComp"><spring:message code="A0180" text="검색"/></button>
        </div>
        
        <div class="company_lst">
            <table>
                <colgroup>
                    <col><col><col><col>
                </colgroup>
                
                <thead>
                    <tr>
                        <th><spring:message code="A0069" text="선택"/></th>
                        <th><spring:message code="A0313" text="회사명"/></th>
                        <th><spring:message code="A0313" text="회사명"/>(<spring:message code="A0560" text="영문"/>)</th>
                        <th><spring:message code="A0533" text="회사ID"/></th>
                    </tr>
                </thead>
                
                <tbody>
                    <tr>
                        <td scope='row' colspan='4' class='data_none'><spring:message code="A0257" text="등록된 데이터가 없습니다."/></td>
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
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button class="btn_close"><spring:message code="A0532" text="취소"/></button>
            <button id="selectComp"><spring:message code="A0320" text="저장"/></button>              
        </div>
    </div>
</div>
<!-- //회사 검색 팝업 -->

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
        $('#lyr_user_add .btn_company_srch').on('click',function(){
        	//openPopup("lyr_company_srch"); 
        	$("#srchCompTxt").val('');
        	$('#lyr_company_srch').css('display', 'block');
        	srchComp(1);
        });
      
        $('#lyr_user_add .name_chk').on('click',function(){
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
        	$("#addType").val("I");
        	$("#pwText").remove();
        	document.getElementById("user_id").readOnly = false;
        	$("#id_Chk").show();
        	openPopup("lyr_user_add");
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
	});
});	


/** 조회  */
function userSearch(currentPage) {
	var lang = $.cookie("lang");

	var obj = new Object();
	obj.page = currentPage;
	//obj.rdoVal = $("input[name=system_use_slt]:checked").val();
	obj.ipt_select = $("#ipt_select1 option:selected").val(); // 조건선택 selectbox 
	obj.ipt_srchtext = $("#ipt_srchtxt").val();
	obj.authTy = $("#authTy option:selected").val();
	obj.rowNum = 20;
	obj.offset = (obj.page * obj.rowNum) - obj.rowNum;

	$.ajax({url : "${pageContext.request.contextPath}/getSUPERUserList",
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
				frontMnt : "frontMnt",
			},
		}).success(function(result) {
				console.log(result);

				var jObj = JSON.parse(result);
				var jSPUList = jObj.superUserList;
				var jPaging = jObj.paging;

				console.log(jPaging);

				inerHtml = "";
				pagingHtml = "";

				if (jSPUList.length > 0) {
					for ( var key in jSPUList) {
						console.log("key : " + key);
						console.log("value : " + JSON.stringify(jSPUList[key]));
						
						inerHtml += "<tr><td><div class='checkBox'><input type='checkbox' name='sstm_menu_chk' id='user_chk" + (parseInt(key) + parseInt(JSON.stringify(jPaging.startRow)) + 1) + "' class='checking ipt_check'><label for='user_chk" + (parseInt(key) + parseInt(JSON.stringify(jPaging.startRow)) + 1) + "'></label></div></td>";
						inerHtml += "<td>" + (parseInt(key) + parseInt(JSON.stringify(jPaging.startRow)) + 1) + "</td>";
						
						if (JSON.stringify(jSPUList[key].USER_NM) == null) {
							inerHtml += "<td>-</td>";
						} else {
							inerHtml += "<td>" + JSON.stringify(jSPUList[key].USER_NM).replace(/\"/g, "") + "</td>";
						}
						
						inerHtml += "<td><a href='javascript:selectDetailUser(" + JSON.stringify(jSPUList[key].USER_ID) + ")' class='btn_lyr_open'>"+ JSON.stringify(jSPUList[key].USER_ID).replace(/\"/g, "") + "</a></td>";
						inerHtml += "<td>" + JSON.stringify(jSPUList[key].COMPANY_ID).replace(/\"/g, "") + "</td>";
						inerHtml += "<td>" + JSON.stringify(jSPUList[key].COMPANY_NAME).replace(/\"/g, "") + "</td>";
						if(jSPUList[key].COMPANY_NAME_EN != null && jSPUList[key].COMPANY_NAME_EN != ""){
							inerHtml += "<td>" + jSPUList[key].COMPANY_NAME_EN + "</td>";
						}else {
							inerHtml += "<td>-</td>";
						}
						if (JSON.stringify(jSPUList[key].MOBLPHON_NO) == null || jSPUList[key].MOBLPHON_NO == "--") {
							inerHtml += "<td>-</td>";
						} else {
							inerHtml += "<td>" + JSON.stringify(jSPUList[key].MOBLPHON_NO).replace(/\"/g, "") + "</td>";
						}
						
						if(lang == "en"){
							if(jSPUList[key].USER_AUTH_TY == "S"){
								inerHtml += "<td>SuperAdmin</td>";
							}else if(jSPUList[key].USER_AUTH_TY == "A"){
								inerHtml += "<td>Admin</td>";
							}else if(jSPUList[key].USER_AUTH_TY == "N"){
								inerHtml += "<td>Consultant</td>";
							}else{
								inerHtml += "<td>Guest</td>";
							}
						}else{
							inerHtml += "<td>" + jSPUList[key].USER_AUTH_NM + "</td>";
						}
						
						
						inerHtml += "<td>" + JSON.stringify(jSPUList[key].REGIST_DT).replace(/\"/g, "") + "</td>";

						if (jSPUList[key].nowLock == null) {
							inerHtml += "<td style=\"color:#14C26F\"><spring:message code='A0982' text='정상' /></td></tr>";
						} else {
							inerHtml += "<td><div class='btnBox'><a class='btn_lyr_open'  style=\"color:#EC3C3C; width:90px\" onclick='javascript:resetPwLock(" + JSON.stringify(jSPUList[key].USER_ID) + ")'><spring:message code='A0981' text='잠금해제' /></a></div></td></tr>";;
						}
					}

					console.log("key : " + JSON.stringify(jPaging.currentPage));

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
					inerHtml += "<tr><td scope='row' colspan='9' class='data_none'><spring:message code='A0257' text='등록된 데이터가 없습니다.'/></td></tr>";
					pagingHtml += "<div class='tbl_path'><spring:message code='A0172' text='전체'/><strong> <strong>1</strong> / 0</div>";
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
		var innerHTML = "<span>" + $("#user_id").val() + "</span><spring:message code='A0818' text='은 사용 가능한 아이디 입니다.' />";
		$("#lyr_infomation .lyr_cont").find('p').empty();
		$("#lyr_infomation .lyr_cont").find('p').append(innerHTML);

		$("#user_pw").focus();
		$("#checkId").val(true);
	}
}

function saveUser(){
	var checkYn = false;
	
	// 회사명/회사ID 체크
	if($("#company_id").val() == ""){
		alert("<spring:message code='A0596' text='회사명/회사ID를 입력주세요'/>");
		return;
	} else {
		checkYn = true;
	}
	
	// 사용자ID 체크
	if($("#user_id").val() == ""){
		alert("<spring:message code='A0595' text='사용자ID를 입력해주세요.'/>");
		return;
	} else {
		checkYn = true;
	}
	
	// 중복체크 확인
	if ($("#checkId").val() == "false") {
		if($("#addType").val() == "I"){
			alert("<spring:message code='A0588' text='중복체크를 해주세요'/>");	
			return;
		}
	} else {
		checkYn = true;
	}

	// 중복체크한 ID와 input text에 입력된 ID 같은지 체크
	if($("#chk_userid").val() == $("#user_id").val()){
		checkYn = true;
	}  else {
		if($("#addType").val() == "U"){
			alert("<spring:message code='A0597' text='등록한 ID와 다릅니다.'/>");
			return;
		} else {
			alert("<spring:message code='A0598' text='중복체크한 ID와 다릅니다.'/>");
			return;
		}
	}
	
	// 비밀번호 체크
	/* if($("#user_pw").val() == ""){
		alert("<spring:message code='A0599' text='비밀번호를 입력해주세요'/>");
		return;
	} else {
		checkYn = true;
	} */
	
	// 비밀번호 체크
	if($("#insUptType").val() == "insert"){
		if($("#user_pw").val() == ""){
			alert("<spring:message code='A0841' text='비밀번호 초기화 버튼을 클릭해주세요.' />");
			return;
		}else{
	 		checkYn = true;
		}
	} 
// 	if($("#user_pw").val() != null && $("#user_pw").val() != ""){
// 		if($("#user_pw").val().length <= 8 || $("#user_pw").val().length >= 16){
// 			alert("<spring:message code='A0838' text='비밀번호 8자리 이상 16자리 이하로 입력해주세요.' />");
// 			return;
// 		}else{
// 			checkYn = true;
// 		}
// 		var pwCheck = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,16}$/; 
// 		if(!pwCheck.test($("#user_pw").val())){
// 			alert("<spring:message code='A0839' text='영문,숫자,특수문자의 조합으로 입력해주세요.' />");
// 			return;
// 		}else{
// 			checkYn = true;
// 		}
// 	}
	
	
	// 권한유형 체크
	if($("#user_auth_ty").val() == ""){
		alert("<spring:message code='A0837' text='권한유형을 선택해주세요.' />");
		return;
	} else {
		checkYn = true;
	}
	
	// 이름 체크
	if($("#user_nm").val() == ""){
		alert("<spring:message code='A0821' text='이름을 입력해주세요.' />");
		return;
	} else {
		checkYn = true;
	}
	
	return checkYn;
}
/** 등록  저장  */
function insertUserInfo() {
	if(saveUser()){

		var obj = new Object();
		var jsonObj = new Object();

		obj.companyId = $("#company_id").val();
		
		obj.userId = $("#user_id").val();
		obj.userPw = $("#user_pw").val();
		obj.userNm = $("#user_nm").val();
		
		obj.userAuthTy = $("#user_auth_ty option:selected").val(); // 조건선택 selectbox 
		obj.sexdstn    = $("input[name=sexdstn]:checked").val();
		obj.brthdy     = $("#brthdy").val();
		
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
		obj.useAt       = $("input[name=system_use_slt]:checked").val();
		obj.sbscrbTy    = "I";
		obj.enabledYn   = $("#enabledYn").val();
		
		jsonObj.setSpUser = obj;

		$.ajax({url : "${pageContext.request.contextPath}/insertUserInfo",
			data : JSON.stringify(jsonObj),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
		}).success(function(result) {
			hidePopup("lyr_user_add");
			$("#enabledYn").val("Y");
			//$('.lyrWrap').hide();
			alert("<spring:message code='A0589' text='등록이 완료되었습니다.'/>");
			var curPage = $("#contents .paging .list strong").text();
			userSearch(curPage);
			
		}).fail(function(result) {
			
		});
	}	
}

function srchComp(currentPage){
	var obj = new Object();
	obj.page = currentPage;
	obj.rdoVal = "useY";
	obj.ipt_select = $("#ipt_select2 option:selected").val(); // 조건선택 selectbox 
	obj.ipt_text = $("#srchCompTxt").val();
	obj.rowNum = 10;
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
				frontMnt : "frontMnt",
			},
		}).success(function(result) {
				console.log(result);

				var jObj = JSON.parse(result);
				var jSPUList = jObj.superCompList;
				var jPaging = jObj.paging;

				console.log(jPaging);

				inerHtml = "";
				pagingHtml = "";

				if (jSPUList.length > 0) {
					for ( var key in jSPUList) {
						console.log("key : " + key);
						console.log("value : " + JSON.stringify(jSPUList[key]));
						
						inerHtml += "<tr><td><div class='checkBox'><input type='checkbox' name='company_srch_lst' id='company_chk" + (parseInt(key) + parseInt(JSON.stringify(jPaging.startRow)) + 1) + "' class='checking ipt_check'><label for='company_chk" + (parseInt(key) + parseInt(JSON.stringify(jPaging.startRow)) + 1) + "'></label></div></td>";			
						inerHtml += "<td class='companyNmKo'>" + JSON.stringify(jSPUList[key].COMPANY_NAME).replace(/\"/g, "") + '</td>';
						if(jSPUList[key].COMPANY_NAME_EN == null){
							inerHtml += "<td class='companyNmEn'>-</td>"
						}else{
							inerHtml += "<td class='companyNmEn'>" + JSON.stringify(jSPUList[key].COMPANY_NAME_EN).replace(/\"/g, "") + '</td>';
						}
						inerHtml += "<td class='companyId'>" + JSON.stringify(jSPUList[key].COMPANY_ID).replace(/\"/g, "") + '</td></tr>';
					}

					console.log("key : " + JSON.stringify(jPaging.currentPage));

					pagingHtml += "<div class='tbl_path'><spring:message code='A0172' text='전체'/><strong> <strong>" + JSON.stringify(jPaging.currentPage) + "</strong> / " + JSON.stringify(jPaging.totalPage) + "</div>";
					pagingHtml += "<div class='paging'>";
					pagingHtml += "<a class='btn_paging_prev' href='javascript:srchComp(" + JSON.stringify(jPaging.prevPage) + ")' ><spring:message code='A0580' text='이전 페이지로 이동 '/></a>";
					pagingHtml += "<span class='list'>";

					for (var i = JSON.stringify(jPaging.pageRangeStart); i <= JSON.stringify(jPaging.pageRangeEnd); i++) {
						if (JSON.stringify(jPaging.currentPage) == i) {
							pagingHtml += "<strong>" + i + "</strong>";
						} else {
							pagingHtml += "<a href='javascript:srchComp(" + i + ")'>" + i + "</a>";
						}
					}

					pagingHtml += "</span>";
					pagingHtml += "<a class='btn_paging_next' href='javascript:srchComp(" + JSON.stringify(jPaging.nextPage) + ")'><spring:message code='A0581' text='다음 페이지로 이동 '/></a>";
					pagingHtml += "</div>";

				} else {
					inerHtml += "<tr><td scope='row' colspan='4' class='data_none'><spring:message code='A0257' text='등록된 데이터가 없습니다.'/></td></tr>";
					pagingHtml += "<div class='tbl_path'><spring:message code='A0172' text='전체'/><strong> <strong>1</strong> / 0</div>";
					pagingHtml += "<div class='paging'>";
					pagingHtml += "<a class='btn_paging_prev' href='#none' ><spring:message code='A0580' text='이전 페이지로 이동 '/></a>";
					pagingHtml += "<span class='list'>";
					pagingHtml += "<strong>1</strong>";
					pagingHtml += "</span>";
					pagingHtml += "<a class='btn_paging_next' href='#none'><spring:message code='A0581' text='다음 페이지로 이동 '/></a>";
					pagingHtml += "</div>";
				}

				$(".company_lst").find('tbody').empty();
				$(".company_lst").find('tbody').append(inerHtml);

				$("#lyr_company_srch .tbl_btm_info").empty();
				$("#lyr_company_srch .tbl_btm_info").append(pagingHtml);

				//radio버튼처럼 checkbox name값 설정
			    $("input[type='checkbox'][name='company_srch_lst']").click(function(){
			        //click 이벤트가 발생했는지 체크
			        if ($(this).prop('checked')) {
			            //checkbox 전체를 checked 해제후 click한 요소만 true지정
			            $('input[type="checkbox"][name="company_srch_lst"]').prop('checked', false);
			            $(this).prop('checked', true);
			        }
			    });
			}).fail(function(result) {
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

/** 선택한 회사정보 보내기 */
function chkSelectComp(){
	
	// 컬럼 순서 바뀌면 맞춰줘야 함
	// 컬럼 순서 바뀌면 맞춰줘야 하는게 아니고 컬럼순서가 바뀌어도 동작할 수 있도록 명시적으로 선언을 해야하죠...
	var compNm =$("input[name=company_srch_lst]:checked").parents("tr").find("td.companyNmKo").text()
	var compId = $("input[name=company_srch_lst]:checked").parents("tr").find("td.companyId").text()
	$("#company_name").val(compNm);
	$("#company_id").val(compId);
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
		url : "${pageContext.request.contextPath}/getUserId",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(
			function(result) {
				if(result[0].EMAIL != undefined){
					var email = result[0].EMAIL.split("@");
					
					$("#email2").val(email[1]);
					$("#email1").val(email[0]);
				}
				
				console.log(result[0].COMPANY_NAME);
				$("#user_id").val(result[0].USER_ID);  
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

				if (result[0].USE_AT == "Y") {
					$("input[name=system_use_slt][id='used']").prop('checked', true);
				} else {
					$("input[name=system_use_slt][id='not_used']").prop('checked', true);
				}
				
				if (result[0].SEXDSTN == "0") {
					$("input[name=sexdstn][id='id=male']").prop('checked', true);
				} else {
					$("input[name=sexdstn][id='female']").prop('checked', true);
				}
				document.getElementById("user_id").readOnly = true;
				$("#id_Chk").hide();
				$("#chk_userid").val(result[0].USER_ID);
				openPopup("lyr_user_add");
			}).fail(function(result) {
		console.log("회사명 상세조회 error");
	});
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
			var userId = $("input[name=sstm_menu_chk]:checked").parent().parent().next().next().next().eq(i).text();
			list.push(userId);
		}
	}
	console.log("list : " + list);
	
	var obj = new Object();
	obj.userId = list;

	$.ajax({
		url : "${pageContext.request.contextPath}/deleteUserInfo",
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
