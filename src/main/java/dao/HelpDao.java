package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.*;

public class HelpDao {
	
	//관리자 selectHelpList 오버로딩
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		String sql = "SELECT h.help_no helpNo, h.help_memo helpMemo, h.createdate helpCreatedate, c.comment_memo commentMemo, c.createdate commentCreatedate"
					+" FROM help h LEFT JOIN comment c ON h.help_no = c.help_no LIMIT ?, ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("helpNo", rs.getInt("helpNo"));
			m.put("helpMemo", rs.getString("helpMemo"));
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
			list.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	// 사용자 질문조회
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		String sql = "SELECT h.help_no helpNo, h.help_memo helpMemo, h.createdate helpCreatedate, c.comment_memo commentMemo, c.createdate commentCreatedate"
					+" FROM help h LEFT JOIN comment c ON h.help_no = c.help_no WHERE h.member_id = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("helpNo", rs.getInt("helpNo"));
			m.put("helpMemo", rs.getString("helpMemo"));
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
			list.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	// 질문추가
	public int insertHelp(Help help) throws Exception {
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT help(help_memo, member_id, updatedate, createdate) VALUES(?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setString(2, help.getMemberId());
		
		int row = stmt.executeUpdate();
		if(row ==1) {
			System.out.println("입력성공");
		} else {
			System.out.println("입력실패");
		}		
		return row;
	}
	// 질문수정 전 - 조회
	public Help selectHelpOne(int helpNo) throws Exception {
		Help help= null;
		String sql = "SELECT help_no helpNo, help_memo helpMemo, updatedate FROM help WHERE help_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);
		rs = stmt.executeQuery();
		if(rs.next()) {
			help = new Help();
			help.setHelpNo(rs.getInt("helpNo"));
			help.setHelpMemo(rs.getString("helpMemo"));
			help.setUpdatedate(rs.getString("updatedate"));
		}
		dbUtil.close(rs, stmt, conn);
		return help;	
	}
	
	// 질문수정
	public int updateHelp(Help help) throws Exception {
		int row = 0;
		String sql = "UPDATE help SET help_memo = ?, updatedate = ? WHERE help_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setString(2, help.getUpdatedate());
		stmt.setInt(3, help.getHelpNo());
		
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	// 질문삭제
	public int deleteHelp(Help help) throws Exception {
		int row = 0;
		
		String sql = "DELETE FROM help WHERE help_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, help.getHelpNo());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);;
		
		return row;	
	}
}