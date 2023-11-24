<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- .tabBox -->
<div class="tabBox">
	<ul class="lst_tab">
		<li><a href="${pageContext.request.contextPath}/analysis/vocAnalysisMain?pageContents=keyowrd&lang=${lang}"><spring:message code="A0503" text="고빈도 키워드" /></a></li>
		<li><a href="${pageContext.request.contextPath}/analysis/vocAnalysisMain?pageContents=classification&lang=${lang}"><spring:message code="A0514" text="인입원인 분류" /></a></li>
		<li><a class="active" href="${pageContext.request.contextPath}/analysis/vocAnalysisMain?pageContents=management&lang=${lang}"><spring:message code="A0519" text="부정/민원 고객 관리" /></a></li>
	</ul>
</div>
<!-- //.tabBox -->
<!-- 검색조건 -->
<div class="srchArea">
	<table class="tbl_line_view" summary="업무구분,카테고리,화자로 구성됨">
		<caption class="hide">검색조건</caption>
		<colgroup>
			<col width="80"><col><col width="80"><col><col width="80">
			<col>
			<!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
		</colgroup>
		<tbody>
		<tr>
			<th scope="row"><spring:message code="A0504" text="상담일자" /></th>
			<td>
				<div class="iptBox">
					<input type="text" name="fromDate" id="fromDate" class="ipt_date" autocomplete="off">
				</div>
				<span>-</span>
				<div class="iptBox">
					<input type="text" name="toDate" id="toDate" class="ipt_date" autocomplete="off">
				</div>
			</td>
			<%-- <th>업무구분</th>
			<td>
				<select class="select">
					<option>I/B</option>
					<option>O/B</option>
				</select>
			</td>
			<th>카테고리</th>
			<td>
				<select class="select">
					<option>222</option>
				</select>
			</td> --%>
		</tr>
		<tr>
			<th scope="row"><spring:message code="A0527" text="화자" /></th>
			<td>
				<select id="speaker-sel" class="select">
					<option value="%" selected><spring:message code="A0530" text="전체" /></option>
					<option value="ST0001"><spring:message code="A0529" text="고객" /></option>
					<option value="ST0002"><spring:message code="A0410" text="상담원" /></option>
					<%-- <option>모노</option> --%>
				</select>
			</td>
			<th style="font-size: 11px;"><spring:message code="A0520" text="키워드명" /></th>
			<td>
				<div class="iptBox w100">
					<input type="text" id="keyword-ipt" class="ipt_txt" autocomplete="off">
				</div>
			</td>
			<!-- <th>콜구분</th>
			<td>
				<select class="select">
					<option>222</option>
				</select>
			</td> -->
		</tr>
		</tbody>
	</table>
		<input type="text" id="keyword-ipt" class="ipt_txt" autocomplete="off" style="opacity: 0; pointer-events: none;">
	<!-- //검색조건 -->
	<div  class="btnBox sz_small line">
		<button id="neg-search-btn" type="button" class="btnS_basic" onclick="search()" id="search"><spring:message code="A0528" text="검색" /></button>
	   <%-- <button type="button" id="export" class="btnS_basic">다운로드</button>--%>
	</div>
