<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>OB콜 통계</h4>
<p class="header_desc">진행한 Outbound Call의 날짜별 또는 시간별 통계치와 그래프를 보여주는 화면입니다.</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/33645517/87915378-0fb69b80-caad-11ea-8ef4-92b88690c173.jpg" alt="OB 콜 통계 화면">
</div>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/33645517/87915368-0cbbab00-caad-11ea-8fb1-9c71f8a2247f.jpg" alt="OB 콜 통계 화면">
</div>
<div class="paragraph">
  <p>진행한 Outbound Call의 날짜별 또는 시간별 통계치와 그래프를 보여주며, 다운로드 버튼을 통해 엑셀파일로 받을 수 있습니다.</p>
  <p>Search Type이 Hourly Unit(한 시간단위) 또는 Daily Unity(일 단위)로 선택하고, 조회 기간과 Campaign을 선택해 Search 버튼을 클릭하면 통계치를 보여줍니다. Campaign이란, 회사에서 서비스하는 AI 콜센터명(음성봇)입니다. <span class="info_small">ex) 한화생명_POC_음성봇, 클라우드화재보험</span></p>
  <p>한 회사는 여러개의 Campaign를 등록할 수 있습니다. 일자, 캠페인명, 총 진행 건수, 평균 통화시간을 확인할 수 있습니다. Bot Response는 AI 음성봇이 통화를 종료한 경우, Bot + CSR은 상담사가 개입하여 통화를 종료하는 경우, ETC는 고객이 통화를 끊는 경우, 그 외에는 No. of Give-ups에 카운팅이 되어 보여집니다.</p>
  <p>그래프는 Search Type값에 따라 X축이 설정되고, 그에 따른 건수가 Y 값으로 보여집니다.</p>
</div>
