<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-04-08
  Time: 오후 4:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h4>챗봇빌더_엑셀파일작성</h4>
<p class="header_desc">엑셀 파일 작성을 통해 챗봇에서 필요한 다양한 답변 및 로직 설정이 가능합니다.</p>
<h5>작성 전 주의사항</h5>
<p class="header_desc">챗봇빌더 '샘플데이터 다운로드' 버튼을 통해 샘플데이터 양식을 다운받을 수 있습니다. 엑셀로 작성 시 샘플데이터 다운로드를 통해 기존 포맷을 지키며 작성을 부탁드립니다.</p>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/77707749/107318493-3dfad780-6ae0-11eb-9c67-9e8c8730343e.JPG" alt="샘플데이터 다운로드 위치">
</div>
<ul class="list">
  <li>
    <span class="list_type">-</span>
    한국어 버전만 작성을 하실 경우, 중/일/영 칼럼의 데이터란은 공백으로 하되, 1행의 제목란은 샘플데이터와 같이 동일하게 정의해주시기 바랍니다.
  </li>
  <li>
    <span class="list_type">-</span>
    인텐트시트에서 필요한 인텐트 작성 시, 사전에 학습이 안된 인텐트라면 해당 인텐트를 의도 페이지에서 정규식으로 추가 작성해주시기 바랍니다.
  </li>
  <li>
    <span class="list_type">-</span>
    컬럼의 순서는 샘플데이터 파일과 동일하게 작성해주시기 바랍니다.
  </li>
  <li>
    <span class="list_type">-</span>
    예외시트(Fallback시트)는 샘플데이터 내용에서 변경하지 않으셔도 됩니다.
  </li>
</ul>
<h5>답변시트(Task) 작성법</h5>
<div class="img_box">
  <img class="full_img" src="https://user-images.githubusercontent.com/77707749/107329190-29740a80-6af3-11eb-8998-507a11c45814.png" alt="엑셀 답변시트(Task)">
</div>
<ul class="list title_xl">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            번호(A열)
          </span>
    <span class="desc">태스크 번호를 기입하는 row입니다. 해당 row에 데이터가 존재하는 경우 번호를 순열에 맞게 추가해 주어야 합니다. 번호 미 기입 시 오류가 발생합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            이미지/Description(B~F열)
          </span>
    <div class="desc">
      각 태스크에 이미지 카드를 생성하는 row입니다. 사용자에게 task를 보여 줄 수 있는 방식으로 버튼과 캐로셀이 있습니다. 버튼은 디스플레이명에서 지정한 이름으로 보여 주는 것 이고 캐로셀은 이미지 셀에 등록된 사진과 디스플레이명, 디스크립션이 하나의 카드로 만들어져서 캐로셀 형식으로 보여집니다.
      <div class="img_box">
        <img class="auto_img" src="https://user-images.githubusercontent.com/77707749/107329289-4dcfe700-6af3-11eb-97c7-017a2faea150.png" alt="이미지 카드">
      </div>
      그림 예시를 보면 사진이 ‘이미지’, AVA 문구가 ‘디스플레이명’, 그리고 빨간 박스 안의 내용이 ‘Description’입니다. 하지만 이미지 같은 경우는 보통 jpg나 png 파일로 되어 있어 엑셀에 넣기 힘들기 때문에 이미지를 링크로 변환시켜서 변환된 링크를 이미지 cell에 기입 합니다. 이미지를 추가하는 다른 방법으로는 엑셀파일에서 이미지 cell에 별도 입력없이 챗봇빌더에 파일 업로드 후 각 각의 인텐트에 이미지 추가할 수 있습니다.<br><br>
      ※ 참고 : 이미지 -> 링크 변환 URL :: <a href="https://sds-dev.maum.ai:8080/brain-sds-builder/upload/image">https://sds-dev.maum.ai:8080/brain-sds-builder/upload/image</a>
    </div>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            태스크(G~J열)
          </span>
    <span class="desc">답변을 호출할 고유한 답변의 업무명(이름)을 정의하는 row입니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            디스플레이명(한/중/일/영)(K~N열)
          </span>
    <span class="desc">사용자에게 보여질 버튼 또는 이미지카드의 내용을 기입하는 row입니다. 각 태스크의 디스플레이명에 작성한 내용이 버튼 또는 이미지카드 안에 내용으로써 보여집니다. 번호1을 예로 들면 처음으로라는 태스크가 사용자에게 ‘처음으로' 이라는 내용을 담고있는 버튼 또는 이미지카드로 보여집니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            다음태스크 (O~R열)
          </span>
    <span class="desc">현재 답변과 이어질 다음 추천 태스크를 사용자에게 버튼 또는 이미지카드로 보여주는 기능입니다. 디스플레이명이 버튼/이미지카드 안의 내용 이라면, 다음태스크는 각 태스크를 버튼/이미지카드로 가져오는 기능 자체입니다. 그림 예시 중 다음태스크 row에 B라는 문자와 숫자의 의미는 ‘버튼으로써 A열에 기입한 번호와 맞는 task를 보여주겠다.’ 라는 것을 의미하고 I는 ‘이미지카드로써 다음 태스크를 보여주겠다.’ 를 의미합니다. 이미지로 다음 태스크를 보여줄 때는 B열(이미지)에 이미지 링크가 필수적으로 있어야 합니다. 번호1을 예로 들면 ‘처음으로' 라는 태스크-답변 이후에 객실예약을 이미지카드로 보여주고, 예약조회, 예약수정, 예약취소의 디스플레이명을 버튼으로 보여줘라’ 라는 의미가 됩니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            답변(S~V열)
          </span>
    <span class="desc">사용자에게 노출될 태스크의 답변을 정의하는 row입니다.</span>
  </li>
