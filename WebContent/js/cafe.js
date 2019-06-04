var root = '/cafetale';
var cafeId, cafeTitle;
function getListItem(index, cafeInfo, loginId) {
    var el = document.createElement('li');
    el.onclick = function(){
    	showCafeModal(cafeInfo, loginId);
    };
    var itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' + '<h2><strong>' + cafeInfo.title + '</strong></h2>';
    if(cafeInfo.phone){
    	itemStr += '<span class="tel">' + cafeInfo.phone  + '</span>';
    }
    itemStr += '<span>' + cafeInfo.newAddress + '</span>';
    var star = "";
    for(var i=0; i<parseInt(cafeInfo.grade); i++){
    	star += '★';
    }
    for(var i=0; i<5-parseInt(cafeInfo.grade); i++){
    	star += '☆';
    }
	itemStr += '평점 <strong id="list_star">' + star + '</strong> | ' + '♥ <strong id="list_good">' + cafeInfo.good + '</strong></var></div>';
    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

function getCafeDetailInfo(cafeId){
	var cafeDetailInfo;
	$.ajax({
		type: 'GET',
		url: root + '/getCafeDetailInfo.cafetale',
		data: {cafeId: cafeId},
		async: false,
		success: function(data){
			cafeDetailInfo = data.cafeDetailInfo;
		},
		error: function(e) {
			alert('getCafeDetailInfo 에러 : ' + e);
		}
	});
	return cafeDetailInfo;
}

function showCafeModal(cafeInfo, loginId){
	cafeId = cafeInfo.id;
	cafeTitle = cafeInfo.title;
	$('#cafedetail_title').html(cafeTitle);
	$('#cafedetail_image').attr('src', !cafeInfo.image ? root + '/image/no_image.png' : cafeInfo.image);
	$('#cafedetail_newAddress').html('<strong>주소</strong><br>' + cafeInfo.newAddress);
	$('#cafedetail_zipcode').html('(우) ' + cafeInfo.zipcode);
	if(cafeInfo.phone){
		$('#cafedetail_phone').html('<i class="fa fa-phone" aria-hidden="true"></i> &nbsp;' + cafeInfo.phone);
	} else {
		$('#cafedetail_phone').remove();
	}
	initGood(cafeInfo, loginId);
	if(loginId){
		friend(loginId);
		popoverPagination(1, loginId);
	}
	initCafeGrade(cafeId, loginId);
	$('#cafedetailmodal').insertAfter('.modal.fade:last');
   	$('#cafedetailmodal').modal('show');
}

function initGood(cafeInfo, loginId){
	$.ajax({
		type: 'GET',
		url: root + '/initGood.cafetale',
		data: {loginId:loginId, cafeId:cafeInfo.id},
		dataType: 'text',
		success: function(data) {
			var heart = '<i id="modal_heart" class="fa fa-heart-o" title="좋아요 + 내 카페목록에 추가" aria-hidden="true" style="color:red;"></i> ';
       		$('#cafedetail_good').html(heart + '<strong id="modal_heartcount">' + cafeInfo.good + '</strong>');
			if(data == '1'){
				$('#modal_heart').attr('class', 'fa fa-heart');
				$('#cafedetail_good').attr('title', '좋아요 취소 + 내 카페목록에서 삭제');
			}
			$('#cafedetail_good').unbind('click');
			$('#cafedetail_good').click(function(){
				toggleGood(cafeInfo, loginId);
			});
		},
		error: function(e) {
			alert("에러" + e);
		}
	});
}

function toggleGood(cafeInfo, loginId){
	if(!loginId){
		alertify.alert('<b>로그인이 필요한 서비스입니다. 상단메뉴에서 로그인 해주세요.</b>').set('frameless', true);
		return false;
	}
	$.ajax({
		type: 'GET',
		url: root + '/toggleGood.cafetale',
		data: {loginId:loginId, cafeId:cafeInfo.id},
		dataType: 'text',
		success: function(data) {
			if(data == "1"){
				$('#modal_heart').attr('class', 'fa fa-heart');
				$('#cafedetail_good').attr('title', '좋아요취소 + 내 카페목록에서 삭제');
			} else {
				$('#modal_heart').attr('class', 'fa fa-heart-o');
				$('#cafedetail_good').attr('title', '좋아요 + 내 카페목록에 추가');
			}
			cafeInfo.good += parseInt(data);
			$('#modal_heartcount').html(cafeInfo.good);
			$('#list_good').html(cafeInfo.good);
		},
		error: function(e) {
			alert("에러" + e);
		}
	});
}

var friendList;
function friend(loginId){
	$.ajax({
		type: 'GET',
		url: root + '/friend.cafetale',
		data: {memberId:loginId},
		dataType: 'json',
		async: false,
		success: function(data) {
			friendList = data.friendList;
		},
		error: function(e) {
			alert("friend 에러" + e);
		}
	});
}

var popoverPageUtil = function(friendList, loginId){
	var totalCnt; // 전체 게시물 수
	var pageCnt; // 페이지당 게시물 수
	var curPage; // 현재 페이지
	var pageNumber;// 페이지번호 숫자
	var start;
	var end;
	var content;

	this.setCurPage = function(curPage){
		this.curPage = curPage;
	}
	this.getCurPage = function(){
		return this.curPage;
	}
	this.setPageNumber = function(){
		this.pageNumber = parseInt(this.totalCnt / this.pageCnt) + (parseInt(this.totalCnt % this.pageCnt) ? 1 : 0);
	}
	this.setStartEnd = function(){
		this.start = (this.curPage - 1) * this.pageCnt;
		this.end = this.curPage * this.pageCnt >= this.totalCnt ? this.totalCnt-1 : this.curPage * this.pageCnt-1;
	}
	this.setContent = function(){
		this.content = makeFriendList(this.start, this.end, loginId);
		this.content += '<nav><ul class="pager"><li class="previous';
		if(this.curPage == 1){
			this.content += ' disabled"><a href="#"><span aria-hidden="true">&laquo;</span></a></li>';
		} else {
			this.content += '"><a href="#" onclick="javascript:popoverPageMove('+ (this.curPage - 1) +', '+ loginId +');"><span aria-hidden="true">&laquo;</span></a></li>';
		}
		this.content += '<li class="next';
		if(this.curPage == this.pageNumber){
			this.content += ' disabled"><a href="#"><span aria-hidden="true">&raquo;</span></a></li>';
		} else {
			this.content += '"><a href="#" onclick="javascript:popoverPageMove('+ (this.curPage + 1) +', '+ loginId + ');"><span aria-hidden="true">&raquo;</span></a></li>';
		}
		this.content += '</ul></nav>';
		$('#divRecommend .popover-content').html(this.content);
	}
	this.getContent = function(){
		return this.content;
	}
}

function popoverPageMove(curPage, loginId){
	var util = new popoverPageUtil(friendList, loginId);
	util.totalCnt = Object.keys(friendList).length;
	util.pageCnt = 5;
	util.setCurPage(curPage);
	util.setPageNumber();
	util.setStartEnd();
	util.setContent();
}

function popoverPagination(curPage, loginId){
	removePopoverPagination();
	var util = new popoverPageUtil(friendList, loginId);
	util.totalCnt = Object.keys(friendList).length;
	util.pageCnt = 5;
	util.setCurPage(curPage);
	util.setPageNumber();
	util.setStartEnd();
	util.setContent();
	$('#divRecommend>button').popover({animation: false, html: true, content: util.getContent()});
}

function removePopoverPagination(){ 
	$('#divRecommend>button').popover('destroy');
}

function makeFriendList(start, end, loginId){
	var buttonStr = '';
	for(var i=start; i<=end; i++){
		buttonStr += '<div><button class="btn btn-default btn-sm" onclick="cafeRecommend(\'' + (friendList[i].member_id) + '\', \''+ loginId +'\')" style="text-align: center; width:100%;">';
		buttonStr += '<div class="img-circle" style="width: 30px; height: 30px; overflow: hidden; float:left; margin-right: 5%;">';
		buttonStr += '<img src="'+ root +'/getUserImage.cafetale?member_id='+ friendList[i].member_id +'" style="width: 100%; height: auto; position: relative; top: 50%; left: 50%; transform: translate(-50%, -50%); -webkit-transform: translate(-50%, -50%);">';
		buttonStr += '</div><div style="display: flex; transform: translate(0%, 30%);">' + friendList[i].member_id + '</div></button></div>';
	}
	return buttonStr;
}

function cafeRecommend(friendId, loginId){
	alertify.prompt('친구에게 추천하기', friendId + '님에게 ' + cafeTitle + '을(를) 추천하시겠습니까?<br><br>추천메시지 (생략가능)', '',
		function(e, value) {
			if(value != null){
				var strSize = (function(s,b,i,c){
				    for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
				    return b;
				})(value);
				if(strSize > 300){
					alertify.alert('<b>입력범위가 초과되었습니다. (' + strSize + '/300bytes)</b>').set('frameless', true);
				}
				$.ajax({
					type: 'GET',
					url: root + '/cafeRecoomend.cafetale',
					data: {loginId:loginId, friendId:friendId, cafeId:cafeId, message:value}
				});
				alertify.alert('<b>추천되었습니다.</b>').set('frameless', true);
			} else {
				return false;
			}
		}, function() { }
	).set('labels', {ok:'확인', cancel:'취소'});
}

function initCafeGrade(cafeId, loginId){
	$.ajax({
		type: 'GET',
		url: root + '/initCafeGrade.cafetale',
		data: {cafeId:cafeId},
		dataType: 'text',
		async: false,
		success: function(data) {
			var grade = data ? (data == '0' ? '첫 번째로 별점을 남겨주세요!' : '평점 : ' + data + '점') : '첫 번째로 별점을 남겨주세요!'; 
       	    $('#cafedetail_grade').text(grade);
	       	var star = "";
	        for(var i=0; i<parseInt(!data ? '0' : data); i++){
	         	star += '★';
	        }
	        for(var i=0; i<5-parseInt(!data ? '0' : data); i++){
	         	star += '☆';
	        }
       	    $('#list_star').html(star);
       		initGradeRating(cafeId, loginId);
		},
		error: function(e) {
			alert("initCafeGrade 에러" + e);
		}
	});
	return false;
}

function initGradeRating(cafeId, loginId){
	if(!loginId){ //로그인정보가 없으면 별점남기기 이벤트 활성화
		ratingOn(cafeId);
	} else { //로그인정보가 있으면 별점을 남겼는지 확인 후 남겼으면 남겼던 별점으로 설정, 없으면 별점남기기 이벤트 활성화
		$.ajax({
			type: 'GET',
			url: root + '/initGradeRating.cafetale',
			data: {loginId:loginId, cafeId:cafeId},
			dataType: 'text',
			async: false,
			success: function(data){
				if(data){
					var rate = data-1;
					$('.star_rating a:eq(' + rate + ')').addClass('on').prevAll('a').addClass('on');
					$('.star_rating').attr('title', '별점을 수정하려면 Click!');
					$('.star_rating').unbind('click');
					$('.star_rating').on('click', function(){
						alertify.confirm('별점 수정하기', '별점을 수정하시겠습니까?', function(){
							deleteMyRating(cafeId, loginId);
							ratingOn(cafeId, loginId);
						}, function(){}).set('labels', {ok:'확인', cancel:'취소'});
					});
				} else {
					ratingOn(cafeId, loginId);
				}
			},
			error: function(e){
				alert("initGradeRating 에러" + e);
			}
		});
	}
	return false;
}

function deleteMyRating(cafeId, loginId){
	$.ajax({
		type: 'GET',
		url: 'deleteMyRating.cafetale',
		data: {loginId:loginId, cafeId:cafeId},
		dataType: 'text',
		async: false,
		success: function(){
			initCafeGrade(cafeId);
		},
		error: function(e){
			alert("에러" + e);
		}
	});
	return false;
}

function ratingOn(cafeId, loginId){
	if(loginId) {
		$('.star_rating').attr('title', '별점을 남기려면 클릭하세요!');
	} else {
		$('.star_rating').attr('title', '별점을 주려면 로그인이 필요해요!');
	}
	$('.star_rating a').unbind('mouseover mouseout click');
	$('.star_rating a').on({
		'mouseover' : function() {
			$(this).parent().children('a').removeClass('on');
			$(this).addClass("on").prevAll('a').addClass('on');
			raty = $(this).parent().children('.on').length;
			return false;
		},
		'mouseout' : function() {
			$(this).parent().children("a").removeClass("on");
			return false;
		},
		'click' : function(){
			$(this).parent().children('a').off('mouseover mouseout click');
			$(this).parent().attr('title', '별점을 수정하려면 Click!');
			rating(loginId, cafeId, raty);
			return false;
		}
	});
}

function rating(loginId, cafeId, raty){
	if(!loginId){
		alertify.alert('<b>로그인이 필요한 서비스입니다. 상단메뉴에서 로그인 해주세요.</b>').set('frameless', true);
		return false;
	}
	$.ajax({
		type: 'GET',
		url: root + '/rating.cafetale',
		data: {loginId:loginId, cafeId:cafeId, raty:raty},
		dataType: 'text',
		async: false,
		success: function() {
			initCafeGrade(cafeId, loginId);
			alertify.alert('<b>' + raty + '점을 남겼습니다!</b>').set('frameless', true);
		},
		error: function(e) {
			alert("rating 에러" + e);
		}
	});
}