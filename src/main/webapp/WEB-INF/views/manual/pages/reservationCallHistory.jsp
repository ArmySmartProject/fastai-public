<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>음성봇 예약콜 이력조회</h4>
<p class="header_desc">해당 회사의 Campaign 선택 및 검색 조건을 통해 해당 Campaign의 예약콜 이력을 조회 할 수 있습니다.</p>

<h5>O/B 예약콜 이력조회 메인 화면</h5>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/62526902/97535411-f6ec4900-19fe-11eb-8e33-96743f810696.PNG" alt="OB 예약콜 이력조회 메인화면">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    Campaign 선택을 통해 Campaign별 예약콜 이력을 조회 할 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    검색일시는 이력 리스트의 콜 시작시간을 기준으로 검색됩니다.
  </li>
  <li>
    <span class="list_type">-</span>
    예약콜명 및 상태 검색조건을 통해 예약콜 이력을 검색 할 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    "보기" 버튼 클릭 시 해당 예약콜에 대한 상세 이력 팝업(=상세 보기 화면)이 보여집니다.
  </li>
</ul>

<h5>O/B 예약콜 이력조회 상세 보기 화면</h5>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/62526902/97536895-374cc680-1a01-11eb-9c5a-01964cb5ce11.PNG" alt="OB 예약콜 이력조회 상세 팝업창">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    검색 영역의 "상세 보기" 버튼 클릭 시 예약콜 발송 대상에 대한 검색 조건값들이 나옵니다.
  </li>
  <li>
    <span class="list_type">-</span>
    리스트 설명
    <ul class="list">
      <li>
          <span class="title">
            <span class="list_type">-</span>
            이름
          </span>
        <span class="desc">예약콜 대상 고객 이름</span>
      </li>
      <li>
          <span class="title">
            <span class="list_type">-</span>
            전화번호
          </span>
        <span class="desc">예약콜 대상 고객 전화번호</span>
      </li>
      <li>
          <span class="title">
            <span class="list_type">-</span>
            콜 시작시간
          </span>
        <span class="desc">해당 고객에 대한 콜 시작시간</span>
      </li>
      <li>
          <span class="title">
            <span class="list_type">-</span>
            통화시간
          </span>
        <span class="desc">해당 고객이 통화한 시간</span>
      </li>
      <li>
          <span class="title">
            <span class="list_type">-</span>
            상태
          </span>
        <span class="desc">해당 고객에 대한 통화 진행 여부 (<b>미진행</b> : 고객 통화 미진행 / <b>진행중</b> : 현재 고객 통화중 / <b>진행완료</b> : 고객 통화 완료)</span>
      </li>
      <li>
          <span class="title">
            <span class="list_type">-</span>
            안내결과
          </span>
        <span class="desc">Campaign 시나리오 안내 여부 (<b>SUCCESS</b> : 안내성공 / <b>FAIL</b> : 안내실패)</span>
      </li>
      <li>
          <span class="title">
            <span class="list_type">-</span>
            통화결과
          </span>
        <span class="desc">고객과의 통화 여부 (<b>성공</b> : 고객통화 성공 / <b>실패</b> : 고객통화 실패)
<b>비고</b> : 통화 시 메모내용</span>
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
    "새로고침" 버튼을 통해 고객들의 상태, 안내결과, 통화결과 최근 상태로 볼 수 있습니다.
  </li>
</ul>




<div class="paragraph">
  <p>대시보드에서는 조회 기간과 Campaign을 선택해 Search 버튼을 클릭하면 통계치를 보여줍니다. Campaign이란, 회사에서 서비스하는 AI 콜센터명(음성봇)입니다. <span class="info_small">ex) 한화생명_POC_음성봇, 클라우드화재보험</span></p>
  <p>한 회사는 여러개의 Campaign를 등록할 수 있습니다. 일자, 캠페인명, 총 진행 건수, 평균 통화시간 등을 확인할 수 있습니다.</p>
  <p>막대 그래프는 Search 기간에 따라 X축이 설정되고, 그에 따른 건수가 Y 값으로 보여집니다.</p>
</div>

<h5>발송 결과 상세</h5>
<div class="img_box">
  <img class="full_img" src="${pageContext.request.contextPath}/resources/images/manual/img_statistics_send.png" alt="음성봇통계 발송 결과 상세 화면">
