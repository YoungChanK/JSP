<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <% request.setCharacterEncoding("UTF-8"); %>
 <jsp:useBean id="mgr" class="mem.MemberMgr"/>
 <jsp:useBean id="bean" class ="mem.memberBean"/>
 <jsp:setProperty property ="*" name="bean">
 <%
 //boolean result로 들어오는 값이 false이나 true이냐에 따라 회원가입 실패 또는 회원가입으로 나위어 지게 되고 가입이 실패 -> member.jsp로  
 //성공시 login.jsp로
 	boolean result = mgr.insertMember(bean);
 	String mag= "회원가입에 실패 했습니다.";
 	String location = "member.jsp";
 	if(result){
 		mag = "회원가입을 하였습니다.";
 		location = "login.jsp";
 	}
 
 
 %>
 <script>
 	alert("<%=mag%>");
 	location.href="<%=location%>"
 </script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>