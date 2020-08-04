package User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bbs.Bbs;

public class UserDAO {
 
 private Connection conn;            // 데이터 베이스와 연결을 위한 객체
 private PreparedStatement pstmt;    // SQL문을 데이터베이스에 보내기 위해 사용하는 객체
 private ResultSet rs;               // SQL질의에 의해 생성된 테이블을 저장하는 객체

 public UserDAO() {
  try {
  
   String dbURL = "jdbc:mysql://localhost:3306/mydb";
   String dbID = "root";
   String dbPW = "1234";
   Class.forName("com.mysql.jdbc.Driver"); // DB연결
   conn = DriverManager.getConnection(dbURL,dbID, dbPW);
  }catch(Exception e) {
   e.printStackTrace();
  }
 }
  
  public int login(String userID, String userPW) {
   
   String SQL = "SELECT userPW FROM USER WHERE userID=?";
   
   try {
    
    pstmt = conn.prepareStatement(SQL);
    //상단 SQL문에 있는 첫번째 ?에 userID값을 적용
    pstmt.setString(1,userID);
    //insert, delete, update는 pstmt.executeUpdate();를 사용하지만
    // select는 pstmt.executeQuery();를 사용한다.
    // rs = stmt.excuteQuery() - SQL 질의 결과를 ResultSet에 저장합니다.
    // SQL 문장을 실행하고 결과를 리턴
    rs = pstmt.executeQuery();
    // next함수는 ResultSet에 저장된 SELECT문 실행 결과를 행단위로 1행씩 넘겨서 만약에 다음 행이 있으면
    if(rs.next()) {
     //rs.getString() - getString함수는 해당 순서의 열에있는 데이터를 String형으로 받아온단 뜻이다.
     //SQL결과문 값중 해당 비밀번호값과 일치하면
     if(rs.getString(1).equals(userPW))
      //1값을 리턴하여 로그인 성공
      return 1;
     else
      //아니면 0값을 리턴하여 비밀번호 실패
      return 0;
    }
    // 아이디가 없거나 일치하지 않는다면 -1값 리턴
    return -1;
   }catch(Exception e) {
    e.printStackTrace();
   }
   // 데이터베이스 오류로 인한 -2값을 리턴
   return -2;
  }
  
  
  //회원가입 DAO
  
  	public int join(User user) {
  		String SQL = "INSERT INTO USER VALUES(?,?,?,?,?)";
  		
  		try {
  			pstmt=conn.prepareStatement(SQL);
  			pstmt.setString(1, user.getUserID());
  			pstmt.setString(2, user.getUserPW());
  			pstmt.setString(3, user.getUserName());
  			pstmt.setString(4, user.getUserGender());
  			pstmt.setString(5, user.getUserEmail());
  			return pstmt.executeUpdate();
  		}catch(Exception e) {
  			e.printStackTrace();
  		}
  		return -1;
  	}

  	
  	//정보수정하는 메소드 생성 
  	//수정할 필드의 값을 받아오기 
  	//SQL문 만들고 DB접속후 삽입
  	//실패시 -1반환
	public int modify(String userID, String userPW, String userName, String userEmail , String userGender) {
  		String SQL = "UPDATE USER SET USERPW = ?,USERName = ?,USERGender = ?,USEREmail = ? WHERE USERID =?";
  		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPW);
			pstmt.setString(2, userName);
			pstmt.setString(3, userGender);
			pstmt.setString(4, userEmail);
			pstmt.setString(5, userID);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
  	}
  
  
//		pstmt=conn.prepareStatement(SQL);
//		pstmt.setString(1, user.getUserPW());
//		pstmt.setString(2, user.getUserName());
//		pstmt.setString(3, user.getUserGender());
//		pstmt.setString(4, user.getUserEmail());
//		pstmt.setString(5, userID);
//		return pstmt.executeUpdate();
//		
  
  
  
 }