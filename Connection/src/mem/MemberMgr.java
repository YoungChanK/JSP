package mem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import pool.DBConnectionMgr;

public class MemberMgr {

// 커넥션풀이라는 인스턴스 변수를 생성

	private DBConnectionMgr pool;

	public MemberMgr() {

		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
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
			// pool객체를 통해서 mysql에 연결합니다.
			conn = pool.getConnection();
			SQL = "select id from tblMember where id = ?";
			// SQL문을 DB에 보내기 위한 prepareStatement을 생성
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			flag = pstmt.executeQuery().next();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// Connection 객체를 재사용하기 위해서 닫지 않고 pool에 반납
			pool.freeConnection(conn, pstmt, rs);
		}
		return flag;
	}
	
	//우편번호 검색
	public Vector<ZipcodeBean> ZipCodeRead(String area3){
		Connection conn= null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql=null;
		
		Vector<ZipcodeBean> vlist = new Vector<ZipcodeBean>();
		
		try {
			conn = pool.getConnection();
			sql= "select * from zipcode where area3 like ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,"%"+area3+"%");
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				//while안에서 bean객체를 활용하기 위해서는 zipcodebean이라는 객체를 생성해야만 bean 객체를 사용할 수 있다.
				
				ZipcodeBean bean = new ZipcodeBean();
				bean.setZipcode(rs.getString(1));
				bean.setArea1(rs.getString(2));
				bean.setArea2(rs.getString(3));
				bean.setArea3(rs.getString(4));
				//addElement 를 표현하지 않으면 bean에 구성되어 있는 값들이 리스트로 표현되지 않는다
				
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn,pstmt,rs);
		}
		return vlist;
	}
	
	//회원가입
	public boolean insertMember(MemberBean bean) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		
		try {
			conn = pool.getConnection();
			sql="insert tblMember(id,pwd,name,gender,birthday,email,zipcode,address,hobby,job) values (?,?,?,?,?,?,?,?,?,?)";
			pstmt =conn.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPwd());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getGender());
			pstmt.setString(5, bean.getBirthday());
			pstmt.setString(6, bean.getEmail());
			pstmt.setString(7, bean.getZipcode());
			pstmt.setString(8, bean.getAddress());
			String hobby[]=bean.getHobby();
			//db에 저장할 hb배열을 0으로 초기화
			char hb[] = {'0','0','0','0','0'};
			String lists[]= {"인터넷","여행","게임","영화","운동"};
				for(int i =0;i<hobby.length;i++) {
					for(int j=0;j<lists.length;j++) {
						if(hobby[i].equals(lists[j])) {
							//SQL 결과값이 저장된 hobby[]배열의 값과 lists[]배열의 값이 같은지를 비교
							//같으면 체크가 된 것이므로 처음 '0'으로 초기화 된 hb[]배열의 hb[j]값을 '1'로 저장하게 된다
							hb[j]='1';
						}
					}
				}
				pstmt.setString(9, new String(hb));
				pstmt.setString(10, bean.getJob());
				if(pstmt.executeUpdate()==1)
					flag=true;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn,pstmt);
		}
		
		
		
		return flag;
		
	}
	
	//로그인
	public boolean loginMember(String id, String pwd) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		
		
		try {
			conn =pool.getConnection();
			sql="select id from tblmember where id= ? and pwd =?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs=pstmt.executeQuery();
			flag=rs.next();
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			pool.freeConnection(conn,pstmt,rs);
		}
		
		return flag;
	}
	//정보수정
	public boolean updateMember(MemberBean bean) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		int count;
		try {
			conn = pool.getConnection();
			sql="update tblMember set pwd=?,name=?,gender=?,email=?,birthday=?,zipcode=?,address=?,hobby=?,job=? where id= ?";
			pstmt =conn.prepareStatement(sql);
			pstmt.setString(1, bean.getPwd());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getGender());
			pstmt.setString(4, bean.getEmail());
			pstmt.setString(5, bean.getBirthday());
			pstmt.setString(6, bean.getZipcode());
			pstmt.setString(7, bean.getAddress());
			String hobby[]=bean.getHobby();
			char hb[] = {'0','0','0','0','0'};
			String lists[]= {"인터넷","여행","게임","영화","운동"};
				for(int i =0;i<hobby.length;i++) {
					for(int j=0;j<lists.length;j++) {
						if(hobby[i].equals(lists[j])) {
							hb[j]='1';
						}
					}
				}
				pstmt.setString(8, new String(hb));
				pstmt.setString(9, bean.getJob());
				pstmt.setString(10,bean.getId());	
				count = pstmt.executeUpdate();
				if(count>0)
					flag=true;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn,pstmt);
		}
		
		
		
		return flag;
	
	
	
	}
	
	
	
	
	
	
	
	
	
	
	
	

}