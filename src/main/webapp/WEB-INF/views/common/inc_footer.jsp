<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.11.0.min.js"></script> -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/conn.ws.js"></script>



<input type ="hidden" id="alertType"/>
<div class="lyrBox lyrAlert" id="alertBox">
	<div class="lyr_mid">
	    <span class="message">span 영역 입니다.</span>
	</div>
	<div class="lyr_btm">
        <div class="btnBox sz_small" id="alertBtnBox">
	    </div>
    </div>
</div>
<!-- IB 사용자 프로필 -->
<div class="lyrBox" id="ib_infoLayer">
	<div class="lyr_top">
		<h3><spring:message code="A0064" text="고객정보 변경" /></h3>
		<button class="btn_lyr_close">닫기</button>
	</div>
	<div class="lyr_mid">
	    <p><em class="ft_clr_1st">*</em><spring:message code="A0583" text="는 필수 입력 사항 입니다." /></p>
		<table class="tbl_line_view">
			<caption class="hide"><spring:message code="A0064" text="고객정보 변경" /></caption>
			<colgroup>
				<col width="75">
				<col>
				<col width="75">
				<col>
			</colgroup>
				<tbody>
				<form id="UserEdtForms">
					<input type="hidden" id="USEREDT_CUST_ID" name="USEREDT_CUST_ID">
					<tr>
						<th scope="row"><em>*</em><spring:message code="A0039" text="성명" /></th>
						<td>
							<div class="iptBox">
								<input type="text" class="ipt_txt" id="USEREDT_CUST_NM" name="USEREDT_CUST_NM">
							</div>
						</td>
						<th>Chat ID</th>
						<td>
							<div class="iptBox">
								<input type="text" class="ipt_txt"  id="USEREDT_CONSULT_CHAT_ID" name="USEREDT_CONSULT_CHAT_ID">
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="A0040" text="고객구분" /></th>
						<td>
							<div class="radioBox purple">
								<input type="radio" name="USEREDT_ipt_radio"  id="ipt_radio3_1_1" class="ipt_radio "  value="0" checked="checked"> <label for="ipt_radio3_1_1"><spring:message code="A0041" text="개인" /></label>
								<input type="radio" name="USEREDT_ipt_radio" id="ipt_radio3_1_2" class="ipt_radio "  value="1"> <label for="ipt_radio3_1_2"><spring:message code="A0042" text="법인" /></label>
							<!-- 				
								<input type="radio" name="ipt_radio" id="ipt_radio3_1_1" class="ipt_radio"> <label for="ipt_radio3_1_1">개인</label> 
								<input type="radio" name="ipt_radio" id="ipt_radio3_1_2"	class="ipt_radio"> <label for="ipt_radio3_1_2">법인</label> -->
							</div>
						</td>
						<th><spring:message code="A0051" text="현상태" /></th>
						<td>
							<div class="iptBox">
								<input type="text" class="ipt_txt" id="USEREDT_CUST_STATE_NM" name="USEREDT_CUST_STATE_NM">
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="A0043" text="구독플랜" /></th>
						<td>
							<div class="iptBox">
								<input type="text" class="ipt_txt"  id="USEREDT_CUST_SUBSC_PLAN" name="USEREDT_CUST_SUBSC_PLAN">
							</div>
						</td>
						<th><spring:message code="A0052" text="API계정 ID" /></th>
						<td>
							<div class="iptBox">
								<input type="text" class="ipt_txt"  id="USEREDT_CUST_API_ID" name="USEREDT_CUST_API_ID" >
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="A0053" text="API계정 Key" /></th>
						<td>
							<div class="iptBox">
								<input type="text" class="ipt_txt"   id="USEREDT_CUST_API_KEY" name="USEREDT_CUST_API_KEY" >
							</div>
						</td>
						<th><spring:message code="A0044" text="가입경로" /></th>
						<td>
							<div class="iptBox">
								<input type="text" class="ipt_txt"   id="USEREDT_CUST_REG_PATH" name="USEREDT_CUST_REG_PATH" >
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="A0045" text="가입일" /></th>
						<td>
							<div class="iptBox">
								<input type="text" class="ipt_dateTime"   id="USEREDT_CUST_REG_DATE" name="USEREDT_CUST_REG_DATE" >
							</div>
						</td>
						<th><spring:message code="A0054" text="해지일" /></th>
						<td>
							<div class="iptBox">
								<input type="text" class="ipt_dateTime"   id="USEREDT_CUST_TERM_DATE" name="USEREDT_CUST_TERM_DATE" >
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="A0046" text="자택주소" /></th>
						<td colspan="3">
							<div class="iptBox">
								<input type="text" class="ipt_txt"   id="USEREDT_CUST_ADDRESS" name="USEREDT_CUST_ADDRESS" >
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="A0047" text="직장주소" /></th>
						<td colspan="3">
							<div class="iptBox">
								<input type="text" class="ipt_txt"   id="USEREDT_CUST_ADDRESS2" name="USEREDT_CUST_ADDRESS2" >
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="A0048" text="이메일" /></th>
						<td>
							<div class="iptBox">
								<input type="text" class="ipt_txt"   id="USEREDT_CUST_EMAIL" name="USEREDT_CUST_EMAIL" >
							</div>
						</td>
						<th><spring:message code="A0055" text="자택전화" /></th>
						<td>
							<div class="iptBox">
								<input type="text" class="ipt_txt"   id="USEREDT_CUST_HOME_NO" name="USEREDT_CUST_HOME_NO" >
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><em>*</em><spring:message code="A0049" text="이동전화" /></th>
						<td>
							<div class="iptBox">
								<input type="text" class="ipt_txt"   id="USEREDT_CUST_TEL_NO" name="USEREDT_CUST_TEL_NO" >
							</div>
						</td>
						<th><spring:message code="A0056" text="직장전화" /></th>
						<td>
							<div class="iptBox">
								<input type="text" class="ipt_txt"   id="USEREDT_CUST_COMPANY_NO" name="USEREDT_CUST_COMPANY_NO" >
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="A0057" text="결제정보" /></th>
						<td colspan="3">
							<div class="dlBox_bg">
								<dl>
									<dt><spring:message code="A0058" text="카드정보" /></dt>
									<dd>
										<div class="iptBox">
											<input type="text" class="ipt_txt"  id="PAYEDT_CARD_INFO" name="PAYEDT_CARD_INFO" >
										</div>
									</dd>
								</dl>
								<dl>
									<dt><spring:message code="A0043" text="구독플랜" /></dt>
									<dd>
										<div class="iptBox">
											<input type="text" class="ipt_txt"  id="PAYEDT_CUST_SUBSC_PLAN" name="PAYEDT_CUST_SUBSC_PLAN" >
										</div>
									</dd>
								</dl>
								<dl>
									<dt><spring:message code="A0059" text="최근 결제일" /></dt>
									<dd>
										<div class="iptBox">
											<input type="text" class="ipt_dateTime"  id="PAYEDT_RECENT_PAYMENT_DATE" name="PAYEDT_RECENT_PAYMENT_DATE" >
										</div>
									</dd>
								</dl>
								<dl>
									<dt><spring:message code="A0060" text="다음 결제일" /></dt>
									<dd>
										<div class="iptBox">
											<input type="text" class="ipt_dateTime"  id="PAYEDT_NEXT_PAYMENT_DATE" name="PAYEDT_NEXT_PAYMENT_DATE" >
										</div>
									</dd>
								</dl>
								<dl>
									<dt><spring:message code="A0061" text="결제금액" /></dt>
									<dd>
										<div class="iptBox">
											<input type="text" class="ipt_txt"  id="PAYEDT_PAY_AMOUNT" name="PAYEDT_PAY_AMOUNT"  >
										</div>
									</dd>
								</dl>
								<dl>
									<dt><spring:message code="A0062" text="결제예정금액" /></dt>
									<dd>
										<div class="iptBox">
											<input type="text" class="ipt_txt"  id="PAYEDT_EXPECTED_PAY_AMOUNT" name="PAYEDT_EXPECTED_PAY_AMOUNT"  >
										</div>
									</dd>
								</dl>
							</div>
						</td>
					</tr>
					</form>
				</tbody>
		</table>
	</div>
	<div class="lyr_btm">
		<div class="btnBox sz_small">
			<button class="" id="saveUser"><spring:message code="A0320" text="저장" /></button>
			<button class="btn_lyr_close"><spring:message code="A0532" text="취소" /></button>
		</div>
	</div>
