'use strict';
var lang=gLocale;
var chatBotUiCtrl;
var writeMessage;
var openChatWindow;
var writePreviousMessages;
var chatbotMonitor;
var curRoomId;
var roomUUIDMap = [];

$(document).ready(function () {
	/**
	 * 화면 UI 생성을위한 컨트롤러
	 */
	chatBotUiCtrl = (function(){

		// 채팅룸 리스트 박스
		var chatListBox = $(".lst_dialogue");

		// 채팅 박스 
		var chatBox = $(".m_chatting .lst_talk");

		// 채팅박스 고객명
		var chatBoxUserIdElem = $(".callView .callView_tit h3 span");


		// 채팅룸 Element clone data
		var chatListElemClone = $('<li>'+
				'<a href="#none">'+
				'<span class="thumb">'+
				'<em></em>'+
				'</span>'+
				'<span class="info">'+
				'<em class="name">홍길동</em>'+
				'<em class="txt"></em>'+
				'</span>'+
				'<span class="status">'+
				'<em class="time"></em>'+
				'<em class="state">챗봇</em>'+
				'</span>'+
				'</a>'+
				'</li>');

		var botChatElemClone = $('<li class="customer">'+
				'<div class="bot_msg">'+
				'<em class="txt"></em>'+
				'<div class="date">2019.08.14 12:00</div>'+
				'</div>'+
				'<div class="btn_basic" style="display:none"></div>'+
				'</li>');

		var userChatElemClone = $('<li class="adviser">'+
				'<div class="bot_msg">'+
				'<em class="txt"></em>'+
				'<div class="btnItem" style="display:none">'+
				'<ul>'+
				'</ul>'+
				'</div>'+
				'<div class="date">2019.08.14 12:00</div>'+
				'</div>'+
				'</li>'+
				'<li class="botMsg_swiper" style="display:none">'+
				'<div class="swiper-wrapper">'+
				'</div>'+
				'<div class="swiper-pagination"></div>'+
				'<div class="swiper-button-prev"></div>'+
				'<div class="swiper-button-next"></div>'+
				'</li>');

		var sysChatElemClone = $('<li class="stmMessage">'+
				'<span></span>'+
				'</li>');

		var swiperElem = $('<div class="swiper-slide">'+
				'<a class="swiper_item" href="#" target="_self">'+
				'<span class="item_img"><img src="${pageContext.request.contextPath}/resources/images/sample/sample_swiper01.jpg" alt="이미지 명"></span>'+
				'<span class="item_tit">상품 검색할래?</span>'+
				'<span class="item_txt">찾고 싶은 상품을 바로 검색하세요.</span>'+
				'</a>'+
				'</div>');

		// 왼쪽 상단 채팅방 정보
		var sessionIdTxt = $(".cont_cell .session_id");
		var csServiceTxt = $(".cont_cell .cs_service");
		var csCategoryTxt = $(".cont_cell .cs_category");
		var userIdTxt = $(".cont_cell .user_id");

		// 채팅룸 Array data
		var chatListElemArray=[];

		var roomMap={};

		/**
		 * 모든 채팅룸을 삭제함
		 */
		var clearChatList=function(){
			chatListBox.html("");
		};

		/**
		 *  채팅상담 최초 생성시 채팅룸 생성
		 */
		var addChatList=function(id,obj){
			console.log(obj);
			var room=roomMap[id]=obj.room;

			var clone = chatListElemClone.clone();


			if (room['bot']) {
				clone.find(".state").text(message["챗봇"]);
				clone.removeClass("calling");
				clone.removeClass("alarm");
			} else if (room['available']) {
				clone.find(".state").text(message["상담요청"]);
				clone.addClass("alarm");
			} else if (!room['available'] && !room['bot']) {
				clone.find(".state").text(message["상담중"]);
				clone.addClass("calling");
			}

			clone.find(".name").html(room.userId);

			clone.attr("room-id",obj.roomId);
			clone.attr("id",id);
			clone.addClass(obj.option);
			clone.attr("onclick","chatBotUiCtrl.openChat(this)");
			//clone.find("name",id);
			chatListElemArray.push(clone);
			chatListBox.append(clone);
		};

		/**
		 * 특정 채팅룸을 삭제함
		 */
		var deleteChatList=function(cls){
			chatListBox.find("."+cls).remove();
		};

		/**
		 * 생성된 채팅룸의 정보를 변경함
		 */
		var modifyChatList=function(id,obj){
			/*
			date: "2020년 4월 27일 월요일"
			message: "fsdfsd↵"
			time: "17:32"
			*/
			// console.log(obj);

			getChatListElem(id).attr("time",getTimeStr(obj.date,obj.timeDetail));

			// AMR 보고있던 채팅방 표시
			var getChatListName = getChatListElem(id).find('.name').text();
			var rememberList = chatBoxUserIdElem.text();
			var rememberListName = (rememberList.match(/\((.*?)\)/) || [,""])[1];
			if ( getChatListName === rememberListName ) {
				getChatListElem(id).addClass('on');
			}

			var adapterResponse = obj.adapterResponse;
			if(adapterResponse && adapterResponse['answer']){
				newText = adapterResponse.answer.trim();
				newText = newText.replace(/(<([^>]+)>)/ig,"");
				var regx = /\|\|\|+[A-Za-z]+\|\|\|+/;
				try{
					newText = JSON.parse(newText.replace(regx,""));
					getChatListElem(id).find(".txt").text(newText.answer);
				}catch (e) {
					//JSON 형식 아님
					getChatListElem(id).find(".txt").text(newText);
				}
			}
			else{
				if(obj.message){
					var newText = obj.message.replace(/(<([^>]+)>)/ig,"");
					if(newText)
						getChatListElem(id).find(".txt").text(newText);
				}
			}

			if(obj.timeDetail){
				var timestr = beforeTimeStr(obj.date,obj.timeDetail);
				// console.log(timestr);
				getChatListElem(id).find(".time").html(timestr);
			}
			orderChatList();
			getSelectTime();
		};

		var orderChatList=function(){
			chatListBox.find("li").sort(function(a,b) {
				var atime = $(a).attr("time");
				var btime = $(b).attr("time");
				console.log(atime > btime);
				return atime < btime ? 1 : -1;
			}).appendTo(chatListBox);
		};

		/**
		 * 채팅 리스트의 자식 엘리멘터를 가져옴
		 */
		var getChatListElem=function(id){
			return chatListBox.find("#"+id);
		};

		/**
		 *  채팅방을 연다.
		 */
		var openChat = function(elem) {
			if (window.location.href.includes('mobileCbCsMain')) {

				var form = document.createElement('form');
				var available;
				var bot;
				var csCategory;
				var roomId;
				var status;
				var userId;
				var sessionId;
				var dataObject = new Object();
				var roomData = roomMap[$(elem).attr("id")];
				available = document.createElement('input');
				available.setAttribute('type', 'hidden');
				available.setAttribute('name', 'available');
				available.setAttribute('value', roomData.available);
				bot = document.createElement('input');
				bot.setAttribute('type', 'hidden');
				bot.setAttribute('name', 'bot');
				bot.setAttribute('value', roomData.bot);
				csCategory = document.createElement('input');
				csCategory.setAttribute('type', 'hidden');
				csCategory.setAttribute('name', 'csCategory');
				csCategory.setAttribute('value', roomData.csCategory);
				roomId = document.createElement('input');
				roomId.setAttribute('type', 'hidden');
				roomId.setAttribute('name', 'roomId');
				roomId.setAttribute('value', roomData.roomId);
				status = document.createElement('input');
				status.setAttribute('type', 'hidden');
				status.setAttribute('name', 'status');
				status.setAttribute('value', roomData.status);
				userId = document.createElement('input');
				userId.setAttribute('type', 'hidden');
				userId.setAttribute('name', 'userId');
				userId.setAttribute('value', roomData.userId);
				sessionId = document.createElement('input');
				sessionId.setAttribute('type', 'hidden');
				sessionId.setAttribute('name', 'sessionId');
				sessionId.setAttribute('value', roomData.sessionId);
				form.appendChild(available);
				form.appendChild(bot);
				form.appendChild(csCategory);
				form.appendChild(roomId);
				form.appendChild(status);
				form.appendChild(userId);
				form.appendChild(sessionId);
				form.setAttribute('method', 'post');
				if (window.location.href.includes('redtie/mobileCbCsMain')) {
					form.setAttribute('action', "/redtie/mobileChatting");
				} else {
					form.setAttribute('action', "/mobileChatting");
				}
				document.body.appendChild(form);
				form.submit();

			}

			var room;
			if (window.location.href.includes('mobileChatting')) {
				room = elem;
				var innerHtml = '';
				innerHtml = '<em>'+room.userId+'</em>';
				$('.title').append(innerHtml);
			} else {
				room = roomMap[$(elem).attr("id")];
			}

			/* AMR 보고있는 채팅방 표시 */
			$('.lst_dialogue .bot_rooms').removeClass('on');
			$(elem).addClass('on');

			$("#gcs_title em").text(room['csService']);

			chatBox.attr("room-id",room.roomId);
			chatBoxUserIdElem.text("("+room.userId+")");

			sessionIdTxt.text(room.roomId);

			if (room.csService) {
				var chatbotNm = getChatbotNm(room.csService);
				if (chatbotNm) {
					csServiceTxt.text(chatbotNm);
				} else {
					csServiceTxt.text(room.csService);
				}
			}

			if (room.csCategory) {
				csCategoryTxt.text(room.csCategory);
			}
			userIdTxt.text(room.userId);

			openChatWindow(room['roomId'], room['csService'], room['userId']);

			var a =room['available'];
			var b = room['bot'];
			if (!room['available'] && !room['bot']) {
				$('textarea[name="user_message"]').attr('disabled', false);
				$('#btn_intervention').addClass('hide');
				$('#btn_intervention_stop').removeClass('hide');
				$('.btn_lyr_open').removeClass('on');
			}else{
				$('#btn_intervention').removeClass('hide');
				$('#btn_intervention_stop').addClass('hide');
				$('.chat_end').removeClass('on');
			}
		};

		var getChatbotNm = (no) => {
			if (chatbotInfos) {
				var chatbot = chatbotInfos.filter((account) => {
					return account.No == no});
				if (chatbot[0])
					return chatbot[0].Name;
			}
		};


		var clearChat=function(){
			chatBox.html("");
		};

		var addChat = function (talkObj) {

			let talker = talkObj.userType;
			let msg = talkObj.message;
			let date = talkObj.date;
			let time = talkObj.timeDetail;
			let adapterResponse = talkObj.adapterResponse;

			var clone;

			if (!adapterResponse) {
				if (talker === 'supporter') {
					clone = userChatElemClone.clone();
					clone.find(".txt").html(msg);
					clone.find(".txt").find("a").removeAttr("href");
					clone.find(".txt").find("a").wrap('<div class="txt_btn"></div>');
					clone.find(".date").text(time);

				} else if (talker === 'user') {
					clone = botChatElemClone.clone();
					clone.find(".txt").html(msg);
					clone.find(".txt").find("a").removeAttr("href");
					clone.find(".txt").find("a").wrap('<div class="txt_btn"></div>');
					clone.find(".date").text(time);

				} else if (talker === 'system') {
					clone = sysChatElemClone.clone();
					clone.find("span").html(msg);
				}
			} else {
				createBotMsg(adapterResponse);
			}


			if(clone && msg){
				chatBox.append(clone);
				$(".m_chatting .lst_talk").append(clone);
				$(".chatUI_mid.btmUi").scrollTop($(".lst_talk").height());
			}


			/**
			 if (talkObj.expectedIntents && talkObj.expectedIntents.length > 0){
				talkObj.expectedIntents.forEach(intent => {
					if (intent.displayType == 'B') {
						var intentBtn = $('<li><a href="#"></a></li>');
						intentBtn.find("a").text(intent.displayName);
						intentBtn.find("a").attr("value",intent.intent);
						clone.find(".btnItem ul").append(intentBtn);
						clone.find(".btnItem").show();
					}else if (intent.displayType == 'I') {
						var swiperElemClone = swiperElem.clone();
			            swiperElemClone.find("img").attr("src",intent.displayUrl);
						swiperElemClone.find(".item_tit").text(intent.displayName);
						swiperElemClone.find(".item_txt").text(intent.displayText);
						console.log(clone.find(".botMsg_swiper"));
						clone.eq(1).find(".swiper-wrapper").append(swiperElemClone);
						clone.eq(1).show();
					}
				});

				// swiper
				var swiper = new Swiper('.botMsg_swiper', {
					speed : 200,
					slidesPerView:2,
					spaceBetween: 10,
					centeredSlides: false,
					pagination: {
						el: '.swiper-pagination',
					clickable: true,
					},
				    navigation: {
				      nextEl: '.swiper-button-next',
				      prevEl: '.swiper-button-prev',
				    },
				});

			}
			 **/
		};

		var isViewRoomId=function(roomId){
			return chatBox.attr("room-id")===roomId;
		};

		var createBotMsg=function(response) {
			for(var index = 0 ; index < response.length; index++) {
				selectResponseType(response[index]);
			}
			selectResponseType(response);

			$('.chatbot_contents .bot_infoBox').css({'display':'none'});
			$('.chatbot_contents .lst_talk').css({'display':'block'});

			$('.chatUI_mid').scrollTop($('.chatUI_mid')[0].scrollHeight);
		};

		var selectResponseType = function (response) {
			console.log('response~~');
			console.log(response);
			if (!!response.answer) {
				var ans = response.answer;

				// map이나 inquiry 중 하나만 있다고 가정.
				// console.log(ans);

				if (ans.includes("|||MAP|||")) {
					var res = ans.split("|||MAP|||");
					botResponseMap(res[1]);
					response.answer = res[0];

				} else if (ans.includes("|||INQUIRY|||")) {
					var res = ans.split("|||INQUIRY|||");
					botResponseInquiry(res[1]);
					response.answer = res[0];
				} else if (ans.includes("|||ORDER|||")) {
					var res = ans.split("|||ORDER|||");
					botResponseOrder(res[1]);
					response.answer = res[0];
				} else if (ans.includes("|||PROMOTION|||")) {
					var res = ans.split("|||PROMOTION|||");
					botResponsePromotion(res[1]);
					response.answer = res[0];
				} else if (ans.includes("|||IMG_CAROUSEL|||")) {
					var res = ans.split("|||IMG_CAROUSEL|||");
					// 이미지 캐로셀은 예외적으로 textResponse를 먼저 처리.
					response.answer = res[0];
					if (!!response.answer) {
						botResponseText(response.answer);
					}
					response.answer = undefined;

					botResponseImgCarousel(res[1]);
				}
			}

			if (!!response.answer) {
				botResponseText(response.answer);
			}
			if (!!response.list && response.list.length > 0) {
				botResponseList(
						response.list);
			}
			if (!!response.buttons) {
				botResponseButton(response.buttons);
			}
			if (!!response.carousel && response.carousel.length
					> 0) {
				botResponseCarousel(response.carousel);
			}
			if (!!response.farewell) {
				botResponseText(response.farewell);
			}
			botResponseTime();
			makeTxtInnerButton();
		};

		return {
			addChatList: addChatList,
			deleteChatList: deleteChatList,
			modifyChatList: modifyChatList,
			clearChatList: clearChatList,
			deleteChatList: deleteChatList,
			openChat: openChat,
			clearChat: clearChat,
			addChat: addChat,
			isViewRoomId: isViewRoomId
		};
	})();

	// [ predefined variables ]
	// serverURL, userType, userId, userOption,
	// csService, csCategory, firstQuestion
	console.log('[user type] : ' + userType);
	console.log('[user id]   : ' + userId);



	openChatWindow = function(roomId, csService = '', clientId = '',previousMsgs = undefined, openMsg = '') {
		console.log('[OPEN CHAT WINDOW] current room id: ' + roomId);
		curRoomId = roomId;

		if (socketClient.userType === 'supporter') {
			$('textarea[name="user_message"]').attr('disabled', true);

			// show user info
			$('div ul#chat_user_info .csService em').text(csService);
			$('div ul#chat_user_info .customerName em').text(clientId);
		}
		$("#connect_wrap").show();

		if (!previousMsgs) {
			socketClient.getPreviousMsgs(roomId);
		} else {
			writePreviousMessages(roomId, previousMsgs);
		}

		if (openMsg !== '') {
			sendMessage(openMsg);
		}

	};

	// user
	function createUserRoom() {
		let bot = true;
		socketClient.createNJoinRoom(bot, csService, csCategory).then((data) => {
			openChatWindow(data.roomId, csService, data.userId,
			data.previousMsg, firstQuestion);
	});
	}

	if (userType === 'user') {
		createUserRoom();
	}

	// (test용)상담 시작 버튼 in supporter
	$('.supporter_test_btn').click(getAvailableRoomList);

	// 상담사로 전환
	$('.dialog_change .btn_confirm').click(transferToAgent);

	// 채팅 종료
	$('.dialog_chatout .btn_confirm').click(endChat);

	// get room list from server
	function getAvailableRoomList() {
		socketClient.getAvailableRooms();
	}

	function transferToAgent() {
		console.log('transferToAgent');
		socketClient.transferToAgent();
		$('.cschat_btm .menu_open').click();
	}

	function endChat() {
		console.log('endChat');
		socketClient.endChat(curRoomId);
		// handleChatEndUI();
	}

	// 임시 소스 for GCS
	function writeChatList(rooms, option = 'av_rooms') {
		if (rooms.length === 0) {
			console.log(option + ': no available rooms.');
		}
		//let ul = document.getElementById('chat_candidates');
		//let div = ul.querySelector('div#' + option);
		//div.innerHTML = '';
		chatBotUiCtrl.deleteChatList(option);

		rooms.forEach(room => {
			let index = s4();
		let liId = 'session' + index;
		let foundRoom = roomUUIDMap.find(
				roomTemp => roomTemp.roomId === room.roomId);
		if (foundRoom) {
			foundRoom.sessionId = liId;
		} else {
			roomUUIDMap.push({roomId: room.roomId, sessionId: liId});
		}

		chatBotUiCtrl.addChatList(liId,{option:option,room:room});
	});
		setLastMsg(rooms, 0);
	}

	// 임시 소스 for GCS
	function setLastMsg(rooms, index) {
		for(var i in rooms){
			(function(room){
				// set last msg
				console.log('getPreviousMsgs:RoomId ' + room.roomId);
				socketClient.getPreviousMsgs(room.roomId);
			})(rooms[i]);
		}
	}

	writePreviousMessages=function(roomId, previousMsgs) {
		chatBotUiCtrl.clearChat();

		let talker = '';
		previousMsgs.forEach(talkObj => {
			writeMessage(roomId, talkObj.userType, talkObj);
	});
	};

	writeMessage = function(roomId, talker, talkObj) {
		console.log('writeMsg:' + roomId + talkObj.message);

		/*supporter 용 UI action*/
		if (typeof userOption !== "undefined" && userOption === 'gcs') {
			var room = roomUUIDMap.find(room => room.roomId === roomId);
			if (room) {
				let liId = room.sessionId;
				chatBotUiCtrl.modifyChatList(liId, talkObj);
			}
		}

		if (curRoomId !== roomId) {
			return;
		}
		chatBotUiCtrl.addChat(talkObj);
	};

	/*msg Input 값 받아오기*/
	function getInputMsg() {
		return $('textarea[name="user_message"]').val();
	}

	/*msg Input 창 clear*/
	function clearInputMsg() {
		$('textarea[name="user_message"]').val("");
		$('textarea[name="user_message"]').focus();
	}

	/* 채팅 스크롤 하단 유지 */
	function handleCsTalkScroll() {
		var $csTalk = $('.cschat_mid .cs_talk');
		$csTalk.scrollTop($csTalk[0].scrollHeight);
	}

	/* 상담종료 시작부터 상담평가 완료까지의 이벤트 */
	function handleChatEndUI() {
		var starScoreEl = $('.score_template').html();
		var $score = '';
		var $scoretext = '';
		var coloredScore = 0;
		var index = 0;

		// 상담 종료 버튼 클릭 시

		// 상담 평가를 완료하지 않으면 menu 버튼 클릭 불가능
		$('.user_menu .menu button').attr('disabled', true);

		// 평가표 open
		$('.cs_talk').append(
				'<li class="each_chatout">' +
				'<div class="supporter_evaluation">' +
				'<div class="text_box">\n' +
				'<em>\n' +
				'상담은 만족스러웠나요??\n' +
				'</em>\n' +
				'<p>\n' +
				'상담 평가를 남겨주시면 다음번 상담 시<br>\n' +
				'반영하도록 하겠습니다.\n' +
				'</p>\n' +
				'</div>\n' +
				'<div class="suggestion">\n' +
				starScoreEl +
				'\n<textarea name="evaluation" id="" cols="30" rows="3\n" placeholder="추가 의견 작성하기"></textarea>'
				+
				'<button type="submit" class="score_submit">완료</button>\n' +
				'</div>\n' +
				'</div>\n' +
				'</li>'
		);
		handleCsTalkScroll();
		scoreColoring();
		scoreSuccess();

		// dialog 상담평가 별점주기
		function scoreColoring() {
			$('.supporter_evaluation .score button').on('click', function () {
				$score = $('.supporter_evaluation .score');
				let thisScore = $(this).parent($('.score'));
				$scoretext = $score.find($('.score_text'));
				index = $score.index(thisScore);
				coloredScore = index + 1;
				actionColoring();
			});
		}

		// 평가 결과 채팅창에 표시
		function scoreSuccess() {
			$('.score_submit').on('click', function () {
				$('.each_chatout').empty().html(
						'<em>상담이 종료되었습니다.</em>\n' +
						'<div class="selected_score">\n' + starScoreEl + '\n</div>'
				);

				$score = $('.selected_score').find('.score');
				$scoretext = $score.find($('.score_text'));
				coloredScore = index + 1;

				$scoretext.addClass('hide');
				actionColoring();

				// 상담 평가를 완료하면 menu 버튼 클릭 가능
				$('.user_menu .menu button').attr('disabled', false);
			});
		}

		// 클릭한 별만큼 색칠하기
		function actionColoring() {
			$score.removeClass('on');
			$scoretext.removeClass('on');
			for (var i = 0; i < coloredScore; i++) {
				$score.eq(i).addClass('on');
			}
			$scoretext.eq(index).addClass('on');
		}
	}

	/* cschat_btm user메뉴 open */
	$('.cschat_btm .menu_open').on('click', function () {
		$(this).siblings('.menu').toggleClass('on');
	});

	/* 수정 200420 AMR */

	/* cschat modal
  button 클릭 시 dialog 오픈 */
	function handleCschatDialog(button, dialog) {
		button.on('click', function () {
			$('.cschat_body').addClass('backdrop');
			dialog.addClass('on');
		});

		/* close 확인 */
		dialog.find('.btn_cancel').on('click', function () {
			/* 모달 전체 close 공통 */
			$('.cschat_body').removeClass('backdrop');
			dialog.removeClass('on');
			$('.menu').removeClass('on')
		});

		/* 확인 버튼 */
		dialog.find('.btn_confirm').on('click', function () {
			/* 모달 전체 close 공통 */
			$('.cschat_body').removeClass('backdrop');
			dialog.removeClass('on');
			$('.menu').removeClass('on');
		});
	}

	handleCschatDialog($('#btn_change'), $('.dialog_change'));
	handleCschatDialog($('#btn_chatout'), $('.dialog_chatout'));

	/* dialog supporter_evaluation 별점 */
	false && $('#supporter_evaluation .score button').on('click', function () {
		var $score = $('#supporter_evaluation .score');
		var index = $score.index($(this).parent('.score'));
		var coloringScore = index + 1;

		$score.removeClass('on');

		for (var i = 0; i < coloringScore; i++) {
			$score.eq(i).addClass('on');
		}
	});

	/*채팅 Input 에서 Send Icon 클릭 시 */
	$('#btn_chat').on('click', function () {
		sendMessage();
	});

	/*채팅 Input에서 Enter 시*/
	$('textarea[name="user_message"]').keyup(
			function (e) {
				e.preventDefault();
				var code = e.keyCode ? e.keyCode : e.which;
				// EnterKey
				if (code === 13) {
					// shift + Enter
					if (e.shiftKey != true) {
						// todo: 필요한지 확인.
						//$('.chatUI_btm #btn_chat').submit();
						//$('.chatUI_btm .textArea').val('');
						sendMessage($(this).val());
					}
					return false;
				}
			});

	function sendMessage(msg = '') {
		if (msg === '') {
			msg = getInputMsg();
		}

		if (msg !== '') {
			writeMessage(curRoomId, 'supporter', {message: msg,date: getDate(),timeDetail: getTime(),time:getTime(),userType:'supporter'});
			socketClient.send2Server(msg);
			clearInputMsg();
		}
	}



	// 임시 소스 for GCS
	if (typeof userOption !== "undefined" && userOption === 'gcs') {
		roomUUIDMap = [];
		// socket client for CHATBOT MONITORING
		// chatbotMonitor = new ChatbotMonitorSocket(userType, userId);
		// chatbotMonitor.setEventListeners(writeMessage, writeChatList);


		// (gcs/supporter용) 상담개입 버튼
		$('#btn_transfer_cslor').click(function () {
			console.log('(gcs)상담개입:' + curRoomId);
			if (curRoomId) {
				socketClient.joinRoom(curRoomId).then(data => {
					// message 입력창 활성화
					$('textarea[name="user_message"]').attr('disabled',false);
				$('#btn_intervention').addClass('hide');
				$('#btn_intervention_stop').removeClass('hide');
				$('.menu').removeClass('on');
				$('.chat_end').addClass('on');
				$('.btn_lyr_open').removeClass('on');

			})
			.catch(function (err) {
					console.log(err); // Error: Request is failed
				});
			}
		});

		// (gcs/supporter용) 상담종료 버튼
		$('#btn_call_end').click(function () {
			console.log('(gcs)상담종료:' + curRoomId);
			if (curRoomId) {
				socketClient.endUserChat(curRoomId);
				// message 입력창 비활성화
				$('textarea[name="user_message"]').attr('disabled',true);
				// 대화창 clear
				$('.m_chatting .lst_talk').html('');
				// 챗봇, 세션 정보 clear
				$('.chatbot_info_table td.cs_service').html('');
				$('.chatbot_info_table td.session_id').html('');
				$('.chatbot_info_table td.user_id').html('');

				$('#btn_intervention').addClass('hide');
				$('#btn_intervention_stop').addClass('hide');

				curRoomId = undefined;
			}
		});

	}

	// socket client for TALKING
	let socketClient = new SocketClient(userType, userId);
	socketClient.setEventListeners(writeMessage, writeChatList, handleChatEndUI);

	getAvailableRoomList();
	if (window.location.href.includes('mobileChatting')) {
		chatBotUiCtrl.openChat(chatRoomVO);
	}

});

