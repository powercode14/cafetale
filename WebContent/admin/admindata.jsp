<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자 게시물 관리</title>
</head>  
  <body>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
    rel="stylesheet" type="text/css">
    <link href="http://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css"
    rel="stylesheet" type="text/css">
    <div class="navbar navbar-default navbar-static-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-ex-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#"></a>
        </div>
        <div class="collapse navbar-collapse" id="navbar-ex-collapse">
          <ul class="nav navbar-nav navbar-right">
            <li>
              <a href="${root }/index.jsp">로그아웃</a>
            </li>
          </ul>
        </div>
      </div>
    </div>
    <div class="section">
      <div class="container">
        <div class="row">
          <div class="col-md-8">
             <div class="container">
              <nav class="navbar navbar-inverse">
                <div class="container-fluid">
                  <!-- Brand and toggle get grouped for better mobile display -->
                  <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                      <span class="sr-only">Toggle navigation</span>
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">관리자 menu</a>
                  </div>
                  <!-- Collect the nav links, forms, and other content for toggling -->
                  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav navbar-right">
                      <li class="dropdown1">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                        aria-haspopup="true" aria-expanded="false"> 회원 관리 </a>
                        <ul class="dropdown-menu">
                          <li>
                            <a href="${root }/admin/adminmember.jsp">신고된 회원 관리</a>
                          </li>
                          <li>
                            <a href="${root }/admin/adminstats.jsp">회원 통계</a>
                          </li>
                        </ul>
                      </li>
                      <li class="dropdown2">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                        aria-haspopup="true" aria-expanded="false"> 게시물 관리 </a>
                        <ul class="dropdown-menu">
                          <li>
                            <a href="${root }/admin/adminborder.jsp">게시물 관리</a>
                          </li>
                          <li>
                            <a href="${root }/admin/adminborder.jsp">신고된 게시물</a>
                          </li>
                          <li>
                            <a href="${root }/admin/adminborder_end.jsp">폐업 신고 알림</a>
                          </li>
                        </ul>
                      </li>
                      <li class="dropdown3">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                        aria-haspopup="true" aria-expanded="false"> 게시물 통계 </a>
                        <ul class="dropdown-menu">
                          <li>
                            <a href="${root }/admin/adminstats.jsp">날짜별 게시물 통계</a>
                          </li>
                          <li>
                            <a href="${root }/admin/adminstats.jsp">지역별 게시물 통계</a>
                          </li>
                        </ul>
                      </li>
                      <li class="active dropdown4">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                        aria-haspopup="true" aria-expanded="false"> 관리자 정보 </a>
                        <ul class="dropdown-menu">
                          <li>
                            <a href="${root }/admin/admindata.jsp">관리자 정보 수정</a>
                          </li>
                        </ul>
                      </li>
                    </ul>
                  </div>
                  <!-- /.navbar-collapse -->
                </div>
                <!-- /.container-fluid -->
              </nav>
            </div>
            <article class="container">
              <div class="container">
                <div id="myTabContent" class="tab-content">
                  <div role="tabpanel" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">
                    <div class="col-md-12">
                      <div class="page-header">
                        <h1>관리자 정보 수정
                          <small>edit</small>
                        </h1>
                      </div>
                      <br>
                      <div class="form-group" align="center"></div>
                      <div class="row">
                        <div class="row text-right">
                          <div class="modal-body">
                            <form class="form-horizontal">
                              <div class="form-group">
                                <label class="col-sm-3 control-label" for="inputId">
                                  <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif"
                                  alt="필수">아이디</label>
                                <div class="col-sm-6">
                                  <input class="form-control" type="text" id="joinid" name="joinid" placeholder="ID"
                                  required="" autofocus="">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="col-sm-3 control-label" for="inputPassword">
                                  <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif"
                                  alt="필수">비밀번호</label>
                                <div class="col-sm-6">
                                  <input class="form-control" id="password" type="password" name="password"
                                  placeholder="password">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="col-sm-3 control-label" for="inputPasswordCheck">
                                  <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif"
                                  alt="필수">비밀번호 확인</label>
                                <div class="col-sm-6">
                                  <input class="form-control" id="passwordcheck" type="password" placeholder="Password 확인">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="col-sm-3 control-label" for="inputName">
                                  <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif"
                                  alt="필수">이름</label>
                                <div class="col-sm-6">
                                  <input class="form-control" id="name" type="text" name="name" placeholder="이름">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="col-sm-3 control-label" for="inputEmail">
                                  <img src="http://img.echosting.cafe24.com/skin/base/common/ico_required.gif"
                                  alt="필수">이메일</label>
                                <div class="col-sm-6">
                                  <input class="form-control" id="email" type="email" name="email" placeholder="e-mail">
                                </div>
                              </div>                              
                              <div class="form-group">
                                <label class="col-sm-3 control-label" for="inputPhone">휴대폰번호</label>
                                <div class="col-sm-6">
                                  <input type="tel" class="form-control" id="phone" name="phone" placeholder="- 없이 입력해 주세요">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="col-sm-3 control-label" for="inputBirth">생년월일</label>
                                <div class="col-sm-6">
                                  <input class="form-control" id="birth" type="text" name="birth" placeholder="ex) 951111">
                                </div>
                              </div>
                               <br>
                              <hr>
                              <br>
                              <br>
                              <div class="col-sm-12 text-center">
                                <button type="button" class="btn btn-primary">관리자 정보 수정</button>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                              </div>
                            </form>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </article>
          </div>
        </div>
      </div>
    </div>
  </body>

</html>