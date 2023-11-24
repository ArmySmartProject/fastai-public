<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>회사 및 권한 관리</h4>
<p class="header_desc">회사 등록 및 수정, 해당 회사의 메뉴를 관리합니다. (<span class="info_large">SUPER-ADMIN</span> 이 관리하는 메뉴입니다.)</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/62526902/88020594-feca6080-cb66-11ea-8528-baf11bd43306.PNG" alt="회사 및 권한 관리 화면">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    시스템 사용 여부 및 조건 선택으로 회사 리스트를 검색 할 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    회사 리스트에는 회사 ID, 회사 명, 회사 명(영문), 연락처, 시스템 사용여부, 등록일을 볼 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    회사 정보 등록
    <ul class="list">
      <li>
        <span class="list_type">-</span>
        등록 버튼 클릭 시 회사 정보를 등록 할 수 있는 팝업창이 나옵니다.
      </li>
      <li>
        <div class="img_box">
          <img class="auto_img" src="https://user-images.githubusercontent.com/62526902/88021105-dbec7c00-cb67-11ea-9cfa-447c3ef0013a.PNG" alt="등록 팝업 창">
        </div>
      </li>
      <li>
        <span class="title"><span class="list_type">-</span>회사명</span>
        <span class="desc">회사명 입력 후 중복확인을 진행해주세요.</span>
      </li>
      <li>
        <span class="title"><span class="list_type">-</span>시스템 사용여부</span>
        <span class="desc">서비스 사용 여부를 체크하는 란입니다.</span>
      </li>
    </ul>
  </li>
  <li>
    <span class="list_type">-</span>
    회사 정보 수정 및 삭제
    <ul class="list">
      <li>
        <span class="list_type">-</span>
        회사리스트에서 <span class="info_medium">회사명</span> 클릭 시 해당 회사의 정보를 수정 및 삭제 할 수 있는 팝업창이 나옵니다.
      </li>
      <li>
        <div class="img_box">
          <img class="auto_img" src="https://user-images.githubusercontent.com/62526902/88022447-3b4b8b80-cb6a-11ea-88b6-30cd3caf3676.PNG" alt="company 정보 팝업 창">
        </div>
      </li>
      <li>
        <span class="title"><span class="list_type">-</span>수정</span>
        수정 하고 싶은 내용을 입력 후 수정버튼을 클릭하면 수정이 됩니다.
      </li>
      <li>
        <span class="title"><span class="list_type">-</span>삭제</span>
        삭제를 원하시는 회사는 해당 회사명 클릭 후 팝업이 나오면 삭제버튼을 클릭하면 삭제가 됩니다.
      </li>
    </ul>
  </li>
  <li>
    <span class="list_type">-</span>
    권한관리 부여 및 수정
    <ul class="list">
      <li>
        <span class="list_type">-</span>
        테이블 맨 우측 권한관리 아이콘을 클릭하면 메뉴를 부여 할 수 있는 권한관리 팝업창이 나옵니다.
      </li>
      <li>
        <div class="img_box">
          <img class="auto_img" src="https://user-images.githubusercontent.com/62526902/88021556-a3996d80-cb68-11ea-8839-827d3cec24fa.PNG" alt="권한관리 팝업 창">
        </div>
      </li>
    </ul>
  </li>
</ul>