</ul>
<h6>답변 엑셀 작성시 유의 사항</h6>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            엑셀 규격
          </span>
    <span class="desc">해당 엑셀 시트는 한, 중, 일, 영으로 총 4개의 언어로 구성되어 있습니다. 만약 본인이 하나의 언어만 쓴다면 해당 언어로만 작성하고 나머지 언어 cell은 공란으로 두어도 되나 <span class="info_medium">절대 다른 row를 삭제해서는 안됩니다.</span> 한국어 이외의 다른 언어를 사용 하지 않는 다고 해서 다른 언어 row를 삭제하거나 순서를 바꾸면 오류가 납니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            그 외의 오류 케이스
          </span>
    <ul class="list">
      <li>
        <span class="list_type">1.</span>
        다음인텐트에서 , (쉼표)를 .(온점)으로 쓰는 경우
      </li>
      <li>
        <span class="list_type">2.</span>
        다음인텐트에서 쓰는 데이터가 번호 컬럼에 없는 경우 ex) A열 번호가 132번 까지 기입되어 있으나 다음인텐트에 B133 이 있을 경우
      </li>
      <li>
        <span class="list_type">3.</span>
        다음인텐트에 공백이 있는경우 ex) B2, B133
      </li>
    </ul>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            언어
          </span>
    <span class="desc">이미지, 디스크립션, 디스플레이명, 다음태스크, 답변은 사용자에게 보여지 지만 태스크는 사용자에게 보여지지 않습니다. 때문에 챗봇 사용자에게 보이는 부분만 해당 국가의 언어로 번역해서 작성하면 되고 사용자에게 보여지지 않는 태스크 row는 한/중/일/영 모두 관리자가 관리하기 편한 언어로 작성하여도 무방합니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            편의 기능
          </span>
    <ul class="list">
      <li>
              <span class="title">
                <span class="list_type">-</span>
                줄바꿈
              </span>
        <span class="desc">&#60;br&#62;로 표시</span>
      </li>
      <li>
              <span class="title">
                <span class="list_type">-</span>
                버튼 내 링크 삽입
              </span>
        <span class="desc">&#60;a href="이동할url"&#62;버튼이름&#60;/a&#62;</span>
      </li>
      <li>
              <span class="title">
                <span class="list_type">-</span>
                말풍선 나누기
              </span>
        <span class="desc">||||| (Shift + )</span>
      </li>
    </ul>
  </li>
