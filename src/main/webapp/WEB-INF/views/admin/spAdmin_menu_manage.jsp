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
        	<jsp:param name="titleCode" value="A0540"/>
		    <jsp:param name="titleTxt" value="시스템 메뉴관리"/>
		</jsp:include>
		<!-- //#header -->
    <!-- #container -->
    <div id="container">
        <!-- #contents -->
        <div id="contents">
            <!-- .content -->
            <div id="super_admin" class="content">
                <!-- .section -->
                <div class="stn">
                
                	  
					    
                    <div class="fl menu_admin">
                        <div class="menu_slt_box">
                            <div class="lst_hd"><spring:message code="A0566" text="메뉴 목록"/></div>
                            <div class="lst_bd menu_lst">
                                 <ul id="treeDemo" class="ztree"></ul>              
                            </div> 
                        </div>
                        <div class="btnBox btn_menu_del">
                           <a href="javascript:menuDelPop();" class="btnS_basic"><spring:message code="A0541" text="삭제" /></a>
						</div>          
                        <div class="btnBox btn_menu_add">
                            <a class="btnS_basic" id="add_Menu" onclick="addMenu();"><spring:message code="A0573" text="메뉴추가"/></a>
                        </div>  
                    </div>
                    
                    <div class="fr menu_admin">
                        <div class="menu_info_tbl">
                            <table summary="메뉴코드, 메뉴명, 메뉴경로, 메뉴URL, 사용여부, 메뉴설명, 등록일, 수정일로 구성됨">
                                <caption class="hide">메뉴상세설정</caption>                                
                                <colgroup>
                                    <col width="110"><col>
                                </colgroup>
                                
                                <thead>
                                    <tr>
                                        <th colspan="2" scope="col"><spring:message code="A0567" text="메뉴상세"/></th>
                                    </tr>
                                </thead>
                                
                                <tbody class="slt_menu">   
                                    <!-- 선택메뉴 없을 경우 -->
                                    <tr class="slt_none">
                                        <td colspan="2">※ 메뉴가 선택되지 않았습니다.<br>좌측 메뉴 목록에서 수정 및 삭제할 메뉴를 선택하시거나 메뉴추가 버튼을 클릭하여 신규 메뉴를 등록하세요.</td>
                                    </tr>  
                                    <!-- 선택메뉴 있을 경우 -->                               
                                    <tr>
                                        <th scope="row"><spring:message code="A0568" text="메뉴코드"/></th>
                                        <td>
                                            <div class="iptBox">
                                                <input type="text" class="ipt_txt" id="menuCode" readonly="readonly">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><spring:message code="A0569" text="메뉴 명"/></th>
                                        <td>
                                            <div class="iptBox">
                                                <input type="text" class="ipt_txt" id="menuNmKo" disabled="disabled">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><spring:message code="A0569" text="메뉴 명"/>(<spring:message code="A0560" text="영문"/>)</th>
                                        <td>
                                            <div class="iptBox">
                                                <input type="text" class="ipt_txt" id="menuNmEn" disabled="disabled">
                                            </div>
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <th scope="row"><spring:message code="A0570" text="메뉴 경로"/></th>
                                        <td id="menuCours"></td>
                                    </tr>
                                    <tr>
			                        	<th scope="row"><spring:message code="A0832" text="연결구분"/></th>
				                        <td>
				                            <div class="radioBox">
				                             	<input value="00" type="radio" name="system_link_ty" id="linkty_ne" disabled="disabled">
				                                <label for="linkty_ne"><spring:message code="A0836" text="사용안함"/></label>
				                                <input value="01" type="radio" name="system_link_ty" id="linkty_page" disabled="disabled">
				                                <label for="linkty_page"><spring:message code="A0833" text="페이지"/></label>
				                                <input value="02" type="radio" name="system_link_ty" id="linkty_link" disabled="disabled">
				                                <label for="linkty_link"><spring:message code="A0834" text="링크"/></label>
				                                <input value="03" type="radio" name="system_link_ty" id="linkty_embedded" disabled="disabled">
				                                <label for="linkty_embedded"><spring:message code="A0835" text="임베디드"/></label>
				                            </div>
				                        </td>
				                    </tr>
                                    <tr>
                                        <th scope="row"><spring:message code="A0571" text="메뉴 URL"/></th>
                                        <td>
                                            <div class="iptBox">
                                                <input type="text" class="ipt_txt" id="menuUrl" disabled="disabled">
                                            </div>
                                        </td>
                                    </tr>
