<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>

<script type="text/javascript">
$(document).ready(function(){
	$('#replyCollapse').on('show.bs.collapse', function(){
		initReply(sessionStorage.getItem('articleIdx'), sessionStorage.getItem('replyPage'));
	});
	
	$('#articleDetailModal').on('hide.bs.modal', function(){
		removeMemberCafePager('articleDetailCafeTitleBtn');
		$('#replyCollapse').collapse('hide');
	});
});

function modifyArticle(){
	var cafetitle = $('#articleDetailCafeTitleBtn').text();
	var cafeid = $('#articleCafeId').val();
	$('#articleDetailCafeTitleDiv').html('<button type="button" class="btn btn-default has-popover" id="articleDetailCafeTitleBtn" data-toggle="popover" data-placement="bottom">'+ cafetitle +' <span class="caret"></span></button><input type="hidden" id="articleCafeId" value="'+ cafeid +'">');
	memberCafePager(1, 1, 'articleDetailCafeTitleBtn');
	var content = $('#contentDiv>div').html();
	$('#contentDiv').html('<div id="summernote2">'+content+'</div>');
	$('#articleDetailModal #articleTitleDiv').prev().css('margin-top', '0.7%');
	$('#articleDetailModal #articleTitleDiv').html('<input type="text" class="form-control" id="title" value="'+ $('#articleDetailModal #articleTitleDiv>p').text() +'">');
	fileList = new FileList();
	var allImgArr = $('#summernote2>p>img').get();
	for(var i in allImgArr){
		var src = $('#summernote2>p>img:eq('+i+')').attr('src');
		fileList.insertAllFile(src.substring(src.lastIndexOf('/')+1));
	}
	initSummernote('summernote2');
	$('#contentDiv').parent().nextAll().hide();
	$('#articleDetailModal .modal-footer').html('<button type="button" class="btn btn-primary" id="modifyOkBtn" onclick="modifyArticleOk();">수정</button><button type="button" class="btn btn-default" id="cancleBtn" onclick="initArticleDetailModal('+ $('#boardListIndex').val() + ');">취소</button>');
}

function modifyArticleOk(){
	alertify.confirm('게시물 수정', '수정하시겠습니까?', function(){
		$('#summernote2').html($('#summernote2').summernote('code'));
		$('#summernote2').summernote('destroy');
		$('#boardWriteModal #content').val($('#summernote').html());
		var imgArr = $('#summernote2>p>img').get();
		for(var i in imgArr){
			var src = $('#summernote2>p>img:eq('+i+')').attr('src');
			fileList.insertRegisterFile(src.substring(src.lastIndexOf('/')+1));
		}
		$.ajax({
			type: 'GET',
			url: '${root}/modifyArticle.cafetale',
			data: {
				idx: sessionStorage.getItem('articleIdx'),
				title: $('#articleDetailModal #title').val(),
				content: $('#summernote2').summernote('code'),
				cafe_id: $('#articleDetailModal #articleCafeId').val(),
				allFileList: fileList.allFileList,
				registerFileList: fileList.registerFileList
			},
			async: false,
			success: function(){
				alertify.alert('수정 완료').set('frameless', 'true');
				initBoard(sessionStorage.getItem('boardPage'));
				$('#articleDetailModal #articleTitleDiv').prev().css('margin-top', '');
				$('#articleDetailModal #articleTitleDiv').html('<p>'+$('#articleDetailModal #title').val()+'</p>');
				$('#articleDetailCafeTitleDiv').html('<button type="button" class="btn btn-link" id="articleDetailCafeTitleBtn"></button><input type="hidden" id="articleCafeId" value="'+ boardList[i].cafe_id +'">');
				$('#articleDetailCafeTitleBtn').text(boardList[i].cafe_title);
				$('#articleDetailCafeTitleBtn').on('click', function(){
					var cafeDetailInfo = getCafeDetailInfo(boardList[i].cafe_id);
					showCafeModal(cafeDetailInfo, '${loginUserInfo.member_id}');
				});
				$('#contentDiv').html('<div class="panel panel-default form control" style="padding: 1%; margin-bottom: 1%;" id="content">'+ $('#summernote2').summernote('code') +'</div>');
				$('#summernote2').summernote('destroy');
				$('#contentDiv').parent().nextAll().show();
				$('#articleDetailModal .modal-footer').html('<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>');
			},
			error: function(e) {
				alert('modifyArticle 에러 : ' + e);
			}
		});
	}, function(){}).set('labels', {ok:'확인', cancel:'취소'});
}

