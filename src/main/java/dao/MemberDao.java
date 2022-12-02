package dao;
import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.Cash;
import vo.Member;
import vo.Notice;

public class MemberDao {
	
	// 관리자 : 멤버레벨수정
	public int updateMemberLevel(Member member) throws Exception  {
		int row = 0;
		String sql = "UPDATE member SET member_level = ? WHERE member_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, member.getMemberLevel());
		stmt.setInt(2, member.getMemberNo());
		
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	// 관리자 : 마지막 페이지를 구하기위한 메소드
	public int selectMemberCount() throws Exception {
		int count = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql ="SELECT COUNT(*) FROM member";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			count = rs.getInt("COUNT(*)");
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return count;
	}
	
	// 관리자 멤버 리스트
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) throws Exception {
		/*
		 * ORDER BY createdate DESC
		 */
		ArrayList<Member> list = new ArrayList<Member>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate FROM member ORDER BY member_no DESC, createdate DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			m.setMemberLevel(rs.getInt("memberLevel"));
			m.setMemberName(rs.getString("memberName"));
			m.setUpdatedate(rs.getString("updatedate"));
			m.setCreatedate(rs.getString("createdate"));
			list.add(m);
		}
		return list;
	}
	// 관리자 멤버 강퇴
	public int deleteMemberByAdmin(Member member) throws Exception {
		int row = 0;
		
		String sql = "DELETE FROM member WHERE member_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, member.getMemberNo());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);;
		
		return row;
	}
	//회원가입 1) id 중복확인 2) 회원가입
	
	//반환값 t:이미존재, f:사용가능
	public boolean selectMemberIdCk(String memberId) throws Exception {
		boolean  result = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			result = true;
		}
		dbUtil.close(rs, stmt, conn);		
		return result;
	}
	// 회원가입
	public Member insertMember(Member paramMember) throws Exception {
		Member resultRow = new Member();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?, PASSWORD(?), ?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		stmt.setString(3, paramMember.getMemberName());
		
		int row = stmt.executeUpdate();
		if(row ==1) {
			System.out.println("입력성공");
		} else {
			System.out.println("입력실패");
		}
				
		stmt.close();
		conn.close();
		return resultRow;
	}
	/*
	public int insertMember(Member member) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?, PASSWORD(?), ? , CURDATE(), CURDATE()";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,  member.getMemberId());
		stmt.setString(2,  member.getMemberPw());
		stmt.setString(3,  member.getMemberName());
		
		row = stmt.executeUpdate();		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	*/	
	// 로그인
	public Member login(Member paramMember) throws Exception {
		Member resultMember = null;
		
		// DB를 연결하는 코드가 Dao 메서드에 거의 공통적으로 중복
		// 중복되는 코드를 하나의 메서드로 
		// 입력값과 반환값을 결정해야
		// 입력값X, 반환값은 Connection 타입의 결과값이 남아야 한다.
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberLevel(rs.getInt("memberLevel"));
			resultMember.setMemberName(rs.getString("memberName"));
		}
		System.out.println(paramMember.getMemberId()+""+paramMember.getMemberPw()+"login값 넘어옴");
		rs.close();
		stmt.close();
		conn.close();		
		return resultMember;
	}	
	// 회원정보 수정
	public Member updateMember(Member paramMember) throws Exception {
		Member loginMember = new Member();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE member SET member_name = ?, updatedate = CURDATE() WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberName());
		stmt.setString(2, paramMember.getMemberId());
		
		int row = stmt.executeUpdate();
		if(row ==1) {
			System.out.println("수정성공");
			
			stmt.close();
			conn.close();
			return loginMember;
		} else {
			System.out.println("수정실패");	
			
			stmt.close();
			conn.close();
			return null;
		}
	}	
	// 회원탈퇴
	public int deleteMember(Member member) throws Exception{
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("삭제성공");
		} else {
			System.out.println("삭제실패");
		}
		stmt.close();
		conn.close();
		return row;
	}
}