<!--                                     <tr> -->
<%--                                     	<th scope="row"><spring:message code="A0636" text="정렬순서" /></th> --%>
<!--                                     	<td> -->
<!--                                     		<select class="select" id="selectSortOrdr" disabled="disabled"> -->
<%--                                     			<option><spring:message code="A0069" text="-선택-" /> </option> --%>
<!--                                     		</select> -->
<!--                                     	</td> -->
<!--                                     </tr> -->
                                    <tr>
                                        <th scope="row"><spring:message code="A0557" text="사용여부"/></th>
                                        <td>
                                            <div class="radioBox">
                                                <input type="radio" name="system_use_slt1" id="used2" disabled="disabled">
                                                <label for="used2" id="used2_cursor" style="cursor: default;"><spring:message code="A0535" text="사용"/></label>
                                                <input type="radio" name="system_use_slt1" id="not_used2" disabled="disabled">
                                                <label for="not_used2" id="not_used2_cursor" style="cursor: default;"><spring:message code="A0536" text="미사용"/></label>
                                            </div>
                                        </td>
                                    </tr>
                                    <%-- <tr>
                                        <th scope="row"><spring:message code="A0572" text="메뉴설명"/></th>
                                        <td>
                                            <div class="textareaBox">
                                                <textArea id="MenuExp" disabled="disabled"></textArea>
                                            </div>
                                        </td>
                                    </tr> --%>
                                    <tr>
                                        <th scope="row"><spring:message code="A0542" text="등록일"/></th>
                                        <td id="registDt"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><spring:message code="A0574" text="수정일"/></th>
                                        <td id="updtDt"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <input type="hidden" id="topMenuCode">                    
                        <input type="hidden" id="parntsMenuCode">
                        <input type="hidden" id="peakMenuCode" value="Y">
                        <input type="hidden" id="menuDp" value="0">
                        <input type="hidden" id="resetMenu">   
                        <input type="hidden" id="resetTopMenuCode">
                        <div class="callView">
                        <div class="btnBox sz_small line">
                            <!-- [D] 등록관련 UI script는 하단script 영역에 있음 -->
                            <button type="button" class="btnS_basic" onclick="detailReset(event);" id="menuDetailReset" disabled="disabled"><spring:message code="A0817" text="되돌리기" /></button>
                            <button type="button" class="btnS_basic" onclick="updateMenu();" id="updateMenu" disabled="disabled"><spring:message code="A0809" text="수정"/></button>
                                          
                        </div>
                        </div>   
                    </div>                                        
                </div>
            </div>
            <!-- //.content -->
        </div>
        <!-- //#contents -->
    </div>
    <!-- //#container -->
</div>
<!-- //#wrap -->
<div id="lyr_add_menu" class="lyrBox lyr_super">
	<input type="hidden" id="menuCompanyId" value="">
    <div class="lyr_top">
        <button class="btn_lyr_close"><span class="fas fa-times"></span></button>
    	<h2><spring:message code="A0573" text="메뉴추가"/></h2>
     </div>
    <div class="lyr_mid">
    	<div class="menu_info_tbl">
            <table summary="메뉴코드, 메뉴명, 메뉴경로, 메뉴URL, 사용여부, 메뉴설명, 등록일, 수정일로 구성됨">
                <caption class="hide">메뉴상세설정</caption>                                
                <tbody class="slt_menu">   
                    <!-- 선택메뉴 없을 경우 -->
                    <tr class="slt_none">
                        <td colspan="2">※ 메뉴가 선택되지 않았습니다.<br>좌측 메뉴 목록에서 수정 및 삭제할 메뉴를 선택하시거나 메뉴추가 버튼을 클릭하여 신규 메뉴를 등록하세요.</td>
                    </tr>  
                    <!-- 선택메뉴 있을 경우 -->
                    <tr>
						<td colspan="2" id="top_MenuPath"></td>                    
                    </tr>
                    <tr>
                        <th scope="row"><spring:message code="A0568" text="메뉴코드"/></th>
                        <td>
                            <div class="iptBox">
                                <input type="text" class="ipt_txt" id="popMenuCode" value="" disabled="disabled">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><spring:message code="A0569" text="메뉴 명"/></th>
                        <td>
                            <div class="iptBox">
                                <input type="text" class="ipt_txt" id="popMenuNmKo">
                            </div>
                        </td>
                    </tr>                                    
                    <tr>
                        <th scope="row"><spring:message code="A0569" text="메뉴 명"/>(<spring:message code="A0560" text="영문"/>)</th>
                        <td>
                            <div class="iptBox">
                                <input type="text" class="ipt_txt" id="popMenuNmEn">
                            </div>
                        </td>
                    </tr>                                    
                    <tr>
                        <th scope="row"><spring:message code="A0570" text="메뉴 경로"/></th>
                        <td id="popMenuCours"></td>
                    </tr>
                    <tr>
						<th scope="row"><spring:message code="A0832" text="연결구분"/></th>
						<td>
						    <div class="radioBox">
						    	<input value="00" type="radio" name="system_link_ty1" id="linkty_ne1" checked="checked">
                                <label for="linkty_ne1"><spring:message code="A0836" text="사용안함"/></label>
						        <input value="01" type="radio" name="system_link_ty1" id="linkty_page1">
						        <label for="linkty_page1"><spring:message code="A0833" text="페이지"/></label>
						        <input value="02" type="radio" name="system_link_ty1" id="linkty_link1">
						        <label for="linkty_link1"><spring:message code="A0834" text="링크"/></label>
						        <input value="03" type="radio" name="system_link_ty1" id="linkty_embedded1">
						        <label for="linkty_embedded1"><spring:message code="A0835" text="임베디드"/></label>
						    </div>
						</td>
                   </tr>
                    <tr>
                        <th scope="row"><spring:message code="A0571" text="메뉴 URL"/></th>
                        <td>
                            <div class="iptBox">
                                <input type="text" class="ipt_txt" id="popMenuUrl">
                            </div>
                        </td>
                    </tr>