function getDate() {
	let today = new Date();
	let year = today.getFullYear(); // 년도
	let month = today.getMonth() + 1;  // 월
	let date = today.getDate();  // 날짜
	let day = today.getDay();  // 요일
	let day_han = new Array('일', '월', '화', '수', '목', '금', '토');
	let res = year + '년 ' + month + '월 ' + date + '일 ' + day_han[day] + '요일';
	return res;
}

function getTime() {
	let today = new Date();
	let time = today.getHours().toString().padStart(2, '0')
			+ ":" + today.getMinutes().toString().padStart(2, '0')
			+ ":" + today.getSeconds().toString().padStart(2, '0');
	return time;
}

function s4(){
	return ((1 + Math.random()) * 0x10000 | 0).toString(16).substring(1);
}

function beforeTimeStr(dateStr,timeStr){
	if(!dateStr || !timeStr){
		return timeStr;
	}
	dateStr=dateStr.substr(0,dateStr.indexOf("요일")-2);
	var toDay = new Date();
	var newDay = new Date((dateStr+" "+timeStr).replace("년","-").replace("월","-").replace("일",""));



	if(toDay.toDateString()==newDay.toDateString()){
		return (newDay.getHours()>12?message["오후"]:message["오전"])+" "+timeStr;
	}

	toDay.setDate(toDay.getDate()-1);
	if(toDay.toDateString()==newDay.toDateString()){
		return message["어제"];
	}

	return dateStr.replace("년","-").replace("월","-").replace("일","");
}