</div>
<!-- IB //사용자 프로필 -->	
	
<!-- OB //사용자 프로필 -->
<div class="lyrBox" id="ob_infoLayer">
	<div class="lyr_top">
		<h3><spring:message code="A0064" text="고객정보 변경" /></h3>
		<button class="btn_lyr_close">닫기</button>
	</div>
	<form id="userEdtForm" method="post">
	<div class="lyr_mid">
		<table class="tbl_line_view">
			<caption class="hide">고객정보 변경</caption>
			<colgroup>
				<col width="75">
				<col>
				<col width="75">
				<col>
			</colgroup>
			<tbody id="userEdtBody">
			</tbody>
        </table>
	</div>
	</form>
	<div class="lyr_btm">
		<div class="btnBox sz_small">
			<button onclick="saveUser()"><spring:message code="A0037" text="확인" /></button>
		</div>
	</div>
</div>
<!-- OB //사용자 프로필 -->
	
<div class="lyrBox contactBox" id="mailForm">
    <div class="contact_tit">
        <h3><spring:message code="A0614" text="서비스 신청 및 문의하기"/></h3>
    </div>
    <div class="contact_cnt">
        <p class="info_txt"><spring:message code="A0632" text="서비스에 관련된 문의를 남겨 주시면 담당자가 확인 후 연락 드리겠습니다." /></p>
        <ul class="contact_lst">
            <li><a href="tel:1661-3222">1661-3222</a></li>
            <li><span>hello@maum.ai</span></li>
        </ul>
        <form id="sendmailForm">
	        <div class="contact_form">
	            <div class="contact_item">
	                <input type="text" id="send_user_name" class="ipt_txt" autocomplete="off">
	                <label for="user_name">
	                    <span class="fas fa-user" aria-hidden="true"></span><spring:message code="A0032" text="이름" />
	                </label>
	            </div>
	            <div class="contact_item">
	                <input type="text" id="send_user_email" class="ipt_txt" autocomplete="off">
	                <label for="user_email">
	                    <span class="fas fa-envelope" aria-hidden="true"></span><spring:message code="A0048" text="이메일" />
	                </label>
	            </div>
	            <div class="contact_item">
	                <input type="text" id="send_user_phone" class="ipt_txt" autocomplete="off">
	                <label for="user_phone">
	                    <span class="fas fa-mobile-alt" aria-hidden="true"></span><spring:message code="A0074" text="연락처" />
	                </label>
	            </div>
	            <div class="contact_item_block">
	                <textarea id="send_user_text" class="textArea" rows="6"></textarea>
	                <label for="textArea">
	                    <span class="fas fa-align-left" aria-hidden="true"></span><spring:message code="A0633" text="문의내용" />
	                </label>
	            </div>
	        </div>
        </form>
    </div>
    <div class="contact_btn">
        <button id="btn_sendMail" class="btn_inquiry" onclick="sendMail()"><spring:message code="A0327" text="문의하기" /></button>
        <button class="btn_lyr_close" id="close_sendmail_form"><spring:message code="A0631" text="닫기" /></button>
    </div>
</div>

<!-- 사용자 프로필 -->
<div id="lyr_profile" class="lyrBox lyr_profile">
	<div class="lyr_top">
		<h3><spring:message code="A0030" text="프로필" /></h3>
		<button class="btn_lyr_close">닫기</button>
	</div>
	<div class="lyr_mid">
		<p class="check_modif" style="display: none" id="modif_warn"><spring:message code="A0960" text=""/></p>
		<dl class="dlBox">
			<dt><spring:message code="A0031" text="아이디" /></dt>
			<dd>
				<div class="iptBox">
					<input type="text" class="ipt_txt" id="userIdForEdit" value="${user.userId}" disabled>
				</div>
			</dd>
		</dl>
		<dl class="dlBox">
			<dt><spring:message code="A0032" text="이름" /></dt>
			<dd>
				<div class="iptBox">
					<input type="text" class="ipt_txt" id="userNameForEdit" value="${user.userNm}" disabled>
				</div>
			</dd>
		</dl>
		<dl class="dlBox">
			<dt><spring:message code="A0612" text="비밀번호" /></dt>
			<dd>
				<div class="iptBox" style="margin-bottom: 7px;">
					<input type="password" class="ipt_txt" placeholder="<spring:message code="A0268" text="기존 비밀번호" />" id="originPw">
					<!-- [D] 에러메세지 -->
					<p class="error_msg" style="display:none;" id="originPwTest"><spring:message code="A0269" text="기존 비밀번호를 입력해 주세요." /></p>
				</div>
				<div class="iptBox" style="margin-bottom: 7px;">
					<input type="password" class="ipt_txt" placeholder="<spring:message code="A0033" text="비밀번호" />" id="testPw1">
					<!-- [D] 에러메세지 -->
					<p class="error_msg" style="display:none;" id="pwTest1" ><spring:message code="A0034" text="패스워드 생성규칙이 올바르지 않습니다. 8~20자 이내, 영문 특수문자 숫자 포함" /></p>
					<p class="error_msg" style="display:none;" id="pwTest12"><spring:message code="A0950" text="패스워드 생성규칙이 올바르지 않습니다. 8~20자 이내, 영문 특수문자 숫자 포함" /></p>
					<p class="error_msg" style="display:none;" id="pwTest13"><spring:message code="A0951" text="패스워드 생성규칙이 올바르지 않습니다. 8~20자 이내, 영문 특수문자 숫자 포함" /></p>
					<p class="error_msg" style="display:none;" id="pwTest14"><spring:message code="A0952" text="패스워드 생성규칙이 올바르지 않습니다. 8~20자 이내, 영문 특수문자 숫자 포함" /></p>

				</div>
				<div class="iptBox">
					<input type="password" class="ipt_txt" placeholder="<spring:message code="A0035" text="비밀번호 확인" />" id="testPw2">
					<!-- [D] 에러메세지 -->
					<p class="error_msg" style="display:none;" id="pwTest2"><spring:message code="A0036" text="패스워드가 일치하지 않습니다." /></p>
					<p class="modified_msg"><spring:message code="A0961" text="" /><span id="last_modified"></span></p>
				</div>
			</dd>
		</dl>
	</div>
	<div class="lyr_btm">
		<div class="btnBox sz_small">
			<button class="btn_lyr" id="btnEditPw"><spring:message code="A0037" text="확인" /></button>
		</div>
	</div>
