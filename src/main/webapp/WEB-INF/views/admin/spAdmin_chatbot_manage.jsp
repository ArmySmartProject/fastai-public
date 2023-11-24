<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html lang="ko">
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
  <!-- icon_favicon -->
  <link rel="shortcut icon" type="image/x-icon" href="resources/images/ico_favicon_60x60.png"><!-- 윈도우즈 사이트 아이콘, HiDPI/Retina 에서 Safari 나중에 읽기 사이드바 -->
  <!-- 한정 css -->
  <link rel="stylesheet" type="text/css" href="resources/css/ui.jqgrid.css"/>
  <!-- 공통 css -->
  <link rel="stylesheet" type="text/css" href="resources/css/font.css">
  <link rel="stylesheet" type="text/css" href="resources/css/reset.css">
  <link rel="stylesheet" type="text/css" href="resources/css/all.css">
  <link rel="stylesheet" type="text/css" href="resources/css/fast_aicc.css">

  <!--[if lte IE 9]>
  <script src="${pageContext.request.contextPath}/resources/js/html5shiv.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/respond.min.js"></script>

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
  <title>챗봇 관리 &gt; FAST AICC</title>
</head>

<body>
<!-- .page loading -->
<div id="pageldg">
    <span class="out_bg">
        <em>
            <strong>&nbsp;</strong>
            <strong>&nbsp;</strong>
            <strong>&nbsp;</strong>
            <b>&nbsp;</b>
        </em>
    </span>
</div>
<!-- //.page loading -->

<!-- #wrap -->
<div id="wrap">
  <!-- #header -->
  <jsp:include page="../common/inc_header.jsp">
    <jsp:param name="titleCode" value="A0406"/>
    <jsp:param name="titleTxt" value="O/B 콜 통계"/>
  </jsp:include>
  <!-- //#header -->

  <hr>

  <!-- #container -->
  <div id="container">
    <div class="hidden-data" style="display: none">
      <p id="hidden_user_name">${userName}</p>
      <p id="hidden_user_id">${userId}</p>
      <p id="hidden_company_name">${companyName}</p>
      <p id="hidden_company_id">${companyId}</p>
    </div>
    <div class="srchArea">
      <table class="tbl_line_view" summary="검색일자,고객조회,유형검색,DB별 최종 값 기준으로 구성됨">
        <caption class="hide">검색조건</caption>
        <colgroup>
          <col width="100">
          <!-- cell 개수 만큼 <col> 개수를 넣어야 함 -->
        </colgroup>
        <tbody>
        <tr>
          <th scope="row">회사명 검색</th>
          <td>
            <div class="iptBox" style="width: 55%;">
              <input type="text" class="ipt_txt search_company" autocomplete="off" style="width: 100%;">
            </div>
          </td>
        </tr>
        <%--<tr>--%>
          <%--<th scope="row">챗봇명 검색</th>--%>
          <%--<td>--%>
            <%--<div class="iptBox" style="width: 55%;">--%>
              <%--<input type="text" class="ipt_txt search_chatbot" autocomplete="off" style="width: 100%;">--%>
            <%--</div>--%>
          <%--</td>--%>
        <%--</tr>--%>
        </tbody>
      </table>
      <div class="btnBox sz_small line">
        <button type="button" class="btnS_basic btn_search">검색</button>
      </div>
    </div>

    <!-- .jqGridBox -->
    <div class="jqGridBox table_full">
      <!-- [D] jqGrid 내 수정버튼에 들어갈 tag입니다 -->
      <%--<a href="#lyr_chatbotManagement" class="btnS_line btn_lyr_open">수정</a>--%>

      <table id="jqGrid"></table>
      <div id="jqGridPager"></div>
    </div>
    <!-- //.jqGridBox -->
  </div>
  <!-- //#container -->

  <hr>

  <!-- #footer -->
  <div id="footer">
    <div class="cyrt"><span>&copy; MINDsLab. All rights reserved.</span></div>
  </div>
  <!-- //#footer -->
</div>
<!-- //#wrap -->
<%@ include file="../common/inc_footer.jsp"%>

