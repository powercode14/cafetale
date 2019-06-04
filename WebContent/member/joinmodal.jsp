<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
		<div id="joinmodal" class="modal fade" role="dialog">
			<div class="modal-dialog">
			  <div class="modal-content">
			    <div class="modal-header" align="center">
			      <button type="button" class="close" data-dismiss="modal">&times;</button>
			      <h2 class="form-signin-heading">회원가입 <small>join</small></h2>
			    </div>
			    <div class="modal-body">
			      <form id="joinform" enctype="multipart/form-data" method="post" action="${root}/register.cafetale">
			        <div class="row">
			          <label class="col-sm-3 control-label text-right" for="member_id">
			            <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"/>아이디
			          </label>
			          <div class="col-sm-4">
			            <input class="form-control " type="text" id="member_id" name="member_id" placeholder="ID" onkeyup="javascript:idcheck();">
			          </div>
			          <label class="col-sm-5 control-label" id="idresult"></label>
			        </div>
			        <br>
					<div class="row">
					  <label class="col-sm-3 control-label text-right" for="member_pw">
					    <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"/>비밀번호
					  </label>
					  <div class="col-sm-4">
					    <input class="form-control" type="password" id="member_pw" name="member_pw" placeholder="password"/>
					  </div>
					</div>
					<br>
					<div class="row">
					  <label class="col-sm-3 control-label text-right" for="member_pw_check">
					    <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"/>비밀번호 확인
					  </label>
					  <div class="col-sm-4">
					    <input class="form-control" type="password" id="member_pw_check" placeholder="Password Check" onkeyup="javascript:passwordCheck();">
					  </div>
					  <label class="col-sm-5 control-label" id="passwordcheckresult"></label>
					</div>
					<br>
					<div class="row">
					  <label class="col-sm-3 control-label text-right" for="inputName">
					    <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"/> 이름
					  </label>
					  <div class="col-sm-5">
					    <input class="form-control" type="text" id="member_name" name="member_name" placeholder="이름">
					  </div>
					</div>
					<br>
					<div class="row">
					  <label class="col-sm-3 control-label text-right" for="member_email">
					    <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif" alt="필수"/> 이메일
					  </label>
					  <div class="col-sm-5">
					    <input class="form-control" type="email" id="member_email" name="member_email" placeholder="e-mail">
					  </div>
					</div>
					<hr>
					<div class="row">
					  <div class="col-sm-7">
					  	<div class="row">
					  	  <label class="col-sm-5 control-label text-right" for="member_phone">휴대폰번호</label>
					  	  <div class="col-sm-7" style="margin-bottom: 6%;">
						    <div class="input-group">
						      <input type="tel" class="form-control" id="member_phone" name="member_phone" placeholder="ex) 010-1234-5678" />
						    </div>
						  </div>
						  <label class="col-sm-5 control-label text-right" for="member_birth">생년월일</label>
						  <div class="col-sm-7" style="margin-bottom: 6%;">
						  	<div class="input-group">
						      <input class="form-control" type="text" id="member_birth" name="member_birth" placeholder="ex) 951111">
						    </div>
						  </div>
						  <label class="col-sm-5 control-label text-right" for="member_gender">성별</label>
						  <div class="col-sm-7" style="margin-bottom: 6%;">
						    <input type="radio" id="member_gender" name="member_gender" value="m"> 남 
						    <input type="radio" id="member_gender" name="member_gender" value="w" style="margin-left: 20%"> 여
						  </div>
						  <label class="col-sm-5 control-label text-right" for="register_img">주소</label>
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
					  		  <img id="preview" src="${root}/common/default.png" style="width: 100%; height: auto; position: relative; top: 50%; left: 50%; transform: translate(-50%, -50%); -webkit-transform: translate(-50%, -50%);">
					  		</div>
					  		<br>
					  		<input type="file" id="register_img" name="register_img">
					  		<script>
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
					        
					        /* function check() 
					        { 
					            document.getElementById("preview").src=document.getElementById("register_img").value;
					        }
					        
					        function checksize() 
					        { 
					            alert(document.getElementById("preview").fileSize);
					        } */
							</script>
					    </div>
					  </div>
					</div>
					<div class="row">
					  <div class="col-sm-7 col-sm-offset-2" style="margin-left: 24.3%;">
	                  	<div class="input-group" style="margin-bottom: 3%; width: 100%;">                  
	                    	<input class="form-control" type="text" id="member_address1" name="member_address1" placeholder="시/구/군" readonly="readonly">
	                    </div>
	                    <br>
	                    <div class="input-group" style="margin-bottom: 3%; width: 100%;">                  
	                    	<input class="form-control" type="text" id="member_address2" name="member_address2" placeholder="상세 주소">
	                    </div>
	                  </div>
               		</div>
				  </form>
			    </div>
			    <div class="modal-footer">
			      <button class="btn btn-primary" id="btnjoin" name="btnjoin" onclick="javascript:join();">회원가입</button>
			      <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			    </div>
		      </div>
		    </div>
	      </div>