<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<script type="text/javascript" src="${root}/js/cafe.js"></script>
<script type="text/javascript">

var myCafeList;
var rcCafeList;

$(document).ready(function(){
	$("#mycafemodal").on('show.bs.modal', function(){
		getRcCafeList();
		getCafeList();
		myCafePagination(1, 1);
	});
	
	$("#mycafemodal").on('hide.bs.modal', function(){
		delete myCafeList;
	});
});

function getCafeList(){
	if($('#cafetabs>li:eq(1)').attr('class') == 'active'){
		$('#cafetabs>li:eq(1)').removeAttr('class');
		$('#cafetabs>li:eq(0)').attr('class', 'active');
		$('#cafetabs>li:eq(0) i').attr('class', 'fa fa-heart');
		$('#cafetabs>li:eq(1) i').attr('class', 'fa fa-thumbs-o-up');
	}
	$.ajax({
		type: "POST",
		url: "${root}/getCafeList.cafetale",
		data: {memberId:"${loginUserInfo.member_id}"},
		dataType: 'json',
		async: false,
		success: function(data) { //java쪽에서 json을 넘겨줘야함
			myCafeList = data.myCafeList;
			$('#myCafeCounter').text(myCafeList.length);
		},
		error: function(e) {
			alert("에러" + e);
		}
	});
}

function getRcCafeList(){
	if($('#cafetabs>li:eq(0)').attr('class') == 'active'){
		$('#cafetabs>li:eq(0)').removeAttr('class');
		$('#cafetabs>li:eq(1)').attr('class', 'active');
		$('#cafetabs>li:eq(0) i').attr('class', 'fa fa-heart-o');
		$('#cafetabs>li:eq(1) i').attr('class', 'fa fa-thumbs-up');
	}
	$.ajax({
		type: "POST",
		url: "${root}/getRcCafeList.cafetale",
		data: {loginId:"${loginUserInfo.member_id}"},
		dataType: 'json',
		async: false,
		success: function(data) {
			rcCafeList = data.rcCafeList;
			$('#rcCounter').text(rcCafeList.length);
		},
		error: function(e) {
			alert("에러" + e);
		}
	});
}

var pageUtil = function(listIndex){
	var totalCnt; // 전체 게시물 수
	var pageCnt; // 페이지당 게시물 수
	var curPage; // 현재 페이지
	var pageNumber;// 페이지번호 숫자
	var start;
	var end;

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
	this.draw = function(){
		var prevLi = document.createElement('li');
		prevLi.innerHTML = '<a href="#" aria-laber="Previous"><span aria-hidden="true">&laquo;</span></a>';
		if(this.curPage == 1){
			prevLi.className = 'disabled';
		} else {
			prevLi.onclick = (function(c) {
				return function(){
					myCafePagination(--c, listIndex);
				}
			})(this.curPage);
		}
		$('#myCafePagination>ul').append(prevLi);
		for(var i=1; i<=this.pageNumber; i++){
			var pageLi = document.createElement('li');
			if(i==this.curPage){
				pageLi.className = 'active';
				pageLi.innerHTML = '<a href="#">'+ i +'<span class="sr-only">(current)</span></a>';
			} else {
				pageLi.innerHTML = '<a href="#">'+ i +'</a>';
				pageLi.onclick = (function(i){
					return function(){
						myCafePagination(i, listIndex);
					}
				})(i);
			}
			$('#myCafePagination>ul').append(pageLi);
		}
		var nextLi = document.createElement('li');
		nextLi.innerHTML = '<a href="#" aria-laber="Next"><span aria-hidden="true">&raquo;</span></a>';
		if(this.curPage == this.pageNumber){
			nextLi.className = 'disabled';
		} else {
			nextLi.onclick = (function(c) {
				return function(){
					myCafePagination(++c, listIndex);
				}
			})(this.curPage);
		}
		$('#myCafePagination>ul').append(nextLi);
	}
}

