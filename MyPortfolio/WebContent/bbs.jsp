<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
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
	 //현재페이지의 수를 알려는 구문
	 int pageNumber = 1;
	 if(request.getParameter("pageNumber") != null){
	  pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
   <li class="active"><a href="bbs.jsp">게시판</a></li>
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
    <li><a href="join.jsp">로그아웃</a></li>
    </ul>
   </li>
  </ul>
<%} %>
 </div>
</nav>


<!-- 게시판   -->

	<div class ="container">
		<div class="row">
		
			<table class="table table-striped" style ="text-align:center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color:#eeeeee; text-align:center;">번호</th>
						<th style="background-color:#eeeeee; text-align:center;">제목</th>
						<th style="background-color:#eeeeee; text-align:center;">작성자</th>
						<th style="background-color:#eeeeee; text-align:center;">작성일</th>
					</tr>
				</thead>
				<tbody>
				<%
				BbsDAO bbsDAO = new BbsDAO();
				ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
				for(int i =0;i<list.size();i++){
					
				%>
					<tr>
						<td><%=list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID() %>"><%=list.get(i).getBbsTitle() %></a></td>
						<td><%=list.get(i).getUserID() %></td>
						<td><%=list.get(i).getBbsDate().substring(0,11)+list.get(i).getBbsDate().substring(11,13)+"시"+list.get(i).getBbsDate().substring(14,16)+"분" %></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<!--이전버튼과 이후 버튼을 만드는 과정  -->
			<%
				if(pageNumber !=1){
					
			%>
				<!-- 기본적 버튼이 생성되지만 배치적 위치는 왼쪽으로 배치 -->
				<a href="bbs.jsp?pageNumber=<%=pageNumber -1 %>" class="btn btn-success btn-arraow-left">이전</a>
			<%
				} if(bbsDAO.nextPage(pageNumber+1)){
			%>
			
				<a href="bbs.jsp?pageNumber=<%=pageNumber +1 %>" class="btn btn-success btn-arraow-left">이후</a>
			<%
				}
			%>
			
			
			
			
			
			
			
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>






<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>