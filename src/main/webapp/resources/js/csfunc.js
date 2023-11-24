//ajax호출 
/*function ajaxCall(url,headerName,token, data, types) {
		$.ajax({
			method : 'POST',
			url : url,
			data : JSON.stringify(data),
			contentType : "application/json; charset=utf-8",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(headerName,token);
			},
		})
		.success(function(result) {
			alert("re="+result);
			return result;
		}).fail(function(result) {
			 return result;
		});
}*/

//콜 받았을 시 시간 표시

// 시계 시작
var timerId = null;
var count =0;
function StartCallTime(str) {
	toHHMMSS(str);
    timerId = setInterval(toHHMMSS(str), 1000);
}

// 시계 중지
function StopCallTime(str) {
	console.log(timerId);
    if(timerId != null) {
        clearInterval(timerId);
    }
}

// 현재 시간 출력
function toHHMMSS(str) {
var hh   = Math.floor(count / 3600);
var mi = Math.floor((count - (hh * 3600)) / 60);
var ss = count - (hh * 3600) - (mi * 60);
if (hh   < 10) {hh   = "0"+hh;}
if (mi < 10) {mi = "0"+mi;}
if (ss < 10) {ss = "0"+ss;}
console.log(hh + ":" + mi + ":" + ss);
console.log(str);
$("#" + str).find('.call_time').html(hh + ":" + mi + ":" + ss);
//document.getElementsByClassName("call_time").innerHTML = hh + ":" + mi + ":" + ss;
count++;
}

//form obj 만들기  name value
function serializeObject(formId) { 
	      var obj = null; 
	      try { 
	          if($("#"+formId)[0].tagName && $("#"+formId)[0].tagName.toUpperCase() == "FORM" ) { 
	              var arr = $("#"+formId).serializeArray(); 
	              if(arr){ obj = {}; 
	              jQuery.each(arr, function() { 
	                  obj[this.name] = this.value; }); 
	              } 
	          } 
	      }catch(e) { 
	          alert(e.message); 
	      }finally {} 
	      return obj; 
	    }