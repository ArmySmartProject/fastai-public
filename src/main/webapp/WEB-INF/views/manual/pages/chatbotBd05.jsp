<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>답변불가 대화현황 조회</h4>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/68629376/91417723-2f9b6500-e88c-11ea-88da-22d7c67fef6d.png" alt="답변불가 대화현황 조회 화면">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    좌측 상단의 기간을 설정하여 조회 가능합니다.
  </li>
  <li>
    <span class="list_type">-</span>
    검색창에서는 순번, 챗봇, 질문, 사용자 Id 를 설정하여 검색 가능 합니다.
  </li>
  <li>
    <span class="list_type">-</span>
    순번은 숫자만 검색가능하며 숫자가 아닌 경우 alert창이 나옵니다.
  </li>
  <li>
    <span class="list_type">-</span>
    순번은 Integer 타입으로 Database에서 부분검색이 지원되지 않습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    목록에서는 순번, 챗봇이름, 답변이 불가한 질문, 사용자Id, 대화시간을 확인할 수 있습니다.
  </li>
</ul>
