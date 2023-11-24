<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>BQA</h4>
<p class="header_desc">Q&A 관리 화면(List)을 볼 수 있습니다.</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/68629376/88256954-98c11300-ccf7-11ea-8a1a-0de9210898b0.png" alt="BQA 화면">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    질문/응답을 선택하여 그에 해당하는 list 검색가능합니다.
  </li>
  <li>
    <span class="list_type">-</span>
    검색후 나타나는 리스트에 대한 행의 개수를 설정할 수 있습니다.(5, 10, 15, 20, 30, 50, 100)
  </li>
  <li>
    <span class="list_type">-</span>
    우측 상단에서 도메인 인덱스, 엑셀 업로드, 엑셀 다운로드, RICH CONTENT 엑셀 업로드가 가능합니다.
  </li>
</ul>
<h5>Q&A 생성</h5>
<p class="header_desc">추가하기 버튼으로 Q&A를 생성할 수 있습니다.</p>
<div class="img_box">
  <img class="auto_img" src="https://user-images.githubusercontent.com/68629376/91267098-90a03b80-e7ad-11ea-9c78-7d659fcd9559.png" alt="추가하기 팝업 창">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    추가하기에서 Domain name, Team code, 사번, Answer, Question 을 설정할 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    Answer 우측의 RC(Rich Content) 를 선택하면 Button, Image/URL, API, NONE을 선택할 수 있습니다.
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            Button
          </span>
    <span class="desc">사용자의 input에 맞는 버튼을 생성함으로서 답변할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            Image/URL
          </span>
    <span class="desc">사용자의 input에 맞는 image나 링크(URL)을 생성함으로서 답변할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            API
          </span>
    <span class="desc">사용자의 input에 맞는 API를 출력합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            NONE
          </span>
    <span class="desc">Button, Image, URL, API 등을 사용하지 않습니다.</span>
  </li>
</ul>
<h5>Q&A 인덱스</h5>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/68629376/88259098-957c5600-ccfc-11ea-891d-54a803f8a2b1.png" alt="Q&A 인덱스 화면">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    전체 인덱싱 혹은 추가 인덱싱을 할 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    인덱싱시에 DB에서 solr의 검색 엔진에 data를 보내어 추후 챗봇 ITF 관련 검색 엔진 기능을 향상 시킵니다.
  </li>
  <li>
    <span class="list_type">-</span>
    인덱싱 내역에서 내역을 확인할 수 있습니다. (No, Total, Type, indexing_started_dtm, committed_dtm, taken_time, creator_id)
  </li>
</ul>
<h5>Q&A 도메인</h5>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/68629376/88259320-fc9a0a80-ccfc-11ea-87dd-6770cbae4d7d.png" alt="Q&A 도메인 화면">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    Q&A 도메인에서 도메인을 추가, 수정 (이름/설명), 제거 가능합니다.
  </li>
  <li>
    <span class="list_type">-</span>
    동일질문에 여러 응답을 추가 가능하며, 랜덤으로 output 됩니다.
  </li>
</ul>
