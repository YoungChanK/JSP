package DbConnect;

import java.sql.Connection;
import java.sql.DriverManager;

public class dbConn {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
			
		Connection con;
		
		try {
			 Class.forName("com.mysql.jdbc.Driver").newInstance();
			 con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "1234");
			 System.out.println("Success");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

}