function getTimeStr(dateStr,timeStr){
	if(!dateStr || !timeStr){
		return new Date().getTime();
	}
	dateStr=dateStr.substr(0,dateStr.indexOf("요일")-2);
	return new Date((dateStr+" "+timeStr).replace("년","-").replace("월","-").replace("일","")).getTime();
}


















function botResponseMap(map_response) {
	var jsonRes = JSON.parse(map_response);
	// console.log(jsonRes)

	var mapSelectHtml =
			'   <li class="adviser"> \
          <div class="bot_msg"> \
              <div class="btnLst"> \
                  <span class="txt txt_radius">' + jsonRes.answer + '</span> \
                <div class="iptBox"> \
                    <dl class="dl_ipt"> \
                        <dt>' + jsonRes.texts.start + '</dt> \
                        <dd> \
                            <select class="select start">';

	var startCustomCheck = false;
	jsonRes.starts.forEach(function(start) {
		mapSelectHtml += '<option data-location=';
		if(start.location.hasOwnProperty("get"))
		{
			mapSelectHtml += '"' + start.location.get + '"';
			if(start.location.get == "custom")
			{
				mapSelectHtml += 'value="direct"  '
			}
		}
		else
		{
			mapSelectHtml += '\'{"lat": ' + start.location.lat + ', "lng": ' + start.location.lng + '}\' ';
		}
		if(start.selected){
			mapSelectHtml += 'selected';
			if(start.location.get == "custom")
			{
				startCustomCheck = true;
			}
		}
		mapSelectHtml +='> ' + start.name + '</option>';
	});

	mapSelectHtml +=
			'                       </select> \
                              <input type="text" name="selboxDirect" class="ipt_txt selboxDirect startInput" value="" \
      ';
	if(startCustomCheck){
		mapSelectHtml += 'style="display: inline-block;"'
	}
	mapSelectHtml += '> \
                        </dd> \
                    </dl> \
                    <dl class="dl_ipt"> \
                        <dt>' + jsonRes.texts.end + '</dt> \
                        <dd> \
                            <select class="select end"> \
    ';

	var endCustomCheck = false;
	jsonRes.ends.forEach(function(end) {
		mapSelectHtml += '<option data-location=';
		if(end.location.hasOwnProperty("get"))
		{
			mapSelectHtml += '"' + end.location.get + '"';
			if(end.location.get == "custom")
			{
				mapSelectHtml += 'value="direct" ';
			}
		}
		else
		{
			mapSelectHtml += '\'{"lat": ' + end.location.lat + ', "lng":' + end.location.lng + '}\' '
		}
		if(end.selected){
			mapSelectHtml +='selected';
			if(end.location.get === "custom")
			{
				endCustomCheck = true;
			}
		}
		mapSelectHtml +='> ' +  end.name + '</option>';
	});

	mapSelectHtml +=
			' \
                              </select> \
                              <input type="text" name="selboxDirect" class="ipt_txt selboxDirect endInput" value="" \
      ';
	if(endCustomCheck){
		mapSelectHtml += 'style="display: inline-block;"'
	}
	mapSelectHtml += '\
                            > \
                        </dd> \
                    </dl> \
                </div> \
                <div class="btnBox"> \
                    <button type="button" class="btn_point btn_map">' + jsonRes.texts.button + '</button> \
                </div> \
            </div> \
        </div>  \
        </li> \
     ';

	$('.m_chatting .lst_talk').append(
			mapSelectHtml
	);

	$('.chatUI_mid').scrollTop($('.chatUI_mid')[0].scrollHeight);

	//191129 추가
	//대화Type (출발지&도착지)
	$('.dl_ipt .select').on('change', function(){
		if ($(this).val() == 'direct') {
			$(this).parent().find('.selboxDirect').show();
		} else {
			$(this).parent().find('.selboxDirect').hide();
		}
	});

	//지도UI
	$('.btn_map').on('click', function(e){
		$('.mapWrap').removeClass('map_hide');
		$('#map').show();
		// 경로 그리기
		var start = $(this).parent().parent().find('select.start')[0];
		var startCoord = start.options[start.selectedIndex].getAttribute('data-location');
		var startData;
		if(startCoord == "current" || startCoord == "custom"){startData = startCoord;}
		else {startData = JSON.parse(startCoord);}

		var end = $(this).parent().parent().find('select.end')[0];
		var endCoord = end.options[end.selectedIndex].getAttribute('data-location');
		var endData;
		if(endCoord == "current" || endCoord == "custom"){endData = endCoord;}
		else {endData = JSON.parse(endCoord);}

		var startInput = $(this).parent().parent().find('input.startInput').val();
		var endInput = $(this).parent().parent().find('input.endInput').val();

		if(startCoord == 'custom') { $('#startLctn').val(startInput); }
		else { $('#startLctn').val(start.value); }

		if(endCoord == 'custom') { $('#endtLctn').val(endInput); }
		else { $('#endtLctn').val(end.value); }

		var panel = document.getElementById('panel');
		directionsBySelection(startData, endData,'TRANSIT', startInput, endInput, panel);
	});

	$('.btn_mapWrap_close').on('click',function(){
		$('.mapWrap').removeClass('detailTransform');
		$('.mapWrap_tit .iptBox .ipt_txt').prop('disabled',false);
		$('.mapWrap').addClass('map_hide').delay(500);
	});

}


