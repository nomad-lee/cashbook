package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.*;

public class CommentDao {
	//답변추가
	public int insertComment(Comment comment) throws Exception {
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT comment(help_no, comment_memo, member_id, updatedate, createdate) VALUES(?, ? , ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getHelpNo());
		stmt.setString(2, comment.getCommentMemo());
		stmt.setString(3, comment.getMemberId());
		
		int row = stmt.executeUpdate();
		if(row ==1) {
			System.out.println("입력성공");
		} else {
			System.out.println("입력실패");
		}		
		return row;
	}
	// 답변수정 전 - 조회
	public Comment selectCommentOne(int commentNo) throws Exception {
		Comment comment= null;
		String sql = "SELECT comment_no commentNo, help_no helpNo, comment_memo commentMemo, updatedate FROM comment WHERE comment_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		rs = stmt.executeQuery();
		if(rs.next()) {
			comment= new Comment();
			comment.setCommentNo(rs.getInt("commentNo"));
			comment.setHelpNo(rs.getInt("helpNo"));
			comment.setCommentMemo(rs.getString("commentMemo"));
			comment.setUpdatedate(rs.getString("updatedate"));
		}		
		dbUtil.close(rs, stmt, conn);
		return comment;	
	}
	// 답변수정
	public int updateComment(Comment comment) throws Exception {
		int row = 0;
		String sql = "UPDATE comment SET comment_memo = ?, updatedate = ? WHERE comment_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, comment.getCommentMemo());
		stmt.setString(2, comment.getUpdatedate());
		stmt.setInt(3, comment.getCommentNo());
		
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}

	// 답변삭제
	public int deleteComment(Comment comment) throws Exception {
		int row = 0;
		
		String sql = "DELETE FROM comment WHERE comment_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getCommentNo());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);;
		
		return row;	
	}
}
