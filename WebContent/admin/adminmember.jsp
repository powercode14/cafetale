<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link
      href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
      rel="stylesheet" type="text/css">
   <link
      href="http://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css"
      rel="stylesheet" type="text/css">
    <link rel="icon" href="../../favicon.ico">

    <title>전국 카페 정보 공유|Cafetale</title>

    <!-- Bootstrap core CSS -->
    <link href="${root }/css/bootstrap.min.css" rel="stylesheet">
    <link href="${root }/css/ie10-viewport-bug-workaround.css" rel="stylesheet">


    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
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
                      <li class="active dropdown1">
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
                        <a href="${root }/admin/adminstats.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button"
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
                      <li class="dropdown4">
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
                        <h1>신고된 회원 관리
                          <small>edit</small>
                        </h1>
                      </div>
                      <div class="form-group" align="center">                      
                      </div>
                      <div class="row">
                        <div class="col-md-1">
                          <input type="checkbox" id="ex_chk">
                          <br>
                          <img src="${root }/image/friend1.jpg" class="img-circle img-responsive">
                        </div>
                        <div class="col-md-2">
                          <br>
                          <div class="checks">
                            <br>
                            <button type="button" class="btn btn btn-default" data-target="#myModal"
                            data-toggle="modal">신고된 회원 ID </button>
                          </div>
                        </div>
                        <div class="col-md-1">
                          <input type="checkbox" id="ex_chk">
                          <br>
                          <img src="${root }/image/friend2.jpg" class="img-circle img-responsive">
                        </div>
                        <div class="col-md-2">
                          <br>
                          <div class="checks">
                            <br>
                             <button type="button" class="btn btn btn-default" data-target="#myModal"
                            data-toggle="modal">신고된 회원 ID </button>
                          </div>
                        </div>
                        <div class="col-md-1">
                          <input type="checkbox" id="ex_chk">
                          <br>
                          <img src="${root }/image/friend3.jpg" class="img-circle img-responsive">
                        </div>
                        <div class="col-md-2">
                          <br>
                          <div class="checks">
                            <br>
                             <button type="button" class="btn btn btn-default" data-target="#myModal"
                            data-toggle="modal">신고된 회원 ID </button>
                          </div>
                        </div>
                        <div class="col-md-1">
                          <input type="checkbox" id="ex_chk">
                          <br>
                          <img src="${root }/image/friend4.jpg" class="img-circle img-responsive">
                        </div>
                        <div class="col-md-2">
                          <br>
                          <div class="checks">
                            <br>
                             <button type="button" class="btn btn btn-default" data-target="#myModal"
                            data-toggle="modal">신고된 회원 ID </button>
                          </div>
                        </div>
                      </div>
                      <br>
                      <div class="row">
                        <div class="col-md-1">
                          <input type="checkbox" id="ex_chk">
                          <br>
                          <img src="${root }/image/friend5.jpg" class="img-circle img-responsive">
                        </div>
                        <div class="col-md-2">
                          <br>
                          <div class="checks">
                            <br>
                             <button type="button" class="btn btn btn-default" data-target="#myModal"
                            data-toggle="modal">신고된 회원 ID </button>
                          </div>
                        </div>
                        <div class="col-md-1">
                          <input type="checkbox" id="ex_chk">
                          <br>
                          <img src="${root }/image/friend6.jpg" class="img-circle img-responsive">
                        </div>
                        <div class="col-md-2">
                          <br>
                          <div class="checks">
                            <br>
                             <button type="button" class="btn btn btn-default" data-target="#myModal"
                            data-toggle="modal">신고된 회원 ID </button>
                          </div>
                        </div>
                        <div class="col-md-1">
                          <input type="checkbox" id="ex_chk">
                          <br>
                          <img src="${root }/image/friend7.jpg" class="img-circle img-responsive">
                        </div>
                        <div class="col-md-2">
                          <br>
                          <div class="checks">
                            <br>
                             <button type="button" class="btn btn btn-default" data-target="#myModal"
                            data-toggle="modal">신고된 회원 ID </button>
                          </div>
                        </div>
                        <div class="col-md-1">
                          <input type="checkbox" id="ex_chk">
                          <br>
                          <<img src="${root }/image/friend8.jpg" class="img-circle img-responsive">
                        </div>
                        <div class="col-md-2">
                          <br>
                          <div class="checks">
                            <br>
                             <button type="button" class="btn btn btn-default" data-target="#myModal"
                            data-toggle="modal">신고된 회원 ID </button>
                          </div>
                        </div>
                      </div>
                      <br>
                      <div class="row">
                        <div class="col-md-1">
                          <input type="checkbox" id="ex_chk">
                          <br>
                          <img src="${root }/image/friend9.jpg" class="img-circle img-responsive">
                        </div>
                        <div class="col-md-2">
                          <br>
                          <div class="checks">
                            <br>
                             <button type="button" class="btn btn btn-default" data-target="#myModal"
                            data-toggle="modal">신고된 회원 ID </button>
                          </div>
                        </div>
                        <div class="col-md-1">
                          <input type="checkbox" id="ex_chk">
                          <br>
                          <img src="${root }/image/friend10.jpg" class="img-circle img-responsive">
                        </div>
                        <div class="col-md-2">
                          <br>
                          <div class="checks">
                            <br>
                             <button type="button" class="btn btn btn-default" data-target="#myModal"
                            data-toggle="modal">신고된 회원 ID </button>
                          </div>
                        </div>
                        <div class="col-md-1">
                          <input type="checkbox" id="ex_chk">
                          <br>
                          <img src="${root }/image/friend11.jpg" class="img-circle img-responsive">
                        </div>
                        <div class="col-md-2">
                          <br>
                          <div class="checks">
                            <br>
                             <button type="button" class="btn btn btn-default" data-target="#myModal"
                            data-toggle="modal">신고된 회원 ID </button>
                          </div>
                        </div>
                        <div class="col-md-1">
                          <input type="checkbox" id="ex_chk">
                          <br>
                          <img src="${root }/image/friend12.jpg" class="img-circle img-responsive">
                        </div>
                        <div class="col-md-2">
                          <br>
                          <div class="checks">
                            <br>
                             <button type="button" class="btn btn btn-default" data-target="#myModal"
                            data-toggle="modal">신고된 회원 ID </button>
                          </div>
                        </div>
                      </div>
                      <br>
                      <div class="row">
                        <div class="col-md-1">
                          <input type="checkbox" id="ex_chk">
                          <br>
                          <img src="${root }/image/friend13.jpg" class="img-circle img-responsive">
                        </div>
                        <div class="col-md-2">
                          <br>
                          <div class="checks">
                            <br>
                             <button type="button" class="btn btn btn-default" data-target="#myModal"
                            data-toggle="modal">신고된 회원 ID </button>
                          </div>
                        </div>
                        <div class="col-md-1">
                          <input type="checkbox" id="ex_chk">
                          <br>
                          <img src="${root }/image/friend14.jpg" class="img-circle img-responsive">
                        </div>
                        <div class="col-md-2">
                          <br>
                          <div class="checks">
                            <br>
                            <button type="button" class="btn btn btn-default" data-target="#myModal"
                            data-toggle="modal">신고된 회원 ID </button>
                          </div>
                        </div>
                        <div class="col-md-1">
                          <input type="checkbox" id="ex_chk">
                          <br>
                          <img src="${root }/image/friend15.jpg" class="img-circle img-responsive">
                        </div>
                        <div class="col-md-2">
                          <br>
                          <div class="checks">
                            <br>
                             <button type="button" class="btn btn btn-default" data-target="#myModal"
                            data-toggle="modal">신고된 회원 ID </button>
                          </div>
                        </div>
                        <div class="col-md-1">
                          <input type="checkbox" id="ex_chk">
                          <br>
                          <img src="${root }/image/friend16.jpg" class="img-circle img-responsive">
                        </div>
                        <div class="col-md-2">
                          <br>
                          <div class="checks">
                            <br>
                             <button type="button" class="btn btn btn-default" data-target="#myModal"
                            data-toggle="modal">신고된 회원 ID </button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <form class="form-horizontal" action="main.html">
                    <div class="form-group" align="center">                  
                    </div>
                    <div class="form-group">
                      <div class="col-sm-10 text-center" align="center">
                        <button class="btn btn-primary" type="submit" id="join">삭제하기
                          <i class="fa fa-check spaceLeft"></i>
                        </button>
                      </div>
                    </div>
                  </form>
                  <hr>
                </div>
              </div>
            </article>
          </div>
        </div>
        <div class="tab-pane fade" role="tabpanel" id="profile" aria-labelledby="profile-tab">
          <p class="text-center">신고된 게시물 페이지</p>
        </div>
      </div>
    </div>
    <div id="myModal" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">×</button>
            <h4 class="modal-title">회원ID</h4>
          </div>
          <div class="modal-body">
            <div class="row">
              <div class="col-md-4">
                <img src="http://pingendo.github.io/pingendo-bootstrap/assets/placeholder.png"
                class="img-responsive">
              </div>
              <div class="col-md-7">
                <br>
                <div class="checks">
                  <h4 class="text-left">게시물제목</h4>
                </div>
              </div>
            </div>
            <br>
            <div class="row">
              <div class="col-md-4">
                <img src="http://pingendo.github.io/pingendo-bootstrap/assets/placeholder.png"
                class="img-responsive">
              </div>
              <div class="col-md-7">
                <br>
                <div class="checks">
                  <h4 class="text-left">게시물제목</h4>
                </div>
              </div>
            </div>
            <br>
            <div class="row">
              <div class="col-md-4">
                <img src="http://pingendo.github.io/pingendo-bootstrap/assets/placeholder.png"
                class="img-responsive">
              </div>
              <div class="col-md-7">
                <br>
                <div class="checks">
                  <h4 class="text-left">게시물제목</h4>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
  </body>

</html>