function botResponseInquiry(iqrResponse) {
	iqrResponse = JSON.parse(iqrResponse);

	// initializeInquiryDisplsy();

	// 문의하기 및 예약하기 팝업 채우기
	// title
	$('.chatAside_hd h3').text(iqrResponse.title);
	// 이용약관
	iqrResponse.tos.forEach(function(terms){
		$('.chatAside_bd .tos p.txt').text(terms.title);
		$('.chatAside_bd .tos div.iptBox label').text(terms.check);
		$('.chatAside_bd .tos div.iptBox button.btn_terms').text(terms.btn);
	});

	// form
	$('.chatAside_bd .form p.txt').text(iqrResponse.form.comment);
	fields = iqrResponse.form.field;
	for (name in fields) {
		field = fields[name];
		title = field.title;

		$('.chatAside_bd .form dl.dlBox.form_' + name)[0].style.display = '';
		$('.chatAside_bd .form dl.dlBox.form_' + name + ' dt').text(title);

		if (field.placeholder) {
			$('.chatAside_bd .form dl.dlBox.form_' + name + ' dd input.ipt_txt').placeholder = field.placeholder
		}

		if ($('.chatAside_bd .form dl.dlBox.form_' + name + ' dd .radioBox').length !== 0) {
			// radio btn options
			for (label in field.options) {
				$('.chatAside_bd .form dl.dlBox.form_' + name + ' dd .radioBox label[for=' + label  + ']')
				.text(field.options[label].title);
			}
		}
	}

	// datetimepicker 관련 meta 설정
	if (!!fields['datetime']) {
		var meta = fields['datetime'].meta;
		$('.glyphicon-time').attr('time-data-before', meta.timePlaceholder);
		$('.glyphicon-time').attr('date-data-before', meta.datePlaceholder);

		$('.chatAside_bd .form dl.dlBox.form_datetime dd.pick_guide .pick_guide01').next().text(meta.today);
		$('.chatAside_bd .form dl.dlBox.form_datetime dd.pick_guide .pick_guide02').next().text(meta.available);
		$('.chatAside_bd .form dl.dlBox.form_datetime dd.pick_guide .pick_guide03').next().text(meta.selected);
	}

	// submit button
	$('.chatAside_bd div.btnBox button.btn_submit').text(iqrResponse.form.submitBtn);

	var $chatAside = $('.chat_inquiry').parent();

	// submit btn onclick
	var submitBtn = $('.chatAside_bd div.btnBox button.btn_submit');
	submitBtn.prop("onclick", null).off("click");
	submitBtn.on('click', function(){
		var $thisChatAside = $(this).parents($chatAside);
		if ( !!iqrResponse.tos[0] && iqrResponse.tos[0].required &&
				!!$thisChatAside.find('input[name="agreement"]').length &&
				!$thisChatAside.find('input[name="agreement"]').is(':checked') ) {
			// alert('개인정보 약관에 동의해주세요');
			alert(iqrResponse.tos[0].requireAlert);
			return;
		}
		if ( !!fields['name'] && fields['name'].required &&
				!!$thisChatAside.find('input[name="name"]').length &&
				!$thisChatAside.find('input[name="name"]').val().trim() ) {
			// alert('이름을 입력해주세요');
			alert(fields['name'].requireAlert);
			return;
		}
		if ( !!fields['gender'] && fields['gender'].required &&
				!!$thisChatAside.find('input[name="gender"]').length &&
				!$thisChatAside.find('input[name="gender"]').is(':checked') ) {
			// alert('성별을 선택해주세요');
			alert(fields['gender'].requireAlert);
			return;
		}
		if ( !!fields['tel'] && fields['tel'].required &&
				!!$thisChatAside.find('input[name="tel"]').length &&
				!$thisChatAside.find('input[name="tel"]').val().trim() ) {
			// alert('연락처를 입력해주세요');
			alert(fields['tel'].requireAlert);
			return;
		}
		if ( !!fields['email'] && fields['email'].required &&
				!!$thisChatAside.find('input[name="email"]').length &&
				!$thisChatAside.find('input[name="email"]').val().trim() ) {
			// alert('이메일을 입력해주세요');
			alert(fields['email'].requireAlert);
			return;
		}
		if ( !!fields['datetime'] && fields['datetime'].required &&
				!!$thisChatAside.find('input[name="datetime"]').length &&
				!$thisChatAside.find('input[name="datetime"]').val().trim() ) {
			// alert('날짜를 선택해주세요');
			alert(fields['datetime'].requireAlert);
			return;
		}
		if ( !!fields['inquiry'] && fields['inquiry'].required &&
				!!$thisChatAside.find('textarea[name="inquiry"]').length &&
				!$thisChatAside.find('textarea[name="inquiry"]').val().trim() ) {
			// alert('요청사항을 입력해주세요');
			alert(fields['inquiry'].requireAlert);
			return;
		}

		// 문의내용 뒷단으로 넘기기
		var genderInfo = '남자';
		if ($('input:radio[id="gender_woman"]').is(':checked')){
			genderInfo = '여자';
		}
		var inquiryData = {
			"name": $(".form_name").find("input").val(),
			"gender": genderInfo,
			"phone": $(".form_tel").find("input").val(),
			"email": $(".form_email").find("input").val(),
			"datetime": $(".form_datetime").find("input").val(),
			"add": $(".form_add").find("textarea").val(),
			"inquiryMsg": $(".form_inquiry").find("textarea").val()};

		callWSServer({"type": "intent", "input": JSON.stringify(inquiryData), "host": host, "lang":lang, "jsonData": JSON.stringify(getJsonData())});

		// success 팝업 채우기
		$('.chatAside_bd div.stnBox.popup .popup_content .popup_txt em').text(iqrResponse.form.successPopup.title);
		$('.chatAside_bd div.stnBox.popup .popup_content .popup_txt p').html(iqrResponse.form.successPopup.description);
		$thisChatAside.find('.chatAside_bd').addClass('success_screen');

	});

	// aside open
	$(document).on('click', '.inquiry_btn', function(){
		$chatAside.addClass('aside_show');
		window.parent.postMessage("aside_open", "*");
	});

	// aside close (input value 초기화 및 창 닫힘)
	$('.btn_chatAside_close').on('click', function(){
		window.parent.postMessage("aside_close", "*");
		$(this).parents($chatAside).removeClass('aside_show').find('.chatAside_bd').removeClass('success_screen');
		$(this).parents($chatAside).find('input[type="text"], input[type="tel"], textarea').val('');
		$(this).parents($chatAside).find('input[type="checkbox"], input[type="radio"]').removeAttr('checked');
	});

	// 추가 200306 AMR 약관보기
	$chatAside.find('.btn_terms').on('click', function(){
		$(this).parents('.chatAside_bd').addClass('info_screen');
	});

	$chatAside.find('.info_text .btn_point').on('click', function(){
		$(this).parents('.chatAside_bd').removeClass('info_screen');
		$chatAside.find('input[name="agreement"]').prop('checked', true);
	});
}



