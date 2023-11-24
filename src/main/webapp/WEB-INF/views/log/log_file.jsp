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
  <title>log > log file</title>
</head>
<body>
<ul class="select_file">
  <%--  <li class="active">catalina.out</li>--%>
  <%--  <li>catalina_1.out</li>--%>
  <%--  <li>catalina_2.out</li>--%>
  <%--  <li>catalina_3.out</li>--%>
  <%--  <li>catalina_4.out</li>--%>
</ul>

<div class="iptBox search">
  <input type="text" class="ipt_txt" id = "search_box" placeholder="다음 검색어 : enter, 이전 검색어: shift + enter">
</div>

<div class="codes">
  <ul>
  </ul>
</div>

<div class="paging" style="display: none;">
  <a class="btn_paging_first" data-value="first" onclick="handlePaging()"></a>
  <a class="btn_paging_prev" data-value="prev" onclick="handlePaging()" ></a>
  <div class="iptBox">
    <input type="text" id="page_box" class="ipt_txt" value="1">
    <span>/</span>
    <span id="max_page"></span>
  </div>
  <a class="btn_paging_next" data-value="next" onclick="handlePaging()"></a>
  <a class="btn_paging_last" data-value="last" onclick="handlePaging()"></a>
</div>

<script type="text/javascript">
  var logname = "";
  var filename = ""; // 이곳에 파일 이름 저장

  var nowPage = 0;
  var maxPage = 99;

  var searcharr = [];
  var findWord = null;
  var findPage = 0;
  var findIdx = 0;

  var loading = false;



  async function handlePaging() {

    if(loading == true){
      alert("로딩중입니다");
    }
    loading = true;

    let $target = $(event.target);
    let value = $target.attr('data-value');

    if (value === 'first') {
      nowPage = 0;
      await getLog(logname, filename, nowPage);

      $('#page_box').val(nowPage + 1);

    } else if (value === 'prev') {


      if (nowPage <= 0) {
        loading =false;
        return;}

      nowPage = nowPage - 1;
      await getLog(logname, filename, nowPage);
      $('#page_box').val(nowPage + 1);

    } else if (value === 'next') {


      if (nowPage >= maxPage - 1) {
        loading =false;
        return;}

      nowPage = nowPage + 1;
      $('#page_box').val(nowPage + 1);

      await getLog(logname, filename, nowPage);

    } else if (value === 'last') {

      nowPage = maxPage - 1;
      await getLog(logname, filename, nowPage);


      $('#page_box').val(nowPage + 1);

    }

    loading = false;

  }

  function getMaxPage(logname,fileName){



    return new Promise(function (resolve, reject){

      $.ajax({
        url: "/logfile/countline/"+logname+"?filename="+fileName,
        type: "GET",
        contentType: 'application/json',
        success:function(res){


          if(filename != fileName){
            loading = false;
            return
          }
          var cnt = res.count;


          maxPage = Math.ceil(cnt/300);

          $('#max_page').text(maxPage);

          return resolve(res);



        }
      })

    })



  }

  function getLog(logname,fileName,page){ //현재 페이지보다 하나 아래 넣어야함 1페이지면 0

    return new Promise(function (resolve, reject){

      $.ajax({
        url: "/logfile/vi/"+logname+"/"+page+"?filename="+fileName,
        type: "GET",
        async: true,
        contentType: 'application/json',
        success:function(res){

          var data = res.logData;

          $('.codes').empty();

          data.forEach(function (log, index) {
            //한 페이지당 300페이지씩 가져옴
            if(log===null){
              log = "~";
            }
            let list = $('<li><span class="number">' + (300 * page + index + 1) + '</span>'+ log +'</li>');
            $('.codes').append(list);

          })

          return resolve(res);


        }
      });

    })
  }

  function getFileList(name) {

    return new Promise(function (resolve, reject){

      $.ajax({
        url: "/logfile/filelist/" + name,
        type: "GET",
        contentType: 'application/json',
        success:function(res){

          $('.select_file').empty();

          for(let i=0; i<res.fileList.length; i++){

            if(!res.fileList[i].match(/.txt|.log|.out|.err/)){
              continue;
            }

            let list = $('<li></li>');
            list.text(res.fileList[i]+" --- "+res.fileDateList[i]);
            list.data("filename",res.fileList[i]);
            $('.select_file').append(list);
          }

          $('.select_file li').on('click', function() {

            if(loading == true){
              alert("로딩중입니다");
              return;
            }

            loading = true;
            findWord = null;

            //클릭 했을 때 로그 뿌리기
            let $this = $(this);
            $('.select_file li').removeClass('active');
            $this.addClass('active');
            $('#page_box').val('1');
            nowPage = 0;
            filename = $this.data("filename");

            let checkpromise = getMaxPage(name, filename).then(() => {

              let logData = getLog(name, filename, 0);

              $('.paging').show();
              loading = false;
            });



          });

          resolve(res);

        }
      })

    })




  }

  function findword(filename, page, word){

    return new Promise(function (resolve, reject){

      $.ajax({
        url: "/logfile/find/" + logname+'?filename='+filename +'&page='+page +'&word='+word,
        type: "GET",
        contentType: 'application/json',
        async: true,
        success: function (res){


          if(res.data === 'success'){

            nowPage = res.page;
            $('#page_box').val(nowPage+1);

            var data = res.line;
            findWord = word;
            findPage = nowPage;
            $('.codes').empty();

            let regword = new RegExp(word, "gi");

            var findfirst = -1;

            data.forEach(function (log, index) {
              //한 페이지당 300페이지씩 가져옴
              if(log===null){
                log = "~";
              }

              if(findfirst==-1&&log.match(regword)){
                findfirst = index;
              }


              highlight = log.replace(regword,"<span style='color: red'>"+word+"</span>");


              let list = $('<li><span class="number">' + (300 * nowPage+ index + 1) + '</span>'+ highlight +'</li>');
              $('.codes').append(list);
            })

            $('.codes').scrollTop(0);
            $('.codes').scrollTop( $('.codes li').eq(findfirst).offset().top-325);



          }
          else{
          }
          return resolve(res);
        }

      })

    })

  }

  function findallword(filename, page, word){

    return new Promise(function (resolve, reject){

      $.ajax({
        url: "/logfile/findall/" + logname+'?filename='+filename +'&page='+page +'&word='+word,
        type: "GET",
        contentType: 'application/json',
        async: true,
        success: function (res){


          if(res.data === 'success'){

            return resolve(res);

          }

          else{

            return resolve(res);
            alert("검색결과가 없습니다.")

          }
        },

      })



    })

  }

  function binarySearchEnter(array, targetValue) {
    let left = 0;
    let right = array.length - 1;
    while(left <= right) {
      let mid = Math.floor((left + right) / 2);
      if(array[mid] === targetValue) {
        return mid;
      }
      else if(array[mid] > targetValue) {
        right = mid - 1;
      }
      else if(array[mid] < targetValue) {
        left = mid + 1;
      }
    }
    return left;
  }

  function binarySearchShiftEnter(array, targetValue) {
    let left = 0;
    let right = array.length - 1;
    while(left <= right) {
      let mid = Math.floor((left + right) / 2);
      if(array[mid] === targetValue) {
        return mid;
      }
      else if(array[mid] > targetValue) {
        right = mid - 1;
      }
      else if(array[mid] < targetValue) {
        left = mid + 1;
      }
    }
    return right;
  }

  $(document).ready(async function() {


    if(eventSource != null){
      eventSource.close();
    }

    logname = '${logName}';

    await getFileList(logname);

    $('.status_box button').on('click', function(){

      let $this = $(this);

      $('.status_box button').removeClass('active');

      $this.addClass('active');

    });

    $('#search_box').keyup(async function (event) {



      if (event.keyCode == 13) {

        if (loading == true) {
          alert("로딩중입니다.")
          return;
        }

        loading = true;

        let $this = $(this);
        let val = $this.val().trim();


        if (event.keyCode == 13 && event.shiftKey) {
          if (val.length < 2) {
            alert("2글자 이상 입력하세요.");
            loading = false;
            return;
          }


          if (val != findWord) {

            findWord = val;
            findPage = nowPage;
            findIdx = 0;


            const [firstFindData, FindPageList] = await Promise.all([findword(filename, findPage, findWord), findallword(filename, 0, findWord)]);
            searcharr = FindPageList.page;
            if (FindPageList.page.length == 0) {
              alert("검색결과가 없습니다.")
              findWord = null;
            }
          } else if (nowPage == searcharr[findIdx]) {
            findWord = val;
            findIdx = findIdx - 1;
            if (findIdx < 0) {
              alert("파일의 처음까지 검색을 완료했습니다. 파일의 끝부터 다시 검색합니다.")
              findIdx = searcharr.length - 1;
            }
            await findword(filename, searcharr[findIdx], findWord);

          } else {

            findWord = val;
            findIdx = binarySearchShiftEnter(searcharr, nowPage);
            console.log(findIdx)
            if (findIdx < 0) {
              alert("파일의 처음까지 검색을 완료했습니다. 파일의 끝부터 다시 검색합니다.")
              findIdx = searcharr.length - 1;
            }
            await findword(filename, searcharr[findIdx], findWord);

          }
          console.log("쉬프트도 같이눌림");
        }
        else if (event.keyCode == 13) {
          if (val.length < 2) {
            alert("2글자 이상 입력하세요.");
            loading = false;
            return;
          }

          if (val != findWord) {

            findWord = val;
            findPage = nowPage;


            const [firstFindData, FindPageList] = await Promise.all([findword(filename, findPage, findWord), findallword(filename, 0, findWord)]);
            searcharr = FindPageList.page;
            console.log(FindPageList.data)
            if (FindPageList.page.length == 0) {
              alert("검색결과가 없습니다.")
              findWord = null;
            }
          }
          else if (nowPage == searcharr[findIdx]) {
            findWord = val;
            findIdx = findIdx + 1;
            if (findIdx == searcharr.length) {
              alert("파일의 끝까지 검색을 완료했습니다. 파일의 처음부터 다시 검색합니다.")
              findIdx = 0;
            }
            await findword(filename, searcharr[findIdx], findWord);

          }
          else {

            findWord = val;
            findIdx = binarySearchEnter(searcharr, nowPage);
            if (findIdx == searcharr.length) {
              alert("파일의 끝까지 검색을 완료했습니다. 파일의 처음부터 다시 검색합니다.")
              findIdx = 0;
            }
            await findword(filename, searcharr[findIdx], findWord);

          }
        }

        loading = false;
      }

    })

    $('#page_box').change(async function (){

      if(loading==true){
        alert("로딩중입니다.");
        return;
      }

      loading=true;

      let $this = $(this);
      let val = Number($this.val());

      if (val > maxPage || val < 1 || !Number.isInteger(val)) {
        loading = false;
        return;
      } else {
        nowPage = val - 1;


        $('#search_box').value = "";

        await getLog(logname, filename, nowPage);
      }

      loading = false;


    })


  })


</script>
</body>
</html>
