import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Scanner;

public class UpdateTest {
    Scanner scan = new Scanner(System.in);
    Connection conn = null;
    PreparedStatement pstmt = null;
    public UpdateTest(){

    }

    public void start(){
        //사원번호와 급여를 입력받아 해당 사원의 급여를 수정 하는 프로그램
        //데이터 입력5
        System.out.print("수정할 사원번호 = " );
        int empno = scan.nextInt();

        System.out.print("수정할 급여 = ");
        int sal = scan.nextInt();

        try {
            //1. 드라이버 로딩
            Class.forName("com.mysql.cj.jdbc.Driver");

            //2. db로딩
            conn = DriverManager.getConnection("jdbc:mysql://localhost/demo", "root", "nexusgh12");

            //3. 쿼리문 작성
            String sql = "update emp set sal=? where empno=?";
            pstmt = conn.prepareStatement(sql);
            //3-1 : 필요 데이터 세팅
            pstmt.setInt(1, sal);
            pstmt.setInt(2, empno);

            //4. 실행 : 수정한 레크드의 수를 리턴해준다.
            int result = pstmt.executeUpdate();

            if (result > 0) {
                System.out.println(result + "개의 레코드가 수정됨");
            } else {
                System.out.println("수정한 레코드가 없습니다.");
            }



        } catch (Exception e) {
            e.printStackTrace();
        } finally{ //에러 여부 상관없이 실행
            //5. dbClose
            try {
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            } catch (Exception e) {
            }
        }


    }
    public static void main(String[] args) {
        new UpdateTest().start();

    }

}
