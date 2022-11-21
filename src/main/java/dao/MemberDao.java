package dao;

import java.sql.*;
import util.DBUtil;
import vo.Member;

public class MemberDao {
	public Member login(Member paramMember) throws Exception {
		Member resultMember = null;
		
		/*
		Class.forName("org.mariadb.jdbc.Driver");
		Conncection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook","root","java1234");
		// DB를 연결하는 코드가 Dao 메서드에 거의 공통적으로 중복
		//중복되는 코드를 하나의 메서드로 만들자
		// 입력값과 반환값을 결정해야
		// 입력값X, 반환값은 Connection 타입의 결과값이 남아야 한다.
		*/
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id memberId, member_name memberName FROM member WHERE member_id=? AND member_pw=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
		}
				
		rs.close();
		stmt.close();
		conn.close();
		
		return resultMember;
	}
	
	// 회원가입
	public int insertMember(Member parmMember) throws Exception {
		int resultRow = 0;
		/*
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");
		*/
		return resultRow;
	}
}