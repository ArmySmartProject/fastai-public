var transferYN = 0; // AI에서 상담사로 전환 여부
var result = ''; // 리턴값
var inerHtml ="";
var ws_agent = null; // 청취, 상담개입
var autoCallArr = null;// autocall목록
var wss_url = "";
var autoCallInfo = null;

//체크한 고객들 contract_no, campaignId로 복수개 소켓 날림(일단 하나만)
function conn_main_ws(url) {
	
	wss_url = url+"/callsocket";
	
	main_ws = new WebSocket(wss_url);
	
	main_ws.onopen = function() {
		
		main_ws.send('{"EventType":"CALL", "Event":"subscribe"}');
	};
	main_ws.onerror = function(event) {
		console.error("main Socket is error now.");
		console.error(event);
		alert("소켓 연결에 실패하였습니다.");
	};
		
	main_ws.onmessage = function(e) {
		
		if(e.data == "wss"){
			return;
		}
		
		var rcv_data = JSON.parse(e.data);
		console.log("call====");
		console.log(rcv_data);
		// 타입이CALL인 경우
		if (rcv_data.EventType == 'CALL') {
			if (rcv_data.Event == 'status') {
				if (rcv_data.call_status == "CS0002") {//전화 연결중인결우
					
					if(autoCallArr != null){
						$.each(autoCallArr, function(i, v){
							
							console.log("onmessage");
							
							console.log(v);
							console.log("onmessage");
							
							if(v.contractNo == rcv_data.contract_no){//현재 autocall중인 배열중 contract_no 가 같은 i번을 삭제
								autoCallArr.splice(i, 1);
								return false;
							}
						});
					
						//autoCall중인 배열이 0
						if(autoCallArr.length == 0){
							$("#autoCallYn").val("N");
						}
						console.log(autoCallArr);
					}
					
					$("#" + rcv_data.Agent).find('.call_state').html(getLocaleMsg("A0002", "통화중"));
					sendMsg = '{"EventType":"STT", "Event":"subscribe", "Caller":"' + rcv_data.Caller	+ '", "Agent":"' + rcv_data.Agent + '", "contract_no":"' + rcv_data.contract_no + '"}';
					agentWs(url, sendMsg,rcv_data.Agent);
					var obj = new Object();
					obj.TEL_NO =  rcv_data.Caller;
					obj.SIP_USER =  rcv_data.Agent;
					obj.CONTRACT_NO =  rcv_data.contract_no;
					
					//통화중이 될경우 클릭 펑션
					$("#" + rcv_data.Agent +"_chatBot").on("click",obj,function() {
						obj.CAMPAIGN_ID = $("#" + rcv_data.Agent +"_chatBot > input").val();//해당봇의 캠페인 ID
						
						agentClick(obj);
					});//통화중이 될경우 클릭 펑션-END
				} else if (rcv_data.call_status == "CS0006") {
					$("#" + rcv_data.Agent).find('.call_state').html(getLocaleMsg("", "진행중"));
	            } else if (rcv_data.call_status == "CS0003") {
	            	//$("#" + rcv_data.Agent).find('.call_state').html(getLocaleMsg("A0001", "대기중"));
	            	//$("#" + rcv_data.Agent).find('.lst_talk').empty();//하단 채팅 내용 삭제
	            	//$("#" + rcv_data.Agent +"_chatBot").prop("onclick", null).off("click");
	            	$("#" + rcv_data.Agent).find('.call_state').html(getLocaleMsg("A0001", "대기중"));
	            	$("#" + rcv_data.Agent).find('.lst_talk').empty();//하단 채팅 내용 삭제
	            	$("#" + rcv_data.Agent +"_chatBot").prop("onclick", null).off("click");
	            	$('.callDetail .callView .callView_tit span.call_state').text('통화종료');
	            	$('.callDetail .callView').removeClass("alarm");
	            	$("#" + rcv_data.Agent).find(".callView").removeClass("alarm");

	            } else {
	            	//$("#" + rcv_data.Agent).find('.call_state').html(getLocaleMsg("A0001", "대기중"));
	            	//$("#" + rcv_data.Agent).find('.lst_talk').empty();//하단 채팅 내용 삭제
	            	//$("#" + rcv_data.Agent +"_chatBot").prop("onclick", null).off("click");
	            	$("#" + rcv_data.Agent).find('.call_state').html(getLocaleMsg("A0001", "대기중"));
	            	$("#" + rcv_data.Agent).find('.lst_talk').empty();//하단 채팅 내용 삭제
	            	$("#" + rcv_data.Agent +"_chatBot").prop("onclick", null).off("click");
	            	$('.callDetail .callView .callView_tit span.call_state').text('통화중료');
	            	$('.callDetail .callView').removeClass("alarm");
	            	$("#" + rcv_data.Agent).find(".callView").removeClass("alarm");

	            }
			}else if (rcv_data.Event == 'stop') {
				console.log("call stop");
				ajaxCall("/getOpUserState", $("#headerName").val(), $("#token").val(),	JSON.stringify(obj), "N");
            }else if(rcv_data.Event == "transfer"){//상담사 요청 들어옴
            	//현재 STT보고있는 대상 > 팝업 + alarm + 소리
            	if($("#chatCont").find( 'div.callView_tit' ).attr("name") == rcv_data.Agent){
            		fnAlarmCont(rcv_data.Agent, {type:"on", alarm:true, audio:true, alert:true});
            		//document.getElementById("alarmAudio").play();//오디오켜기
            		//$("#"+rev_data.Agent+" > div").addClass("alarm");
            	}else if($("#call_change_op").attr("class").match("btnS_primary") == "btnS_primary"){//상담개입중 > alarm
            		fnAlarmCont(rcv_data.Agent, {type:"on", alarm:true, audio:false});
            	}else{//나머지(STT를 보고있는데 상담사 요청한콜, STT안보고있는데 상담사 요청한콜) > alarm + 소리
            		fnAlarmCont(rcv_data.Agent, {type:"on", alarm:true, audio:true});
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


		ajaxCall($("#csType").val()=="IB"?"ibUserInfo":"obUserInfo",$("#headerName").val(), $("#token").val(),	JSON.stringify(obj), "N");
		/**
		 * 확인해야할 사항 콜 청취중 음성봇 변경시  
		 * 상당개입중 하단 음성봇 선택시 변경? 불가?
		 * 
		 * */
		//"콜청취" 클릭
		$("#call_listen").off("click").on("click",obj,function() {
		    //$('#call_listen').attr("disabled", true);

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
			
			if($("#call_listen").attr("disabled") == "disabled"){
				msg = getLocaleMsg("A0006", "청취를 종료하시겠습니까?");
			}else if($("#call_change_op").attr("disabled") == "disabled"){
				msg = getLocaleMsg("A0007", "상담을 종료하시겠습니까?");
			}
			
			alertInit(msg, "socketCloseYn");
			
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

function directCall(obj) {
	console.log("campaginId : " + obj.CAMPAIGN_ID);
	console.log("contractNo : " + obj.CONTRACT_NO);
	
	var sendMsg = { Event: "DIRECT", contractNo: obj.CONTRACT_NO, campaignId: obj.CAMPAIGN_ID ,agentId: $("#OP_LOGIN_ID").val()};
	
	console.log("데이터 : " + JSON.stringify(sendMsg));
	
	
	ajaxCall("/sendCM",$("#headerName").val(), $("#token").val(),	JSON.stringify(sendMsg), "N");
	
	sendMsgRestful("/sendCM", $("#headerName").val(), $("#token").val(),"DIRECT", JSON.stringify(sendMsg), "N");
}
// 소프트폰 종료
function call_direct(){
	var telNo = $("#telNo").val();
	
	var sendMsg = { Event: "HANGUP", dialNo: telNo ,agentId: $("#OP_LOGIN_ID").val()};
	ajaxCall("/sendCM",$("#headerName").val(), $("#token").val(),	JSON.stringify(sendMsg), "N");
	
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
function agentWs(url, sendMsg,agent_ws) {
	
	agent_ws = new WebSocket(wss_url);
	
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
				//if($("#rcv_data.Agent").length == 0) return;
				if(rcv_data.Agent.length == 0) return;
				
				$("#chatCont").find( 'div.callView_tit').attr("name", "");
				//청취 , 상담개입 중이면 종료됨
				if(ws_agent != null){
					
					chBtn("call_close");
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
	        //$("#"+rcv_data.No).empty();
	/*      if(rcv_data.Result =="Y") inerHtml += "<span class='active'>YES</span> <span>NO</span> <span>없음</span>";
	        else if(rcv_data.Result =="N") inerHtml += "<span>YES</span> <span class='active'>NO</span> <span>없음</span>";
	        else inerHtml += "<span>YES</span> <span>NO</span> <span  class='active'>없음</span>";*/
	         
	        //if(rcv_data.Result =="Y") inerHtml += "<span class='active'>YES</span> <span>NO</span> ";
	         
	        /*if(rcv_data.Result =="상담원"){
	           inerHtml += "<span>"+rcv_data.Result+"</span> ";
	        }else if(rcv_data.Result =="상담원연결"){
	           inerHtml += "<span>"+rcv_data.Result+"</span> ";
	        }else{
	           inerHtml += "<span>"+rcv_data.Result+"</span> ";
	        }*/
	        if(rcv_data.Result != null && rcv_data.Result != "Y" && rcv_data.Result != "N") {
	        	inerHtml += "<span>"+rcv_data.Result+"</span> ";
	        }else if (rcv_data.Result == "Y"){
	        	inerHtml += "<span class='active'>YES</span> <span>NO</span> ";
	        }else if (rcv_data.Result == "N"){
	        	inerHtml += "<span>YES</span> <span class='active'>NO</span> ";
	        }
	         
	         /*      else if(value.TASK_VALUE =="N") inerHtml += "<span>YES</span> <span class='active'>NO</span> <span>없음</span>";
	               else inerHtml += "<span>YES</span> <span>NO</span> <span  class='active'>없음</span>";*/
	         
	         //else  inerHtml += "<span>YES</span> <span class='active'>NO</span> ";
	        $("#"+rcv_data.No).html(inerHtml);
		}
	};
}

/*******************************************************************************
 * 메인 채팅 창 ( 상단 오른쪽에 대한 채팅 값)
 ******************************************************************************/
function makeMsg(rcv_data) {
	if (rcv_data.Direction == 'TX') {//봇 --에이전트
		result ="<li class='bot'><div class='bot_msg'><em class='txt'>"+rcv_data.Text+"</em><div class='date'></div></div></li>";
		$("#" + rcv_data.Agent).find('.lst_talk').append(result);
		$("#" + rcv_data.Agent).find( 'div.chatUI_mid' ).scrollTop($("#" + rcv_data.Agent).find( 'ul.lst_talk' ).height());
		if($("#chatCont").find( 'div.callView_tit' ).attr("name") == rcv_data.Agent){
			$("#chatCont").find( 'ul.lst_talk' ).append(result);
			$("#chatCont").find( 'div.chatUI_mid' ).scrollTop($("#chatCont").find( 'ul.lst_talk' ).height());   
		}
	} else if (rcv_data.Direction == 'RX') {//고객 --에이전트
		result ="<li class='user'><div class='bot_msg'><em class='txt'>"+rcv_data.Text+"</em><div class='date'></div></div></li>";
		$("#" + rcv_data.Agent).find('.lst_talk').append(result);
		$("#" + rcv_data.Agent).find( 'div.chatUI_mid' ).scrollTop($("#" + rcv_data.Agent).find( 'ul.lst_talk' ).height());   
		if($("#chatCont").find( 'div.callView_tit' ).attr("name") == rcv_data.Agent){
			$("#chatCont").find( 'ul.lst_talk' ).append(result);
			$("#chatCont").find( 'div.chatUI_mid' ).scrollTop($("#chatCont").find( 'ul.lst_talk' ).height());
		}
	}else if (rcv_data.SPEAKER_CODE == 'ST0002') {//봇 --DB데이터
		result ="<li class='bot'><div class='bot_msg'><em class='txt'>"+rcv_data.SENTENCE+"</em><div class='date'></div></div></li>";
		$("#chatCont").find( 'ul.lst_talk' ).append(result);
		$("#chatCont").find( 'div.chatUI_mid' ).scrollTop($("#chatCont").find( 'ul.lst_talk' ).height());   
	} else if (rcv_data.SPEAKER_CODE == 'ST0001') {//고객 --DB데이터
		result ="<li class='user'><div class='bot_msg'><em class='txt'>"+rcv_data.SENTENCE+"</em><div class='date'></div></div></li>";
		$("#chatCont").find( 'ul.lst_talk' ).append(result);
		$("#chatCont").find( 'div.chatUI_mid' ).scrollTop($("#chatCont").find( 'ul.lst_talk' ).height());   
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
	        			 "agent_id": agent_id
	        	 };
	         }
	         
	         var data = JSON.stringify(msg);
	         
	         ws.send(data);
	         console.log("send REGISTER (" + trans_type + ")");
	      };

	      ws.onmessage = function (evt) {
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
	
	/*var sendUrl = "/sendCM";
        $.ajax({
            url: url,
            data: {sendMsgStr: sendMsgStr},
            type: "POST",
            method : 'POST',
            beforeSend: function (xhr) {
				xhr.setRequestHeader(headerName,token);
            },
        }).done(function (data) {
            console.log("### SUCC : " + data);
        }).fail(function (data) {
            console.log("### FAIL : " + data);
        });*/
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
					inerHtml += "<option value="+value.CODE+">"+value.CODE_NM+"</option>";
				});
				if(valueChk(reqData.UPJQID)){
					if(reqData.UPCODE !="999")
						$("#"+reqData.UPJQID).next().append(inerHtml);
				}else{
					$("select[id^='cst'][id$='_1']").append(inerHtml);
				}
			}
		}
	}else if(setUserEdt){
		//유저정보 저장
		
	}else{
		//상담유형 변경 제외 refresh
		
		//최초 클릭했을때 상담내용 저장용 데이터 삽입
		//고객 상담정보 단건 이제 안들고옴 > 상담내용 저장용 데이터
		$("#CSDTL_CONTRACT_NO").val(result.CONTRACT_NO);
		$("#CSDTL_CALL_ID").val(result.CALL_ID);//상담내용 저장용
		$("#CSDTL_CAMPAIGN_ID").val(result.CAMPAIGN_ID);//상담내용 저장용
		
		//고객정보/////
		if(valueChk(result.userInfoList)){
			obj = JSON.parse(result.userInfoList);
			if(obj.length > 0){
				
				$.each(obj[0], function(key, value){
					if(key=="CUST_TYPE"){//라디오
						$("input:radio[name=\'user_ipt_radio\']:radio[value="+value+"]").prop('checked', true); // 
						$("input:radio[name=\'USEREDT_ipt_radio\']:radio[value="+value+"]").prop('checked', true); // 
					}else{
						if($.isNumeric(value) && value.toString().length > 8){//폰번호 하이픈
							value =telNumHyphen(value);
						}
						$(".USER_"+key).html(value);
						$("#USEREDT_"+key).val(value);
					}
				});
			}
		}
		
		console.log("@@@@");
		console.log(result.userPaymentList);
		
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
						inerHtml += "<option value="+catevalue.CODE+">"+catevalue.CODE_NM+"</option>";
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
		                  inerHtml += "<span>YES</span> <span class='active'>NO</span>";
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
				
				
			}
		}
		
		
		//상담이력정보조회(사이드)////
		$("#csHisCont").find( 'tbody.csHis_tbody' ).empty();
		if(valueChk(result.csHisList)){
			obj = JSON.parse(result.csHisList);
			if(obj.length > 0){
				 inerHtml ="";
				$.each(obj, function(key, value){
					//상담이력
					inerHtml +='<tr onclick="resultDetail('+value.CONTRACT_NO+', '+value.CALL_ID+')">';
					inerHtml +="<td scope='row'>"+value.START_TIME+"</td>";
					inerHtml +="<td>"+value.DURATION+"</td>";
					inerHtml +="<td>"+value.CALL_TYPE_NM+"</td>";
					//inerHtml +="<td>"+value.CONSULT_TYPE3_DEPTH1_NM+"</td>";
					/*inerHtml +="<td>-</td>";*/
					inerHtml +="<td>"+value.CD_DESC+"</td>";//시도결과
					inerHtml +="<td>"+value.MNT_STATUS_NAME+"</td>";//통화결과
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
		
		// IbOP상태정보////
		if(valueChk(result.opStatus)){
			initTextParsing(result.opStatus);
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
/*
 * autocall
 */

//ob > autocall 요청시
//sendMsg = '{"EventType":"STT", "Event":"subscribe", 
//"Caller":"' + getd_cust_tel_no + '", 
//"Agent":"' + getd_cust_op_id + '", "contract_no":"' + getd_contract_no + '", 
//"campaignId":"' + getd_campaign_id + '"}';
//리스트로 받아야하는데 일단 하나만 테스트
function startAutocall(headerName, token, params){
	
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

function stopAutoCall(headerName, token){

	$("#autoCallYn").val("N");//autocall 실행중 플래그
	
	//autoCallArr > autocall실행시 배열에 넣고 봇에 날아올때마다 실행된것들 삭제

		console.log("autoCallInfo");
		console.log(autoCallInfo);

		var sendMsg = '{"EventType":"STT", "Event":"STOP", "Caller":"' + autoCallInfo.TEL_NO + '", "Agent":"' + autoCallInfo.SIP_USER + '", "contractNo":"' + autoCallInfo.CONTRACT_NO + '", "campaignId":"' + autoCallInfo.CAMPAIGN_ID + '"}';
		
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
	        console.log("### stop SUCC : " + data);
	    }).fail(function (data) {
	        console.log("### stop FAIL : " + data);
	    });
		
}


/*******************************************************************************
 * null 값 체크 리턴   없는값이면 false   값이 있으면 true
 ******************************************************************************/
function valueChk(data) {
	
	if(typeof data != "undefined" &&  data != null &&  data != "" && data != "null"){
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
	
	console.log(data);
	
	if(data.length > 0){
		$.each(data[0], function(key, value){
			if(key =="CUST_OP_STATUS"){
				console.log("in"+value);
				$(".groupBox.bg_none" ).find("button").removeClass("active");
				$(".groupBox.bg_none" ).find("button:input[value="+value+"]").addClass("active");
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
	$('#UserEdtForm').each(function(){
	    this.reset();
	  });
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

/*
 * 비밀번호 대소문자, 숫자포함 8~20 
 */

function ckEditPw(pw){
	var re = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,20}/
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
		$("#call_close").attr("disabled", false);
		/*$("#"+id).attr("disabled", true);
		$("#"+id).css("background-color", "green");
		$("#"+id).css("color", "black");*/
		
		$("#"+id).attr("class", "btnS_primary");
		$("#"+id).attr("disabled", true);
		
		if(id == "call_listen" && $("#call_change_op").attr("disabled") == "disabled"){
			//상담개입 > 청취
			//$("#call_change_op").attr("style", "");
			$("#call_change_op").attr("class", "btnS_basic");
			$("#call_change_op").attr("disabled", false);
			onOffVal = false;
		}else if(id == "call_change_op" && $("#call_listen").attr("disabled") == "disabled"){
			//청취 > 상담개입
			//$("#call_listen").attr("style", "");
			$("#call_listen").attr("class", "btnS_basic");
			$("#call_listen").removeAttr("disabled");
			onOffVal = false;
		}
		
	}else{
		
		//종료, init
		$("#call_listen").attr("class", "btnS_basic");
		$("#call_listen").attr("disabled", false);
		$("#StpAutoCall").attr("class", "btnS_basic");
		$("#StpAutoCall").attr("disabled", false);
		$("#call_change_op").attr("class", "btnS_basic");
		$("#call_change_op").attr("disabled", false);

		$("#call_close").attr("disabled", true);
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
		alertHtml += '<button class="btn_lyr_close" onclick="'+defType+'">'+getLocaleMsg("A0004", "취소")+'</button>';
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
	
	if(dimCloseYn){
		$(".lyrWrap").hide();
	}
	
	
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
			var msg = getLocaleMsg("", "고객상담요청.");
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

/*
 * 상담이력 클릭 이벤트
 */

function resultDetail(contract_no, call_id){
	var popSize = "width=800,height=600";
	var popOption = "titlebar=no,toolbar=no,menubar=no,location=no,directories=no,status=no,scrollbars=no";
	winpop1 = window.open("/mntResultPop?ctn="+call_id+"&cno="+contract_no,"winpop1", popSize + "," + popOption);

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
			if(id=="07070907045"){
				obj.TEL_NO = "01028093384";
				obj.SIP_USER =  id;
				obj.CONTRACT_NO =  "46";
				$("#chatCont_CONTRACTNO").val(obj.CONTRACT_NO);
				ajaxCall($("#csType").val()=="IB"?"ibUserInfo":"obUserInfo", $("#headerName").val(), $("#token").val(),	JSON.stringify(obj), "N");
			}else if(id=="7043"){
				obj.TEL_NO = "01030682457";
				obj.SIP_USER =  id;
				obj.CONTRACT_NO =  "2038";
				$("#chatCont_CONTRACTNO").val(obj.CONTRACT_NO);
				ajaxCall($("#csType").val()=="IB"?"ibUserInfo":"obUserInfo", $("#headerName").val(), $("#token").val(),	JSON.stringify(obj), "N");
			}
			
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

function agentInfo(params) {
	autoCallInfo = params;
}
	
