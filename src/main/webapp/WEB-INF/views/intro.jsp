<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2021-10-08
  Time: 오전 11:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="format-detection" content="telephone=no">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
  <!-- Cache reset -->
  <meta http-equiv="Expires" content="Mon, 06 Jan 2016 00:00:01 GMT">
  <meta http-equiv="Expires" content="-1">
  <meta http-equiv="Pragma" content="no-cache">
  <meta http-equiv="Cache-Control" content="no-cache">

  <!-- Open Graph Tag -->
  <meta property="og:title"            content="maum.ai"/>
  <meta property="og:type"             content="website"/><!-- 웹 페이지 타입 -->
  <meta property="og:url"              content="https://maum.ai"/>
  <meta property="og:image"            content="${pageContext.request.contextPath}/aiaas/common/images/maum.ai_web.png"/>
  <meta property="og:description"      content="웹인공지능이 필요할땐 마음AI"/>

  <!-- icon_favicon -->
  <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/ico_favicon_60x60.png"><!-- 윈도우즈 사이트 아이콘, HiDPI/Retina 에서 Safari 나중에 읽기 사이드바 -->
  <!-- css -->
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/font.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/reset.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/all.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/swiper.min.css" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/fast_intro.css">

  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/swiper.min.js"></script>

  <!--[if lte IE 9]>
	<script src="${pageContext.request.contextPath}/js/html5shiv.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/respond.min.js"></script>

	<div class="lyrWrap">
		<div class="lyr_bg ie9"></div>
		<div class="lyrBox">
			<div class="lyr_top">
				<h3>브라우저 업데이트 안내</h3>
			</div>
			<div class="lyr_mid">
				<div class="legacy-browser">
					현재 사용중인 브라우저는 지원이 중단된 브라우저입니다.<br>
					원활한 온라인 서비스를 위해 브라우저를 <a href="http://windows.microsoft.com/ko-kr/internet-explorer/ie-11-worldwide-languages" target="_blank">최신 버전</a>으로 업그레이드 해주세요.
				</div>
			</div>
			<div class="lyr_btm">
				<div class="btnBox sz_small">
					<button class="btn_win_close">창 닫기</button>
				</div>
			</div>
		</div>
	</div>
	<![endif]-->

  <!-- Global site tag (gtag.js) - Google Analytics -->
<%--  <script async src="https://www.googletagmanager.com/gtag/js?id=UA-122649087-8"></script>--%>
<%--  <script>--%>
<%--    window.dataLayer = window.dataLayer || [];--%>
<%--    function gtag(){dataLayer.push(arguments);}--%>
<%--    gtag('js', new Date());--%>
<%--    gtag('config', 'UA-122649087-8');--%>
<%--  </script>--%>

  <title><spring:message code="A0616" text="소개 FAST 대화형 AI 서비스" /></title>
</head>
<body>
<%--intro_wrap--%>
<div id="intro_wrap">
  <%--  intro_header scroll--%>
  <div id="intro_header" class="">
    <div class="intro_inner_wrap">
      <div>
        <h1 class="logo">
          <img src="${pageContext.request.contextPath}/resources/images/intro/logo_AICC_wh.svg" alt="aicc 로고">
        </h1>
        <a class="pc inline-block intro_to_login" href="/login" target="_blank">FAST AI</a>
