<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>

<script type="text/javascript">
$(document).ready(function(){
	$('#modifyCheckModal').on('show.bs.modal', function(){
		$('#modifyCheckModal').insertAfter('.modal.fade:last');
	});
	
	$('#modifyCheckModal').on('shown.bs.modal', function(){
		$('#checkPw').focus();
	});
	
	$('#modifyCheckModal').on('hidden.bs.modal', function(){
		$('#checkPw').val('');
	});

	$('#checkPw').keyup(function(keycode){
		if(keycode.which == 13){
			modifyCheck();
		}
	});
	
	if('${loginUserInfo.member_gender}' === 'm'){
		$('#member_gender[value=m]').attr('checked', true);
	} else if('${loginUserInfo.member_gender}' === 'w') {
		$('#member_gender[value=w]').attr('checked', true);
	}
});

function modifyCheck(){
	var loginId = '${loginUserInfo.member_id}';
	var checkPw = $('#checkPw').val();
	if(!checkPw){
		alertify.alert('비밀번호를 입력해주세요!').set('frameless', true);
		return false;
	} else {
		$.ajax({
			type: 'POST',
			url: '${root}/modifyCheck.cafetale',
			data: {loginId: loginId, checkPw: checkPw},
			dataType: 'json',
			success: function(data){
				if(data == 0){
					alertify.alert('비밀번호가 틀렸습니다!').set('frameless', true);
				} else {
					$('#modifyCheckModal').modal('hide');
					$('#modifyModal').insertAfter('.modal.fade:last');
					$('#modifyModal').modal('show');
				}
			},
			error: function(e) {
				alert("에러" + e);
			}
		});
	}
}

function modify(){
	if(!$("#member_id").val()) {
		alertify.alert("아이디는 필수 입력사항입니다.").set('frameless', true);
		return;
	} else if(!$("#member_pw").val()) {
		alertify.alert("비밀번호는 필수 입력사항입니다.").set('frameless', true);
		return;
	} else if($("#member_pw").val() != $("#member_pw_check").val()) {
		alertify.alert("비밀번호가 서로 다릅니다.").set('frameless', true);
		return;
	} else if(!$("#member_name").val()) {
		alertify.alert("이름은 필수 입력사항입니다.").set('frameless', true);
		return;
	} else if(!$("#member_email").val()) {
		alertify.alert("이메일은 필수 입력사항입니다.").set('frameless', true);
		return;
	} else {
		if(!$("#register_img").val()){
			var image = '<input type="hidden" name="member_image" value="${loginUserInfo.member_image}"/>';
			$("#modifyform").append(image);
			$('#register_img').remove();
		}
		var hidden = '<input type="hidden" name="page" value="' + document.location.href + '"/>';
		$('#modifyform').append(hidden);
		$('#modifyform').submit();
	}
}

if('${loginUserInfo.member_gender}' === 'm'){
	$('#member_gender[value=m]').prop('checked', true);
} else if('${loginUserInfo.member_gender}' === 'w'){
	$('#member_gender[value=w]').prop('checked', true);
}

$(function() {
    $("#register_img").on('change', function(){
        readURL(this);
    });
});