function botResponseOrder(orderResponse) {
	var $chatAside;
	var isCafe;
	// 현재 ui hard coding, todo: 메뉴명 db에서 가져오도록.
	if (orderResponse.includes("PAVAN")) {
		$chatAside = $('.cafe_order').parent();
		isCafe = true;
		handleChatAsideOrder();
	} else if (orderResponse.includes("DELIGHT")) {
		$chatAside = $('.food_order').parent();
		isCafe = false;
		handleChatAsideOrder();
	}

	// 추가 AMR 200412 주문하기 카테고리 메뉴 open close
	function handleChatAsideOrder() {
		var categoryBtn = $('.chatAside .chat_order .category');
		var categoryMenu = $('.chatAside .chat_order .category_menu');
		var $eachmenu = $('.chatAside .chat_order .each_menu');
		var $checkbox = $('.chatAside .chat_order .each_menu [type="checkbox"]');

		categoryBtn.on('click', function(event){
			event.preventDefault();
			var thisCategoryMenu = $(this).siblings(categoryMenu);

			if ( thisCategoryMenu.hasClass('on') ) {
				categoryMenu.removeClass('on');
			} else {
				categoryMenu.removeClass('on');
				thisCategoryMenu.toggleClass('on');
			}
		});

		// 체크박스 체크해제 시 수량 초기화
		$checkbox.on('change', function(event){
			event.preventDefault();
			var $eachmenu = $(this).parents('.each_menu');

			if ( $(this).prop('checked') == false ) {
				$eachmenu.find('.count').val('');
			}
			calcTotalPrice()
		});

		// 주문 수량을 적으면 메뉴체크
		$chatAside.find('.chat_order .count').on('keyup', function(event){
			event.preventDefault();
			var $eachmenu = $(this).parents('.each_menu');

			$eachmenu.find('[type="checkbox"]').prop('checked', Boolean(Number(this.value)));
			calcTotalPrice()
		});

		// 선택한 메뉴들 합계
		function calcTotalPrice() {
			var totalPrice = 0;
			var $total = $chatAside.find('.chat_order .total_price');

			$eachmenu.each(function(){
				var price = Number($(this).find('span.price').text().replace(/,/g, ''));
				var count = Number($(this).find('.count').val());
				totalPrice = (price * count) + totalPrice;
			});
			var priceText = '총 가격: ' + numberFormat(totalPrice) + '원';
			$total.text(priceText);
			return numberFormat(totalPrice);
		}

		function clearOrderForm () {
			// input field clear
			$chatAside.find(".chat_order input[name='name']").val('');
			$chatAside.find(".chat_order input[name='tel']").val('');
			$chatAside.find(".chat_order input[name='email']").val('');
			// $(".chat_order input[name='pickupTime']").val('');
			$chatAside.find(".chat_order textarea[name='add']").val('');

			// each menu count clear
			$eachmenu.each(function(){
				$(this).find('.count').val(0);
			});
			// total price clear
			$chatAside.find('.chat_order .total_price').text('');
			$chatAside.find('.stn_area').scrollTop($chatAside.find('.stn_area'));

			//checkbox, radio button clear
			$chatAside.find('input[type="checkbox"], input[type="radio"]').removeAttr('checked');
		}

		function checkOrderData(orderData) {
			if (!orderData.tos) {
				alert('개인정보동의 약관에 동의해주세요');
				return false;
			}
			if (orderData.name === undefined || orderData.name === '') {
				alert('이름을 입력해주세요');
				return false;
			}
			if (orderData.phone === undefined || orderData.phone === '') {
				alert('전화번호를 입력해주세요');
				return false;
			}
			if (orderData.email === undefined || orderData.email === '') {
				alert('이메일을 입력해주세요');
				return false;
			}
			if (orderData.reqList === undefined || orderData.reqList.length <= 0) {
				alert('메뉴를 선택해주세요');
				return false;
			}
			if (orderData.pickupTime === undefined || orderData.pickupTime === '') {
				if (isCafe) {alert('픽업시간을 선택해주세요');}
				else {alert('수령일자를 선택해주세요');}
				return false;
			}
			if (!isCafe && $chatAside.find('input:radio[name="take"]:checked').length <= 0) {
				alert('수령시간을 선택해주세요');
				return false;
			}
			if (orderData.payment === undefined || orderData.payment === '') {
				alert('결제방법을 선택해주세요');
				return false;
			}

			return true;
		}

		// aside open
		$(document).on('click', '.order_btn', function(){
			$chatAside.addClass('aside_show');
			window.parent.postMessage("aside_open", "*");
			// 현재 무조건 checked. todo: 삭제
			$chatAside.find('input[name="agreement"]').prop('checked', true);
		});

		// 약관보기
		$chatAside.find('.btn_terms').on('click', function(){
			$(this).parents('.chatAside_bd').addClass('info_screen');
		});

		// 약관 열어서 확인 (아직 약관 내용 없으므로 작동하지 않음)
		$chatAside.find('.chat_order .btn_point').on('click', function(){
			$(this).parents('.chatAside_bd').removeClass('info_screen');
			$chatAside.find('input[name="agreement"]').prop('checked', true);
		});


		// aside close (input value 초기화 및 창 닫힘)
		$('.btn_chatAside_close').on('click', function(){
			clearOrderForm();
			window.parent.postMessage("aside_close", "*");
			$(this).parents($chatAside).removeClass('aside_show').find('.chatAside_bd').removeClass('success_screen');
			// $(this).parents($chatAside).find('input[type="text"], input[type="tel"], textarea').val('');
			$(this).parents($chatAside).find('input[type="checkbox"], input[type="radio"]').removeAttr('checked');
		});

		/* 수정 200427 AMR주문하기 픽업시간 */
		var dpElement = $('#pickup_time');
		var dp = dpElement.datetimepicker({
			locale: 'ko',
			inline: true,
			format: 'HH:mm',
			dayViewHeaderFormat: 'YYYY 년 MM 월',
			stepping: 10,
			daysOfWeekDisabled: [0],
			disabledDates: ['2020-01-01','2020-03-01','2020-05-01','2020-05-05','2020-06-06','2020-08-15','2020-10-03','2020-10-09','2020-12-25'],
			// 01-01 새해(신정), 03-01 삼일절, 05-01 근로자의날, 05-05 어린이날, 06-06 현충일, 08-15 광복절, 10-03 개천절, 10-09 한글날, 12-25 크리스마스
			// 설날(구정)				음력 1월 1일
			// 석가탄신일(부처님오신날)	 음력 4월 8일
			// 추석						음력 8월 15일
			disabledHours: getDisabledHoursForDp(),
			icons: {
				time: 'glyphicon glyphicon-time',
				date: 'glyphicon glyphicon-calendar',
				up: 'glyphicon glyphicon-chevron-up',
				down: 'glyphicon glyphicon-chevron-down',
				previous: 'glyphicon glyphicon-chevron-left',
				next: 'glyphicon glyphicon-chevron-right',
				today: 'glyphicon glyphicon-screenshot',
				clear: 'glyphicon glyphicon-trash',
				close: 'glyphicon glyphicon-remove'
			}
		});

		//추가 200427 AMR datetimepicker 이전시간 선택 불가
		// 현재시간 인식해서 이전 시간 가져오기
		function getDisabledHoursForDp (selectedDate){
			var thisHour = moment().hour();
			var inactiveHours = [0,1,2,3,4,5,6,7,8,17,18,19,20,21,22,23]

			if(
					(selectedDate === undefined) ||
					(selectedDate && selectedDate.format('YYYY-MM-DD') === moment().format('YYYY-MM-DD'))
			) {
				for (var hour=0, length = thisHour; hour<length; hour++) {
					var hasHour = false
					for(var h=0, l=inactiveHours.length; h<l; h++){
						if(inactiveHours[h] === hour){
							hasHour = true
						}
					}
					if(hasHour === false){
						inactiveHours.push(hour)
					}
				}
			}

			// 24시간 모두 disabled이면 에러가 발생하여 방어코드
			if(inactiveHours.length === 24){
				inactiveHours.shift()
			}

			return inactiveHours
		}

		// 일시를 전부 사용할 때
		dpElement.on("dp.change", function(event){
			var inactiveHours = getDisabledHoursForDp(event.date);
			dp.disabledHours(inactiveHours);
		});

		// submit btn onclick
		var submitBtn = $chatAside.find('.chatAside_bd div.btnBox button.btn_submit');
		submitBtn.prop("onclick", null).off("click");
		submitBtn.on('click', function(event) {
			var orderList = [];
			$eachmenu.each(function(){
				var label = $(this).find('label').text();
				var count = Number($(this).find('.count').val());

				if (count > 0) {
					var order = [label, count + "개"];
					orderList.push(order);
				}
			});

			var checkedTake = $chatAside.find('input:radio[name="take"]:checked');
			var checkedPayment = $chatAside.find('input:radio[name="payment"]:checked');
			var pickupTime = $chatAside.find(".chat_order input[name='pickupTime']").val();
			var take = checkedTake[0] ? checkedTake.siblings("label[for='" + checkedTake[0].id + "']").text() : "";

			var orderData = {
				"tos" : $('input[name="agreement"]').is(':checked'),
				"name": $chatAside.find(".chat_order input[name='name']").val(),
				"phone": $chatAside.find(".chat_order input[name='tel']").val(),
				"email": $chatAside.find(".chat_order input[name='email']").val(),
				"pickupTime": isCafe ? pickupTime : pickupTime + '/' + take,
				"msg": $chatAside.find(".chat_order textarea[name='add']").val(),
				"totalPrice": calcTotalPrice(),
				"reqList": orderList,
				"take": isCafe ? take : '',
				"payment": checkedPayment[0]? checkedPayment.siblings("label[for='" + checkedPayment[0].id + "']").text() : ""
			};

			if (!checkOrderData(orderData)){
				return;
			}

			// console.log(orderData);

			// success 팝업 채우기
			$chatAside.find('.chatAside_bd div.check_order span.order_name').siblings('em').text(orderData.name);
			$chatAside.find('.chatAside_bd div.check_order span.order_phone').siblings('em').text(orderData.phone);
			$chatAside.find('.chatAside_bd div.check_order span.order_email').siblings('em').text(orderData.email);
			$chatAside.find('.chatAside_bd div.check_order span.order_take').siblings('em').text(orderData.take);
			$chatAside.find('.chatAside_bd div.check_order span.order_payment').siblings('em').text(orderData.payment);
			$chatAside.find('.chatAside_bd div.check_order span.order_pickupTime').siblings('em').text(orderData.pickupTime);
			$chatAside.find('.chatAside_bd div.check_order span.order_msg').siblings('p').text(orderData.msg);
			$chatAside.find('.chatAside_bd div.check_order span.order_totalPrice').siblings('em').text(orderData.totalPrice);
			var reqListP = $chatAside.find('.chatAside_bd div.check_order span.order_reqList').siblings('p');
			reqListP.empty();
			var orderResTxt = '';
			for (var i in orderList) {
				var order = orderList[i];
				var em = $("<em></em>").text(order[0] + ' ' + order[1]);
				orderResTxt += order[0] + ' ' + order[1] + '</br>';
				reqListP.append(em);
			}

			$chatAside.find('.chatAside_bd').addClass('success_screen');
			$chatAside.find('.chatAside_bd div.check_order .btn_point.btn_chatAside_close').off('click');
			$chatAside.find('.chatAside_bd div.check_order .btn_point.btn_chatAside_close').on('click', function (event) {
				clearOrderForm();
				callWSServer({"type": "intent",
					"input": JSON.stringify(orderData),
					"host": host, "lang":lang,
					"jsonData": JSON.stringify(getJsonData())});
				window.parent.postMessage("aside_close", "*");
				$chatAside.find('.chatAside_bd').removeClass('success_screen');
				botResponseText(orderResTxt + "주문 완료되었습니다.");
			});
		});
	}
}


