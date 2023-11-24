class SocketClient {

  constructor(userType, userId) {
    this.userType = userType;
    this.userId = userId;
    this.connected = false;
    this.avRooms = [];
    this.myRooms = [];

    // todo: should 'roomId', 'bot', 'lastTalk' be multi value?
    this.roomId = '';
    this.bot = false;
    this.lastTalk = {};

    var socket = io.connect(serverURL, {transports: ['websocket']});
    // var socket = io.connect(serverURL + '/connectors');
    this.socket = socket;

    socket.once('connection', (data) => {
      if (data.type === 'connected') {
        this.connected = true;
      }
    });

    if (window.Notification) {
      Notification.requestPermission();
    }

    this.socket.on('getPreviousMsgs', (data) => {
    	console.log('getPreviousMsgs 도착');
    	console.log(data.roomId, data.previousMsg);
    	this.roomId = data.roomId;

    	let previousMsgs = data.previousMsg;
    	let lastMsg = previousMsgs[previousMsgs.length - 1];
    	if (!lastMsg) {
    	  lastMsg = {message: '', time: ''};
    	}

    	if(chatBotUiCtrl.isViewRoomId(data.roomId)){
    		writePreviousMessages(data.roomId, previousMsgs);
    	}
    	else{
    		writeMessage(data.roomId, '', lastMsg);
    	}

    });
  }
}

var socketClient = SocketClient.prototype;

// websocket 서버에서 event 응답 시 UI action을 정의
socketClient.setEventListeners = function (writeMessage,
    writeChatList = undefined,
    handleChatEndUI = undefined) {
  this.socket.on('system', function (data) {
    writeMessage(data.roomId, 'system', data);
  });

  this.socket.on('message', (data) => {
    console.log('socketClient:getMsg');
//    if (data.roomId === this.roomId) {
    let talker = 'other';
    if (data.userId === this.userId) {
      talker = 'me';
    }
    writeMessage(data.roomId, talker, data.talkObj);
//    }
  });

  // userType: supporter
  if (this.userType === 'supporter') {
    this.socket.on('getAvailableRooms', (data) => {
      console.log('getAvailableRoom 도착');

      this.socket.emit('getMyRooms', {
        userId: this.userId
      });
      writeChatList(data.avRooms, 'av_rooms');
      writeChatList(data.botRooms, 'bot_rooms');
    });

    this.socket.on('getMyRooms', (data) => {
      console.log('getRoom 도착');
      this.myRooms = data.rooms;
      writeChatList(data.rooms, 'my_rooms');

      data.rooms.forEach(room => {
        this.joinRoom(room.roomId);
      });

    });
  }

  // userType: user
  if (this.userType === 'user') {
    this.socket.on('leaveRoom', (data) => {
      console.log('leaveRoom 도착');

      // 상담 종료 UI action
      handleChatEndUI();

    });

    // 'end Conversation' event By Server
    this.socket.on('endConversation', (data) => {
      console.log('endConversation 도착');
      this.endChat(data.roomId);
    });
  }

  this.socket.on('err', function (data) {
    alert(data.message);
  });
};

socketClient.enteringEvent = function () {
  this.socket.emit('enteringEvent', {
    roomId: this.roomId,
    userType: this.userType,
    userId: this.userId
  });
};

socketClient.bluringEvent = function () {
  this.socket.emit('bluringEvent', {
    roomId: this.roomId,
    userType: this.userType,
    userId: this.userId
  });
};

socketClient.send2Server = function (msg) {
  console.log('send msg to server:', msg);
  this.socket.emit('message', {
    roomId: this.roomId,
    userType: this.userType,
    userId: this.userId,
    message: msg
  });
};

socketClient.getAvailableRooms = function () {
  this.socket.emit('getAvailableRooms', {
    userId: this.userId
  });
};

socketClient.transferToAgent = function () {
  this.socket.emit('transferToAgent', {
    userType: this.userType,
    userId: this.userId,
    roomId: this.roomId
  });

  this.bot = false;
};

socketClient.endChat = function (roomId) {
  this.socket.emit('leaveRoom', {
    userType: this.userType,
    userId: this.userId,
    roomId: roomId
  });
};

// supporter 용
socketClient.endUserChat = function (roomId) {
  this.socket.emit('endConversation', {
    userType: this.userType,
    userId: this.userId,
    roomId: roomId
  });
};

socketClient.createRoom = function (csService, csCategory) {
  console.log('createRoom');
  this.socket.emit('createRoom',
      {
        userType: this.userType, userId: this.userId,
        csService: csService, csCategory: csCategory
      });

  return new Promise((resolve, reject) => {
    this.socket.once('createRoom', function (data) {
      console.log('createRoom 완료');
      resolve(data.roomId);
    });
  });

};

socketClient.joinRoom = function (roomId) {
  console.log('joinRoom');

  this.socket.emit('joinRoom',
      {roomId: roomId, userType: this.userType, userId: this.userId});

  return new Promise((resolve, reject) => {
    this.socket.once('joinRoom', (data) => {
      console.log('joinRoom완료');
      this.roomId = data.roomId;
      resolve(data);
    });
  });
};

socketClient.createNJoinRoom = function (bot = false, csService, csCategory) {
  console.log('createNJoinRoom');
  this.socket.emit('createNJoinRoom',
      {
        userType: this.userType, userId: this.userId,
        bot: bot, csService: csService, csCategory: csCategory
      });

  return new Promise((resolve, reject) => {
    this.socket.once('createNJoinRoom', (data) => {
      console.log('createNJoinRoom완료:' + data.roomId);
      console.log(data);
      this.roomId = data.roomId;
      this.bot = bot;
      resolve(data);
    });
  });
};

socketClient.getPreviousMsgs = function (roomId) {
  console.log('getPreviousMsgs, ' + roomId);
  this.socket.emit('getPreviousMsgs', {roomId: roomId});
};



socketClient.getMyRooms = function () {
  return this.myRooms;
};