function readURL(input) {
	if (input.files && input.files[0]) {
    	var reader = new FileReader();

        reader.onload = function (e) {
    		$('#preview').attr('src', e.target.result);
    	}
    	reader.readAsDataURL(input.files[0]);
    }
}
</script>
<style>
#modifyModal .modal-body{
    max-height: calc(100vh - 200px);
    overflow-y: auto;
}
#register_img { width: 100%; }
</style>

		<div id="modifyCheckModal" class="modal fade" role="dialog">
		  <div class="modal-dialog modal-sm">
			<div class="modal-content">
			  <div class="modal-body">
			  	<strong>비밀번호를 입력해주세요.</strong>
			  	<div id="modifyCheckForm" class="input-group">
			  	  <input type="hidden" name="loginId" value="${loginUserInfo.member_id}" />
	              <input id="checkPw" name="checkPw" type="password" class="form-control" />
	              <span class="input-group-btn">
	                <button id="modifyCheckButton" type="submit" onclick="javascript:modifyCheck();" class="btn btn-default">확인</button>
	              </span>
	            </div>
			  </div>
			</div>
		  </div>
		</div>
		<div id="modifyModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
			  <div class="modal-content">
			    <div class="modal-header" align="center">
			      <button type="button" class="close" data-dismiss="modal">&times;</button>
			      <h2 class="form-signin-heading">회원정보수정 <small>modify</small></h2>
			    </div>
			    <div class="modal-body">
			      <form id="modifyform" enctype="multipart/form-data" method="post" action="${root}/modify.cafetale">
			        <div class="row">
			          <label class="col-md-3 control-label text-right" for="member_id">
			            <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"/>아이디
			          </label>
			          <div class="col-md-4">
			            <input class="form-control" type="text" id="member_id" name="member_id" value="${loginUserInfo.member_id}" readonly>
			          </div>
			        </div>
			        <br>
					<div class="row">
					  <label class="col-md-3 control-label text-right" for="member_pw">
					    <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"/>비밀번호
					  </label>
					  <div class="col-md-4">
					    <input class="form-control" type="password" id="member_pw" name="member_pw" placeholder="password"/>
					  </div>
					</div>
					<br>
					<div class="row">
					  <label class="col-md-3 control-label text-right" for="member_pw_check">
					    <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"/>비밀번호 확인
					  </label>
					  <div class="col-md-4">
					    <input class="form-control" type="password" id="member_pw_check" placeholder="Password Check" onkeyup="javascript:passwordCheck();">
					  </div>
					  <label class="col-md-5 control-label" id="passwordcheckresult"></label>
					</div>
					<br>
					<div class="row">
					  <label class="col-md-3 control-label text-right" for="inputName">
					    <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"/> 이름
					  </label>
					  <div class="col-md-5">
					    <input class="form-control" type="text" id="member_name" name="member_name" value="${loginUserInfo.member_name}">
					  </div>
					</div>
					<br>
					<div class="row">
					  <label class="col-md-3 control-label text-right" for="member_email">
					    <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"/> 이메일
					  </label>
					  <div class="col-md-5">
					    <input class="form-control" type="email" id="member_email" name="member_email" value="${loginUserInfo.member_email}">
					  </div>
					</div>
					<hr>
					<div class="row">
					  <div class="col-sm-7">
					  	<div class="row">
					  	  <label class="col-sm-5 control-label text-right" for="member_phone">휴대폰번호</label>
					  	  <div class="col-sm-7" style="margin-bottom: 6%;">
						    <div class="input-group">
						      <input type="tel" class="form-control" id="member_phone" name="member_phone" placeholder="ex) 010-1234-5678" value="${loginUserInfo.member_phone}"/>
						    </div>
						  </div>
						  <label class="col-sm-5 control-label text-right" for="member_birth">생년월일</label>
						  <div class="col-sm-7" style="margin-bottom: 6%;">
						  	<div class="input-group">
						      <input class="form-control" type="text" id="member_birth" name="member_birth" placeholder="ex) 951111" value="${loginUserInfo.member_birth}">
						    </div>
						  </div>
						  <label class="col-sm-5 control-label text-right" for="member_gender">성별</label>
						  <div class="col-sm-7" style="margin-bottom: 6%;">
						    <input type="radio" id="member_gender" name="member_gender" value="m"> 남
						    <input type="radio" id="member_gender" name="member_gender" value="w" style="margin-left: 20%"> 여
						  </div>
						  <label class="col-sm-5 control-label text-right">주소</label>
	                  	  <div class="col-sm-7">
	                  		<div class="input-group">
	                  		  <button type="button" class="btn btn-success" onclick="javascript:goPopup();">주소검색 <i class="fa fa-search"></i></button>
	                  		</div>
	                  	  </div>
					  	</div>
					  </div>
					  <div class="col-sm-5">
					    <div class="well">
					        <label class="control-label" for="register_img">사진 </label>
					  		<div class="thumbnail-wrapper img-circle" style="width: 80px; height: 80px; margin: auto; overflow: hidden;">
					  		  <img id="preview" src="${root}/getUserImage.cafetale?member_id=${loginUserInfo.member_id}" style="width: 100%; height: auto; position: relative; top: 50%; left: 50%; transform: translate(-50%, -50%); -webkit-transform: translate(-50%, -50%);">
					  		</div>
					  		<br>
					  		<input type="file" id="register_img" name="register_img">
					    </div>
					  </div>
					</div>
					<div class="row">
					  <div class="col-sm-7 col-sm-offset-2" style="margin-left: 24.3%;">
	                  	<div class="input-group" style="margin-bottom: 3%; width: 100%;">                  
	                    	<input class="form-control" type="text" id="member_address1" name="member_address1" placeholder="시/구/군" readonly="readonly" value="${loginUserInfo.member_address1}">
	                    </div>
	                    <br>
	                    <div class="input-group" style="margin-bottom: 3%; width: 100%;">                  
	                    	<input class="form-control" type="text" id="member_address2" name="member_address2" placeholder="상세 주소" value="${loginUserInfo.member_address2}">
	                    </div>
	                  </div>
               		</div>
				  </form>
			    </div>
			    <div class="modal-footer">
			      <button type="button" class="btn btn-primary" id="btnjoin" onclick="javascript:modify();">수정</button>
			      <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			    </div>
		      </div>
		    </div>
	      </div>