<!--                     <tr> -->
<%--                        	<th scope="row"><spring:message code="A0636" text="정렬순서" /></th> --%>
<!--                        	<td> -->
<!--                        		<select class="select" id="popSelectSortOrdr"> -->
<%--                        			<option><spring:message code="A0069" text="-선택-" /></option> --%>
<!--                        		</select> -->
<!--                        	</td> -->
<!--                     </tr> -->
 					
                    <tr>
                        <th scope="row"><spring:message code="A0557" text="사용여부"/></th>
                        <td>
                            <div class="radioBox">
                                <input type="radio" name="system_use_slt" id="used22" checked="checked">
                                <label for="used22"><spring:message code="A0535" text="사용"/></label>
                                <input type="radio" name="system_use_slt" id="not_used22">
                                <label for="not_used22"><spring:message code="A0536" text="미사용"/></label>
                            </div>
                        </td>
                    </tr>
                    <%-- <tr>
                        <th scope="row"><spring:message code="A0572" text="메뉴설명"/></th>
                        <td>
                            <div class="textareaBox">
                                <textArea></textArea>
                            </div>
                        </td>
                    </tr> --%>
                </tbody>
            </table>
        </div>
       <div class="lyr_btm">             
        <div class="btnBox btn_menu_info">
            <!-- [D] 등록관련 UI script는 하단script 영역에 있음 -->
            <a class="btnS_basic btn_register" onclick="insertMenu();"><spring:message code="A0538" text="등록"/></a>                        
            <a class="btnS_basic btn_lyr_close" id="cancel"><spring:message code="A0532" text="취소"/></a>
        </div>
       </div>
    </div>
</div>
<!-- 서비스 신청 및 문의하기 -->  
<%@ include file="../common/inc_footer.jsp"%>
<!-- //서비스 신청 및 문의하기 -->  


<div id="lyr_del_chk" class="lyrBox lyr_alert">
    <div class="lyr_cont">
        <p><spring:message code="A0824" text="선택하신  메뉴가 삭제됩니다." /><br><spring:message code="A0825" text="정말 삭제하시겠습니까?" /></p>
    </div>

    <div class="btnBox sz_small">
        <button class="btn_lyr_del" onclick="deleteMenu();"><spring:message code="A0037" text="확인" /></button>
        <button class="btn_lyr_close"><spring:message code="A0532" text="취소" /></button>
    </div>
</div>

<!-- page Landing -->  
<script type="text/javascript">   


// 메뉴 데이터 셋팅
var treeData =[
	<c:forEach var="menu1" items="${user.menuLinkedMap}" varStatus="status">
		<c:set var="menu1" value="${menu1.value}"/>
		<c:if test="${empty menu1.topMenuCode}">
			{ id : "${menu1.menuCode}", name:"${lang=="en"?menu1.menuNmEn:menu1.menuNmKo}" },
			<c:if test="${not empty menu1.menuLinkedMap}">
				<c:forEach var="menu2" items="${menu1.menuLinkedMap}" varStatus="status">
					<c:set var="menu2" value="${menu2.value}"/>
					{ id : "${menu2.menuCode}", pid : "${menu2.topMenuCode}" ,name:"${lang=="en"?menu2.menuNmEn:menu2.menuNmKo}" },
					<c:if test="${not empty menu2.menuLinkedMap}">
						<c:forEach var="menu3" items="${menu2.menuLinkedMap}" varStatus="status">
							<c:set var="menu3" value="${menu3.value}"/>
							{ id : "${menu3.menuCode}", pid : "${menu3.topMenuCode}" ,name:"${lang=="en"?menu3.menuNmEn:menu3.menuNmKo}" },
						</c:forEach>
					</c:if>
				</c:forEach>
			</c:if>
	   	</c:if>
	</c:forEach>
 ];
 
 
 
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
        menuList();
	});
    
});

