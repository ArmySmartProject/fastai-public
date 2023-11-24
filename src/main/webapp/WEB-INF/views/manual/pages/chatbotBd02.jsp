<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>챗봇 관리</h4>
<p class="header_desc">챗봇빌더에서 사용할 수 있는 챗봇들을 개별적으로 관리(추가,제거,수정)합니다.</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/68629376/88254249-aa062180-ccef-11ea-8375-ce0af9d17bcc.png" alt="챗봇빌더 챗봇 관리 화면">
  <p class="info_small">TPS : 초당 트랜잭션 수(Transaction Per Second)</p>
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    우측상단의 검색 기능으로 챗봇의 이름 검색이 가능합니다. 해당하는 챗봇이 없으면 '데이터 없음'으로 보여집니다.
  </li>
  <li>
    <span class="list_type">-</span>
    샘플 챗봇 추가와 챗봇 추가 기능이 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    챗봇들이 목록에 아이콘과 함께 보이며 생성 날짜가 게시되어 있습니다.
  </li>
</ul>
<h5>샘플 챗봇 추가</h5>
<p class="header_desc">샘플 챗봇 추가 버튼을 누르면 나타나는 팝업창에서 챗봇 추가가 가능합니다.</p>
<div class="img_box">
  <img class="auto_img" src="https://user-images.githubusercontent.com/68629376/88254743-1fbebd00-ccf1-11ea-8c4d-81012a91303c.png" alt="샘플 챗봇 추가 팝업 창">
</div>
<div class="img_box">
  <img class="auto_img" src="https://user-images.githubusercontent.com/68629376/88254818-690f0c80-ccf1-11ea-9817-a11e71051107.png" alt="Created 팝업">
  <p class="info_small">&#60; Created 팝업 &#62;</p>
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    Tutorial Bot 혹은 Tutorial Bot2 중 하나를 선택한 후에 추가하기 버튼을 누르면 'Created' 팝업이 나타납니다. 'Created' 팝업 확인을 누르면 샘플 챗봇이 정상적으로 추가됩니다.
  </li>
</ul>
<h5>챗봇 추가</h5>
<p class="header_desc">챗봇 추가 버튼을 누르면 챗봇을 설정할 수 있는 화면이 나타납니다.</p>
<div class="img_box">
  <img class="auto_img" src="https://user-images.githubusercontent.com/68629376/91276183-2216aa00-e7bc-11ea-9279-9ffd8b84f170.png" alt="챗봇 추가 화면">
</div>
<h5>챗봇 추가 화면 (기본정보)</h5>
<ul class="list title_large">
  <li>
    <span class="list_type">-</span>
    챗봇 이름을 설정할 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    이미지 파일을 업로드하여 챗봇의 사진을 변경할 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    챗봇에 대한 설명을 넣을 수 있습니다.
    <div class="img_box">
      <img class="auto_img" src="https://user-images.githubusercontent.com/68629376/88255338-16365480-ccf3-11ea-8d66-9e9a10aa8c8b.png" alt="챗봇 설명 란">
    </div>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            Greeting message
          </span>
    <span class="desc">챗봇이 시작됨과 함께 나오는 인사말을 설정하며 그와 함께 보여지는 버튼을 설정합니다.</span>
  </li>
  <li>
    <span class="list_type">-</span>
    Greeting message를 입력 후 추가, 수정, 제거가 가능합니다.
  </li>
  <li>
    <span class="list_type">-</span>
    버튼 추가로 Greeting message와 같이 나오는 클릭이 가능한 버튼을 생성 할 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    버튼명과 클릭시 output되는 전송값을 설정, 수정, 제거가 가능합니다.
    <div class="img_box">
      <img class="auto_img" src="https://user-images.githubusercontent.com/68629376/88255410-51388800-ccf3-11ea-9b23-d369f8134b68.png" alt="output되는 전송값">
    </div>
  </li>
  <li>
    <span class="list_type">-</span>
    미리보기 버튼 클릭시 우측 상용화면에서 미리보기가 가능합니다.
    <div class="img_box">
      <img class="auto_img" src="https://user-images.githubusercontent.com/68629376/88256109-4848b600-ccf5-11ea-83f0-48dc74253f78.png" alt="미리보기 화면">
    </div>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            Unknown message
          </span>
    <span class="desc">Unknown message를 설정하며 답변 불가 항목에 대해 보여지는 메세지를 설정합니다.</span>
  </li>
  <li>
    <span class="list_type">-</span>
    Unknown message를 입력 후 추가, 수정, 제거가 가능합니다.
  </li>
  <li>
    <span class="list_type">-</span>
    버튼 추가로 Greeting message와 같이 나오는 클릭이 가능한 버튼을 생성 할 수 있습니다.
  </li>
