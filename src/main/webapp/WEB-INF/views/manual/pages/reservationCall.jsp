<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>음성봇 예약콜 관리</h4>
<p class="header_desc">Outbound 예약콜 등록, 수정 및 삭제등 회사별 고객들에 대한 예약콜을 관리합니다.</p>

<h5>O/B 예약콜 관리 메인 화면</h5>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/62526902/97529369-1ed5af80-19f3-11eb-9891-0e5ff4b766b8.PNG" alt="OB예약콜 메인화면">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    회사에 부여된 Campaign을 선택하여 예약콜 등록, 수정 및 삭제를 할 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    예약콜명, 상세설명, 예약일시, 등록일, 등록자, 수정일, 수정자를 확인 할 수 있는 리스트가 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    등록, 수정 및 삭제 버튼을 통해 예약콜을 등록, 수정 및 삭제 할 수 있습니다.
  </li>
</ul>

<h5>O/B 예약콜 관리 등록</h5>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/62526902/97530492-a02e4180-19f5-11eb-97ce-015bed3f0a32.PNG" alt="OB예약콜 등록 상세 팝업창">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    메인 화면에 "등록" 버튼 클릭 시 예약콜을 등록 할 수 있는 팝업창이 나옵니다.
  </li>
  <li>
    <span class="list_type">-</span>
    등록 팝업창은 예약콜, 발송기간, 발송대상으로 나뉘어 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    발송 대상 "검색" 버튼 클릭 시 발송 대상 검색 조건에 맞는 고객 리스트가 나옵니다.
  </li>
  <li>
    <span class="list_type">-</span>
    각 필드에 내용을 입력합니다.(예약콜 / 발송 기간)
    <ul class="list">
      <li>
        <span class="title">
          <span class="list_type">-</span>
          예약콜 명
        </span>
        <span class="desc">
          등록하려는 예약콜 명.
        </span>
      </li>
      <li>
        <span class="title">
          <span class="list_type">-</span>
          상세 설명
        </span>
        <span class="desc">
          해당 예약콜에 대한 설명.
        </span>
      </li>
      <li>
        <span class="title">
          <span class="list_type">-</span>
          시작-종료 일자
        </span>
        <span class="desc">
          예약콜을 진행하고자 하는 시작 및 종룍 기간.
        </span>
      </li>
      <li>
        <span class="title">
          <span class="list_type">-</span>
          발송 시간
        </span>
        <span class="desc">
          예약콜이 진행되는 시간.(시간: 00 ~ 23시 <b>1시간 단위</b>, 분: 00 ~ 50분 <b>10분단위</b>)
        </span>
      </li>
      <li>
        <span class="title">
          <span class="list_type">-</span>
          요일 선택
        </span>
        <span class="desc">
          예약콜이 진행되는 요일.(주중클릭시 월,화,수,목,금 선택 / 주말 클릭 시 토,일 선택)
        </span>
      </li>
      <li>
        <span class="title">
          <span class="list_type">-</span>
          시도 횟수
        </span>
        <span class="desc">
          해당 회사 고객들의 예약콜 시도횟수를 선택.(0, 1, 2, 3이상 / <b>다중 선택 가능</b>)
        </span>
      </li>
      <li>
        <span class="title">
          <span class="list_type">-</span>
          대상 상태
        </span>
        <span class="desc">
          해당 회사 고객들의 상태를 선택 (미 실행, 통화실패, 통화 성공/안내 실패, 통화 성공/ 안내 성공 / <b>다중 선택 가능</b>)
        </span>
      </li>
      <li>
          <span class="title">
            <span class="list_type">-</span>
            이름
          </span>
        <span class="desc">예약콜 대상 고객 이름</span>
      </li>
    </ul>
  </li>
  <li>
    <span class="list_type">-</span>
    상세 검색 조건 부분은 다를 수 있으므로 해당 필드명 조건에 맞춰서 검색하시면 됩니다.
  </li>
  <li>
    <span class="list_type">-</span>
    <b>주의 : 발송 대상을 검색 후 저장해야 합니다.</b>
  </li>
</ul>

<h5>O/B 예약콜 관리 수정</h5>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/62526902/97533739-1afa5b00-19fc-11eb-8329-e54d7c995f51.png" alt="OB예약콜 수정 상세 팝업창">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    메인 화면 리스트에서 "수정" 버튼 클릭시 해당 예약콜에 대한 수정 팝업창이 나옵니다.
  </li>
  <li>
    <span class="list_type">-</span>
    등록 시 입력 했던 예약콜 정보들이 나오며 수정하고자 하는 필드의 내용을 수정하시면 됩니다.
  </li>
</ul>

<h5>O/B 예약콜 관리 삭제</h5>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/62526902/97534444-59dce080-19fd-11eb-9d83-6576507aec78.PNG" alt="OB예약콜 삭제 관련 화면">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    예약콜 리스트를 체크 하신 후 "삭제" 버튼 클릭 시 체크된 예약콜 리스트가 삭제됩니다. (<b>다중 삭제 가능</b>)
  </li>
</ul>