</div>
<div id="lyr_com_chk" class="lyrBox lyr_alert">
    <div class="lyr_cont">
        <p></p>
    </div>

    <div class="btnBox sz_small">
        <button class="btn_lyr_del"><spring:message code="A0037" text="확인" /></button>
    </div>
</div>

<!-- //사용자 프로필 -->

<!-- 도움말 -->  
<div id="lyr_help" class="lyrBox">
    <div class="lyr_top">
        <h3>도움말</h3>
        <button class="btn_lyr_close">닫기</button>
     </div>
    <div class="lyr_mid">
        <div class="helpBox">
            <h3>I/B 상담하기</h3>
            <dl>
                <dt>대시보드</dt>
                <dd>
IN-BOUND의 기간별 응대 현황과 I/B Call 통계, 실시간 상담현황 데이터를 조회할 수 있는 화면입니다.
응대 현황 : 설정한 기준일에 따라 전체현황, 상담현황(실시간) 데이터를 표시합니다.
총인입은 외부에서 걸려온 모든 콜횟수이며, 응대의 종류에는 Bot, Bot+CSR, Etc 가 있습니다.
응대란 포기, 발신을 제외한 모든 인입콜 횟수이며, 어떤 콜타입으로 통화를 종료했냐에 따라 그에 맞게 카운트 됩니다. ex) 봇이 통화종료 → bot, 사용자가 통화종료 → Etc
상담 현황(실시간) : 현재 INBOUND, OUTBOUND 응대중인 봇,상담사 수와 대기중인 봇,상담사 수, 응대외 현황을 조회합니다.
I/B Call 통계 : 설정한 기준일에 따라 I/B Call 통계를 그래프로 나타냅니다.
그래프에 커서를 올리면 해당 날짜에 해당하는 상세한 통계이력이 표시됩니다.
실시간 상담현황 : 현재 I/B에 할당된 BOT, 상담사의 회선 및 상태값을 나타냅니다.
통화중, 대기중, 연결안됨의 상태값이 존재합니다.
                </dd>
            </dl>
            <dl>
                <dt>IB 상담화면</dt>
                <dd>
고객이 상담사에게 할당된 회선 번호로 전화를 걸면, 진행중인 통화에 대한 전반적인 내용을 실시간으로 확인할 수 있는 화면입니다.
상담사의 상태값을 설정할 수 있습니다.
수신대기 : 상담사가 콜을 받을 수 있는 상태입니다.
업무 : 상담사가 다른 업무로 인해 콜을 받지 못하는 상태입니다.
휴식 : 휴식시간으로 콜을 받지 못하는 상태입니다.
상담사가 속한 회사의 총 현황과 상담사 본인의 현황을 확인할 수 있습니다.
총인입수와 음성봇, 상담사(사람)의 응대 현황과 대기고객, 통화시간 등을 확인할 수 있습니다.
상담사에게 할당된 각각의 회선마다 콜 진행을 모니터링 할 수 있습니다.
음성봇1 (07070907044)과 같은 타이틀 영역을 클릭하면 상단에서 통화에 대한 정보를 확인 할 수 있습니다.
전화한 고객에 대한 정보를 확인합니다.(고객정보는 DB에 저장되어있는 고객인 경우에만 확인할 수 있습니다.)
정보변경 : 전화한 고객에 대한 정보를 수정할 수 있습니다.
신규등록 : 등록되어있지 않은 고객인 경우, 고객 데이터를 신규로 등록할 수 있습니다.
상담사가 통화에 대한 내용을 저장할 수 있습니다.
저장할 때, 저장 후 상태값을 설정할 수 있습니다. 상태값은 상단의 수신대기, 업무, 휴식과 동일합니다.
진행되는 콜에 대해 모니터링 할 수 있습니다.
번호, 구간, 탐지 : 통화중 언급되었는지 또는 어떤 대답을 하였는지 등을 체크합니다.
콜청취 : 진행되는 통화를 청취합니다.
상답개입 : 음성봇과 고객이 통화하는 것을 모니터링하다가 상담개입을 눌러 상담사와 고객이 통화합니다.
                </dd>
            </dl>
            <dl>
                <dt>I/B콜 통계</dt>
                <dd>
IN-BOUND-CALL 통계 수치를 나타내는 화면입니다.
I/B콜은 고객이 지정된 회선으로 전화를 거는 것을 의미합니다.
I/B콜 통계 페이지에서는 콜이 어떤 방식으로 진행되었는지에 대해 통계를 확인할 수 있습니다.
Company : 로그인한 계정이 소속된 회사입니다.
검색유형 : 30분, 시간, 일, 월 단위로 통계를 확인할 수 있습니다.
검색일자 : 설정되어있는 검색 유형에 따라 30분, 시간, 일, 월 단위로 통계를 확인하고 싶은 기간을 설정합니다.
제외여부 : 주말제외가 체크되어있는 경우, 통계에서 주말 데이터는 제외되어 보여집니다.
검색 : 검색유형, 검색일자, 제외여부를 설정하였다면 검색버튼을 눌러 통계를 확인할 수 있습니다.
다운로드 : 검색된 데이터들이 엑셀파일로 다운로드됩니다. 만약 데이터가 존재하지 않는다면 다운로드되지 않습니다.
총인입 : 해당 시간에 진행된 콜의 수 입니다.
Bot응대 : 음성봇이 통화를 종료한 경우입니다.
Bot + CSR : 음성봇과 상담사가 콜을 진행한 경우입니다.
ETC : 상담사가 통화를 종료한 경우입니다.
총응대호 : 콜이 정상적으로 진행된 경우입니다.
응대율 : 총응대호 / 총인입 을 퍼센트로 나타낸 수치입니다.
포기호 : 통화중 끊어진 경우를 의미합니다.
포기율 : 포기호 / 총인입 을 퍼센트로 나타낸 수치입니다.
평균통화시간 : 총응대호로 잡힌 통화에 대한 평균 통화 시간을 의미합니다.
평균포기시간 : 포기호로 잡힌 통화에 대한 평균 포기 시간을 의미하나, 현재는 00:00:00으로 표시되고 있습니다.
                </dd>
            </dl>
            <h3>O/B 상담</h3>
            <dl>
                <dt>O/B 상담화면</dt>
                <dd>
