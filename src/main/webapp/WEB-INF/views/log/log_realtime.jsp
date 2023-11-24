<%--
  Created by IntelliJ IDEA.
  User: mindslab
  Date: 2022-02-15
  Time: 오후 7:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
  <title>log > log real time</title>
</head>
<body>
  <div class="option_real">
    <div class="iptBox">
      <span>tail -f -n</span>
      <input type="text" class="ipt_txt" id="lastLineSize" value="10">
    </div>
    <div class="status_box">
      <button type="button" class="btn_secondary" id ="startPolling" data-status="start">LOG START</button>
      <button type="button" class="btn_secondary active" id = "endPolling" data-status="end">LOG STOP</button>
    </div>

    <div class="checkBox" style="display: none; padding-left: 0;">
      <input type="checkbox" id="lastline" checked>
      <label for="lastline" style="padding-left: 26px; font-size: 14px;">스크롤 하단 고정</label>
    </div>
  </div>

  <div class="realtimecodes">
    <ul>
      <%--    <li><span class="number">1</span>Lorem ipsum dolor sit amet, consectetur adipisicing elit. A accusamus aperiam beatae cumque cupiditate distinctio enim hic id impedit iure magnam, nam nostrum placeat quasi, qui rem sequi tempore vitae.</li>--%>
      <%--    <li><span class="number">2</span>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolorum ea error numquam reprehenderit sint velit? Blanditiis, consequuntur cumque ducimus esse incidunt iste iusto laboriosam nulla numquam omnis quaerat, vel vitae.</li>--%>
      <%--    <li><span class="number">3</span>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam aspernatur explicabo fugit libero modi quasi quis quisquam sit tenetur voluptatem! A autem cumque doloribus ea harum ipsum mollitia tempore voluptatem?</li>--%>
      <%--    <li><span class="number">4</span>Lorem ipsum dolor sit amet, consectetur adipisicing elit. A assumenda dicta eveniet exercitationem facilis incidunt labore molestias omnis quae quaerat, quas recusandae rerum unde! Amet natus omnis vero voluptates voluptatum!</li>--%>
      <%--    <li><span class="number">5</span></li>--%>
      <%--    <li><span class="number">6</span>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ab asperiores aut cumque dolores eius eligendi eveniet fugiat incidunt ipsum molestiae, molestias mollitia obcaecati officia quam quia quibusdam reprehenderit vero voluptatum?</li>--%>
      <%--    <li><span class="number">7</span></li>--%>
      <%--    <li><span class="number">8</span>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Alias amet aut ea minima natus placeat quo. Aperiam dicta dolor dolores ipsam itaque laudantium magni nam odit quas quasi. Natus, vel.</li>--%>
    </ul>
  </div>


<script type="text/javascript">

  function getRealtimelog(logName){



    if(eventSourceStatus == false) {
      lastLine = $('#lastLineSize').val();

      $('.realtimecodes').empty();

      if (!(lastLine > 0 && lastLine < 1001)) {
        lastLine = 10;
      }

      var eventurl = `/realtime/1?tailNsize=` + lastLine +'&logName='+logName;
      eventSource = new EventSource(eventurl);

      eventSource.onmessage = event => {

        if (event.data == null) {
          event.data = "~";
        }
        let list = $('<li></span>' + event.data + '</li>');
        $('.realtimecodes').append(list);

        if($('#lastline').prop("checked")) {
          $(".realtimecodes").scrollTop($(".realtimecodes")[0].scrollHeight);
        }

      };

      $('.checkBox').show();


      $('.status_box button').removeClass('active');
      $('#startPolling').addClass('active');
      eventSourceStatus = true;
    }



  }

  function stopGetRealtimeLog(){

    if(eventSourceStatus == true) {

      eventSource.close();
      let list = $('<li></span>' +  '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' + '</li>');
      $('.realtimecodes').append(list);

      list = $('<li></span>' + 'exit program' + '</li>');
      $('.realtimecodes').append(list);
      $(".realtimecodes").scrollTop($(".realtimecodes")[0].scrollHeight);

      $('.status_box button').removeClass('active');


      $('#endPolling').addClass('active');

      $('.checkBox').hide();
      eventSourceStatus = false;
    }
  }

  var eventSourceStatus = false;
  var eventSource = null;




  $(document).ready(function() {

    let logName = '${logName}';


    $('#startPolling').on('click', function(){
      getRealtimelog(logName);
    });

    $('#endPolling').on('click', function(){
      stopGetRealtimeLog();
    });


    $('#lastline').on('change', function(){
      var $this = $(this);
      var checked = $this.prop("checked");


      if( checked ){
        console.log('check true');
        $(".realtimecodes").scrollTop($(".realtimecodes")[0].scrollHeight);

        // $(this).removeClass('active');
      }
      else {
        console.log('check false');
        // $(this).addClass('active');
      }
    });

    $('#lastLineSize').keyup(function (event){


      if(event.keyCode==13) {

        if (eventSourceStatus == false) {
          getRealtimelog(logName);
        } else {
          stopGetRealtimeLog();
        }
      }

    })

  })


</script>
</body>
</html>
