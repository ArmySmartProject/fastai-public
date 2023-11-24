<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>IB 상담화면</h4>
<p class="header_desc">고객이 상담사에게 할당된 회선 번호로 전화를 걸면, 진행중인 통화에 대한 전반적인 내용을 실시간으로 확인할 수 있는 화면입니다.</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/50193171/91148192-44dd8b80-e6f4-11ea-8513-8240c2869b77.png" alt="IB 상담화면">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    상담사의 상태값을 설정할 수 있습니다.
    <ul class="list">
      <li>
              <span class="title">
                <span class="list_type">-</span>
                수신대기
              </span>
        <span class="desc">상담사가 콜을 받을 수 있는 상태입니다.</span>
      </li>
      <li>
              <span class="title">
                <span class="list_type">-</span>
                업무
              </span>
        <span class="desc">상담사가 다른 업무로 인해 콜을 받지 못하는 상태입니다.</span>
      </li>
      <li>
              <span class="title">
                <span class="list_type">-</span>
                휴식
              </span>
        <span class="desc">휴식시간으로 콜을 받지 못하는 상태입니다.</span>
      </li>
    </ul>
  </li>
  <li>
    <span class="list_type">-</span>
    상담사가 속한 회사의 총 현황과 상담사 본인의 현황을 확인할 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    총인입수와 음성봇, 상담사(사람)의 응대 현황과 대기고객, 통화시간 등을 확인할 수 있습니다.
  </li>
</ul>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/30282351/88023293-c2e5ca00-cb6b-11ea-9f41-bcc31c49a48f.png" alt="음성봇 화면">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    상담사에게 할당된 각각의 회선마다 콜 진행을 모니터링 할 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    <span class="info_medium">음성봇1 (07070907044)</span>
    과 같은 타이틀 영역을 클릭하면 상단에서 통화에 대한 정보를 확인 할 수 있습니다.
  </li>
</ul>
<div class="paragraph">
  <p>이하 설명은 <span class="info_large">음성봇1 (07070907044)</span>
    과 같은 타이틀 영역을 클릭하였다는 전제하에 작성하였습니다.</p>
</div>
<div class="img_box">
  <img src="https://user-images.githubusercontent.com/30282351/88021705-f541f800-cb68-11ea-88d8-aa02a274b517.png" alt="고객정보">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    전화한 고객에 대한 정보를 확인합니다.(고객정보는 DB에 저장되어있는 고객인 경우에만 확인할 수 있습니다.)
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            정보변경
          </span>
    <span class="desc">전화한 고객에 대한 정보를 수정할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            신규등록
          </span>
    <span class="desc">등록되어있지 않은 고객인 경우, 고객 데이터를 신규로 등록할 수 있습니다.</span>
  </li>
  <li>
    <span class="list_type">-</span>
    고객이 등록한 카드번호가 나오며, 카드 정보는 숫자 16자리에 맞춰 변경할 수 있습니다.
  </li>
</ul>
<div class="img_box">
  <img src="https://user-images.githubusercontent.com/30282351/88022498-5ae2b400-cb6a-11ea-897b-1a5ad5209ff3.png" alt="고객정보-모자이크">
</div>
<div class="img_box">
  <img src="https://user-images.githubusercontent.com/30282351/88022202-d3954080-cb69-11ea-87a3-0fa679197a7c.png" alt="고객정보-모자이크">
</div>
<div class="img_box">
  <img src="https://user-images.githubusercontent.com/30282351/88022032-7ac5a800-cb69-11ea-9ca8-33af6b5ea76b.png" alt="상담내용">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    상담사가 통화에 대한 내용을 저장할 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    저장할 때, 저장 후 상태값을 설정할 수 있습니다. 상태값은 상단의 수신대기, 업무, 휴식과 동일합니다.
  </li>
</ul>
<div class="img_box">
  <img src="https://user-images.githubusercontent.com/30282351/88023597-47384d00-cb6c-11ea-9fe3-f533b94caaca.png" alt="음성봇">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    진행되는 콜에 대해 모니터링 할 수 있습니다.
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            번호, 구간, 탐지
          </span>
    <span class="desc">통화중 언급되었는지 또는 어떤 대답을 하였는지 등을 체크합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            콜청취
          </span>
    <span class="desc">진행되는 통화를 청취합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            상답개입
          </span>
    <span class="desc">음성봇과 고객이 통화하는 것을 모니터링하다가 상담개입을 눌러 상담사와 고객이 통화합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            종료
          </span>
    <span class="desc">종료버튼 클릭시에, 콜이 종료되는 것이 아닌 상담개입이 종료가 됩니다.</span>
  </li>
</ul>
<div class="img_box">
  <img src="https://user-images.githubusercontent.com/50193171/91147907-e31d2180-e6f3-11ea-86bd-bfd3e4bcabea.png" alt="상담이력, 예약">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            상담이력
          </span>
    <span class="desc">현재 전화한 고객이 이전에 통화한 이력을 확인할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            예약
          </span>
    <span class="desc">상담내용 영역에서 재통화에 대한 내용을 저장한 경우 여기서 보여집니다.</span>
  </li>
</ul>
