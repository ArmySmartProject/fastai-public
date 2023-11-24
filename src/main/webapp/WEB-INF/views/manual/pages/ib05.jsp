<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>IB콜 상담원별 통계</h4>
<p class="header_desc">IN-BOUND의 기간별 상담원 콜 이력통계 및 필터링, 이력통계 데이터를 다운로드 할 수 있는 화면입니다.</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/50193171/87918729-cddc2400-cab1-11ea-9daa-d277504f26a9.png" alt="IB 상담원별 통계 화면">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            Company
          </span>
    <span class="desc">자신이 속한 Company의 상담원 콜이력을 조회합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            상담원 지정
          </span>
    <span class="desc">콜이력 조회를 하고 싶은 상담원을 선택합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            모음기준
          </span>
    <span class="desc">개인 | (시/일/월/요일) -> 상담원별로 그룹지어서 조회합니다. (시/일/월/요일) | 개인 -> 날짜별로 그룹지어서 조회합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            검색유형
          </span>
    <span class="desc">일 단위 또는 월 단위로 조회합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            검색일자
          </span>
    <span class="desc">조회하고 싶은 이력조회의 날짜를 지정합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            제외여부
          </span>
    <span class="desc">주말을 제외하고 조회할지 선택합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            다운로드
          </span>
    <span class="desc">다운로드를 하면 엑셀파일이 다운로드 되고, 상담원 콜 이력조회 데이터들이 엑셀에 표시됩니다.</span>
  </li>
  <li>
    <span class="list_type">-</span>
    조건을 넣어 검색을 하면 해당 조건에 맞는 상담원 콜 이력조회 리스트가 나타납니다.
  </li>
  <li>
    <span class="list_type">-</span>
    테이블 컬럼을 클릭하면 오름차순, 내림차순으로 정렬할 수 있고, 한 페이지당 데이터 30개씩 페이징 처리가 됩니다.
  </li>
  <li>
    <span class="list_type">-</span>
    시간대 별로 콜이 몇번 왔는지 표시됩니다. (00 ~ 23)
  </li>
</ul>
