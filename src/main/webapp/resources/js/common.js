// MINDsLab. YMJ. 20190830

$(document).ready(function (){
	//pnb
	var pnbClicked = false;

	$('.btn_potal_ham').click(function(){
		if (!pnbClicked) {
			$(this).addClass('active');
            $('#wrap').addClass('nav_show');
            $('.nav_pnb').addClass('active');
			pnbClicked=true;
		} else {
			$(this).removeClass('active');
            $('.nav_pnb').removeClass('active');
            $(this).closest('#wrap').removeClass('nav_show');	
			pnbClicked=false;
		}
	});    

    //pnb (mouse on)
    $('.gnb').on('mouseover',function(){	
        $(this).addClass('active');
        $('#wrap').addClass('nav_show');
        $('.nav_gnb').addClass('active');
    }); 
    //pnb (mouse off)
    $('.gnb').on('mouseleave',function(){	
        $(this).removeClass('active');
        $('.nav_gnb').removeClass('active');
        $(this).closest('#wrap').removeClass('nav_show');	
    }); 
    //pnb (3depth UI변경)
    $('.gnb ul.third').each(function(){
        $(this).parent('li').addClass('arrow');

        $('.gnb ul.third li a').on('click',function(){	
            $('.gnb ul.third li').removeClass('active');    
            $(this).parent('li').addClass('active');    
        });	 
    });
    //pnb (선택된 메뉴)
    $('.nav_gnb ul.sub > li > a').on('click',function(){	
    	$('.nav_gnb ul.sub > li').removeClass('selected');  
        $(this).parent('li').addClass('selected');    
    });	 

    
    //snb
	$('.pnb .nav_pnb>li>a').on('click',function(){	
    //    $('.btn_potal_ham').removeClass('active');
    //    $('.nav_pnb').removeClass('active');
   //     $('.btn_potal_ham').closest('#wrap').removeClass('nav_show');	
   //     pnbClicked=false;
        
    //    $('.pnb .nav_pnb>li').removeClass('active');
        $(this).parent().addClass('active');     
   //     $(this).parent().find('.sub li:first').addClass('active'); 
    });    
	// $('.nav_pnb>li>.sub>li a').on('click',function(){	
   //      $('.nav_pnb>li>.sub>li').removeClass('active');
   //      $(this).parent().addClass('active');     
   //  });    
    
    //Layer popup open 
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
            $('body').css('overflow','');  
            $('body').find(hrefId).unwrap();
            //'<div class="lyrWrap"></div>'
            $('.lyr_bg').remove(); 
        });	
    });	
    
	
    //사용자 프로필
	$('.ico_profile.btn_lyr_open').on('click',function(){	
        $('.lyr_profile').show();    
    });	 
    
    // select
    $('.selectbox select').on('change',function(){
        var select_name = $(this).children('option:selected').text();
        $(this).siblings('label').text(select_name);
    });
    
    //Table all checkBox
	$('.ipt_tbl_allCheck').on('click',function(){	
        var iptTblAllCheck = $(this).is(":checked");
        if ( iptTblAllCheck ) {
          $(this).prop('checked', true);
          $(this).parents('table').find('tbody td input:checkbox').prop('checked', true);
        } else {
          $(this).prop('checked', false);
          $(this).parents('table').find('tbody td input:checkbox').prop('checked', false);
        }
        var count = $("input:checkbox[name=obCheck]:checked").length;
        var countCallQueue = $("input:checkbox[name=obCallQueueCheck]:checked").length;

        if(count > 0){
          $("#SrtAutoCall").prop("disabled",false);
        }
        else{
          $("#SrtAutoCall").prop("disabled",true);
        }
        if(countCallQueue > 0){
          $("#deleteCallQueueBtn").prop("disabled",false);
        }
        else{
          $("#deleteCallQueueBtn").prop("disabled",true);
        }
	});
    
    //checkBox checking
	$('.ipt_check').on('click',function(){	
        var iptChecking = $(this).is(":checked");
        if ( iptChecking ) {
            $(this).parents('.checking').find('.checkBox input:checkbox').prop('checked', false);
            $(this).prop('checked', true);  
        }
	});
        
    //상담사 메인화면(aside)
	$('.call_aside').each(function(){
		$('.call_aside .aside_container .adide_content').hide(); //Show first tab content
	
		//TAB On Click Event
		$('.nav_call_aside li button').on('click', function(){
            var callAsideIndex = $(this).parent('li').index()+1;
            
            $('.call_aside .aside_container .adide_content').hide();
            $('.nav_call_aside li button').removeClass('active');
            $('.call_aside').addClass('active');            
            $(this).addClass('active');
            $('.aside_container').find('.adide_content:nth-child('+ callAsideIndex +')').show();
            
			return false;
		});
        
		$('.call_aside .btn_adide_close').on('click', function(){
            $('.call_aside .aside_container .adide_content').hide();
            $('.nav_call_aside li button').removeClass('active');
            $('.call_aside').removeClass('active');  
		});
	});
    
	$('.selectBox').each(function(){
		var selectIndex = $(this).children('.select').length;
        
        if ( selectIndex == 1 ){
            $(this).children('.select').css({
                display:'block',
                width:'100%',
            });
        } else if ( selectIndex == 2 ){
            $(this).children('.select').css({
                width:'50%',
            });
        } else if ( selectIndex == 3 ){
            $(this).children('.select').css({
                width:'calc(33.3333% - 5px)',
            });
        } 
	});	
	
	// 검색 Enter key
	$(".srchArea input, .srchArea .select, .srchBox input, .srchBox .select, .use_slt_group input").keydown(function(e){
		if(e.keyCode == 13){
			var pickerLength = 0;
			for(var i = 0; i < $('.dropdown-menu').length; i++) {
				if($('.dropdown-menu').eq(i).css("display") == "block") {
					pickerLength++;
				}
			}
			
			if(pickerLength == 0) {
				if($(this).attr("class") == "select") {
					$(this).blur();
				}
				if($("#lyr_company_srch").css("display") == "block") {
					$("#srchComp").trigger("click");
				} else {
					$("#search").trigger("click");
				}
			}
		}
	});
	
	//도움말
	$('.helpBox dl dt').on('click',function(){	  
	    $('.helpBox dl').removeClass('open'); 
	    $(this).parent('dl').addClass('open');    
	});
});	

