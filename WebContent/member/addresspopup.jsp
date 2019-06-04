<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>

<title>도로명주소 검색</title>
<% 
   request.setCharacterEncoding("UTF-8");  //한글깨지면 주석제거
   String inputYn = request.getParameter("inputYn"); 
   String roadFullAddr = request.getParameter("roadFullAddr"); 
   String roadAddrPart1 = request.getParameter("roadAddrPart1"); 
   String roadAddrPart2 = request.getParameter("roadAddrPart2"); 
   String engAddr = request.getParameter("engAddr"); 
   String jibunAddr = request.getParameter("jibunAddr"); 
   String zipNo = request.getParameter("zipNo"); 
   String addrDetail = request.getParameter("addrDetail"); 
   String admCd    = request.getParameter("admCd");
   String rnMgtSn = request.getParameter("rnMgtSn");
   String bdMgtSn  = request.getParameter("bdMgtSn");
%>
</head>
<script language="javascript">
function init(){
   var url = location.href;
   var confmKey = "U01TX0FVVEgyMDE2MTExNzE0NTQxMTE2NjMy";
   // resultType항목 추가(2016.10.06)
   var resultType = "4"; // 도로명주소 검색결과 화면 출력유형, 1 : 도로명, 2 : 도로명+지번, 3 : 도로명+상세건물명, 4 : 도로명+지번+상세건물명
   var inputYn= "<%=inputYn%>";
   if(inputYn != "Y"){
      document.form.confmKey.value = confmKey;
      document.form.returnUrl.value = url;
      document.form.resultType.value = resultType; // resultType항목 추가(2016.10.06)
      document.form.action="http://www.juso.go.kr/addrlink/addrLinkUrl.do"; //인터넷망
      document.form.submit();
   }else{
      opener.jusoCallBack("<%=roadFullAddr%>","<%=roadAddrPart1%>","<%=addrDetail%>",
         "<%=roadAddrPart2%>","<%=engAddr%>","<%=jibunAddr%>","<%=zipNo%>", 
         "<%=admCd%>", "<%=rnMgtSn%>", "<%=bdMgtSn%>");
      window.close();
   }
}
</script>
</head>
<body onload="init();">
   <form id="form" name="form" method="post">
      <input type="hidden" id="confmKey" name="confmKey" value=""/>
      <input type="hidden" id="returnUrl" name="returnUrl" value=""/>
      <input type="hidden" id="resultType" name="resultType" value=""/> 
      <!-- 해당시스템의 인코딩타입이 EUC-KR일경우에만 추가 START--> 
      <!-- 
      <input type="hidden" id="encodingType" name="encodingType" value="EUC-KR"/>
       -->
      <!-- 해당시스템의 인코딩타입이 EUC-KR일경우에만 추가 END-->
   </form>
</body>
</html>





