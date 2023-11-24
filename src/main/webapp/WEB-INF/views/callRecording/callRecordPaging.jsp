<%--
  Created by IntelliJ IDEA.
  User: hoseop
  Date: 20. 5. 4.
  Time: 오전 10:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="paging">
    <input type="hidden" name="total-page" value=""/>
    <input type="hidden" name="cur-page" value="1"/>
    <input type="hidden" name="amount" value="15"/>
    <a class="btn_paging_first"
       href="#none">처음 페이지로
        이동</a>
    <a class="btn_paging_prev"
       href="#none">이전 페이지로
        이동</a>
    <span class="list">
                        </span>
    <a class="btn_paging_next"
       href="#none">다음 페이지로
        이동</a>
    <a class="btn_paging_last"
       href="#none">마지막 페이지로
        이동</a>
</div>

<script type="text/javascript">
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
            $(".paging").find('input[name="cur-page"]').val(page);

            search();
        });
    }

    function goPage(data) {

        console.log("goPage: ");
        console.log(data);

        var html = '';
        for (var i = data.pageRangeStart; i <= data.pageRangeEnd; i++) {
            if (data.currentPage === i) {
                html += '<strong>' + i + '</strong>\n';
            } else {
                html += '<a href="#none">' + i + '</a>';
            }
        }

        $(".paging").find("span").html("");
        $(".paging").find("span").append(html);
        $(".paging").find('input[name="total-page"]').val(data.totalPage);

    }
</script>

