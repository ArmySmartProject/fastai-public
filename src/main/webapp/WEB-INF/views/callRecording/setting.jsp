<%--
  Created by IntelliJ IDEA.
  User: hoseop
  Date: 20. 4. 27.
  Time: 오전 10:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="format-detection" content="telephone=no">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <!-- Cache reset -->
    <meta http-equiv="Expires" content="Mon, 06 Jan 2016 00:00:01 GMT">
    <meta http-equiv="Expires" content="-1">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">

    <%@ include file="../common/inc_head_resources.jsp" %>
</head>
<body>
<!-- #wrap -->
<div id="wrap">
    <!-- #header -->
    <jsp:include page="../common/inc_header.jsp">
        <jsp:param name="titleCode" value="A0504"/>
        <jsp:param name="titleTxt" value="Setting"/>
    </jsp:include>
    <!-- //#header -->
    <!-- #container -->
    <div id="container">
        <!-- .section -->
        <div class="section">
            <!-- //.tab_calling -->
            <div class="tab_calling_view" style="padding:20px;">
                <div class="tbl_cell">
                    <!-- .callView -->
                    <div class="callView">
                        <!-- .callView_tit -->
                        <div class="callView_tit">
                            <h3>Setting</h3>
                        </div>
                        <!-- //.callView_tit -->
                        <!-- .callView_cont -->
                        <div class="callView_cont" style="height:auto;">
                            <dl class="dl_tblType01">
                                <dt>Recording Router</dt>
                                <dd>
                                    <dl class="dl_tblType01_tr">
                                        <dt>IP</dt>
                                        <dd>
                                            <div class="iptBox">
                                                <input type="text" class="ipt_txt">
                                            </div>
                                        </dd>
                                    </dl>
                                    <dl class="dl_tblType01_tr">
                                        <dt>Port</dt>
                                        <dd>
                                            <div class="iptBox">
                                                <input type="text" class="ipt_txt">
                                            </div>
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                            <dl class="dl_tblType01">
                                <dt>Phone Number</dt>
                                <dd>
                                    <dl class="dl_tblType01_tr">
                                        <dt></dt>
                                        <dd>
                                            <select class="select">
                                                <option>11111111</option>
                                                <option>11111111</option>
                                                <option>11111111</option>
                                                <option>11111111</option>
                                            </select>
                                        </dd>
                                        <dd>
                                            <div class="btnBox sz_small">
                                                <a href="http://10.122.66.179/gcs_portal/fastAicc/ci_cr_Setting.html#lyr_add_pnum"
                                                   class="btnS_basic btn_lyr_open"><span class="fas fa-plus"
                                                                                         aria-hidden="true"></span>Add</a>
                                                <button type="button"><span class="fas fa-minus"
                                                                            aria-hidden="true"></span>Delete
                                                </button>
                                            </div>
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                            <dl class="dl_tblType01">
                                <dt>Recording Server</dt>
                                <dd>
                                    <dl class="dl_tblType01_tr">
                                        <dt>IP</dt>
                                        <dd>
                                            <select class="select">
                                                <option>11111111</option>
                                                <option>11111111</option>
                                                <option>11111111</option>
                                                <option>11111111</option>
                                            </select>
                                        </dd>
                                        <dd>
                                            <div class="btnBox sz_small">
                                                <a href="http://10.122.66.179/gcs_portal/fastAicc/ci_cr_Setting.html#lyr_add_rsver"
                                                   class="btnS_basic btn_lyr_open"><span class="fas fa-plus"
                                                                                         aria-hidden="true"></span>Add</a>
                                                <button type="button"><span class="fas fa-minus"
                                                                            aria-hidden="true"></span>Delete
                                                </button>
                                            </div>
                                        </dd>
                                    </dl>
                                    <dl class="dl_tblType01_tr">
                                        <dt>Port</dt>
                                        <dd>
                                            <div class="iptBox">
                                                <input type="text" class="ipt_txt">
                                            </div>
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                            <dl class="dl_tblType01">
                                <dt>Audio Codec</dt>
                                <dd>
                                    <dl class="dl_tblType01_tr">
                                        <dt></dt>
                                        <dd>
                                            <select class="select">
                                                <option>11111111</option>
                                                <option>11111111</option>
                                                <option>11111111</option>
                                                <option>11111111</option>
                                            </select>
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                            <dl class="dl_tblType01">
                                <dt>Meta DB Server</dt>
                                <dd>
                                    <dl class="dl_tblType01_tr">
                                        <dt>IP</dt>
                                        <dd>
                                            <div class="iptBox">
                                                <input type="text" class="ipt_txt">
                                            </div>
                                        </dd>
                                    </dl>
                                    <dl class="dl_tblType01_tr">
                                        <dt>Port</dt>
                                        <dd>
                                            <div class="iptBox">
                                                <input type="text" class="ipt_txt">
                                            </div>
                                        </dd>
                                    </dl>
                                </dd>
                                <dd>
                                    <dl class="dl_tblType01_tr">
                                        <dt>ID</dt>
                                        <dd>
                                            <div class="iptBox">
                                                <input type="text" class="ipt_txt">
                                            </div>
                                        </dd>
                                    </dl>
                                    <dl class="dl_tblType01_tr">
                                        <dt>Password</dt>
                                        <dd>
                                            <div class="iptBox">
                                                <input type="text" class="ipt_txt">
                                            </div>
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                            <dl class="dl_tblType01">
                                <dt>Recording Log</dt>
                                <dd>
                                    <dl class="dl_tblType01_tr">
                                        <dt>Log path</dt>
                                        <dd>
                                            <div class="iptBox">
                                                <input type="text" class="ipt_txt">
                                            </div>
                                        </dd>
                                    </dl>
                                    <dl class="dl_tblType01_tr">
                                        <dt>Log file</dt>
                                        <dd>
                                            <div class="iptBox">
                                                <input type="text" class="ipt_txt">
                                            </div>
                                        </dd>
                                    </dl>
                                </dd>
                                <dd>
                                    <dl class="dl_tblType01_tr">
                                        <dt>Log rotate</dt>
                                        <dd>
                                            <div class="iptBox">
                                                <input type="text" class="ipt_txt" style="width:90%;">
                                                <span>days</span>
                                                <input type="text" class="ipt_txt1" style="width:90%; opacity:0;pointer-events:none;">
                                            </div>
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>

                        </div>
                        <!-- //.callView_cont -->
                        <div class="btnBox sz_small line">
                            <a href="http://10.122.66.179/gcs_portal/fastAicc/ci_cr_Setting.html#none"
                               class="btnS_basic">저장</a>
                        </div>
                    </div>
                    <!-- //.callView -->
                </div>
            </div>
        </div>
        <!-- //.section -->
    </div>
    <!-- //#container -->

    <hr>

    <!-- #footer -->
    <div id="footer">
        <div class="cyrt"><span>© MINDsLab. All rights reserved.</span></div>
    </div>
    <!-- //#footer -->
