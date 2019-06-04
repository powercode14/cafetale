<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>

<div class="nav navbar-form navbar-right">
	<jsp:include page="/member/joinmodal.jsp"></jsp:include>
	<button type="submit" class="btn btn-default" id="btnlogin" name="btnlogin" onclick="javascript:login();"><b>로그인</b></button>
	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#joinmodal">회원가입</button>
</div>

<form class="nav navbar-form navbar-right" id="loginform" method="post" action="${root}/login.cafetale">
	<label class="checkbox" for="saveid">
    	<input type="checkbox" value="remember-me" id="saveid"><font size="3" color="white"> 아이디 저장</font>&nbsp;
    </label>
	<input type="text" id="loginid" name="login_id" class="form-control">
	<input type="password" id="loginpw" name="login_pw" class="form-control">
</form>

<script type="text/javascript">
$(document).ready(function() {
    var userInputId = getCookie("userInputId");
    $("#loginid").val(userInputId); 
     
    if($("#loginid").val() != ""){ 
        $("#saveid").attr("checked", true);
    }
     
    $("#saveid").change(function(){ 
        if($("#saveid").is(":checked")){                     
               //id 저장 클릭시 pwd 저장 체크박스 활성화
            var userInputId = $("#loginid").val();
            setCookie("userInputId", userInputId, 365);
        }else{ 
            deleteCookie("userInputId");
        }
    });
  
    $("#loginid").keyup(function(){
        if($("#saveid").is(":checked")){
            var userInputId = $("#loginid").val();
            setCookie("userInputId", userInputId, 365);
        }
    });
});

$('#loginpw').keydown(function(e){
	if(e.keyCode == 13){
		login();
	}
});
function login(){
	var loginid = $("#loginid").val();
	var loginpw = $("#loginpw").val();
	if(loginid  == "") {
		alert("아이디를 입력해주세요.");
		return;
	} else if(loginpw == "") {
		alert("비밀번호를 입력해주세요");
		return;
	} else {
		var hidden = '<input type="hidden" name="page" value="' + document.location.href + '"/>';
		$("#loginform").append(hidden);
		$("#loginform").submit();
	}
}
</script>
