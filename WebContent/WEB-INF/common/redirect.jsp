<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${root}/js/jquery-3.1.0.min.js"></script>
<title>카페검색은 카페테일!</title>
</head>
<body>
<form id="rdform" method="get">
	<input type="hidden" name="page" value="${page}"/>
</form>
<script type="text/javascript">
var msg = "${msg}";
if(msg){
	alert(msg);
}
$('#rdform').submit();
</script>
</body>
</html>