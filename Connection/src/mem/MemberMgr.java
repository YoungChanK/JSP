package mem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import pool.DBConnectionMgr;

public class MemberMgr {

// Ŀ�ؼ�Ǯ�̶�� �ν��Ͻ� ������ ����
 
 private DBConnectionMgr pool;
 
 public MemberMgr() {
  
  try {
   pool = DBConnectionMgr.getInstance();
  }catch(Exception e) {
   e.printStackTrace();
  }
  
 }
 
 // ID�ߺ�Ȯ��
 
 public boolean checkId(String id) {
  
  Connection conn = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  String SQL = null;
  boolean flag = false;
  
  try {
   //pool��ü�� ���ؼ� mysql�� �����մϴ�.
   conn = pool.getConnection();
   SQL = "select id from tblMember where id = ?";
   //SQL���� DB�� ������ ���� prepareStatement�� ����
   pstmt = conn.prepareStatement(SQL);
   pstmt.setString(1, id);
   flag = pstmt.executeQuery().next();
   
  }catch(Exception e) {
   e.printStackTrace();
  } finally {
   //Connection ��ü�� �����ϱ� ���ؼ� ���� �ʰ� pool�� �ݳ�
   pool.freeConnection(conn, pstmt, rs);
  }
  return flag;
 }
 
 
 
 
 
}