var menuTree;
var treeData=[];
var dragNodePid;
var dragNodeid;
var dragNode;
// tree option
var setting = {
   edit: {
		enable: true,
		drag:{
			isMove : true,
			prev : true,
           next : true,
			inner : true,
		}
	},

   data: {
       simpleData: {
           enable: true,
       }
   },

   check: {
       enable: true,
		chkStyle: "checkbox",
		chkboxType: { "Y": "s", "N": "ps" }
   },
   callback: {
		beforeClick: function(treeId, treeNode, clickFlag){
// 			console.log(treeId);
// 			console.log(treeNode);
// 			console.log(clickFlag);
			menuDetail(event,treeNode.id,treeNode.pId);
		},
		beforeDrag: function(treeId, treeNodes) {
// 			console.log(treeId);
// 			console.log(treeNodes);
			console.log(treeNodes[0].pId);
			dragNodePid = treeNodes[0].pId;
			dragNodeid =  treeNodes[0].id;
			dragNode = treeNodes[0];
		},
		beforeDrop: function(treeId, treeNodes, targetNode, moveType) {
			
			if(moveType=="next" || moveType=="prev"){
				if(targetNode.level>3){
// 					alert("메뉴는 최대 3뎁스를 초과합니다.");
					return false;
				}
				if((targetNode.level+getMaxChildNodeLevel(dragNode))>3){
// 					alert("하위 뎁스가 3뎁스를 초과합니다. 이동하시려는 메뉴의 하위뎁스를 제거해주세요.");
					return false;
				}
				if(dragNodePid!=targetNode.pId){
					
					var menuCode = dragNodeid;
					var parentMenuCode = getParentNode(targetNode).id;
					var topCode = targetNode.getParentNode().id;
					var menuDp = targetNode.level-1;
					console.log("parentMenuCode :"+parentMenuCode);
					console.log("topCode :"+topCode);
					console.log("menuDp :"+menuDp);
					updateMenuDp(menuCode,topCode,parentMenuCode,menuDp);
					// 자식 노드도 변경된 parentCode,menudp로 변경
					recurChildNode(treeNodes[0]);
					
					
				}
				
				setTimeout(function(){
					console.log(targetNode.pId);
					// 같은 레벨의 메뉴 찾기
					var nodes = menuTree.getNodesByFilter(function(node){if(node.pId==targetNode.pId){return node;}},false);
					// 순서 변경
					for(var i in nodes){
						updateMenuOrder(nodes[i].id,Number(i)+1);
					}
					console.log(nodes);
				},500);
			}else if(moveType=="inner"){
				if(targetNode.level>2){
// 					alert("메뉴는 최대 3뎁스를 초과합니다.");
					return false;
				}
				if((targetNode.level+getMaxChildNodeLevel(dragNode))>2){
// 					alert("하위 뎁스가 3뎁스를 초과합니다. 이동하시려는 메뉴의 하위뎁스를 제거해주세요.");
					return false;
				}
				if(dragNodePid!=targetNode.id){
					console.log("부모 메뉴 서로 다름 "+dragNodePid+"!="+targetNode.id);
					
					var menuCode = dragNodeid;
					var parentMenuCode = getParentNode(targetNode).id;
					var topCode = targetNode.id;
					var menuDp = targetNode.level;
					console.log("parentMenuCode :"+parentMenuCode);
					console.log("topCode :"+topCode);
					console.log("menuDp :"+menuDp);
					updateMenuDp(menuCode,topCode,parentMenuCode,menuDp);
					// 자식 노드도 변경된 parentCode,menudp로 변경
					recurChildNode(treeNodes[0]);
					
					setTimeout(function(){
						console.log(targetNode.pId);
						// 같은 레벨의 메뉴 찾기
						var nodes = menuTree.getNodesByFilter(function(node){if(node.pId==targetNode.id){return node;}},false);
						// 순서 변경
						for(var i in nodes){
							updateMenuOrder(nodes[i].id,Number(i)+1);
						}
						console.log(nodes);
					},500);
				}
			}
			
			
				
		}
	}
}

/**
 * 메뉴 트리에서 최상위 메뉴를 찾는 함수
 */
function getParentNode(node){
	var pNode = node;
	while(pNode.pId!=""){
		pNode=pNode.getParentNode();
	}
	return pNode;
}

/**
 * 재귀문으로 하위 모든 자식노드중 가장 높은 레벨을 가져옴
 */
function getMaxChildNodeLevel(node){
	var level = -1;
	if(!node.children)
		return;
	for(var i in node.children){
		var inode = node.children[i];
		var ilevel = getMaxChildNodeLevel(inode);
		if(inode.level>ilevel){
			level=inode.level;
		}
		
		if(level==-1){
			level=inode.level;
		}
	}
	
	return level;
}

/**
 *  재귀문으로 하위 모든 자식 노드 정보 변경
 */
function recurChildNode(node){
	if(!node.children)
		return;
	for(var i in node.children){
		var inode = node.children[i];
		
		var menuCode = inode.id;
		var parentMenuCode = getParentNode(inode).id;
		var topCode = inode.getParentNode().id;
		var menuDp = inode.level-1;
		console.log(inode);
		console.log("parentMenuCode :"+parentMenuCode);
		console.log("topCode :"+topCode);
		console.log("menuDp :"+menuDp);
		updateMenuDp(menuCode,topCode,parentMenuCode,menuDp);
		recurChildNode(inode);
	}
}



