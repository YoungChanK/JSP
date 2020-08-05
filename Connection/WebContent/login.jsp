<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	request.setCharacterEncoding("UTF-8");
 	String id=(String)session.getAttribute("idkey");
 
 
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href = "css/style.css" rel="stylesheet" type ="text/css">
<script type ="text/javascript">
	function loginCheck(){
		if(document.loginFrm.id.value==""){
			alert("아이디를 입력해 주세요");
			document.loginFrm.id.focus();
			return;
		}
		if(document.loginFrm.pwd.value==""){
			alert("패스워드를 입력해 주세요");
			document.loginFrm.pwd.focus();
			return;	
		}
		document.loginFrm.submit();
		
	}

</script>
</head>
<body bgcolor="#f7f9fa">
	<div id="logindiv" align="center">
		<br>
		<br>
		<%if (id !=null){ %>
		<b><%=id %></b>님 환영합니다
		<p>제한된 기능을 활용하실수 있습니다.</p>
		<a href="update.jsp">정보수정</a>&nbsp; &nbsp;
		<a href="Logout.jsp">로그아웃</a>
		<%}else{%>
		<form name="loginFrm" method="post" action="LoginProc.jsp">
		<table>
			<tr>
				<td id="logintd" colspan ="2">
					<font color="#ffffff">
							<b>로 그 인</b>
						</font>
				</td>
			</tr>
			<tr class="logintr">
				<td><p>아 이 디</p></td>
				<td><input type ="text" name ="id"></td>
			</tr>
			<tr class="logintr">
				<td><p>비밀번호</p></td>
				<td><input type ="password" name ="pwd"></td>
			</tr>
			<tr>
				<td colspan="2">
					<div align ="right">
						<input type ="button" value="로그인" onclick="loginCheck()">&nbsp;
						<input type ="button" value="회원가입" onclick="javascript:location.href='member.jsp'">&nbsp;
					</div>
				</td>
			</tr>
		</table>
		</form>
		<%}%>
	</div>
</body>
</html>