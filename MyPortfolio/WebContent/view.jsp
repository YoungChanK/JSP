<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
    <%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
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
	int bbsID =0;
	if(request.getParameter("bbsID") != null){
		bbsID=Integer.parseInt(request.getParameter("bbsID"));
	}
	if(bbsID== 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 정보입니다')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
	
	}
	//이와 같은 구문을 통해 게시판 빈영역에 입력한 데이터 값들이담겨 나타날 수 있도록 조치
	Bbs bbs = new BbsDAO().getBbs(bbsID);
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
    <li><a href="logoutAction.jsp">로그아웃</a></li>
    </ul>
   </li>
  </ul>
<%} %>
 </div>
</nav>


<!-- 게시판   -->

	<div class ="container">
		<div class="row">
		<form method="post" action="writeAction.jsp">
			<table class="table table-striped" style ="text-align:center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan ="2" style ="background-color:#eeeeee;  text-align :center;">게시판 글보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width:20%">글제목</td>
						<td colspan="2"><%=bbs.getBbsTitle() %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%=bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td><%=bbs.getBbsDate().substring(0,11)+bbs.getBbsDate().substring(11,13)+"시"+bbs.getBbsDate().substring(14,16)+"분" %></td>
					</tr>
						<tr>
						<td>내용</td>
						<td colspan="2" style="min-width:200px; text-align:left"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
				<%
				/*  로그인 후 게시물을 보고 있을떄 */
					if (userID != null && userID.equals(bbs.getUserID())) {
				%>
				<!-- 리스트 번호에 관련되는 사항을 update.jsp에서 변경시키겟다 -->
				<a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수정</a>
					<!-- 리스트 번호에 관련되는 사항을 deleteAction.jsp에서 삭제시키겟다 -->
				 <a onclick="return confirm('진짜로 삭제할까요.?)" href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">삭제</a>
				<%
				
					}
				%>
			</form>
		</div>
	</div>






<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>