function removeArticle(){
	alertify.confirm('게시물 삭제', '정말로 삭제하시겠습니까?', function(){
		$.ajax({
			type: 'GET',
			url: '${root}/removeArticle.cafetale',
			data: {
				idx: sessionStorage.getItem('articleIdx'),
			},
			success: function(){
				alertify.alert('삭제 완료').set('frameless', 'true');
				$('#articleDetailModal').modal('hide');
				initBoard(sessionStorage.getItem('boardPage'));
				sessionStorage.removeItem('articleIdx');
			},
			error: function(e) {
				alert('removeArticle 에러 : ' + e);
			}
		});
	}, function(){}).set('labels', {ok:'확인', cancel:'취소'});
}

function insertReply(){
	$.ajax({
		type: 'GET',
		url: '${root}/insertReply.cafetale',
		data: {	
			writer_id: '${loginUserInfo.member_id}',
			content: $('#replyContent').val(),
			parent_idx: sessionStorage.getItem('articleIdx'),
		},
		success: function() {
			initArticleDetailModal($('#boardListIndex').val());
			initBoard(sessionStorage.getItem('boardPage'));
			initReply(sessionStorage.getItem('articleIdx'), sessionStorage.getItem('replyPage'));
		},
		error: function(e) {
			alert('registerArticle 에러 : ' + e);
		}
	});
}

function initReply(articleIdx, replyPage){
	$('#replyCollapse>.well>.row:not(:eq(0))').empty();
	$('#replyCollapse>.well>br').remove();
	$('#replyContent').val('');
	$.ajax({
		type: 'GET',
		url: '${root}/initReply.cafetale',
		data: {memberId: '${loginUserInfo.member_id}', parent_idx: articleIdx, page: replyPage},
		dataType: 'json',
		success: function(data) {
			var replyList = data.replyList;
			console.log(replyList);
			for(var i in replyList) {
				$('#replyCollapse>.well').append(
					'<br><div class="row">' +
						'<div class="col-sm-3">' +
							'<div class="row"><div class="col-sm-12">' +
							'<button class="btn btn-default form-control" type="button" data-toggle="dropdown" onclick="showProfile(\''+ replyList[i].writer_id +'\')">' +
								'<div class="img-circle" style="width: 25px; height: 25px; margin: auto; overflow: hidden; float:left;">' +
									'<img id="loginUserImg" src="${root}/getUserImage.cafetale?member_id='+ replyList[i].writer_id +'" style="width: 100%; height: auto; position: relative; top: 50%; left: 50%; transform: translate(-50%, -50%); -webkit-transform: translate(-50%, -50%);">' +
								'</div>' +
								'<p style="word-wrap: break-word; overflow: hidden; text-overflow: ellipsis;">'+ replyList[i].writer_id +'</p>' +
							'</button>' +
							'</div></div>' +
							'<div class="row" style="margin-top:1%;"><div class="col-sm-12"><small><i class="' + 
							(replyList[i].write_date.includes('.') ? 'fa fa-calendar' : 'fa fa-clock-o') +
							'" aria-hidden="true"></i> ' + replyList[i].write_date + '</small></div></div>' +
						'</div>' +
						'<div class="col-sm-7" style="padding-left: 0.4%; padding-right: 0.4%;">' +
		  					'<p style="margin-top: 1%; float:left;">' + replyList[i].content + '</p>' +
		  					('${loginUserInfo.member_id}' == replyList[i].writer_id ? ' &nbsp;&nbsp;<a href="#" class="btn btn-link btn-sm" style="padding-right:1%;" onclick="modifyReply($(this), \''+ replyList[i].idx +'\');">수정</a><small>|</small><a href="#" class="btn btn-link btn-sm" style="padding-left:1%;" onclick="deleteReply(\''+ replyList[i].idx +'\');">삭제</a>' : '') +
						'</div>' +
						'<div class="col-sm-2">' +
							'<div class="row"><div class="col-sm-6 text-center" style="padding-left: 0%; padding-right: 0%;">' +
								('${loginUserInfo.member_id}' == replyList[i].writer_id ? '<button class="btn btn-default btn-sm" disabled="disabled"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i> ' + replyList[i].good +'</button></div><div class="col-sm-6 text-center" style="padding-left: 0%; padding-right: 0%;"><button class="btn btn-default btn-sm" disabled="disabled"><i class="fa fa-thumbs-o-down" aria-hidden="true"></i> ' + replyList[i].bad + '</button></div>' :
								'<button class="btn btn-default btn-sm" onclick="toggleArticleGood(\''+ replyList[i].idx +'\','+ false +');"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i> ' + replyList[i].good +'</button></div><div class="col-sm-6 text-center" style="padding-left: 0%; padding-right: 0%;"><button class="btn btn-default btn-sm" onclick="toggleArticleBad(\''+ replyList[i].idx +'\','+ false +');"><i class="fa fa-thumbs-o-down" aria-hidden="true"></i> ' + replyList[i].bad + '</button></div>') +
							'</div>' +
						'</div>' +
					'</div>'
				);
			}
			if(Object.keys(replyList).length < parseInt($('#replyCntBtn').text().substring(3))){
				$('#replyCollapse>.well').append('<div class="row"><div class="col-sm-12">' +
					'<button class="btn btn-link btn-block" onclick="addReply();">댓글 더 보기</button>' +
					'</div></div>');
			}
		},
		error: function(e) {
			alert('initReply 에러 : ' + e);
		}
	});
}

