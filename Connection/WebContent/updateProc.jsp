<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <% request.setCharacterEncoding("UTF-8"); %>
 <jsp:useBean id="mgr" class="mem.MemberMgr"/>
 <jsp:useBean id="bean" class ="mem.MemberBean"/>
 <jsp:setProperty  name="bean" property ="*"/>

 <%
 //boolean result로 들어오는 값이 false이나 true이냐에 따라 회원가입 실패 또는 회원가입으로 나위어 지게 되고 가입이 실패 -> member.jsp로  
 //성공시 login.jsp로
 	boolean result = mgr.updateMember(bean);
 	String mag= "정보수정에 실패 했습니다.";
 	String location = "member.jsp";
 	if(result){
 		mag = "정보수정을 하였습니다. 다시 로그인 해주세요";
 		location = "login.jsp";
 	}
 
 
 %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script>
 	alert("<%=mag%>");
 	location.href="<%=location%>"
 </script>
</head>
<body>

</body>
</html>