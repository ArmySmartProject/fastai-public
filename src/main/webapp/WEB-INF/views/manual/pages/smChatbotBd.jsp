<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>챗봇빌더(회사)</h4>
<p class="header_desc">본 챗봇빌더는 회사 사용자(A회사, B회사, 등등)들을 위한 기능으로, 회사별 연결된 계정으로 로그인 할 경우, 회사에 매핑된 챗봇들을 생성/관리 할 수 있는 서비스입니다.</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/77707749/107011667-4e0e7080-67db-11eb-800e-a0e580007f27.png" alt="챗봇빌더(회사) 화면">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            챗봇목록
          </span>
    <span class="desc">만들어진 챗봇 검색, 챗봇 추가를 할 수 있습니다 <span class="info_medium">(챗봇 추가 희망 시 문의해 주시 길 바랍니다.)</span></span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            답변
          </span>
    <span class="desc">태스크에 따른 답변을 업로드(엑셀/개별) 및 삭제 할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            의도
          </span>
    <span class="desc">챗봇 대화모델을 이루고 있는 의도에 따른 정규식문장을 추가 삭제 할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            설정
          </span>
    <span class="desc">챗봇 UI에 대한 설정 값을 변경할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            테스트
          </span>
    <span class="desc">현재 운영에 적용된 챗봇버전을 확인 할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            언어선택
          </span>
    <span class="desc">상단 국기를 선택하여 각 언어별로 작성된 답변을 볼 수 있습니다.</span>
  </li>
</ul>
<h5>챗봇추가 & 챗봇설정</h5>
<p class="header_desc">챗봇목록에 있는 추가 버튼을 클릭하면 새 챗봇을 추가할 수 있습니다. 이미 등록 된 챗봇의 설정(수정) 화면도 같은 화면입니다.</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/77707749/107308806-a213a080-6acc-11eb-8f12-7678e67ccd26.png" alt="챗봇추가 화면">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            카테고리
          </span>
    <span class="desc">챗봇학습모델 선택(호텔, 병원 등등) -> 현재는 호텔 모델만 선택가능</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            챗봇명
          </span>
    <span class="desc">챗봇이름</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            챗봇 ID
          </span>
    <span class="desc">챗봇고유 ID</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            Email
          </span>
    <span class="desc">문의하기, 예약 등등 내용 받을 이메일 주소(대표 Email 주소 하나만 등록 가능)</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            상세설명
          </span>
    <span class="desc">챗봇에 대한 설명</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            메인 색상
          </span>
    <span class="desc">3곳(언어, 고객답변, How may I help you?) rgb 색상 변경</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            포인트 글자색상
          </span>
    <span class="desc">3곳(언어, 고객답변, How may I help you?) 글자색(흰색/검은색) 변경</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            로고 이미지
          </span>
    <span class="desc">챗봇 상담 로고 이미지 변경</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            아이콘 이미지
          </span>
    <span class="desc">챗봇 말풍선과 하단 동그라미 이미지 변경(최적 사이즈:72px*72px)</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            언어선택
          </span>
    <span class="desc">챗봇에서 사용할 언어를 선택할 수 있습니다. <span class="info_medium">초기 챗봇 생성 시 사용할 언어 선택 후 변경이 불가</span> 하오니 주의해야 합니다.</span>
  </li>
</ul>
<h5>답변 화면</h5>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/77707749/107011667-4e0e7080-67db-11eb-800e-a0e580007f27.png" alt="챗봇 답변 화면">
</div>
<ul class="list title_large">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            엑셀 업로드
          </span>
    <span class="desc">태스크 &#60;-&#62; 답변 데이터를 개별로 추가 할 수도 있지만, 엑셀로 한번에 업로드 할 수 있습니다.<br><span class="info_medium">※ <a href="/manual?page=smChatbotBdExcel" data-menu="smChatbotBdExcel">엑셀파일작성 매뉴얼</a> 참고</span></span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            엑셀 다운로드
          </span>
    <span class="desc">챗봇빌더에 작성되어 있는 내용을 엑셀로 다운받을 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            샘플데이터 다운로드
          </span>
    <span class="desc">엑셀 데이터 양식을 받을 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            태스크
          </span>
    <span class="desc">'답변'을 호출할 수 있는 '업무명'을 정의한 것입니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            디스플레이명
          </span>
    <span class="desc">각 태스크 별로 사용자에게 버튼 또는 이미지카드로 보여질 내용입니다. 태스크 명 작성 시 태스크명과 동일하게 저장됩니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            답변
          </span>
    <span class="desc">태스크로부터 호출 될 답변 내용을 정하는 것 입니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            태스크 추가
          </span>
    <span class="desc">태스크, 답변, 이미지카드, 버튼, 태스크와의 관계를 설정할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            상세
          </span>
    <span class="desc">기존 태스크의 내용을 수정할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            삭제
          </span>
    <span class="desc">태스크를 삭제합니다. 삭제시 챗봇 무반응 현상을 방지하기 위해 관련 의도도 함께 삭제 필요합니다.</span>
  </li>
