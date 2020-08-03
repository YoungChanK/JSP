<%@ page import="java.io.PrintWriter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포트폴리오사이트</title>
</head>
<body>
<%
//세션종료
session.invalidate();
%>
<script>
	location.href='main.jsp';
</script>
</body>
</html>