function menuList(){
	treeData=[];
	treeData.push({ id : "", name:"<spring:message code="A0566" text="메뉴 목록"/>" });
    $.ajax({
   	url : "${pageContext.request.contextPath}/getMenuList",
   	method : 'GET',
   	contentType : "application/json; charset=utf-8",
   	beforeSend : function(xhr) {
   		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
   	},
    }).success(function(result) {
   		if(result != null) {
    			for(var depth1 in result){
    				if(result[depth1].topMenuCode == null){
    					
    					treeData.push({ id : result[depth1].menuCode, pId: "",name:${lang=='en'?'result[depth1].menuNmEn':'result[depth1].menuNmKo'} });
//     					innerHtml += "<li onclick=menuDetail(event,'"+result[depth1].menuCode+"','');><a href='#none'><span class='fas fa-caret-down'>${lang=='en'?'"+result[depth1].menuNmEn+"':'"+result[depth1].menuNmKo+"'}</a>";
   						if(result[depth1].menuLinkedMap != null){
	   						for(var depth2 in result[depth1].menuLinkedMap){
// 		   						innerHtml += "<ul class='third'>";
								treeData.push({ id : result[depth1].menuLinkedMap[depth2].menuCode, pId: result[depth1].menuLinkedMap[depth2].topMenuCode ,name:${lang=='en'?'result[depth1].menuLinkedMap[depth2].menuNmEn':'result[depth1].menuLinkedMap[depth2].menuNmKo'} });
// 	   							innerHtml += "<li onclick=menuDetail2(event,'"+result[depth1].menuLinkedMap[depth2].menuCode+"','"+result[depth1].menuLinkedMap[depth2].topMenuCode+"');><a href='#none'><span class='fas fa-caret-down'>${lang=='en'?'"+result[depth1].menuLinkedMap[depth2].menuNmEn+"':'"+result[depth1].menuLinkedMap[depth2].menuNmKo+"'}</a>";
	 	   						if(result[depth1].menuLinkedMap[depth2].menuLinkedMap != null){
// 	 	   							innerHtml += "<ul class='fourth'>";
			   						for(var depth3 in result[depth1].menuLinkedMap[depth2].menuLinkedMap){
			   							treeData.push({ id : result[depth1].menuLinkedMap[depth2].menuLinkedMap[depth3].menuCode, pId: result[depth1].menuLinkedMap[depth2].menuLinkedMap[depth3].topMenuCode ,name:${lang=='en'?'result[depth1].menuLinkedMap[depth2].menuLinkedMap[depth3].menuNmEn':'result[depth1].menuLinkedMap[depth2].menuLinkedMap[depth3].menuNmKo'} });
			   						}
// 			   						innerHtml += "</ul>";
	 	   						}
	   						}
   						}
    				}
    			}
   		}
   	 // tree data
//    	     treeData =[
//    	        { id : "1", name:"node1" },
//    	        { id : "11", pId : "1", name:"child1"},
//    	        { id : "12", pId : "1", name:"child2"},
//    	        { id : "2", name:"node2" },
//    	        { id : "21", pId : "2", name:"child3"},
//    	        { id : "22", pId : "2", name:"child4"},
//    	        { id : "22", pId : "2", name:"child5"},
//    	        { id : "22", pId : "2", name:"child6"},
//    	        { id : "22", pId : "2", name:"child7"},
//    	        { id : "3", name:"node3" },
//    	        { id : "31", pId : "3", name:"child8"},
//    	        { id : "32", pId : "3", name:"child9"},
//    	        { id : "32", pId : "3", name:"child10"},
//    	    ];
   	 
   	 	// tree 초기화
   	    menuTree = $.fn.zTree.init($("#treeDemo"), setting, treeData);
   		menuTree.expandNode(menuTree.getNodeByTId("treeDemo_1"))
   		menuEvent();
	}).fail(function(result) {
		console.log("menuList search error");
	});
}
function menuEvent(){
    //첫 메뉴 화면 보이게 
    $('.menu_slt_box .menu_lst > li').find('.sub').css("display","block");
    
    $('.menu_slt_box .menu_lst > li').on('click',function(event){
    	event.stopPropagation();
    	$(this).addClass('active').find('.sub').stop().slideDown(300);
    });
    
    $('.menu_slt_box .menu_lst .sub > li').on('click',function(event){
    	event.stopPropagation();
        if($(this).find('.third').css('display') == "block"){
        	$(this).find('.third').css("display" , "none");
        	$(this).find('.fourth').css("display" , "none");
        	$('.menu_slt_box .menu_lst .sub > li').removeClass('active');
        	$('.menu_slt_box .menu_lst .third > li').removeClass('active');
        	$('.menu_slt_box .menu_lst .fourth > li').removeClass('active');
        }else {
        	$('.menu_slt_box .menu_lst .sub > li').removeClass('active');
        	$('.menu_slt_box .menu_lst .third > li').removeClass('active');
        	$('.menu_slt_box .menu_lst .fourth > li').removeClass('active');
        	$(this).addClass('active').find('.third').stop().slideDown(300);
        }   	
    });	
    
    $('.menu_slt_box .menu_lst .third > li').on('click',function(event){	
    	event.stopPropagation();
    	if($(this).find('.fourth').css('display') == "block"){
        	$(this).find('.fourth').css("display" , "none");
        	$('.menu_slt_box .menu_lst .third > li').removeClass('active');
        	$('.menu_slt_box .menu_lst .fourth > li').removeClass('active');
    	}else{
        	$('.menu_slt_box .menu_lst .sub > li').removeClass('active');
        	$('.menu_slt_box .menu_lst .third > li').removeClass('active');
        	$('.menu_slt_box .menu_lst .fourth > li').removeClass('active');
        	$(this).parent().parent().addClass('active');
        	$(this).addClass('active').find('.fourth').stop().slideDown(300);
    	}
    });
   
    $('.menu_slt_box .menu_lst .fourth > li').on('click',function(event){
    	event.stopPropagation();
    	$('.menu_slt_box .menu_lst .fourth > li').removeClass('active');
    	$('.menu_slt_box .menu_lst .third > li').removeClass('active');
    	$('.menu_slt_box .menu_lst .sub > li').removeClass('active');
    	$(this).parent().parent().addClass('active');
    	$(this).parent().parent().parent().parent().addClass('active');
    	$(this).addClass('active');
    });
}


