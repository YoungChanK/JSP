package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	// DAO영역중 DB와 연결해 주는 영역

	private Connection conn;
	private ResultSet rs;

	// DB연결구문
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

	// 게시판에 글을 입력하기 위한 3가지의 메소드
	// getNext(), getDate(), int write
	// 순번 최신글1 > 그다음글2 >그 다음글3
	public int getNext() {

		// 게시물에 들어가 있는 내용을 순번으로 선택하여 가져오는 구문
		// 게시물의 내용을 가져 오는 메소드
		// ASC(오름차순)
		// DESC(내림차순)
		// ORDER By : 차순
		String SQL = "SELECT bbsID FROM BBS ORDER By bbsID DESC";
		try {
			// 쿼리문의 결과를 가져오기 위한 첫 수단
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// 쿼리문의 결과값을 rs에 저장
			rs = pstmt.executeQuery();
			// next() : 1번부터 다음순번으로 하나씩 조회해 나가는 메소드
			if (rs.next()) {
				// 그 다음 게시글의 순번이 떨어지게 만들어 주는 값을 반환
				return rs.getInt(1) + 1;
			}
			// 첫번째 게시물인 경우
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	// 게시물 날짜를 표현하는 메소드
	public String getDate() {

		// 게시물에 들어가 있는 내용을 순번으로 선택하여 가져오는 구문
		String SQL = "SELECT NOW()";
		try {
			// 쿼리문의 결과를 가져오기 위한 수단
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// 쿼리문의 결과를 받는다.
			rs = pstmt.executeQuery();
			// next() : 1번부터 다음순번으로 하나씩 조회해 나가는 메소드
			if (rs.next()) {
				// 첫번째 게시물에 대한 날짜를 반환 > next > next...
				return rs.getString(1); // 날짜 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
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
//LIST 구현
//목록을 가져오기 위한 메소드 구현
	
	public ArrayList<Bbs> getList(int pageNumber){
		//bbsAvailable = 1 : 게시판에 보이는 목록들
		//ORDER BY bbsID DESC LIMIT10" : 10개 까지의 목록만 보여준다.
		//
		//현재 유효번호가 존재하고 새롭게 작성될 게시글 번호보다 작은 게시글 번호를 내림 차순하여 최대 10까지 조회한다
		//String SQL ="SELECT * FROM BBS WHERE bbsID< ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT10";
		  String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		//bbs에서 나오는 인스턴스를 보관할 수 있는 리스트구조를 제작
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//글 출력 갯수
			//getnext = 다음글에 작성될 게시글 번호
			//만약 현재 글이 3개라면 getNext()=4,1페이지 때문에 결과값은 4가된다.
			//4보다 작은 5개의 게이글이 출력되게 표현
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
	
	//만약에 리스트의 갯수가 10개의 단위로 끊겨 표현한다고 했을때 다음페이지가 나타나면 않되니까 그래서 이메소드를 활용하는것이다.
	public boolean nextPage(int pageNumber){
		  
		  String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		  
		  //bbs에서 나오는 인스터스를 보관할 수 있는 리스트구조를 제작
		 
		
		  try {
		   PreparedStatement pstmt = conn.prepareStatement(SQL);
		   pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
		   rs=pstmt.executeQuery();
		   if(rs.next()) {
		    //10개보다 하나 이상 리스트가 존재한다면 다음페이지가 존재한다라는것을
		    //의미
		    return true;
		   }
		  }catch(Exception e) {
		   e.printStackTrace();
		  }
		  //10개씩 끊어서 더 이상 존재하는 리스트가 없다면 다음페이지는 존재하지 않는다라는 것을 의미
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
	
		   // 게시판 수정
	    public int update(int bbsID, String bbsTitle, String bbsContent) {
	   /* 어느 순번에 관한 내용을 변경할 것 인가? */
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
	         return -1; // 오류적 사항의 값을 반환
	}
	    
	    
	public int delete(int bbsID) {
		//delete를 쓰면 완전삭제 , view단에서 삭제가 이루어 지더라도 데이터는 남아 있을 수 있도록 해주는 기능
		String SQL="UPDATE BBS SET bbsAvailable = 0 WHERE bbsID=? ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);   
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}  return -1; // 오류적 사항의 값을 반환
	}
	
	
	
}