상담사에게 할당된 AI Outbound을 수동으로 진행하거나, 현재 진행중인 Outbound를 실시간으로 모니터링하며, 필요시엔 청취 및 상담개입을 할 수 있는 화면 입니다.
DB List에 AI OutBound Call을 발송할 수 있는 대상 고객의 분류, 이름, 전화번호, 최근 AI OB 진행 상태 리스트가 보여집니다. 목록 중 이름을 클릭하면 등록된 고객 상세 정보가 보여지며 정보를 수정할 수 있습니다. 회선번호 또는 내선번호로 진행 중인 Outbound 통화의 STT를(왼쪽 상담봇, 오른쪽 고객 발화) 실시간으로 확인 할 수 있으며 해당 영역을 클릭하면 D영역에 실시간 STT 내용과 E영역에 진행 중인 시나리오의 단계별로 대상 고객이 긍정 혹은 부정으로 대답했는지 여부 등 시나리오에 적용된 탐지값을 기준으로 내용을 확인 할 수 있습니다.
                </dd>
            </dl>
            <dl>
                <dt>O/B 콜통계</dt>
                <dd>
상담사에게 할당된 AI Outbound을 수동으로 진행하거나, 현재 진행중인 Outbound를 실시간으로 모니터링하며, 필요시엔 청취 및 상담개입을 할 수 있는 화면 입니다.
DB List에 AI OutBound Call을 발송할 수 있는 대상 고객의 분류, 이름, 전화번호, 최근 AI OB 진행 상태 리스트가 보여집니다. 목록 중 이름을 클릭하면 등록된 고객 상세 정보가 보여지며 정보를 수정할 수 있습니다. 회선번호 또는 내선번호로 진행 중인 Outbound 통화의 STT를(왼쪽 상담봇, 오른쪽 고객 발화) 실시간으로 확인 할 수 있으며 해당 영역을 클릭하면 D영역에 실시간 STT 내용과 E영역에 진행 중인 시나리오의 단계별로 대상 고객이 긍정 혹은 부정으로 대답했는지 여부 등 시나리오에 적용된 탐지값을 기준으로 내용을 확인 할 수 있습니다.
                </dd>
            </dl>
            <h3>챗봇 상담</h3>
            <dl>
                <dt>채팅 상담</dt>
                <dd>
고객의 챗봇 대화를 모니터링하고, '상담개입'을 통해 고객과 실시간 채팅 상담을 진행합니다.
챗봇에 고객 발화가 들어오면 좌측 리스트에 한 줄이 추가됩니다.
리스트의 원하는 대화 세션을 클릭하면 아래와 같이 해당 세션의 대화 내용을 모니터링할 수 있습니다.
고객정보창
인입채널: 챗봇/서비스 종류 id
세션ID: 대화의 고유한 세션 id
성명: 고객의 로그인 id, id가 없으면 접속 세션 id
상담 개입
모니터링 중 상담사가 개입을 원할 때 (혹은 고객에게 상담사 연결 요청이 왔을 때) 하단의 '상담개입' 버튼을 눌러 개입이 가능합니다.
실시간 채팅 상담
상담 개입 후에는 상담사와 고객이 실시간 채팅을 합니다.
상담 종료
상담 종료를 클릭하면, 채팅 목록에서 해당 세션이 사라집니다.
고객에게는 'end conversataion' 알람이 가고, 그 후에 고객의 발화는 다시 챗봇에게 전달됩니다.
                </dd>
            </dl>
            <h3>FAST AICC 관리</h3>
            <dl>
                <dt>COMPANY 및 권한 관리</dt>
                <dd>
회사 등록 및 수정, 해당 회사의 메뉴를 관리합니다. (SUPER-ADMIN이 관리하는 메뉴입니다.)
COMPANY 및 권한 관리 메인 화면
시스템 사용 여부 및 조건 선택으로 회사 리스트를 검색 할 수 있습니다.
회사 리스트에는 회사 ID, 회사 명, 회사 명(영문), 연락처, 시스템 사용여부, 등록일을 볼 수 있습니다
회사 정보 등록
메인 화면에 등록 클릭 시 회사 정보를 등록 할 수 있는 팝업창이 나옵니다.
회사 등록은 SUPER-ADMIN이 등록 할 수 있습니다.
각 필드에 내용을 입력합니다.
회사 명 : 등록하려는 회사 명. (필수 입력)
회사 명(영문) : 등록하려는 영문 회사명.
대표자 명 : 회사의 대표자 이름.
사업자등록번호 : 회사의 사업등록번호.
법인등록번호 : 회사의 법인등록번호.
주소 : 회사의 주소 및 상세 주소
팩스번호 : 회사 팩스번호.
담당자연락처 : 회사 담당자 연락처.
시스템 사용여부 : 서비스 사용 여부.
회사명 중복체크 후 필수 입력 사항 및 정보를 입력 후 저장 버튼을 누르면 등록이 완료됩니다.
회사 정보 수정 및 삭제
회사리스트에서 회사명 클릭 시 해당 회사의 정보를 수정 및 삭제 할 수 있는 팝업창이 나옵니다.
수정 하고 싶은 내용을 입력 후 수정버튼을 클릭하면 수정이 됩니다.
삭제를 원하시는 회사는 해당 회사명 클릭 후 팝업이 나오면 삭제버튼을 클릭하면 삭제가 됩니다.
권한관리 부여 및 수정
권한관리 버튼을 클릭하면 메뉴를 부여 할 수 있는 메뉴리스트 팝업창이 나옵니다
회사가 신청한 메뉴를 체크 후 저장하면 해당 회사가 이용 할 수 있는 메뉴가 저장됩니다.
수정시 다시 버튼 클릭 후 회사에 부여된 메뉴를 수정하실수 있습니다.
                </dd>
            </dl>
            <dl>
                <dt>사용자 관리</dt>
                <dd>
