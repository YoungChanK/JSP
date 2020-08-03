<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="User.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="User.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPW" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <%
 	String userID=null;
 if(session.getAttribute("userID") !=null){
	 userID=(String) session.getAttribute("userID");
 }
 if(userID!=null){
	 	PrintWriter script = response.getWriter();
	   script.println("<script>");
	   script.println("alert('이미 로그인 되었습니다.')");
	   script.println("location.href='main.jsp'");
	   script.println("</script>");
 }
 
 
 
 
  UserDAO userDAO = new UserDAO();
  int result = userDAO.login(user.getUserID(), user.getUserPW());
  if(result == 1){
	  //세션처리
	session.setAttribute("userID", user.getUserID());
   PrintWriter script = response.getWriter();
   script.println("<script>");
   script.println("location.href='main.jsp'");
   script.println("</script>");
  }else if(result == 0){
   PrintWriter script = response.getWriter();
   script.println("<script>");
   script.println("alert('비밀번호가 틀립니다.')");
   script.println("history.back()");
   script.println("</script>");
  }else if(result == -1){
   PrintWriter script = response.getWriter();
   script.println("<script>");
   script.println("alert('존재하지 않는 아이디 입니다.')");
   script.println("history.back()");
   script.println("</script>");
  }else if(result == -2){
   PrintWriter script = response.getWriter();
   script.println("<script>");
   script.println("alert('데이터베이스 오류가 발생했습니다.')");
   script.println("history.back()");
   script.println("</script>");
  }
 
 %>


</body>
</html>