</div>
<div class="paragraph">
  <p>발송 결과 상세 화면에서는 발송 성공, 발송 실패 건수 확인이 가능합니다. 발송이란, 전화를 건 것을 의미합니다.</p>
  <p>발송 현황 추이: 추이 기준 선택 박스는 선택한 기간에 따라 달라지며 시, 일, 주, 월, 년을 선택 할 수 있습니다. 산식 옵션 선택 박스는 선택한 추이 기준에 따라 달라지며 합계, 일평균, 주평균, 월평균을 선택 할 수 있습니다.</p>
  <p>발송 규모 비교: 비교하고자 하는 기간을 선택하여 서로 다른 기간의 성공/실패 건 규모를 비교할 수 있습니다.</p>
</div>

<h5>통화 결과 상세</h5>
<div class="img_box">
  <img class="full_img" src="${pageContext.request.contextPath}/resources/images/manual/img_statistics_dial.png" alt="음성봇통계 통화 결과 상세 화면">
</div>
<div class="paragraph">
  <p>통화 결과 상세 화면에서는 통화 성공, 통화 실패, 통화 성공률 확인이 가능합니다. 통화란, 전화를 받은 것을 의미합니다.</p>
  <p>통화 현황 추이: 추이 기준 선택 박스는 선택한 기간에 따라 달라지며 시, 일, 주, 월, 년을 선택 할 수 있습니다. 산식 옵션 선택 박스는 선택한 추이 기준에 따라 달라지며 합계, 일평균, 주평균, 월평균을 선택 할 수 있습니다.</p>
  <p>통화 결과 비교: 비교하고자 하는 기간을 선택하여 서로 다른 기간의 성공/실패 건 규모를 비교할 수 있습니다.</p>
  <p>통화 실패 사유: 통화를 실패한 경우 부재, 결번, 수신거부, 기타로 구분된 실패 사유를 확인할 수 있습니다.</p>
</div>

<h5>캠페인 결과 상세</h5>
<div class="img_box">
  <img class="full_img" src="${pageContext.request.contextPath}/resources/images/manual/img_statistics_camp.png" alt="음성봇통계 캠페인 결과 상세 화면">
</div>
<div class="paragraph">
  <p>캠페인 결과 상세 화면에서는 캠페인 성공, 캠페인 실패, 캠페인 성공률 확인이 가능합니다. 캠페인 성공이란, 음성봇을 통해 목적 안내 혹은 목적 확인이 완료 되는 지점(Task)에 도달한 것을 의미합니다.</p>
  <p>캠페인 결과 추이: 추이 기준 선택 박스는 선택한 기간에 따라 달라지며 시, 일, 주, 월, 년을 선택 할 수 있습니다. 산식 옵션 선택 박스는 선택한 추이 기준에 따라 달라지며 합계, 일평균, 주평균, 월평균을 선택 할 수 있습니다.</p>
  <p>캠페인 결과 비교: 비교하고자 하는 기간을 선택하여 서로 다른 기간의 발송, 통화, 캠페인 성공/실패를 한 번에 규모 비교할 수 있습니다.</p>
</div>

<h5>Task 별 이탈 상세</h5>
<div class="img_box">
  <img class="full_img" src="${pageContext.request.contextPath}/resources/images/manual/img_statistics_task.png" alt="음성봇통계 Task 별 이탈 상세 화면">
</div>
<div class="paragraph">
  <p>Task 별 이탈 상세 화면에서는 고객이 어느 Task에서 통화 이탈을 했는지 확인이 가능합니다. Task 이탈이란, 음성봇과의 통화 중 전화를 종료하는 경우에 시나리오의 어느 지점(Task)에서 종료를 했는지를 의미합니다.</p>
  <p>Task별 고객 이탈 현황 비교 분석: 비교하고자 하는 기간을 3개까지 선택이 가능하며 서로 다른 기간의 이탈 건 및 이탈률 규모를 비교할 수 있습니다.</p>
  <p>캠페인 성공 구분: Y로 표시된 지점(Task)에 진입하면 캠페인 성공으로 통계 데이터가 쌓입니다. <span class="small_text">캠페인 성공이란 음성봇을 통해 목적 안내 혹은 목적 확인이 완료 되는 지점(Task)에 도달했을 때 성공이라고 합니다.</span></p>
</div>