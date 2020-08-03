<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href = "css/style.css" rel="stylesheet" type ="text/css">
<script type ="text/javascript" src="js/script.js"></script>
</head>
<!-- 페이지 로딩 및 새로 고침이 발새하면 포커스가 id 입력칸으로 위치 -->
<body bgcolor="#FFFFCC" onload="regFrm.id.focus()">
<div align ="center" >
<br><br>
<form name="regFrm" method="post" action="memberProc.jsp">
<table align ="center" border="0" cellSpacing ="0" cellpadding="5">
	<tr>
		<td align="center" valign="middle" bgcolor="#ffffcc">
			<table border="1" cellSpacing ="0" cellpadding="2" align="center" width="600">
				<tr align="center" bgcolor="#996600">
					<td colspan="3">
						<font color="#ffffff">
							<b>회원가입</b>
						</font>
					</td>
				</tr>
				<tr>
					<td width ="20%">아이디</td>
					<td width = "50%">
						<input name ="id" size="15">
						<input type="button" value="ID중복확인" onClick="idCheck(this.form.id.value)"></td>
					<td width="30%">아이디를 적어 주세요.</td>
				</tr>
				<tr>
					<td>패스워드</td>
					<td><input type = "password" name ="pwd" size="15"></td>
					<td>패스워드를 적어주세요</td>
				</tr>
				<tr>
					<td>패스워드 확인</td>
					<td><input type = "password" name ="repwd" size="15"></td>
					<td>패스워드를 확인합니다</td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type = "text" name ="name" size="15"></td>
					<td>이름을 입력해 주세요</td>
				</tr>
				<tr>
					<td>성별</td>
					<td>남<input type = "radio" name ="gender" value="1" checked="checked">
						여<input type = "radio" name ="gender" value="2"></td>
			
				</tr>
			</table>
		</td>
	</tr>
</table>



</form>


</div>
</body>
</html>