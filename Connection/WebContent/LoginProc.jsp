<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="mem.MemberMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	String url ="login.jsp";
	String msg ="로그인에 실패 하였습니다.";
	
	boolean result= mMgr.loginMember(id,pwd);
	if(result){
		session.setAttribute("idkey", id);
		msg="로그인 되었습니다.";
	}else{
		msg = "로그인에 실패 하였습니다.";
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>
</head>
<body>
	
</body>
</html>