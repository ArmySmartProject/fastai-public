<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>OB 상담화면</h4>
<p class="header_desc">상담사에게 할당된 AI Outbound을 수동으로 진행하거나, 현재 진행중인 Outbound를 실시간으로 모니터링하며, 필요시엔 청취 및 상담개입을 할 수 있는 화면 입니다.</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/50193171/91269393-01495700-e7b2-11ea-83ea-e7ef1ad717e1.png" alt="OB 상담 화면">
</div>
<div class="paragraph">
  <p>상단바에 상담사(자신)의 상태를 수신대기, 업무, 휴식으로 표시할 수 있습니다. 수신대기는 상담사가 콜을 받을 수 있는 상태이며, 업무는 상담사가 다른 업무로 인해 콜을 받지 못하는 상태입니다. 휴식은 휴식시간으로 콜을 받지 못하는 상태입니다.</p>
  <p>총현황은 그 회사에 속한 상담사들의 하루동안 총 콜 현황이며, 나의 현황은 자신의 하루 동안 콜 현황입니다. DB List에 AI OutBound Call을 발송할 수 있는 대상 고객의 분류, 이름, 전화번호, 시도결과 값이 보여집니다. 시도결과란 최근 AI OB 진행 상태 리스트이며, 통화중에는 AI진행중, 통화종료시 중지 등 상태값이 실시간으로 바뀝니다.</p>
  <p>목록 중 이름을 클릭하면 A영역에 등록된 고객 상세 정보가 보여지며 정보 변경(B영역)버튼으로 정보를 수정할 수 있습니다. C영역엔 회선번호 또는 내선번호로 진행 중인 Outbound 통화의 STT를(왼쪽 상담봇, 오른쪽 고객 발화) 실시간으로 확인 할 수 있으며 해당 영역을 클릭하면 D영역에 실시간 STT 내용과 E영역에 진행 중인 시나리오의 단계별로 대상 고객이 긍정 혹은 부정으로 대답했는지 여부 등 시나리오에 적용된 탐지값을 기준으로 내용을 확인 할 수 있습니다.</p>
  <p>Auto 종료 버튼(G영역)을 누르면 통화를 종료할 수 있습니다. 콜 청취 버튼을(F영역)을 누르면 실시간으로 통화내용을 청취할 수 있습니다. 상담개입을(F영역) 클릭하여 상담사가 통화에 직접 개입해 진행 할 수 있고, 종료 버튼(F영역)을 통해 상담개입 및 청취를 종료할 수 있습니다. <span class="info_small">종료버튼 클릭시에, 콜이 종료되는 것이 아닌 상담개입이 종료가 됩니다.</span></p>
</div>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/50193171/91269396-03131a80-e7b2-11ea-8b7c-f007f4bb0ced.png" alt="OB 상담 화면">
</div>
<div class="paragraph">
  <p>OB Result영역에 상담 내용을 입력하고 SAVE 버튼을 통해 이력을 저장할 수 있습니다. 화면 오른쪽에 상담 이력 탭을 클릭하면 해당 회선으로 진행한 통화 중 저장된 상담 이력을 확인 할 수 있습니다.</p>
</div>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/50193171/91269398-04dcde00-e7b2-11ea-84c0-c42aef4abf17.png" alt="OB 상담 화면">
</div>
<div class="paragraph">
  <p>Call Again 영역에 다시 통화를 돌릴 시간과 정보를 SAVE 버튼으로 저장하면, 화면 오른쪽 예약 탭을 통해 콜 예약 리스트를 확인 할 수 있습니다.</p>
</div>
