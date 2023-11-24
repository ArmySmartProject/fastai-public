<%--
  Created by IntelliJ IDEA.
  User: hoseop
  Date: 20. 4. 22.
  Time: 오전 11:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div id="${param.pagingId}" class="paging">
    <input type="hidden" name="total-page" value="" />
    <input type="hidden" name="cur-page" value="1" />

    <c:if test="${param.pageContents eq 'classification'}">
        <c:if test="${param.pagingId eq 'result-paging'}">
            <input type="hidden" name="amount" value="20" />
        </c:if>
        <c:if test="${param.pagingId eq 'result-detail-paging'}">
            <input type="hidden" name="amount" value="15" />
            <input type="hidden" name="category1" value="" />
            <input type="hidden" name="category2" value="" />
            <input type="hidden" name="category3" value="" />
        </c:if>
    </c:if>
    <c:if test="${param.pageContents eq 'management'}">
        <c:if test="${param.pagingId eq 'keyword-paging'}">
            <input type="hidden" name="amount" value="20" />
        </c:if>
        <c:if test="${param.pagingId eq 'result-paging'}">
            <input type="hidden" name="amount" value="15" />
        </c:if>
    </c:if>
    <c:if test="${param.pageContents eq 'highFrequencyKeyword'}">
        <c:if test="${param.pagingId eq 'result-paging'}">
            <input type="hidden" name="amount" value="20" />
        </c:if>
        <c:if test="${param.pagingId eq 'result-detail-paging'}">
            <input type="hidden" name="amount" value="15" />
            <input type="hidden" name="keyword" value="" />
        </c:if>
    </c:if>

    <a class="btn_paging_first" href="#none">처음 페이지로 이동</a>
    <a class="btn_paging_prev" href="#none">이전 페이지로 이동</a>
    <span class="list">
    </span>
    <a class="btn_paging_next" href="#none">다음 페이지로 이동</a>
    <a class="btn_paging_last" href="#none">마지막 페이지로 이동</a>
</div>

<script>
    $(document).ready(function(){
        //페이징 이벤트 처리
        pagingHandler();
    })

    function pagingHandler(){
        var pagingDiv = $(".paging");

        pagingDiv.off("click").on("click", "a", function(e){
            e.preventDefault();

            var page = 0;

            if($(e.target).hasClass("btn_paging_first")){
                if(parseInt($(e.target).parent().find("strong").text()) <= 1){
                    //alert("첫번째 페이지 입니다");
                    return;
                }
                page = 1;
            }
            else if($(e.target).hasClass("btn_paging_prev")){
                page = parseInt($(e.target).parent().find("strong").text()) - 1;
                if(page < 1){
                    //alert("첫번째 페이지 입니다");
                    return;
                }
            }
            else if($(e.target).hasClass("btn_paging_next")){
                page = parseInt($(e.target).parent().find("strong").text()) + 1;
                console.log(page + "," + $(e.target).parent().find('input[name="total-page"]').val());
                if(page > $(e.target).parent().find('input[name="total-page"]').val()){
                    //alert("마지막 페이지 입니다");
                    return;
                }
            }
            else if($(e.target).hasClass("btn_paging_last")){
                if(parseInt($(e.target).parent().find("strong").text()) >= $(e.target).parent().find('input[name="total-page"]').val()){
                    //alert("마지막 페이지 입니다");
                    return;
                }
                page = $(e.target).parent().find('input[name="total-page"]').val();
            }
            else{
                page = parseInt($(e.target).text());
            }

            console.log("pagingHandler: " + page);

            var pageContents = "${param.pageContents}";
            if(pageContents === 'management') {
                if ($(e.target).parent().is("#result-paging") || $(e.target).parent().parent().is("#result-paging")) {
                    $("#result-paging").find('input[name="cur-page"]').val(page);
                    getResult();
                }
                if ($(e.target).parent().is("#keyword-paging") || $(e.target).parent().parent().is("#keyword-paging")) {
                    $("#keyword-paging").find('input[name="cur-page"]').val(page);
                    search();
                }
            }
            else if(pageContents === 'classification'){
                if($(e.target).parent().is("#result-paging") || $(e.target).parent().parent().is("#result-paging")){
                    $("#result-paging").find('input[name="cur-page"]').val(page);
                    search();
                }
                if($(e.target).parent().is("#result-detail-paging") || $(e.target).parent().parent().is("#result-detail-paging")){
                    $("#result-detail-paging").find('input[name="cur-page"]').val(page);

                    var category1 = $("#result-detail-paging").find('input[name="category1"]').val();
                    var category2 = $("#result-detail-paging").find('input[name="category2"]').val();
                    var category3 = $("#result-detail-paging").find('input[name="category3"]').val();
                    searchDetail(category1, category2, category3);
                }
            }
            else if(pageContents === 'highFrequencyKeyword'){
                if($(e.target).parent().is("#result-paging") || $(e.target).parent().parent().is("#result-paging")){
                    $("#result-paging").find('input[name="cur-page"]').val(page);
                    search();
                }
                if($(e.target).parent().is("#result-detail-paging") || $(e.target).parent().parent().is("#result-detail-paging")){
                    $("#result-detail-paging").find('input[name="cur-page"]').val(page);
                    var keyword = $("#result-detail-paging").find('input[name="keyword"]').val();
                    searchDetail(keyword);
                }
            }
            else{
                console.log("pagingHandler > corrupted pageContents");
            }
        });
    }

    function goPage(data, pType){

        console.log(pType + " goPage: ");
        console.log(data);

        var html = '';
        for(var i=data.pageRangeStart; i<=data.pageRangeEnd; i++){
            if(data.currentPage === i){
                html += '<strong>' + i + '</strong>\n';
            }
            else{
                html += '<a href="#none">' + i + '</a>';
            }
        }

        var pageContents = "${param.pageContents}";
        if(pageContents === 'management') {
            if(pType === "result"){
                $("#result-paging").find("span").html("");
                $("#result-paging").find("span").append(html);
                $("#result-paging").find('input[name="total-page"]').val(data.totalPage);
            }
            else if(pType === "keyword"){
                $("#keyword-paging").find("span").html("");
                $("#keyword-paging").find("span").append(html);
                $("#keyword-paging").find('input[name="total-page"]').val(data.totalPage);
            }
            else{
                console.log("corrupted pType");
            }
        }
        else if((pageContents === 'classification') || (pageContents === 'highFrequencyKeyword')){
            if(pType === "result"){
                $("#result-paging").find("span").html("");
                $("#result-paging").find("span").append(html);
                $("#result-paging").find('input[name="total-page"]').val(data.totalPage);
            }
            else if(pType === "result-detail"){
                $("#result-detail-paging").find("span").html("");
                $("#result-detail-paging").find("span").append(html);
                $("#result-detail-paging").find('input[name="total-page"]').val(data.totalPage);
            }
            else{
                console.log("corrupted pType");
            }
        }
        else{
            console.log("goPage > corrupted pageContents");
        }
    }
</script>
