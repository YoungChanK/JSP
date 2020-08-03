<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>포트폴리오 사이트</title>
</head>
<body>

	<!-- 세션유지 -->
	<%
		/* 로그인 하지 않았을때의 세션 현황  */
	String userID = null;
	/* 로그인 했을때 의 세션 현황  */
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	// 로그인이 되어야 업데이트가 가능하다.
	// 로그인이 되어 있지 로그인 할 수 있도록 login.jsp로 이동
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("'location.href='bbs.jsp'");
		script.println("</script>");
	}

	// bbsID 초기값 선언;
	int bbsID = 0;
	// 업데이트가 되기위해 업데이트할 리스트의 순번이 정확히 파악되어야 한다.
	// 값을 받아와서 정수로 바꿔 값을 변환하여 넣는다
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}

	// 업데이트시 만약 순번이 0이라면 유효하지 않다고 기재
	if (bbsID == 0) {
		// 스크립트문 출력
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않는 정봉입니다.')");
		script.println("'location.href='bbs.jsp'");
		script.println("</script>");
	}

	// DAO의 정보를 받아와야 한다.
	Bbs bbs = new BbsDAO().getBbs(bbsID);
	if (!userID.equals(bbs.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("'location.href='bbs.jsp'");
		script.println("</script>");
	}
	%>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar-collapse"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a href="main.jsp" class="navbar-brand">WEBPR</a>
		</div>
		<!-- navbar-header -->
		<!-- 버튼 클릭했을때나 PC형태일떄 나오는 메뉴들 제작 -->

		<div class="collapse navbar-collapse" id="navbar-collapse">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
				<li><a href="portView.jsp">포트폴리오</a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false"> 회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
						<!-- dotoree   dragon -->
					</ul></li>
			</ul>
		</div>
	</nav>

	<!-- 게시판 -->
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?bbsID=<%=bbsID%>">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd;">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">게시판
								수정하기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="글제목" name="bbsTitle" maxlength="50"
								value="<%=bbs.getBbsTitle()%>"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글내용"
									name="bbsContent" maxlength="2100" style="height: 350px"><%=bbs.getBbsContent()%></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-rigth" value="글쓰기">
			</form>

		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>