<%--        요금안내 url 사용안함--%>
<%--        <a id="pricing_page intro_to_pricing" class="pc inline-block" href="https://maum.ai/home/pricingPage?lang=ko" target="_blank"><spring:message code="A0712" text="가격정책"/></a>--%>

        <div class="fr pc">
          <div class="intro_lang">
            <a href="?lang=ko" class="ko">KOR</a>
            <a href="?lang=en" class="en">ENG</a>
          </div>
        </div>
      </div>

      <div class="mobile">
        <button type="button" class="btn_mobile_ham active open_menu_mobile">
          <img src="${pageContext.request.contextPath}/resources/images/intro/ico_menu_ham.svg" alt="모바일 메뉴 열기">
        </button>

        <div id="mobile_menu">
          <button type="button" class="close_menu_mobile">
            <img src="${pageContext.request.contextPath}/resources/images/intro/ico_menu_close.svg" alt="모바일 메뉴 닫기">
          </button>
          <div class="background"></div>
          <div class="menu">
            <div class="logo">
              <img src="${pageContext.request.contextPath}/resources/images/intro/logo_AICC_bk.svg" alt="aicc 로고">
            </div>
            <ul>
              <li><a href="/login" class="intro_to_login" target="_blank">FAST AI</a></li>
              <li><a href="https://maum.ai/home/pricingPage?lang=ko" class="intro_to_pricing" target="_blank"><spring:message code="A0712" text="가격정책"/></a></li>
            </ul>
            <p class="info_text">※ <spring:message code="A1051" text="FAST AI 서비스는 PC에 최적화되어있습니다."/></p>

            <div class="intro_lang">
              <a href="?lang=ko" class="ko">
                <div class="img_box">
                  <img src="${pageContext.request.contextPath}/resources/images/ico_lang_ko.png" alt="한국어로 보기">
                </div>
                <span>KOR</span>
              </a>
              <a href="?lang=en" class="en">
                <div class="img_box">
                  <img src="${pageContext.request.contextPath}/resources/images/ico_lang_en.png" alt="영어로 보기">
                </div>
                <span>ENG</span>
              </a>
            </div>
          </div>
        </div>
        <%--          <a href="" target="_blank">로그인</a>--%>
      </div>
    </div>
  </div>
  <%--    //intro_header--%>

  <%--    intro_container--%>
  <div id="intro_container">
    <%--      intro_visual--%>
    <div id="intro_visual">
      <div class="intro_inner_wrap">
        <h2>AI Contact Center</h2>
        <p>
          <spring:message code="A1000" text="인공지능 컨텍센터는 뛰어난 음성인식과 챗봇 기술을 기반으로 CS에 최적화된 서비스를 제공합니다." />
        </p>
        <div class="scroll_down">
          <img src="${pageContext.request.contextPath}/resources/images/intro/text_scrolldown.svg" alt="스크롤 다운 영어 글자">
        </div>
      </div>
    </div>
    <%--      //intro_visual--%>
    <%--      content Business--%>
    <div class="content business">
      <div class="intro_inner_wrap">
        <div class="title">
          <span class="title_number">01</span>
          <h3>Business</h3>
        </div>
        <div class="title_desc business_desc">
          <h4><spring:message code="A1001" text="마인즈랩의 인공지능 컨텍센터" />(AICC)</h4>
          <p>
            <spring:message code="A1002" text="음성봇과 챗봇, 텔레마케팅 기능을 제공하여 고객VOC분석, 상담지원,고객직접 상담을 진행하는 AI서비스 입니다." />
          </p>
        </div>
      </div>
    </div>
    <%--      //content Business--%>
    <%--      content Success stories--%>
    <div class="content success">
      <div class="intro_inner_wrap">
        <div class="sub_title">
          <h3>Success stories</h3>
          <p>
            <spring:message code="A1003" text="많은 기업이 AICC와 함께 더 편리해진 서비스를 경험하고 있습니다." />
          </p>
        </div>

        <div class="swiper_success swiper pc">
          <div class="command_box">
            <button type="button" class="success-button-prev">
              <img src="${pageContext.request.contextPath}/resources/images/intro/ico_arrow_left.svg" alt="이전 화살표">
              <span>prev</span>
            </button>
            <button type="button" class="success-button-next">
              <img src="${pageContext.request.contextPath}/resources/images/intro/ico_arrow_right.svg" alt="다음 화살표">
              <span>next</span>
            </button>
          </div>

          <ul class="swiper-wrapper">
            <li class="swiper-slide">
              <div>
                <div class="img_box">
                  <img src="${pageContext.request.contextPath}/resources/images/intro/img_hyundaai.jpg" alt="현대해상 음성봇">
                </div>
                <div class="tit_desc">
                  <span class="tit"><spring:message code="A1004" text="현대해상 음성봇" /></span>
                  <p class="desc"><spring:message code="A1005" text="실시간 STT, TTS기술과 챗봇 기술이 접목된 AI 상담원 서비스 구축" /></p>
                </div>
              </div>
            </li>

            <li class="swiper-slide">
              <div>
                <div class="img_box">
                  <img src="${pageContext.request.contextPath}/resources/images/intro/img_hanabank.jpg" alt="하나은행(HAI) 뱅킹">
                </div>
                <div class="tit_desc">
                  <span class="tit"><spring:message code="A1006" text="하나은행(HAI) 뱅킹"/></span>
                  <p class="desc"><spring:message code="A1007" text="해외송금부터 공과금 납부까지 차원이 다른 AI 뱅킹 서비스 구축"/></p>
                </div>
              </div>
            </li>

            <li class="swiper-slide">
              <div>
                <div class="img_box">
                  <img src="${pageContext.request.contextPath}/resources/images/intro/img_fubon.jpg" alt="푸본현대생명 TM QA">
                </div>
                <div class="tit_desc">
                  <span class="tit"><spring:message code="A1008" text="푸본현대생명 TM QA"/></span>
                  <p class="desc"><spring:message code="A1009" text="실시간 STT, 패턴분류 엔진을 통한 TM 계약 불완전 판매 모니터링 시스템 구축"/></p>
                </div>
              </div>
            </li>

            <li class="swiper-slide">
              <div>
                <div class="img_box">
                  <img src="${pageContext.request.contextPath}/resources/images/intro/img_samsungelectronics.jpg" alt="북미 삼성전자 VOC">
                </div>
                <div class="tit_desc">
                  <span class="tit"><spring:message code="A1010" text="북미 삼성전자 VOC"/></span>
                  <p class="desc"><spring:message code="A1011" text="고객과의 콜 내용을 바탕으로 강성클레임 및 대외 리스크 콜 분석 시스템 구축"/></p>
                </div>
              </div>
            </li>
          </ul>
        </div>

        <div class="swiper_success swiper mobile">
          <div class="command_box">
            <button type="button" class="success-button-prev">
              <img src="${pageContext.request.contextPath}/resources/images/intro/ico_arrow_left.svg" alt="이전 화살표">
              <span>prev</span>
            </button>
            <button type="button" class="success-button-next">
              <img src="${pageContext.request.contextPath}/resources/images/intro/ico_arrow_right.svg" alt="다음 화살표">
              <span>next</span>
            </button>
          </div>

          <ul class="swiper-wrapper">
            <li class="swiper-slide">
              <div>
                <div class="img_box">
                  <img src="${pageContext.request.contextPath}/resources/images/intro/img_hyundaai.jpg" alt="현대해상 음성봇">
                </div>
                <div class="tit_desc">
                  <span class="tit"><spring:message code="A1004" text="현대해상 음성봇" /></span>
                  <p class="desc"><spring:message code="A1005" text="실시간 STT, TTS기술과 챗봇 기술이 접목된 AI 상담원 서비스 구축" /></p>
                </div>
              </div>
            </li>

            <li class="swiper-slide">
              <div>
                <div class="img_box">
                  <img src="${pageContext.request.contextPath}/resources/images/intro/img_hanabank.jpg" alt="하나은행(HAI) 뱅킹">
                </div>
                <div class="tit_desc">
                  <span class="tit"><spring:message code="A1006" text="하나은행(HAI) 뱅킹"/></span>
                  <p class="desc"><spring:message code="A1007" text="해외송금부터 공과금 납부까지 차원이 다른 AI 뱅킹 서비스 구축"/></p>
                </div>
              </div>
            </li>

            <li class="swiper-slide">
              <div>
                <div class="img_box">
                  <img src="${pageContext.request.contextPath}/resources/images/intro/img_fubon.jpg" alt="푸본현대생명 TM QA">
                </div>
                <div class="tit_desc">
                  <span class="tit"><spring:message code="A1008" text="푸본현대생명 TM QA"/></span>
                  <p class="desc"><spring:message code="A1009" text="실시간 STT, 패턴분류 엔진을 통한 TM 계약 불완전 판매 모니터링 시스템 구축"/></p>
                </div>
              </div>
            </li>

            <li class="swiper-slide">
              <div>
                <div class="img_box">
                  <img src="${pageContext.request.contextPath}/resources/images/intro/img_samsungelectronics.jpg" alt="북미 삼성전자 VOC">
                </div>
                <div class="tit_desc">
                  <span class="tit"><spring:message code="A1010" text="북미 삼성전자 VOC"/></span>
                  <p class="desc"><spring:message code="A1011" text="고객과의 콜 내용을 바탕으로 강성클레임 및 대외 리스크 콜 분석 시스템 구축"/></p>
                </div>
              </div>
            </li>
          </ul>

        </div>

      </div>
    </div>
    <%--      //content Success stories--%>
    <%--      content Service--%>
    <div class="content service">
      <div class="intro_inner_wrap">
        <div class="title">
          <span class="title_number">02</span>
          <h3>Service</h3>
        </div>
        <div class="title_desc">
          <h4><spring:message code="A1012" text="AICC 핵심 서비스 3가지"/></h4>
          <p>
            <spring:message code="A1013" text="고객에게 만족스러운 이용 경험을 제공하는 AICC의 대표적인 서비스를 소개합니다."/>
          </p>
        </div>

        <ul>
          <li>
            <div class="img_box fr">
              <div class="img">
                <img class="pc" src="${pageContext.request.contextPath}/resources/images/intro/img_chatbot.jpg" alt="background">
                <img class="mobile" src="${pageContext.request.contextPath}/resources/images/intro/img_chatbot_m.jpg" alt="background">
              </div>
            </div>

            <div class="desc_box fl">
              <span>FAST AI</span>
              <p>
                <spring:message code="A1014" text="근무 장소에 제한 받지 않고 AI 상담봇의 효율적인 상담이 가능한 Financially competitive, Agile, Scalable, and Trendy AI 서비스"/>
              </p>
              <div>
                <a href="/login" target="_blank">
                  <spring:message code="A1015" text="FAST AI 바로가기"/>
                  <img class="pc" src="${pageContext.request.contextPath}/resources/images/intro/ico_arrow_right.svg" alt="오른쪽 화살표">
                  <img class="mobile" src="${pageContext.request.contextPath}/resources/images/intro/ico_arrow_right_m.svg" alt="오른쪽 화살표">
                </a>
              </div>
            </div>
          </li>

          <li>
            <div class="img_box fl">
              <div id="img_voc" class="img">
                <img class="pc" src="${pageContext.request.contextPath}/resources/images/intro/img_voc.jpg" alt="background">
                <img class="mobile" src="${pageContext.request.contextPath}/resources/images/intro/img_voc_m.jpg" alt="background">
              </div>
            </div>

            <div class="desc_box fl">
              <span>VOC</span>
              <p>
                <spring:message code="A1016" text="기업이 고객과의 상호작용을 통해 다양한 VOC 데이터를 분석하고 Customer Value 향상을 위해 다양한 insight를 제공하는 솔루션"/>
              </p>
              <div>
                <a href="#lyr_join" class="btn_lyr_open">
                  <spring:message code="A1017" text="문의하기 바로가기"/>
                  <img class="pc" src="${pageContext.request.contextPath}/resources/images/intro/ico_arrow_right.svg" alt="오른쪽 화살표">
                  <img class="mobile" src="${pageContext.request.contextPath}/resources/images/intro/ico_arrow_right_m.svg" alt="오른쪽 화살표">
                </a>
              </div>
            </div>
          </li>

          <li>
            <div class="img_box fr">
              <div class="img">
                <img class="pc" src="${pageContext.request.contextPath}/resources/images/intro/img_TMQA.jpg" alt="background">
                <img class="mobile" src="${pageContext.request.contextPath}/resources/images/intro/img_TMQA_m.jpg" alt="background">
              </div>
            </div>

            <div class="desc_box fl">
              <span>TMQA</span>
              <p>
                <spring:message code="A1018" text="TM 채널 QA 업무 효율화, 고객 콜센터 상담 분석, CM채널 상담콜 분석 서비스를 제공하는 통합 솔루션"/>
              </p>
              <div>
                <a href="#lyr_join" class="btn_lyr_open">
                  <spring:message code="A1017" text="문의하기 바로가기"/>
                  <img class="pc" src="${pageContext.request.contextPath}/resources/images/intro/ico_arrow_right.svg" alt="오른쪽 화살표">
                  <img class="mobile" src="${pageContext.request.contextPath}/resources/images/intro/ico_arrow_right_m.svg" alt="오른쪽 화살표">
                </a>
              </div>
            </div>
          </li>
        </ul>
      </div>
    </div>
    <%--      //content Service--%>
    <%--      content Technology--%>
    <div class="content technology">
      <div class="intro_inner_wrap">
        <div class="title">
          <span class="title_number">03</span>
          <h3>Tech-<br>nology</h3>
        </div>
        <div class="title_desc">
          <h4><spring:message code="A1019" text="다양한 기술이 결합된 AICC"/></h4>
          <p>
            <spring:message code="A1020" text="음성인식, 챗봇 등의  AI 기술을 활용하여 다양한 산업 분야에 적용할 수 있습니다."/>
          </p>
        </div>
      </div>
      <div class="newline_div"></div>
      <div class="intro_inner_wrap technology_list inline-flex pc">
        <div class="list voicebot">
          <span><spring:message code="A1021" text="음성봇"/></span>
          <p><spring:message code="A1022" text="기존의 상담사의 완전판매 모니터링, 대출 신청 등의 업무 대체"/></p>
          <ul>
            <li>- <spring:message code="A1023" text="고객의 음성을 문자로 변환"/></li>
            <li>- <spring:message code="A1024" text="대화 내용을 음성으로 출력"/></li>
            <li>- <spring:message code="A1025" text="챗봇 기술을 통한 대화 내용 관리"/></li>
          </ul>
        </div>
        <div class="list chatbot">
          <span><spring:message code="A1026" text="챗봇"/></span>
          <p><spring:message code="A1027" text="대화 시나리오를 업로드하여 관리하는 제작 툴 제공"/></p>
          <ul>
            <li>- <spring:message code="A1028" text="엑셀 업로드를 통한 챗봇 제작 가능"/></li>
            <li>- <spring:message code="A1029" text="전화, 채팅 시뮬레이션 가능"/></li>
            <li>- <spring:message code="A1030" text="키패드나 음성의 입력채널 선택 가능"/></li>
          </ul>
        </div>
        <div class="list conversation">
          <span><spring:message code="A1031" text="대화관리"/></span>
          <p><spring:message code="A1032" text="자연스러운 상담사 콜 또는 대화를 이어나갈 수 있는 상담 서비스"/> </p>
          <ul>
            <li>- <spring:message code="A1033" text="상담 대화모델 구축"/></li>
            <li>- <spring:message code="A1034" text="질의 응답 서비스 구축"/></li>
            <li>- <spring:message code="A1035" text="키워드 및 카테고리 분석"/></li>
          </ul>
        </div>
        <div class="list consultinganalysis">
          <span><spring:message code="A1036" text="상담 분석"/></span>
          <p><spring:message code="A1037" text="고객 인입 채널에 따른 VOC 분석 툴 제공 서비스"/></p>
          <ul>
            <li>- <spring:message code="A1038" text="QA 업무 효율화"/></li>
            <li>- <spring:message code="A1039" text="전체 Risk 관리"/></li>
            <li>- <spring:message code="A1040" text="인공지능 대화 모델 고도화"/></li>
          </ul>
        </div>
      </div>
      <div id="swiper_technology" class="intro_inner_wrap technology_list mobile swiper">
        <div class="swiper-wrapper">
          <div class="swiper-slide list voicebot">
            <span><spring:message code="A1021" text="음성봇"/></span>
            <p><spring:message code="A1022" text="기존의 상담사의 완전판매 모니터링, 대출 신청 등의 업무 대체"/></p>
            <ul>
              <li>- <spring:message code="A1023" text="고객의 음성을 문자로 변환"/></li>
              <li>- <spring:message code="A1024" text="대화 내용을 음성으로 출력"/></li>
              <li>- <spring:message code="A1025" text="챗봇 기술을 통한 대화 내용 관리"/></li>
            </ul>
          </div>
          <div class="swiper-slide list chatbot">
            <span><spring:message code="A1026" text="챗봇"/></span>
            <p><spring:message code="A1027" text="대화 시나리오를 업로드하여 관리하는 제작 툴 제공"/></p>
            <ul>
              <li>- <spring:message code="A1028" text="엑셀 업로드를 통한 챗봇 제작 가능"/></li>
              <li>- <spring:message code="A1029" text="전화, 채팅 시뮬레이션 가능"/></li>
              <li>- <spring:message code="A1030" text="키패드나 음성의 입력채널 선택 가능"/></li>
            </ul>
          </div>
          <div class="swiper-slide list conversation">
            <span><spring:message code="A1031" text="대화관리"/></span>
            <p><spring:message code="A1032" text="자연스러운 상담사 콜 또는 대화를 이어나갈 수 있는 상담 서비스"/> </p>
            <ul>
              <li>- <spring:message code="A1033" text="상담 대화모델 구축"/></li>
              <li>- <spring:message code="A1034" text="질의 응답 서비스 구축"/></li>
              <li>- <spring:message code="A1035" text="키워드 및 카테고리 분석"/></li>
            </ul>
          </div>
          <div class="swiper-slide list consultinganalysis">
            <span><spring:message code="A1036" text="상담 분석"/></span>
            <p><spring:message code="A1037" text="고객 인입 채널에 따른 VOC 분석 툴 제공 서비스"/></p>
            <ul>
              <li>- <spring:message code="A1038" text="QA 업무 효율화"/></li>
              <li>- <spring:message code="A1039" text="전체 Risk 관리"/></li>
              <li>- <spring:message code="A1040" text="인공지능 대화 모델 고도화"/></li>
            </ul>
          </div>
        </div>
        <div class="swiper-pagination"></div>
      </div>
    </div>
    <%--      //content Technology--%>
    <%--      intro_ask--%>
    <div id="intro_ask">
      <div class="intro_inner_wrap">
        <em><spring:message code="A1041" text="무엇이든 물어보세요"/></em>
        <p><spring:message code="A1042" text="스마트한 인공지능 컨텍센터와 함께 새로운 서비스를 경험하세요."/></p>
        <a href="#lyr_join" class="btn_lyr_open"><spring:message code="A1043" text="문의하기"/></a>
      </div>
    </div>
    <%--      //intro_ask--%>
  </div>
  <%--  //intro_container--%>

  <%--  intro_footer--%>
  <div id="intro_footer">
