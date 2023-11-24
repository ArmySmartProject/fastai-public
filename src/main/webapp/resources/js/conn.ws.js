var transferYN = 0; // AI에서 상담사로 전환 여부
var result = ''; // 리턴값
var inerHtml ="";
var ws_agent = null; // 청취, 상담개입
var wss_url = ""; 

// 메인소켓 연결 url: 연결주소 연결 요청메세지 CALL
function conn_main_ws(url) {
	
	wss_url = url+"/callsocket"; //90배포용 
	main_ws = new WebSocket(wss_url);
	
	main_ws.onclose = function(event) {
	  console.error("main Socket is closed now.");
	  console.error(event);
	};
	
	main_ws.onerror = function(event) {
		console.error("main Socket is error now.");
		console.error(event);
		alert(getLocaleMsg("A0011", "소켓 연결에 실패하였습니다."));
	};
		
	main_ws.onopen = function() {
		main_ws.send('{"EventType":"CALL", "Event":"subscribe"}');
	};
	main_ws.onmessage = function(e) {
		
		console.log("refresh");
		console.log(e.data);
		
		if(e.data == "wss"){
			return;
		}
		
		var rcv_data = JSON.parse(e.data);
		console.log("call====");
		console.log(rcv_data);
		// 타입이CALL인 경우
		if (rcv_data.EventType == 'CALL') {
			if (rcv_data.Event == 'status') {
				if($("#csType").val() == "OB"){
					// OB DbList 시도 결과
					goPage($("#currentPage").val(), 'outbound');
				}
				
				if (rcv_data.call_status == "CS0002") {//전화 연결중인결우
					$("#" + rcv_data.Agent).find('.call_state').html(getLocaleMsg("A0002", "통화중"));
					$("#" + rcv_data.Agent+" > .time > a").text(getLocaleMsg("A0002", "통화중"));
					$("#" + rcv_data.Agent).find(".callView").addClass("alarm");
					
					//wss
					//sendMsg = '{"EventType":"STT", "Event":"subscribe", "Caller":"' + rcv_data.Caller	+ '", "Agent":"' + rcv_data.Agent + '", "contract_no":"' + rcv_data.contract_no + '"}';
					sendMsg = '{"EventType":"STT", "Event":"subscribe", "Caller":"' + rcv_data.Caller	+ '", "Agent":"' + rcv_data.Agent + '", "contract_no":"' + rcv_data.contract_no + '"}';
					
					agentWs(url, sendMsg,rcv_data.Agent);
					var obj = new Object();
					obj.TEL_NO =  rcv_data.Caller;
					obj.SIP_USER =  rcv_data.Agent;
					obj.CONTRACT_NO =  rcv_data.contract_no;
					
					//통화중되면 대시시간 시작
					waitTimer(rcv_data.Agent);
					fncMap[rcv_data.Agent]();
					
					//$("#autoCallYn").val("Y");
					//통화중이 될경우 클릭 펑션
					$("#" + rcv_data.Agent +"_chatBot").on("click",obj,function() {
						obj.CAMPAIGN_ID = $("#" + rcv_data.Agent +"_chatBot > input").val();//해당봇의 캠페인 ID
						
						agentClick(obj);
					});//통화중이 될경우 클릭 펑션-END
				} else if (rcv_data.call_status == "CS0006") {
					$("#" + rcv_data.Agent).find('.call_state').html(getLocaleMsg("", "진행중"));
					//$("#autoCallYn").val("Y");
					
	            } else if (rcv_data.call_status == "CS0003") {
	            	$("#" + rcv_data.Agent).find('.call_state').html(getLocaleMsg("A0001", "대기중"));
	            	$("#" + rcv_data.Agent+" > .time > a").text(getLocaleMsg("A0001", "대기중"));
	            	$("#" + rcv_data.Agent).find('.lst_talk').empty();//하단 채팅 내용 삭제
	            	$("#" + rcv_data.Agent +"_chatBot").prop("onclick", null).off("click");
	            	$('.callDetail .callView').removeClass("alarm");
	            	$("#" + rcv_data.Agent).find(".callView").removeClass("alarm");
	            	
	            	//대기중이되면 대기시간 초기화
	            	stopTimer(rcv_data.Agent);
	            	fncMap[rcv_data.Agent]();
	            	
                    $("#call_listen").attr("class", "btnS_basic");
                    $("#call_listen").attr("disabled", true);

                    $("#call_end").addClass("hide");

                    $("#call_change").attr("class", "btnS_basic");
                    $("#call_change").attr("disabled", true);
                    $("#consultantType").val("false");

					$("#StpAutoCall").attr("class", "btnS_basic");
					$("#StpAutoCall").attr("disabled", true);

	            	$("#autoCallYn").val("N");
                    $("#SrtAutoCall").removeClass("hide");
	            	if($('.callDetail .callView .callView_tit span.call_state').text() == ""){
	            		$('.callDetail .callView .callView_tit span.call_state').text('');
	            	}else{
	            		$('.callDetail .callView .callView_tit span.call_state').text(getLocaleMsg("A0008", "통화종료"));
	            	}
	            	//$("#autoCallYn").val("N");
	            	if(agent_scoket_map[rcv_data.Agent]){
	            		//통화 후 대기중 I/B CM_CONTRACT에 CUST_ID 업데이트
						// if($("#csType").val() == "IB"){
						// 	var obj = new Object();
						// 	obj.TEL_NO =  rcv_data.Caller;
						// 	obj.CONTRACT_NO =  rcv_data.contract_no;
						// 	httpSend("updateCustId", $("#headerName").val(), $("#token").val(), JSON.stringify(obj));
						// }else if($("#csType").val() == "OB"){
						// 	var obj = new Object();
						// 	obj.TEL_NO =  rcv_data.Caller;
						// 	obj.CAMPAIGN_ID =  $("#obCustCampaignId").text();
						// 	obj.CONTRACT_NO =  rcv_data.contract_no;
						// 	httpSend("/updateObCustId", $("#headerName").val(), $("#token").val(), JSON.stringify(obj));
						// }
						// var obj = new Object();
						// obj.TEL_NO =  rcv_data.Caller;
						// obj.CAMPAIGN_ID =  $("#obCustCampaignId").text();
						// obj.CONTRACT_NO =  rcv_data.contract_no;
						// httpSend("/updateObCustId", $("#headerName").val(), $("#token").val(), JSON.stringify(obj));

		            	agent_scoket_map[rcv_data.Agent].close();
		            	delete agent_scoket_map[rcv_data.Agent];
	            	}
	            } else {
	            	$("#" + rcv_data.Agent).find('.call_state').html(getLocaleMsg("A0001", "대기중"));
	            	$("#" + rcv_data.Agent+" > .time > a").text(getLocaleMsg("A0001", "대기중"));
	            	$("#" + rcv_data.Agent).find('.lst_talk').empty();//하단 채팅 내용 삭제
	            	$("#" + rcv_data.Agent +"_chatBot").prop("onclick", null).off("click");
	            	//$('.callDetail .callView .callView_tit span.call_state').text('통화중료');
	            	$('.callDetail .callView').removeClass("alarm");
	            	$("#" + rcv_data.Agent).find(".callView").removeClass("alarm");
	            	
	            	//대기중이되면 대기시간 초기화
	            	stopTimer(rcv_data.Agent);
	            	fncMap[rcv_data.Agent]();
	            	
                    $("#call_listen").attr("class", "btnS_basic");
                    $("#call_listen").attr("disabled", true);

                    $("#call_end").addClass("hide");

                    $("#call_change").attr("class", "btnS_basic");
                    $("#call_change").attr("disabled", true);

					$("#StpAutoCall").attr("class", "btnS_basic");
					$("#StpAutoCall").attr("disabled", true);

	            	$("#autoCallYn").val("N");
                    $("#SrtAutoCall").removeClass("hide");
	            	if($('.callDetail .callView .callView_tit span.call_state').text() == ""){
	            		$('.callDetail .callView .callView_tit span.call_state').text('');
	            	}else{
	            		$('.callDetail .callView .callView_tit span.call_state').text(getLocaleMsg("A0008", "통화종료"));
	            	}
	            	//$("#autoCallYn").val("N");
	            	if(agent_scoket_map[rcv_data.Agent]){
	            		//통화 후 대기중 I/B CM_CONTRACT에 CUST_ID 업데이트
						// if($("#csType").val() == "IB"){
						// 	var obj = new Object();
						// 	obj.TEL_NO =  rcv_data.Caller;
						// 	obj.CONTRACT_NO =  rcv_data.contract_no;
						// 	httpSend("updateCustId", $("#headerName").val(), $("#token").val(), JSON.stringify(obj));
						// }else if($("#csType").val() == "OB"){
						// 	var obj = new Object();
						// 	obj.TEL_NO =  rcv_data.Caller;
						// 	obj.CAMPAIGN_ID =  $("#obCustCampaignId").text();
						// 	obj.CONTRACT_NO =  rcv_data.contract_no;
						// 	httpSend("/updateObCustId", $("#headerName").val(), $("#token").val(), JSON.stringify(obj));
						// }
						// var obj = new Object();
						// obj.TEL_NO =  rcv_data.Caller;
						// obj.CAMPAIGN_ID =  $("#obCustCampaignId").text();
						// obj.CONTRACT_NO =  rcv_data.contract_no;
						// httpSend("/updateObCustId", $("#headerName").val(), $("#token").val(), JSON.stringify(obj));

		            	agent_scoket_map[rcv_data.Agent].close();
		            	delete agent_scoket_map[rcv_data.Agent];
	            	}
	            }
			}else if (rcv_data.Event == 'stop') {
				console.log("call stop");
				ajaxCall("/getOpUserState", $("#headerName").val(), $("#token").val(),	JSON.stringify(obj), "N");
            }else if(rcv_data.Event == "transfer"){//상담사 요청 들어옴
            	//현재 STT보고있는 대상 > 팝업 + alarm + 소리
            	if($("#chatCont").find( 'div.callView_tit' ).attr("name") == rcv_data.Agent){
            		fnAlarmCont(rcv_data.Agent, {type:"on", alarm:false, audio:true, alert:true});
            		//document.getElementById("alarmAudio").play();//오디오켜기
            		//$("#"+rev_data.Agent+" > div").addClass("alarm");
            	}else if($("#call_change").attr("class").match("btnS_primary") == "btnS_primary"){//상담개입중 > alarm
            		fnAlarmCont(rcv_data.Agent, {type:"on", alarm:false, audio:false});
            	}else{//나머지(STT를 보고있는데 상담사 요청한콜, STT안보고있는데 상담사 요청한콜) > alarm + 소리
            		fnAlarmCont(rcv_data.Agent, {type:"on", alarm:false, audio:true});
            		//$("#"+rev_data.Agent+" > div").addClass("alarm");
            		//document.getElementById("alarmAudio").play();//오디오켜기
            	}
            }
		}
	};
}


