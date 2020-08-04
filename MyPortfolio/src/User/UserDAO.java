package User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bbs.Bbs;

public class UserDAO {
 
 private Connection conn;            // ������ ���̽��� ������ ���� ��ü
 private PreparedStatement pstmt;    // SQL���� �����ͺ��̽��� ������ ���� ����ϴ� ��ü
 private ResultSet rs;               // SQL���ǿ� ���� ������ ���̺��� �����ϴ� ��ü

 public UserDAO() {
  try {
  
   String dbURL = "jdbc:mysql://localhost:3306/mydb";
   String dbID = "root";
   String dbPW = "1234";
   Class.forName("com.mysql.jdbc.Driver"); // DB����
   conn = DriverManager.getConnection(dbURL,dbID, dbPW);
  }catch(Exception e) {
   e.printStackTrace();
  }
 }
  
  public int login(String userID, String userPW) {
   
   String SQL = "SELECT userPW FROM USER WHERE userID=?";
   
   try {
    
    pstmt = conn.prepareStatement(SQL);
    //��� SQL���� �ִ� ù��° ?�� userID���� ����
    pstmt.setString(1,userID);
    //insert, delete, update�� pstmt.executeUpdate();�� ���������
    // select�� pstmt.executeQuery();�� ����Ѵ�.
    // rs = stmt.excuteQuery() - SQL ���� ����� ResultSet�� �����մϴ�.
    // SQL ������ �����ϰ� ����� ����
    rs = pstmt.executeQuery();
    // next�Լ��� ResultSet�� ����� SELECT�� ���� ����� ������� 1�྿ �Ѱܼ� ���࿡ ���� ���� ������
    if(rs.next()) {
     //rs.getString() - getString�Լ��� �ش� ������ �����ִ� �����͸� String������ �޾ƿ´� ���̴�.
     //SQL����� ���� �ش� ��й�ȣ���� ��ġ�ϸ�
     if(rs.getString(1).equals(userPW))
      //1���� �����Ͽ� �α��� ����
      return 1;
     else
      //�ƴϸ� 0���� �����Ͽ� ��й�ȣ ����
      return 0;
    }
    // ���̵� ���ų� ��ġ���� �ʴ´ٸ� -1�� ����
    return -1;
   }catch(Exception e) {
    e.printStackTrace();
   }
   // �����ͺ��̽� ������ ���� -2���� ����
   return -2;
  }
  
  
  //ȸ������ DAO
  
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

  	
  	//���������ϴ� �޼ҵ� ���� 
  	//������ �ʵ��� ���� �޾ƿ��� 
  	//SQL�� ����� DB������ ����
  	//���н� -1��ȯ
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