모든 회사의 사용자를 등록, 수정, 삭제를 관리합니다.(SUPER_ADMIN이 관리하는 메뉴입니다.)
사용자 관리 메인화면
권한 유형 및 조건 선택으로 사용자 리스트를 검색 할 수 있습니다.
권한유형에는 SUPERADMIN, ADMIN, CONSULTANT, GUEST를 선택하여 검색 할 수 있습니다.
조건 선택에서는 이름, ID, 회사 ID, 회사 명, 회사 명(영문)를 선택하여 검색 할 수 있습니다.
이름, 아이디, 회사 ID, 회사 명, 회사 명(영문), 연락처, 권한유형, 등록일을 볼 수 있습니다.
사용자 등록
등록 버튼 클릭 시 사용자 정보를 등록 할 수 있는 팝업창이 나옵니다.
Fast-aicc관리의 사용자 등록 SUPER-ADMIN만 등록이 가능합니다.
회사 조회 버튼을 통해 회사를 검색하고 원하는 회사를 선택한 후 저장을 하면 해당 회사에 사용자를 등록 할 수 있습니다.
검색 조건에서 회사 명, 회사 명(영문), 회사 ID를 선택 후 검색합니다.
원하시는 회사를 선택 후 저장버튼을 클릭합니다.
각 필드에 내용을 입력합니다.
사용자 ID : 사용자가 사용할 아이디. (필수 입력)
비밀번호 : 사용자가 사용할 비밀번호. (필수 입력)
권한유형: 사용자에게 부여할 권한. (필수 입력)
성별: 사용자의 성별.
이름 : 사용자의 이름. (필수 입력)
생년월일 : 사용자의 생년월일.
이메일 : 사용자의 이메일.
휴대폰 번호 : 사용자의 휴대번호.
직급 : 사용자의 직급.
부서 : 사용자의 해당 부서.
주소 : 사용자의 주소.
사용여부 : 사용자 ID 사용 여부. (필수 입력)
사용자 ID 중복체크 후 필수 입력 사항 및 정보를 입력 후 저장 버튼을 누르면 등록이 완료됩니다.
사용자 정보 수정
사용자리스트에서 사용자 ID 클릭 시 해당 사용자의 정보를 수정 할 수 있는 팝업창이 나옵니다.
수정하고 싶은 내용을 입력 후 수정 버튼을 클릭하면 수정이 됩니다.
단, 사용자 ID는 수정이 불가능합니다.
사용자의 회사변경을 원할 시 등록에서의 방법으로 조회 후 변경 하실 수 있습니다.
사용자 정보 삭제
삭제하고 싶은 사용자를 체크 후 삭제 버튼을 클릭합니다.
삭제 버튼을 클릭하면 다시 한번 삭제 여부를 묻습니다. (삭제를 원할 시 확인)
                </dd>
            </dl>
            <dl>
                <dt>메뉴 그룹 권한 관리</dt>
                <dd>
회사 등록 및 수정, 해당 회사의 메뉴를 관리합니다. (SUPER-ADMIN이 관리하는 메뉴입니다.)
COMPANY 및 권한 관리 메인 화면
시스템 사용 여부 및 조건 선택으로 회사 리스트를 검색 할 수 있습니다.
회사 리스트에는 회사 ID, 회사 명, 회사 명(영문), 연락처, 시스템 사용여부, 등록일을 볼 수 있습니다
회사 정보 등록
메인 화면에 등록 클릭 시 회사 정보를 등록 할 수 있는 팝업창이 나옵니다.
회사 등록은 SUPER-ADMIN이 등록 할 수 있습니다.
각 필드에 내용을 입력합니다.
회사 명 : 등록하려는 회사 명. (필수 입력)
회사 명(영문) : 등록하려는 영문 회사명.
대표자 명 : 회사의 대표자 이름.
사업자등록번호 : 회사의 사업등록번호.
법인등록번호 : 회사의 법인등록번호.
주소 : 회사의 주소 및 상세 주소
팩스번호 : 회사 팩스번호.
담당자연락처 : 회사 담당자 연락처.
시스템 사용여부 : 서비스 사용 여부.
회사명 중복체크 후 필수 입력 사항 및 정보를 입력 후 저장 버튼을 누르면 등록이 완료됩니다.
회사 정보 수정 및 삭제
회사리스트에서 회사명 클릭 시 해당 회사의 정보를 수정 및 삭제 할 수 있는 팝업창이 나옵니다.
수정 하고 싶은 내용을 입력 후 수정버튼을 클릭하면 수정이 됩니다.
삭제를 원하시는 회사는 해당 회사명 클릭 후 팝업이 나오면 삭제버튼을 클릭하면 삭제가 됩니다.
권한관리 부여 및 수정
권한관리 버튼을 클릭하면 메뉴를 부여 할 수 있는 메뉴리스트 팝업창이 나옵니다
회사가 신청한 메뉴를 체크 후 저장하면 해당 회사가 이용 할 수 있는 메뉴가 저장됩니다.
수정시 다시 버튼 클릭 후 회사에 부여된 메뉴를 수정하실수 있습니다.
                </dd>
            </dl>
            <h3>챗봇 빌더</h3>
            <dl>
                <dt>서비스 현황</dt>
                <dd>
챗봇 빌더 서비스의 TPS 처리 결과 및 세션 대화 수를 수치와 도표를 사용하여 나타냅니다.
서비스 현황 메인화면
우측 상단에서 bot의 종류, 시간별, 일자별을 설정하여 조회할 수 있습니다.
메인 상단에서 세션 수, 대화 수, 평균 TPS 그리고 답변 성공률의 수치를 파악할 수 있습니다.
그래프를 통하여 TPS 및 대화 처리 결과를 시각적으로 볼 수 있습니다.
서비스 현황 조회 기능
특정 bot의 특정 날짜의 시간별 서비스 현황을 파악할 수 있습니다.
특정 bot의 일정 기간사이의 서비스 현황을 파악할 수 있습니다.
bot의 종류를 선택하여 특정 bot의 서비스 현황을 파악할 수 있습니다.
                </dd>
            </dl>
            <dl>
                <dt>챗봇 관리</dt>
                <dd>
챗봇빌더에서 사용할 수 있는 bot들을 개별적으로 관리(추가,제거,수정)합니다.
챗봇관리 메인 화면
우측상단의 검색 기능으로 bot이름 검색이 가능합니다.
샘플 챗봇 추가(Tutorial Bot)와 챗봇 추가 기능이 있습니다.
챗봇들이 목록에 아이콘과 함께 보이며 생성 날짜가 게시되어 있습니다.
챗봇관리 챗봇 검색기능
찾고자 하는 챗봇의 이름에 포함된 단어를 입력하면 그에 해당하는 챗봇들이 검색됩니다.
해당하는 챗봇이 없을시에 '데이터 없음'으로 나타납니다.
샘플 챗봇 추가
우측 상단의 샘플 챗봇 추가를 클릭합니다.
아래와 같은 샘플 챗봇 추가 팝업이 나타납니다.
챗봇 추가 화면 (기본정보)
챗봇 이름을 설정할 수 있습니다.
이미지 파일을 업로드하여 챗봇의 사진을 변경할 수 있습니다.
챗봇에 대한 설명을 넣을 수 있습니다.
챗봇 추가 화면 (PREITF)
PREITF 패턴 매칭시 BQA를 SKIP하고 ITF로 진입합니다.
preitf_id, itf_order, pattern, Action으로 구분되어 있습니다.
우측 상단 ADD PATTERN을 통해 신규 등록이 가능합니다.
Action 에서 정규식을 수정 혹은 제거할 수 있습니다.
챗봇 추가 화면 (Q&amp;A)
메인 화면에서 선택 가능한 도메인(좌측) 선택된 도메인(우측)으로 나뉘어 집니다.
질문 추천 사용 유무를 ON/OFF 할 수 있습니다.
질문 추천 사용시 형태소 매칭 오차 범위를 설정 가능하며, 재확인 메세지를 수정할 수 있습니다.
                </dd>
            </dl>
            <dl>
                <dt>대화 모니터링</dt>
                <dd>