</ul>
<h5>인텐트 시트(BertIntent) 작성법</h5>
<p class="header_desc">해당 시트는 모든 intent를 정의하는 시트 입니다. 답변 시트의 태스크 열에서 작성한 것과 동일하게 작성하길 권장합니다. 태스크와 이름을 꼭 같게 할 필요는 없지만 동일하게 하는 것이 관리하기 더 편하고 로직(Relation 시트) 설정시 용이하기 때문에 동일하게 하는 것을 권장 드립니다. 챗봇 사용자에게 보여지는 부분이 아니기 때문에 한/중/일/영 모두 관리하기 편한 언어로 통일합니다.</p>
<div class="img_box">
  <img class="auto_img" src="https://user-images.githubusercontent.com/77707749/107330083-72788e80-6af4-11eb-85aa-e93e101d7309.png" alt="인텐트시트(BertIntent)">
</div>
<h6>인텐트 엑셀 작성시 유의 사항</h6>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            엑셀 규격
          </span>
    <span class="desc">해당 엑셀 시트는 한, 중, 일, 영으로 총 4개의 언어로 구성되어 있습니다. 만약 본인이 하나의 언어만 쓴다면 해당 언어로만 작성하고 나머지 언어 cell은 공란으로 두어도 되나 <span class="info_medium">절대 다른 row를 삭제해서는 안됩니다.</span> 한국어 이외의 다른 언어를 사용 하지 않는 다고 해서 다른 언어 row를 삭제하거나 순서를 바꾸면 오류가 납니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            언어
          </span>
    <span class="desc">인텐트는 사용자에게 보여지지 않습니다. 때문에 한/중/일/영 모두 관리자가 관리하기 편한 언어로 작성하여도 무방합니다.</span>
  </li>
  <li>
    <span class="list_type">-</span>
    편의를 위해 태스크와 동일한 이름으로 작성할 경우 인텐트와 태스크를 헷갈리지 않고 구분해야 합니다.
  </li>
</ul>
<h5>로직 시트(Relation) 작성법</h5>
<div class="img_box">
  <img class="auto_img" src="https://user-images.githubusercontent.com/77707749/107330913-88d31a00-6af5-11eb-8231-6c49ba2aeca6.png" alt="로직시트(Relation)">
</div>
<div class="paragraph">
  <p>해당 시트에서는 intent와 태스크의 관계를 형성하여 챗봇의 대화 흐름을 컨트롤 할 수 있는 시트입니다.</p>
  <ul class="list">
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Src_Task
            </span>
      <span class="desc">현재 task</span>
    </li>
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Dest_ Task
            </span>
      <span class="desc">다음 task</span>
    </li>
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Bert_Intent
            </span>
      <span class="desc">BertIntent 시트에서 작성한 intent</span>
    </li>
  </ul>
  <p>풀어서 설명하자면 현재 task에서 어떠한 intent를 받으면 다음 task로 넘어갈 것인지 Logic을 짜는 것 입니다. 또한 여기서 보면 *가 되어 있는데 이 문자의 의미가 anywhere, 즉 모든 task를 의미합니다. 엑셀 이미지의 2번째 행 예시는 다음과 같습니다.</p>
  <ul class="list">
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Src_Task
            </span>
      <span class="desc">*(anywhere)</span>
    </li>
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Dest_ Task
            </span>
      <span class="desc">객실예약</span>
    </li>
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Bert_Intent
            </span>
      <span class="desc">객실예약</span>
    </li>
  </ul>
  <p>모든 태스크에서 태스크 ‘객실예약’으로 가기 위해 필요한 intent는 ‘객실예약’ 으로 설정하는 것 입니다. 다른 예를 들어보자면 사용자가 객실(Src_Task)에 대해서 발화 하다가 예약(Bert_Intent)을 물어보면 객실예약(Dest_Task)라는 태스크로 가게끔 로직을 설정하는 것 입니다. 해당 예시에서는 사용자가 처음부터 객실예약에 대해서 물어 볼 경우, 예약에 대해 발화한 후 객실에 대해 물어보는 경우도 생각하여 아래와 같이 추가적으로 로직을 생성해야 합니다.</p>
  <ul class="list">
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Src_Task
            </span>
      <span class="desc">객실</span>
    </li>
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Dest_ Task
            </span>
      <span class="desc">객실예약</span>
    </li>
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Bert_Intent
            </span>
      <span class="desc">예약</span>
    </li>
  </ul>
  <ul class="list">
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Src_Task
            </span>
      <span class="desc">예약</span>
    </li>
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Dest_ Task
            </span>
      <span class="desc">객실예약</span>
    </li>
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Bert_Intent
            </span>
      <span class="desc">객실</span>
    </li>
  </ul>
  <ul class="list">
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Src_Task
            </span>
      <span class="desc">*</span>
    </li>
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Dest_ Task
            </span>
      <span class="desc">객실예약</span>
    </li>
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Bert_Intent
            </span>
      <span class="desc">객실예약</span>
    </li>
  </ul>
  <p>이처럼 로직을 짤 때는 단순한 flow만 볼 것이 아니라 모든 경우의 수를 생각해서 로직을 짜야 합니다.</p>