</div>
<!-- tbl_lstViewBox -->
<div class="tbl_lstViewBox">
	<div class="lstBox">
		<div class="h4Box">
			<h4><spring:message code="A0522" text="불만키워드" /></h4>
			<%-- <div class="fr">
				<dl>
					<dt><spring:message code="A0523" text="불만 콜수" /></dt>
					<dd><span id="total-neg-call" class="count_num">${callNumDTO.negCall}</span>건</dd>
				</dl>
				<dl>
					<dt><spring:message code="A0524" text="총 콜수" /></dt>
					<dd><span id="total-call" class="count_num">${callNumDTO.totalCall}</span>건</dd>
				</dl>
			</div> --%>
		</div>
		<div class="tbl_customTd scroll">
			<table class="tblType01" summary="키워드명,건수로 구성됨">
				<caption class="hide">인입원인 목록</caption>
				<colgroup>
					<col><col>
					<!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
				</colgroup>
				<thead>
				<tr>
					<th scope="col"><spring:message code="A0520" text="키워드명" /></th>
					<th scope="col" class="al_r"><spring:message code="A0509" text="건수" /></th>
				</tr>
				</thead>
				<tbody id="keyword-list-body">
					<input type="hidden" name="keyword" value=""/>
					<tr>
						<td scope="row" colspan="2" class="dataNone"><spring:message code="A0257" text="등록된 데이터가 없습니다." /></td>
					</tr>
				</tbody>
			</table>
		</div>

		<jsp:include page="./analysisPaging.jsp">
			<jsp:param name="pagingId" value="keyword-paging"/>
			<jsp:param name="pageContents" value="management"/>
		</jsp:include>
	</div>
	<div class="viewBox">
		<div class="h4Box">&nbsp;</div>
		<div class="tbl_customTd scroll">
			<table class="tblType01" summary="고객ID,고객연락처,상담일시,용례문장(원문), 청취로 구성됨">
				<caption class="hide">원문 목록</caption>
				<colgroup>
					<col width="80"><col width="140"><col width="150"><col><col width="50">
					<!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
				</colgroup>
				<thead>
				<tr>
					<th scope="col" style="min-width: 120px;"><spring:message code="A0525" text="고객ID" /></th>
					<th scope="col"><spring:message code="A0526" text="고객연락처" /></th>
					<th scope="col"><spring:message code="A0504" text="상담일시" /></th>
					<th scope="col"><spring:message code="A0513" text="용례 문장(원문)" /></th>
					<th scope="col" style="width: 60px;"><spring:message code="A0249" text="청취" /></th>
				</tr>
				</thead>
				<tbody id="neg-list-body">
					<tr>
						<td scope="row" colspan="5" class="dataNone"><spring:message code="A0720" text="검색된 데이터가 없습니다." /></td>
					</tr>
				</tbody>
			</table>
		</div>

		<jsp:include page="./analysisPaging.jsp">
			<jsp:param name="pagingId" value="result-paging"/>
			<jsp:param name="pageContents" value="management"/>
		</jsp:include>
	</div>
</div>
<%@ include file="sttTextModal.jsp"%>