</div>
<!-- //#wrap -->

<!-- ===== layer popup ===== -->
<!-- 사용자 비밀번호 변경 -->
<div id="lyr_profile" class="lyrBox">
    <div class="lyr_top">
        <h3>사용자 정보</h3>
        <button class="btn_lyr_close">닫기</button>
    </div>
    <div class="lyr_mid">
        <dl class="dlBox">
            <dt>아이디</dt>
            <dd>
                <div class="iptBox">
                    <input type="text" class="ipt_txt" value="adsf2355@naver.com" disabled="">
                </div>
            </dd>
        </dl>
        <dl class="dlBox">
            <dt>이름</dt>
            <dd>
                <div class="iptBox">
                    <input type="text" class="ipt_txt" value="홍길동" disabled="">
                </div>
            </dd>
        </dl>
        <dl class="dlBox">
            <dt>비밀번호</dt>
            <dd>
                <div class="iptBox" style="margin-bottom:7px;">
                    <input type="password" class="ipt_txt" placeholder="비밀번호">
                </div>
                <div class="iptBox">
                    <input type="password" class="ipt_txt" placeholder="비밀번호 확인">
                    <!-- [D] 에러메세지
                    <p class="error_msg">패스워드가 일치하지 않습니다.</p> -->
                </div>
            </dd>
        </dl>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button class="btn_lyr_close">저장</button>
            <button class="btn_lyr_close">취소</button>
        </div>
    </div>