<!-- 추가 200629 챗봇관리 상세보기 -->
<div id="lyr_chatbotManagement" class="lyrBox">
  <div class="lyr_top">
    <h3>회사별 챗봇 관리</h3>
    <button class="btn_lyr_close">닫기</button>
  </div>
  <div class="lyr_mid" style="max-height: 655px;">
    <h3 id="hidden_detail_comp_id" style="display:none;">회사ID : <span>comp000</span></h3>
    <div class="titArea">
      <h3 style="text-transform:none;">회사명 : <span>동창회</span></h3>
                                                                         <div class="lot_row">
      <div class="lot_cell">
        <div class="stn tbl_dropdown">
                    <span class="stn_tit">
                        할당 가능한 챗봇 목록
                    </span>

          <div class="stn_cont">
            <div class="tbl_customTd scroll" style="height: 430px;">
              <table class="tbl_line_lst possible_list" summary="번호/고객명/고객구분/연락처1(대표)/연락처2/연락처3으로 구성됨">
                <caption class="hide">DB List</caption>
                <colgroup>
                  <col width="40"><col width="130"><col><col><col>
                  <col>
                </colgroup>
                <thead>
                <tr>
                  <th scope="col">
                    <div class="ipt_check_only">
                      <input type="checkbox" class="ipt_tbl_allCheck">
                    </div>
                  </th>
                  <!-- [D] dropbox를 가지는 th에는 "th_sort" class를 추가해야 합니다. -->
                  <th scope="col">
                    <span>챗봇ID</span>
                    <!-- [D]
                        체크박스를 가질 때 : th_dropbox와 th_check_box 클래스를 적용해야합니다.
                        검색창을 가질 때 : th_dropbox와 th_search_box 클래스를 적용해야합니다.
                    -->
                    <!-- [D]
                    <div class="th_dropbox th_search_box">
                      <div class="iptBox">
                        <input type="text" class="ipt_txt">
                      </div>
                      <button type="button" class="btnS_basic btn_dropbox_confirm">확인</button>
                    </div> -->
                  </th>
                  <th scope="col">챗봇명</th>
                  <!--<th scope="col">상태</th>-->
                  <th scope="col">할당현황</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox">
                    </div>
                  </td>
                  <td>홍길동</td>
                  <td>counseleors@maum.ai</td>
                  <td>가능</td>
                  <td><em>1</em> 개</td>
                </tr>
                <tr>
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox">
                    </div>
                  </td>
                  <td>홍길동</td>
                  <td>counseleors@maum.ai</td>
                  <td>가능</td>
                  <td><em>2</em> 개</td>
                </tr>
                <tr>
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox">
                    </div>
                  </td>
                  <td>홍길동</td>
                  <td>counseleors@maum.ai</td>
                  <td>가능</td>
                  <td><em>5</em> 개</td>
                </tr>
                <tr>
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox">
                    </div>
                  </td>
                  <td>홍길동</td>
                  <td>counseleors@maum.ai</td>
                  <td>가능</td>
                  <td><em>9</em> 개</td>
                </tr>
                <tr>
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox">
                    </div>
                  </td>
                  <td>홍길동</td>
                  <td>counseleors@maum.ai</td>
                  <td>가능</td>
                  <td><em>10</em> 개</td>
                </tr>
                <tr>
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox">
                    </div>
                  </td>
                  <td>홍길동</td>
                  <td>counseleors@maum.ai</td>
                  <td>가능</td>
                  <td><em>10</em> 개</td>
                </tr>
                <tr>
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox">
                    </div>
                  </td>
                  <td>홍길동</td>
                  <td>counseleors@maum.ai</td>
                  <td>가능</td>
                  <td><em>10</em> 개</td>
                </tr>
                <tr>
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox">
                    </div>
                  </td>
                  <td>홍길동</td>
                  <td>counseleors@maum.ai</td>
                  <td>가능</td>
                  <td><em>10</em> 개</td>
                </tr>
                <tr>
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox">
                    </div>
                  </td>
                  <td>홍길동</td>
                  <td>counseleors@maum.ai</td>
                  <td>가능</td>
                  <td><em>10</em> 개</td>
                </tr>
                </tbody>
              </table>
            </div>
            <span class="infoTxt pos_cnt">총 <span>10</span> 개</span>
          </div>
        </div>
      </div>
      <div class="lot_cell connect_cell">
        <button type="button" class="btn_connect assign_button"><img src="${pageContext.request.contextPath}/resources/images/ico_arrow_r.png" alt="챗봇 할당하기"></button>
        <button type="button" class="btn_connect release_button"><img src="${pageContext.request.contextPath}/resources/images/ico_arrow_l.png" alt="챗봇 할당 취소하기"></button>
      </div>
      <div class="lot_cell">
        <div class="stn tbl_dropdown">
                    <span class="stn_tit">
                        할당된 챗봇 목록
                    </span>
          <div class="stn_cont">
            <div class="tbl_customTd scroll" style="height: 430px;">
              <table class="tbl_line_lst assigned_list" summary="번호/고객명/고객구분/연락처1(대표)/연락처2/연락처3으로 구성됨">
                <caption class="hide">DB List</caption>
                <colgroup>
                  <col width="40"><col><col><col><col>
                  <col>
                </colgroup>
                <thead>
                <tr>
                  <th scope="col">
                    <div class="ipt_check_only">
                      <input type="checkbox" class="ipt_tbl_allCheck">
                    </div>
                  </th>
                  <!-- [D] dropbox를 가지는 th에는 "th_sort" class를 추가해야 합니다. -->
                  <th scope="col">
                    <span>챗봇ID</span>
                    <!-- [D]
                        체크박스를 가질 때 : th_dropbox와 th_check_box 클래스를 적용해야합니다.
                        검색창을 가질 때 : th_dropbox와 th_search_box 클래스를 적용해야합니다.
                    -->
                    <!-- [D]
                    <div class="th_dropbox th_search_box">
                      <div class="iptBox">
                        <input type="text" class="ipt_txt">
                      </div>
                      <button type="button" class="btnS_basic btn_dropbox_confirm">확인</button>
                    </div> -->
                  </th>
                  <th scope="col">챗봇명</th>
                  <!--<th scope="col">상태</th>-->
                  <th scope="col">할당현황</th>
                </tr>
                </thead>
                <tbody>
                <!-- [D] 고정되는 user는 admin_active와 checkbox disabled 를 함께 지정해주면 해주면됩니다.  -->
                <tr class="admin_active">
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox" disabled>
                    </div>
                  </td>
                  <td>MaumCloud관리자</td>
                  <td>admin2</td>
                  <td>가능</td>
                  <td><em>1</em> 개</td>
                </tr>
                <tr>
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox">
                    </div>
                  </td>
                  <td>홍길동</td>
                  <td>counseleors@maum.ai</td>
                  <td>가능</td>
                  <td><em>2</em> 개</td>
                </tr>
                <tr>
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox">
                    </div>
                  </td>
                  <td>홍길동</td>
                  <td>counseleors@maum.ai</td>
                  <td>가능</td>
                  <td><em>5</em> 개</td>
                </tr>
                <tr>
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox">
                    </div>
                  </td>
                  <td>홍길동</td>
                  <td>counseleors@maum.ai</td>
                  <td>가능</td>
                  <td><em>9</em> 개</td>
                </tr>
                <tr>
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox">
                    </div>
                  </td>
                  <td>홍길동</td>
                  <td>counseleors@maum.ai</td>
                  <td>가능</td>
                  <td><em>10</em> 개</td>
                </tr>
                <tr>
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox">
                    </div>
                  </td>
                  <td>홍길동</td>
                  <td>counseleors@maum.ai</td>
                  <td>가능</td>
                  <td><em>10</em> 개</td>
                </tr>
                <tr>
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox">
                    </div>
                  </td>
                  <td>홍길동</td>
                  <td>counseleors@maum.ai</td>
                  <td>가능</td>
                  <td><em>10</em> 개</td>
                </tr>
                <tr>
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox">
                    </div>
                  </td>
                  <td>홍길동</td>
                  <td>counseleors@maum.ai</td>
                  <td>가능</td>
                  <td><em>10</em> 개</td>
                </tr>
                <tr>
                  <td scope="row">
                    <div class="ipt_check_only">
                      <input type="checkbox">
                    </div>
                  </td>
                  <td>홍길동</td>
                  <td>counseleors@maum.ai</td>
                  <td>가능</td>
                  <td><em>10</em> 개</td>
                </tr>
                </tbody>
              </table>
            </div>
            <span class="infoTxt ass_cnt">총 <span>10</span> 개</span>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="lyr_btm">
    <div class="btnBox sz_small">
      <button class="system_alert_save">저장</button>
      <button class="btn_lyr_close">취소</button>
    </div>
  </div>
