<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!-- .tabBox -->
<div class="tabBox">
    <ul class="lst_tab">
        <li><a href="${pageContext.request.contextPath}/analysis/vocAnalysisMain?pageContents=keyowrd&lang=${lang}"><spring:message code="A0503" text="고빈도 키워드" /></a></li>
        <li><a class="active" href="${pageContext.request.contextPath}/analysis/vocAnalysisMain?pageContents=classification&lang=${lang}"><spring:message code="A0514" text="인입원인 분류" /></a></li>
        <li><a href="${pageContext.request.contextPath}/analysis/vocAnalysisMain?pageContents=management&lang=${lang}"><spring:message code="A0519" text="부정/민원 고객 관리" /></a></li>
    </ul>
</div>
<!-- //.tabBox -->
<!-- 검색조건 -->
<div class="srchArea">
    <table class="tbl_line_view" summary="상담일자,업무구분,카테고리로 구성됨">
        <caption class="hide">검색조건</caption>
        <colgroup>
            <col width="80"><col width="300"><col width="80"><col>
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

            <th><spring:message code="A0515" text="카테고리" /></th>
            <td>
                <select class="select" style="width:120px;" id="category1">
                    <option value=""><spring:message code="A0530" text="전체" /></option>
                </select>
                <select class="select" style="width:120px;" id="category2">
                    <option value=""><spring:message code="A0530" text="전체" /></option>
                </select>
                <select class="select" style="width:120px;" id="category3">
                    <option value=""><spring:message code="A0530" text="전체" /></option>
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
            <table class="tblType01" summary="대분류,중분류,소분류, count로 구성됨">
                <caption class="hide">인입원인 목록</caption>
                <colgroup>
                    <col><col><col><col>
                    <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
                </colgroup>
                <thead>
                <tr>
                    <th scope="col"><spring:message code="A0516" text="대분류" /></th>
                    <th scope="col"><spring:message code="A0517" text="중분류" /></th>
                    <th scope="col"><spring:message code="A0518" text="소분류" /></th>
                    <th scope="col" class="al_r">COUNT</th>
                </tr>
                </thead>
                <tbody id="tbody">
                <tr>
                    <td scope="row" colspan="4" class="dataNone"><spring:message code="A0257" text="등록된 데이터가 없습니다." /></td>
                </tr>
                </tbody>
            </table>
        </div>

        <jsp:include page="./analysisPaging.jsp">
            <jsp:param name="pagingId" value="result-paging"/>
            <jsp:param name="pageContents" value="classification"/>
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
            <jsp:param name="pageContents" value="classification"/>
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
    });

    function search() {
        var startDate = $('#fromDate').val();
        var endDate = $('#toDate').val();
        var category1 = $('#category1').val();
        var category2 = $('#category2').val();
        var category3 = $('#category3').val();

        var lang = "${lang}";

        var page = $("#result-paging").find('input[name="cur-page"]').val();
        var amount = $("#result-paging").find('input[name="amount"]').val();

        var sendData = {
            startDate: startDate,
            endDate: endDate,
            category1: category1,
            category2: category2,
            category3: category3,
            page: (page-1)*amount,
            amount: amount,
            vocLang:(lang === "ko") ? "KOR" : "ENG",
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/getHmdResult",
            method : 'POST',
            data: sendData,
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            }
        }).done(function (data) {
            $("result-paging").find("span").html("");
            $("#result-detail-paging").find("span").html("");

            if(data.list.length != 0) {
                initDetail();

                var template = "";
                data.list.forEach(function(item, idx){
                    template +=
                        "<tr style='cursor: pointer;' onclick=\"searchDetail('" + item['category1'] + "','" + item['category2'] + "','" + item['category3'] + "')\">" +
                            "<td scope='row'><a class='lnk' href='#none'>" + item['category1'] + "</a></td>" +
                            "<td><a class='lnk' href='#none'>" + item['category2'] + "</a></td>" +
                            "<td><a class='lnk' href='#none'>" + item['category3'] + "</a></td>" +
                            "<td class='al_r'><span class='count_num'>" + item['count'] + "</span></td>" +
                        "</tr>";

                    if(data.list.length -1 === idx) {
                        $('#tbody').empty();
                        $('#tbody').append(template);
                    }
                });              
                
                goPage(data.pagingVO, "result");
               
            } else {
                var template =
                    "<tr>" +
                    "   <td scope='row' colspan='4' class='dataNone'><spring:message code='A0257' text='등록된 데이터가 없습니다.' /></td>" +
                    "</tr>";
                $('#tbody').empty();
                $('#tbody').append(template);
            }
        });
    }

    function searchDetail(category1, category2, category3) {
        var startDate = $('#fromDate').val();
        var endDate = $('#toDate').val();

        var lang = "${lang}";

        var page = $("#result-detail-paging").find('input[name="cur-page"]').val();
        var amount = $("#result-detail-paging").find('input[name="amount"]').val();

        $("#result-detail-paging").find('input[name="category1"]').val(category1);
        $("#result-detail-paging").find('input[name="category2"]').val(category2);
        $("#result-detail-paging").find('input[name="category3"]').val(category3);

        var sendData = {
            startDate: startDate,
            endDate: endDate,
            category1: category1,
            category2: category2,
            category3: category3,
            page: (page-1)*amount,
            amount: amount,
            vocLang:(lang === "ko") ? "KOR" : "ENG",
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/getHmdResultDetail",
            method : 'POST',
            data: sendData,
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            }
        }).done(function (data) {
            if(data.list.length != 0) {
                var template = "";
                data.list.forEach(function(item, idx){
                    template +=
                        "<tr>" +
                            "<td scope='row'><span class='phone_num'>" + item['telNo'] + "</span></td>" +
                            "<td>" + item['createdDtm'] + "</td>" +
                            "<td>" + item['speaker'] + "</td>" +
                            "<td>" + item['sentence'] + "</td>" +
                            "<td><a class='btn_ico_line btn_lyr_open' href='#none;' onclick=openPopup('" + item['callId']+ "')><span class='fas fa-volume-up' aria-hidden='true'>" +
                                "</span></a></td>" +
                        "</tr>";
                    if(data.list.length -1 === idx) {
                        $('#tbody2').empty();
                        $('#tbody2').append(template);
                    }
                });               
               
                goPage(data.pagingVO, "result-detail");
               
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