function agentClick(obj){

	//통화중이 될경우 클릭 펑션
		//초기화
		initSet();
		
		if($("#csType").val() == "OB"){
			agentInfo(obj);
		}
		$(".saveCsBtn").attr('disabled', false);
		//정보변경버튼 활성화_0515
		$(".btnS_basic.btn_userInfoModify.btn_lyr_open").first().removeAttr("disabled");
		if($("#consultantType").val() == "true"){
			$("#call_change").attr("class", "btnS_primary");
			$("#call_change").attr("disabled", true);
		}else{
			$("#call_change").attr("class", "btnS_basic");
			$("#call_change").attr("disabled", false);
		}
		
		$('.callDetail .callView').addClass("alarm");
		//청취, 개입, 종료버튼 초기화
		chBtn("call_close");
		//클릭시 요소변경
		$("#chatCont").find( 'div.callView_tit' ).attr("name",obj.SIP_USER);
		$("#chatCont_CONTRACTNO").val(obj.CONTRACT_NO);
		//클릭시 chatCont값 변경 되어야 하는 부분  - 통화 시간도 있어야 함
		//$("#chatCont").find( 'div.callView_tit >h3' ).empty();
		$("#chatCont").find( 'div.callView_tit >h3' ).append($("#" + obj.SIP_USER +"_chatBot >h3").html());
		//$("#chatCont").find( 'ul.lst_talk' ).empty();   
		//$("#chatCont").find( 'tbody.score_tbody' ).empty();//구간탐지 초기화
		//클릭시 연결된 전화번호 에이전트 커넥트넘버로 고객정보 상담내용 구간탐지 값 호출
		//봇 클릭 캠페인ID값 얻기(상담유형)
		$("#CSDTL_CAMPAIGN_ID").val(obj.CAMPAIGN_ID);

		ajaxCall($("#csType").val()=="IB"?"ibUserInfo":"obUserInfo",$("#headerName").val(), $("#token").val(),	JSON.stringify(obj), "N");
		/**
		 * 확인해야할 사항 콜 청취중 음성봇 변경시  
		 * 상당개입중 하단 음성봇 선택시 변경? 불가?
		 * 
		 * */
		//"콜청취" 클릭
		$("#call_listen").off("click").on("click",obj,function() {
		    //$('#call_listen').attr("disabled", true);
			$("#call_end").removeClass("hide");
			if(chBtn("call_listen") == false){
				
				console.log("상담개입 > 청취");
				
				ws_agent.close();
				ws_agent = null;
			}
			
			
			var sendMsg = { Event: "LISTEN", AgentId: $("#OP_LOGIN_ID").val(), dialNo: obj.SIP_USER};
		    //var sendMsg = { Event: "LISTEN", AgentId: "admin", dialNo: obj.SIP_USER};//testcode
		     sendMsgRestful("/sendCM", $("#headerName").val(), $("#token").val(),"LISTEN", JSON.stringify(sendMsg), "N");
		 });
		 //"상담개입" 클릭
		$("#call_change_op").off("click").on("click",obj,function() {
		    //$('#call_listen').attr("disabled", true);
			
			$("#consultantType").val("true");
			
			//상담개입시 대기시간 초기화
			stopTimer(obj.SIP_USER);
        	fncMap[obj.SIP_USER]();
			$("#"+obj.SIP_USER).find(".call_state").text("통화중");
				$("#call_end").removeClass("hide");
				if(chBtn("call_change_op") == false){
					
					console.log("청취 > 상담개입");
					
					ws_agent.close();
					ws_agent = null;
				}
				//STT보는중 알람울리는중이면 알람 전부끄기
				fnAlarmCont(obj.SIP_USER, {type:"audioAllOff", alarm:true, audio:true});
				//document.getElementById("alarmAudio").load();//오디오끄기
				
				var sendMsg = { Event: "TRANSFER", AgentId: $("#OP_LOGIN_ID").val(), dialNo: obj.SIP_USER};
			    //var sendMsg = { Event: "TRANSFER", AgentId: "admin", dialNo: obj.SIP_USER};//testcode
			     sendMsgRestful("/sendCM", $("#headerName").val(), $("#token").val(),"TRANSFER", JSON.stringify(sendMsg), "N");
		});
		 //"종료" 클릭
		$("#call_close").off("click").on("click",obj,function() {
			
			var msg = "";
			//var closeYn = null;
			
//			if($("#call_listen").attr("disabled") == "disabled"){
//				msg = getLocaleMsg("A0006", "청취를 종료하시겠습니까?");
//			}
//			else if($("#call_change_op").attr("disabled") == "disabled"){
//				msg = getLocaleMsg("A0007", "상담을 종료하시겠습니까?");
//			}
//			
//			alertInit(msg, "socketCloseYn");
			$("#consultantType").val("false");
			socketCloseYn("socketCloseYn");
			$("#call_end").addClass("hide");
			//closeYn = confirm(msg);
			/*closeYn = ibAlert(msg, "");
			
			console.log("closeYn : "+closeYn);
			
			if(closeYn){
				
				chBtn("call_close");
				
				ws_agent.close();
				ws_agent = null;
			}*/
			
		});
		
		
		if($("#alarmAudio_"+obj.SIP_USER).length > 0 && $("#"+obj.SIP_USER+" > div").attr("class").match("alarm")){
			//알람떠있는 상태면 알람제거 + 소리끄고 처음으로
			
			fnAlarmCont(obj.SIP_USER, {type:"off", alarm:true, audio:true});
			
			//$("#"+obj.SIP_USER+" > div").removeClass("alarm");
			//document.getElementById("alarmAudio").load();
		}
		
}
//소프트폰 콜
function directCall(obj) {
	console.log("campaginId : " + obj.CAMPAIGN_ID);
	console.log("contractNo : " + obj.CONTRACT_NO);
	
	var sendMsg = { Event: "DIRECT", contractNo: obj.CONTRACT_NO, campaignId: obj.CAMPAIGN_ID ,agentId: $("#OP_LOGIN_ID").val()};
	
	console.log("데이터 : " + JSON.stringify(sendMsg));
	
	
	//ajaxCall("/sendCM",$("#headerName").val(), $("#token").val(), JSON.stringify(sendMsg), "N");
	
	sendMsgRestful("/sendCM", $("#headerName").val(), $("#token").val(),"DIRECT", JSON.stringify(sendMsg), "N");
}
// 소프트폰 종료
function call_direct(){
	var telNo = $("#telNo").val();
	
	var sendMsg = { Event: "HANGUP", dialNo: telNo ,agentId: $("#OP_LOGIN_ID").val()};
	ajaxCall("/sendCM",$("#headerName").val(), $("#token").val(), JSON.stringify(sendMsg), "N");
	
	ws_agent.close();
	ws_agent = null;
	
	document.getElementById("call_direct").innerHTML = "소프트폰";
	$("#call_direct").attr("disabled", true);
}

/*******************************************************************************
 * bot 팝업창에 대한 웹소켓 에이전트
 ******************************************************************************/