function mndBtnVisible(jq, index){
	if(index == 1){
		jq.css('visibility', 'visible');
	} else {
		jq.css('visibility', 'hidden');
	}
}

function modifyReply(t, idx){
	var div = t.parent();
	var originalText = div.find('p').text();
	div.html('<textarea class="form-control" rows="2"></textarea>');
	div.find('textarea').val(originalText);
	div.find('textarea').focus();
	div.next().html('<button class="btn btn-default form-control">수정</button>');
	div.next().find('button').on('click', function(){
		$.ajax({
			type: 'GET',
			url: '${root}/modifyReply.cafetale',
			data: {idx: idx, content: div.find('textarea').val()},
			async: false,
			success: function() {
				initBoard(sessionStorage.getItem('boardPage'));
				initReply(sessionStorage.getItem('articleIdx'), sessionStorage.getItem('replyPage'));
			},
			error: function(e) {
				alert('modifyReply 에러 : ' + e);
			}
		});
	});
}

function deleteReply(idx){
	alertify.confirm('댓글 삭제', '해당 댓글을 삭제하시겠습니까?', function(){
		$.ajax({
			type: 'GET',
			url: '${root}/deleteReply.cafetale',
			data: {idx: idx},
			success: function(){
				initBoard(sessionStorage.getItem('boardPage'));
				initReply(sessionStorage.getItem('articleIdx'), sessionStorage.getItem('replyPage'));
			},
			error: function(e) {
				alert('deleteReply 에러 : ' + e);
			}
		});
	}, function(){}).set('labels', {ok:'확인', cancel:'취소'});
}

function toggleArticleGood(idx, flag){
	$.ajax({
		type: 'GET',
		url: '${root}/toggleArticleGood.cafetale',
		data: {memberId: '${loginUserInfo.member_id}', idx: idx},
		success: function(){
			initBoard(sessionStorage.getItem('boardPage'));
			if(flag){
				initArticleDetailModal($('#boardListIndex').val());
			}
			initReply(sessionStorage.getItem('articleIdx'), sessionStorage.getItem('replyPage'));
		},
		error: function(e) {
			alert('toggleArticleGood 에러 : ' + e);
		}
	});
}

function toggleArticleBad(idx, flag){
	$.ajax({
		type: 'GET',
		url: '${root}/toggleArticleBad.cafetale',
		data: {memberId: '${loginUserInfo.member_id}', idx: idx},
		success: function(){
			initBoard(sessionStorage.getItem('boardPage'));
			if(flag){
				initArticleDetailModal($('#boardListIndex').val());
			}
			initReply(sessionStorage.getItem('articleIdx'), sessionStorage.getItem('replyPage'));
		},
		error: function(e) {
			alert('toggleArticleBad 에러 : ' + e);
		}
	});
}

function addReply(){
	sessionStorage.setItem('replyPage', parseInt(sessionStorage.getItem('replyPage'))+1);
	initReply(sessionStorage.getItem('articleIdx'), sessionStorage.getItem('replyPage'));
}

function articleLeft(){
	$('#boardListIndex').val(parseInt($('#boardListIndex').val())-1);
	initBoard(sessionStorage.getItem('boardPage'));
	initArticleDetailModal($('#boardListIndex').val());
}

function articleRight(){
	$('#boardListIndex').val(parseInt($('#boardListIndex').val())+1);
	initBoard(sessionStorage.getItem('boardPage'));
	initArticleDetailModal($('#boardListIndex').val());
}