function botResponsePromotion(promoResponse) {
	promoResponse = JSON.parse(promoResponse);

	$('.m_chatting .lst_talk').append(
			'<li class="bot bot_promotion"> \
      <div class="bot_msg">\
          <div class="generic"> \
              <span class="generic_img"><img src="' + promoResponse.img + '" alt="프로모션 사진"></span> \
                <span class="generic_tit">' + promoResponse.title + '</span> \
                    <div class="txt">' + promoResponse.comment + '</div> \
             </div> \
        </div>\
        </li>'
	);

	$('.chatUI_mid').scrollTop($('.chatUI_mid')[0].scrollHeight);
}

function botResponseText(botMsg) {
	$('.m_chatting .lst_talk').append(
			'<li class="adviser"> \
          <span class="cont"> \
              <em class="txt">' +
			botMsg +
			'</em> \
     </span><br>\
 </li>'
	);
	$('.chatUI_mid').scrollTop($('.chatUI_mid')[0].scrollHeight);
}


function botResponseImgCarousel(imgResponse) {
	imgResponse = JSON.parse(imgResponse);

	var imgCarouselHtml =
			'<li class="adviser"> \
          <div data-swiper-id="2" class="botMsg_swiper full_preview">\
              <div class="swiper-wrapper">';

	// img 클릭시 나오는 Back swiper를 별도로 그려줘야.
	var imgBackdropHtml =
			'<div class="popup_swipe_backdrop"> \
          <div class="popup_swipe_preview"> \
              <div class="botMsg_swiper"> \
                  <div class="swiper-wrapper">';

	for (i in imgResponse.imgList) {
		var img = imgResponse.imgList[i];
		imgCarouselHtml +=
				'<div class="swiper-slide"> \
            <a class="swiper_item" href="#" target="_self"> \
                <span class="item_img"><img src="' + img.src + '" alt="' + img.title + '"></span> \
                </a> \
            </div>';

		imgBackdropHtml +=
				'<div class="swiper-slide"> \
            <div class="swiper_item"> \
                <span class="item_img"><img src="' + img.src + '" alt="' + img.title + '"></span> \
                </div> \
            </div>';
	}

	imgCarouselHtml +=
			'</div> \
          <!-- [D] Swiper Pagination --> \
      <div class="swiper-pagination"></div> \
      <!-- [D] Swiper navigation buttons --> \
      <div class="swiper-button-prev"></div> \
      <div class="swiper-button-next"></div> \
      </div>\
  </li>';

	imgBackdropHtml +=
			'</div>\
      <!-- [D] Swiper Pagination -->\
      <div class="swiper-pagination"></div>\
      <!-- [D] Swiper navigation buttons -->\
      <div class="swiper-button-prev"></div>\
      <div class="swiper-button-next"></div>\
      <button type="button" class="btn_popupClose"><em>팝업 닫기</em></button>\
  </div>';


	$('.chatUI_mid .lst_talk').append(imgCarouselHtml);
	$('#chatUI_wrap').append(imgBackdropHtml);

	handleSwipePopupPreviewOpenClose();
	applySwiper($('[data-swiper-id="2"]'), {slidesPerView: 1});

	$('.chatUI_mid').scrollTop($('.chatUI_mid')[0].scrollHeight);
}