<%--    회사소개, 이용약과, 개인정보처리방침 url 사용안함--%>
<%--    <ul class="links">--%>
<%--      <li><a href="https://maum.ai:8080/kr/company" target="_blank"><spring:message code="A1044" text="회사소개"/></a></li>--%>
<%--      <li><a href="https://maum.ai/home/krTermsMain" target="_blank"><spring:message code="A1045" text="이용약관"/></a></li>--%>
<%--      <li><a href="https://maum.ai/home/krTermsMain#conditions" target="_blank"><spring:message code="A1046" text="개인정보처리방침"/></a></li>--%>
<%--    </ul>--%>
    <div class="company">
      <div class="intro_inner_wrap">
        <ul>
          <li><spring:message code="A1047" text="사업자 등록번호 314-86-55446"/>  |</li>
          <li><spring:message code="A1048" text="대표 유태준"/>  |</li>
          <li><spring:message code="A1049" text="(주) 마인즈랩 경기도 성남시 분당구 대왕판교로644번길 49 다산타워 5층"/>  |</li>
          <li> <a href="tel:16613222"><spring:message code="A1050" text="Tel: 1661-3222"/></a>  |</li>
          <li><a href="#lyr_join">E-mail: hello@maum.ai</a></li>
        </ul>
      </div>

      <p>Copyright © 2022 MINDsLab. All rights reserved.</p>
    </div>
  </div>
  <%--  //intro_footer--%>
