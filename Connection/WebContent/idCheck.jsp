<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="mem.MemberMgr" />
<%
 request.setCharacterEncoding("UTF-8");
 String id = request.getParameter("id");
 boolean result = mMgr.checkId(id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#f7f9fa">
 <div align="center">
  <br><b><%=id %></b>
  <%
   if(result){
    out.println("는 이미 존재하는 ID입니다.");
   } else {
    out.println("는 사용가능합니다.");
   }
  %>
  <a href="#" onClick="self.close()">닫기</a>
 </div>

</body>
</html>