<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>사용자 관리</h4>
<p class="header_desc">회사 등록 및 수정, 해당 회사의 메뉴를 관리합니다. (<span class="info_large">SUPER-ADMIN</span> 이 관리하는 메뉴입니다.)</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/62526902/88026744-4524bd00-cb71-11ea-9218-2d95fe691e89.PNG" alt="사용자 관리 화면">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    이름, 아이디, 회사 ID, 회사 명, 회사 명(영문), 연락처, 권한유형, 등록일을 볼 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    권한 유형 및 조건 선택으로 사용자 리스트를 검색 할 수 있습니다.
    <ul class="list">
      <li>
        <span class="title"><span class="list_type">-</span>권한유형</span>
        <span class="desc">SUPERADMIN, ADMIN, CONSULTANT, GUEST</span>
      </li>
      <li>
        <span class="title"><span class="list_type">-</span>조건 선택</span>
        <span class="desc">이름, ID, 회사 ID, 회사 명, 회사 명(영문)</span>
      </li>
    </ul>
  </li>
</ul>
<h5>사용자 등록</h5>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    등록 버튼을 클릭하면 나오는 사용자관리 팝업 창에서 회사 명/회사 ID 조회 버튼을 통해 원하는 회사를 선택합니다.
  </li>
  <li>
    <span class="list_type">-</span>
    각 필드에 내용을 입력하고 저장합니다
    <span class="span info_small">&#40;*는 필수 입력 입니다.&#41;</span>
  </li>
  <li>
    <div class="img_box">
      <img class="auto_img" src="https://user-images.githubusercontent.com/62526902/88027616-7e116180-cb72-11ea-88ea-e1e70b0f5fba.PNG" alt="사용자 등록 팝업 창">
      <p class="info_small">&#60;사용자 등록 팝업 창&#62;</p>
    </div>
    <div class="img_box">
      <img class="auto_img" src="https://user-images.githubusercontent.com/62526902/88027743-ac8f3c80-cb72-11ea-8644-3db9025bdca5.PNG" alt="사용자 등록 회사명 조회 팝업 창">
      <p class="info_small">&#60;회사 조회 팝업 창&#62;</p>
    </div>
  </li>
</ul>
<h5>사용자 정보 수정</h5>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    사용자 관리 화면 사용자 테이블에서 아이디를 클릭하면 해당 사용자의 정보를 수정할 수 있는 팝업 창이 나옵니다.
    <span class="info_medium">&#40;사용자 ID는 수정이 불가능합니다.&#41;</span>
  </li>
  <li>
    <span class="list_type">-</span>
    사용자의 회사변경은 회사명/회사 ID 조회를 통해 변경할 수 있습니다.
  </li>
</ul>
<h5>사용자 정보 삭제</h5>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    삭제하고 싶은 사용자를 체크 후 삭제 버튼을 클릭합니다.
  </li>
  <li>
    <span class="list_type">-</span>
    체크박스 다중 선택으로 여러명의 사용자를 동시에 삭제 할 수 있습니다.
  </li>
</ul>