</div>
<%--//intro_wrap--%>

<!-- 서비스 신청 및 문의하기 -->
<div id="lyr_join" class="lyrBox contactBox">
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
          <label for="send_user_name">
            <span class="fas fa-user"></span><spring:message code="A0032" text="이름" />
          </label>
        </div>
        <div class="contact_item">
          <input type="text" id="send_user_email" class="ipt_txt" autocomplete="off">
          <label for="send_user_email">
            <span class="fas fa-envelope"></span><spring:message code="A0048" text="이메일" />
          </label>
        </div>
        <div class="contact_item">
          <input type="text" id="send_user_phone" class="ipt_txt" autocomplete="off">
          <label for="send_user_phone">
            <span class="fas fa-mobile-alt"></span><spring:message code="A0074" text="연락처" />
          </label>
        </div>
        <div class="contact_item_block">
          <textarea id="send_user_text" class="textArea" rows="6"></textarea>
          <label for="send_user_text">
            <span class="fas fa-align-left"></span><spring:message code="A0633" text="문의내용" />
          </label>
        </div>
      </div>
    </form>
  </div>
  <div class="contact_btn">
    <button class="btn_inquiry" onclick="sendMail()"><spring:message code="A0327" text="문의하기" /></button>
    <button id="close_sendmail_form" class="btn_lyr_close">닫기</button>
  </div>
