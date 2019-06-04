<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<body>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <title>관리자 게시물 관리</title>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <script type="text/javascript"
      src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
   <script type="text/javascript"
      src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
   <link
      href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
      rel="stylesheet" type="text/css">
   <link
      href="http://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css"
      rel="stylesheet" type="text/css">
   
   <script type='text/javascript'>
      function CheckForHash(){
         if(document.location.hash){
            var HashLocationName = document.location.hash;
            HashLocationName = HashLocationName.replace("#","");
            document.getElementById(HashLocationName).style.display='block';
            document.getElementById('Intructions').style.display='none';
            for(var a=0; a<5; a++){
               if(HashLocationName != ('Show' +(a+1))){
                  document.getElementById('Show'+(a+1)).style.display='none';
               }
            }
         }else{
            document.getElementById('Intructions').style.display='block';
            for(var a=0; a<5; a++){
               document.getElementById('Show'+(a+1)).style.display='none';
            }
         }
      }
      function RenameAnchor(anchorid, anchorname){
         document.getElementById(anchorid).name = anchorname; //this renames the anchor
      }
      function RedirectLocation(anchorid, anchorname, HashName){
         RenameAnchor(anchorid, anchorname);
         document.location = HashName;
      }
      var HashCheckInterval = setInterval("CheckForHash()", 500);
      window.onload = CheckForHash;
   </script>
   
   
   
   
   
   
   <div class="navbar navbar-default navbar-static-top">
      <div class="container">
         <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
               data-target="#navbar-ex-collapse">
               <span class="sr-only">Toggle navigation</span> <span
                  class="icon-bar"></span> <span class="icon-bar"></span> <span
                  class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"></a>
         </div>
         <div class="collapse navbar-collapse" id="navbar-ex-collapse">
            <ul class="nav navbar-nav navbar-right">
               <li><a href="#">로그아웃</a></li>
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
                        <button type="button" class="navbar-toggle collapsed"
                           data-toggle="collapse"
                           data-target="#bs-example-navbar-collapse-1"
                           aria-expanded="false">
                           <span class="sr-only">Toggle navigation</span> <span
                              class="icon-bar"></span> <span class="icon-bar"></span> <span
                              class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="#">관리자 menu</a>
                     </div>
                     <!-- Collect the nav links, forms, and other content for toggling -->
                     <div class="collapse navbar-collapse"
                        id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav navbar-right">
                           <li class="dropdown1"><a href="#" class="dropdown-toggle"
                              data-toggle="dropdown" role="button" aria-haspopup="true"
                              aria-expanded="false"> 회원 관리 </a>
                              <ul class="dropdown-menu">
                                 <li>
                            <a href="${root }/admin/adminmember.jsp">신고된 회원 관리</a>
                          </li>
                          <li>
                            <a href="${root }/admin/adminstats.jsp">회원 통계</a>
                          </li>
                              </ul></li>
                           <li class="dropdown2"><a href="#"
                              class="dropdown-toggle" data-toggle="dropdown" role="button"
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
                              </ul></li>
                           <li class="active dropdown3"><a href="#" class="dropdown-toggle"
                              data-toggle="dropdown" role="button" aria-haspopup="true"
                              aria-expanded="false"> 게시물 통계 </a>
                              <ul class="dropdown-menu">
                                 <li><a
                                    href='javascript:RedirectLocation("LocationAnchor", "Show1", "#Show1");'>
                                       날짜별 계시물 통계 </a></li>
                                 <li><a
                                    href='javascript:RedirectLocation("LocationAnchor", "Show1", "#Show1");'>
                                       지역별 계시물 통계</a></li>
                                       
                           <a id='LocationAnchor' name=''></a>
                           <div id='linkholder'>
                                       
                              </ul></li>
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
                  <!-- /.container-fluid --> </nav>
               </div>
            </div>
         </div>
      </div>
   
   
   </div>
   <div id='Show1' style='display: none; font-size: 20px'>

                                 <h2>지역별 통계 현황</h2>
                                 <div class="progress">
                                    <div
                                       class="progress-bar progress-bar-success progress-bar-striped"
                                       role="progressbar" aria-valuenow="40" aria-valuemin="0"
                                       aria-valuemax="100" style="width: 40%">40% Complete
                                       (success)</div>
                                 </div>
                                 <div class="progress">
                                    <div
                                       class="progress-bar progress-bar-info progress-bar-striped"
                                       role="progressbar" aria-valuenow="50" aria-valuemin="0"
                                       aria-valuemax="100" style="width: 50%">50% Complete
                                       (info)</div>
                                 </div>
                                 <div class="progress">
                                    <div
                                       class="progress-bar progress-bar-warning progress-bar-striped"
                                       role="progressbar" aria-valuenow="60" aria-valuemin="0"
                                       aria-valuemax="100" style="width: 60%">60% Complete
                                       (warning)</div>
                                 </div>
                                 <div class="progress">
                                    <div
                                       class="progress-bar progress-bar-danger progress-bar-striped"
                                       role="progressbar" aria-valuenow="70" aria-valuemin="0"
                                       aria-valuemax="100" style="width: 70%">70% Complete
                                       (danger)</div>
                                 </div>

                              </div></li>
</body>
</html>