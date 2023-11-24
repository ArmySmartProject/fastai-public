<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!-- .tabBox -->
<div class="tabBox">
    <ul class="lst_tab">
        <li><a class="active" href="${pageContext.request.contextPath}/analysis/vocAnalysisMain?pageContents=keyowrd&lang=${lang}"><spring:message code="A0503" text="고빈도 키워드" /></a></li>
        <li><a href="${pageContext.request.contextPath}/analysis/vocAnalysisMain?pageContents=classification&lang=${lang}"><spring:message code="A0514" text="인입원인 분류" /></a></li>
        <li><a href="${pageContext.request.contextPath}/analysis/vocAnalysisMain?pageContents=management&lang=${lang}"><spring:message code="A0519" text="부정/민원 고객 관리" /></a></li>
    </ul>
</div>
<!-- //.tabBox -->
<!-- 검색조건 -->
<div class="srchArea">
    <table class="tbl_line_view" summary="상담일자,업무구분,유형검색,DB별 최종 값 기준으로 구성됨">
        <caption class="hide">검색조건</caption>
        <colgroup>
            <col width="80"><col width="300"><col width="80"><col><col width="150">
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
            <th><spring:message code="A0527" text="화자" /></th>
            <td>
                <select class="select" style="width: 150px;" id="speakerCode">
                    <option value="" selected><spring:message code="A0530" text="전체" /></option>
                    <option value="ST0001"><spring:message code="A0529" text="고객" /></option>
                    <option value="ST0002"><spring:message code="A0410" text="상담원" /></option>
                </select>
            </td>
        </tr>
        </tbody>
    </table>
    <!-- //검색조건 -->
    <div class="btnBox sz_small line">
        <button type="button" class="btnS_basic" onclick="search()" id="search"><spring:message code="A0528" text="검색" /></button>
        <%--<button type="button" id="export" class="btnS_basic">다운로드</button>--%>
    </div>
</div>
<!-- tbl_lstViewBox -->
<div class="tbl_lstViewBox">
    <div class="lstBox">
        <div class="tbl_customTd scroll">
            <table class="tblType01" summary="고빈도 키워드,건수,연관어 구성됨">
                <caption class="hide">고빈도 키워드 목록</caption>
                <colgroup>
                    <col width="70"><col width="70"><col>
                    <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                </colgroup>
                <thead>
                <tr>
                    <th scope="col" style="min-width: 80px;"><spring:message code="A0508" text="키워드" /></th>
                    <th scope="col"><spring:message code="A0509" text="건수" /></th>
                    <th scope="col"><spring:message code="A0510" text="연관어" /></th>
                </tr>
                </thead>
                <tbody id="tbody">
                    <tr>
                        <td scope="row" colspan="3" class="dataNone"><spring:message code="A0720" text="검색된 데이터가 없습니다." /></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <jsp:include page="./analysisPaging.jsp">
            <jsp:param name="pagingId" value="result-paging"/>
            <jsp:param name="pageContents" value="highFrequencyKeyword"/>
        </jsp:include>
    </div>
    <div class="viewBox">
        <div class="tbl_customTd scroll">
            <table class="tblType01" summary="고객연락처,상담일시,화자, 용례문장(원문), 청취로 구성됨">
                <caption class="hide">원문 목록</caption>
                <colgroup>
                    <col width="110"><col width="150"><col width="70"><col><col width="50">
                    <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                </colgroup>
                <thead>
                <tr>
                    <th scope="col"><spring:message code="A0511" text="고객연락처" /></th>
                    <th scope="col"><spring:message code="A0512" text="상담일시" /></th>
                    <th scope="col"><spring:message code="A0527" text="화자" /></th>
                    <th scope="col"><spring:message code="A0513" text="용례 문장(원문)" /></th>
                    <th scope="col" style="width: 60px;"><spring:message code="A0249" text="청취" /></th>
                </tr>
                </thead>
                <tbody id="tbody2">

                <tr>
                    <td scope="row" colspan="5" class="dataNone"><spring:message code="A0720" text="검색된 데이터가 없습니다." /></td>
                </tr>
                </tbody>
            </table>
        </div>
        <jsp:include page="./analysisPaging.jsp">
            <jsp:param name="pagingId" value="result-detail-paging"/>
            <jsp:param name="pageContents" value="highFrequencyKeyword"/>
        </jsp:include>
    </div>
</div>