//Table scroll
var $table = $('table.scroll'),
    $bodyCells = $table.find('tbody tr:first').children(),
    colWidth;

// Adjust the width of thead cells when window resizes
$(window).resize(function() {
    // Get the tbody columns width array
    colWidth = $bodyCells.map(function() {
        return $(this).innerWidth();
    }).get();

    // Set the width of thead columns
    $table.find('thead tr').children().each(function(i, v) {
        $(v).width(colWidth[i]);
    });    
}).resize(); // Trigger resize handler

function openPopup(hrefId, title) {
    hrefId = "#" + hrefId;
    var winHeight = $(window).height() * 0.7;
    var $popup = $('body').find(hrefId);
    if ($popup.hasClass('movable')) {
        $popup.addClass('active');
        //Layer popup close
        $('.btn_lyr_close, .lyr_bg').on('click', function () {
            $popup.removeClass('active');
        });
    } else {
        if (title) {
            $('body').find(hrefId + " .lyr_cont").text(title);
        }
        
        $('body').find(hrefId).wrap('<div class="lyrWrap"></div>');
        if ($(".lyrWrap .lyr_bg").length == 0) {
            $('body').find(hrefId).before('<div class="lyr_bg"></div>');
        }
        //Layer popup close
        $('.btn_lyr_close, .lyr_bg').on('click', function () {
            $('body').css('overflow', '');
            $('body').find(hrefId).unwrap();
            if ($('body').find(hrefId).parent(".lyrWrap").next().attr("class") != "lyrWrap" && $('body').find(hrefId).parents(".lyrWrap").length == 1) {
                $('.lyr_bg').remove();
            }
        });
    }
    $('body').css('overflow', 'hidden');
    
    if (hrefId == "#alertBox") {
        var zIndex = $("#alertBox").parent().css("z-index");
        $("#alertBox").parent().css("z-index", parseInt(zIndex) + 3);
    }
    //대화 UI
    $('.lyrBox .lyr_mid').each(function () {
        $(this).css('max-height', Math.floor(winHeight) + 'px');
    });
	
	//Layer popup close 
	$('.btn_lyr_close, .lyr_bg').on('click',function(){
		$('body').css('overflow','');
		$('body').find(hrefId).unwrap();
		
		if($('body').find(hrefId).parent(".lyrWrap").next().attr("class") != "lyrWrap" && $('body').find(hrefId).parents(".lyrWrap").length == 1) {
			$('.lyr_bg').remove();
		}
	});
}

function hidePopup(hrefId){
	hrefId="#"+hrefId;
	var $popup = $('body').find(hrefId)
	if ($popup.hasClass('movable')) {
		$popup.removeClass('active');
		return;
	}
	$('body').css('overflow','');  
	$popup.unwrap();
	//'<div class="lyrWrap"></div>'
	$('.lyr_bg').remove(); 
}

function dragElement(elmnt) {
	  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
	  if (document.getElementById(elmnt.id + "header")) {
	    /* if present, the header is where you move the DIV from:*/
	    document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
	  } else {
	    /* otherwise, move the DIV from anywhere inside the DIV:*/
	    elmnt.onmousedown = dragMouseDown;
	  }

	  function dragMouseDown(e) {
	    e = e || window.event;
	    e.preventDefault();
	    // get the mouse cursor position at startup:
	    pos3 = e.clientX;
	    pos4 = e.clientY;
	    document.onmouseup = closeDragElement;
	    // call a function whenever the cursor moves:
	    document.onmousemove = elementDrag;
	  }

	  function elementDrag(e) {
	    e = e || window.event;
	    e.preventDefault();
	    // calculate the new cursor position:
	    pos1 = pos3 - e.clientX;
	    pos2 = pos4 - e.clientY;
	    pos3 = e.clientX;
	    pos4 = e.clientY;
	    // set the element's new position:
	    elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
	    elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
	  }

	  function closeDragElement() {
	    /* stop moving when mouse button is released:*/
	    document.onmouseup = null;
	    document.onmousemove = null;
	  }
	}