// 소켓 연결 url: 연결주소 연결 요청메세지  STT ( 임시) 
//웹소켓 다중으로 여는거에 대한 이야기가 필요함
var agent_scoket_map={
		
}
function agentWs(url, sendMsg,agent_ws) {
	
	console.log("agentWs");
	console.log(sendMsg);
	agent_ws = new WebSocket(wss_url);
	
	agent_scoket_map[JSON.parse(sendMsg).Agent]=agent_ws;
	agent_ws.onopen = function() {
		agent_ws.send(sendMsg);
	};
	agent_ws.onmessage = function(e) {
		
		//wss
		if(e.data == "wss"){
			return;
		}
		
		var rcv_data = JSON.parse(e.data);
		console.log("STT====");
		console.log(rcv_data);
		if (rcv_data.EventType == 'STT') {//통화코드
			if (transferYN == 0 && rcv_data.Event == 'interim') {
				makeMsg(rcv_data);
			} else if(rcv_data.Event == 'stop') {

				//현재돌고있는 봇아니면 연결 안끊음
				if(rcv_data.Agent.length == 0) return;
				//if($("#rcv_data.Agent").length == 0) return;
				
				$("#chatCont").find( 'div.callView_tit').attr("name", "");
				//청취 , 상담개입 중이면 종료됨
				
				if(ws_agent != null){
					
//					chBtn("call_close");
					ws_agent.close();
					ws_agent = null;
				}

				agent_ws.close();
				
				//알람온상태이면 알람제거
				if($("#alarmAudio_"+rcv_data.Agent).length > 0 && $("#"+rcv_data.Agent+" > div").attr("class").match("alarm")){
					//알람떠있는 상태면 알람제거 + 소리끄고 처음으로
					fnAlarmCont(rcv_data.Agent, {type:"off", alarm:true, audio:true});
					//$("#"+obj.SIP_USER+" > div").removeClass("alarm");
					//document.getElementById("alarmAudio").load();
				}
				
			}
		} else if (transferYN == 0 && rcv_data.EventType == 'DETECT') {//체크값
			console.log("탐지 값 : " + rcv_data.Result)
			
	        inerHtml ="";
			
			if(rcv_data.contract_no == $("#CSDTL_CONTRACT_NO").val()){
		        if(rcv_data.Result != null && rcv_data.Result != "Y" && rcv_data.Result != "N") {
		        	inerHtml += "<span>"+rcv_data.Result+"</span> ";
		        }else if (rcv_data.Result == "Y"){
		        	inerHtml += "<span class='active'>YES</span> <span>NO</span> ";
		        }else if (rcv_data.Result == "N"){
		        	inerHtml += "<span>YES</span> <span class='active'>NO</span> ";
		        }
		        $("#"+rcv_data.No).html(inerHtml);
			}
	         
	      }
	};
}

/*******************************************************************************
 * 메인 채팅 창 ( 상단 오른쪽에 대한 채팅 값)
 ******************************************************************************/
function makeMsg(rcv_data) {
	if (rcv_data.Direction == 'TX') {//봇 --에이전트
		if(rcv_data.ignored == 'N' || rcv_data.IGNORED == 'N'){
			result ="<li class='bot'><div class='bot_msg'><em class='txt'>"+rcv_data.Text+"</em><div class='date'></div></div></li>";
		}else{
			result ="<li class='bot'><div class='bot_msg'><em class='txt ignored'>"+rcv_data.Text+"</em><div class='date'></div></div></li>";
		}
		$("#" + rcv_data.Agent).find('.lst_talk').append(result);
		$("#" + rcv_data.Agent).find( 'div.chatUI_mid' ).scrollTop($("#" + rcv_data.Agent).find( 'ul.lst_talk' ).height());
		if($("#chatCont.alarm").find( 'div.callView_tit' ).attr("name") == rcv_data.Agent){
			$("#chatCont.alarm").find( 'ul.lst_talk' ).append(result);
			$("#chatCont.alarm").find( 'div.chatUI_mid' ).scrollTop($("#chatCont").find( 'ul.lst_talk' ).height());   
		}
	} else if (rcv_data.Direction == 'RX') {//고객 --에이전트
		if(rcv_data.ignored == 'N' || rcv_data.IGNORED == 'N'){
			result ="<li class='user'><div class='bot_msg'><em class='txt'>"+rcv_data.Text+"</em><div class='date'></div></div></li>";
		}else{
			result ="<li class='user'><div class='bot_msg'><em class='txt ignored'>"+rcv_data.Text+"</em><div class='date'></div></div></li>";
		}
		$("#" + rcv_data.Agent).find('.lst_talk').append(result);
		$("#" + rcv_data.Agent).find( 'div.chatUI_mid' ).scrollTop($("#" + rcv_data.Agent).find( 'ul.lst_talk' ).height());   
		if($("#chatCont.alarm").find( 'div.callView_tit' ).attr("name") == rcv_data.Agent){
			$("#chatCont.alarm").find( 'ul.lst_talk' ).append(result);
			$("#chatCont.alarm").find( 'div.chatUI_mid' ).scrollTop($("#chatCont").find( 'ul.lst_talk' ).height());
		}
	}else if (rcv_data.SPEAKER_CODE == 'ST0002') {//봇 --DB데이터
		if(rcv_data.ignored == 'N' || rcv_data.IGNORED == 'N'){
			result ="<li class='bot'><div class='bot_msg'><em class='txt'>"+rcv_data.SENTENCE+"</em><div class='date'></div></div></li>";
		}else{
			result ="<li class='bot'><div class='bot_msg'><em class='txt ignored'>"+rcv_data.SENTENCE+"</em><div class='date'></div></div></li>";
		}
		$("#chatCont.alarm").find( 'ul.lst_talk' ).append(result);
		$("#chatCont.alarm").find( 'div.chatUI_mid' ).scrollTop($("#chatCont").find( 'ul.lst_talk' ).height());   
	} else if (rcv_data.SPEAKER_CODE == 'ST0001') {//고객 --DB데이터
		if(rcv_data.ignored == 'N' || rcv_data.IGNORED == 'N'){
			result ="<li class='user'><div class='bot_msg'><em class='txt'>"+rcv_data.SENTENCE+"</em><div class='date'></div></div></li>";
		}else{
			result ="<li class='user'><div class='bot_msg'><em class='txt ignored'>"+rcv_data.SENTENCE+"</em><div class='date'></div></div></li>";
		}
		$("#chatCont.alarm").find( 'ul.lst_talk' ).append(result);
		$("#chatCont.alarm").find( 'div.chatUI_mid' ).scrollTop($("#chatCont").find( 'ul.lst_talk' ).height());   
	}
	
}




/*******************************************************************************
 * 통화청취 ajax
 ******************************************************************************/
function sendMsgRestful(url,headerName,toke , type, sendMsgStr, event) {
        
	var mic_on = false;
	if(type == "TRANSFER" || type == "DIRECT"){
		mic_on = true;
	}
	
	var sendObj = JSON.parse(sendMsgStr);
	
	console.log("sendMsg : "+ sendMsgStr);

	   //var host = '10.122.64.152';
	   //var port = '5800';
	   var voiceUrl = $("#voiceUrl").val();
	   if(type == "TRANSFER"){
		   var dial_no = sendObj.dialNo;
		   var agent_id = sendObj.AgentId;
	   }else if(type == "DIRECT"){
		   var contract_no = sendObj.contractNo;
		   var campaign_id = sendObj.campaignId;
		   var agent_id = sendObj.agentId;
	   }else if(type == "LISTEN"){
		   var dial_no = sendObj.dialNo;
		   var agent_id = sendObj.AgentId;
	   }
	   
	   var audioQueue = [];
	   if (ws_agent != null) {
	      ws_agent.close();
	      ws_agent = null;
	   }
	   
	   ws_agent = new WebSocket(voiceUrl+"/callsocket");
	   
	   ws_agent.binaryType = 'arraybuffer';
	   var ws = ws_agent;

	   var trans_type = 'recv_only';
	   if (mic_on) {
	      if (navigator.getUserMedia){
	         trans_type = 'recv_send';
	         navigator.getUserMedia({audio:true},
	               function(stream) {
	        	 		
	        	 	  console.log("send_audio");
	        	 
	                  send_audio(ws, stream);
	               },
	               function(e) {
	                  alert('Error capturing audio.');
	               });
	      } else alert('getUserMedia not supported in this browser.');
	   }

	   var audioCtx = new (window.AudioContext || window.webkitAudioContext)({
	      sampleRate: 8000
	   });
	   var source = audioCtx.createBufferSource();
	   var scriptNode = audioCtx.createScriptProcessor(1024, 0, 1);
	   scriptNode.onaudioprocess = function(audioProcessingEvent) {
	      var outputBuffer = audioProcessingEvent.outputBuffer;
	      var outputData = outputBuffer.getChannelData(0);
	      //console.log("outputBuffer length is " + outputBuffer.length);
	      //console.log("audioQueue length is " + audioQueue.length);
	      if (audioQueue.length < (outputBuffer.length * 2) ) {
	    	 outputData.fill(0);
	         return;
	      }
	      for (var sample = 0; sample < outputBuffer.length; sample++) {
	         var hRawAudio = audioQueue.shift();
	         var lRawAudio = audioQueue.shift();
	         // For little endian
	         var unsignedWord = (hRawAudio & 0xff) + ((lRawAudio & 0xff) << 8);
	         // For big endian
	         //var unsignedWord = ((hRawAudio & 0xff) << 8) + (lRawAudio & 0xff);
	         var signedWord = (unsignedWord + 32768) % 65536 - 32768;
	         outputData[sample] = signedWord / 32768.0;
	      }
	   }

	   if (ws_agent) {
	      ws.onopen = function () {
	         console.log("Connection is established...");
	         source.connect(scriptNode);
	         scriptNode.connect(audioCtx.destination);
	         source.start();
	         //wss
	         /*
	         var msg = {
	 	            "opcode": "REGISTER",
	 	            "system_type" : "PC_AGENT",
	 	            "dial_no": dial_no,
	 	            "trans_type": trans_type,
	 	            "agent_id": agent_id
	 	     };
	         */
	         if(type == "TRANSFER"){
	        	 var msg = {
	        			 "opcode": "REGISTER",
	        			 "system_type" : "PC_AGENT",
	        			 "dial_no": dial_no,
	        			 "trans_type": trans_type,
	        			 "agent_id": agent_id
	        	 };
	         }else if(type == "DIRECT") {
	        	 var msg = {
	        			 "opcode": "REGISTER",
	        			 "system_type" : "PC_AGENT",
	        			 "contract_no": contract_no,
	        			 "campaign_id": campaign_id,
	        			 "trans_type": trans_type,
	        			 "agent_id": agent_id,
	        	 };
	         }else if(type == "LISTEN") {
	        	 var msg = {
	        			 "opcode": "REGISTER",
	        			 "system_type" : "PC_AGENT",
	        			 "dial_no": dial_no,
	        			 "trans_type": trans_type,
	        			 "agent_id": agent_id
	        	 };
	         }
	         
	         var data = JSON.stringify(msg);
	         
	         ws.send(data);
	         
	         $.ajax({
	 	        url: "sendCM",
	 	        data: sendMsgStr,
	 	        method : 'POST',
	 	        contentType : "application/json; charset=utf-8",
	 	        async:false,
	 	        beforeSend: function (xhr) {
	 				xhr.setRequestHeader("X-XSRF-TOKEN",token.value);
	 	        }
	 	    }).done(function (data) {
	 	        console.log("### SUCC : " + data);
	 	    }).fail(function (data) {
	 	        console.log("### FAIL : " + data);
	 	    });
	         console.log("send REGISTER (" + trans_type + ")");
	      };

	      ws.onmessage = function (evt) {
	    	  
	    	  if(evt.data == "wss"){
	    		  return;
	    	  }
	    	  
	    	  //console.log("wss audio");
	    	  //console.log(evt.data);
	    	  
	         var received_msg = new Uint8Array(evt.data); // firefox에서 동작
	         console.log("Message is received... " + received_msg.length);
	         // audioQueue.push(received_msg);
	         for (var i = 0; i < received_msg.length; i++) {
	            //console.log("push audio samples");
	            audioQueue.push(received_msg[i]);
	         }
	         // console.log("Queue is received... " + audioQueue.length);
	      };

	      ws.onclose = function () {
	         try {
	            source.disconnect(scriptNode);
	            scriptNode.disconnect(audioCtx.destination);
	            if (mic_on) {
	               console.log("Disconnect mic");
	               microphone_stream.disconnect(micScriptNode);
	               micScriptNode.disconnect(micAudioCtx.destination);
	               voice_stream.getTracks()[0].stop();
	            }
	         }
	         catch (e) {
	            console.log(e);
	         }
	         console.log("Connection is closed...");
	      };
	   } else {

	      // The browser doesn't support WebSocket
	      alert("WebSocket NOT supported by your Browser!");
	   }
	
	   
	   
    }