</ul>
<h5>답변 &#62; 태스크 추가</h5>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/77707749/107210922-2a9c2d80-6a48-11eb-8385-b6d6d318ed99.png" alt="챗봇 답변 태스크 추가 팝업">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            태스크 명
          </span>
    <span class="desc">답변 이름 정의 ex)조식 가격, 코로나19 안내(한글/외국어/특수문자/숫자/공백 사용 가능)</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            답변
          </span>
    <span class="desc">고객에게 노출될 답변 정의</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            캐로셀
          </span>
    <span class="desc">슬라이드 버튼 등록(등록된 태스크 중에서 선택 가능)</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            버튼
          </span>
    <span class="desc">버튼 등록(등록된 태스크 중에서 선택 가능)</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            이미지 카드
          </span>
    <span class="desc">해당 태스크에 대한 이미지 카드 등록</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            태스크 관계
          </span>
    <span class="desc">이전 태스크와 의도를 통한 로직 설정</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            언어선택
          </span>
    <span class="desc">상단 국기를 선택하여 각 언어별로 태스크 명과 답변을 작성할 수 있습니다. 태스크 명과 답변 이외의 기능은 한국어로 작성한 내용과 동일하게 저장되며 챗봇 초기 생성시 설정한 모든 언어에 대해서 값을 입력해줘야 저장할 수 있습니다.</span>
  </li>
</ul>
<h5>의도</h5>
<p class="header_desc">사용자 발화에서 중요한 키워드 추출 후 사용자 발화의 의도를 파악하고, 해당 의도를 답변 페이지에서 지정한 태스크 및 답변과 매칭합니다. 의도 페이지는 의도 이름을 정의하고, 의도를 호출할 수 있는 정규식(규칙)과 NQA 및 BERT 학습 문장을 구성하는 페이지입니다.</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/77707749/107013104-464fcb80-67dd-11eb-9228-c88d41d6902d.png" alt="챗봇 의도 화면">
</div>
<ul class="list title_large">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            의도
          </span>
    <span class="desc">사용자가 정의한 의도의 이름을 보여주는 열입니다. 오른쪽 상단의 추가 버튼을 통해 의도를 추가할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            정규식 문장
          </span>
    <span class="desc">정규식은 의도를 검색할 규칙을 관리자가 미리 규정하는 기능입니다. 관리자가 미리 규정해 놓은 규칙 안에서 검색되기 때문에 정규식을 튼튼하게 짜 놓았을 경우 정답률이 올라가나 정해놓지 않은 답변에 대해서는 대답을 할 수 없습니다. 상세 버튼을 통해 각 의도의 규칙을 설정할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            NQA 학습 문장
          </span>
    <span class="desc">NQA는 미리 인덱싱 해 놓은 발화를 검색하고 다양한 검색기능을 통해 정규식 보다 훨씬 높은 정답률을 기대할 수 있습니다. 하지만 오탈자나 인덱싱하지 않은 데이터에 대해서는 찾지 못합니다. 상세 버튼을 통해 각 의도 별 로 다수의 NQA 문장을 등록할 수 있으며 해당 페이지에서는 대표 NQA 문장만 노출됩니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            BERT 학습 문장
          </span>
    <span class="desc">BERT 딥러닝을 통해 미리 인덱싱 하지 않은 사용자 발화와 오탈자에도 올바른 답변을 할 수 있도록 학습시키는 문장입니다. 각 의도의 대표 학습문장만 해당 페이지에서 노출됩니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            상세
          </span>
    <span class="desc">해당 의도와 관련한 정규식, 학습 문장 관리 가능</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            삭제
          </span>
    <span class="desc">해당 의도 삭제. 의도와 정규식 문장, NQA 학습문장, BERT 학습문장이 전부 삭제됨으로 삭제시 주의가 필요합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            검색
          </span>
    <span class="desc">의도, 정규식 문장, BERT 학습 문장을 입력해 검색할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            챗봇학습
          </span>
    <span class="desc">추가한 NQA 문장들을 학습시킬 수 있습니다. 또한 해당 버튼을 통해 엑셀 양식을 다운받고 NQA 문장 작성 후 학습 시킬 수 있습니다.</span>
  </li>
