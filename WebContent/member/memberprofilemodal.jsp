<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>

<style>
	#divCounter>div { text-align:center; }
	#divCafeImage>div { text-align:center; }
	#divCafeImage>div~div:nth-child(-n+5) { padding-left:0%; padding-right:0%;}
	#divCafeImage>div:not(:first-child):not(:last-child) { position:relative; height: 80px; text-align: center; border:5px ridge; }
	#divCafeImage>div:not(:first-child):not(:last-child):hover { border:hidden; }
	#divCafeImage img { width: 100%; height: 100%; }
	#divCounter label:hover { background-color:#eee; }
	#divrpcafebtn { padding-bottom: 2%; }
 	#divrpcafebtn>button { background-color: transparent; border: none; transition-duration: 0.3s; }
	#divrpcafebtn>button:hover { background-color: #008CBA; color: white; border-radius: 3px; }
	#divdefaultprofile>div.col-sm-3 { padding-left:0%; }
	#divdefaultprofile>div.col-sm-6 { padding-left:0%; padding-right:0%; }
	#divdefaultprofile div.popover { width: 220%; text-align: center; }
	#divdefaultprofile>div:nth-child(1)>h5:nth-child(1) { margin-bottom:20%; }
	#divdefaultprofile>div:nth-child(2)>h5:nth-child(1) { margin-bottom:8.5%; }
	#divdefaultprofile>div:nth-child(2)>h5:nth-child(2)>button { font-weight: bold; background-color: transparent; border: 2px solid #008CBA; border-radius: 3px;  transition-duration: 0.3s; }
	#divdefaultprofile>div:nth-child(2)>h5:nth-child(2)>button:hover { background-color: #008CBA; color: white; border-radius: 3px; }
</style>
<script type="text/javascript" src="${root}/js/cafe.js"></script>
<script>
$(document).ready(function(){
	$('#divdefaultprofile>div:eq(0) i[data-toggle="tooltip"]').tooltip({template : '<div class="tooltip" style="width: 170%;" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'});
});

function showProfile(memberId){
	getMemberDetailInfo(memberId);
	$('#memberprofilemodal').insertAfter('.modal.fade:last');
	$('#memberprofilemodal').modal();
	if($('#divdefaultprofile>div:eq(1)>h5:eq(1)').has('button').length){
		$('#divdefaultprofile>div:nth-child(2)>h5:nth-child(1)').css('margin-bottom', '5.5%');
	}
}

var goodCafeList, rcCafeId;
function getMemberDetailInfo(memberId){
	$.ajax({
		type: 'GET',
		url: '${root}/getMemberDetailInfo.cafetale',
		data: {memberId:memberId},
		dataType: "json",
		async: false,
		success: function(data) {
			$('#memberprofilemodal .form-signin-heading>span').text(memberId);
			$('#memberprofilemodal .img-circle>img').attr('src', '${root}/getUserImage.cafetale?member_id=' + memberId);
			$('#divdefaultprofile>div.col-sm-6>h5:eq(0)').text(memberId + '('+ data.member_name +')');
			var followingList = data.followingList;
			goodCafeList = data.goodCafeList;
			rcCafeId = data.member_cafe_id;
			var followingCount=0, followerCount=0, friendCount=0;
			for(var i=0; i<Object.keys(followingList).length; i++){
				if(followingList[i].state === 'following'){
					++followingCount;
				} else if(followingList[i].state === 'follower'){
					++followerCount;
				} else if(followingList[i].state === 'friend') {
					++friendCount;
				}
			}
			$('#followingCount').text(followingCount);
			$('#followerCount').text(followerCount);
			$('#friendCount').text(friendCount);
			$('#goodCount').text(Object.keys(goodCafeList).length);
			if(!data.member_rpCafe){
				$('#divdefaultprofile>div:eq(1)>h5:eq(1)').text('대표카페가 없습니다.');
			} else {
				var rcCafeButton = '<button type="button" class="btn btn-default btn-sm" data-toggle="tooltip" data-placement="bottom" title="게시판으로 이동" onclick="moveRcCafeBoard('+data.member_cafe_id+');">';
				rcCafeButton += data.member_rpCafe + '</button>';
				$('#divdefaultprofile>div:eq(1)>h5:eq(1)').html(rcCafeButton);
				$('#divdefaultprofile>div:eq(1)>h5:eq(1)>button').tooltip();
			}
			if('${loginUserInfo.member_id}' !== memberId){ //로그인아이디와 프로필을 확인하려는 멤버의 id가 다른경우
				$('#divdefaultprofile>div:eq(2)>button').css('visibility', 'hidden');
				$('#divCounter label').off('click');
			} else {
				setRpCafeButton(memberId, data.member_rpCafe);
				$('#divdefaultprofile>div:eq(2)>button').css('visibility', 'visible');
				$('#divCounter label').click(function(){
					showFollowModal($('#divCounter label').index(this)+1);
				});
			}
			cafePager(1, 1);
			cafePager(1, 2);
		},
		error: function(e) {
			alert("에러" + e);
		}
	});
}

