<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/public.jsp"%>
<!-- include summernote css/js-->
<!-- <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.js"></script> -->
<jsp:include page="/common/bar_top.jsp"/>
<link href="${root}/css/summernote.css" rel="stylesheet">
<script src="${root}/js/summernote.js"></script>
<script src="${root}/js/summernote-ko-KR.js"></script>
<script type="text/javascript" src="${root}/js/cafe.js?ver=2"></script>
<script type="text/javascript">
var boardList;
$(document).ready(function(){
	if(sessionStorage.getItem('firstWrite')){
		insertBoard();
		sessionStorage.removeItem('firstWrite');
	}
	if(sessionStorage.getItem('rcCafeId')){
		$('#displayOpt input[type=checkbox]:eq(0)').attr('checked', true);
		$('#displayOpt input[type=hidden]:eq(0)').val(sessionStorage.getItem('rcCafeId'));
		sessionStorage.removeItem('rcCafeId');
	}
	$('#displayOpt input[type=checkbox]').change(function(){
		$('#displayOpt input[type=checkbox]').each(function(i){
			if($(this).prop('checked')){
				var value;
				if(i == 0){
					getMemberDetailInfo('${loginUserInfo.member_id}');
					value = rcCafeId;
				} else {
					value = 'on';
				}
				$(this).next('input[type=hidden]').val(value);
			} else {
				$(this).next('input[type=hidden]').val('');
			}
		});
		initBoard(sessionStorage.getItem('boardPage'));
		return false;
	});
	
	initBoard(sessionStorage.getItem('boardPage'));
	var idx = sessionStorage.getItem('idx');
	if(idx != null){
		for(var i in boardList){
			if(boardList[i].idx == idx){
				initArticleDetailModal(i);
				showArticleDetailModal(i);
				sessionStorage.removeItem('idx');
				break;
			}
		}
	}
});

var FileList = function(){
	this.allFileList = [''];
	this.registerFileList = [''];
}

FileList.prototype.insertAllFile = function(file){
	if(this.allFileList[0] == ''){
		this.allFileList[0] = file;
	} else {
		this.allFileList.push(file);
	}
}

FileList.prototype.insertRegisterFile = function(file){
	if(this.registerFileList[0] == ''){
		this.registerFileList[0] = file;
	} else {
		this.registerFileList.push(file);
	}
}

var fileList = new FileList();

function insertBoard(){
	if(!'${loginUserInfo}'){
		alertify.alert('<b>로그인이 필요한 서비스입니다. 상단메뉴에서 로그인 해주세요.</b>').set('frameless', true);
		return false;
	}
	initSummernote('summernote');
	$('#boardWriteModal').modal();
}

function initSummernote(id){
	$('#' + id).summernote({
		callbacks: {
			onImageUpload: function(files) {
				for(var i = 0; i<files.length; i++){
					sendFile(files[i], this);
				}
			},
	    },
		height : 165,
		minHeight : 100,
		maxHeight : null,
		focus : true,
		lang : 'ko-KR'
	});
	
	function sendFile(file, el) {
	    var data = new FormData();
	    data.append("imageFile", file);
	    $.ajax({
	        data : data,
	        type : "POST",
	        url : '${root}/imageUpload.cafetale',
	        enctype: 'multipart/form-data',
	        cache : false,
	        contentType : false,
	        processData : false,
	        success : function(data) {
	        	$(el).summernote('editor.insertImage', '${root}' + data.url, function(image) {
	        		image.css({'width': '240px', 'height': 'auto'});
	        	});
	        	fileList.insertAllFile(data.name);
	        }
	    });
	}
}

function changeSearchOpt(index){
	$('#searchOptBtn').html($('#searchOpt>li:eq('+ index +')>a').text() + ' <span class="caret"></span>');
	$('#searchOption').val(index);
}