</ul>
<h5>의도 데이터 입력 방법</h5>
<p class="header_desc">의도 데이터를 탄탄하게 작성해야 다양한 사용자 발화에서 중요한 단어를 추출해 사용자 발화의 올바른 의미를 파악하고 정확한 답변을 할 수 있습니다. 또한 데이터 탄탄한 데이터 구축 방법은 다음과 같습니다.</p>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    데이터 분류 의도 별로 핵심/비핵심 키워드를 분류해야 합니다. 핵심 키워드 란 각 의도에서 의미 있는 키워드를 말하며 비핵심 키워드 란 사용자 발화에서 의미 없는 키워드, 또는 해당 의도에서 추출되지 않아야 할 키워드를 말합니다.
    <div class="img_box">
      <img class="auto_img" src="https://user-images.githubusercontent.com/77707749/107209049-b3659a00-6a45-11eb-866c-a9697343bda6.JPG" alt="데이터 분류 의도 별 핵심/비핵심 키워드 작성법">
    </div>
  </li>
  <li>
    <span class="list_type">-</span>
    데이터 생성/정제/학습 데이터를 분류하고 어떠한 엔진을 사용할지 결정했다면 각 엔진에 맞는 데이터를 생성하고 학습해야 합니다. 엔진 특성 별로 데이터 생성법은 조금씩 다르지만 기본 틀은 다음과 같습니다.
    <ul class="list">
      <li>
        <span class="list_type">1.</span>
        대표 질문들은 의도의 모든 경우를 답할 수 있게 만들어야 합니다. 이 뜻은 각 의도에서 나올 수 있는 발화에 대한 내용을 하나하나 질문에 추가해야 한다는 의미입니다.
      </li>
      <li>
        <span class="list_type">2.</span>
        질문 입력 시, 핵심 키워드는 각 질문마다 반드시 포함되어야 합니다.
      </li>
      <li>
        <span class="list_type">3.</span>
        대표 질문은 항상 모든 주어 목적어 동사가 반드시 포함되어야 합니다.
      </li>
      <li>
        <span class="list_type">4.</span>
        형태소가 잘 검색될 수 있게, 복합 형태소는 떨어지는 것과 붙어있는 것 모두 질문을 입력해야 합니다.<br>(ex. 객실예약 의도에 대한 질문 : 객실예약, 객실 예약)
      </li>
      <li>
        <span class="list_type">5.</span>
        동의어 치환이 가능하니, 같은 의미의 단어(ex. 마인즈랩 = 마랩)을 늘리고자 질문을 추가하는 것은 바람직하지 않습니다. 동의어 치환 시, indexing과 검색 모두 영향을 미칩니다.
      </li>
    </ul>
  </li>
</ul>
<h5>의도 &#62; 상세(정규식)</h5>
<p class="header_desc">의도 메인페이지의 각 의도 상세 버튼을 통해 해당 의도와 매칭될 정규식을 추가할 수 있습니다.</p>
<div class="img_box">
  <img class="auto_img" src="https://user-images.githubusercontent.com/77707749/107013131-4d76d980-67dd-11eb-89bc-2d77c482c2d1.png" alt="의도 상세(정규식)">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            개별추가
          </span>
    <span class="desc">해당 의도와 관련된 정규식(규칙)을 추가 하거나 테스트할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            규칙
          </span>
    <span class="desc">규칙으로 작성된 정규식을 키워드 형태로 보여줍니다. 각 각의 색은 키워드 별로 설정한 조건을 의미합니다. 개별 추가/상세 의 '정규식 직접 입력'을 통해서 설정하면 규칙 열은 공란으로 노출됩니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            정규식
          </span>
    <span class="desc">규칙 또는 정규식 직접입력을 통해 작성된 정규식을 정규식 형태로 보여줍니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            상세
          </span>
    <span class="desc">작성된 정규식(규칙)을 수정 하거나 테스트할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            삭제
          </span>
    <span class="desc">작성된 정규식(규칙)을 삭제 합니다.</span>
  </li>