function botResponseButton(button_response) {
	var button_li = "";
	var first_btn;

	if (button_response.length > 0) {
		button_response.forEach(function (button_ele) {
			button_li += '<li><a class="intent" href="#" data-display="'+ button_ele.display +'" data-intent="'+ button_ele.intent.intent +'">' + button_ele.display  + '</a></li>';
		});
	}

	first_btn = getInitComment(lang);

	button_li += '<li><a class="intent btnStart" href="#" data-display="처음으로" data-intent="처음으로">'+ first_btn +'</a></li>';

	$('.chatUI_mid .lst_talk').append(
			'<li class="adviser"> \
      <div class="bot_msg">\
          <div class="btnItem">\
              <ul>'+button_li+' </ul>\
        </div>	\
    </div>\
    </li>'
	);
	$('.chatUI_mid').scrollTop($('.chatUI_mid')[0].scrollHeight);

}

// swiper
function applySwiper (selector, option) {
	var defaultOption = {
		speed : 200,
		slidesPerView:2,
		spaceBetween: 10,
		centeredSlides: false,
		pagination: {
			el: '.swiper-pagination',
			clickable: true
		},
		navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev'
		}
	};
	return new Swiper(selector, $.extend(defaultOption, option))
}


function botResponseCarousel(carousel_response) {
	var carousel_div = "";

	carousel_response.forEach(function (carousel_ele) {
		var intent = carousel_ele.intent;

		if (!intent.displayText)  {
			intent.displayText = "";
		}

		carousel_div +=
				'<div class="swiper-slide"> \
            <a class="swiper_item intent" href="#" target="_self" data-intent="'+ intent.intent +'" data-display="'+ carousel_ele.display +'">\
                    <span class="item_img"><img src="' + intent.displayUrl + '" onError="this.src=\'/resources/images/redtie.jpg\'"></span> \
                    <span class="item_tit">'+ intent.displayName +'</span> \
					<span class="item_txt">'+ intent.displayText +'</span> \
				</a> \
			</div>';
	});

	$('.chatUI_mid .lst_talk').append(
			'<li class="bot botMsg_swiper"> \
          <div class="swiper-wrapper">'
			+ carousel_div +
			'</div> \
  <div class="swiper-pagination"></div> \
      <div class="swiper-button-prev"></div> \
      <div class="swiper-button-next"></div> \
  </li>'
	);

	var swiper_option = {
		init : false,
		speed : 200,
		slidesPerView:2,
		spaceBetween: 10,
		centeredSlides: false,
		loop: false,
		pagination: {
			el: '.swiper-pagination',
			clickable: true
		},
		navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev'
		}
	};

	if (carousel_response.length > swiper_option.slidesPerView) {
		swiper_option.loop = true;
	}

	var swiper = new Swiper('.botMsg_swiper', swiper_option);
	// var lenght = $('.botMsg_swiper').length;
	// if (lenght > 1) {
	//     for (var i = lenght-1; i > 1; i--) {
	//         if ($('.botMsg_swiper')[i].localName === 'li') {
	//             $('.botMsg_swiper')[i].swiper.init();
	//             break;
	//         }
	//     }
	// } else {
	//     $('.botMsg_swiper:last')[0].swiper.init();
	// }

	$('.botMsg_swiper:last')[0].swiper.init();
	$('.chatUI_mid').scrollTop($('.chatUI_mid')[0].scrollHeight);

}