</script>

<div id="articleDetailModal" class="modal fade" role="dialog" style="overflow-y: auto;">
	<div class="modal-dialog">
	  <div class="modal-content">
	    <div class="modal-header" align="center">
	      <button type="button" class="close" data-dismiss="modal">&times;</button>
	      <h2 class="form-signin-heading"><span>게시물 보기</span> <small>write</small></h2>
	    </div>
	    <div class="modal-body">
	    	<input type="hidden" id="boardListIndex" value="">
			<div class="row">
				<div class="col-sm-1 col-sm-offset-1" style="margin-right: 0%; margin-top: 0.7%;"><b>작성자</b></div>
				<div class="col-sm-3">
					<button type="button" class="btn btn-link" id="writer_id" onclick="showProfile($(this).text());"></button>
				</div>
				<div class="col-sm-1 col-sm-offset-1" style="margin-right: 0%; margin-top: 0.7%;">
					<b>카페명</b>
				</div>
				<div class="col-sm-3" id="articleDetailCafeTitleDiv"></div>
			</div><br>
			<div class="row">
				<div class="col-sm-1 col-sm-offset-1" style="margin-top:0.7%; padding-right: 0%;"><b>제목</b></div>
				<div class="col-sm-9" style="padding-left:0%;" id="articleTitleDiv">
				</div>
			</div><br>
			<div class="row">
				<div class="col-sm-2 col-sm-offset-1">
					<b>내용</b>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-10 col-sm-offset-1" id="contentDiv"></div>
			</div>
			<div class="row">
				<div class="col-sm-6 col-sm-offset-1">
					<button class="btn btn-default" id="articleLeft" onclick="articleLeft();">이전글</button>
					<button class="btn btn-default" id="articleRight" onclick="articleRight();">다음글</button>&nbsp;
				</div>
				<div class="col-sm-2 col-sm-offset-2 text-right">
					<button class="btn btn-default" id="articleGoodBtn"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i></button>
					<button class="btn btn-default" id="articleBadBtn"><i class="fa fa-thumbs-o-down" aria-hidden="true"></i></button>
				</div>
			</div><br>
			<div class="row">
				<div class="col-sm-2 col-sm-offset-1" id="reply_cnt" >
					<button id="replyCntBtn" type="button" class="btn btn-default" data-toggle="collapse" data-target="#replyCollapse" aria-expanded="false" aria-controls="replyCollapse"></button>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-10 col-sm-offset-1">
					<div class="collapse" id="replyCollapse">
						<div class="well">
							<div class="row">
								<div class="col-sm-3">
									<div class="form-control" style="background-color: #f5f5f5;" type="button" data-toggle="dropdown">
										<c:if test="${loginUserInfo.member_id != null}">
										<div class="img-circle" style="width: 25px; height: 25px; margin: auto; overflow: hidden; float:left;">
											<img id="loginUserImg" src="${root}/getUserImage.cafetale?member_id=${loginUserInfo.member_id}" style="width: 100%; height: auto; position: relative; top: 50%; left: 50%; transform: translate(-50%, -50%); -webkit-transform: translate(-50%, -50%);">
										</div>
										<p style="word-wrap: break-word; overflow: hidden; text-overflow: ellipsis; text-align:center;">${loginUserInfo.member_id}</p>
										</c:if>
										<c:if test="${loginUserInfo.member_id == null}">
										<div class="img-circle" style="width: 25px; height: 25px; margin: auto; overflow: hidden; float:left;">									
											<img id="loginUserImg" src="${root}/image/default.png" style="width: 100%; height: auto; position: relative; top: 50%; left: 50%; transform: translate(-50%, -50%); -webkit-transform: translate(-50%, -50%);">
										</div>
										<p style="word-wrap: break-word; overflow: hidden; text-overflow: ellipsis; text-align:center;">로그인필요</p>
										</c:if>
									</div>
								</div>
								<div class="col-sm-7" style="padding-left: 0.4%; padding-right: 0.4%;">
									<textarea class="form-control" id="replyContent" rows="2"></textarea>
								</div>
								<div class="col-sm-2">
									<c:if test="${loginUserInfo.member_id != null}">
									<button class="btn btn-default form-control" onclick="insertReply();">Comment</button>
									</c:if>
									<c:if test="${loginUserInfo.member_id == null}">
									<button class="btn btn-default form-control disabled">Comment</button>
									</c:if>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
	    </div>
	    <div class="modal-footer">
	    </div>
      </div>
    </div>
</div>
