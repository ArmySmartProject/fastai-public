<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>챗봇 통계</h4>
<p class="header_desc">챗봇의 날짜별, 시간별 통계 그래프를 보여주는 화면입니다.</p>

<div class="img_box">
  <img class="full_img" src="${pageContext.request.contextPath}/resources/images/manual/img_chatbot_stattistics.png" alt="챗봇 통계 화면">
</div>
<ul class="list title_large">
  <li>
    통계
    <ul class="list title_large">
      <li>
        <span class="title">
          <span class="list_type">-</span>
          Total Messages
        </span>
        <span class="desc">선택한 날짜 범위에서 챗봇이 수신받은 전체 메세지 수</span>
      </li>
      <li>
        <span class="title">
          <span class="list_type">-</span>
          Total Users
        </span>
        <span class="desc">선택한 날짜 범위에서 챗봇을 사용한 유저 수</span>
      </li>
      <li>
        <span class="title">
          <span class="list_type">-</span>
          Total Avg.conversations per user
        </span>
        <span class="desc">선택한 날짜 범위에서 유저당 메세지 평균 수 (챗봇을 사용한 유저 수/챗봇이 수신받은 메세지 수)</span>
      </li>
      <li>
        <span class="title">
          <span class="list_type">-</span>
          Total Email
        </span>
        <span class="desc">선택한 날짜 범위에서 챗봇을 통해 문의를 한 수</span>
      </li>
    </ul>
  </li>
  <li>
    <span class="title">
      Total Messages Per Hour
    </span>
    <span class="desc">선택한 날짜 범위에서 메세지를 수신한 수를 시간별로 표시한 그래프</span>
  </li>
  <li>
    <span class="title">
      Active Users Per Hour
    </span>
    <span class="desc">선택한 날짜 범위에서 챗봇을 사용한 유저의 수를 시간별로 표시한 그래프</span>
  </li>
  <li>
    <span class="title">
      New User Count(today)
    </span>
    <span class="desc">선택한 날짜 범위에서 챗봇을 사용한 유저의 수와 오늘 접속한 유저의 수를 표시한 그래프</span>
  </li>
  <li>
    <span class="title">
      PC/Mobile Count
    </span>
    <span class="desc">선택한 날짜 범위에서 접속 경로(PC/Mobile) 별로 유저 수를 표시한 그래프</span>
  </li>
  <li>
    <span class="title">
      Channel Count
    </span>
    <span class="desc">선택한 날짜 범위에서 채널 별로 유저 수를 표시한 그래프</span>
  </li>
  <li>
    <span class="title">
      Link Count
    </span>
    <span class="desc">선택한 날짜 범위에서 유저가 link 답변을 클릭한 수를 표시한 그래프</span>
  </li>
  <li>
    <span class="title">
      Top 10 Category
    </span>
    <span class="desc">선택한 날짜 범위에서 챗봇이 답변한 category(=task)를 순위를 매겨 표시한 표</span>
  </li>
  <li>
    <span class="title">
      User Question
    </span>
    <span class="desc">선택한 날짜 범위에서 유저가 물어본 내용을 순위를 매겨 표시한 표</span>
  </li>
</ul>