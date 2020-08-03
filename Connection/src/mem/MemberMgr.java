package mem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import pool.DBConnectionMgr;

public class MemberMgr {

// 커넥션풀이라는 인스턴스 변수를 생성
 
 private DBConnectionMgr pool;
 
 public MemberMgr() {
  
  try {
   pool = DBConnectionMgr.getInstance();
  }catch(Exception e) {
   e.printStackTrace();
  }
  
 }
 
 // ID중복확인
 
 public boolean checkId(String id) {
  
  Connection conn = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  String SQL = null;
  boolean flag = false;
  
  try {
   //pool객체를 통해서 mysql에 연결합니다.
   conn = pool.getConnection();
   SQL = "select id from tblMember where id = ?";
   //SQL문을 DB에 보내기 위한 prepareStatement을 생성
   pstmt = conn.prepareStatement(SQL);
   pstmt.setString(1, id);
   flag = pstmt.executeQuery().next();
   
  }catch(Exception e) {
   e.printStackTrace();
  } finally {
   //Connection 객체를 재사용하기 위해서 닫지 않고 pool에 반납
   pool.freeConnection(conn, pstmt, rs);
  }
  return flag;
 }
 
 
 
 
 
}