</div>
<!-- //서비스 신청 및 문의하기 -->
<input type="hidden" id= "headerName"  value="${_csrf.headerName}" />
<input type="hidden" id= "token"  value="${_csrf.token}" />

<script type="text/javascript">
  $(window).scroll(function() {
    scrollTop = $(document).scrollTop();

    //fixed 된 헤더에 가로 스크롤 적용
    $('#intro_header').css('left', 0 - $(this).scrollLeft());

    //헤더 active
    if ( scrollTop > 60 ) {
      $('#intro_header').addClass('scroll');
    } else {
      $('#intro_header').removeClass('scroll');
    }

    //service 영역 img box 효과
    var imgBox = $('.content.service .img_box');
    var img01ScrollTop = imgBox.eq(0).offset().top - 700;
    var img02ScrollTop = imgBox.eq(1).offset().top - 700;
    var img03ScrollTop = imgBox.eq(2).offset().top - 700;

    if (scrollTop >= img01ScrollTop) {
      imgBox.eq(0).addClass('scroll');
    }
    if (scrollTop >= img02ScrollTop) {
      imgBox.eq(1).addClass('scroll');
    }
    if (scrollTop >= img03ScrollTop) {
      imgBox.eq(2).addClass('scroll');
    }
  });

  $(document).ready(function(){

    var thisURL = $(location).attr('href'),
      urlStr = thisURL.substring(thisURL.indexOf('/intro'));
    $('.mobile .intro_lang a').removeClass('active');

    if ( urlStr.includes('/intro?lang=en') ) { //영문일 경우
      $('.pc .intro_lang .ko').appendTo($('.pc .intro_lang')); //한국어를 마지막 리스트로 보냄
      $('.mobile .intro_lang .en').addClass('active');
      $('.intro_to_login').attr('href', '/login?lang=en');
      $('.intro_to_pricing').attr('href', 'https://maum.ai/home/pricingPage?lang=en');
      $('.links a').each(function () {
        var list = $(this);
        var href = list.attr('href').replace('kr', 'en');
        list.attr('href', href);
      });
      $('.swiper_success.pc .tit_desc .tit').css('height', '60px');
      $('.swiper_success.pc .tit_desc .desc').css('height', '100px');
      $('.swiper_success.mobile .tit_desc .tit').css({
        'height': '38px',
        'text-align': 'left',
      });
      $('.swiper_success.mobile .tit_desc .desc').css('height', '74px');
      $('#intro_footer .intro_inner_wrap').addClass('en');

    } else { //한글일 경우
      $('.pc .intro_lang .en').appendTo($('.pc .intro_lang')); //영어를 마지막 리스트로 보냄
      $('.mobile .intro_lang .ko').addClass('active');
      $('.intro_to_login').attr('href', '/login');
      $('.intro_to_pricing').attr('href', 'https://maum.ai/home/pricingPage?lang=ko');
      $('.links a').each(function () {
        var list = $(this);
        var href = list.attr('href').replace('en', 'kr');
        list.attr('href', href);
      });
      $('.swiper_success.pc .tit_desc .tit').css('height', '30px');
      $('.swiper_success.pc .tit_desc .desc').css('height', '56px');
      $('.swiper_success.mobile .tit_desc .tit').css({
        'height': '18px',
        'text-align': 'center',
      });
      $('.swiper_success.mobile .tit_desc .desc').css('height', '32px');
      $('#intro_footer .intro_inner_wrap').removeClass('en');

    }

    // swiper
    var swiper_success = new Swiper(".swiper_success", {
      initialSlide: 0,
      slidesPerView: 3,
      spaceBetween: 30,
      centeredSlides: false,
      loop: true,
      loopAdditionalSlides : 1,
      autoplay: {
        delay: 2500,
        disableOnInteraction: false,
      },
      navigation: {
        nextEl: ".success-button-next",
        prevEl: ".success-button-prev",
      },
      breakpoints: {
        768: {
          autoplay: false,
          initialSlide: 0,
          slidesPerView: 1.5,
          spaceBetween: 16,
        }
      }
    });

    var swiper_technology = new Swiper("#swiper_technology", {
      slidesPerView: 1,
      spaceBetween: 20,
      loop: true,
      centeredSlides: false,
      pagination: {
        el: ".swiper-pagination",
      },
    });

  });