var firstMenu = function (){
	$('.menu_slt_box .menu_lst .sub > li').removeClass('active');
	$('.menu_slt_box .menu_lst .third > li').removeClass('active');
	$('.menu_slt_box .menu_lst .fourth > li').removeClass('active');
	//메뉴 상세 초기화
	$("#selectSortOrdr").empty();
	$("#menuCode").val("");
	$("#menuNmKo").val("");
	$("#menuNmEn").val("");
	$("#menuCours").text("");
	$("#menuUrl").val("");
	$("#selectSortOrdr").append("<option><spring:message code='A0069' text='-선택-' /></option>");
	
	$("input[name=system_link_ty]").prop('checked', false);
	
	$("input[name=system_use_slt1][id='used2']").prop('checked', false);
	$("input[name=system_use_slt1][id='not_used2']").prop('checked', false);
	
	
	$("#registDt").text("");
	$("#updtDt").text("");
	//메뉴 추가 팝업 초기화
	$("#top_MenuPath").text("");
	$("#popMenuCours").text("");
	$("#peakMenuCode").val("Y");
	//최상위 메뉴코드
	$("#topMenuCode").val("");
	$("#parntsMenuCode").val("");
	//메뉴 목록 클릭시 일때 MenuDp: 0
	$("#menuDp").val(0);
	//초기화시 사용되는 값
	$("#resetMenu").val("");
	//메뉴목록 클릭시 메뉴추가 disabled 해제
	$("#add_Menu").css({
		"pointer-events": "auto",
		background: "#5e77ff"
	});
}
//menu 상세 조회 dep1
function menuDetail(event,menuCode, topMenuCode) {
	if(topMenuCode==null){
		topMenuCode="";
	}
	
	if(menuCode=="" && topMenuCode==""){
		firstMenu();
		return;
	}
	
	//1뎁스 클릭시 메뉴추가 disabled 해제
	$("#add_Menu").css({
		"pointer-events": "auto",
		background: "#5e77ff"
	});
	
	//disabled 해제
	$("#menuNmKo").attr("disabled", false);
	$("#menuNmEn").attr("disabled", false);
	$("#menuUrl").attr("disabled", false);
	$("#selectSortOrdr").attr("disabled", false);
	$("input[name=system_link_ty]").attr("disabled", false);
	$("#used2").attr("disabled", false);
	$("#not_used2").attr("disabled", false);
	$("#not_used2_cursor").css("cursor", "pointer");
	$("#used2_cursor").css("cursor", "pointer");
	$("#menuDetailReset").attr("disabled", false);
	$("#updateMenu").attr("disabled", false);
	$("#deleteMenu").attr("disabled", false);
	
	
	//부모 메뉴 코드
	$("#parntsMenuCode").val(menuCode);
	//최상위 메뉴코드
	$("#topMenuCode").val(menuCode);
	$("#peakMenuCode").val("N");
	//메뉴 깊이 1뎁스 클릭시 일때 MenuDp: 1
	$("#menuDp").val(1);
	//초기화시 사용되는 값
	$("#resetMenu").val("menu1");
	$("#resetTopMenuCode").val(topMenuCode);
	var obj = new Object();
	obj.lang = $.cookie("lang");
	obj.menuCode = menuCode;
	obj.topMenuCode = topMenuCode;
	$.ajax({
		url : "${pageContext.request.contextPath}/getMenuDetail",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
				//FAST AICC 관리 사용여부 관련 disabled 처리 
				if(result[0].PARNTS_MENU_CODE == "MENU042"){
					$("#used2").attr("disabled", true);
					$("#not_used2").attr("disabled", true);
					if($("#useAtExplanation").length < 1){
						$("#not_used2_cursor").after("<em>*</em><span id='useAtExplanation' style='color:gray;'><spring:message code='A0840' text='관리메뉴는 사용 여부를 수정할 수 없습니다.'/></span>");
					}
				}else{
					$("#used2").attr("disabled", false);
					$("#not_used2").attr("disabled", false);
					$("#useAtExplanation").remove();
				}
				
				$("#selectSortOrdr").empty();
				$("#menuCode").val(result[0].MENU_CODE);
				$("#menuNmKo").val(result[0].MENU_NM_KO);
				$("#menuNmEn").val(result[0].MENU_NM_EN);
				$("#menuUrl").val(result[0].USER_MENU_URL);
				for(var i =0; i < result[1].SortOrdr.length; i++){
					if((i+1) == result[0].SORT_ORDR){
					$("#selectSortOrdr").append("<option selected='selected'>"+result[0].SORT_ORDR+"</option>")
					}else{
					$("#selectSortOrdr").append("<option>"+(i+1)+"</option>")
					}
				}
				if(result[0].USE_AT == "Y"){
					$("input[name=system_use_slt1][id='used2']").prop('checked', true);
				}else if(result[0].USE_AT == null || result[0].USE_AT == "N"){
					$("input[name=system_use_slt1][id='not_used2']").prop('checked', true);
				}
				
				$("input[name=system_link_ty][value="+result[0].LINK_TY+"]").prop('checked', true);
				
				$("#registDt").text(result[0].REGIST_DT);
				if(result[0].UPDT_DT == null){
					$("#updtDt").text("");
				}else {
					$("#updtDt").text(result[0].UPDT_DT);
				}
				$("#menuCours").text(result[1].COURS);
				$("#popMenuCours").text(result[1].COURS);
				$("#top_MenuPath").text(result[1].COURS);
				
			}).fail(function(result) {
		console.log("menu detail search error");
	});
	
}

