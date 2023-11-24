<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>IB/OB 음성봇 콜 이력조회</h4>
<p class="header_desc">IN-BOUND 또는 OUT-BOUND의 기간별 콜 이력조회 및 필터링, 이력조회 데이터를 다운로드 할 수 있는 화면입니다.</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/50193171/87912038-97011080-caa7-11ea-8576-2be7bb286b99.png" alt="IB콜 이력조회 화면">
</div>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/50193171/87912999-53a7a180-caa9-11ea-8be8-4e3d01e71699.png" alt="검색 영역">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            Company
          </span>
    <span class="desc">자신이 속한 Company의 콜 이력을 조회합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            검색일시
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
</ul>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/50193171/87913650-640c4c00-caaa-11ea-90c2-bb5e9cc9bc29.png" alt="상세 검색 영역">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            상세검색
          </span>
    <span class="desc">상세검색을 클릭하면 필터링을 할 수 있는 조건들이 나타나고, 자신이 찾고자 하는 조건을 넣어 검색을 하면 그에맞는 이력이 조회됩니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            음성봇명
          </span>
    <span class="desc">회사에서 서비스하는 AI 콜센터명(음성봇)이며, Campaign과 같은 의미입니다.</span>
  </li>
</ul>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/50193171/87915532-4391c100-caad-11ea-95a8-e67e45589cba.png" alt="다운로드 된 엑셀">
  <img class="full_img" src="https://user-images.githubusercontent.com/50193171/87913753-8dc57300-caaa-11ea-8423-3c3d92118d4b.png" alt="다운로드 된 엑셀">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            다운로드
          </span>
    <span class="desc">다운로드를 하면 엑셀파일이 다운로드 되고, 이력조회 데이터들이 엑셀에 표시됩니다.</span>
  </li>
</ul>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/50193171/87913972-ed238300-caaa-11ea-8c3c-d40f481b7c65.png" alt="이력조회 리스트">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    조건을 넣어 검색을 하면 해당 조건에 맞는 이력조회 리스트가 나타납니다.
  </li>
  <li>
    <span class="list_type">-</span>
    테이블 컬럼을 클릭하면 오름차순, 내림차순으로 정렬할 수 있고, 한 페이지당 데이터 30개씩 페이징 처리가 됩니다.
  </li>
</ul>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/50193171/87914991-7b4c3900-caac-11ea-8efa-1b564772fd61.png" alt="대화 이력 보기">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    대화이력 보기 버튼을 클릭하면 해당 모달창이 나타납니다.
  </li>
  <li>
    <span class="list_type">-</span>
    상담을 진행한 대화이력을 볼 수 있으며, 콜의 대한 정보가 나타납니다.
  </li>
  <li>
    <span class="list_type">-</span>
    오디오 재생버튼을 클릭하면 콜 이력을 들을 수 있으며, 설정한 구간에 맞게 stt 가 잘 탐지되었는지 표시됩니다.
  </li>
</ul>
