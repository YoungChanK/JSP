package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	// DAO������ DB�� ������ �ִ� ����

	private Connection conn;
	private ResultSet rs;

	// DB���ᱸ��
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/mydb";
			String dbID = "root";
			String dbPW = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPW);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// �Խ��ǿ� ���� �Է��ϱ� ���� 3������ �޼ҵ�
	// getNext(), getDate(), int write
	// ���� �ֽű�1 > �״�����2 >�� ������3
	public int getNext() {

		// �Խù��� �� �ִ� ������ �������� �����Ͽ� �������� ����
		// �Խù��� ������ ���� ���� �޼ҵ�
		// ASC(��������)
		// DESC(��������)
		// ORDER By : ����
		String SQL = "SELECT bbsID FROM BBS ORDER By bbsID DESC";
		try {
			// �������� ����� �������� ���� ù ����
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// �������� ������� rs�� ����
			rs = pstmt.executeQuery();
			// next() : 1������ ������������ �ϳ��� ��ȸ�� ������ �޼ҵ�
			if (rs.next()) {
				// �� ���� �Խñ��� ������ �������� ����� �ִ� ���� ��ȯ
				return rs.getInt(1) + 1;
			}
			// ù��° �Խù��� ���
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}

	// �Խù� ��¥�� ǥ���ϴ� �޼ҵ�
	public String getDate() {

		// �Խù��� �� �ִ� ������ �������� �����Ͽ� �������� ����
		String SQL = "SELECT NOW()";
		try {
			// �������� ����� �������� ���� ����
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// �������� ����� �޴´�.
			rs = pstmt.executeQuery();
			// next() : 1������ ������������ �ϳ��� ��ȸ�� ������ �޼ҵ�
			if (rs.next()) {
				// ù��° �Խù��� ���� ��¥�� ��ȯ > next > next...
				return rs.getString(1); // ��¥ ��ȯ
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // �����ͺ��̽� ����
	}

	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBS VALUE (?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
//LIST ����
//����� �������� ���� �޼ҵ� ����
	
	public ArrayList<Bbs> getList(int pageNumber){
		//bbsAvailable = 1 : �Խ��ǿ� ���̴� ��ϵ�
		//ORDER BY bbsID DESC LIMIT10" : 10�� ������ ��ϸ� �����ش�.
		//
		//���� ��ȿ��ȣ�� �����ϰ� ���Ӱ� �ۼ��� �Խñ� ��ȣ���� ���� �Խñ� ��ȣ�� ���� �����Ͽ� �ִ� 10���� ��ȸ�Ѵ�
		//String SQL ="SELECT * FROM BBS WHERE bbsID< ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT10";
		  String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		//bbs���� ������ �ν��Ͻ��� ������ �� �ִ� ����Ʈ������ ����
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//�� ��� ����
			//getnext = �����ۿ� �ۼ��� �Խñ� ��ȣ
			//���� ���� ���� 3����� getNext()=4,1������ ������ ������� 4���ȴ�.
			//4���� ���� 5���� ���̱��� ��µǰ� ǥ��
			pstmt.setInt(1, getNext() - (pageNumber -1) *10);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//���࿡ ����Ʈ�� ������ 10���� ������ ���� ǥ���Ѵٰ� ������ ������������ ��Ÿ���� �ʵǴϱ� �׷��� �̸޼ҵ带 Ȱ���ϴ°��̴�.
	public boolean nextPage(int pageNumber){
		  
		  String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		  
		  //bbs���� ������ �ν��ͽ��� ������ �� �ִ� ����Ʈ������ ����
		 
		
		  try {
		   PreparedStatement pstmt = conn.prepareStatement(SQL);
		   pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
		   rs=pstmt.executeQuery();
		   if(rs.next()) {
		    //10������ �ϳ� �̻� ����Ʈ�� �����Ѵٸ� ������������ �����Ѵٶ�°���
		    //�ǹ�
		    return true;
		   }
		  }catch(Exception e) {
		   e.printStackTrace();
		  }
		  //10���� ��� �� �̻� �����ϴ� ����Ʈ�� ���ٸ� ������������ �������� �ʴ´ٶ�� ���� �ǹ�
		  return false;
		  
		  
		 }
		public Bbs getBbs(int bbsID) {
			String SQL = "SELECT * FROM BBS WHERE bbsID =?";
			
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, bbsID);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					
						Bbs bbs = new Bbs();
						bbs.setBbsID(rs.getInt(1));
						bbs.setBbsTitle(rs.getString(2));
						bbs.setUserID(rs.getString(3));
						bbs.setBbsDate(rs.getString(4));
						bbs.setBbsContent(rs.getString(5));
						bbs.setBbsAvailable(rs.getInt(6));
					return bbs;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
	
		   // �Խ��� ����
	    public int update(int bbsID, String bbsTitle, String bbsContent) {
	   /* ��� ������ ���� ������ ������ �� �ΰ�? */
	   String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ? ";
	         try {
	            PreparedStatement pstmt = conn.prepareStatement(SQL);
	            pstmt.setString(1, bbsTitle);         
	            pstmt.setString(2, bbsContent);         
	            pstmt.setInt(3, bbsID);         
	         return pstmt.executeUpdate();
	         }catch(Exception e) {
	            e.printStackTrace();
	         }
	         return -1; // ������ ������ ���� ��ȯ
	}
	    
	    
	public int delete(int bbsID) {
		//delete�� ���� �������� , view�ܿ��� ������ �̷�� ������ �����ʹ� ���� ���� �� �ֵ��� ���ִ� ���
		String SQL="UPDATE BBS SET bbsAvailable = 0 WHERE bbsID=? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);   
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}  return -1; // ������ ������ ���� ��ȯ
	}
	
	
	
}
