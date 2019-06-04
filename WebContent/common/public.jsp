<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="root" value="${pageContext.request.contextPath}"/>
<%-- <c:set var="bcode" value="${param.bcode}"/>
<c:set var="page" value="${param.page}"/>
<c:set var="key" value="${param.key}"/>
<c:set var="word" value="${param.word}"/> --%>

<html lang="ko">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
	<title>카페검색은 카페테일!</title>
	<script type="text/javascript" src="${root}/js/httpRequest.js"></script>
	<script type="text/javascript" src="${root}/js/index.js"></script>
	<script type="text/javascript" src="${root}/js/jquery-3.1.0.min.js"></script>
	
	<script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${root}/js/font-awesome-4.7.0/css/font-awesome.min.css">
    <link href="http://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css" rel="stylesheet" type="text/css">
	

	
	<link rel="stylesheet" href="${root}/js/alertifyjs/css/alertify.css">
	<script src="${root}/js/alertifyjs/alertify.js"></script>
	
	<script type="text/javascript">
	//override defaults
	alertify.defaults.transition = "zoom";
	alertify.defaults.theme.ok = "btn btn-primary";
	alertify.defaults.theme.cancel = "btn btn-danger";
	alertify.defaults.theme.input = "form-control";
	</script>
	<script type="text/javascript">
		var root = "${root}";
	</script>
</head>
<body>
	<jsp:include page="/cafe/cafedetailmodal.jsp"/>