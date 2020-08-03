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
 String userID1 = request.getParameter("userID");
/*UserDAO userDAO = new UserDAO();
int num=userDAO.modify(userID1,request.getParameter("userPW"),request.getParameter("userName"),request.getParameter("userEmail"),request.getParameter("userGender"));
if(num==-1) {
	PrintWriter obj = response.getWriter();
	obj.println("<scrit>");
	obj.println("alert('실패')");
	obj.println("</scrit>");
}

  */
 	if(user.getUserPW()==null ||user.getUserName() ==null ||user.getUserGender()==null ||user.getUserEmail()==null){
 		 PrintWriter script = response.getWriter();
 		   script.println("<script>");
 		   script.println("alert('입력이 되어 있지 않습니다.')");
 		   script.println("history.back()");
 		   script.println("</script>");
 		
 	}else{
 		  UserDAO userDAO = new UserDAO();
 		 int result = userDAO.modify(userID,request.getParameter("userPW"),request.getParameter("userName"),request.getParameter("userEmail"),request.getParameter("userGender"));
 		 if(result ==-1 ){
 			 PrintWriter script = response.getWriter();
 			 script.println("<script>");
 	 		 script.println("alert('디비오류')");
 	 		 script.println("history.back()");
 	 		 script.println("</script>");
 		 }else{
 			session.setAttribute("userID", user.getUserID());
 			 PrintWriter script = response.getWriter();
 			 script.println("<script>");
 			script.println("alert('회원정보 수정 완료.')");
 	 		 script.println("location.href='main.jsp'");
 	 		 script.println("</script>");
 			 
 		 }
 	} 
 
 
 
 
  
 %>


</body>
</html>