</ul>
<h5>의도 &#62; 정규식 개별추가</h5>
<p class="header_desc">의도와 매칭될 정규식을 추가할 수 있습니다. 해당 의도와 매칭 될 사용자 발화를 예상하여 규칙을 구성해야 합니다. 아래 기능들을 활용하여 정규식을 직접 작성하지 않고, 손 쉽게 규칙을 작성할 수 있으며 조건을 잡고 드래그 하면 조건의 순서를 바꿀 수 있습니다.</p>
<div class="img_box">
  <img class="auto_img" src="https://user-images.githubusercontent.com/77707749/107013136-4ea80680-67dd-11eb-8895-337fccebccf1.png" alt="의도 정규식 개별추가 팝업창">
  <p class="info_small">※ '|'(shift + \)는 'or'를 의미합니다. ex) 객실|방|룸 = 객실 or 방 or 룸</p>
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            규칙
          </span>
    <span class="desc">정규식 작성에 필요한 5가지 조건 중 필요한 조건을 선택 후 키워드 작성하여 정규식을 짤 수 있습니다.</span>
    <ul class="list title_xl">
      <li>
              <span class="title">
                <span class="list_type">1.</span>
                시작텍스트
              </span>
        <span class="desc">해당 조건에 추가한 키워드 중 하나는 무조건 사용자 발화 맨 처음에 나와야 합니다.</span>
      </li>
      <li>
              <span class="title">
                <span class="list_type">2.</span>
                텍스트가 정확하게 일치함
              </span>
        <span class="desc">해당 조건에 추가하는 키워드와 똑같은 단어가 사용자 발화에 있을 시 매칭합니다.</span>
      </li>
      <li>
              <span class="title">
                <span class="list_type">3.</span>
                텍스트에 포함
              </span>
        <span class="desc">해당 조건에 추가한 키워드가 사용자 발화 중 어느 위치에 있던지 매칭합니다.</span>
      </li>
      <li>
              <span class="title">
                <span class="list_type">4.</span>
                텍스트에 포함하지 않음
              </span>
        <span class="desc">해당 조건에 추가한 키워드가 사용자 발화 중 포함되면 매칭되지 않습니다. 예를 들면, '식당', '식당메뉴'의 인텐트가 있을 경우, '식당' 정규식에 '메뉴' 키워드를 조건4로 추가해주면 '식당' 인텐트에서는 '메뉴'가 포함된 발화는 매칭되지 않습니다.</span>
      </li>
      <li>
              <span class="title">
                <span class="list_type">5.</span>
                종료 텍스트
              </span>
        <span class="desc">해당 조건에 추가한 키워드 중 하나는 무조건 사용자 발화 맨 끝에 나와야 합니다. 위 예시는 '예약'이라는 단어가 사용자 발화(문장) 맨 끝에 나오지 않아 매칭되지 않습니다.</span>
      </li>
    </ul>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            규칙추가
          </span>
    <span class="desc">규칙(조건) 추가를 통해서 정규식에 다양한 조건을 추가할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            정규식 직접 입력
          </span>
    <span class="desc">해당 조건 체크할 경우, 규칙(조건)을 통하여 작성한 정규식은 사라지고, 사용자가 직접 정규식을 작성할 수 있는 방식만 남겨집니다. ※ 정규식 직접 입력을 통해 만들어진 정규식을 규칙(조건) 사용으로 변환할 수 없습니다. 필요 시 해당 정규식 삭제 후 새로 작성이 필요합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            결과 정규식
          </span>
    <span class="desc">규칙 기능 사용으로 설정한 조건들이 자동으로 '결과 정규식'에 표현 됩니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            테스트 문장
          </span>
    <span class="desc">작성한 정규식이 사용자 발화와 매칭 되는지 테스트하는 기능입니다. 사용자 발화 입력 후 테스트 버튼 클릭 시 정규식과 매칭되는지 확인할 수 있습니다.</span>
  </li>
