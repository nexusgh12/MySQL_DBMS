package MySQL_DBMS;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SelectTest {

    public SelectTest() {
        // TODO Auto-generated constructor stub
    }

    public void start() {

        //데이터베이스 연결
        //1. jdbc 드라이브를 jvm에 객체를 생성하여 등록한다.
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        }catch(ClassNotFoundException cnfe) {
            System.out.println("드라이브 로딩 실패!!");
        }


        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            //2. DB연결
            // DriverManager 클래스의 getConnection() 메서드를 실행하면
            // 데이터베이스를 연결하여  Connection 객체 리턴해준다.

            String url= "jdbc:mysql://127.0.0.1/demo"; //서버 ip/db명
            conn = DriverManager.getConnection(url, "root", "nexusgh12");//서버 주소, 계정, 비번
            //쿼리문 - 레코드 선택
            String sql = "select empno, ename, hiredate, sal from emp order by ename asc";

            //3. Prepared statement 객체를 생성
            pstmt = conn.prepareStatement(sql);

            // 4. pstmt를 실행한다
            rs = pstmt.executeQuery();

            while(rs.next()) {
                int empno = rs.getInt(1);// rs.getInt("empno");보통 숫자로 씀
                String ename = rs.getString(2); //rs.getString("ename");
                String hiredate = rs.getString(3);
                double sal= rs.getDouble(4);
                System.out.printf("%6d %10s %22s %10.2f\n", empno, ename, hiredate, sal);

            }


        } catch(SQLException se) {
            System.out.println("DB 연결 에러 발생");
        } finally {
            try {
                // 연결 종료
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();

            } catch(Exception e) {}


        }



    }
    public static void main(String[] args) {
        // TODO Auto-generated method stub

        new SelectTest().start();
    }

}
