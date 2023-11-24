<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>음성봇 통계</h4>
<p class="header_desc">진행한 Outbound Inbound Call의 날짜별, 시간별 통계 그래프를 보여주는 화면입니다. 대시보드와 상세 통계로 구분되어 있으며 상세 통계는 발송결과, 통화결과, 캠페인 성공 결과, Task 별 고객 이탈 현황으로 나누어져 있습니다. 보여지는 통계데이터는 다운로드 버튼을 통해 엑셀파일로 받을 수 있습니다.</p>

<h5>대시보드</h5>
<div class="img_box">
  <img class="full_img" src="${pageContext.request.contextPath}/resources/images/manual/img_statistics_dashboard.png" alt="음성봇통계 대시보드 화면">
</div>
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