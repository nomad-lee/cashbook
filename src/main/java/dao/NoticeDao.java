package dao;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.Category;
import vo.Notice;

public class NoticeDao {
	// 공지추가
	public int insertNotice(Notice notice) throws Exception {
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT notice(notice_memo, updatedate, createdate) VALUES(?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		
		int row = stmt.executeUpdate();
		if(row ==1) {
			System.out.println("입력성공");
		} else {
			System.out.println("입력실패");
		}
		
		// 완성필요
		return row;
	}
	// 공지수정 전 - 조회
	public Notice selectNoticeOne(int noticeNo) throws Exception {
		Notice notice = null;
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate FROM notice WHERE notice_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		rs = stmt.executeQuery();
		if(rs.next()) {
			notice = new Notice();
			notice.setNoticeNo(rs.getInt("noticeNo"));
			notice.setNoticeMemo(rs.getString("noticeMemo"));
			notice.setCreatedate(rs.getString("createdate"));
		}
		
		dbUtil.close(rs, stmt, conn);
		return notice;	
	}
	
	// 공지수정
	public int updateNotice(Notice notice) throws Exception {
		int row = 0;
		String sql = "UPDATE notice SET notice_memo = ? WHERE notice_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		stmt.setInt(2, notice.getNoticeNo());
		
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	// 공지삭제
	public int deleteNotice(Notice notice) throws Exception {
		int row = 0;
		
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getNoticeNo());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);;
		
		return row;	
	}
	//마지막 페이지를 구할려면 전체
	public int selectNoticeCount() {
		int count = 0;
		//
		return count;
	}
	
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate FROM notice ORDER BY notice_no DESC, createdate DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}
		return list;
	}
}