/*
 * 아웃바운드 autocall
 */


/**
 * 청취 / 개입 관련 함수
 */

function stopAudioStream() {
	   if (ws_agent) {
	      ws_agent.close();
	   }
	}

	function floatTo16BitPCM(input) {
	   var output = new DataView(new ArrayBuffer(input.length * 2));
	   for (var i = 0; i < input.length; i++) {
	      var multiplier = input[i] < 0 ? 0x8000 : 0x7fff; // 16-bit signed range is -32768 to 32767
	      output.setInt16(i * 2, input[i] * multiplier | 0, true); // index, value, little edian
	   }
	   return output.buffer;
	}

	function send_audio(ws, stream /* from getUserMedia */) {
	   voice_stream = stream;
	   //var micAudioCtx = new (window.AudioContext || window.webkitAudioContext)({
	   micAudioCtx = new (window.AudioContext || window.webkitAudioContext)({
	      sampleRate: 8000
	   });

	   microphone_stream = micAudioCtx.createMediaStreamSource(stream);

	   // Create a ScriptProcessorNode with a bufferSize of 4096 and a single input and output channel
	   //var scriptNode = micAudioCtx.createScriptProcessor(1024, 1, 1);
	   micScriptNode = micAudioCtx.createScriptProcessor(1024, 1, 1);
	   // Give the node a function to process audio events
	   micScriptNode.onaudioprocess = function (audioProcessingEvent) {
	      // The input buffer is the song we loaded earlier
	      var inputBuffer = audioProcessingEvent.inputBuffer;
	      var inputData = inputBuffer.getChannelData(0);
	      var sendBuffer = floatTo16BitPCM(inputData);
	      ws.send(sendBuffer);
	      
	   }
	   microphone_stream.connect(micScriptNode);
	   micScriptNode.connect(micAudioCtx.destination);
	}

/**
 * 청취 / 개입 관련 함수 end
 */

/*******************************************************************************
 * ajax 호출 
 ******************************************************************************/
//ajax호출 
function ajaxCall(url,headerName,token, data, types) {
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
			resultProcess(result,data);
		}).fail(function(result) {
		});
}
/*******************************************************************************
 * ajax호출 값에 대한 처리
 ******************************************************************************/