</div>
<h6>로직 엑셀 작성 시 유의 사항</h6>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            엑셀 규격
          </span>
    <span class="desc">해당 엑셀 시트는 한, 중, 일, 영으로 총 4개의 언어로 구성되어 있습니다. 만약 본인이 하나의 언어만 쓴다면 해당 언어로만 작성하고 나머지 언어 cell은 공란으로 두어도 되나 <span class="info_medium">절대 다른 row를 삭제해서는 안됩니다.</span> 한국어 이외의 다른 언어를 사용 하지 않는 다고 해서 다른 언어 row를 삭제하거나 순서를 바꾸면 오류가 납니다.</span>
  </li>
  <li>
          <span class="title">
            <span class="list_type">-</span>
            언어
          </span>
    <span class="desc">해당 시트도 다른 시트와 마찬가지로 한/중/일/영 언어로 작성하게 되어 있는데 이 부분 역시 사용자에게 보여지는 부분이 아닙니다. 이 시트는 답변(Task)시트와 인텐트(BertIntent)시트에서 태스크와 intent를 작성하였던 언어로 작성해주면 됩니다.</span>
  </li>
  <li>
    <span class="list_type">-</span>
    답변(Task)시트의 Task에 없거나 인텐트(BertIntent)시트에 없는 데이터를 기입하여 로직을 구성할 경우 오류가 납니다.
  </li>
</ul>
<h5>예외 시트(Fallback)</h5>
<div class="img_box">
  <img class="auto_img" src="https://user-images.githubusercontent.com/77707749/107332005-f0d63000-6af6-11eb-8182-fbf7d27196f3.png" alt="예외시트(Fallback)">
</div>
<div class="paragraph">
  <p>세번째 시트는 예외 시트로 로직(Relation)시트에 정의되어 있지 않은 로직이 챗봇 상에서 나타날 경우에 Default 태스크인 죄송이 매칭됩니다.</p>
  <ul class="list">
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Src_Task
            </span>
      <span class="desc">객실예약</span>
    </li>
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Dest_ Task
            </span>
      <span class="desc">예약조회</span>
    </li>
    <li>
            <span class="title">
              <span class="list_type">-</span>
              Bert_Intent
            </span>
      <span class="desc">예약조회</span>
    </li>
  </ul>
  <p>위와 같은 로직 외의 다른 로직은 짜여져 있지 않다고 가정해 보겠습니다. 객실예약 태스크에서 예약조회 intent를 잡으면 예약조회 태스크-답변을 해주게 로직이 짜여 있지만, 만약 객실예약에서 예약조회가 아닌 식당예약 이라는 intent를 잡으면 Default 태스크인 죄송이 매칭됩니다.</p>
</div>
<h6>예외 시트 유의 사항</h6>
<ul class="list">
  <li>
          <span class="title">
            <span class="list_type">-</span>
            엑셀 규격 및 언어
          </span>
    <span class="desc">해당 엑셀 시트는 Default 시트로 <span class="info_medium">수정해서는 안됩니다.</span></span>
  </li>
  <li>
    <span class="list_type">-</span>
    답변(Task)시트에 죄송 태스크를 추가 해 죄송 태스크에 대한 답변을 수정할 수 있습니다.
  </li>
</ul>
