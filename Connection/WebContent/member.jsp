<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href = "css/style.css" rel="stylesheet" type ="text/css">
<script type ="text/javascript">


function idCheck(id) {
	  frm = document.regFrm;
	  if (id == "") {
	   alert("아이디를 입력해 주세요.");
	   frm.id.focus();
	   return;
	  }
	  url = "idCheck.jsp?id=" + id;
	  window.open(url, "IDCheck", "width=300,height=150");
	 }

	 function zipSearch() {
	  url = "zipSearch.jsp?search=n";
	  window.open(url, "ZipCodeSearch","width=500,height=300,scrollbars=yes");
	 }
</script>

</head>
<!-- 페이지 로딩 및 새로 고침이 발새하면 포커스가 id 입력칸으로 위치 -->
<body bgcolor="#f7f9fa" onload="regFrm.id.focus()">
<div align ="center" >
<br><br>
<form name="regFrm" method="post" action="memberProc.jsp">
<table id = "tb1" align ="center" border="0" cellSpacing ="0" cellpadding="5">
	<tr>
		<td align="center" valign="middle" bgcolor="#ffffff">
			<table id = "tb2" border="1" cellSpacing ="0px" cellpadding="2px" align="center" width="700px">
				<tr id = "tr1"align="center" bgcolor="#000000">
					<td colspan="3">
						<font color="#ffffff">
							<b>회 원 가 입</b>
						</font>
					</td>
				</tr>
				<tr>
					<td width ="20%"><p>아이디</p></td>
					<td width = "60%">
						<input name ="id" size="30">
						<input type="button" value="ID중복확인" onClick="idCheck(this.form.id.value)"></td>
			
				</tr>
				<tr>
					<td><p>패스워드</p></td>
					<td><input type = "password" name ="pwd" size="30"></td>
					
				</tr>
				<tr>
					<td><p>패스워드 확인</p></td>
					<td><input type = "password" name ="repwd" size="30"></td>
					
				</tr>
				<tr>
					<td><p>이름</p></td>
					<td><input type = "text" name ="name" size="30"></td>
				
				</tr>
				<tr >
					<td><p>성별</p></td>
					<td id="genderflex"><p>남자</p><input type = "radio" name ="gender" value="1" checked="checked">
						<p>여자</p><input type = "radio" name ="gender" value="2"></td>
			
				</tr>
				<tr>
					<td><p>생년월일</p></td>
					<td><input name ="birthday" size="15">&nbsp;&nbsp;ex)931220</td>
			
				</tr>
				<tr>
					<td><p>Email</p></td>
					<td><input type="text" name ="email" size="30"></td>
				</tr>
				<tr>
					<td><p>우편번호</p></td>
					<td><input type="text" name ="zipcode" size="5" readonly>
						<input type="button" value="우편번호찾기"  onclick="zipSearch()"></td>
				
				</tr>
				<tr>
					<td><p>주소</p></td>
					<td><input name ="address" size=""></td>
	
				</tr>
				<tr>
					<td><p>취미</p></td>
					<td>
						<p>인터넷<input type ="checkbox" name ="hobby"  value="인터넷"></p>
						<p>여행<input type ="checkbox" name ="hobby"  value="여행"></p>
						<p>게임<input type ="checkbox" name ="hobby"  value="게임"></p>
						<p>영화<input type ="checkbox" name ="hobby"  value="영화"></p>
						<p>운동<input type ="checkbox" name ="hobby"  value="운동"></p>
					</td>
				
				</tr>
				<tr>
					<td><p>직업</p></td>
					<td><select name ="job">
						<option value="0" selected>선택하세요.
						<option value="회사원">회사원
						<option value="연구전문직">연구전문직
						<option value="교수학생">교수학생
						<option value="일반자영업">일반자영업
						<option value="공무원">공무원
						<option value="의료인">의료인
						<option value="법조인">법조인
						<option value="종교,언론,예술인">종교,언론,예술인
						<option value="농,축,수산,광업인">농,축,수산,광업인
						<option value="주부">주부
						<option value="무직">무직
						<option value="기타">기타
					</select>
					</td>
				
				</tr>
				<tr>
					<td id="lasttd" colspan="3" align="center"><input type="button" value="회원가입" onclick="inputCheck()">&nbsp;&nbsp;
						<input type="reset" value="다시쓰기">&nbsp;&nbsp;
						<input type="button" value="로그인" onclick="javascrot:location.href='login.jsp'">
					</td>
				</tr>
			</table>
		</td>
	</tr> 
</table>



</form>


</div>
</body>
</html>