function resultProcess(result,data) {
	
	console.log("asdf");
	console.log(result);
	
	var obj;
	var cateObj;
	
	var cheCateYn = false;//카테고리 변경 flag
	var setUserEdt = false;//고객정보 변경 flag
	
	if(valueChk(result.ReqParam)){
		cheCateYn = JSON.parse(result.ReqParam).TYPE;
	}
	
	if(valueChk(result.setUserEdt)){
		setUserEdt = result.setUserEdt;
	}
	
	console.log("setUserEdt:"+setUserEdt);
	var lang = $.cookie("lang");
	if(cheCateYn){
		//상담유형대중소 변경시 ////
		if(valueChk(result.consultingTypeList) && cheCateYn){
			
			obj = JSON.parse(result.consultingTypeList);
			
				var reqData = JSON.parse(data);
				inerHtml="";//초기화
				if(valueChk(reqData.UPJQID)){
					//선택한 셀렉트 박스 다음 형제 셀렉트박스요소 모두 초기화 reqData.UPJQID.charAt(reqData.UPJQID.length-1)
					$("#"+reqData.UPJQID).nextAll().find('option:not(:first)').remove();
				}else{
					//카테고리 모든 셀렉트박스 초기화
					$("select[id^='cst']").find('option:not(:first)').remove();
				}
				//	if(obj.UPCODE !="999" || $(this).attr('id').charAt($(this).attr('id').length-1)=="1")
				
			if(obj.length > 0){
				$.each(obj, function(key, value){
					if(lang == 'ko' || !lang){
            			inerHtml += "<option value="+value.CODE+">"+value.CODE_NM+"</option>";
					}else if(lang == 'en'){
						inerHtml += "<option value="+value.CODE+">"+value.CODE_NM_ENG+"</option>";
					}
				});
				if(valueChk(reqData.UPJQID)){
					if(reqData.UPCODE !="999")
						$("#"+reqData.UPJQID).next().append(inerHtml);
				}else{
					$("select[id^='cst'][id$='_1']").append(inerHtml);
				}
			}
		}
	}
//	else if(setUserEdt){
//		//유저정보 저장
//		
//	}
	else{
		if(result.type == "update" || result.type == "insert") {
			alert(getLocaleMsg("A0012", "등록이 완료되었습니다."));
			hidePopup('ib_infoLayer');
		}
		
		if(result.type == "update"){
			$(".btnS_basic.btn_userInfoModify.btn_lyr_open").first().removeAttr("disabled");
		}
		//상담유형 변경 제외 refresh
		
		//최초 클릭했을때 상담내용 저장용 데이터 삽입
		if($("#csType").val() =="IB"){
			//고객 상담정보 단건 이제 안들고옴 > 상담내용 저장용 데이터
			$("#CSDTL_CONTRACT_NO").val(result.CONTRACT_NO);
			$("#CSDTL_CALL_ID").val(result.CALL_ID);//상담내용 저장용
			$("#CSDTL_CAMPAIGN_ID").val(result.CAMPAIGN_ID);//상담내용 저장용
		}
		
		//고객정보/////
		if(valueChk(result.userInfoList)){
			//상담 내용 disabled 해제(I/B 상담화면)
			if($("#csType").val() == "IB"){
		    	$("#cst1_1").attr("disabled", false);
		    	$("#cst1_2").attr("disabled", false);
		    	$("#cst1_3").attr("disabled", false);
		    	$("#cst2_1").attr("disabled", false);
		    	$("#cst2_2").attr("disabled", false);
		    	$("#cst2_3").attr("disabled", false);
		    	$("#cst3_1").attr("disabled", false);
		    	$("#cst3_2").attr("disabled", false);
		    	$("#cst3_3").attr("disabled", false);
		    	$("#CSDTL_CALL_MEMO").attr("disabled", false);
		    	$("#CSDTL_RECALL_TEL_NO").attr("disabled", false);
		    	$("#CSDTL_RECALL_DATE").attr("disabled", false);
		    	$("#CSDTL_NEW_CUST_OP_ID").attr("disabled", false);
		    	$("#CSDTL_NEW_CUST_OP_EMAIL").attr("disabled", false);
		    	$("#sb_commCd12").attr("disabled", false);
			}
			if($("#csType").val() == "OB"){
			   // O/B상담화면 고객정보 disabled 해제
			   $("#updateUserInfo").attr("disabled", false);
			   $("#saveCsDtl").attr("disabled", false);
			   $("#dial_status").attr("disabled", false);
			   $("#mnt_status").attr("disabled", false);
			   $("#ob_memo").attr("disabled", false);
			   $("#CSDTL_RECALL_TEL_NO").attr("disabled", false);
			   $("#CSDTL_RECALL_DATE").attr("disabled", false);
			   $("#dbListCustId").val(JSON.parse(result.userInfoList)[0].CUST_ID);
			   $("#dbListTelNo").val(JSON.parse(result.userInfoList)[0].CUST_TEL_NO);
			}
	    	
			$("#CSDTL_CONTRACT_NO").val(result.CONTRACT_NO);
			
			obj = JSON.parse(result.userInfoList);
			if(obj.length > 0){
				
				$.each(obj[0], function(key, value){
					if(key=="CUST_TYPE"){//라디오
						$("input:radio[name=\'user_ipt_radio\']:radio[value="+value+"]").prop('checked', true); // 
						$("input:radio[name=\'USEREDT_ipt_radio\']:radio[value="+value+"]").prop('checked', true); // 
						if($("#csType").val() =="OB"){
							$("input:radio[name='ipt_radio_OB']:radio[value="+value+"]").prop('checked', true); //
						}
					}else{
//						_NO
						if(key=="CUST_HOME_NO" || key=="CUST_TEL_NO" || key=="CUST_COMPANY_NO"){
							if($.isNumeric(value) && value.toString().length > 8){//폰번호 하이픈
								value =telNumHyphen(value);
							}
						}
						$(".USER_"+key).html(value);
						$("#USEREDT_"+key).val(value);
							
						if($("#csType").val() =="OB"){
								$(".USER_"+key).html(value);
								$("#OB_USEREDT_"+key).val(value);
							}
				
						console.log("key : " + key);
						console.log("value : " + value);
					}
				});
			}else{
				//고객정보 없는경우 > 추후작업
				$(".USER_CUST_TEL_NO").text(result.TEL_NO);
			}
		}
		
		//고객 결제정보////
		if(valueChk(result.userPaymentList)){
			obj = JSON.parse(result.userPaymentList);
			if(obj.length > 0){
				$.each(obj[0], function(key, value){
					if($.isNumeric(value)){
						value =numberFormat(value);
					}
					$(".PAY_"+key).html(value);
					$("#PAYEDT_"+key).val(value);
					if($("#csType").val() =="OB"){
						$(".PAY_"+key).html(value);
						$("#OB_PAYEDT_"+key).val(value);
					}
				});
			}
		}
		
		//고객정보없거나 고객정보 있어도 상담내용 없어도 상담유형은 뿌려줘야함. > 상담한 기록이 있더라도 상담내용은 공백으로.. 상담유형만 나오게
		if($("#csType").val() =="IB" && valueChk(result.consultingTypeList)){
			cateObj = JSON.parse(result.consultingTypeList);
			//debugger;
			if(cateObj.length > 0){
				inerHtml = "";
				$.each(cateObj, function(catekey, catevalue){
					if(catevalue.CODE.length == 2){//대분류
						if(lang == 'ko' || !lang){
            		   		inerHtml += "<option value="+catevalue.CODE+">"+catevalue.CODE_NM+"</option>";
            	   		}else if(lang == 'en'){
            		   		inerHtml += "<option value="+catevalue.CODE+">"+catevalue.CODE_NM_ENG+"</option>";
				   		}
					}
				});
				$.each($("select[id^='cst'][id$='_1']"), function(i, v){
					$("#"+v.id).append(inerHtml);
				});
				inerHtml = "";
			}
		}
		
		/*
		//고객  상담내용 정보//// > 있어도 안뿌려줌
		if(valueChk(result.userCsDtlList)){
			
			console.log("dsaffdsafdsafdsafdsaDfsadfsafdsafdsafasd?");
			
			obj = JSON.parse(result.userCsDtlList);
			
			if(obj.length > 0){
				
				$.each(obj[0], function(key, value){
					
					if(key=="IMPORTANCE_LEVEL"){//긴급도 레벨
						$("#sb_commCd12 option[value="+value+"]").attr('selected','selected');
					}else if(key.indexOf('CONSULT_TYPE') > -1 && $("#csType").val() =="IB" && value != "999"){//카테고리값
					
						cateObj = JSON.parse(result.consultingTypeList);
						//debugger;
						if(cateObj.length > 0){
							inerHtml = "";
							$.each(cateObj, function(catekey, catevalue){
								
								if(value.substr(0,value.length-2) ==catevalue.UPCODE ){
									inerHtml += "<option value="+catevalue.CODE+">"+catevalue.CODE_NM+"</option>";
								}else if(isEmpty(value.substr(0,value.length-2))&& catevalue.CAMPAIGN_ID ==catevalue.UPCODE ){
									inerHtml += "<option value="+catevalue.CODE+">"+catevalue.CODE_NM+"</option>";
								}else if(value.length == 2 && catevalue.CODE.length == 2){//대분류
									inerHtml += "<option value="+catevalue.CODE+">"+catevalue.CODE_NM+"</option>";
								}
								
							});
						}
					
						$("#cst"+key.substr("CONSULT_TYPE".length,1)+"_"+key.substr(key.length-1)).append(inerHtml);
						$("#cst"+key.substr("CONSULT_TYPE".length,1)+"_"+key.substr(key.length-1)+" option[value="+value+"]").attr('selected','selected');
						
					}else{
						
						if($.isNumeric(value) && value.toString().length > 8){//폰번호 하이픈
							value =telNumHyphen(value);
						}
						
						$("#CSDTL_"+key).val(value);
					}
					
				});
				
				if($("#csType").val() =="IB"){
					//카테고리 선택값이 없을때 대메뉴
					
					var chk=true;
					for ( var i in Object.keys(obj[0])) {
						if( Object.keys(obj[0])[i].indexOf('CONSULT_TYPE') == 0 )		chk=false;
					}
					inerHtml ="";
					if(chk){
						
						inerHtml ="";
						cateObj = JSON.parse(result.consultingTypeList);
						$.each(cateObj, function(catekey, catevalue){
							if(catevalue.CAMPAIGN_ID ==catevalue.UPCODE ){
								inerHtml += "<option value="+catevalue.CODE+">"+catevalue.CODE_NM+"</option>";
							}
						});
					}
					$("select[id^='cst'][id$='_1']").append(inerHtml);
					//카테고리 선택값이 없을때 대메뉴 end 언제사용됨??? 확인
					
					//상담유형 > 코드값 존재하면 들어가 있는 상태
					$.each($("select[id^='cst'][id$='_1']"), function(idx, code){
						cateObj = JSON.parse(result.consultingTypeList);
						inerHtml = "";
						//대분류가 정해져 있는 상태
						if(code.value != "999"){
							//대분류에따라 중분류, 소분류에 들어갈 값 만들어줌
							$.each($("select[id^='"+code.id.substr(0, code.id.length-2)+"']"), function(idx, code){
								if($("#"+code.id).val() == "999"){
									$.each(cateObj, function(catekey, catevalue){
										inerHtml = "";
										if(catevalue.UPCODE == $("#"+code.id.substr(0, code.id.length-1)+idx).val()){
											inerHtml += "<option value="+catevalue.CODE+">"+catevalue.CODE_NM+"</option>";
										}
										$("#"+code.id).append(inerHtml);
									});
								}
							});
						}else{
							$.each(cateObj, function(catekey, catevalue){
								if(catevalue.CODE.length == 2){
									inerHtml += "<option value="+catevalue.CODE+">"+catevalue.CODE_NM+"</option>";
								}
							});
							$("#"+code.id).append(inerHtml);
						}
					});
					//상담유형 > 코드값 존재하면 들어가 있는 상태 end

					
				}
			}else{
				//고객정보없거나 고객정보 있어도 상담내용 없어도 상담유형은 뿌려줘야함.
				if($("#csType").val() =="IB" && valueChk(result.consultingTypeList)){
					
					if(valueChk(result.CAMPAIGN_ID)){
						$("#CSDTL_CAMPAIGN_ID").val(result.CAMPAIGN_ID);
					}
					
					cateObj = JSON.parse(result.consultingTypeList);
					//debugger;
					if(cateObj.length > 0){
						inerHtml = "";
						$.each(cateObj, function(catekey, catevalue){
							if(catevalue.CODE.length == 2){//대분류
								inerHtml += "<option value="+catevalue.CODE+">"+catevalue.CODE_NM+"</option>";
							}
						});
						$.each($("select[id^='cst'][id$='_1']"), function(i, v){
							$("#"+v.id).append(inerHtml);
						});
						inerHtml = "";
					}
				}
				
			}
		}else{
			
			//고객정보없거나 고객정보 있어도 상담내용 없어도 상담유형은 뿌려줘야함.
			if($("#csType").val() =="IB" && valueChk(result.consultingTypeList)){
				cateObj = JSON.parse(result.consultingTypeList);
				//debugger;
				if(cateObj.length > 0){
					inerHtml = "";
					$.each(cateObj, function(catekey, catevalue){
						if(catevalue.CODE.length == 2){//대분류
							inerHtml += "<option value="+catevalue.CODE+">"+catevalue.CODE_NM+"</option>";
						}
					});
					$.each($("select[id^='cst'][id$='_1']"), function(i, v){
						$("#"+v.id).append(inerHtml);
					});
					inerHtml = "";
				}
			}
			
		}
		*/
		
		
		//채팅정보////
		if(valueChk(result.userChatList)){
			obj = JSON.parse(result.userChatList);
			$("#chatCont").find( 'ul.lst_talk' ).empty();   
			if(obj.length > 0){
				$.each(obj, function(key, value){
					makeMsg(value);
				});
			}
		}
		
		/*
		//탐지정보////
		if(valueChk(result.userCampSList)){
			obj = JSON.parse(result.userCampSList);
			if(obj.length > 0){
				 inerHtml ="";
				$.each(obj, function(index, value){
					inerHtml += "<tr><td scope='row'>"+index+"</td>";
					inerHtml += "<td>"+value.TASK_INFO+"</td>";
					inerHtml += "<td><div class='detectBox' id='"+value.INFO_SEQ+"'>";
					if(value.TASK_VALUE =="Y") inerHtml += "<span class='active'>YES</span> <span>NO</span> ";
					//else if(value.TASK_VALUE =="N") inerHtml += "<span>YES</span> <span class='active'>NO</span> <span>없음</span>";
					//else inerHtml += "<span>YES</span> <span>NO</span> <span  class='active'>없음</span>";
					else  inerHtml += "<span>YES</span> <span class='active'>NO</span> ";
					//1차적으로 3단계로 작업 원래는 Y이거나 그외 N으로 작업이야기가 있었음
					inerHtml +="</div></td></tr>";
				});
				$("#chatCont").find( 'tbody.score_tbody' ).empty();
				$("#chatCont").find( 'tbody.score_tbody' ).append(inerHtml);
			}
		}
		*/
		
		if(valueChk(result.mntResult)){
			
			inerHtml ="";
			obj = JSON.parse(result.mntResult);//result.userCampSList
			
			if(obj.length > 0){
				var inner_obj = null;
				if(valueChk(result.userCampSList)){
					inner_obj = JSON.parse(result.userCampSList);
				}
				
				$.each(obj, function(i, v){
					console.log("taskType : " + v.taskType);
						inerHtml += "<tr><td scope='row'>"+v.seq+"</td>";
						inerHtml += "<td>"+v.taskInfo+"</td>";
						inerHtml += "<td id="+v.campaignId+"_"+v.task+"><div class='detectBox' id='"+v.seq+"'>";
		               if(v.taskType == "V"){
		                  inerHtml += "<span id="+v.campaignId+"_"+v.task+"></span> ";
		               }else if(v.taskType == "C"){
		                  inerHtml += "<span>YES</span> <span>NO</span>";
		                  //1차적으로 3단계로 작업 원래는 Y이거나 그외 N으로 작업이야기가 있었음
		               }
		               inerHtml +="</div></td></tr>";
		            });
		            
		            $("#chatCont").find( 'tbody.score_tbody' ).empty();
		            $("#chatCont").find( 'tbody.score_tbody' ).append(inerHtml);
		            
		            if(inner_obj != null && inner_obj.length > 0){//저장된 캠페인 스코어 존재
		               $.each(inner_obj, function(j, jv){
		                  //캠페인 스코어가 존재하면 Y이든 N이든 하나는 돌려줘야함
		                  //현재 캠페인의 테스크가 Y이면 YES active 
		                  //$("#"+jv.CAMPAIGN_ID+"_"+jv.INFO_TASK+" > div").empty();//agentClick시 응대화면 refresh > 추후 바뀌면 id 설정하는데 call_id나 contarctno세팅
		                  if(jv.TASK_VALUE != null && jv.TASK_VALUE != "Y" && jv.TASK_VALUE != "N"){
		                     $("#"+jv.CAMPAIGN_ID+"_"+jv.INFO_TASK+" > div").html("<span>"+jv.TASK_VALUE+"</span> ");
		                  }else if (jv.TASK_VALUE == "Y"){
		                     $("#"+jv.CAMPAIGN_ID+"_"+jv.INFO_TASK+" > div").html("<span class='active'>YES</span> <span>NO</span> ");
		                  }else if (jv.TASK_VALUE == "N"){
		                     $("#"+jv.CAMPAIGN_ID+"_"+jv.INFO_TASK+" > div").html("<span>YES</span> <span class='active'>NO</span> ");
		                  }
		               });
		            }
		            /*else{
						inerHtml += "<span>YES</span> <span class='active'>NO</span> ";
					}*/
				
				/*if(inner_obj != null && inner_obj.length > 0){//저장된 캠페인 스코어 존재
					$.each(inner_obj, function(j, jv){
						//캠페인 스코어가 존재하면 Y이든 N이든 하나는 돌려줘야함
						//현재 캠페인의 테스크가 Y이면 YES active 
						if(jv.TASK_VALUE =='Y'){
							$("#"+jv.CAMPAIGN_ID+"_"+jv.INFO_TASK+" > div").empty();//agentClick시 응대화면 refresh > 추후 바뀌면 id 설정하는데 call_id나 contarctno세팅
							$("#"+jv.CAMPAIGN_ID+"_"+jv.INFO_TASK+" > div").append("<span class='active'>YES</span> <span>NO</span> ");
						}
					});
				}else{
					inerHtml += "<span>YES</span> <span class='active'>NO</span> ";
				}*/
			}
		}
		
		
		
		
		//탐지정보////추후 되는거 보고 반영
		/*if(valueChk(result.mntResult)){
			
			if(obj.length == 0){
				inerHtml ="";
				obj = JSON.parse(result.mntResult);//result.userCampSList
				$.each(obj, function(i, v){
					inerHtml += "<tr><td scope='row'>"+i+"</td>";
					inerHtml += "<td>"+v.taskInfo+"</td>";
					inerHtml += "<td><div class='detectBox' id='"+v.seq+"'>";
					//if(value.TASK_VALUE =="Y") inerHtml += "<span class='active'>YES</span> <span>NO</span> ";
					else if(value.TASK_VALUE =="N") inerHtml += "<span>YES</span> <span class='active'>NO</span> <span>없음</span>";
					else inerHtml += "<span>YES</span> <span>NO</span> <span  class='active'>없음</span>";
					//else 
					inerHtml += "<span>YES</span> <span class='active'>NO</span> ";
					//1차적으로 3단계로 작업 원래는 Y이거나 그외 N으로 작업이야기가 있었음
					inerHtml +="</div></td></tr>";
				});
				$("#chatCont").find( 'tbody.score_tbody' ).empty();
				$("#chatCont").find( 'tbody.score_tbody' ).append(inerHtml);
			}
			
			
		}*/
		
		//상담이력정보조회(사이드)////
		$("#csHisCont").find( 'tbody.csHis_tbody' ).empty();
		if(valueChk(result.csHisList)){
			obj = JSON.parse(result.csHisList);
			if(obj.length > 0){
				 inerHtml ="";
				$.each(obj, function(key, value){
					//상담이력
					console.log("key : " + key);
					console.log("value : " + JSON.stringify(value));
					inerHtml +="<tr>";
					inerHtml +="<td scope='row'>"+value.START_TIME+"</td>";
					inerHtml +="<td nowrap>"+value.DURATION+"</td>";
					inerHtml +="<td>"+value.CALL_TYPE_NM+"</td>";
					if(value.CALL_TYPE_NM == "I/B"){
						inerHtml +="<td>"+value.CONSULT_TYPE1_DEPTH1_NM+"</td>";
						inerHtml +="<td>"+value.CONSULT_TYPE2_DEPTH1_NM+"</td>";
						inerHtml +="<td>"+value.CONSULT_TYPE3_DEPTH1_NM+"</td>";
						inerHtml +="<td>"+value.CD_DESC+"</td>";
						inerHtml +="<td>"+value.SIP_USER+"</td>";
					}
					if(value.CALL_TYPE_NM == "O/B"){
						if(lang == "en"){
							inerHtml +="<td nowrap>"+value.CD_DESC_ENG+"</td>";
							inerHtml +="<td nowrap>"+value.MNT_STATUS_NAME_ENG+"</td>";
						}else{
							inerHtml +="<td nowrap>"+value.CD_DESC+"</td>";
							inerHtml +="<td nowrap>"+value.MNT_STATUS_NAME+"</td>";
						}
					}
					//inerHtml +="<td>"+value.CONSULT_TYPE3_DEPTH1_NM+"</td>";
					/*inerHtml +="<td>-</td>";*/
					inerHtml +="<td>"+value.CUST_OP_ID+"</td>";
					inerHtml +="</tr>";
					//상담내역
					$(".CSHIS_"+key).html(value);
				});
				$("#csHisCont").find( 'tbody.csHis_tbody' ).append(inerHtml);
			}else{
				inerHtml ="<td scope='row' class='al_c' colspan='9'>"+getLocaleMsg("A0005", "등록된 데이터가 없습니다.")+"</td>";
				$("#csHisCont").find( 'tbody.csHis_tbody' ).append(inerHtml);
			}
		}else{
			inerHtml ="<td scope='row' class='al_c' colspan='9'>"+getLocaleMsg("A0005", "등록된 데이터가 없습니다.")+"</td>";
			$("#csHisCont").find( 'tbody.csHis_tbody' ).append(inerHtml);
		}
		//OB고객정보 >> OB결과&재통화
		if(valueChk(result.userObResultRecall)){
			obj = JSON.parse(result.userObResultRecall);
			if(obj.length > 0){
				$.each(obj, function(key, value){
					if(value.callTypeNm == "O/B"){
						//시도결과
						$("#dial_status option[value="+value.dialResult+"]").prop("selected", "selected");
						//상담메모
						$("#mnt_status option[value="+value.mntStatus+"]").prop("selected", "selected");
						//상담메모
						$("#ob_memo").val(value.callMemo);
						//예약 연락처
						$("#CSDTL_RECALL_TEL_NO").val(value.recallTelNo);
						//예약일시
						$("#CSDTL_RECALL_DATE").val(value.recallDate);
					}
				});
			}
		}
		// IbOP상태정보////
		if(valueChk(result.opIbStateTotal)){
			initTextParsing(result.opIbStateTotal);
		}
		// obOP상태정보total////
		if(valueChk(result.opTotalObStateList)){
			initTextParsing(result.opTotalObStateList);
		}
		// obOP상태정보user////
		if(valueChk(result.opUserObStateList)){
			initTextParsing(result.opUserObStateList);
		}
		
		//상담유형 변경 제외 refresh end
	}
	
	
}

