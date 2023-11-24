<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>사용자 관리</h4>
<p class="header_desc">회사 사용자의 정보를 등록, 수정, 삭제 할 수 있도록 관리합니다. (<span class="info_large">ADMIN</span> 이 관리하는 메뉴입니다.)</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/62526902/88042013-35fc3a00-cb86-11ea-8e6f-6cae8ace3af3.PNG" alt="사용자 관리 화면">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    이름, 사용자 ID, 권한 그룹 사용여부, 연락처, 권한유형, 등록자, 등록일, 수정자, 수정일을 볼수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    사용여부, 사용자 검색 (이름, 사용자 ID)으로 사용자 리스트를 검색 할 수 있습니다.
  </li>
</ul>
<h5>사용자 등록</h5>
<ul class="list">
  <li>
    <div class="img_box">
      <img class="auto_img" src="https://user-images.githubusercontent.com/62526902/88042236-94291d00-cb86-11ea-844a-a19264ae2729.PNG" alt="사용자 등록 팝업 창">
      <p class="info_small">&#60;사용자 등록 팝업 창&#62;</p>
    </div>
    <ul class="list">
      <li>
              <span class="title">
                <span class="list_type">-</span>
                권한 유형
              </span>
        <span class="desc">사용자의 권한 설정</span>
      </li>
      <li>
              <span class="title">
                <span class="list_type">-</span>
                권한 그룹
              </span>
        <span class="desc">사용자의 메뉴그룹 선택</span>
        <ul class="list">
          <li>
            <span class="list_type">-</span>
            권한 그룹이 없을 경우 <span class="info_medium">메뉴그룹 권한관리</span>에서 메뉴 그룹을 생성하고 등록할 수 있습니다.
          </li>
        </ul>
      </li>
      <li>
              <span class="title">
                <span class="list_type">-</span>
                사용여부
              </span>
        <span class="desc">사용자의 ID사용여부</span>
      </li>
    </ul>
  </li>
</ul>
<h5>사용자 수정</h5>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/62526902/88042977-c129ff80-cb87-11ea-9661-885bad11abcd.PNG" alt="사용자 관리 팝업 창">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    수정버튼을 클릭하면 해당 사용자의 정보를 수정할 수 있는 팝업 창이 나옵니다.
    <span class="info_medium">&#40;사용자 ID는 수정이 불가능합니다.&#41;</span>
  </li>
  <li>
    <span class="list_type">-</span>
    수정하고자 하는 권한 그룹이 없을 경우 <span class="info_medium">메뉴그룹 권한관리</span>에서 그룹을 생성하고 등록할 수 있습니다.
  </li>
</ul>
<h5>사용자 삭제</h5>
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