</div>
<!-- //사용자 비밀번호 변경 -->
<!-- 서비스 신청 및 문의하기 -->
<div id="lyr_join" class="lyrBox contactBox">
    <div class="contact_tit">
        <h3>서비스 신청 및 문의하기</h3>
    </div>
    <div class="contact_cnt">
        <p class="info_txt">서비스에 관련된 문의를 남겨 주시면 담당자가 확인 후 연락 드리겠습니다.</p>
        <ul class="contact_lst">
            <li><a href="tel:1661-3222">1661-3222</a></li>
            <li><span>hello@maum.ai</span></li>
        </ul>
        <div class="contact_form">
            <div class="contact_item">
                <input type="text" id="user_name" class="ipt_txt" autocomplete="off">
                <label for="user_name">
                    <span class="fas fa-user" aria-hidden="true"></span>이름
                </label>
            </div>
            <div class="contact_item">
                <input type="text" id="user_email" class="ipt_txt" autocomplete="off">
                <label for="user_email">
                    <span class="fas fa-envelope" aria-hidden="true"></span>이메일
                </label>
            </div>
            <div class="contact_item">
                <input type="text" id="user_phone" class="ipt_txt" autocomplete="off">
                <label for="user_phone">
                    <span class="fas fa-mobile-alt" aria-hidden="true"></span>연락처
                </label>
            </div>
            <div class="contact_item_block">
                <textarea id="user_txt" class="textArea" rows="6"></textarea>
                <label for="textArea">
                    <span class="fas fa-align-left" aria-hidden="true"></span>문의내용
                </label>
            </div>
        </div>
    </div>
    <div class="contact_btn">
        <button id="btn_sendMail" class="btn_inquiry">문의하기</button>
        <button class="btn_lyr_close">닫기</button>
    </div>
</div>
<!-- //서비스 신청 및 문의하기 -->
<!-- New Phone Number -->
<div id="lyr_add_pnum" class="lyrBox">
    <div class="lyr_top">
        <h3>New Phone Number</h3>
        <button class="btn_lyr_close">닫기</button>
    </div>
    <div class="lyr_mid">
        <dl class="dlBox">
            <dt style="width:100px;">Phone Number</dt>
            <dd>
                <div class="iptBox">
                    <input type="text" class="ipt_txt" style="width:100%; height:30px;">
                </div>
            </dd>
        </dl>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button class="btn_lyr_close">저장</button>
            <button class="btn_lyr_close">취소</button>
        </div>
    </div>
</div>
<!-- New Recording Server -->
<div id="lyr_add_rsver" class="lyrBox">
    <div class="lyr_top">
        <h3>New Recording Server</h3>
        <button class="btn_lyr_close">닫기</button>
    </div>
    <div class="lyr_mid">
        <dl class="dlBox">
            <dt>IP</dt>
            <dd>
                <div class="iptBox">
                    <input type="text" class="ipt_txt" style="width:100%; height:30px;">
                </div>
            </dd>
        </dl>
        <dl class="dlBox">
            <dt>Port</dt>
            <dd>
                <div class="iptBox">
                    <input type="text" class="ipt_txt" style="width:100%; height:30px;">
                </div>
            </dd>
        </dl>
    </div>
    <div class="lyr_btm">
        <div class="btnBox sz_small">
            <button class="btn_lyr_close">저장</button>
            <button class="btn_lyr_close">취소</button>
        </div>
    </div>
</div>

<%@ include file="../common/inc_footer.jsp"%>

<!-- page Landing -->
<script type="text/javascript">
    $(window).load(function () {
        //page loading delete
        $('#pageldg').addClass('pageldg_hide').delay(300).queue(function () {
            $(this).remove();
        });
    });
</script>
<!-- script -->
<script type="text/javascript">
    jQuery.event.add(window, "load", function () {
        $(document).ready(function () {
            // GCS iframe
            $('.gcsWrap', parent.document).each(function () {
                //header 화면명 변경
                var pageTitle = $('title').text().replace('> FAST AICC', '');

                $(top.document).find('#header h2 a').text(pageTitle);
            });
        });
    });
</script>
</body>
</html>
