<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mem.ZipcodeBean" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id='mMgr' class ="mem.MemberMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String search = request.getParameter("search");
	String area3=null;
	/* Vector는 ArrayList와 같은 구성 */
	Vector<ZipcodeBean> vlist=null;
	
	if(search.equals("y")){
		//요청한 area3 값의 매개변수 MemberMgr 클래스의 zipcodeRead()메소드를 호출하며 반환되는 값을 Vector 타입의 Vlist로 반환받는다.
		area3 =request.getParameter("area3");
		vlist = mMgr.ZipCodeRead(area3);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우편번호 검색</title>
<link href = "css/style.css" rel="stylesheet" type ="text/css">
<script type="text/javascript">

function loadSearch(){
	frm=document.zipFrm;
	if(frm.area3.value ==""){
		alert("도로명을 입력하세요");
		frm.area3.focus();
		return;
	}
	frm.action = "zipSearch.jsp";
	frm.submit();
}
//sendAdd() 함수는 도로명으로 검ㅅㄱ된 우편번호와 주소의 값을 가지고 자신을 오픈 시킨 페이지(member.jsp)로 넘어가면서 창을 닫은 자바스크립트 함수이다
function sendAdd(zipcode,adds){
		opener.document.regFrm.zipcode.value=zipcode;
		opener.document.regFrm.address.value=adds;
		//두 값이 인풋태그 안으로 들어가면서 서치창은 자동적으로 닫기게 된다.
		self.close();
}
</script>
</head>
<body bgcolor="#ffffcc">

<div align="center"></div>
<br>
<form name ="zipFrm" method="post">
	<table>
		<tr>
			<td><br>도로명 입력 : <input name ="area3">
			<!--버튼을 클릭하게 되면 zipSearch.jsp 가 열림 -->
			<input type="button" value ="검색" onclick="loadSearch()">
			</td>
		</tr>
		<!--검색결과 시작  -->
		<%
			if(search.equals("y")){
				//입력된 데이터 정보가 없을 경우(도로명)
				if(vlist.isEmpty()){
					
		%>	
		<tr>
			<td align="center"><br>검색된 결과가 없습니다.</td>
		</tr>
		<%
				}else{
		%>
		<tr>
			<td align="center"><br>※검색 후, 아래 우편번호를 클릭하면 자동으로 입력됩니다.</td>
		</tr>
		<%
			for(int i=0; i<vlist.size();i++){
				ZipcodeBean bean=vlist.get(i);
				String rZipcode =bean.getZipcode();
				String rArea1 = bean.getArea1();
				String rArea2 = bean.getArea2();
				String rArea3 = bean.getArea3();
				String adds = rArea1 + " " +rArea2 + " " + rArea3 + " ";
			
		%>
		<tr>
			<td><a href="#" onclick="javascript:sendAdd('<%=rZipcode%>','<%=adds %>')"><%=rZipcode %><%=adds %></a></td>
		</tr>
		<%
				}
			}
		}
		%>
		<!-- 검색 결과 끝 -->
		<tr>
			<td align ="center"><br>
			<a href="#" onClick="self.close()">닫기</a></td>
		</tr>
	</table>
		<input type="hidden" name="search" value="y">

</form>
</body>
</html>