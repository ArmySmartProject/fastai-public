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
		
		<!-- #header -->
		<jsp:include page="../common/inc_header.jsp">
			<jsp:param name="titleCode" value="A0630"/>
			<jsp:param name="titleTxt" value="메뉴 그룹 권한관리"/>
		</jsp:include>
		<!-- //#header -->
		
		<!-- #container -->
		<div id="container">
	        <!-- #contents -->
	        <div id="contents">
	            <div id="super_admin" class="content">
                <!-- .section -->
                <div class="stn">
                    <div class="tblBox_r"></div>
                    <div class="tbl_top_info">                    
                        <div class="condition_box"> 
                            <div class="srch_group">
                            	<input type="hidden" id="companyGroupId" value="">
                                <span class="group_title"><spring:message code="A0810" text="그룹검색" /> </span>
                                <div class="srchBox">
                                    <input type="text" class="ipt_srch" placeholder="<spring:message code="A0558" text="검색어를 입력"/>" id="ipt_srchtxt">
                                    <input type="text" class="ipt_srch" placeholder="<spring:message code="A0558" text="검색어를 입력"/>" id="ipt_srchtxt" style="opacity: 0; pointer-events: none;">
	                                <button type="submit" class="btn_srch" id="search"><spring:message code="A0180" text="검색"/></button>
                                </div>                                
                            </div>
                        </div>
                        
                        <div class="btnBox sz_small line">
                            <!-- [D] 등록관련 UI script는 하단script 영역에 있음 -->
                            <a class="btnS_basic btn_lyr_open" id="addMenuGoup" onclick="addMenuGroup();"><spring:message code="A0538" text="등록"/></a>
                            <a href="#none" class="btnS_basic btn_clr" id="deleteMenuGroup" onclick="deleteMenuGroup();"><spring:message code="A0541" text="삭제"/></a>     
                        </div>
                    </div>
                    
                    <div class="tbl_box">
                        <table summary="No, 그룹명, 그룹설명, 등록자, 등록일,수정자,수정일,수정으로 구성됨">
                            <colgroup>
                                <col width="60">
                                <col>
                                <col>
                                <col width="200">
                                <col width="120">
                                <col width="200">
                                <col width="120">
                                <col width="100">
                                <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                            </colgroup>                            
                            <thead>
                                <tr>
                                    <th scope="col">
                                        <div class="checkBox">
                                            <input type="checkbox" id="ipt_check00" name="sstm_allGroup_chk" class="ipt_check">
                                            <label for="ipt_check00"><spring:message code="A0135" text="No."/></label>
                                        </div>                                        
                                    </th>
                                    <th scope="col"><spring:message code="A0811" text="그룹명" /></th>
                                    <th scope="col"><spring:message code="A0815" text="메뉴설명" /></th>
                                    <th scope="col"><spring:message code="A0813" text="등록자" /></th>
                                    <th scope="col"><spring:message code="A0542" text="등록일" /></th>
                                    <th scope="col"><spring:message code="A0808" text="수정자" /></th>
                                    <th scope="col"><spring:message code="A0574" text="수정자" /></th>
                                    <th scope="col"><spring:message code="A0809" text="수정" /></th>
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
<!-- 메뉴 그룹 등록 -->
<div id="lyr_menuAdd" class="lyrBox" style="width:700px;">
    <div class="lyr_top">
        <h3><spring:message code="A0630" text="메뉴 그룹  권한관리 "/></h3>
        <button class="btn_lyr_close"><spring:message code="A0631" text="닫기" /></button>
     </div>
    <div class="lyr_mid" style="max-height: 527px;">
        <div class="lotBox">
            <div class="lot_half">
                <p class="infoTxt"><spring:message code="A0814" text="사용할 그룹을 등록해주세요." /></p>
                <div class="tblBox">
                    <table class="tbl_line_view2" summary="그룹명,그룹설명으로 구성됨">
                    <caption class="hide">내용입력</caption>
                    <colgroup>
                        <col width="70"><col>    
                    </colgroup>
                    <tbody>
                        <tr>
                            <th scope="row"><em class="ft_clr_1st">*</em><spring:message code="A0811" text="그룹명" /></th>
                            <td>
                                <div class="iptBox">
                                    <input type="text" class="ipt_txt" id="insGroupNm">
                                </div>
                            </td>
                        </tr>   
                        <tr>
                            <th scope="row"><spring:message code="A0815" text="그룹설명" /></th>
                            <td>
                                <div class="textareaBox">
                                    <textarea class="textArea" style="height:234px;" id="insGroupExp"></textarea>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                    </table>
                </div>
                <p class="infoTxt"><em class="ft_clr_1st">*</em><spring:message code="A0583" text="는 필수 입력 사항 입니다." /></p>
            </div>
            <div class="lot_half">
                <p class="infoTxt"><spring:message code="A0585" text="사용할 시스템(메뉴)를 선택하세요."/></p>
                <div class="menu_slt_chk">
	        	<div class="lst_hd">
	                <div class="checkBox">
	                    <input type="checkbox" name="sstm_menu_chk" id="total_chk1" class="checking all_sstm_menu ins_all_sstm_menu">
	                    <label for="total_chk1"></label>
	                </div>
	                <div class="menu_name"><spring:message code="A0569" text="메뉴 명"/></div>
            	</div>
				<ul class="lst_bd menu_lst">
				<c:forEach var="menu1" items="${menuLinkedMap}" varStatus="status">
					<c:set var="menu1" value="${menu1.value}"/>
					<c:if test="${empty menu1.topMenuCode}">
						<li onclick="firstMenu(event);">
							<div class="checkBox">
			                    <input type="checkbox" name="sstm_menu_chk" id="sstm_${menu1.menuCode}" class="checking ipt_check ins_ipt_check" value="${menu1.menuCode}">
			                    <label for="sstm_${menu1.menuCode}"></label>
				            </div>
							<div class="menu_name">
								<a href="#none">${lang=="en"?menu1.menuNmEn:menu1.menuNmKo}<span class="menu1 fas fa-caret-up"></span></a>
							</div>
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
									<li onclick="subMenu(event);" class="${menu2.menuOnImage} ${arrow} ${selected}">
										<div class="checkBox">
					                        <input type="checkbox" name="sstm_menu_chk" id="sstm_${menu2.menuCode}" class="checking ipt_check ins_ipt_check" value="${menu2.menuCode}">
					                        <label for="sstm_${menu2.menuCode}"></label>
					                    </div>
										<div class="menu_name">
											<a href="#none">${lang=="en"?menu2.menuNmEn:menu2.menuNmKo}<span class="menu2 fas fa-caret-up"></span></a>
										</div>
										<c:if test="${not empty menu2.menuLinkedMap}">
											<ul class="third">
												<c:forEach var="menu3" items="${menu2.menuLinkedMap}" varStatus="status">
													<c:set var="menu3" value="${menu3.value}"/>
													<li onclick="thirdMenu(event);">
							                           <div class="checkBox">
					                                        <input type="checkbox" name="sstm_menu_chk" id="sstm_${menu3.menuCode}" class="checking ipt_check ins_ipt_check" value="${menu3.menuCode}">
					                                        <label for="sstm_${menu3.menuCode}"></label>
					                                    </div>
							                            <div class="menu_name">
								                            <a href="#none">${lang=="en"?menu3.menuNmEn:menu3.menuNmKo}</a>
							                            </div>
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
        </div>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">            
            <button id="insertMenuGroup" onclick="insertMenuGroup();"><spring:message code="A0320" text="저장"/></button>  
            <button class="btn_lyr_close"><spring:message code="A0532" text="취소"/></button>
        </div>
    </div>