/*******************************************************************************
 * null 값 체크 리턴   없는값이면 false   값이 있으면 true
 ******************************************************************************/
function valueChk(data) {
	if(typeof data != "undefined" &&  data != null &&  data != ""){
		return true;
	}else{
		return false;
	}
}

/*******************************************************************************
 * 상위 상태바 파싱 현재 IB 작업완료
 ******************************************************************************/	
function initTextParsing(obj){
	var data = JSON.parse(obj);
	var userIdTxt = "";//하단 아이디
	var userNmTxt = "";//하단 아이디
	
	if(data.length > 0){
		$.each(data[0], function(key, value){
			if(key =="CUST_OP_STATUS"){
				$(".groupBox.bg_none" ).find("button").removeClass("active");
				$(".groupBox.bg_none" ).find("button:input[value="+value+"]").addClass("active");
			}else if(key == "CHAT_CONSULT_STATUS"){
				$(".groupBox.chat_bg" ).find("button").removeClass("active");
				$(".groupBox.chat_bg" ).find("button:input[value="+value+"]").addClass("active");
			}else if(key =="OP_LOGIN_ID"){
				$("#OP_LOGIN_ID").val(value);
				userIdTxt = value; 
			}else if(key == "OP_USER_NM"){
				userNmTxt = value;
			}else{
				$("#"+key).html(value);
			}
		});
		
		if($("#userIdForEdit").val() == "" || $("#userIdForEdit").val() == null){
			$("#userIdForEdit").val(userIdTxt);
			$("#userNameForEdit").val(userNmTxt);
		}
		
		userIdTxt = userNmTxt+"("+userIdTxt+")";
		$("#loginUserTxt").text(userIdTxt);
		
	}
}