</ul>
<h5>의도 &#62; 상세(NQA)</h5>
<p class="header_desc">의도 메인페이지의 각 의도 상세 버튼을 통해 해당 의도와 매칭될 NQA문장들을 추가할 수 있습니다. 의도와 매칭될 사용자 발화를 예상하여 NQA 문장을 구성해야 하며 동일한 의도에 대해 다양한 형태소(체언과 용언)로 학습 문장을 구성 시 성능이 올라갑니다. 해당 페이지에서 추가한 문장들을 학습하기 위해 NQA 문장 추가 후 의도 메인 페이지 ‘챗봇 학습’ 버튼을 통하여 학습시켜야 정상적으로 학습이 완료됩니다. 또한 ‘챗봇 학습’ 버튼을 통하여 엑셀로 작업 후 업로드 시 본 페이지에 엑셀로 작업한 NQA문장이 추가됩니다.</p>
<div class="img_box">
  <img class="auto_img" src="https://user-images.githubusercontent.com/77707749/107013124-4b147f80-67dd-11eb-8d75-9408aca52bf6.png" alt="의도 상세(NQA) 화면">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            문장
          </span>
    <span class="desc">추가한 학습문장 리스트를 볼 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            개별추가
          </span>
    <span class="desc">학습문장을 입력하여 신규 NQA 학습문장을 추가할 수 있습니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            상세
          </span>
    <span class="desc">기존 NQA 학습문장을 수정할 수 있습니다.</span>
  </li>
</ul>
<h5>의도 &#62; 상세(학습문장) 엑셀업로드</h5>
<p class="header_desc">NQA학습문장 페이지에서 개별 추가 하지 않고, 의도 페이지 ‘챗봇 학습’ 버튼 中 ‘엑셀 업로드’ 버튼을 통하여 작업한 엑셀을 NQA학습문장으로 추가할 수 있습니다.</p>
<div class="img_box">
  <img class="auto_img" src="https://user-images.githubusercontent.com/77707749/107453015-86bc9a00-6b8d-11eb-8488-e65862fad684.png" alt="의도 NQA 챗봇 학습 팝업 창">
</div>
<div class="img_box">
  <img class="auto_img" src="https://user-images.githubusercontent.com/77707749/107013111-48198f00-67dd-11eb-8bfa-b82c5e8841b6.png" alt="엑셀 작성 예시">
</div>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            Category
          </span>
    <span class="desc">카테고리는 기본값 ‘공통’으로 입력합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            Intent
          </span>
    <span class="desc">NQA학습문장을 추가할 의도를 입력합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            Question
          </span>
    <span class="desc">의도와 매칭될 사용자 발화를 예상하여 NQA 문장을 입력 및 구성합니다.</span>
  </li>
  <li>
    <span class="list_type">-</span>
    데이터 입력 방법에 관해서는 <span class="info_medium">의도 데이터 입력 방법</span> 에 상세히 나와있습니다.
  </li>
</ul>
<h5>의도 학습 &#62; NQA</h5>
<div class="img_box">
  <img class="auto_img" src="https://user-images.githubusercontent.com/77707749/107453015-86bc9a00-6b8d-11eb-8488-e65862fad684.png" alt="의도 NQA 챗봇 학습 팝업 창">
</div>
<div class="paragraph">
  <p>의도 &#62; NQA 상세에서 개별 학습문장을 추가/수정/삭제하거나, 의도 &#62; NQA 엑셀 업로드를 통한 학습문장 추가/수정/삭제 할 시, 의도 메인페이지 우측 상단의 ‘챗봇 학습’버튼에 “챗봇을 학습하세요”라고 사용자 가이드가 뜹니다.</p>
  <p>해당 버튼을 누르면, 챗봇 학습용 팝업이 뜨고, 업데이트 시간과 학습한 시간을 비교하여 ‘학습’ 버튼을 누르면 됩니다.</p>
  <p>"챗봇 학습"을 하지 않으면, 의도 학습이 수정되지 않으니 주의 바랍니다.</p>
