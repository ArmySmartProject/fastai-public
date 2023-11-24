<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>대시보드</h4>
<p class="header_desc">IN-BOUND의 기간별 응대 현황과 I/B Call 통계, 실시간 상담현황 데이터를 조회할 수 있는 화면입니다.</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/68629376/91433557-6aa69400-e89e-11ea-961a-893803b3d9ab.png" alt="대시보드">
</div>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/68629376/91419721-b7826e80-e88e-11ea-85c3-ddb70a7a03a4.png" alt="대시보드">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            응대현황
          </span>
    <span class="desc">설정한 기준일에 따라 전체현황, 상담현황(실시간) 데이터를 표시합니다.</span>
  </li>
  <li>
    <span class="list_type">-</span>
    Bot, Bot+CSR, Etc 수치들은 통화 후의 상태값들을 기준으로 조회됩니다. 이 상태값들은 전화 상태를 관리하는 교환기에서 내려주는 값에 따라 분류가 되는데, 교환기의 종류에 따라 내려주는 값이 다를 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    교환기는 전화의 수/발신과 고객이 전화를 수신거부 했는지, 결번인지 등 전화에 대한 전반적인 상태 관리를 해주는 역할을 합니다. 그러나 교환기의 종류에 따라 결번 여부, 수신거부 여부 등을 알려주지 않는 경우도 있으며 서버 구성에 따라 교환기에서 아무런 값을 받지 못하는 경우가 발생할 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    총인입은 외부에서 걸려온 모든 콜횟수이며, 응대의 종류에는 Bot, Bot+CSR, Etc 가 있습니다.
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            대기중->BOT
          </span>
    <span class="desc">해당 회사에서 운영 중인 음성봇 개수</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            대기중->CSR
          </span>
    <span class="desc">해당 회사의 속한 상담사 중 '수신대기' 상태인 상담사 수</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            응대외->업무
          </span>
    <span class="desc">해당 회사의 속한 상담사 중 '업무' 상태인 상담사 수</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            응대외->이석
          </span>
    <span class="desc">해당 회사의 속한 상담사 중 '휴식' 상태인 상담사 수</span>
  </li>
  <li>
    <span class="list_type">-</span>
    응대란 포기, 발신을 제외한 모든 인입콜 횟수이며, 어떤 콜타입으로 통화를 종료했냐에 따라 그에 맞게 카운트 됩니다. ex) 봇이 통화종료 -> bot, 사용자가 통화종료 -> Etc
  </li>
  <li>
    <span class="list_type">-</span>
    상담 현황(실시간) : 현재 INBOUND, OUTBOUND 응대중인 봇,상담사 수와 대기중인 봇,상담사 수, 응대외 현황을 조회합니다.
  </li>
</ul>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/50193171/87909267-e4c74a00-caa2-11ea-84e1-84dbd12b4545.png" alt="I/B 콜 통계">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            I/B Call 통계
          </span>
    <span class="desc">설정한 기준일에 따라 I/B Call 통계를 그래프로 나타냅니다.</span>
  </li>
  <li>
    <span class="list_type">-</span>
    그래프에 커서를 올리면 해당 날짜에 해당하는 상세한 통계이력이 표시됩니다.
  </li>
</ul>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/50193171/91259770-1a4e0a00-e7aa-11ea-89fe-dad45cbac3fb.png" alt="실시간 상담현황">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            실시간 상담현황
          </span>
    <span class="desc">현재 I/B에 할당된 BOT 회선 및 상태값을 나타냅니다.</span>
  </li>
  <li>
    <span class="list_type">-</span>
    통화중, 대기중, 연결안됨의 상태값이 존재합니다.
  </li>
</ul>