/*******************************************************************************
 * 문자열이 빈 문자열인지 체크하여 결과값을 리턴한다.
 * @param str       : 체크할 문자열
 ******************************************************************************/	
function isEmpty(str){
    if(typeof str == "undefined" || str == null || str == "")
        return true;
    else
        return false ;
}

/*******************************************************************************
 * 전화번호 - 삽입
 * @param num       : 체크할 문자열
 ******************************************************************************/	
function telNumHyphen(num) {
	   return num.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
	}


/*******************************************************************************
 * 3자리 콤마
 * @param str       : 체크할 문자열
 ******************************************************************************/	
function numberFormat(inputNumber) {
	   return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

/*******************************************************************************
 * 이메일 형식 체크 * *
 * @param str       : 체크할 문자열
 ******************************************************************************/	
/**
 * * 이메일 형식 체크 * *
 * 
 * @param 데이터
 */
function emailCheck(email) {
	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	if (exptext.test(email) == false) { // 이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우
		alert(getLocaleMsg("", "이메일형식이 올바르지 않습니다."));
		return false;
	}
	return true;
}

//값초기화
function initSet(){
	$("#chatCont").find( 'div.callView_tit >h3' ).empty();
	$("#chatCont").find( 'ul.lst_talk' ).empty();   
	$("#chatCont").find( 'tbody.score_tbody' ).empty();
	$("select[id^='cst']").find('option:not(:first)').remove();
	$('#CSDTL_TABLE input').val("");
	$('#USER_TABLE input:not(input[type=radio])').val(""); //obput
	$('#CSDTL_TABLE textarea').val(result.exampleMessage);
	$('.USER_TABLE_DEL').empty();
	$("#sb_commCd12").val("99");
	//OB결과 selectBox 초기화
	$("#dial_status").val("999");
	$("#mnt_status").val("999");
	$('#UserEdtForm').each(function(){
	    this.reset();
	  });
	$('.callDetail .callView .callView_tit span.call_state').text('통화중');
}
/**
 * * 특수문자제거
 * 
 * @param 데이터
 */
function ScRemov(str) {
	var exptext = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>\#$%&\\\=\(\'\"]/gi; //@ 제외 특수문자
	if (exptext.test(str)) { // 
		str = str.replace(exptext, "");
	}
	return str;
}


function ckEditPw(pw){ // 비밀번호 대소문자, 숫자포함 8~20
	var re = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,20}$/
	return re.test(pw);
}

function ckEditPw2(pw){ // 비밀번호에 생일 관련 숫자가 존재하지 않아야 함
	var re = /^.*((0[1-9])|(1[0-2]))((0[0-9])|([1-2][0-9])|(3[01])).*$/
	return re.test(pw);
}

function ckEditPw3(pw){ // 연속된 같은 숫자
	var re = /^.*(00|11|22|33|44|55|66|77|88|99).*$/
	return re.test(pw);
}

function ckEditPw4(pw){ // 올라가거나 내려가는 연속된 3개 숫자
	var re = /^.*(012|123|234|345|456|567|678|789|890|098|987|876|765|654|543|432|321|210).*$/
	return re.test(pw);
}




//form obj 만들기 name value
//jQuery.fn.serializeObject = function() {
function serializeObject(formId) {
	var obj = null;
	try {
		if ($("#" + formId)[0].tagName
				&& $("#" + formId)[0].tagName.toUpperCase() == "FORM") {
			var arr = $("#" + formId).serializeArray();
			if (arr) {
				obj = {};
				jQuery.each(arr, function() {
					obj[this.name] = this.value;
				});
			}
		}
	} catch (e) {
		alert(e.message);
	} finally {
	}
	return obj;
}

/*
 * 콜청취 / 상담개입 버튼
 */

function chBtn(id){
	
	var onOffVal = true;
	
	if(id != "call_close"){
		//상담개입 or 청취
		$("#call_end").attr("disabled", false);
		/*$("#"+id).attr("disabled", true);
		$("#"+id).css("background-color", "green");
		$("#"+id).css("color", "black");*/
		
		if(id == "call_change_op"){
			if($("#consultantType").val() == "true"){
				$("#call_change").attr("class", "btnS_primary");
				$("#call_change").attr("disabled", true);
			}
		}else{
			$("#"+id).attr("class", "btnS_primary");
			$("#"+id).attr("disabled", true);
		}
		
		if(id == "call_listen" && $("#call_change").attr("disabled") == "disabled"){
			//상담개입 > 청취
			$("#consultantType").val("false");
			//$("#call_change_op").attr("style", "");
			$("#call_change").attr("class", "btnS_basic");
			$("#call_change").attr("disabled", false);
			onOffVal = false;
		}else if(id == "call_change_op" && $("#call_listen").attr("disabled") == "disabled"){
			//청취 > 상담개입
			$("#consultantType").val("true");
			//$("#call_listen").attr("style", "");
			$("#call_listen").attr("class", "btnS_basic");
			$("#call_listen").removeAttr("disabled");
			onOffVal = false;
		}
		
	}else{
		
		console.log("in close btn");
		
		//종료, init
		$("#StpAutoCall").attr("class", "btnS_basic");
		$("#StpAutoCall").attr("disabled", false);
		$("#call_listen").attr("class", "btnS_basic");
		$("#call_listen").attr("disabled", false);
		if($("#consultantType").val() == "false"){
			$("#call_change").attr("class", "btnS_basic");
			$("#call_change").attr("disabled", false);
		}
		
//		$("#call_end").attr("disabled", true);
	}
	
	return onOffVal;
}


/*
 * alert 생성
 */

function alertInit(msg, type, isFn){
	
	console.log(msg);
	
	var defType = "alertEndDef";
	var alertHtml = "";
	
	if(type != "" && type != null){
		defType = type;
	}
	
	if(isFn == "isFn"){
		alertHtml += '<button class="btn_lyr_close" onclick="'+defType+'">'+getLocaleMsg("A0003", "확인")+'</button>';
		alertHtml += '<button class="btn_lyr_close">'+getLocaleMsg("A0004", "취소")+'</button>';
//		alertHtml += '<button class="btn_lyr_close" onclick="'+defType+'">'+getLocaleMsg("A0004", "취소")+'</button>';
	}else if (isFn == "onlyCheckFn") {
		alertHtml += '<button class="btn_lyr_close" onclick="'+defType+'">'+getLocaleMsg("A0003", "확인")+'</button>';
		alertHtml += '<button class="btn_lyr_close">'+getLocaleMsg("A0004", "취소")+'</button>';
	}else{
		alertHtml += '<button class="btn_lyr_close" onclick="'+defType+'(true)">'+getLocaleMsg("A0003", "확인")+'</button>';
		alertHtml += '<button class="btn_lyr_close" onclick="'+defType+'(false)">'+getLocaleMsg("A0004", "취소")+'</button>';
	}

	$("#alertBtnBox > button").remove();
	$("#alertBtnBox").append(alertHtml);
    $(".lyr_mid > span").text(msg);
    
    openPopup("alertBox");
	
}