</div>  

<!-- 메뉴 그룹 수정 -->
<div id="lyr_userModify" class="lyrBox" style="width:700px;">
    <div class="lyr_top">
        <h3><spring:message code="A0630" text="메뉴 그룹  권한관리 "/></h3>
        <button class="btn_lyr_close"><spring:message code="A0631" text="닫기" /></button>
     </div>
    <div class="lyr_mid" style="max-height: 527px;">
        <div class="lotBox">
            <div class="lot_half">
                <p class="infoTxt"><spring:message code="A0814" text="사용할 그룹을 등록해주세요." /></p>
                <div class="tblBox">
                    <table class="tbl_line_view2" summary="그룹명,그룹설명으로 구성됨">
                    <caption class="hide">내용입력</caption>
                    <colgroup>
                        <col width="70"><col>    
                    </colgroup>
                    <tbody>
                        <tr>
                            <th scope="row"><em class="ft_clr_1st">*</em><spring:message code="A0811" text="그룹명" /></th>
                            <td>
                                <div class="iptBox">
                                    <input type="text" class="ipt_txt" id="edtGroupNm">
                                </div>
                            </td>
                        </tr>   
                        <tr>
                            <th scope="row"><spring:message code="A0815" text="그룹설명" /></th>
                            <td>
                                <div class="textareaBox">
                                    <textarea class="textArea" style="height:234px;" id="edtGroupExp"></textarea>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                    </table>
                </div>
                <p class="infoTxt"><em class="ft_clr_1st">*</em><spring:message code="A0583" text="는 필수 입력 사항 입니다." /></p>
            </div>
            <div class="lot_half">
                <p class="infoTxt"><spring:message code="A0585" text="사용할 시스템(메뉴)를 선택하세요."/></p>
                <div class="menu_slt_chk">
	        	<div class="lst_hd">
	                <div class="checkBox">
	                    <input type="checkbox" name="sstm_menu_chk" id="total_chk2" class="checking all_sstm_menu edt_all_sstm_menu">
	                    <label for="total_chk2"></label>
	                </div>
	                <div class="menu_name"><spring:message code="A0569" text="메뉴 명"/></div>
            	</div>
	        
				<ul class="lst_bd menu_lst">
				<c:forEach var="menu1" items="${menuLinkedMap}" varStatus="status">
					<c:set var="menu1" value="${menu1.value}"/>
					<c:if test="${empty menu1.topMenuCode}">
						<li onclick="firstMenu(event);">
							<div class="checkBox">
			                    <input type="checkbox" name="sstm_menu_chk" id="edt_sstm_${menu1.menuCode}" class="checking ipt_check edt_ipt_check" value="${menu1.menuCode}">
			                    <label for="edt_sstm_${menu1.menuCode}"></label>
				            </div>
							<div class="menu_name">
								<a href="#none">${lang=="en"?menu1.menuNmEn:menu1.menuNmKo}<span class="menu1 fas fa-caret-up"></span></a>
							</div>
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
									<li onclick="subMenu(event);" class="${menu2.menuOnImage} ${arrow} ${selected}">
										<div class="checkBox">
					                        <input type="checkbox" name="sstm_menu_chk" id="edt_sstm_${menu2.menuCode}" class="checking ipt_check edt_ipt_check" value="${menu2.menuCode}">
					                        <label for="edt_sstm_${menu2.menuCode}"></label>
					                    </div>
										<div class="menu_name">
												<a href="#none">${lang=="en"?menu2.menuNmEn:menu2.menuNmKo}<span class="menu2 fas fa-caret-up"></span></a>
										</div>
										<c:if test="${not empty menu2.menuLinkedMap}">
											<ul class="third">
												<c:forEach var="menu3" items="${menu2.menuLinkedMap}" varStatus="status">
													<c:set var="menu3" value="${menu3.value}"/>
													<li onclick="thirdMenu(event);">
							                           <div class="checkBox">
					                                        <input type="checkbox" name="sstm_menu_chk" id="edt_sstm_${menu3.menuCode}" class="checking ipt_check edt_ipt_check" value="${menu3.menuCode}">
					                                        <label for="edt_sstm_${menu3.menuCode}"></label>
					                                    </div>
							                            <div class="menu_name">
								                            <a href="#none">${lang=="en"?menu3.menuNmEn:menu3.menuNmKo}</a>
							                            </div>
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
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">            
            <button id="updateMenuGroup" onclick="updateMenuGroup();"><spring:message code="A0320" text="저장"/></button> 
            <button class="btn_lyr_close"><spring:message code="A0532" text="취소"/></button>
        </div>
    </div>