대화 이력 조회
대화 이력을 조회 가능한 page입니다.
좌측 상단의 기간을 설정하여 조회 가능합니다.
검색창에서는 Session id, Bot Name, User id, Domain, Count, Dialog Count, Unknown, Count를 설정하여 검색 가능 합니다.
목록에서는 Session ID, 챗봇, 대화 시작일시, 대화 종료일시, 도메인 수, 대화 수, 미답변 수, 사용자 ID를 확인할 수 있습니다.
우측 상단에서 목록을 '엑셀 다운로드' 버튼을 이용하여 다운 가능합니다.
Session ID 클릭시 각 Session에 대한 상세정보를 볼 수 있습니다.
대화 모니터링 &gt; 답변불가 대화현황 조회
답변이 불가한 대화의 목록을 조회할 수 있습니다.
좌측 상단의 기간을 설정하여 조회 가능합니다.
검색창에서는 No, Botname, Sentence, User ID 를 설정하여 검색 가능 합니다.
목록에서는 순번, 챗봇이름, 답변이 불가한 질문, 사용자ID, 대화시간을 확인할 수 있습니다.
우측 상단에서 목록을 '엑셀 다운로드' 버튼을 이용하여 다운 가능합니다.
                </dd>
            </dl>
 			<h3>FAQ</h3>
            <dl>
                <dt>FAST AICC(v1.0) 이란?</dt>
                <dd>
FAST AICC는 FAST AI 시스템 페이지를 통하여 한 번에 CS 통합 관리를 할 수 있습니다.
내게 꼭 필요했던 CS 업무를 대행하고, 실제 매칭된 상담의 비용을 지불하는 합리적 운영 체계를 가지고 있습니다.
상담 유형과 상담사를 매칭하고, 파트너사의 특성에 맞는 시나리오 커스터마이징이 가능하여 24/7 콜센터를 운영할 수 있습니다.
반복적이고 단순했던 CS 업무는 FAST AI에 맡기고, 생산적인 업무에 집중할 수 있는 업무 환경을 조성할 수 있습니다.
                </dd>
            </dl>
            <dl>
                <dt>어떻게 설치 하나요?</dt>
                <dd>
설치에 필요한 라이브러리
apache tomcat
mysql
mv fast1.0.war ~/tomcat/webapps/ROOT.war
USB에서 FAST WEB에 필요한 WAR 파일을 내려받은 후, tomcat이 설치된 디렉토리로 이동하여 webapps 하위 경로에 ROOT.war 라는 이름으로 파일을 옮깁니다.
cd ~/tomcat/bin
./startup.sh
톰캣 서버를 구동하면 ROOT.war 파일이 풀리며 ROOT 폴더가 생성됩니다.
cd ~/tomcat/webapps/ROOT/WEB-INF/classes
ROOT/WEB-INF/classes 경로의 application 설정파일에 db와 call manager 정보를 적어줍니다.
웹 페이지를 띄어 확인 합니다.
                </dd>
            </dl>
            <dl>
                <dt>최소 사양 및 권장 사항은 어떻게 되나요?</dt>
                <dd>
권장 시스템 사양 및 필요 장비
Windows 10, Chrome 이 설치 된 노트북 및 데스크탑
제품 구동을 위해 마이크,스피커 필요
                </dd>
            </dl>
            <dl>
                <dt>직접 방문 및 문의를 하려면 어떻게 하나요?</dt>
                <dd>
주식회사 마인즈랩 경기도 성남시 분당구 대왕판교로644번길 49 다산타워 5층ㅣ 대표 유태준 ㅣ대표번호 1661-3222
고객 지원센터 : <a class="link" href="https://maum.ai" target="_blank">https://maum.ai</a> 챗봇 문의 및 담당자 전화연결
*오류 발생 시 고객 지원센터로 연락바랍니다.
                </dd>
            </dl>
            <h3>보안</h3>
            <dl>
                <dt>데이터 암,복호화 정책</dt>
                <dd>
데이터 암호화, 복호화시 암호 알고리즘 BCRYPT를 사용하고 있습니다.
BCRYPT는 1999년 발표했고 현재까지 사용되는 가장 강력한 해시 메커니즘 중 하나입니다.
보안에 집착하기로 유명한 OpenBSD에서 기본 암호 인증 메커니즘으로 사용되고 있고, 미래에 PBKDF2보다 더 경쟁력이 있다고 여겨집니다.
                </dd>
            </dl>
        </div>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button class="btn_lyr_close">닫기</button>
        </div>
    </div>
</div>
<!-- //도움말 --> 


	<!-- //통화UI-->
	<!-- 공통 script -->
	<!-- datetimepicker -->
<!-- 추가 2019.12.11 END-->
<script type="text/javascript">

// header profile 비밀번호 변경
$("#btnEditPw").on("click", function(e){
	$("#originPwTest").css("display", "none");
	$("#pwTest1").css("display", "none");
	$("#pwTest12").css("display", "none");
	$("#pwTest13").css("display", "none");
	$("#pwTest14").css("display", "none");
	$("#pwTest2").css("display", "none");
	
	if($("#originPw").val() == "" || $("#originPw").val() == null){
		$("#originPwTest").css("display", "block");
		return;
	}
	
	if(!ckEditPw($("#testPw1").val())){
		$("#pwTest1").css("display", "block");
		return;
	}

	if(ckEditPw2($("#testPw1").val())){
		$("#pwTest12").css("display", "block");
		return;
	}

	if(ckEditPw3($("#testPw1").val())){
		$("#pwTest13").css("display", "block");
		return;
	}

	if(ckEditPw4($("#testPw1").val())){
		$("#pwTest14").css("display", "block");
		return;
	}
	
	if($("#testPw1").val() != $("#testPw2").val()){
		$("#pwTest2").css("display", "block");
		return;
	}

	var json = new Object();
	var jsonObj= new Object();
	
	json.originPw = $("#originPw").val();
	json.pw1 = $("#testPw1").val();
	json.pw2 = $("#testPw2").val();
	json.enabledYn = "Y";
	
	jsonObj.chUserPw=json;
	jsonObj.chUserPwYn = "Y";

	httpSend("${pageContext.request.contextPath}/getEditPw", $("#headerName").val(), $("#token").val(),	JSON.stringify(jsonObj), "retEditPw");
});

function retEditPw(ret){
	if(ret.editPwYn){
		alert('<spring:message code="A0270" text="비밀번호가 변경되었습니다." />');
		$('.lyrWrap').hide(); 
        $('.lyrBox').hide();
        logout();
	}else{
		alert('<spring:message code="A0271" text="기존 비밀번호가 틀립니다." />');
	}
}