</script>
<script type="text/javascript"> //fast login 소스
$(document).ready(function(){
  //Layer popup open
  $('a.btn_lyr_open').on('click',function(){
    var winHeight = $(window).height()*0.7,
            hrefId = $(this).attr('href');

    $('body').css('overflow','hidden');
    $('body').find(hrefId).wrap('<div class="lyrWrap"></div>');
    $('body').find(hrefId).before('<div class="lyr_bg"></div>');

    //대화 UI
    $('.lyrBox .lyr_mid').each(function(){
      $(this).css('max-height', Math.floor(winHeight) +'px');
    });

    //Layer popup close
    $('.btn_lyr_close, .lyr_bg').on('click',function(){
      $('body').css('overflow','');
      $('body').find(hrefId).unwrap();
      //'<div class="lyrWrap"></div>'
      $('.lyr_bg').remove();
    });
  });

  //모바일 메뉴
  $('.open_menu_mobile').on('click', function(){
    $('#mobile_menu').addClass('active');
    $('.open_menu_mobile').hide();
    $('body').css({'overflow': 'hidden'});
  });

  $('.close_menu_mobile').on('click', function(){
    $('#mobile_menu').removeClass('active');
    $('.open_menu_mobile').show();
    $('body').css({'overflow': 'visible'});
  });

  $('#mobile_menu').on('click', function(e){
    e.stopPropagation();
  });

  $('#mobile_menu .background').on('click', function(){
    $('.close_menu_mobile').trigger('click');
  });


  //문의하기 레이어 라벨처리
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

  var title = "[FAST AI] 문의하기가 접수되었습니다.";
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
    console.log('메일 보내기 실패')
  });
}

</script>
</body>
</html>
