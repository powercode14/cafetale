<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">

var followingList;
var memberSearchList;
var followPageIndex = 0;
$(document).ready(function(){
	$('#followmodal').on('show.bs.modal', function(){
		followSelector(followPageIndex);
	});
	
	$('#followmodal').on('hidden.bs.modal', function(){
		removeall();
	});
});

function showFollowModal(index){
	followPageIndex = index;
	$('#followmodal').insertAfter('.modal.fade:last');
	$('#followmodal').modal('show');
}

var ul = $("#followtabs");
var lis = $("#followtabs>li");

function getFollowData(url){
	var followData;
	$.ajax({
		type: "GET",
		url: "${root}/" + url + ".cafetale",
		data: {memberId:"${loginUserInfo.member_id}"},
		dataType: "json",
		async: false,
		success: function(data) { //java쪽에서 json을 넘겨줘야함
			followData = data;
		},
		error: function(e) {
			alert("에러" + e + url);
		}
	});
	return followData;
}

var followPageUtil = function(listIndex){
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
					followPagination(--c, listIndex);
				}
			})(this.curPage);
		}
		$('#followPagination').append(prevLi);
		for(var i=1; i<=this.pageNumber; i++){
			var pageLi = document.createElement('li');
			if(i==this.curPage){
				pageLi.className = 'active';
				pageLi.innerHTML = '<a href="#">'+ i +'<span class="sr-only">(current)</span></a>';
			} else {
				pageLi.innerHTML = '<a href="#">'+ i +'</a>';
				pageLi.onclick = (function(i){
					return function(){
						followPagination(i, listIndex);
					}
				})(i);
			}
			$('#followPagination').append(pageLi);
		}
		var nextLi = document.createElement('li');
		nextLi.innerHTML = '<a href="#" aria-laber="Next"><span aria-hidden="true">&raquo;</span></a>';
		if(this.curPage == this.pageNumber){
			nextLi.className = 'disabled';
		} else {
			nextLi.onclick = (function(c) {
				return function(){
					followPagination(++c, listIndex);
				}
			})(this.curPage);
		}
		$('#followPagination').append(nextLi);
	}
}

function followPagination(curPage, listIndex){
	removePagination();
	var util = new followPageUtil(listIndex);
	if(listIndex == 1){
		followingList = getFollowData('following').followingList;
	}
	util.totalCnt = Object.keys(listIndex == 1 || listIndex == 3 ? followingList : memberSearchList).length;
	util.pageCnt = 5;
	util.setCurPage(curPage);
	util.setPageNumber();
	util.setStartEnd();
	makelist(util.start, util.end, listIndex);
	util.draw();
}

function removePagination(){
	if($('#followPagination').has('li') != 0){
		$('#followPagination').children().remove();
	}
}

function makelist(start, end, listIndex){
	removelist();
	var memberId;
	if(listIndex == 1 || listIndex == 3){
		$('#followtabs>li:eq(0)').addClass('active');
		$('#followtabs>li:eq(1)').removeClass('active');
		for(var i=start; i<=end; i++){
			memberId = followingList[i].member_id;
			var listStr = '<tr><td width="50%" onclick="showProfile(\''+ memberId +'\')"><div class="img-circle" style="width: 25px; height: 25px; overflow: hidden; margin-left:25%; margin-right: 2%; float: left;">';
			listStr += '<img src="${root}/getUserImage.cafetale?member_id='+ memberId +'" style="width: 100%; height: auto; position: relative; top: 50%; left: 50%; transform: translate(-50%, -50%); -webkit-transform: translate(-50%, -50%);"> </div>';
			listStr += '<span>' + memberId + '(' + followingList[i].member_name + ')</span></td>';
			listStr += '<td width="50%" align="center"><button type="button" id="'+ memberId +'button"></button></td></tr>';
			$('#followlist').append(listStr);
			if(followingList[i].state == 'following'){
				changebutton(memberId + 'button', 2);
			} else if(followingList[i].state == 'friend'){
				changebutton(memberId + 'button', 3);
			} else if(followingList[i].state == 'follower'){
				changebutton(memberId + 'button', 4);
			}
		}
	} else {
		for(var i=start; i<=end; i++){
			var spanStr, searchKeyword = $('#friendSearchKeyword').val();
			memberId = memberSearchList[i].member_id, nameStr = memberSearchList[i].member_name;
			if(memberId.includes(searchKeyword)){
				spanStr = memberId.substring(0, memberId.indexOf(searchKeyword));
				spanStr += '<span style="background-color: yellow">' + memberId.substring(memberId.indexOf(searchKeyword), memberId.indexOf(searchKeyword) + searchKeyword.length) + '</span>';
				spanStr += memberId.substring(memberId.indexOf(searchKeyword) + searchKeyword.length);
			} else {
				spanStr = memberId;
			}
			if(nameStr.includes(searchKeyword)){
				spanStr += '(' + nameStr.substring(0, nameStr.indexOf(searchKeyword));
				spanStr += '<span style="background-color: yellow">' + nameStr.substring(nameStr.indexOf(searchKeyword), nameStr.indexOf(searchKeyword) + searchKeyword.length) + '</span>';
				spanStr += nameStr.substring(nameStr.indexOf(searchKeyword) + searchKeyword.length) + ')';
			} else {
				spanStr += '('+ nameStr +')';
			}
			var listStr = '<tr><td width="50%" onclick="showProfile(\''+ memberId +'\')"><div class="img-circle" style="width: 25px; height: 25px; overflow: hidden; margin-left:25%; margin-right: 2%; float: left;">';
			listStr += '<img src="${root}/getUserImage.cafetale?member_id='+ memberSearchList[i].member_id +'" style="width: 100%; height: auto; position: relative; top: 50%; left: 50%; transform: translate(-50%, -50%); -webkit-transform: translate(-50%, -50%);"> </div>';
			listStr += spanStr + '</td>';
			listStr += '<td width="50%" align="center"><button type="button" id="'+ memberId +'button"></button></td></tr>';
			$('#followlist').append(listStr);
			if(memberSearchList[i].state == 'following'){
				changebutton(memberId + 'button', 2);
			} else if(memberSearchList[i].state == 'friend'){
				changebutton(memberId + 'button', 3);
			} else if(memberSearchList[i].state == 'follower'){
				changebutton(memberId + 'button', 4);
			} else {
				changebutton(memberId + 'button', 0);
			}
		}
	}
}


