<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>서비스 현황</h4>
<p class="header_desc">챗봇 빌더 서비스의 TPS 처리 결과 및 세션 대화 수를 수치와 도표를 사용하여 나타냅니다.</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/68629376/91275757-8ab15700-e7bb-11ea-8e66-4841979f904d.png" alt="챗봇빌더 서비스 현황 화면">
  <p class="info_small">TPS : 초당 트랜잭션 수(Transaction Per Second)</p>
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    우측 상단에서 챗봇의 종류, 시간별, 일자별을 설정하여 조회할 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    메인 상단에서 세션 수, 대화 수, 평균 TPS 그리고 답변 성공률의 수치를 파악할 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    세션수는 누적 숫자를 의미합니다.
  </li>
  <li>
    <span class="list_type">-</span>
    그래프를 통하여 TPS 및 대화 처리 결과를 시각적으로 볼 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    TPS 그래프의 세로축은 초당 트랜잭션 건수를 의미합니다.
  </li>
  <li>
    <span class="list_type">-</span>
    대화 처리 결과 그래프의 세로축은 대화 처리 결과의 건수를 의미합니다.
  </li>
</ul>
<h5>서비스 현황 조회</h5>
<p class="header_desc">챗봇의 종류를 선택하여 특정 챗봇의 서비스 현황을 파악할 수 있습니다.</p>
<div class="img_box">
  <img class="auto_img" src="https://user-images.githubusercontent.com/68629376/91275842-a87ebc00-e7bb-11ea-8ff6-3dd3d5258ddd.png" alt="조회 영역">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            일자 조회
          </span>
    <span class="desc">특정 챗봇의 특정 날의 시간의 흐름에 따른 통계를 조회할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            구간 조회
          </span>
    <span class="desc">특정 챗봇의 일정 기간의 서비스 현황을 파악할 수 있습니다.</span>
  </li>
</ul>