</ul>
<h5>챗봇 추가 화면 (PREITF)</h5>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            ITF
          </span>
    <span class="desc">의도 분류 (Intent Finder)</span>
  </li>
  <li>
    <span class="list_type">-</span>
    PREITF 패턴 매칭시 BQA를 SKIP하고 ITF로 진입합니다.
  </li>
  <li>
    <span class="list_type">-</span>
    preitf_id, itf_order, pattern, Action으로 구분되어 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    우측 상단 ADD PATTERN을 통해 신규 등록이 가능합니다.
  </li>
  <li>
    <span class="list_type">-</span>
    Action 에서 정규식을 수정 혹은 제거할 수 있습니다.
  </li>
</ul>
<h6>PREITF 정규식 작성</h6>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/68629376/88256617-be99e800-ccf6-11ea-9bc6-617d3f1528d8.png" alt="정규식 패턴 매칭 화면">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    . 문자 1개의 문자와 일치한다. 단일행 모드에서는 새줄 문자를 제외한다.
  </li>
  <li>
    <span class="list_type">-</span>
    [ ] 문자 클래스 "["과 "]" 사이의 문자 중 하나를 선택한다. "¦"를 여러 개 쓴 것과 같은 의미이다. 예를 들면 [abc]d는 ad, bd, cd를 뜻한다. 또한, "-" * 기호와 함께 쓰면 범위를 지정할 수 있다. "[a-z]"는 a부터 z까지 중 하나, "[1-9]"는 1부터 9까지 중의 하나를 의미한다.
  </li>
  <li>
    <span class="list_type">-</span>
    [^ ] 부정 문자 클래스 안의 문자를 제외한 나머지를 선택한다. 예를 들면 [^abc]d는 ad, bd, cd는 포함하지 않고 ed, fd 등을 포함한다. [^a-z]는 알파벳 소문자로 시작하지 않는 모든 문자를 의미한다.
  </li>
  <li>
    <span class="list_type">-</span>
    ^ 처음 문자열이나 행의 처음을 의미한다.
  </li>
  <li>
    <span class="list_type">-</span>
    $ 끝 문자열이나 행의 끝을 의미한다.
  </li>
  <li>
    <span class="list_type">-</span>
    ( ) 하위식 여러 식을 하나로 묶을 수 있다. "abc¦adc"와 "a(b¦d)c"는 같은 의미를 가진다.
  </li>
  <li>
    <span class="list_type">-</span>
    \n 일치하는 n번째 패턴 일치하는 패턴들 중 n번째를 선택하며, 여기에서 n은 1에서 9 중 하나가 올 수 있다.
  </li>
  <li>
    <span class="list_type">-</span>
    0회 이상 0개 이상의 문자를 포함한다. "a*b"는 "b", "ab", "aab", "aaab"를 포함한다.
  </li>
  <li>
    <span class="list_type">-</span>
    {m, n} m회 이상 n회 이하 "a{1,3}b"는 "ab", "aab", "aaab"를 포함하지만, "b"나 "aaaab"는 포함하지 않는다.
  </li>
  <li>
    <span class="list_type">-</span>
    주로 패턴(pattern)으로 부르는 정규 표현식은 특정 목적을 위해 필요한 문자열 집합을 지정하기 위해 쓰이는 식입니다.
  </li>
  <li>
    <span class="list_type">-</span>
    문자열의 유한 집합을 지정하는 단순한 방법은 문자열의 요소나 멤버를 나열하는 것입니다.
  </li>
</ul>
<h5>챗봇 추가 화면 (Q&A)</h5>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/68629376/91276327-5722fc80-e7bc-11ea-84d5-5e3aaf4dd970.png" alt="챗봇 추가 화면 (Q&A)">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    메인 화면에서 선택 가능한 도메인(좌측) 선택된 도메인(우측)으로 나뉘어 집니다.
  </li>
  <li>
    <span class="list_type">-</span>
    질문 추천 사용 유무를 ON/OFF 할 수 있습니다.
  </li>
  <li>
    <span class="list_type">-</span>
    질문 추천 사용시 형태소 매칭 오차 범위를 설정 가능하며, 재확인 메세지를 수정할 수 있습니다.
  </li>
</ul>