var gLocale = "ko";
$(window).load(function() {
	
	// 	iframe일때 메뉴 및 크기 제어
	var isInIFrame = (window.location != window.parent.location);
	if(isInIFrame==true){
		$("#gnb").hide();
		$("#container").css("padding","60px 0 0 0px");
		$(".potalWrap").css("left","0px");
		$(".potalWrap").css("width","100%");
		$("#header").css("padding","0px");
		$("#header").css("width","100%");
	}
	
	$('.page_loading').addClass('pageldg_hide').delay(300).queue(function() { 
		$(this).remove(); 
	});
	
	gLocale = cookieToLocale();
	
	console.log("locale:"+gLocale);
	
}); 

$(document).ready(function() {
	noteToggle01();
	noteToggle02();
	var lang = $.cookie("lang");
	
	//////**인아웃바운드용**/////
	
	//입력날짜 datepicker로 수정요청
	if(lang == "ko" || lang == null){
		//datetimepicker
		$('#USEREDT_CUST_REG_DATE').datetimepicker({
			format : "yyyy-mm-dd",
			language : "ko",
			autoclose : true,
			minView : 2
		}).on('changeDate', function(selectedDate){
        	$("#USEREDT_CUST_TERM_DATE").datetimepicker('setStartDate',selectedDate.date);
        });
		
		$('#USEREDT_CUST_TERM_DATE').datetimepicker({
			format : "yyyy-mm-dd",
			language : "ko",
			autoclose : true,
			minView : 2
		}).on('changeDate', function(selectedDate){
        	$("#USEREDT_CUST_REG_DATE").datetimepicker('setEndDate',selectedDate.date);
        });
		
		$('#PAYEDT_RECENT_PAYMENT_DATE').datetimepicker({
			format : "yyyy-mm-dd",
			language : "ko",
			autoclose : true,
			minView : 2
		});
		
		$('#PAYEDT_NEXT_PAYMENT_DATE').datetimepicker({
			format : "yyyy-mm-dd",
			language : "ko",
			autoclose : true,
			minView : 2
		});
		
		//예약일
		$('.reserveDate').datetimepicker({
			language : 'ko', // 화면에 출력될 언어를 한국어로 설정합니다.
			pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
			defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
			autoclose : 1,
			startDate : new Date(), //오늘 날짜 이전은  disabled 처리.
		});
	
	}else if(lang == "en"){
		//datetimepicker
		$('#USEREDT_CUST_REG_DATE').datetimepicker({
			format : "yyyy-mm-dd",
			language : "en",
			autoclose : true,
			minView : 2
		}).on('changeDate', function(selectedDate){
        	$("#USEREDT_CUST_TERM_DATE").datetimepicker('setStartDate',selectedDate.date);
        });
		
		$('#USEREDT_CUST_TERM_DATE').datetimepicker({
			format : "yyyy-mm-dd",
			language : "en",
			autoclose : true,
			minView : 2
		}).on('changeDate', function(selectedDate){
        	$("#USEREDT_CUST_REG_DATE").datetimepicker('setEndDate',selectedDate.date);
        });
		
		$('#PAYEDT_RECENT_PAYMENT_DATE').datetimepicker({
			format : "yyyy-mm-dd",
			language : "en",
			autoclose : true,
			minView : 2
		});
		
		$('#PAYEDT_NEXT_PAYMENT_DATE').datetimepicker({
			format : "yyyy-mm-dd",
			language : "en",
			autoclose : true,
			minView : 2
		});
		
		//예약일
		$('.reserveDate').datetimepicker({
			language : 'en', // 화면에 출력될 언어를 한국어로 설정합니다.
			pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략합니다.
			defalutDate : new Date(), // 기본값으로 오늘 날짜를 입력합니다. 기본값을 해제하려면 defaultDate 옵션을 생략합니다.
			autoclose : 1,
			startDate : new Date(), //오늘 날짜 이전은  disabled 처리.
		});
	}
	
	//고객정보 변경
	//전화걸기
	/* $('.btn_ico.call').on('click', function() {
		$('.callingBotton').animate({
			top : '0',
		}, 300);
	}); */
	
	var placeholderLabel = $("#sendmailForm > div > div > input, #sendmailForm > div > div > textarea");
	
    placeholderLabel.on('focus', function(){
        $(this).siblings('label').hide();
    });
    placeholderLabel.on('focusout', function(){
        if($(this).val() === ''){
            $(this).siblings('label').show();
        }
    });
});

// publishing 단계에서 생성된 javascript
function noteToggle01() {
	$(".toggle_type01 .btn_toggle01").click(function() {
		if($(this).parents('.toggle_type01').hasClass("on")) {
			$(this).parents('.toggle_type01').removeClass("on");
		} else {
			$(this).parents('.toggle_type01').addClass("on");
		}
		return false;
	});
}
//publishing 단계에서 생성된 javascript
function noteToggle02() {
	$(".toggle_type02 .btn_toggle02").click(function() {
		if($(this).parents('.toggle_type02').hasClass("on")) {
			$(this).parents('.toggle_type02').removeClass("on");
			$(this).text("더보기");
		} else {
			$(this).parents('.toggle_type02').addClass("on");
			$(this).text("접기");
		}
		return false;
	});
}
//검색 부분 대상일자 datapicker를 위한 함수. 
var nowTemp = new Date();
var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
var checkEnd = now;
var checkStart = $('#schTopTargetDt').datepicker({
	  onRender: function(date) {
		return date.valueOf() > now.valueOf() ? 'disabled' : '';
	  }
	}).on('changeDate', function(ev) {
	  if (ev.date.valueOf() > checkEnd) {
		var newDate = new Date(ev.date)
		newDate.setDate(newDate.getDate() + 1);
		checkEnd = newDate;
	  }
	  checkStart.hide();
	}).data('datepicker');
	


//좌측 메뉴 클릭시 menuUrl로 이동
function goMenu(linkTy,cntntsTy,menuUrl,menuCode){
	if(menuUrl=='')
		return;
	// 페이지 변경
	if(linkTy=="01"){
		baseUrl = "${pageContext.request.contextPath}";
		if (baseUrl) {
			location.href = baseUrl + menuUrl;
		} else {
			location.href = menuUrl;
		}
	}
	// 링크
	else if(linkTy=="02")
	{
		location.href=menuUrl;
	}
	// 임베디드
	else if(linkTy=="03")
	{
		location.href="${pageContext.request.contextPath}/embedded/page/"+menuCode;
	}
}


//프로필 로그아웃 클릭시 로그아웃
function logout(){
	deleteCookie('MAUM_AID');
	deleteCookie('MAUM_RID');
	location.href="${pageContext.request.contextPath}/logout";
	sessionStorage.clear();
}

function deleteCookie(name) {
	document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT; domain=maum.ai; path=/;';
}