function memberSearch(keyword){
	$.ajax({
		type: "GET",
		url: "${root}/memberSearch.cafetale",
		data: {memberId:"${loginUserInfo.member_id}", keyword:keyword},
		dataType: "json",
		async: false,
		success: function(data) {
			memberSearchList = data.memberSearchList;
		},
		error: function(e) {
			alert("에러" + e);
		}
	});
}

function changebutton(id, flag){
	var button = document.getElementById(id);
	if (flag==0){
		button.innerHTML = "팔로우";
		button.value = "팔로우";
		button.setAttribute("class", "btn btn-default btn-xs");
		button.setAttribute("onclick", "javascript:addfollow(id);");
		button.setAttribute("onmouseover", "javascript:changebutton(id, 1);");
		button.setAttribute("onmouseout", "javascript:changebutton(id, 0);");
	} else if(flag==1) {
		button.innerHTML = "팔로우 추가";
		button.setAttribute("class", "btn btn-info btn-xs");
	} else if(flag==2) {
		button.innerHTML = "팔로잉";
		button.value = "팔로잉";
		button.setAttribute("class", "btn btn-success btn-xs");
		button.setAttribute("onclick", "javascript:followcancel(id);");
		button.setAttribute("onmouseover", "javascript:changebutton(id, 5);");
		button.setAttribute("onmouseout", "javascript:changebutton(id, 2);");
	} else if(flag==3) {
		button.innerHTML = "프렌드";
		button.value = "프렌드";
		button.setAttribute("class", "btn btn-primary btn-xs");
		button.setAttribute("onclick", "javascript:followcancel(id);");
		button.setAttribute("onmouseover", "javascript:changebutton(id, 5);");
		button.setAttribute("onmouseout", "javascript:changebutton(id, 3);");
	} else if(flag==4) {
		button.innerHTML = "팔로워";
		button.value = "팔로워";
		button.setAttribute("class", "btn btn-warning btn-xs");
		button.setAttribute("onclick", "javascript:addfollow(id);");
		button.setAttribute("onmouseover", "javascript:changebutton(id, 1);");
		button.setAttribute("onmouseout", "javascript:changebutton(id, 4);");
	} else if(flag==5) {
		button.innerHTML = "팔로우 취소";
		button.setAttribute("class", "btn btn-danger btn-xs");
	}
}

function createsearchbox(){
	removesearchbox();
	removePagination();
	removelist();
	$('#followtabs>li:eq(0)').removeClass('active');
	$('#followtabs>li:eq(1)').addClass('active');
	var searchBoxStr = '<div id="friendsearchdiv" class="input-group"><input type="text" class="form-control" id="friendSearchKeyword" name="friendSearchKeyword" placeholder="아이디 또는 이름 입력"></div>';
	$('#followtabs').append(searchBoxStr);
	$('#friendSearchKeyword').on('keyup', function(e){
		var key = e.keyCode || e.charCode;
		if(e.which !== 0 || key == 8 || key == 46) {
			var searchKeyword = $('#friendSearchKeyword').val();
			if(searchKeyword){
				memberSearch(searchKeyword);
				followPagination(1, 2);
			} else {
				removePagination();
				removelist();
			}
		}
	});
}

function removesearchbox(){
	if(document.getElementById("followtabs").hasChildNodes()){
		$("#friendsearchdiv").remove();
	}
}

function removelist(){
	if(document.getElementById("followlist").hasChildNodes()){
		$("#followlist").children().remove();
	}
}