</div>
</div>
<!-- //챗봇관리 상세보기 -->

<!-- 공통 script -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/all.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<!-- jqgrid -->
<script type="text/javascript"  src="${pageContext.request.contextPath}/resources/js/jquery.jqgrid.src.pub.js"></script>
<!-- page Landing -->
<script type="text/javascript">
  $(window).load(function() {
    //page loading delete
    $('#pageldg').addClass('pageldg_hide').delay(300).queue(function() { $(this).remove(); });
  });
</script>

<!-- script -->
<script type="text/javascript">
  var accountList;
  jQuery.event.add(window,"load",function(){
    $(document).ready(function (){
      // GCS iframe
      $('.gcsWrap', parent.document).each(function(){
        //header 화면명 변경
        var pageTitle = $('title').text().replace('> FAST AICC', '');

        $(top.document).find('#header h2 a').text(pageTitle);
      });

      //시스템 메뉴 선택
      $('.menu_slt_box .menu_lst > li').on('click',function(){
        $(this).find('.sub').stop().slideDown(300);
      });
      $('.menu_slt_box .menu_lst .sub > li').on('click',function(){
        $(this).find('.third').stop().slideDown(300);
      });
      $('.menu_slt_box .menu_lst .third > li').on('click',function(){
        $(this).addClass('active').find('.fourth').stop().slideDown(300);
      });

      //추가 jqGrid(data)
      var jqGridData = [
        {no:'1', chatName:'동창회', chatType:'동창회에 초대하는 시나리오', language:'한국어, 영어', counselors:'1',
          modifyUser:'admin1', modifyTime:'2020-06-04', modifyStart:'수정버튼',
        },
        {no:'2', chatName:'골든튤립호텔', chatType:'골든튤립호텔 CS 시나리오', language:'한국어', counselors:'4',
          modifyUser:'admin2', modifyTime:'2020-06-04', modifyStart:'수정버튼',
        },
        {no:'3', chatName:'챗봇이름', chatType:'챗봇설명', language:'한국어, 영어, 일본어, 중국어', counselors:'-',
          modifyUser:'-', modifyTime:'-', modifyStart:'수정버튼',
        },
        {no:'4', chatName:'챗봇이름', chatType:'챗봇설명', language:'한국어, 영어, 일본어, 중국어', counselors:'-',
          modifyUser:'-', modifyTime:'-', modifyStart:'수정버튼',
        },
        {no:'5', chatName:'챗봇이름', chatType:'챗봇설명', language:'한국어, 영어, 일본어, 중국어', counselors:'-',
          modifyUser:'-', modifyTime:'-', modifyStart:'수정버튼',
        },
        {no:'6', chatName:'챗봇이름', chatType:'챗봇설명', language:'한국어, 영어, 일본어, 중국어', counselors:'-',
          modifyUser:'-', modifyTime:'-', modifyStart:'수정버튼',
        },
        {no:'7', chatName:'챗봇이름', chatType:'챗봇설명', language:'한국어, 영어, 일본어, 중국어', counselors:'-',
          modifyUser:'-', modifyTime:'-', modifyStart:'수정버튼',
        },
      ]

      //AMR jqGrid 200624
      $("#jqGrid").jqGrid({
        // data: jqGridData,
        datatype: "local",
        autowidth: true,
        height: 'auto',
        rowNum: 30,
        rowList: [10,20,30],
        colNames:['NO.', '회사ID', '회사명', '챗봇목록', '챗봇수', '수정자', '수정일', '수정'],
        colModel:[
          {name:'no', index:'no', width: 50, align:'center', sorttype: 'number'},
          {name:'companyId', index:'companyId', align:'center'},
          {name:'compNameKor', index:'compNameKor', align:'center'},
          {name:'chatbotList', index:'chatbotList', width:220, align:'center'},
          {name:'chatbots', index:'chatbots', width:70, align:'center', sorttype: 'number'},

          {name:'modifyUser', index:'modifyUser', align:'center'},
          {name:'modifyTime', index:'modifyTime', align:'center'},
          // {name:'modifyStart', index:'modifyStart', align:'center'},
          {name:'modifyStart', index:'modifyStart', width:70, align:'center', sortable: false, formatter:addButton}
        ],
        pager: "#jqGridPager",
        height: 600,
        viewrecords: true,
        sortname: 'name',
        loadComplete : function(data) {
          $(".ui-pg-input").attr("readonly", true);

          $('.btn_lyr_open').on('click',function(){
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
              $(".player").empty();
              $('body').css('overflow','');
              $('body').find(hrefId).unwrap('<div class="lyrWrap"></div>');
              $('.lyr_bg').remove();
            });
          });
        }
      });

      getAccountList.then((res) => {
        getCompanyList('', '');
      });

      // 추가 AMR 200618
      $('.tbl_dropdown .th_dropbox').on('click', function(e){
        e.stopPropagation();
      });

      // 추가 AMR 200630 테이블 셀 클릭 시 그 라인에 있는 체크박스가 체크된다.
      $('.tbl_dropdown tbody tr').on('click', function(){
        if ( $(this).hasClass('admin_active') ) {
          console.log('admin click');
          return;
        }

        $(this).toggleClass('active');
        console.log('click');

        if ( $(this).hasClass('active') ) {
          $(this).find('input:checkbox').prop('checked', true);
        } else {
          $(this).find('input:checkbox').prop('checked', false);
        }
      });

      // 추가 AMR 200618 table th를 클릭하면 검색할 수 있는 dropbox가 보여진다.
      $('.tbl_dropdown .th_sort').on('click', function(){
        if ( $(this).children('.th_dropbox').hasClass('show') ) {
          $('.tbl_dropdown .th_sort').removeClass('active');
          $('.tbl_dropdown .th_dropbox').removeClass('show');
          return;
        }
        $('.tbl_dropdown .th_dropbox').removeClass('show');
        $('.tbl_dropdown .th_sort').removeClass('active');
        $(this).addClass('active');
        $(this).children('.th_dropbox').addClass('show');
      });

      // 추가 AMR 200618 검색 dropbox에서 확인 버튼을 클릭하면 dropbox가 닫힌다.
      $('.tbl_dropdown .btn_dropbox_confirm').on('click', function(){
        $('.tbl_dropdown .th_dropbox').removeClass('show');
        $('.tbl_dropdown .th_sort').removeClass('active');
      });

      // 추가 AMR 200618 table th 안에 있는 input이 focus되어 있을 때 enter 키를 누르면 확인이 클릭된다.
      $('.th_dropbox .ipt_txt, .ipt_check_only input[type="checkbox"]').on('keydown', function(e){
        var keyCode = e.which?e.which:e.keyCode;
        if ( keyCode === 13 ) {
          $('.th_dropbox.show').find('.btn_dropbox_confirm').trigger('click');
        }
      });

      // 추가 AMR 200617 table th안에 있는 전체선택 checkbox를 클릭하면 전체선택이 된다.
      $('.ipt_dropbox_allCheck').on('click',function(){
        var iptDropboxAllCheck = $(this).is(":checked");
        if ( iptDropboxAllCheck ) {
          $(this).prop('checked', true);
          $(this).parents('.th_dropbox').find('input:checkbox').prop('checked', true);
        } else {
          $(this).prop('checked', false);
          $(this).parents('.th_dropbox').find('input:checkbox').prop('checked', false);
        }
      });

      // 추가 AMR 레이어에서 저장버튼 클릭 시 시스템 얼럿으로 한번 더 확인
      $('.system_alert_save').on('click', function(e){
        var hrefId = $(this).parents('.lyrBox');
        console.log(hrefId);

        if (confirm("저장하시겠습니까?")) {
          // 확인 버튼 클릭 시 레이어 닫기
          $('body').css('overflow','');
          $('body').find(hrefId).unwrap('<div class="lyrWrap"></div>');
          $('.lyr_bg').remove();
        }

        var chatbotList = $('.assigned_list tbody').children();
        var chatbotRowData = new Array();

        for (var i = 0; i < chatbotList.length; i++) {
          var tr = chatbotList.eq(i);
          var td = tr.children();
          var data = new Object();

          data.chatbotId = td.eq(1).text();
          chatbotRowData.push(data);
        }

        var companyId = $('#hidden_detail_comp_id').children('span').text();

        // 상담사 목록 저장하기
        $.ajax({
          type:"POST",
          url: "${pageContext.request.contextPath}/saveChatbotMapping",
          data:{"companyId":companyId, "updaterId":$('#hidden_user_id').text(),
              "chatbotInfoList":JSON.stringify(chatbotRowData)},
          beforeSend:function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
          },
          success:function(){
            getCompanyList('', '');
            alert('저장되었습니다.');
          },
          error:function(e){
            alert('시스템상의 문제로 저장에 실패하였습니다.\n잠시 후 다시 시도해주세요.');
            console.log('call /saveChatbotMapping fail');
            console.log(e);
          }
        });
      });

      $('.btn_search').on('click', function(e) {
        var companyKeyword = $('.tbl_line_view .search_company').val();
        // var chatbotKeyword = $('.tbl_line_view .search_chatbot').val();

        getCompanyList(companyKeyword);
      });

      // 엔터키 입력시 회사명(한글) 검색
      $('.tbl_line_view .ipt_txt').on('keydown', function(e){
        if(e.keyCode == 13) {
          var companyKeyword = $('.tbl_line_view .search_company').val();
          // var chatbotKeyword = $('.tbl_line_view .search_chatbot').val();

          getCompanyList(companyKeyword);
        }
      });

      $('.assign_button').on('click', function(e){
        changeChatbotList(true);
        $('.possible_list .ipt_tbl_allCheck').prop('checked', false);
      });

      $('.release_button').on('click', function(e){
        changeChatbotList(false);
        $('.assigned_list .ipt_tbl_allCheck').prop('checked', false);
      });
    });
  });

  // mssql Account table 조회
  let getAccountList = new Promise((resolve, reject) => {
    $.ajax({
      type:"POST",
      url: "${pageContext.request.contextPath}/getAccountList",
      data:{},
      beforeSend:function(xhr){
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
      success:function(data){
        accountList = data;
        resolve('200');
      },
      error:function(){
        console.log("updateResultByKeyword error");
        resolve('500');
      }
    });
  });

  // company list 조회
  function getCompanyList(companyKeyword) {
    $.ajax({
      type:"POST",
      url: "${pageContext.request.contextPath}/getCompanyList",
      data:{companyKeyword:companyKeyword},
      beforeSend:function(xhr){
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
      success:function(data){
        $('#jqGrid').jqGrid('clearGridData');
        // $("#jqGrid").getGridParam("reccount"); // 페이징 처리 시 현 페이지의 Max RowId 값
        for (var i = 0; i < data.length; i++) {
          var botNames = '';
          if (data[i].BOT_IDS !== '-') {
            var botIds = data[i].BOT_IDS.split(',');
            var botNameList = [];
            for (var j = 0; j < botIds.length; j++) {
              if (Object.keys(accountList).includes(botIds[j])){
                botNameList.push(accountList[botIds[j]].Name);
              } else {
                console.log('host ' + botIds[j] + ' is not exist in "Account"!');
              }
            }
            botNames = botNameList.join(',')
          } else {
            botNames = '-';
          }

          data[i]["CHATBOT_LIST"] = botNames;
          $('#jqGrid').addRowData(i, {no:(i+1).toString(), companyId:data[i].COMPANY_ID,
            compNameKor:data[i].COMPANY_NAME, chatbotList:data[i].CHATBOT_LIST, chatbots:data[i].CHATBOT_CNT,
            modifyUser:data[i].UPDUSR_ID, modifyTime:data[i].UPDT_DT, modifyStart:'수정버튼'});
        }
        $('#jqGrid').trigger('reloadGrid');
      },
      error:function(){
        console.log("updateResultByKeyword error");
      }
    });
  }

  function addButton(cellvalue, options, rowObject) {
    var buttonHtml = '<a href="#lyr_chatbotManagement" class="btnS_line btn_lyr_open" onclick="setDetailInfo(\'' +
      rowObject.compNameKor + '\',\''+ rowObject.companyId + '\')">수정</a>';
    return buttonHtml;
  }

  function setDetailInfo(compNameKor, companyId) {
    // 수정화면 타이틀(회사명) 변경
    $('.titArea').children('h3').children('span').text(compNameKor);
    $('#hidden_detail_comp_id').children('span').text(companyId);

    // 수정화면 테이블 초기와
    $('.possible_list > tbody:last').empty();
    $('.assigned_list > tbody:last').empty();

    getBotMappingInfo(companyId, '');
  }

  // company에 따른 챗봇 mapping 정보 조회
  function getBotMappingInfo(companyId) {
    $.ajax({
      type: "POST",
      url: "${pageContext.request.contextPath}/getBotMappingInfo",
      data: {"companyId":companyId},
      beforeSend:function(xhr) {
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
      success:function(data){
        getBotMappingList(data);
      },
      error:function(e) {
        console.log('call /getBotMappingInfo fail');
        console.log(e);
      }
    });
  }

  // host별 매핑된 company수 조회
  function getBotMappingList(botMappingInfo) {
    $.ajax({
      type: "POST",
      url: "${pageContext.request.contextPath}/getMappedBotCnt",
      data: {},
      beforeSend:function(xhr) {
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
      success:function(data){
        var accountkeys = Object.keys(accountList);
        for (var i = 0; i < accountkeys.length; i++) {
          if (data.hasOwnProperty(accountkeys[i])) {
            accountList[accountkeys[i]]['BotCnt'] = data[accountkeys[i]];
          } else {
            accountList[accountkeys[i]]['BotCnt'] = 0;
          }
        }
        var mappedBotId = [];
        var posList = [];
        var assList = [];

        // 배정된 챗봇 list 만들기
        for (var i = 0; i < botMappingInfo.length; i++) {
          var botId = botMappingInfo[i].BOT_ID;
          assList.push(accountList[botId]);
          mappedBotId.push(botId);
        }

        // 배정 가능한 챗봇 list 만들기
        for (var i = 0; i < Object.keys(accountList).length; i++) {
          if (!mappedBotId.includes(i) && accountList[i] !== undefined) {
            posList.push(accountList[i]);
          }
        }

        $('.possible_list > tbody:last').empty();
        $('.assigned_list > tbody:last').empty();
        addChatbotList(posList, false); // 배정 가능한 챗봇 화면에 뿌려주기
        addChatbotList(assList, true); // 배정된 챗봇 화면에 뿌려주기
        $('.pos_cnt').find('span').text(posList.length);
        $('.ass_cnt').find('span').text(assList.length);
      },
      error:function(e) {
        console.log('call /getMappedBotCnt fail');
        console.log(e);
      }
    });
  }

  function addChatbotList(data, isAssign) {
    data.sort((a,b) => (a.Host > b.Host) ? 1 : ((b.Host > a.Host) ? -1 : 0));
    for (var i = 0; i < data.length; i++) {
      var rowData = '<tr><td scope="row"><div class="ipt_check_only"><input type="checkbox"></div></td>'
          + '<td style="display: none;">' + data[i].No + '</td>'
          + '<td>' + data[i].Host + '</td><td>' + data[i].Name + '</td>'
          + '<td><em>' + data[i].BotCnt + '</em> 개</td></tr>';

      if (isAssign) {
        $('.assigned_list').find('tbody').append(rowData);
      } else {
        $('.possible_list').find('tbody').append(rowData);
      }
    }
  }

  // 선택되어 있는 company에 챗봇 할당
  function changeChatbotList(isAssign) {
    var chatbotList;
    // isAssign이 true이면 챗봇을 company에 할당하는것
    if (isAssign) {
      chatbotList = $('.possible_list input[type="checkbox"]:checked').not('.ipt_tbl_allCheck');
    } else {
      chatbotList = $('.assigned_list input[type="checkbox"]:checked').not('.ipt_tbl_allCheck');
    }
    var chatbotListLeng = chatbotList.length;
    var checkedRowData = new Array();

    for (var i = 0; i < chatbotListLeng; i++) {
      var tr = chatbotList.parent().parent().parent().eq(i);
      var td = tr.children();

      // 체크된 row data 복사
      var tdData = {No: td.eq(1).text(), Host: td.eq(2).text(), Name: td.eq(3).text(), BotCnt: td.eq(4).text().replace(' 개', '')};
      // tdArr.push(td.eq(3).text()); // 상태값. 현재는 항상 가능임
      checkedRowData.push(tdData);
    }
    console.log(checkedRowData);

    // 체크된 row 삭제
    for (var i = 0; i < chatbotListLeng; i++) {
      chatbotList.eq(i).closest('tr').remove();
    }

    if (isAssign) {
      addChatbotList(checkedRowData, isAssign);
      $('.pos_cnt').find('span').text(Number($('.pos_cnt').find('span').text()) - checkedRowData.length);
      $('.ass_cnt').find('span').text(Number($('.ass_cnt').find('span').text()) + checkedRowData.length);
    } else {
      addChatbotList(checkedRowData, isAssign);
      $('.pos_cnt').find('span').text(Number($('.pos_cnt').find('span').text()) + checkedRowData.length);
      $('.ass_cnt').find('span').text(Number($('.ass_cnt').find('span').text()) - checkedRowData.length);
    }
  }
</script>
</body>
</html>
