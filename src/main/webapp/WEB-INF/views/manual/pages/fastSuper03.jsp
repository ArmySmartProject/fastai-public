<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>시스템 메뉴 관리</h4>
<p class="header_desc">회사 등록 및 수정, 해당 회사의 메뉴를 관리합니다. (<span class="info_large">SUPER-ADMIN</span> 이 관리하는 메뉴입니다.)</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/62526902/88030775-9e431f80-cb76-11ea-9de0-5d7c152ba9b6.PNG" alt="시스템 메뉴 관리 화면">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            메뉴 목록
          </span>
    <span class="desc">등록된 메뉴를 볼 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            메뉴 상세
          </span>
    <span class="desc">선택한 메뉴의 상세 정보를 볼 수 있습니다.</span>
  </li>
</ul>
<h5>메뉴 등록</h5>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    메뉴추가 버튼 클릭 시 신규 메뉴를 추가할 수 있는 팝업창이 나옵니다.
  </li>
  <li>
    <span class="list_type">-</span>
    만약 A메뉴의 하위 메뉴를 추가하고 싶다면 A메뉴를 클릭 한 후 메뉴추가를 클릭합니다.
  </li>
  <li>
    <div class="img_box">
      <img class="auto_img" src="https://user-images.githubusercontent.com/62526902/88036416-7ce63180-cb7e-11ea-817c-4921a0a31b23.PNG" alt="">
    </div>
    <span class="list_type">-</span>
    각 필드에 내용을 입력합니다.
    <ul class="list">
      <li>
              <span class="title">
                <span class="list_type">-</span>
                메뉴 명
              </span>
        <span class="desc">메뉴의 국문명</span>
      </li>
      <li>
              <span class="title">
                <span class="list_type">-</span>
                메뉴 명 (영문)
              </span>
        <span class="desc">메뉴의 영문명</span>
      </li>
      <li>
              <span class="title">
                <span class="list_type">-</span>
                연결 구분
              </span>
        <ul class="list">
          <li>
                  <span class="title">
                    <span class="list_type">-</span>
                    페이지
                  </span>
            <span class="desc">입력한 메뉴 URL로 이동 (내부 URI 입력)</span>
          </li>
          <li>
                  <span class="title">
                    <span class="list_type">-</span>
                    링크
                  </span>
            <span class="desc">메뉴 URL 연결</span>
          </li>
          <li>
                  <span class="title">
                    <span class="list_type">-</span>
                    임베디드
                  </span>
            <span class="desc">내부 IFRAME으로 메뉴URL 연결</span>
          </li>
        </ul>
      </li>
      <li>
              <span class="title">
                <span class="list_type">-</span>
                메뉴 URL
              </span>
        <span class="desc">메뉴의 URL</span>
      </li>
      <li>
              <span class="title">
                <span class="list_type">-</span>
                사용여부
              </span>
        <span class="desc">메뉴 사용여부 체크</span>
      </li>
    </ul>
  </li>
</ul>
<h5>메뉴 정렬(이동)</h5>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    메뉴를 클릭 한 후 드래그를 하면 메뉴를 이동시킬 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    클릭한 메뉴를 다른 메뉴 위로 드래그하면 하위 메뉴로 이동시킬 수 있습니다.
  </li>
</ul>
<h5>메뉴 상세</h5>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/62526902/88037701-3bef1c80-cb80-11ea-8ab3-b23adf9dd92d.PNG" alt="메뉴 상세 화면">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    메뉴를 클릭하면 메뉴 상세에 상세 내용이 보여집니다.
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            수정 버튼
          </span>
    <span class="desc">각 필드에서 수정한 내용을 저장합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            되돌리기 버튼
          </span>
    <span class="desc">각 필드에서 수정한 내용을 저장하지 않고 싶을 때 되돌리기 버튼을 누르면 이전 정보로 돌아갑니다.</span>
  </li>
</ul>
<h5>메뉴 삭제</h5>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    삭제하고 싶은 메뉴를 체크 후 삭제 버튼을 클릭합니다.
  </li>
  <li>
    <span class="list_type">-</span>
    체크박스 다중 선택으로 여러 메뉴를 동시에 삭제 할 수 있습니다.
  </li>
</ul>
