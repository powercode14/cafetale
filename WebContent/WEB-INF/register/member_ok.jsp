<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입 완료</title>
</head>
<body>
<center>
${memberinfo.member_name}님 회원가입을 축하합니다.<br>
가입하신 아이디는 ${memberinfo.member_id}이고 이메일은 ${memberinfo.member_email}이고<br>
등록한 사진의 파일명은 ${memberinfo.member_image}입니다.
<a href="${root}/index.jsp">메인화면으로 가기</a>
</center>
</body>
</html>