function initBoard(page){
	$('#boardContainer>div:not(:eq(0))').remove();
	var displayOption = $('#displayOpt input[type=hidden]').toArray();
	var bsk = $('#boardSearchKeyword').val();
	var title, content, titleContent, member;
	if(bsk){
		if($('#searchOption').val() == 0)
			title=bsk;
		else if($('#searchOption').val() == 1)
			content=bsk;
		else if($('#searchOption').val() == 2)
			titleContent=bsk;
		else if($('#searchOption').val() == 3)
			member=bsk;
	}
	$.ajax({
		type: 'GET',
		url: '${root}/initBoard.cafetale',
		data: {
			boardPage: sessionStorage.getItem('boardPage'),
			memberId: '${loginUserInfo.member_id}',
			rcCafeOption: displayOption[0].value,
			goodOption: displayOption[1].value,
			friendOption: displayOption[2].value,
			searchTitle: title,
			searchContent: content,
			searchTitleContent: titleContent,
			searchMember: member
		},
		dataType: 'json',
		async: false,
		success: function(data) {
			boardList = data.boardList;
			var totalCnt = Object.keys(boardList).length;
			for(var i=0; i<(totalCnt >= page * 8 ? page * 8 : totalCnt); i++){
				var content = boardList[i].content;
				$('#dummyDiv').append(content);
				if(i % 4 == 0) {
					$('#boardContainer').append('<div class="row"></div>');
				}
				var imgsrc = $('#dummyDiv>p>img').attr('src');
				$('#boardContainer>div.row:last').append(
					'<div class="post col-sm-3">' +
						'<div class="thumbnail">' +
							'<p><i class="fa fa-thumbs-up" aria-hidden="true"></i> '+ boardList[i].good + '&nbsp;&nbsp;&nbsp;&nbsp;' +
							'<i class="fa fa-eye" aria-hidden="true"></i> '+ boardList[i].hit_count + '&nbsp;&nbsp;&nbsp;&nbsp;' +
							'<i class="' + 
							(boardList[i].write_date.includes('.') ? 'fa fa-calendar' : 'fa fa-clock-o') +
							'" aria-hidden="true"></i> ' + boardList[i].write_date + '</p>' +
							'<div style="position:relative; height: 180px; text-align:center;">' +
								'<img src="'+ (!imgsrc ? '${root}/image/no_image.png' : imgsrc) +'">' +
							'</div>' +	
							'<div class="caption">' +
								'<a href="#" onclick="javascript:initArticleDetailModal('+i+'); showArticleDetailModal('+i+');">'+
								'<span class="badge">' + boardList[i].reply_cnt + '</span> '+ boardList[i].title + '</a>' +
								'<p>' + $('#dummyDiv>p').text() + '</p>' +
							'</div>' +
						'</div>' +
					'</div>'
				);
				$('#dummyDiv').empty();
			}
		},
		error: function(e) {
			alert('initBoard 에러 : ' + e);
		}
	});
}

function initArticleDetailModal(i){
	$('#boardListIndex').val(i);
	$('#contentDiv').parent().nextAll().show();
	if(boardList[i].writer_id == '${loginUserInfo.member_id}'){
		$('#modifyBtn').remove();
		$('#removeBtn').remove();
		$('#articleGoodBtn').addClass('disabled');
		$('#articleBadBtn').addClass('disabled');
		$('#articleRight').parent().append('<button type="button" class="btn btn-primary" id="modifyBtn" onclick="modifyArticle();">수정</button> <button type="button" class="btn btn-danger" id="removeBtn" onclick="removeArticle();">삭제</button>');
	} else {
		$('#articleGoodBtn').unbind('click');
		$('#articleGoodBtn').on('click', function(){
			toggleArticleGood(boardList[i].idx, true);
		});
		$('#articleBadBtn').unbind('click');
		$('#articleBadBtn').on('click', function(){
			toggleArticleBad(boardList[i].idx, true);
		});
	}
	$('#articleDetailModal #writer_id').text(boardList[i].writer_id);
	$('#articleDetailCafeTitleDiv').html('<button type="button" class="btn btn-link" id="articleDetailCafeTitleBtn"></button><input type="hidden" id="articleCafeId" value="'+ boardList[i].cafe_id +'">');
	$('#articleDetailCafeTitleBtn').text(boardList[i].cafe_title);
	$('#articleDetailCafeTitleBtn').on('click', function(){
		var cafeDetailInfo = getCafeDetailInfo(boardList[i].cafe_id);
		showCafeModal(cafeDetailInfo, '${loginUserInfo.member_id}');
	});
	$('#articleDetailModal #articleTitleDiv').prev().css('margin-top', '');
	$('#articleDetailModal #articleTitleDiv').html('<p>'+boardList[i].title+'</p>');
	$('#contentDiv').html('<div class="panel panel-default form control" style="padding: 1%; margin-bottom: 1%;" id="content">'+boardList[i].content+'</div>');
	if(i == 0){
		$('#articleLeft').addClass('disabled');
		if(Object.keys(boardList).length==1){
			$('#articleRight').addClass('disabled');
		}
	} else if(i == Object.keys(boardList).length-1) {
		$('#articleRight').addClass('disabled');
	} else {
		$('#articleLeft').removeClass('disabled');
		$('#articleRight').removeClass('disabled');
	}
	$('#articleDetailModal #replyCntBtn').html('댓글 '+ boardList[i].reply_cnt + ' <span class="caret"></span>');
	if(window.sessionStorage) {
		sessionStorage.setItem('articleIdx', boardList[i].idx);
		sessionStorage.setItem('replyPage', 1);
	}
	$('#articleGoodBtn').html('<i class="fa fa-thumbs-o-up" aria-hidden="true"></i> ' + boardList[i].good);
	$('#articleBadBtn').html('<i class="fa fa-thumbs-o-down" aria-hidden="true"></i> ' + boardList[i].bad);
	$('#articleDetailModal .modal-footer').html('<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>');
}

