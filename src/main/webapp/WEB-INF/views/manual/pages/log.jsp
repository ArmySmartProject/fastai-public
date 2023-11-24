<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>Log 화면</h4>
<p class="header_desc">로그 페이지를 통해 로그를 확인할 수 있습니다.</p>

<div class="img_box">
<img class="full_img" src="${pageContext.request.contextPath}/resources/images/manual/log/img_log_01.png" alt="Log 화면">
</div>
<div class="img_box">
  <img class="full_img" src="${pageContext.request.contextPath}/resources/images/manual/log/img_log_02.png" alt="Log 화면">
</div>

<ul class="list">
  <li>- 로그 카테고리 선택이 가능하며 로그의 종류가 첨부된 사진과 다를 수 있습니다.</li>
  <li>- 로그 확인은 실시간 보기와 파일로 보기로 나뉩니다.</li>
</ul>

<h5>Log 실시간 화면</h5>

<div class="img_box">
  <img class="full_img" src="${pageContext.request.contextPath}/resources/images/manual/log/img_log_03.png" alt="Log 화면">
</div>



<ul class="list">
  <li>- 실시간 보기는 설정한 파일 한개만을 읽어옵니다.</li>
  <li>- 로그 카테고리 선택 및 실시간 보기를 클릭하고, LOG START 버튼을 누르면 하단 로그 영역에서 확인이 가능합니다.</li>
  <li>- tail -f -n 옆 박스는 이전 이력을 몇 줄 가져올지 입력하는 옵션입니다.(입력하지 않아도 됨)</li>
  <li>- 스크롤 하단 고정은 로그가 업데이트 될 때 자동으로 하단에 포커싱되는 기능이며 On/Off가 가능합니다.</li>
  <li>- LOG STOP 버튼을 클릭하면 실시간 보기가 중단됩니다.</li>
</ul>


<h5>Log 파일로 보기 화면</h5>

<div class="img_box">
  <img class="full_img" src="${pageContext.request.contextPath}/resources/images/manual/log/img_log_04.png" alt="Log 화면">
</div>

<ul class="list">
  <li>- 파일로 보기는 설정한 디렉토리에 있는 파일들만 불러 옵니다.</li>
  <li>- 로그 카테고리 선택 및 파일로 보기를 클릭하고 확인하고자 하는 파일을 클릭하면 하단 로그 영역에서 확인이 가능합니다.</li>
  <li>- 검색 창을 통해 검색을 하면 검색된 단어가 빨간색 글씨로 출력이 되며 Enter키를 한번 더 누르면 다음 검색으로 넘어가고 Shift + Enter키를 누르면 이전 검색으로 돌아가게 됩니다.</li>
</ul>

<div class="paragraph">
  <p></p>
</div>