<script type="text/javascript">
	$(document).ready(function (){
		// GCS iframe
		$('.gcsWrap', parent.document).each(function(){
			//header 화면명 변경
			var pageTitle = $('title').text().replace('> FAST AICC', '');

			$(top.document).find('#header h2 a').text(pageTitle);
		});

		var lang = $.cookie("lang");
        
        if(lang == null || lang == "ko"){
	        //datetimepicker
	        $('#fromDate').datepicker({
	            format : "yyyy-mm-dd",
	            language : "ko",
	            autoclose : true,
	            todayHighlight : true
	        });
	
	        $('#toDate').datepicker({
	            format : "yyyy-mm-dd",
	            language : "ko",
	            autoclose : true,
	            todayHighlight : true
	        });
        }else if(lang == "en"){
	        //datetimepicker
	        $('#fromDate').datepicker({
	            format : "yyyy-mm-dd",
	            language : "en",
	            autoclose : true,
	            todayHighlight : true
	        });
	
	        $('#toDate').datepicker({
	            format : "yyyy-mm-dd",
	            language : "en",
	            autoclose : true,
	            todayHighlight : true
	        });
        }

		//table
		$('.tbl_lstViewBox .tblType01 tbody td .lnk').on('click',function(){
			$('.tbl_lstViewBox .tblType01 tbody td .lnk').removeClass('active');
			$(this).addClass('active');
		});

		setDate();

		//키워드별 검색 결과 표시
		showResultByKeyword();
		//검색후 키워드 업데이트
		search();
	});

	function showResultByKeyword(){
		var keywordTbody = $("#keyword-list-body");

		var page = $("#result-paging").find('input[name="cur-page"]').val();
		var amount = $("#result-paging").find('input[name="amount"]').val();

		keywordTbody.off("click").on("click", "tr", function(e){
			e.preventDefault();

			$("#keyword-list-body").find('input[name="keyword"]').val($(this).find("a").text());

			getResult(page,amount);
		})        
	}

	function getResult(page,amount){
		var fromDate = $("#fromDate").val();
		var toDate = $("#toDate").val();
		var keyword = $("#keyword-list-body").find('input[name="keyword"]').val();
		var speakerCode = $("#speaker-sel option:selected").val();

		var page = $("#result-paging").find('input[name="cur-page"]').val();
		var amount = $("#result-paging").find('input[name="amount"]').val();

		var lang = "${lang}";

		var sendData = {
			"page":(page-1)*amount,
			"amount":amount,
			"fromDate":fromDate,
			"toDate":toDate,
			"keyword":keyword,
			"speakerCode":speakerCode,
			"vocLang":(lang === 'ko') ? 'KOR' : 'ENG',
		};
		console.log("getResult:");
		console.log(sendData);

		$.ajax({
			type:"POST",
			url: "${pageContext.request.contextPath}/analysis/negativeCustomerManagement/updateResultByKeyword",
			data:sendData,
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(data){

				var receivedData = JSON.parse(data);
				//console.log(receivedData);

				//키워드 페이지 초기화
				$("#keyword-paging").find("span").html("");


				var negListBody = $("#neg-list-body");
				if(receivedData.negList.length !== 0){
					negListBody.html("");

					for(var i=0; i<receivedData.negList.length; i++){

						var html = '<tr>\n' +
								' <td scope="row">' + receivedData.negList[i].custId + '</td>\n' +
								' <td><span class="phone_num">' + receivedData.negList[i].telNo + '</span></td>\n' +
								' <td>' + receivedData.negList[i].consultTime + '</td>\n' +
								' <td>' + receivedData.negList[i].sentence + '</td>\n' +
								' <td><a class="btn_ico_line" href="#none" onclick=openPopup("' + receivedData.negList[i]['callId'] + '")><span class="fas fa-volume-up" aria-hidden="true"></span></a></td>\n' +
								' </tr>';

						negListBody.append(html);

					}

					goPage(receivedData.pagingVO, "result");
				}
				else{
					negListBody.html(' <tr>\n' +
							'<td scope="row" colspan="5" class="dataNone"><spring:message code="A0720" text="검색된 데이터가 없습니다." /></td>\n' +
							'</tr>');
				}

			},
			error:function(){
				console.log("updateResultByKeyword error");
			},
		});
	}

	function search() {
		var fromDate = $("#fromDate").val();
		var toDate = $("#toDate").val();
		var keyword = $("#keyword-ipt").val();
		var speakerCode = $("#speaker-sel option:selected").val();

		var page = $("#keyword-paging").find('input[name="cur-page"]').val();
		var amount = $("#keyword-paging").find('input[name="amount"]').val();

		var lang = "${lang}";
		
		var sendData = {
			"page":(page-1)*amount,
			"amount":amount,
			"fromDate":fromDate,
			"toDate":toDate,
			"keyword":keyword,
			"speakerCode":speakerCode,
			"vocLang":(lang === 'ko') ? 'KOR' : 'ENG',
		};

		$.ajax({
			type:"POST",
			url: "${pageContext.request.contextPath}/analysis/negativeCustomerManagement/getSearchResult",
			data:sendData,
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(data) {

				var receivedData = JSON.parse(data);
				console.log("search: ");
				console.log(receivedData);

				///촐 콜수, 불만 콜수 업데이트
				getCallNum(sendData);

				//결과창 초기화
				var negListBody = $("#neg-list-body");
				negListBody.html(' <tr>\n' +
					'<td scope="row" colspan="5" class="dataNone"><spring:message code="A0720" text="검색된 데이터가 없습니다." /></td>\n' +
					'</tr>');

				//결과 페이지 초기화
				$("#result-paging").find("span").html("");

				var keywordListBody = $("#keyword-list-body");
				keywordListBody.html("");

				if(receivedData.keywordList.length != 0){
					for(var i=0; i<receivedData.keywordList.length; i++){

						var html = '<tr style="cursor:pointer;">\n' +
								'<input type="hidden" name="keyword" value=""/>\n' +
								'<td scope="row"><a class="lnk" href="#none">'+receivedData.keywordList[i].keyword+'</a></td>\n' +
								'<td class="al_r"><span class="count_num">'+receivedData.keywordList[i].cnt+'</span></td>\n' +
								'</tr>';
						//console.log(html);
						keywordListBody.append(html);

					}
				
					goPage(receivedData.pagingVO, "keyword");
				}
				else{
					var html = '<tr>\n' +
							'<td scope="row" colspan="2" class="dataNone"><spring:message code="A0257" text="등록된 데이터가 없습니다." /></td>\n' +
							'</tr>';
					keywordListBody.append(html);
				}
			},
			error:function(){
				console.log("updateResultByKeyword error");
			},
		});
	}

	function getCallNum(data){
		
		$.ajax({
			type:"POST",
			url: "${pageContext.request.contextPath}/analysis/negativeCustomerManagement/updateCallNum",
			data:data,
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(data) {
				//console.log(data);
				var receivedData = JSON.parse(data);
				console.log(receivedData);
			   
				$("#total-call").text(receivedData.totalCall);
				$("#total-neg-call").text(receivedData.negCall);
			},
			error:function(){
				console.log("updateCallNum error");
			},
		});
	}

</script>