</div>
<h5>챗봇 테스트</h5>
<p class="header_desc">메인 페이지 우측 상단에 있는 ‘챗봇 테스트’ 버튼을 통하여 현재까지 구축한 챗봇을 테스트할 수 있습니다.</p>
<div class="img_box">
  <img class="auto_img" src="https://user-images.githubusercontent.com/77707749/110070918-6368c180-7dbe-11eb-984f-a580b4b93ea6.png" alt="챗봇 테스트 버튼 위치">
</div>
<div class="img_box">
  <img class="auto_img" src="https://user-images.githubusercontent.com/77707749/110071005-94e18d00-7dbe-11eb-9da4-c5f54076dced.png" alt="챗봇 테스트 사용 예시">
  <p class="info_small">그림1 : 챗봇 테스트 초기화면 / 그림2 : 사용자 발화 입력 결과 / 그림3 : 버튼 사용 결과</p>
</div>
<div class="paragraph">
  <p>해당 테스트 기능은 실 사용과 동일한 사용자 인터페이스 및 결과물을 보여줍니다.
    또한 디버깅 기능을 탑재하고 있어 각 발화와 매칭되는 엔진(정규식, NQA, BERT)과 태스크를 보여줌으로써 의도 및 태스크 별로 추가적으로 학습 해야할 방향을 찾는데
    용이합니다. 디버깅 기능의 자세한 설명은 다음과 같습니다.</p>
</div>
<ul class="list">
  <li>
    <p class="li_title">INPUT</p>
    <div class="li_cont">
            <span class="title">
              <span class="list_type">-</span>
              input text
            </span>
      <span class="desc">1번 예시와 같이 사용자가 입력한 발화를 보여줍니다. 다만 2번 예시처럼 버튼을 사용하여 대화를 진행하였을 경우에는 나타나지 않습니다.</span>
    </div>
    <div class="li_cont">
            <span class="title">
              <span class="list_type">-</span>
              type
            </span>
      <span class="desc">발화를 입력하여 대화를 진행하였을 경우에는 ‘utter’, 버튼을 사용한 경우에는 ‘intent’를 보여줍니다.</span>
    </div>
  </li>
  <li>
    <p class="li_title">INTENT</p>
    <div class="li_cont">
            <span class="title">
              <span class="list_type">-</span>
              engine
            </span>
      <span class="desc">REGEX(정규식), NQA, BERT 중 어떤 엔진을 사용하여 사용자 발화의 의도를 찾았는지 보여줍니다.</span>
    </div>
    <div class="li_cont">
            <span class="title">
              <span class="list_type">-</span>
              prob
            </span>
      <span class="desc">위 엔진을 사용하여 찾은 의도의 정확도를 0~1까지의 정수로 보여줍니다. 정확도가 낮다면 해당 의도에 사용자 발화를 추가 학습하여 정확도를 높일 수 있습니다.</span>
    </div>
  </li>
  <li>
    <p class="li_title">TASK</p>
    <div class="li_cont">
            <span class="title">
              <span class="list_type">-</span>
              prev task
            </span>
      <span class="desc">현재 태스크 이전의 태스크를 보여줍니다.</span>
    </div>
    <div class="li_cont">
            <span class="title">
              <span class="list_type">-</span>
              task
            </span>
      <span class="desc">현재 매칭된 태스크를 보여줍니다. 기대했던 태스크가 매칭되지 않았다면, 답변 페이지의 해당 태스크 ‘상세’ 버튼에서 ‘태스크 관계’ 설정을 통해 태스크가 올바른 의도와 연결되어 있는지 확인 합니다. 올바른 의도와 연결되어 있음에도 기대 태스크가 매칭되지 않으면, 의도가 잘못 매칭된 것으로 해당 의도에 사용자 발화를 추가 학습하여 올바른 의도 및 태스크가 매칭되도록 합니다.</span>
    </div>
  </li>
  <li>
    <p class="li_title">ANSWER</p>
    <div class="li_cont">
            <span class="title">
              <span class="list_type">-</span>
              text
            </span>
      <span class="desc">사용자 발화에 매칭된 답변 결과를 보여줍니다.</span>
    </div>
  </li>
</ul>