function myCafePagination(curPage, listIndex){
	removeMyCafePagination();
	var util = new pageUtil(listIndex);
	util.totalCnt = Object.keys(listIndex == 1 ? myCafeList : rcCafeList).length;
	util.pageCnt = 5;
	util.setCurPage(curPage);
	util.setPageNumber();
	util.setStartEnd();
	makeMyCafeList(util.start, util.end, listIndex);
	util.draw();
}

function removeMyCafePagination(){
	if($('#myCafePagination>ul').has('li')){
		$('#myCafePagination>ul').children().remove();
	}
}

function makeMyCafeList(start, end, listIndex){
	removeMyCafeList();
	var content;
	for(var i=start; i<=end; i++){ //listIndex가 2일때(rcCafeList 기능 구현해야함!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!)
		content = '<div class="panel panel-default">';
		content += '<div class="panel-heading" role="tab" id="heading'+i+'">';
		content += '<h4 class="panel-title text-center">';
		content += '<a data-toggle="collapse" data-parent="#accordion" href="#collapse'+i+'" aria-expanded="false" aria-controls="collapse'+i+'">';
		content += (listIndex == 1 ? myCafeList[i].title : rcCafeList[i].title); 
		content += '</a></h4></div>';
		content += '<div id="collapse'+i+'" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading'+i+'">';
		content += '<div class="panel-body">';
		if(listIndex == 2){
			content += '<div><i class="fa fa-clock-o" aria-hidden="true"></i> ';
			content += rcCafeList[i].rcDate + '</div>';
		}
		content += '<div class="btn-group btn-group-justified" role="group">';
		content += '<div class="btn-group" role="group">';
		content += '<button type="button" class="btn btn-default" onclick="showCafeDetailModal('+i+','+listIndex+');"><i class="fa fa-info-circle fa-lg" aria-hidden="true"></i></button></div>';
		if(listIndex == 2){
			content += '<div class="btn-group" role="group">';
			content += '<button type="button" class="btn btn-default" onclick="showComment(\'' + rcCafeList[i].memberId + '\', \'' + rcCafeList[i].message+'\');"><i class="fa fa-commenting-o fa-lg" aria-hidden="true"></i></button></div>';
		}
		content += '<div class="btn-group" role="group">';
		content += '<button type="button" class="btn btn-default" onclick="';
		content += (listIndex == 1 ? 'removeMyCafe(\''+myCafeList[i].id : 'removeRcCafe(\''+ rcCafeList[i].id + '\', \'' + rcCafeList[i].memberId); 
		content += '\');"><i class="fa fa-trash-o fa-lg" aria-hidden="true"></i></button></div></div></div></div></div>';
		$('#myCafeList').append(content);
	}
}

function showComment(memberId, message){
	alertify.alert('<b>'+memberId+'</b>님의 한마디 : '+ (message != 'null' ? message : '')).set({'frameless': true, 'modal' : false});
}

function removeMyCafe(cafeId){
	alertify.confirm('<i class="fa fa-trash-o fa-lg" aria-hidden="true"></i>&nbsp; 내 카페목록에서 삭제', '삭제하시겠습니까?', function(){
		$.ajax({
			type: 'get',
			url: '${root}/toggleGood.cafetale',
			data: {cafeId: cafeId, loginId:'${loginUserInfo.member_id}'},
			dataType: 'json',
			success: function() {
				getCafeList();
				alertify.alert('삭제되었습니다.').set({'frameless': true});
				myCafePagination(1, 1);
			},
			error: function(e) {
				alert("에러" + e);
			}
		});

	}, function(){}).set('labels', {ok:'확인', cancel:'취소'});
}

function removeRcCafe(cafeId, friendId){
	alertify.confirm('내 카페목록에서 삭제', '삭제하시겠습니까?', function(){
		$.ajax({
			type: 'get',
			url: '${root}/removeRcCafe.cafetale',
			data: {cafeId: cafeId, loginId:'${loginUserInfo.member_id}', friendId: friendId},
			success: function() {
				getRcCafeList();
				alertify.alert('삭제되었습니다.').set({'frameless': true});
				myCafePagination(1, 2);
			},
			error: function(e) {
				alert("에러" + e);
			}
		});

	}, function(){}).set('labels', {ok:'확인', cancel:'취소'});
}
/*
 *  j.put("id", dto.getCafe_id());
	j.put("title", dto.getCafe_title());
	j.put("newAddress", dto.getCafe_newAddress());
	j.put("zipcode", dto.getCafe_zipcode());
	j.put("phone", dto.getCafe_phone());
	j.put("image", dto.getCafe_image());
	j.put("graderate", dto.getCafe_graderate());
	j.put("good", dto.getCafe_good());
	j.put("rcDate", dto.getRc_date());
	j.put("friendId", dto.getFriend_id());
	j.put("message", dto.getMessage());
 */

