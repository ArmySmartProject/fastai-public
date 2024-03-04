<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 메뉴 경로 설정 -->
<title>${cours}</title>
<!-- icon_favicon -->
<link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/resources/images/ico_favicon_64x64.png">
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/ico_favicon_64x64.ico">
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/ico_favicon_60x60.png"><!-- 윈도우즈 사이트 아이콘, HiDPI/Retina 에서 Safari 나중에 읽기 사이드바 -->
<!-- resources -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/font.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/all.css">
<!--<link rel="stylesheet" type="text/css" href="/${pageContext.request.contextPath}/resources/css/datepicker.css">
<link rel="stylesheet" type="text/css" href="/${pageContext.request.contextPath}/resources/css/jquery.datetimepicker.css">-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap-datetimepicker.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap-datepicker.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/ui.jqgrid.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/zTreeStyle.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/fast_aicc.css">

	<!-- Global site tag (gtag.js) - Google Analytics -->
<%--<c:if test="${siteCustom eq 'maumAi'}">--%>
<%--	<script async src="https://www.googletagmanager.com/gtag/js?id=G-8MFFNEJ9MF"></script>--%>
<%--	<script>--%>
<%--	  window.dataLayer = window.dataLayer || [];--%>
<%--	  function gtag(){dataLayer.push(arguments);}--%>
<%--	  gtag('js', new Date());--%>
<%--	  gtag('config', 'G-8MFFNEJ9MF');--%>
<%--	</script>--%>
<%--</c:if>--%>

<!-- library -->
<!-- <script type="text/javascript" src="/${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script> -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-migrate-3.3.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.cookie.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap-multiselect.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script><!-- 03_19 -->

<!-- 추가 2019.12.11-->
<!-- fontAwesome 다운받지 않아도 아이콘 정상 표시됨 -->
<!--<script type="text/javascript" src="/${pageContext.request.contextPath}/resources/js/all.js"></script>-->
<!-- 공통 script -->
<!-- datetimepicker -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/moment.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ko.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.timer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.jqgrid.src.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/Chart.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/utils.js"></script>

<!-- locale -->
<!-- <script type="text/javascript" src="/${pageContext.request.contextPath}/resources/locale/locale_ko.js"></script>
<script type="text/javascript" src="/${pageContext.request.contextPath}/resources/locale/locale_en.js"></script> -->
<!-- locale end -->


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.ztree.all.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jszip.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/grid.locale-kr.js"></script>

<!-- word cloud -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jqcloud.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>

<!-- kakao 주소 api -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/postcode.v2.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/swiper.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/swiper.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/player.js"></script>

<script>
	var userId = "${user.userId}";

	/** 실시간 화면 업데이트 관련 소켓 처리 **/
	// 상담사 상태 업데이트 > 대쉬보드 반영
	var update_ws = null;
	function updateOpStatusSocket(type){

		if(type == "conn"){
			var update_url = "${proxyUrl}/updateOpStatus"; //90배포용
			update_ws = new WebSocket(update_url);

			// 중복로그인 처리 소켓이 열렸을때 중복 로그인관련 메세지를 전체소켓에 브로드캐스팅 한다.
			update_ws.onopen = function() {
				update_ws.send("duplicate|"+userId);
			};

			//
			update_ws.onmessage = function(e) {
				// 중복 로그인 메시지가 도착했을때 해당 메세지에서 id를 발췌하여 현재 로그인한 id와 같다면 중복 로그인 에러를 발생시킨다.
				if(e.data.indexOf("duplicate")>-1){
					var id = e.data.replace("duplicate|","");
					if(id==userId){
						window.location.href="/authority_duplicate_login";
					}
				}else if(e.data == "update"){//상담 현황 업데이트
					if(getResAndCsCondition){
						var json = {};
						//var searchType = $("#searchType").val();
						var startDt = $("#fromDate").val();
						var endDt = $("#toDate").val();

						//json.searchType = searchType;
						json.startDt = startDt;
						json.endDt = endDt;
						getResAndCsCondition(json, "cs");
					}
					if($(".consultStatus button.active").length>0)
					{
						var json = new Object();
						var jsonObj= new Object();

						json.CUST_OP_STATUS = $(".consultStatus button.active").val();
						jsonObj.CsDtlOpStatus=json;
						jsonObj.updateYn = "N";

						ajaxCall("${pageContext.request.contextPath}/getOpIbState", $("#headerName").val(), $("#token").val(),	JSON.stringify(jsonObj), "N");
					}
				}
			}
		}else if(type == "update"){
			if(update_ws != null){
				update_ws.send("update");
			}
		}else if(type == "duplicate"){
			if(update_ws != null){
				update_ws.send("duplicate");
			}
		}

	}
	updateOpStatusSocket("conn")
</script>
<!--[if lte IE 9]>
<script src="${pageContext.request.contextPath}/resources/js/html5shiv.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/respond.min.js"></script>


<div class="lyrWrap">
    <div class="lyr_bg ie9"></div>
    <div class="lyrBox">
        <div class="lyr_top">
            <h3>브라우저 업데이트 안내</h3>
         </div>
        <div class="lyr_mid">
            <div class="legacy-browser">
현재 사용중인 브라우저는 지원이 중단된 브라우저입니다.<br>
원활한 온라인 서비스를 위해 브라우저를 <a href="http://windows.microsoft.com/ko-kr/internet-explorer/ie-11-worldwide-languages" target="_blank">최신 버전</a>으로 업그레이드 해주세요.
            </div>
        </div>
        <div class="lyr_btm">
            <div class="btnBox sz_small">
                <button class="btn_win_close">창 닫기</button>
            </div>
        </div>
    </div>
</div>
<![endif]-->