var CafePageUtil = function(){
	var totalCnt; // 전체 게시물 수
	var pageCnt; // 페이지당 게시물 수
	var curPage; // 현재 페이지
	var start, end;
	var content;
	
	this.setStartEnd = function(){
		this.start = (this.curPage - 1) * this.pageCnt;
		this.end = this.curPage * this.pageCnt >= this.totalCnt ? this.totalCnt-1 : this.curPage * this.pageCnt-1;
	}
	
	this.getCurPage = function(){
		this.curPage;
	}

	this.setContent = function(index){
		this.content = makeGoodCafeList(this.start, this.end);
		this.content += '<nav><ul class="pager" style="margin-top: 0%; margin-bottom: 0%;"><li class="previous';
		if(this.curPage == 1){
			this.content += ' disabled"><a href="#"><span aria-hidden="true">&laquo;</span></a></li>';
		} else {
			this.content += '"><a href="#" onclick="javascript:cafePager('+ (this.curPage - 1) + ',' + 3 + ');"><span aria-hidden="true">&laquo;</span></a></li>';
		}
		this.content += '<li class="next';
		if(this.end == this.totalCnt-1){
			this.content += ' disabled"><a href="#"><span aria-hidden="true">&raquo;</span></a></li>';
		} else {
			this.content += '"><a href="#" onclick="javascript:cafePager('+ (this.curPage + 1) + ',' + 3 + ');"><span aria-hidden="true">&raquo;</span></a></li>';
		}
		this.content += '</ul></nav>';
		if(index == 2){
			$('#rpCafeBtn').popover({animation: false, html: true, content: this.content});
		} else {
			$('#divdefaultprofile div.popover-content').html(this.content);
		}
	}
	
	this.getContent = function(){
		return this.content;
	}
	
	this.draw = function(){
		if(this.curPage == 1){
			$('#divCafeImage>div:eq(0)>button').attr('disabled', 'disabled');
		} else {
			$('#divCafeImage>div:eq(0)>button').removeAttr('disabled');
			$('#divCafeImage>div:eq(0)>button').unbind('click');
			$('#divCafeImage>div:eq(0)>button').on('click', (function(c) {
				return function(){
					cafePager(--c, 1);
				}
			})(this.curPage));
		}
		if(this.end == this.totalCnt-1){
			$('#divCafeImage>div:eq(5)>button').attr('disabled', 'disabled');
		} else {
			$('#divCafeImage>div:eq(5)>button').removeAttr('disabled');
			$('#divCafeImage>div:eq(5)>button').unbind('click');
			$('#divCafeImage>div:eq(5)>button').on('click', (function(c) {
				return function(){
					cafePager(++c, 1);
				}
			})(this.curPage));
		}
	}
};

function makeGoodCafeList(start, end){
	var buttonStr = '';
	for(var i=start; i<=end; i++){
		var cafeTitle = goodCafeList[i].title;
		buttonStr += '<div id="divrpcafebtn"><button type="button" onclick="registerRpCafe(\''+ goodCafeList[i].id +'\', \''+ cafeTitle +'\')">'+ cafeTitle +'</button></div>';
	}
	return buttonStr;
}

function cafePager(curPage, index){
	removeCafePager(index);
	var util = new CafePageUtil();
	util.totalCnt = Object.keys(goodCafeList).length;
	util.pageCnt = 4;
	util.curPage = curPage;
	util.setStartEnd();
	if(index == 1){
		util.draw();
		setCafeImage(util.start, util.end);
	} else {
		util.setContent(index);
	}
}

function setCafeImage(start, end){
	for(var i=start; i<=end; i++){
		$('#divCafeImage img:eq('+(i%4)+')').attr('src', goodCafeList[i].image);
	}
	$('#divCafeImage img').each(function(i){
		if($(this).attr('src')){
			$(this).parent().css('visibility', 'visible');
			$(this).unbind('click');
			$(this).on('click', function(){
				showCafeModal(goodCafeList[i+start], '${loginUserInfo.member_id}');		
			});
		} else {
			$(this).off('click');
			$(this).parent().css('visibility', 'hidden');
		}
	});
}

function removeCafePager(index){
	if(index == 1){
		$('#divCafeImage img').attr('src', '');
		$('#divCafeImage img').removeAttr('onclick');
	} else if(index == 2) {
		$('#rpCafeBtn').popover('destroy');
	}
}

function setRpCafeButton(memberId, rpCafe){
	if(!rpCafe){
		$('#rpCafeBtn').text('등록');
	} else {
		$('#rpCafeBtn').text('변경');
	}
}

