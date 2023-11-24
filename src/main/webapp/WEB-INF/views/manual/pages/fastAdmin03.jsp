<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>메뉴 그룹 권한 관리</h4>
<p class="header_desc">사용자들이 사용할 메뉴 그룹을 관리합니다. (<span class="info_large">ADMIN</span> 이 관리하는 메뉴입니다.)</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/62526902/88043923-d5bac780-cb88-11ea-979b-a2a322d9eab9.PNG" alt="메뉴 그룹 권한 관리 화면">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    그룹명, 그룹 설명, 등록자, 등록일, 수정자, 수정일을 볼수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    그룹명으로 사용자 리스트를 검색 할 수 있습니다.
  </li>
</ul>
<h5>메뉴 그룹 권한 관리 등록</h5>
<p class="header_desc">메인 화면에서 등록 클릭 시 메뉴 그룹을 등록 할 수 있는 팝업창이 나옵니다.</p>
<ul class="list">
  <li>
    <div class="img_box">
      <img class="auto_img" src="https://user-images.githubusercontent.com/62526902/88045397-6c878400-cb89-11ea-80b9-952acfe699b3.PNG" alt="메뉴 그룹 권한 관리 팝업 창">
      <p class="info_small">&#60;사용자 등록 팝업 창&#62;</p>
    </div>
    <ul class="list">
      <li>
              <span class="title">
                <span class="list_type">-</span>
                그룹명
              </span>
        <span class="desc">메뉴 그룹의 그룹명을 입력</span>
      </li>
      <li>
              <span class="title">
                <span class="list_type">-</span>
                그룹설명
              </span>
        <span class="desc">메뉴 그룹의 설명을 입력</span>
      </li>
      <li>
        <span class="list_type">-</span>
        사용할 시스템을 선택하여 메뉴 그룹을 만듭니다. (사용할 시스템 다중 선택 가능)
      </li>
    </ul>
  </li>
</ul>
<h5>메뉴 그룹 권한 관리 수정</h5>
<p class="header_desc">수정버튼을 클릭하면 해당 메뉴 그룹의 정보를 수정할 수 있는 팝업 창이 나옵니다.</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/62526902/88042977-c129ff80-cb87-11ea-9661-885bad11abcd.PNG" alt="메뉴 그룹 권한관리 테이블">
  <p class="info_small">&#60;메뉴 그룹 권한관리 테이블&#62;</p>
</div>
<div class="img_box">
  <img class="auto_img" src="https://user-images.githubusercontent.com/62526902/88046104-87a6c380-cb8a-11ea-8b23-3a5321f9bffc.PNG" alt="사용자 관리 팝업 창">
  <p class="info_small">&#60;메뉴 그룹 권한관리 팝업 창&#62;</p>
</div>

<h5>메뉴 그룹 권한 관리 삭제</h5>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    삭제하고 싶은 메뉴를 체크 후 삭제 버튼을 클릭합니다.
  </li>
  <li>
    <span class="list_type">-</span>
    체크박스 다중 선택으로 여러개의 메뉴를 동시에 삭제 할 수 있습니다.
  </li>
</ul>
