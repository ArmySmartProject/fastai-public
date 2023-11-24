<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 3:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>채팅 상담</h4>
<p class="header_desc">고객의 챗봇 대화를 모니터링하고, '상담개입'을 통해 고객과 실시간 채팅 상담을 진행합니다.</p>
<h5>챗봇 대화 모니터링</h5>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/50193171/91265212-c93f1580-e7ab-11ea-9c90-ada098a9ce0c.png" alt="고객 접속 채팅 화면">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    챗봇에 고객 발화가 들어오면 좌측 리스트에 한 줄이 추가됩니다.
  </li>
  <li>
    <span class="list_type">-</span>
    리스트의 원하는 대화 세션을 클릭하면 아래와 같이 해당 세션의 대화 내용을 모니터링할 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    고객정보창
    <ul class="list">
      <li>
        <span class="title"><span class="list_type">-</span>인입채널</span>
        <span class="desc">서비스 종류 id</span>
      </li>
      <li>
        <span class="title"><span class="list_type">-</span>세션ID</span>
        <span class="desc">대화의 고유한 세션 id</span>
      </li>
      <li>
        <span class="title"><span class="list_type">-</span>성명</span>
        <span class="desc">고객의 로그인 id, id가 없으면 접속 세션 id</span>
      </li>
    </ul>
  </li>
  <li>
    <span class="list_type">-</span>
    상담개입
    <ul class="list">
      <li>
        <div class="img_box">
          <img class="full_img" src="https://user-images.githubusercontent.com/33821123/88047135-1cf68780-cb8c-11ea-987e-93b95023d9b9.png" alt="상담개입 화면">
        </div>
      </li>
      <li>
        <span class="list_type">-</span>
        모니터링 중 상담사가 개입을 원할 때 (혹은 고객에게 상담사 연결 요청이 왔을 때) 하단의 '상담개입' 버튼을 눌러 개입이 가능합니다.
      </li>
      <li>
        <span class="list_type">-</span>
        상담 개입 후에는 상담사와 고객이 실시간 채팅을 합니다.
      </li>
    </ul>
  </li>
  <li>
    <span class="list_type">-</span>
    상담종료
    <ul class="list">
      <li>
        <div class="img_box">
          <img class="auto_img" src="https://user-images.githubusercontent.com/33821123/88047769-187e9e80-cb8d-11ea-87c5-a8710ab50c6b.png" alt="상담종료 화면">
        </div>
      </li>
      <li>
        <span class="list_type">-</span>
        상담 종료를 클릭하면, 채팅 목록에서 해당 세션이 사라집니다.
      </li>
    </ul>
  </li>
</ul>
