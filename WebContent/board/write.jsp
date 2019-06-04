<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
$(document).ready(function(){
	$("#boardWriteModal").on('shown.bs.modal', function(){
		memberCafePager(1, 1, 'articleCafeTitleBtn');
		$('#boardWriteModal').insertAfter('.modal.fade:last');
	});
});

function getMemberCafeInfo(){
	var cafeInfoList;
	$.ajax({
		type: 'GET',
		url: '${root}/getMemberCafeInfo.cafetale',
		data: {memberId:'${loginUserInfo.member_id}'},
		dataType: "json",
		async: false,
		success: function(data) {
			cafeInfoList = data.cafeInfoList;
		},
		error: function(e) {
			alert("getMemberCafeInfo 에러" + e);
		}
	});
	return cafeInfoList;
}

var MemberCafePageUtil = function(){
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

	this.setContent = function(cafeInfoList, id){
		this.content = makeMemberGoodCafeList(this.start, this.end, cafeInfoList, id);
		this.content += '<nav><ul class="pager"><li class="previous';
		if(this.curPage == 1){
			this.content += ' disabled"><a href="#"><span aria-hidden="true">&laquo;</span></a></li>';
		} else {
			this.content += '"><a href="#" onclick="javascript:memberCafePager('+ (this.curPage - 1) + ','+ 0 + ',\''+ id +'\');"><span aria-hidden="true">&laquo;</span></a></li>';
		}
		this.content += '<li class="next';
		if(this.end == this.totalCnt-1){
			this.content += ' disabled"><a href="#"><span aria-hidden="true">&raquo;</span></a></li>';
		} else {
			this.content += '"><a href="#" onclick="javascript:memberCafePager('+ (this.curPage + 1) + ','+ 0 + ',\''+ id +'\');"><span aria-hidden="true">&raquo;</span></a></li>';
		}
		this.content += '</ul></nav>';
	}
	
	this.getContent = function(){
		return this.content;
	}
};

function makeMemberGoodCafeList(start, end, cafeInfoList, id){
	var buttonStr = '';
	for(var i=start; i<=end; i++){
		var cafeTitle = cafeInfoList[i].cafeTitle;
		buttonStr += '<div id="mgCafeBtn"><button type="button" onclick="selectCafe(\''+ cafeTitle +'\',\'' + cafeInfoList[i].cafeId +'\',\''+ id +'\');">'+ cafeTitle +'</button></div>';
	}
	return buttonStr;
}

function memberCafePager(curPage, flag, id){
	var cafeInfoList = getMemberCafeInfo();
	var util = new MemberCafePageUtil();
	util.totalCnt = Object.keys(cafeInfoList).length;
	util.pageCnt = 5;
	util.curPage = curPage;
	util.setStartEnd();
	util.setContent(cafeInfoList, id);
	if(flag == 1){
		removeMemberCafePager(id);
		$('#'+id).popover({animation: false, html: true, content: util.getContent()});
	} else {
		$('#'+id+'+div>div.popover-content').html(util.getContent());
	}
}

function removeMemberCafePager(id){
	$('#'+id).popover('destroy');
}

function selectCafe(cafeTitle, cafeId, id){
	$('#'+id).html(cafeTitle + ' <span class="caret"></span>');
	$('#'+id).popover('hide');
	$('#'+id+'+input').val(cafeId);
}

function registerArticle(){
	$('#summernote').html($('#summernote').summernote('code'));
	$('#summernote').summernote('destroy');
	$('#boardWriteModal #content').val($('#summernote').html());
	
	var imgArr = $('#summernote>p>img').get();
	for(var i in imgArr){
		var src = $('#summernote>p>img:eq('+i+')').attr('src');
		fileList.insertRegisterFile(src.substring(src.lastIndexOf('/')+1));
	}
	$.ajax({
		type: 'GET',
		url: '${root}/registerArticle.cafetale',
		data: {
			title: $('#boardWriteModal #title').val(),
			content: $('#boardWriteModal #content').val(),
			writer_id: $('#boardWriteModal #writer_id').val(),
			cafe_id: $('#articleCafeTitleBtn+input').val(),
			allFileList: fileList.allFileList,
			registerFileList: fileList.registerFileList
		},
		success: function(data) {
			alertify.alert('<b>게시물 등록이 완료되었습니다.</b>').set({'frameless': true, 'onclose': function(){
				if(sessionStorage.getItem('boardPage') < data / 8 + 1){
					sessionStorage.setItem('boardPage', data / 8 + 1);
				}
				$('#articleCafeTitleBtn').html('선택 <span class="caret"></span>');
				$('#boardWriteModal #cafe_id').val('');
				$('#boardWriteModal #title').val('');
				initBoard(sessionStorage.getItem('boardPage'));
			}});
			$('#boardWriteModal').modal('hide');
		},
		error: function(e) {
			alert('registerArticle 에러 : ' + e);
		}
	});
}
</script>

<div id="boardWriteModal" class="modal fade" role="dialog" style="overflow-y: auto;">
	<div class="modal-dialog">
	  <div class="modal-content">
	    <div class="modal-header" align="center">
	      <button type="button" class="close" data-dismiss="modal">&times;</button>
	      <h2 class="form-signin-heading"><span>게시물 작성</span> <small>write</small></h2>
	    </div>
	    <div class="modal-body">
			<div class="row">
				<div class="col-sm-1 col-sm-offset-1" style="padding-right: 0%; margin-top: 0.7%;"><b>작성자</b></div>
				<div class="col-sm-3 col-sm-offset-1" style="margin-left:0%;">
					<input type="text" class="form-control" id="writer_id" name="writer_id" value="${loginUserInfo.member_id}" readonly>
				</div>
				<div class="col-sm-1 col-sm-offset-1" style="padding-right: 0%; margin-top: 0.7%;"><b>카페명</b></div>
				<div class="col-sm-3">
					<button type="button" class="btn btn-default has-popover" id="articleCafeTitleBtn" data-toggle="popover" data-placement="bottom">선택 <span class="caret"></span></button>
					<input type="hidden" id="cafe_id" value="">
				</div>
			</div><br>
			<div class="row">
				<div class="col-sm-1 col-sm-offset-1" style="padding-right: 0%; margin-top: 0.7%;"><b>제목</b></div>
				<div class="col-sm-9" style="padding-left:0%;">
					<input type="text" class="form-control" id="title">
				</div>
			</div><br>
			<div class="row">
				<div class="col-sm-2 col-sm-offset-1" style="margin-top: 1%;">
					<b>내용</b>
				</div>
			</div><br>
			<div class="row">
				<div class="col-sm-10 col-sm-offset-1">
					<div id="summernote"></div>
					<input type="hidden" id="content" name="content">
				</div>
			</div><br>
	    </div>
	    <div class="modal-footer">
	      <button type="button" class="btn btn-primary" id="registerBtn" onclick="registerArticle();">등록</button>
	      <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	    </div>
      </div>
    </div>
</div>