//locale return
function cookieToLocale(defaultValue) {

	var str = document.cookie;
	var locale = defaultValue||"ko";
	var result = {};
	
	if(str.match("lang") != null && str.match("lang") != ""){
		
		str = str.split(";");
		str.forEach(function(val){
			val = val.split("=");
			result[val[0].trim()] = decodeURIComponent(val[1] || '');
		});
		locale = result.lang;
	}
	
	return locale;  
}

//비동기호출 > callback
function httpSend(url,headerName,token, data, callback) {
	
		$.ajax({
			url : url,
			data : data,
			method : 'POST',
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(headerName,token);
			},
		})
		.success(function(result) {
			
			// console.log(result);
			result = JSON.stringify(result);
			if(callback != null && callback != ""){
				
				if(typeof callback == "function"){
					callback(result);
				}else{
					eval(callback+"("+result+")");	
				}
				
			}
		}).fail(function(result) {
		});
}

//return msg
function getLocaleMsg(code, defaultMsg){
	gMsgList  = {
		A0001:"<spring:message code='A0110' text='대기중' />",
		A0002:"<spring:message code='A0091' text='통화중' />",
		A0003:"<spring:message code='A0037' text='확인' />",
		A0004:"<spring:message code='A0532' text='취소' />",
		A0005:"<spring:message code='A0257' text='등록된 데이터가 없습니다.' />",
		A0006:"<spring:message code='A0255' text='청취를 종료하시겠습니까?' />",
		A0007:"<spring:message code='A0256' text='상담을 종료하시겠습니까?' />",
		A0008:"<spring:message code='A0638' text='통화종료' />",
		A0009:"<spring:message code='A0407' text='상담 모니터링' />",
		A0010:"<spring:message code='A0721' text='고객상담요청.' />",
		A0011:"<spring:message code='A0710' text='소켓 연결에 실패하였습니다.' />",
		A0012:"<spring:message code='A0589' text='등록이 완료되었습니다.' />"
	}
	
	var retMsg = gMsgList[code];
	if(retMsg == null || retMsg == ""){
		retMsg = defaultMsg;
	}
	
	console.log("retMsg:"+retMsg);
	return retMsg;
}

function chLocale(lc){
	var thisUrl_1 = window.location.href;
	var thisUrl_2 = window.location.origin;
	var thisUrl_3 = window.location.pathname;

	/**
 	IFRAME 통신으로 부모에게 언어 전달
	**/
	window.parent.postMessage({type:"lang",lang:lc}, '*' );
		
	if(thisUrl_1.match("lang") !== null ){
		location.href = thisUrl_2+ thisUrl_3 + "?lang="+ lc;
	}else{
		location.href = thisUrl_1 + "?lang="+ lc;
	}
}


function Time(t) {
	t = new (function() {
	    // Stopwatch element on the page
	    var $stopwatch;
	    // Timer speed in milliseconds
	    var incrementTime = 70;
	    // Current timer position in milliseconds
	    var currentTime = 0;
	    // Start the timer
	    $(function() {
	        $stopwatch = $("#"+t).find("div .cont_cell");
	        console.log( $("#"+t).find("div .cont_cell").html());
	        t= $.timer(updateTimer, incrementTime, true);  
	    });
	    // Output time and increment
	    function updateTimer() {
	        var timeString = formatTime(currentTime);
	        //console.log( $stopwatch.html());
	        //console.log(timeString)
	        $stopwatch.html(timeString);
	        currentTime += incrementTime;
	    }
	    // Reset timer
	    this.resetStopwatch = function() {
	        currentTime = 0;
	        t.Timer.stop().once();
	    };
	});
}

function formatTime(time) {
    time = time / 10;
    var min = parseInt(time / 6000),
        sec = parseInt(time / 100) - (min * 60),
        hundredths = pad(time - (sec * 100) - (min * 6000), 2);
    return (min > 0 ? pad(min, 2) : "00") + ":" + pad(sec, 2) + ":" + hundredths;
}
// Common functions
function pad(number, length) {
    var str = '' + number;
    while (str.length < length) {str = '0' + str;}
    return str;
}
//return yyyy-mm-dd hh:mm
function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year+'-'+month+'-'+day;
}

function sendMail(){

	var ckInput = $("#sendmailForm > div > div > input, #sendmailForm > div > div > textarea");
	var confirmYn = true;

	$.each(ckInput, function(i, v){
		if(v.value == null || v.value == ""){
			alert("내용을 모두 입력해야 이메일을 전달 할 수 있어요!");
			confirmYn = false;
			return false;
		}
	});

	var user_name = $("#send_user_name").val();
	var user_phone = $("#send_user_phone").val();
	var user_text = $("#send_user_text").val();
	var user_email = $("#send_user_email").val();

	var title = '[FAST AI 서비스] 문의하기가 접수되었습니다.';
	var msg = "이름 : " + user_name + "\n연락처 : " + user_phone + "\n문의 내용 : " + user_text;

	var data = '{"fromaddr":"'+user_email+'", "toaddr":"hello@maum.ai", "subject":"'+title+'", "message":"'+msg+'"}';


	if(confirmYn){
		httpSend('/service/sendReqMail', $("#headerName").val(), $("#token").val(), data
				,function(res){
					res = JSON.parse(res);
					if(res == "SUCC"){
						alert("이메일을 보냈습니다. 담당자 확인 후 연락 드리겠습니다 :)");
					}else{
						alert("Contact Us 메일발송 요청 실패하였습니다.");
					}
					console.log(res);
				});

		$.each(ckInput, function(i, v){
			if(v.value != null && v.value != ""){
				v.value = "";
				$(this).siblings('label').show();
			}
		});

		$("#close_sendmail_form").trigger("click");
	}

}



/* function editProfile(){
	$('.lyrWrap').show();    
	$('.lyr_profile').show();    
}

function editUserPw(){
	console.log("in");
	
	console.log(this);
	
	$('.lyrWrap').hide(); 
    $('.lyrBox').hide();
	
} */

function checkModifPw(){
	var jsonObj = new Object()
	httpSend("${pageContext.request.contextPath}/getModifPW", $("#headerName").val(), $("#token").val(), JSON.stringify(jsonObj), "checkModifCallback");
}
function checkModifCallback(cbData){

	if(cbData.nowChange === true){
		$("#modif_warn").css("display","block");
		$("#btnEditPw").text("지금 변경하기");
		$("#btnEditPw").after("<button class=\"btn_lyr\" id=\"btnEditPw2\">다음에 변경하기</button>")
		$("#btnEditPw2").on('click',function(){
			$(this).parents(".lyrBox").find(".btn_lyr_close").click();
		})
		if(window.location.href.includes("?first")){
			$("#header > div.etc > ul:nth-child(1) > li.ico_profile > div > div.btnBox > a").click();
		}
	}
	$("#last_modified").text(cbData.recentPWDate);
	var nowCheckModif = $("#modif_warn").html().replace("[pwmonth]",cbData.pwInterval);
	$("#modif_warn").html(nowCheckModif);

}
checkModifPw()

</script>