function showArticleDetailModal(i){
	$('#articleDetailModal').modal('show');
	if(boardList[i].writer_id != '${loginUserInfo.member_id}'){
		$.ajax({
			type: 'GET',
			url: '${root}/hitBoard.cafetale',
			data: {boardIdx : boardList[i].idx},
			async: false,
			success: function() {
				initBoard(sessionStorage.getItem('boardPage'));
			},
			error: function(e) {
				alert("에러: "+ e);
			}
		});
	}
}

$(window).scroll(function() {
	var boardPage = sessionStorage.getItem('boardPage');
    if ($(window).scrollTop() >= $(document).height() - $(window).height()) {
    	if(Object.keys(boardList).length > boardPage * 8){
    		sessionStorage.setItem('boardPage', boardPage+1);
    		initBoard(boardPage+1);
    	}
    }
});

function searchBoard(){
	sessionStorage.setItem('boardPage', 1);
	initBoard(sessionStorage.getItem('boardPage'));
}

</script>
<style>
.container-fluid { text-align: center; }
.container-fluid>div { float:left; }
.container > .row:nth-child(1) > div:nth-child(3) { text-align:right; }
#boardPagination { text-align:center; }
#boardPagination>ul { margin-top: 0%; }
#boardWriteModal>.modal-dialog { width: 70%; }
#boardContainer .thumbnail>p { text-align:right; margin-top: 1%; margin-right: 3%; }
#boardContainer .thumbnail div:first-child { position:relative; height: 180px; text-align:center; }
#boardContainer .thumbnail img { max-width: 253px; height: 100%; border: 3px double; border-radius: 5px; }
#boardContainer .caption { width: 253.04px; height: 80px; margin-top: 3%; }
#boardContainer .caption>a { display: block; white-space: nowrap; word-wrap: break-word; overflow: hidden; text-overflow: ellipsis; }
#boardContainer .caption>p { height: 40px; margin-top: 2%; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; word-wrap: break-word; overflow: hidden; text-overflow: ellipsis; }

#articleCafeTitleBtn+div.popover { width: 110%; text-align: center; }
#articleDetailCafeTitleBtn+div.popover { width: 110%; text-align: center; }
#mgCafeBtn { padding-bottom: 2%; }
#mgCafeBtn>button { background-color: transparent; border: none; transition-duration: 0.3s; }
#mgCafeBtn>button:hover { background-color: #008CBA; color: white; border-radius: 3px; }

#articleDetailModal>.modal-dialog { width: 70%; }
.collapsing { -webkit-transition: none; transition: none; }
</style>
<br>
<div id="boardContainer" class="container">
	<div class="row">
		<div class="col-sm-2">
			<button class="btn btn-default" id="writeBtn" onclick="insertBoard();">게시물 작성</button> 
		</div>
  		<div class="col-sm-4 col-sm-offset-2">
  			<form id="boardSearchForm" class="input-group" onsubmit="javascript:searchBoard(); return false;">
	  			<div class="input-group-btn">
		  			<button class="btn btn-default" id="searchOptBtn" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="white-space: nowrap;">
		  				제목 <span class="caret"></span>
		  			</button>
					<ul class="dropdown-menu" id="searchOpt">
						<li><a href="#" onclick="changeSearchOpt(0);">제목</a></li>
						<li><a href="#" onclick="changeSearchOpt(1);">내용</a></li>
						<li><a href="#" onclick="changeSearchOpt(2);">제목+내용</a></li>
						<li><a href="#" onclick="changeSearchOpt(3);">작성자</a></li>
					</ul>
				</div>
				<input type="hidden" id="searchOption" value="0">
				<input type="text" id="boardSearchKeyword" class="form-control" placeholder="검색어">
				<span class="input-group-btn">
					<button class="btn btn-default" type="submit" id="boardSearchBtn">검색</button>
				</span>
			</form>
	    </div>
  		<div class="col-sm-2 col-sm-offset-2">
  			<button class="btn btn-default" id="displayOptBtn" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				게시물 표시 조건
				<span class="caret"></span>
			</button>
			<ul class="dropdown-menu" id="displayOpt">
				<li><label class="btn btn-link">대표카페 게시물만 표시 <input type="checkbox"><input type="hidden" value=""></label></li>
				<li><label class="btn btn-link">좋아요 누른 게시물만 표시 <input type="checkbox"><input type="hidden" value=""></label></li>
				<li><label class="btn btn-link">내 친구의 게시물만 표시 <input type="checkbox"><input type="hidden" value=""></label></li>
			</ul>
  		</div>
	</div>
	<hr>
</div>
<div id="dummyDiv" style="display:none;"></div>
<jsp:include page="/board/write.jsp"/>
<jsp:include page="/board/article_detail.jsp"/>
</body>
</html>