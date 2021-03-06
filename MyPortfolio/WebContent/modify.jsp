<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/style.css">
<meta charset="UTF-8">
<title>WebProject</title>
</head>
<body>
<%
/* 세션값받기 */
	String userID=null;
if(session.getAttribute("userID") !=null){
	 userID=(String) session.getAttribute("userID");
}

/* userDAO 에서 modify() 메소드 생성
modify 화면 생성해서 ID세션값 받기
post로 modifyAction.jsp에 값 보내기
modifyAction.jsp에서 userDAO에 있는 modify() 메소드에 값넣어서 쿼리문 실행
데이터베이스 문제시 -1 

 */

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
   <li><a href="main.jsp">게시판</a></li>
  </ul>
  <ul class="nav navbar-nav navbar-right">
   <li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expended="false">접속하기<span class="caret"></span></a>
    <ul class="dropdown-menu">
    <li class="active"><a href="login.jsp">로그인</a></li>
    <li><a href="logoutAction.jsp">로그아웃</a></li>
    </ul>
   </li>
  </ul>
 </div>
</nav>
<div class="container">
 <div class="col-lg-4"></div>
 <div class="col-lg-4">
  <div class="jumbotron" style="padding-top:20px;">
   <form method="post" action="modifyAction.jsp?id=<%=userID%>">
    <h3 style="text-align:center;">회원정보수정</h3>
   
    <div class="form-group">
     <input type="text" class="form-control" placeholder="<%=userID %>" name="userId" maxlength="20" readonly/>
    </div>
    <div class="form-group">
     <input type="password" class="form-control" placeholder="비밀번호" name="userPW" maxlength="20" />
    </div>
    <div class="form-group">
     <input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20" />
    </div>
    <div class="form-group">
     <input type="text" class="form-control" placeholder="이메일" name="userEmail" maxlength="40" />
    </div>
    <div class="form-group" style="text-align:center;">
    	<label class ="btn btn-primary"><input type="radio" name="userGender" autocomplete="off" value="female" checked>남자</label>
    	<label class ="btn btn-primary"><input type="radio" name="userGender" autocomplete="off" value="male">여자</label>
    </div>
    
    <input type="submit" class="btn btn-primary form-control" value="수정" />
    <input type="reset" class="btn btn-primary form-control" value="취소" />
   </form>
  </div>
 </div>
 <div class="col-lg-4"></div>
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>