function registerRpCafe(cafeId, cafeTitle){
	alertify.confirm('대표카페 등록/변경', cafeTitle + '을(를) 대표카페로 '+ (!'${loginUserInfo.member_cafe_title}' ? '등록' : '변경' ) + '하시겠습니까?', function(){
		$.ajax({
			type: 'GET',
			url: '${root}/registerRpCafe.cafetale',
			data: {memberId:'${loginUserInfo.member_id}', cafeId:cafeId},
			success: function() {
				getMemberDetailInfo('${loginUserInfo.member_id}');
				alertify.alert('<b>등록되었습니다.</b>').set('frameless', true);
				$('#rpCafeBtn').popover('hide');
			},
			error: function(e) {
				alert('registerRpCafe 에러 : ' + e);
			}
		});
	}, function(){}).set('labels', {ok:'확인', cancel:'취소'});
}

function removePopoverPagination(){ 
	$('#divRecommend>button').popover('destroy');
}

function moveRcCafeBoard(rcCafeId){
	sessionStorage.setItem('boardPage', 1);
	sessionStorage.setItem('rcCafeId', rcCafeId);
	location.href = '${root}/moveBoard.cafetale';
}

</script>
		  <div id="memberprofilemodal" class="modal fade" role="dialog">
			<div class="modal-dialog">
			  <div class="modal-content">
			    <div class="modal-header" align="center">
			      <button type="button" class="close" data-dismiss="modal">&times;</button>
			      <h2 class="form-signin-heading"><span></span> <small>profile</small></h2>
			    </div>
			    <div class="modal-body">
	              <div class="row">
	                <div class="col-sm-3">
	                  <div class="img-circle" style="width: 60px; height: 60px; overflow: hidden; margin-left:25%; float: left;">
					    <img src="" style="width: 100%; height: auto; position: relative; top: 50%; left: 50%; transform: translate(-50%, -50%); -webkit-transform: translate(-50%, -50%);">
					  </div>
	                </div>
	                <div class="col-sm-9">
	                  <div class="row" id="divdefaultprofile">
	                    <div class="col-sm-3"> 
	                      <h5><b>아이디(이름)</b></h5>
	                      <h5><b>대표카페</b> <i class="fa fa-question-circle" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="대표카페를 등록하면 해당 카페 관련 게시물 모아보기 기능을 이용할 수 있습니다."></i></h5>
	                    </div>
	                    <div class="col-sm-6">
	                      <h5></h5>
	                      <h5></h5>
	                    </div>
	                    <div class="col-sm-3"> 
	                      <button type="button" class="btn btn-default btn-sm" style="margin-bottom:9%;" data-toggle="modal" data-target="#modifyCheckModal">프로필 수정</button>
	                      <button type="button" class="btn btn-default btn-sm has-popover" id="rpCafeBtn" data-toggle="popover" data-placement="bottom" style="float: left;">등록</button>
	                    </div>
	                  </div>
	                </div>
		      	  </div>
		      	  <br>
		      	  <div class="row" id="divCounter">
		      	    <div class="col-sm-2">
		      	      <label>
		      	        <b>팔로잉</b><br>
		      	        <b id="followingCount"></b>
		      	      </label>
		      	    </div>
		      	    <div class="col-sm-2">
		      	      <label>
		      	        <b>팔로워</b><br>
		      	        <b id="followerCount"></b>
		      	      </label>
		      	    </div>
		      	    <div class="col-sm-2">
		      	      <label>
		      	        <b>프렌드</b><br>
		      	        <b id="friendCount"></b>
		      	      </label>
		      	    </div>
		      	  </div>
		      	  <br><br>
		      	  <div class="row">
		      	    <div class="col-sm-3">
		      	      <label data-toggle="popover" data-placement="bottom">
		      	        <b>즐겨찾는 카페</b> <b id="goodCount"></b>
		      	      </label>
		      	    </div>
		      	  </div>
		      	  <br>
		      	  <div class="row" id="divCafeImage">
		      	    <div class="col-sm-2" style="margin-top:3%;">
		      	      <button class="btn btn-default btn-lg">&laquo;</button>
		      	    </div>
		      	    <div class="col-sm-2">
		      	      <img src="">
		      	    </div>
		      	    <div class="col-sm-2">
		      	      <img src="">
		      	    </div>
		      	    <div class="col-sm-2">
		      	      <img src="">
		      	    </div>
		      	    <div class="col-sm-2">
		      	      <img src="">
		      	    </div>
		      	    <div class="col-sm-2" style="margin-top:3%;">
		      	      <button class="btn btn-default btn-lg">&raquo;</button>
		      	    </div>
		      	  </div>
			    </div>
			    <div class="modal-footer">
			      <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			    </div>
		      </div>
		    </div>
	      </div>