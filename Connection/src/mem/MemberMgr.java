package mem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import pool.DBConnectionMgr;

public class MemberMgr {

// Ŀ�ؼ�Ǯ�̶�� �ν��Ͻ� ������ ����

	private DBConnectionMgr pool;

	public MemberMgr() {

		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
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
			// pool��ü�� ���ؼ� mysql�� �����մϴ�.
			conn = pool.getConnection();
			SQL = "select id from tblMember where id = ?";
			// SQL���� DB�� ������ ���� prepareStatement�� ����
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			flag = pstmt.executeQuery().next();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// Connection ��ü�� �����ϱ� ���ؼ� ���� �ʰ� pool�� �ݳ�
			pool.freeConnection(conn, pstmt, rs);
		}
		return flag;
	}
	
	//�����ȣ �˻�
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
				//while�ȿ��� bean��ü�� Ȱ���ϱ� ���ؼ��� zipcodebean�̶�� ��ü�� �����ؾ߸� bean ��ü�� ����� �� �ִ�.
				
				ZipcodeBean bean = new ZipcodeBean();
				bean.setZipcode(rs.getString(1));
				bean.setArea1(rs.getString(2));
				bean.setArea2(rs.getString(3));
				bean.setArea3(rs.getString(4));
				//addElement �� ǥ������ ������ bean�� �����Ǿ� �ִ� ������ ����Ʈ�� ǥ������ �ʴ´�
				
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
	
	//ȸ������
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
			//db�� ������ hb�迭�� 0���� �ʱ�ȭ
			char hb[] = {'0','0','0','0','0'};
			String lists[]= {"���ͳ�","����","����","��ȭ","�"};
				for(int i =0;i<hobby.length;i++) {
					for(int j=0;j<lists.length;j++) {
						if(hobby[i].equals(lists[j])) {
							//SQL ������� ����� hobby[]�迭�� ���� lists[]�迭�� ���� �������� ��
							//������ üũ�� �� ���̹Ƿ� ó�� '0'���� �ʱ�ȭ �� hb[]�迭�� hb[j]���� '1'�� �����ϰ� �ȴ�
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
	
	//�α���
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
	//��������
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
			String lists[]= {"���ͳ�","����","����","��ȭ","�"};
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