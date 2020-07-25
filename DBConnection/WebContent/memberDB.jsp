<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	Connection connection;
	Statement statement;
	ResultSet resultSet;
	
	//JDBC드라이버 ,URL, ID,PW
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String userid = "chan";
	String userpw = "1234";
	String query = "select * from student";
	
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	try{
	//오라클 드라이버값
	Class.forName(driver);
	//주소와 아이디 비밀번호 정보값
	connection = DriverManager.getConnection(url,userid,userpw);
	//SQL문
	statement = connection.createStatement();
	//출력문 : query를 활용하여 내 데이터 베이스 안에 있는는 정보값을 출력 
	resultSet = statement.executeQuery(query);
	//레코드 값을 위에서 부터 아래로 하나씩 출력하는 구문
	//출력할 자료가 있다면 ture , 없다면 false
	while(resultSet.next()){
		String num = resultSet.getString("NUM");
		String name= resultSet.getString("NAME");
		String old = resultSet.getString("old");
		String phonenumber = resultSet.getString("phonenumber");
		String address = resultSet.getString("address");
		String sex = resultSet.getString("sex");
		
		out.println("학번:" + num + "이름 :" + name + "나이 :  " + old + 
				"phone : " + phonenumber +"주소"+ address +"성별"+ sex );
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		//연걸을 끊어주는 구문
		try{
			if(resultSet !=null) resultSet.close();
			if(statement!=null)statement.close();
			if(connection!= null) connection.close();
		}catch(Exception e2){
			e2.printStackTrace();
		}
	}

%>
</body>
</html>