<%@ include file="sttTextModal.jsp"%>

<script type="text/javascript">
    $(document).ready(function () {
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
        $('.tbl_lstViewBox .tblType01 tbody td ul.lst_item li a').on('click',function(){
            $('.tbl_lstViewBox .tblType01 tbody td ul.lst_item li a').removeClass('active');
            $(this).addClass('active');
        });

        setDate();

        search();
    })

    function search() {
        var startDate = $('#fromDate').val();
        var endDate = $('#toDate').val();
        var speakerCode = $('#speakerCode').val();

        var page = $("#result-paging").find('input[name="cur-page"]').val();
        var amount = $("#result-paging").find('input[name="amount"]').val();

        var lang = $.cookie("lang");
        console.log("lang: " + lang);
        if(lang === null){
            lang = "ko";
        }

        var data = {
            page: (page-1)*amount,
            amount: amount,
            startDate: startDate,
            endDate: endDate,
            speakerCode: speakerCode,
            lang: lang
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/getHighFrequencyKeyword",
            method : 'POST',
            data: data,
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            }
        }).done(function (data) {
            console.log(data);
            if(data.length != 0) {
                initDetail();
                var template = "";
                data.forEach(function(item, idx){
                    template +=
                        "<tr style='cursor: pointer;' onclick=\"searchDetail('" + item['keyword'] + "')\">" +
                            "<td scope='row'>" + item['keyword'] + "</td>" +
                            "<td><span class='count_num'>" + item['count'] + "</span></td>" +
                            "<td><ul class=lst_item>";
                            item['associatedKeyword'].forEach(function(content, index){
                                template += "<li onclick='event.cancelBubble=true'>" +
                                    "<a href='#none;' onclick=\"searchDetail('" + content['keyword'] +"')\">" +
                                    content['keyword'] + "</a></li>\n"

                               if(content.length -1 == index) {
                                   template += "</td></ul>" +
                                       "</tr>";
                               }
                            });
                    if(data.length -1 === idx) {
                        $('#tbody').empty();
                        $('#tbody').append(template);
                    }
                });
            } else {
                var template =
                    "<tr>" +
                    "   <td scope='row' colspan='3' class='dataNone'><spring:message code='A0720' text='검색된 데이터가 없습니다.' /></td>" +
                    "</tr>";
                $('#tbody').empty();
                $('#tbody').append(template);
            }
        });
    }

    function searchDetail(keyword) {
        $("#result-detail-paging").find('input[name="keywrod"]').val(keyword);

        var startDate = $('#fromDate').val();
        var endDate = $('#toDate').val();
        var speakerCode = $('#speakerCode').val();

        var page = $("#result-detail-paging").find('input[name="cur-page"]').val();
        var amount = $("#result-detail-paging").find('input[name="amount"]').val();

        var lang = $.cookie("lang");
        if(lang === null){
            lang = "ko";
        }

        var data = {
            page: (page-1)*amount,
            amount: amount,
            startDate: startDate,
            endDate: endDate,
            speakerCode: speakerCode,
            keyword: keyword,
            lang: lang
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/getHighFrequencyKeywordDetail",
            method : 'POST',
            data: data,
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            }
        }).done(function(result){
            if(result.length > 0) {
                var totalCount = result[0]['numFound'];
                result = result.splice(1);

                var template = "";
                result.forEach(function(item, idx) {
                    template +=
                        "<tr>" +
                        "   <td scope='row'><span class='phone_num'>" + item['tel_no'] + "</span></td>" +
                        "   <td>" + item['created_dtm'] + "</td>" +
                        "   <td>" + item['speaker'] + "</td>" +
                        "   <td>" + item['sentence'] + "</td>" +
                        "   <td><a class='btn_ico_line' href='#none' onclick=openPopup('" + item['call_id'] + "')><span class='fas fa-volume-up' aria-hidden='true'></span></a></td>" +
                        "</tr>";

                    if(result.length -1 === idx) {
                        $('#tbody2').empty();
                        $('#tbody2').append(template);
                    }
                })
            } else {
                initDetail();
            }
        });
    }

    function initDetail() {
        var template =
            "<tr>" +
            "   <td scope='row' colspan='5' class='dataNone'><spring:message code='A0720' text='검색된 데이터가 없습니다.' /></td>" +
            "</tr>";
        $('#tbody2').empty();
        $('#tbody2').append(template);
    }

</script>