function removeall(){
	removesearchbox();
	removelist();
}

function addfollow(id){
	var button = document.getElementById(id);
	var buttonid = id.substring(0, id.indexOf("button"));
	var param = "loginId=${loginUserInfo.member_id}&followid=" + buttonid;
	sendRequest(root + "/addfollow.cafetale", param, addfollowresult, "GET");
	function addfollowresult(){
		if(httpRequest.readyState == 4) {
			if(httpRequest.status == 200) {
				if(button.value == "팔로우"){
					changebutton(id, 2);
				} else if(button.value == "팔로워"){
					changebutton(id, 3);
				}
				alertify.alert(buttonid + "님에게 팔로우를 요청했습니다.").set('frameless', true);
			}
		}
	}
}

function followcancel(id){
	var button = document.getElementById(id);
	var buttonid = id.substring(0, id.indexOf("button"));
	alertify.confirm('팔로우 취소', buttonid + '님을 팔로우 취소하시겠습니까?', function(){
		var param = "loginId=${loginUserInfo.member_id}&cancelid=" + buttonid;
		sendRequest(root + "/followcancel.cafetale", param, followcancelresult, "GET");
	}, function(){});
	function followcancelresult(){
		if(httpRequest.readyState == 4) {
			if(httpRequest.status == 200) {
				if(button.value == "팔로잉"){
					changebutton(id, 0);
				} else if(button.value == "프렌드"){
					changebutton(id, 4);
				}
			}
		}
	}
}

function followSelector(index){
	followingList = getFollowData('following').followingList;
	switch(index){
	case 0:
		$('#followState b').text('모두보기');
		break;
	case 1:
		$('#followState b').text('팔로잉');
		for(var i=0; i<Object.keys(followingList).length; i++){
			if(followingList[i].state != 'following'){
				followingList.splice(i, 1);
				i--;
			}
		}
		break;
	case 2:
		$('#followState b').text('팔로워');
		for(var i=0; i<Object.keys(followingList).length; i++){
			if(followingList[i].state != 'follower'){
				followingList.splice(i, 1);
				i--;
			}
		}
		break;
	case 3:
		$('#followState b').text('프렌드');
		for(var i=0; i<Object.keys(followingList).length; i++){
			if(followingList[i].state != 'friend'){
				followingList.splice(i, 1);
				i--;
			}
		}
		break;
	}
	followPagination(1, 3);
}
</script>

<style>
	#followmodal table { table-layout: fixed; word-break: break-all; }
	#followmodal th { text-align: center; margin: auto; vertical-align: middle;	}
	#followmodal tfoot td {	text-align:center; }
	#followtabs>li { font-weight: bold; text-align: center; }
	#followlist td:nth-child(1):hover { background-color: #eee };
</style>
		  <div id="followmodal" class="modal fade" role="dialog">
			<div class="modal-dialog">
			  <div class="modal-content">
			    <div class="modal-header" align="center">
			      <button type="button" class="close" data-dismiss="modal">&times;</button>
			      <h2 class="form-signin-heading">팔로우 관리 <small>follows</small></h2>
			    </div>
			    <div class="modal-body">
	              <div class="row">
	              	<ul class="nav nav-tabs" role="tablist" id="followtabs">
					  <li><a href="#" onclick="javascript:followPagination(1,1); removesearchbox(); $('#followState>button').css('visibility','visible');">팔로잉 목록</a></li>
					  <li><a href="#" onclick="javascript:createsearchbox(); $('#followState>button').css('visibility','hidden');">멤버 검색 <i class="fa fa-search" aria-hidden="true"></i></a></li>
					</ul>
					<form class="col-md-4 input-group" id="friendsearchform"></form>
		        	<table class="table">
		              <thead>
		                <tr>
		                  <th width="50%">아이디(이름)</th>
		                  <th width="50%">
		                    <b style="margin-left: 31%; margin-right: 2%;">팔로우 상태</b>
		                    <div id="followState" class="btn-group">
		                  	  <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><b>모두 보기</b>
		                  	  	<span class="caret"></span>
  							  </button>
		                      <ul class="dropdown-menu" role="menu">
							    <li><a href="#" onclick="javascript:followSelector(0);">모두 보기</a></li>
							    <li><a href="#" onclick="javascript:followSelector(1);">팔로잉</a></li>
							    <li><a href="#" onclick="javascript:followSelector(2);">팔로워</a></li>
							    <li><a href="#" onclick="javascript:followSelector(3);">프렌드</a></li>
							  </ul>
							</div>
		                  </th>
		                </tr>
		              </thead>
		              <tbody id="followlist" class="table-striped"></tbody>
		              <tfoot>
		                <tr>
		                  <td colspan="2">
		                      <ul class="pagination" id="followPagination"></ul>
		                  </td>
		                </tr>
		              </tfoot>
		          	</table>
		      	  </div>
			    </div>
			    <div class="modal-footer">
			      <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			    </div>
		      </div>
		    </div>
	      </div>