function showCafeDetailModal(i, listIndex){
	showCafeModal(listIndex==1?myCafeList[i]:rcCafeList[i], '${loginUserInfo.member_id}');
}

function removeMyCafeList(){
	if($('#myCafeList').has('a')){
		$('#myCafeList').children().remove();
	}
}

/*

function insertMemo(i){
	var memo = $('#memo'+ i).val();
	$.ajax({
		type: "POST",
		url: "${root}/updateMemo.cafetale",
		data: {loginId:"${loginUserInfo.member_id}", cafeId:myCafeList[i].cafeId, memo:memo}
	});
	$('#memo'+ i).attr('readonly', true);
	$('#cafelist > tr:eq('+i+') button').attr('onclick', 'updateMemo('+i+')');
	$('#cafelist > tr:eq('+i+') button').attr('title', '메모수정');
	return false;
}

function updateMemo(i){
	$('#memo'+ i).attr('readonly', false);
	document.getElementById('memo'+i).focus();
	$('#cafelist > tr:eq('+i+') button').attr('onclick', 'insertMemo('+i+')');
	$('#cafelist > tr:eq('+i+') button').attr('title', '메모저장');
	return false;
}

function star(grade){
	var star = "";
    for(var i=0; i<parseInt(!grade ? '0' : grade); i++){
     	star += '★';
    }
    for(var i=0; i<5-parseInt(!grade ? '0' : grade); i++){
     	star += '☆';
    }
    return star;
}

 */

</script>

<style>
	#cafetabs > li { width: 50%; font-weight: bold; text-align: center; }
	table#myCafeTable {	table-layout: fixed; word-break: break-all; }
	.input-group-sm { padding:5px; }
	#myCafeTable th { padding: 5px; text-align: center; }
	#cafelist td { text-align: center; }
	#cafelist td:nth-child(2) { white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
	#cafelist td:last-child { padding: 0px;}
	#cafelist>tr:hover { background-color: #eee; }
	#pagination2 tr td { text-align: center; }
	#mycafemodal div#myCafePagination { text-align: center; }
	#mycafemodal div#myCafePagination>ul { margin-top: 0%; margin-bottom: 0%; }
</style>
		  <div id="mycafemodal" class="modal fade" role="dialog">
			<div class="modal-dialog modal-sm">
			  <div class="modal-content">
			    <div class="modal-header" align="center">
			      <button type="button" class="close" data-dismiss="modal">&times;</button>
			      <h2 class="form-signin-heading">내 카페목록 <small>my café</small></h2>
			    </div>
			    <div class="modal-body">
	              	<ul class="nav nav-tabs" role="tablist" id="cafetabs">
					  <li class="active">
					    <a href="#" onclick="javascript:getCafeList(); myCafePagination(1, 1);"><i class="fa fa-heart" aria-hidden="true"></i> <span class="badge" id="myCafeCounter"></span>
					    </a>
					  </li>
	        		  <li role="presentation">
	        		    <a href="#" onclick="javascript:getRcCafeList(); myCafePagination(1, 2);">
	        		      <i class="fa fa-thumbs-o-up" aria-hidden="true"></i> <span class="badge" id="rcCounter"></span>
	        		    </a>
	        		  </li>
					</ul>
					<div class="panel-group" id="myCafeList" role="tablist" aria-multiselectable="true">
					</div>
					<div id="myCafePagination">
					  <ul class="pagination">
					  </ul>
					</div>
			    </div>
			    <div class="modal-footer">
			      <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			    </div>
		      </div>
		    </div>
	      </div>