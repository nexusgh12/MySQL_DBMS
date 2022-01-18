import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class InsertTest {
    Connection con = null;
    PreparedStatement psmt = null;

    public InsertTest() {

    }

    public void empInsert(){
        //사원번호, 이름, 급여, 입사일을 레코드 추가하기
        //1. 드라이브 로딩
        try {
            //1. 드라이브 로딩
            Class.forName("com.mysql.cj.jdbc.Driver");

            //2. db연결
            con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/demo", "root", "nexusgh12");
            // 3. PreparedStatement 객체 생성 : 쿼리문을 이용하여
            // 사원 번호 : 5555, 이름 : kim,  급여 : 4500, 입사일 현재 날짜와 시간으로 설정
            // 변하는 값은 물음표로 작성                                         1  2  3
            String sql = "insert into emp(empno, ename, sal, hiredate) values(?, ?, ?, now())";
            psmt = con.prepareStatement(sql);

            // ?에 값을 세팅한다.
            psmt.setInt(1, 5555);
            psmt.setString(2, "kim");
            psmt.setDouble(3, 3500);

            // 4. 실행
            // 쿼리문을 실행하여 추가 된 레코드의 수를 반환한다.
            int cnt = psmt.executeUpdate();
            if(cnt>0){
                System.out.println("레코드가 추가되었습니다.");

            }else{
                System.out.println("레코드 추가 실패했습니다.");
            }

        }
        catch (Exception e) {
            e.printStackTrace();
        } finally{
            try {
                if(psmt != null) psmt.close();
                if(con!=null) con.close();
            } catch (Exception e2) {e2.printStackTrace();}

        }

    }

    public static void main(String[] args){
        new InsertTest().empInsert();
    }
}