function getInitComment(lang) {
	var first_btn;

	if (lang == "ko") {
		first_btn = "처음으로"
	}

	if (lang == "en") {
		first_btn = "Restart"
	}

	if (lang == "zh") {
		first_btn = "再起動"
	}

	if (lang == "ch") {
		first_btn = "重新启动"
	}

	return first_btn;
}

function botResponseTime() {
	// 날짜, 요일 시간 정의
	var year  = new Date().getFullYear();  //현재 년도
	var month = new Date().getMonth()+1;  //현재 월
	var date  = new Date().getDate();  //현재 일
	var week  = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');	  //요일 정의
	var thisWeek  = week[new Date().getDay()];	//현재 요일

	var ampm = new Date().getHours() >= 12 ? 'PM' : 'AM';
	var	thisHours = new Date().getHours() >=13 ?  new Date().getHours()-12 : new Date().getHours(); //현재 시
	var	thisMinutes = new Date().getMinutes() < 10 ? '0' + new Date().getMinutes() : new Date().getMinutes(); //현재 분
	var NowTime = year + "." + month + "." + date + " " + ampm + " " + thisHours + ':' + thisMinutes;

	$('.bot:last').append(
			'<div class="date">'+ NowTime +'</div>'
	);
	$('.chatUI_mid').scrollTop($('.chatUI_mid')[0].scrollHeight);
}

//추가: 20191112 유명종
//텍스트 속 버튼
function makeTxtInnerButton() {

	$('.txt').each(function(){
		var txt_btn = $(this).find('a');
		var txt_btnLength = $(this).find('a').length;
		if (txt_btnLength > 1) {
			$(this).find('a').wrapAll('<div class="txt_btns"></div>');
		} else {
			$(this).find('a').wrapAll('<div class="txt_btn"></div>');
		}
	});
}