//메뉴 수정 위치
function updateMenuDp(menuCode,topMenuCode,parentMenuCode,menuDp){
	var obj = new Object();
	obj.lang = $.cookie("lang");
	obj.menuCode = menuCode;
	obj.topMenuCode = topMenuCode;
	obj.parentMenuCode = parentMenuCode;
	obj.menuDp = menuDp;
	
	$.ajax({
		url : "${pageContext.request.contextPath}/updateMenuDetail",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		
	}).fail(function(result) {
		console.log("menu detail search error");
	});
	
}

//메뉴 수정 순서
function updateMenuOrder(menuCode,order){
	var obj = new Object();
	obj.lang = $.cookie("lang");
	obj.menuCode = menuCode;
	obj.sortOrdr = order;
	$.ajax({
		url : "${pageContext.request.contextPath}/updateMenuDetail",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		location.reload();
		
	}).fail(function(result) {
		console.log("menu detail search error");
	});
	
}

//메뉴 수정
function updateMenu(){
	var menuCode = $("#menuCode").val();
	var menuNmKo = $("#menuNmKo").val();
	var menuNmEn = $("#menuNmEn").val();
	var menuUrl = $("#menuUrl").val();
	
	var useAt ="N";
	if(document.getElementById("used2").checked == true){
		useAt = "Y"
	}
	if(document.getElementById("not_used2").checked == true){
		useAt = "N"
	}
	
	if(menuNmKo == null || menuNmKo == ""){
		alert("<spring:message code='A0822' text='메뉴명을 입력해주세요.' />");
		return false;
	}
	if(menuNmEn == null || menuNmEn == ""){
		alert("<spring:message code='A0823' text='메뉴명(영문)을 입력해주세요.' />");
		return false;
	}
	
	var obj = new Object();
	obj.lang = $.cookie("lang");
	obj.menuCode = menuCode;
	obj.menuNmKo = menuNmKo;
	obj.menuNmEn = menuNmEn;
	obj.userMenuUrl = menuUrl;
	obj.useAt = useAt;
	obj.sortOrdr = $("#selectSortOrdr option:selected").val();
	obj.linkTy = $("input[name=system_link_ty]:checked").val();
	$.ajax({
		url : "${pageContext.request.contextPath}/updateMenuDetail",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
				$("#menuNmKo").val(result.menuNmKo);
				$("#menuNmEn").val(result.menuNmEn);
				$("#menuUrl").val(result.userMenuUrl);
				if(result.useAt == "Y"){
					$("input[name=system_use_slt1][id='used2']").attr('checked', true);
				}else if(result.useAt == null || result.useAt == "N"){
					$("input[name=system_use_slt1][id='not_used2']").attr('checked', true);
				}
				$("input[name=system_link_ty][value="+result.linkTy+"]").val()
				
				$("#updtDt").text(result.UpdtDt);
				menuList();
				
				$("#menuCours").text(result.COURS);
				alert('<spring:message code="A0577" text="메뉴 수정이 완료되었습니다."/>');
				location.reload();
			}).fail(function(result) {
		console.log("menu detail search error");
	});
	
}

