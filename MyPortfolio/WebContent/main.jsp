<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equive="Content-Type" content="text/html charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/style.css">
<title>포트폴리오 사이트</title>
</head>
<body>
<%
	/*로그인 하지 않았을때의 세션 현황  */
	String userID=null;
	/* 로그인 하였을때의 새션 유지 현황 */
	if(session.getAttribute("userID") !=null){
	 userID=(String) session.getAttribute("userID");
}
%>

<nav class="navbar navbar-default">
 <div class="navbar=header">
  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#slideMenu" aria-expanded="false">
   <span class="icon-bar"></span>
   <span class="icon-bar"></span>
   <span class="icon-bar"></span>  
  </button>
  <a class="navbar-brand" href="main.jsp">MYWEB</a>
 </div>
 <div class="collapse navbar-collapse" id="slideMenu">
  <ul class="nav navbar-nav">
   <li><a href="main.jsp">메인</a></li>
   <li><a href="bbs.jsp">게시판</a></li>
   <li><a href="main.jsp">포트폴리오</a></li>
  </ul>
  <%
  	if(userID==null){
  %>
  <ul class="nav navbar-nav navbar-right">
   <li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expended="false">접속하기<span class="caret"></span></a>
    <ul class="dropdown-menu">
    <li class="active"><a href="login.jsp">로그인</a></li>
    <li><a href="join.jsp">회원가입</a></li>
    </ul>
   </li>
  </ul>
  <%
  //세션값이 내 정보값이 내장되어 있는 경우
  	}else{
  %>
   <ul class="nav navbar-nav navbar-right">
   <li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expended="false">접속하기<span class="caret"></span></a>
    <ul class="dropdown-menu">
    <li ><a href="modify.jsp">회원수정</a></li>
    <li><a href="logoutAction.jsp">로그아웃</a></li>
    </ul>
   </li>
  </ul>
<%} %>
 </div>
</nav>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>