</div>
</div>

<%@ include file="../common/inc_footer.jsp"%>
  
<script type="text/javascript">   
$(window).load(function() { 
    //page loading delete  
	$('#pageldg').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });
    
	//첫 화면 이동 시 조회
	MenuGroupSearch(1);
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
      
        $('.lyr_alert .btn_close').on('click',function(){
            $('.lyr_alert').hide();
        });
        
        $("#search").on("click", function(){
        	MenuGroupSearch(1);
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
       
	   //등록 팝업 전체 체크       
       $('.ins_all_sstm_menu').click(function(){
     	  if($('.ins_all_sstm_menu').prop('checked')){
              $('.ins_ipt_check').prop('checked',true);
              $('.menu_slt_chk .menu_lst > li').find('.sub').show();
              $('.menu_slt_chk .menu_lst .sub> li').find('.third').show();
              $('.menu_slt_chk .menu_lst > li').find('.menu1').attr('class','menu1 fas fa-caret-down');
          	$('.menu_slt_chk .menu_lst .sub > li').find('.menu2').attr('class','menu2 fas fa-caret-down');
          } else {
              $('.ins_ipt_check').prop('checked',false);
              $('.menu_slt_chk .menu_lst > li').find('.sub').hide();
              $('.menu_slt_chk .menu_lst .sub> li').find('.third').hide();
              $('.menu_slt_chk .menu_lst > li').find('.menu1').attr('class','menu1 fas fa-caret-up');
          	  $('.menu_slt_chk .menu_lst .sub > li').find('.menu2').attr('class','menu2 fas fa-caret-up');
          }
      	});
	   
      	// 수정 팝업 전체 체크
      	$('.edt_all_sstm_menu').click(function(){
          if($('.edt_all_sstm_menu').prop('checked')){
              $('.edt_ipt_check').prop('checked',true);
              $('.menu_slt_chk .menu_lst > li').find('.sub').show();
              $('.menu_slt_chk .menu_lst .sub> li').find('.third').show();
              $('.menu_slt_chk .menu_lst > li').find('.menu1').attr('class','menu1 fas fa-caret-down');
          	  $('.menu_slt_chk .menu_lst .sub > li').find('.menu2').attr('class','menu2 fas fa-caret-down');
          } else {
              $('.edt_ipt_check').prop('checked',false);
              $('.menu_slt_chk .menu_lst > li').find('.sub').hide();
              $('.menu_slt_chk .menu_lst .sub> li').find('.third').hide();
              $('.menu_slt_chk .menu_lst > li').find('.menu1').attr('class','menu1 fas fa-caret-up');
          	  $('.menu_slt_chk .menu_lst .sub > li').find('.menu2').attr('class','menu2 fas fa-caret-up');
          }
      	});
       
      	//리스트 체크 박스 전체 선택 /전체 해제
      	$("input[name=sstm_allGroup_chk]").on('click', function(){
      		if($("input[name=sstm_allGroup_chk]:checked").is(":checked") == true){
	      		$("input[name=sstm_group_chk]").prop('checked', true);
      		}else {
	      		$("input[name=sstm_group_chk]").prop('checked', false);
      		}
      	});
     //권한관리 1뎁스  - 선택 뎁스 하위 메뉴 전체 체크
       $('.menu_slt_chk .menu_lst > li').find('input[name=sstm_menu_chk]').on('click',function(event){	
    	event.stopPropagation();
    	var chk = $(this).prop('checked');
       	if(chk){
       		$(this).parent().parent().find('input[name=sstm_menu_chk]').prop('checked',true);
           } else {
           	$(this).parent().parent().find('input[name=sstm_menu_chk]').prop('checked',false);
           } 
       });
       
       //권한관리 2뎁스  - 선택 뎁스 상위 메뉴와 하위메뉴전체 체크
       $('.menu_slt_chk .menu_lst .sub > li').find('input[name=sstm_menu_chk]').on('click',function(event){	
    	event.stopPropagation();
    	var chk = $(this).prop('checked');
       	if(chk){
       		$(this).parent().parent().parent().siblings('.checkBox').find('input[name=sstm_menu_chk]').prop('checked',true);
           	$(this).parent().parent().find('.third input[name=sstm_menu_chk]').prop('checked',true);
           }
       });
       
       //권한관리 3뎁스 - 선택 뎁스 직속 상위 메뉴들 체크
       $('.menu_slt_chk .menu_lst .third > li').find('input[name=sstm_menu_chk]').on('click',function(event){
    	event.stopPropagation();
       	var chk = $(this).prop('checked');
       	if(chk){
       		$(this).parent().parent().parent().siblings('.checkBox').find('input[name=sstm_menu_chk]').prop('checked',true)
           	$(this).parent().parent().parent().parent().parent().siblings('.checkBox').find('input[name=sstm_menu_chk]').prop('checked',true);
           } 
       });
        
	});
});	