//메뉴 삭제
function menuDelPop(){
	if(menuTree.getCheckedNodes().length==0){
		alert("<spring:message code='A0831' text='삭제할 메뉴 체크박스를 선택해주세요.' />");
		return;
	}
	
	openPopup("lyr_del_chk");
}

function deleteMenu(){
	var checkMenu = menuTree.getCheckedNodes();
	var defferCollection = [];
	
	for(var i in checkMenu){
		var menuCode = checkMenu[i].id;
		var obj = new Object();
		obj.menuCode = menuCode;
		obj.deleteAt = "Y"
		var ajax = $.ajax({
			url : "${pageContext.request.contextPath}/deleteMenu",
			data : JSON.stringify(obj),
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
		});
		defferCollection.push(ajax);
	}
	
	$.when(defferCollection).then(function (){
// 		menuList();
		hidePopup("lyr_del_chk");
		location.reload();
	},function(){
		console.log("menu detail search error");
	});
	
}

function addMenu(){
	//input 초기화
	$("#popMenuNmKo").val("");
	$("#popMenuNmEn").val("");
	$("#popMenuUrl").val("");
	$("input:radio[name=system_link_ty1]").eq(0).prop("checked",true);
	$("input:radio[name=system_use_slt]").eq(0).prop("checked",true);
	
	var popMenuCode = "1";
	var parntsMenuCode = $("#parntsMenuCode").val();
	var topMenuCode = $("#peakMenuCode").val() == "Y" ? null : $("#topMenuCode").val(); 
	var obj = new Object();
	obj.popMenuCode = popMenuCode;
	obj.topMenuCode = topMenuCode;
	$.ajax({
		url : "${pageContext.request.contextPath}/getMenuCode",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
					$("#popMenuCode").val(result[0].MENU_CODE);
					if(parntsMenuCode == ""){
						$("#parntsMenuCode").val(result[0].MENU_CODE);
					}
					$("#popSelectSortOrdr").empty();
					for(var i = 0; i < result[1].SortOrdr.length; i++){
						$("#popSelectSortOrdr").append("<option>"+result[1].SortOrdr[i].SORT_ORDR+"</option>");
					}
					$("#popSelectSortOrdr").append("<option selected='selected'>"+(result[1].SortOrdr.length +1)+"</option>");
			}).fail(function(result) {
		console.log("menu code check error");
	});
	openPopup("lyr_add_menu");
}

function insertMenu(){
	$("#popMenuCode").attr("disabled", false);
	var menuCode = $("#popMenuCode").val();
	var menuNmKo = $("#popMenuNmKo").val();
	var menuNmEn = $("#popMenuNmEn").val();
	var userMenuUrl =$("#popMenuUrl").val();
	var topMenuCode = $("#topMenuCode").val();
	var parntsMenuCode = $("#parntsMenuCode").val();
	var menuDp = $("#menuDp").val();
	if(document.getElementById("used22").checked == true){
		var useAt = "Y"
	}
	if(document.getElementById("not_used22").checked == true){
		var useAt = "N"
	}
	
	if(menuNmKo == null || menuNmKo == ""){
		alert("<spring:message code='A0822' text='메뉴명을 입력해주세요.' />");
		return false;
	}
	if(menuNmEn == null || menuNmEn == ""){
		alert("<spring:message code='A0823' text='메뉴명(영문)을 입력해주세요.' />");
		return false;
	}
	
	var obj = new Object();
	
	obj.menuCode = menuCode;
	obj.menuNmKo = menuNmKo;
	obj.menuNmEn = menuNmEn;
	obj.userMenuUrl = userMenuUrl;
	obj.topMenuCode = topMenuCode;
	obj.parntsMenuCode = parntsMenuCode;
	obj.menuDp = menuDp;
	obj.useAt = useAt;
	obj.sortOrdr = menuTree.getNodesByFilter(function(node){if(node.pId==topMenuCode){return node;}},false).length;
	obj.linkTy = $("input[name=system_link_ty1]:checked").val();
	$.ajax({
		url : "${pageContext.request.contextPath}/insertSystemMenu",
		data : JSON.stringify(obj),
		method : 'POST',
		contentType : "application/json; charset=utf-8",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	}).success(function(result) {
		alert('<spring:message code="A0578" text="메뉴가 추가 되었습니다."/>');
		hidePopup("lyr_add_menu");
		$("#popMenuCode").attr("disabled", true);
		location.reload();
// 		menuList();
	}).fail(function(result) {
		console.log("menu detail search error");
	});
	
	
}

function detailReset(event){
	var menuCode = $("#menuCode").val();
	var topMenuCode = $("#resetTopMenuCode").val();
	var resetMenu = $("#resetMenu").val();
	if(resetMenu == "menu1"){
		menuDetail(event,menuCode,topMenuCode);
	}else if(resetMenu == "menu2") {
		menuDetail2(event,menuCode,topMenuCode);
	}else if(resetMenu == "menu3"){
		menuDetail3(event,menuCode,topMenuCode);
	}
}

</script>
</body>
</html>