function alertEndDef(type){
	
	var dimCloseYn = true;
	
	$(".lyr_alert").hide();

	//$("#alertWrap").hide();
	//$(".lyrWrap").hide();
	
	$.each($(".lyrWrap").children(".lyrBox"), function(i, v){
		console.log(v.style.display);
		if(v.style.display == "block"){
			dimCloseYn = false;
		}
	});
	
//	if(dimCloseYn){
//		$(".lyrWrap").hide();
//	}
	
	
}

/*
 * 청취, 개입 종료 alert 콜백
 */

function socketCloseYn(tf){
	
	if(tf){
		chBtn("call_close");
		ws_agent.close();
		ws_agent = null;
	}
	
	alertEndDef(tf);
	
}

/*
 * 고객상담개입 요청
 */

function reqTransfer(agentId){
	
	console.log("inTrans"+agentId);
	
	fnAlarmCont(agentId, {type:"off", alarm:true, audio:true, alert:true});
	alertEndDef(true);
}


/*
 * 알람, 오디오 컨트롤
 * 
 */
function fnAlarmCont(agentId, evtObj){
	//켜기
	console.log("*************");
	console.log(evtObj);
	console.log(agentId);
	
	if(!$("#alarmAudio_"+agentId).length > 0) return;
	
	if(evtObj.type == "on"){
		if(evtObj.alarm){
			$("#"+agentId+" > div").addClass("alarm");
		}
		if(evtObj.audio){
			document.getElementById("alarmAudio_"+agentId).load();//알람끄고 처음으로
			document.getElementById("alarmAudio_"+agentId).muted = false;
			document.getElementById("alarmAudio_"+agentId).play();//오디오켜기
		}
		//STT보고있는중
		if(evtObj.alert){
			var msg = getLocaleMsg("A0010", "고객상담요청.");
	    	//dim에 click이벤트
	    	$(".lyrWrap").off().on("click", function(){
	    		$("#"+agentId+" > div").removeClass("alarm");
	    		document.getElementById("alarmAudio_"+agentId).muted = true;
	    		document.getElementById("alarmAudio_"+agentId).load();//알람끄고 처음으로
	    	});
	    	
			alertInit(msg, "reqTransfer('"+agentId+"')", "isFn");
		}
	}else if(evtObj.type == "off"){//끄기
		if(evtObj.alarm){
			$("#"+agentId+" > div").removeClass("alarm");
		}
		if(evtObj.audio){
			document.getElementById("alarmAudio_"+agentId).muted = true;
			document.getElementById("alarmAudio_"+agentId).load();//알람끄고 처음으로
		}
	}else if(evtObj.type == "audioAllOff"){
		$.each($("input[id^='alarmAudio']"), function(i, v){
			
			console.log("all");
			console.log(v.id);
			
			document.getElementById(v.id).muted = true;
			document.getElementById(v.id).load();
		});
	}
}

//callback기능용
function startAutocall(headerName, token, params){
	
	autoCallArr = params;
	
	console.log("startAutocall");
	
	$.each(autoCallArr, function(i,v){
		console.log(v);
	});
	
	console.log("startAutocall");
	
	$("#autoCallYn").val("Y");//autocall 실행중 플래그
	
	$.each(params, function(i,v){
		
		var sendMsg = '{"EventType":"STT", "Event":"START", "Caller":"' + v.custTelNo + '", "Agent":"' + v.agent + '", "contractNo":"' + v.contractNo + '", "campaignId":"' + v.campaignId + '"}';
		
		$.ajax({
	        url: "sendCM",
	        data: sendMsg,
	        method : 'POST',
	        contentType : "application/json; charset=utf-8",
	        async:false,
	        beforeSend: function (xhr) {
				xhr.setRequestHeader(headerName,token);
	        }
	    }).done(function (data) {
	        console.log("### SUCC : " + data);
	    }).fail(function (data) {
	        console.log("### FAIL : " + data);
	    });
		
	});
	
}
/******************
대기시간 관련
*******************/
//동적함수 저장.
var fncMap={};
//bot별 time 저장
var timeMap={};

function waitTimer(param) {
	timeMap["hour_"+param] = 0;
    timeMap["min_"+param] = 0;
    timeMap["sec_"+param] = 0;
    timeMap["timer_"+param] = null;
	return fncMap[param] = function(){
      setTimeout(function timer(){
    	  if(timeMap["min_"+param] == 59){
              timeMap["hour_"+param] += 1;
              timeMap["min_"+param] = 0;
          }
          if(timeMap["sec_"+param] == 59){
              timeMap["min_"+param] += 1;
              timeMap["sec_"+param] = 0;
          }else{
              timeMap["sec_"+param] += 1;
          }
          
        //음성봇별 대기시간 표시.
        $("#"+param).find(".call_state").text("");
      	$("#"+param).find(".call_time").text("대기시간 " + timeMap["hour_"+param] + ":" + addzero(timeMap["min_"+param]) + ":" + addzero(timeMap["sec_"+param]));
      	timeMap["timer_"+param]=setTimeout(timer,1000);
        },1000); 
    }  
}

//분,초 0~9 앞에 0 붙이는 함수.
function addzero(num){
    if(num < 10 ){num = "0" + num}
    return num;
}

//대기시간 clear 함수.
function stopTimer(param){	
	return fncMap[param] = function(){
		timeMap["hour_"+param] = 0;
        timeMap["min_"+param] = 0;
        timeMap["sec_"+param] = 0;
        $("#"+param).find(".call_time").text("");
        clearTimeout(timeMap["timer_"+param]);
    }
}

/*****************
 테스트용
 *********************/
 
function ttt(id) {
	 initSet();
	 chBtn("call_close");
		//Time("7041_chatBot");
			$("#chatCont").find( 'div.callView_tit >h3' ).empty();
			$("#chatCont").find( 'div.callView_tit >h3' ).append($("#" + id +"_chatBot >h3").html());
			$("#chatCont").find( 'div.callView_tit' ).attr("name",id)
			var obj = new Object();
//			if(id=="07070907045"){
//				obj.TEL_NO = "01028093384";
//				obj.SIP_USER =  id;
//				obj.CONTRACT_NO =  "46";
//				$("#chatCont_CONTRACTNO").val(obj.CONTRACT_NO);
//				ajaxCall($("#csType").val()=="IB"?"/ibUserInfo":"/obUserInfo", $("#headerName").val(), $("#token").val(),	JSON.stringify(obj), "N");
//			}else if(id=="7043"){
//				obj.TEL_NO = "01030682457";
//				obj.SIP_USER =  id;
//				obj.CONTRACT_NO =  "2038";
//				$("#chatCont_CONTRACTNO").val(obj.CONTRACT_NO);
//				ajaxCall($("#csType").val()=="IB"?"/ibUserInfo":"/obUserInfo", $("#headerName").val(), $("#token").val(),	JSON.stringify(obj), "N");
//			}
			
			//"콜청취" 클릭
			$("#call_listen").off("click").on("click",obj,function() {
			    
				console.log("청취 in");
				
				if(chBtn("call_listen") == false){
					
					console.log("상담개입 > 청취");
					
					ws_agent.close();
					ws_agent = null;
				}
				
				$('#call_listen').attr("disabled", true);
			     var sendMsg = { Event: "LISTEN", AgentId: $("#OP_LOGIN_ID").val(), dialNo: obj.SIP_USER};
			     //var sendMsg = { Event: "LISTEN", AgentId: "admin", dialNo: obj.SIP_USER}; // testcode
			     
			     console.log(sendMsg);
			     
			     sendMsgRestful("/sendCM", $("#headerName").val(), $("#token").val(),"LISTEN", JSON.stringify(sendMsg), "N");
			 });
			 //"상담개입" 클릭
			$("#call_change_op").off("click").on("click",obj,function() {
				
				if(chBtn("call_change_op") == false){
					
					console.log("청취 > 상담개입");
					
					ws_agent.close();
					ws_agent = null;
				}
				
			    //$('#call_listen').attr("disabled", true);
			    //$('#call_change_op').attr("disabled", true);
			     var sendMsg = { Event: "TRANSFER", AgentId: $("#OP_LOGIN_ID").val(), dialNo: obj.SIP_USER}; 
			     //var sendMsg = { Event: "TRANSFER", AgentId: "admin", dialNo: obj.SIP_USER};//testcode
			     sendMsgRestful("/sendCM", $("#headerName").val(), $("#token").val(),"TRANSFER", JSON.stringify(sendMsg), "N");
			});
			
			$("#call_close").off("click").on("click", obj, function(){
				
				var msg = "";
				//var closeYn = null;
				
				if($("#call_listen").attr("disabled") == "disabled"){
					msg = "청취를 종료하시겠습니까?";
				}else if($("#call_change_op").attr("disabled") == "disabled"){
					msg = "상담을 종료하시겠습니까?";
				}
				
				openPopup("alertBox");
				
				$(".lyr_mid > span").text(msg);
				
				//closeYn = confirm(msg);
				
				/*console.log("closeYn : "+closeYn);
				
				if(closeYn){
					
					chBtn("call_close");
					
					ws_agent.close();
					ws_agent = null;
				}*/
				
			});
	} 
	
