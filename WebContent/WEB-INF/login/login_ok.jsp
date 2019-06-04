<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>

<script type="text/javascript">
function logout(){
	var form = document.createElement("form");
	form.setAttribute("method", "GET");
	form.setAttribute("action", root + "/logout.cafetale");
    var hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", "page");
    hiddenField.setAttribute("value", document.location.href);
    form.appendChild(hiddenField);
    document.body.appendChild(form);
	form.submit();
}
</script>

<div class="nav navbar-form navbar-right">
	<div class="dropdown" role="menu" aria-labelledby="menu1">
		<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" style="width:150%;">
			<div class="img-circle" style="width: 25px; height: 25px; margin: auto; overflow: hidden; float:left; margin-right: 5%;">
				<img id="loginUserImg" src="${root}/getUserImage.cafetale?member_id=${loginUserInfo.member_id}" style="width: 100%; height: auto; position: relative; top: 50%; left: 50%; transform: translate(-50%, -50%); -webkit-transform: translate(-50%, -50%);">
			</div>
			<div style="transform: translate(0%, 15%);">${loginUserInfo.member_id} <span class="caret"></span></div>
		</button>
		<ul class="dropdown-menu">
			<li role="presentation"><a role="menuitem" href="#" data-toggle="modal" data-target="#mycafemodal">내 카페목록 <i class="fa fa-list-ul" aria-hidden="true"></i></a></li>
			<li role="presentation"><a role="menuitem" href="#" onclick="javascript:showFollowModal(0);">팔로우 관리 <i class="fa fa-user" aria-hidden="true"></i></a></li>
			<li role="presentation"><a role="menuitem" href="#" onclick="javascript:showProfile('${loginUserInfo.member_id}');">내 프로필 <i class="fa fa-info-circle" aria-hidden="true"></i></a></li>
			<li role="presentation" class="divider"></li>
			<li role="presentation"><a role="menuitem" href="#" onclick="javascript:logout();">로그아웃</a></li>
    	</ul>
  	</div>
</div>
<jsp:include page="/member/mycafemodal.jsp"></jsp:include>
<jsp:include page="/member/memberprofilemodal.jsp"></jsp:include>
<jsp:include page="/member/followmodal.jsp"></jsp:include>
<jsp:include page="/member/modifymodal.jsp"></jsp:include>