//이벤트 상위 전파 중단
function firstMenu(event) {
					event.stopPropagation();
}
//이벤트 상위 전파 중단
function subMenu(event) {
					event.stopPropagation();
}
//이벤트 상위 전파 중단
function thirdMenu(event) {
					event.stopPropagation();
}


/** 조회  */
function MenuGroupSearch(currentPage) {

	console.log(currentPage);
	var ipt_srchtxt = $("#ipt_srchtxt").val();
	var obj = new Object();
	obj.page = currentPage;
	obj.rowNum = 20;
	obj.offset = (obj.page * obj.rowNum) - obj.rowNum;
	obj.ipt_srchtxt = ipt_srchtxt;

	$.ajax({url : "${pageContext.request.contextPath}/getMenuGroupMainList",
			data : JSON.stringify(obj),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			jsonReader : {
				repeatitems : false,
				paging : "paging", // 현제 페이지, 하단의 navi에 출력됨.
				MenuGroupList : "MenuGroupList", // 총 페이지 수
				frontMnt : "frontMnt",
			},
		}).success(function(result) {
				console.log(result);

				var jObj = JSON.parse(result);
				var jSPUList = jObj.MenuGroupList;
				var jPaging = jObj.paging;

				console.log(jPaging);

				inerHtml = "";
				pagingHtml = "";

				if (jSPUList.length > 0) {
					for ( var key in jSPUList) {
						console.log("key : " + key);
						console.log("value : " + JSON.stringify(jSPUList[key]));
						
						inerHtml += "<tr><td scope='row'><div class='checkBox'><input type='checkbox' name='sstm_group_chk' id='ipt_check04" + (parseInt(key) + parseInt(JSON.stringify(jPaging.startRow)) + 1) + "' class='checking ipt_check' value='"+JSON.stringify(jSPUList[key].COMPANY_GROUP_ID)+"'><label for='ipt_check04" + (parseInt(key) + parseInt(JSON.stringify(jPaging.startRow)) + 1) + "'>"+ (parseInt(key) + parseInt(JSON.stringify(jPaging.startRow)) + 1) + "</label></div></td>";
						if (JSON.stringify(jSPUList[key].GOUP_NM) == null) {
							inerHtml += "<td>-</td>";
						} else {
							inerHtml += "<td>" + JSON.stringify(jSPUList[key].GOUP_NM).replace(/\"/g, "") + "</td>";
						}
						if (JSON.stringify(jSPUList[key].GROUP_EXP) == null){
							inerHtml += "<td>-</td>";
						} else {
							inerHtml += "<td>"+ JSON.stringify(jSPUList[key].GROUP_EXP).replace(/\"/g, "") + "</a></td>";
						}
						if (JSON.stringify(jSPUList[key].REGISTER_ID) == null){
							inerHtml += "<td>-</td>";
						} else {
							inerHtml += "<td>" + JSON.stringify(jSPUList[key].REGISTER_ID).replace(/\"/g, "") + "</td>";
						}
						inerHtml += "<td>" + JSON.stringify(jSPUList[key].REGIST_DT).replace(/\"/g, "") + "</td>";
						if (JSON.stringify(jSPUList[key].UPDUSR_ID) == null){
							inerHtml += "<td>-</td>";
						} else {
							inerHtml += "<td>" + JSON.stringify(jSPUList[key].UPDUSR_ID).replace(/\"/g, "") + "</td>";
						}
						if (JSON.stringify(jSPUList[key].UPDT_DT) == null){
							inerHtml += "<td>-</td>";
						} else {
							inerHtml += "<td>" + JSON.stringify(jSPUList[key].UPDT_DT).replace(/\"/g, "") + "</td>";
						}
						inerHtml += "<td><div class='btnBox'><a class='btn_lyr_open' onclick='goUpdate("+JSON.stringify(jSPUList[key].COMPANY_GROUP_ID).replace(/\"/g, "")+");'><spring:message code='A0809' text='수정' /></a></div></td></tr>";
					}

					console.log("key : " + JSON.stringify(jPaging.currentPage));

					pagingHtml += "<div class='tbl_path'><spring:message code='A0172' text='전체'/><strong> <strong>" + JSON.stringify(jPaging.currentPage) + "</strong> / " + JSON.stringify(jPaging.totalPage) + "</div>";
					pagingHtml += "<div class='paging'>";
					
					pagingHtml += "<a class='btn_paging_prev' href='javascript:MenuGroupSearch(" + JSON.stringify(jPaging.prevPage) + ")' ><spring:message code='A0580' text='이전 페이지로 이동 '/></a>";
					pagingHtml += "<span class='list'>";

					for (var i = JSON.stringify(jPaging.pageRangeStart); i <= JSON.stringify(jPaging.pageRangeEnd); i++) {
						if (JSON.stringify(jPaging.currentPage) == i) {
							pagingHtml += "<strong>" + i + "</strong>";
						} else {
							pagingHtml += "<a href='javascript:MenuGroupSearch(" + i + ")'>" + i + "</a>";
						}
					}

					pagingHtml += "</span>";
					pagingHtml += "<a class='btn_paging_next' href='javascript:MenuGroupSearch(" + JSON.stringify(jPaging.nextPage) + ")'><spring:message code='A0581' text='다음 페이지로 이동 '/></a>";
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

function goUpdate(companyGroupId) {
	
	$("#companyGroupId").val(companyGroupId);
	
	var list = new Array();
	
	
	<c:forEach var="menu1" items="${user.menuLinkedMap}">
	<c:set var="menu1" value="${menu1.value}"/>
		list.push("${menu1.menuCode}");
	</c:forEach>
	
	
	var obj = new Object();
	obj.companyGroupId = companyGroupId;
	$.ajax({
		url : "${pageContext.request.contextPath}/getMenuGroupDetail",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(
			function(result) {
				
				$('.all_sstm_menu').prop('checked',false);
				$('.ipt_check').prop('checked',false);
				$('.menu_slt_chk .menu_lst > li').find('.sub').hide();
				$('.menu_slt_chk .menu_lst > li').find('.third').hide();
				$('.menu_slt_chk .menu_lst > li').find('.menu1').attr('class','menu1 fas fa-caret-up');
				$('.menu_slt_chk .menu_lst .sub > li').find('.menu2').attr('class','menu2 fas fa-caret-up');
				
				$("#edtGroupNm").val(result[0].GOUP_NM);
				$("#edtGroupExp").text(result[0].GROUP_EXP);
				
				for(var i = 0; i <result.length; i++) {
					for(var j = 0; j < list.length; j++){
						if(list[j] == result[i].MENU_CODE){
							
							$("#edt_sstm_"+list[j]).prop("checked", true);
							
							if(document.getElementById('edt_sstm_'+list[j]).checked == true){
								$('.menu_slt_chk .menu_lst > li').find('.sub').show();
								$('.menu_slt_chk .menu_lst > li').find('.third').show();
								$('.all_sstm_menu').prop('checked',true);
								$('.menu_slt_chk .menu_lst > li').find('.menu1').attr('class','menu1 fas fa-caret-down');
								$('.menu_slt_chk .menu_lst .sub > li').find('.menu2').attr('class','menu2 fas fa-caret-down');
							}
							
						}
					}
				}
				openPopup("lyr_userModify");
			}).fail(function(result) {
		console.log("menu detail search error");
	});
	
}

function addMenuGroup() {
	/* 메뉴 체크박스 초기화 */
	$('.all_sstm_menu').prop('checked',false);
	$('.ipt_check').prop('checked',false);
	$("#insGroupNm").val("");
	$("#insGroupExp").val("");
	$('.menu_slt_chk .menu_lst > li').find('.sub').hide();
	$('.menu_slt_chk .menu_lst > li').find('.third').hide();
	$('.menu_slt_chk .menu_lst > li').find('.menu1').attr('class','menu1 fas fa-caret-up');
	$('.menu_slt_chk .menu_lst .sub > li').find('.menu2').attr('class','menu2 fas fa-caret-up');
	
	openPopup("lyr_menuAdd");
}

function insertMenuGroup(){
	var groupNm = $("#insGroupNm").val();
	var groupExp = $("#insGroupExp").val();
	
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
				obj.goupNm = groupNm;
				obj.groupExp = groupExp;
				obj.menuCode = list[i];
				
				list1.push(obj);
				idx++;
			}
		}catch(e){}
	}
	
	if($("#insGroupNm").val() == null || $("#insGroupNm").val() == ""){
		alert("<spring:message code='A0826' text='그룹명을 입력해주세요.' />");
		return false;
	}
	
	if(document.getElementById('total_chk1').checked == false){
		alert("<spring:message code='A0827' text='메뉴를 선택해주세요.' />");
		return false;
	}
	
	alert("<spring:message code='A0828' text='메뉴그룹 등록이 완료되었습니다.' />");
	httpSend("${pageContext.request.contextPath}/insertMenuGroup", $("#headerName").val(), $("#token").val(), JSON.stringify(list1),function(){
		hidePopup("lyr_menuAdd");
		var curPage = $("#contents .paging .list strong").text();
		MenuGroupSearch(curPage);
	});
} 

function updateMenuGroup() {
	var companyGroupId = $("#companyGroupId").val();
	var groupNm = $("#edtGroupNm").val();
	var groupExp = $("#edtGroupExp").val();
	
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
			if(document.getElementById('edt_sstm_'+list[i]).checked == true){
				obj.companyGroupId = companyGroupId;
				obj.goupNm = groupNm;
				obj.groupExp = groupExp;
				obj.menuCode = list[i];
				
				list1.push(obj);
				idx++;
			}
		}catch(e){
		}
	}
	if($("#edtGroupNm").val() == null || $("#edtGroupNm").val() == ""){
		alert("<spring:message code='A0826' text='그룹명을 입력해주세요.' />");
		return false;
	}
	if(document.getElementById('total_chk2').checked == false){
		alert("<spring:message code='A0827' text='메뉴를 선택해주세요.' />");
		return false;
	}
	
	alert("<spring:message code='A0829' text='메뉴그룹이  수정되었습니다.' />");
	httpSend("${pageContext.request.contextPath}/updateMenuGroup", $("#headerName").val(), $("#token").val(), JSON.stringify(list1),function(){
		hidePopup("lyr_userModify");
		var curPage = $("#contents .paging .list strong").text();
		MenuGroupSearch(curPage);
	});
// 	location.reload();
	
}

function deleteMenuGroup() {
	var list = new Array();
	
	$("input[name=sstm_group_chk]:checked").each(function(){
	    list.push($(this).val());
	});
	
	console.log("check CompanyGroupId value : " + list);
	
	var obj = new Object();
	obj.companyGroupId = list;

	$.ajax({
		url : "${pageContext.request.contextPath}/deleteMenuGroupInfo",
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
				MenuGroupSearch(curPage);
			}).fail(function(result) {
		console.log("삭제 error");
	});
}
</script>
</body>
</html>
