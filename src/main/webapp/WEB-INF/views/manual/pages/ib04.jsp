<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>IB콜 통계</h4>
<p class="header_desc">IN-BOUND-CALL 통계 수치를 나타내는 화면입니다.</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/30282351/87909581-79ca4300-caa3-11ea-870a-b5daafb6374d.png" alt="IB콜 통계 화면">
</div>
<div class="paragraph">
  <p>I/B콜은 고객이 지정된 회선으로 전화를 거는 것을 의미합니다.</p>
  <p>I/B콜 통계 페이지에서는 콜이 어떤 방식으로 진행되었는지에 대해 통계를 확인할 수 있습니다. 통계 데이터를 그래프는 검색유형에 설정된 시간 단위로  보여줍니다.</p>
</div>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/30282351/88002653-f9a4eb80-cb3d-11ea-91d5-bd91565201dc.png" alt="검색 영역">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            Company
          </span>
    <span class="desc">로그인한 계정이 소속된 회사입니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            검색유형
          </span>
    <span class="desc">30분, 시간, 일, 월 단위로 통계를 확인할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            검색일자
          </span>
    <span class="desc">설정되어있는 검색 유형에 따라 30분, 시간, 일, 월 단위로 통계를 확인하고 싶은 기간을 설정합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            제외여부
          </span>
    <span class="desc"><span class="info_medium">주말제외</span>가 체크되어있는 경우, 통계에서 주말 데이터는 제외되어 보여집니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            검색
          </span>
    <span class="desc">검색유형, 검색일자, 제외여부를 설정하였다면 검색버튼을 눌러 통계를 확인할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            다운로드
          </span>
    <span class="desc">검색된 데이터들이 엑셀파일로 다운로드됩니다. 만약 데이터가 존재하지 않는다면 다운로드되지 않습니다.</span>
  </li>
</ul>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/30282351/88002707-19d4aa80-cb3e-11ea-96da-3748e5aaea23.png" alt="콜 통계 표">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            총인입
          </span>
    <span class="desc">해당 시간에 진행된 콜의 수 입니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            Bot응대
          </span>
    <span class="desc">음성봇이 통화를 종료한 경우입니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            Bot + CSR
          </span>
    <span class="desc">음성봇과 상담사가 콜을 진행한 경우입니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            ETC
          </span>
    <span class="desc">상담사가 통화를 종료한 경우입니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            총응대호
          </span>
    <span class="desc">콜이 정상적으로 진행된 경우입니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            응대율
          </span>
    <span class="desc"><span class="info_medium">총응대호 / 총인입</span> 을 퍼센트로 나타낸 수치입니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            포기호
          </span>
    <span class="desc">통화중 끊어진 경우를 의미합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            포기율
          </span>
    <span class="desc"><span class="info_medium">포기호 / 총인입</span> 을 퍼센트로 나타낸 수치입니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            평균통화시간
          </span>
    <span class="desc"><span class="info_medium">총응대호</span> 로 잡힌 통화에 대한 평균 통화 시간을 의미합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            평균포기시간
          </span>
    <span class="desc"><span class="info_medium">포기호</span> 로 잡힌 통화에 대한 평균 포기 시간을 의미하나, 현재는 <span class="info_medium">00:00:00</span> 으로 표시되고 있습니다.</span>
  </li>
</ul>
