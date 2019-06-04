<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
	<nav id="bar" class="navbar navbar-inverse navbar-top" role="navigation">
		<div class="container" id="bar_top">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="btn btn-link" style="color:white; font-size:200%;" href="${root}/index.jsp">Café tale</a>
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <c:if test="${loginUserInfo == null}">
              <jsp:include page="/WEB-INF/login/login.jsp"/>
            </c:if>
            <c:if test="${loginUserInfo != null}">
              <jsp:include page="/WEB-INF/login/login_ok.jsp"/>
            </c:if>
          </div>
        </div>
    </nav>