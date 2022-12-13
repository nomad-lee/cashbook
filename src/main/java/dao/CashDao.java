package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Cash;
import vo.Member;

public class CashDao {	
	// cashDateList.jsp 조회
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.category_no categoryNo, c.cash_memo cashMemo, ct.category_kind categoryKind, ct.category_name categoryName"
				+ "	FROM cash c INNER JOIN category ct"
				+ "	ON c.category_no = ct.category_no"
				+ "	WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) = ?"
				+ "	ORDER BY c.cash_date ASC, ct.category_kind ASC"; 
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		stmt.setInt(4, date);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("cashMemo", rs.getString("cashMemo"));
			m.put("categoryNo", rs.getLong("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
		}		
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}	
	// updateCashForm.jsp 조회
	public HashMap<String, Object> selectCashListByCashNo(int cashNo) throws Exception{
		HashMap<String, Object> m = new HashMap<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT cash_no cashNo, cash_date cashDate, cash_price cashPrice, category_no categoryNo, cash_memo cashMemo FROM cash WHERE cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			m.put("cashNo", cashNo);
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("cashMemo", rs.getString("cashMemo"));
		}
		return m;
	}	
	// cashList.jsp 조회
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName"
				+ "	FROM cash c INNER JOIN category ct"
				+ "	ON c.category_no = ct.category_no"
				+ "	WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?"
				+ "	ORDER BY c.cash_date ASC, ct.category_kind ASC"; 
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
		}		
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}	
	// insertCashAction.jsp
	public Cash insertCash(Cash paramCash) throws Exception {
		Cash resultRow = new Cash();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO cash(member_id, category_no, cash_price, cash_date, cash_memo, updatedate, createdate) VALUES(?, ?, ?, ?, ?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramCash.getMemberId());
		stmt.setInt(2, paramCash.getCategoryNo());
		stmt.setLong(3, paramCash.getCashPrice());
		stmt.setString(4, paramCash.getCashDate());
		stmt.setString(5, paramCash.getCashMemo());
		
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
	// updateCashAction.jsp
	public Cash updateCash(Cash paramMember) throws Exception {
		Cash resultCash = new Cash();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE cash SET category_no = ?, cash_price = ?, cash_date = ?, cash_memo = ? WHERE cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramMember.getCategoryNo());
		stmt.setLong(2, paramMember.getCashPrice());
		stmt.setString(3, paramMember.getCashDate());
		stmt.setString(4, paramMember.getCashMemo());
		stmt.setInt(5, paramMember.getCashNo());
		
		int row = stmt.executeUpdate();
		if(row ==1) {
			System.out.println("수정성공");
			
			stmt.close();
			conn.close();
			return resultCash;
		} else {
			System.out.println("수정실패");	
			
			stmt.close();
			conn.close();
			return null;
		}
	}
	// deleteCashAction.jsp
	public Cash deleteCash(Cash paramCash) throws Exception {
		Cash resultRow = new Cash();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM cash WHERE cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramCash.getCashNo());
		
		int row = stmt.executeUpdate();
		if(row ==1) {
			System.out.println("삭제성공");
		} else {
			System.out.println("삭제실패");
		}
		stmt.close();
		conn.close();
		return resultRow;
	}
	
	// 사용자별 년도별 수입/지출
	public ArrayList<HashMap<String, Object>> cashListByYear (String memberId) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT YEAR(t2.cashDate) year" //년도
				+ "			, COUNT(t2.importCash) countIncome" //수입카운트
				+ "			, IFNULL(SUM(t2.importCash), 0) sumIncome" //수입합계
				+ "			, IFNULL(ROUND(AVG(t2.importCash)), 0) avgIncome" //수입평균
				+ "			, COUNT(t2.exportCash) countExport" //지출카운트
				+ "			, IFNULL(SUM(t2.exportCash), 0) sumExport" //지출합계
				+ "			, IFNULL(ROUND(AVG(t2.exportCash)), 0) avgExport" //지출평균
				+ "		 FROM (SELECT memberId, cashNo, cashDate"
				+ "					, IF(categoryKind = '수입', cashPrice, null) importCash"
				+ "					, IF(categoryKind = '지출', cashPrice, null) exportCash"
				+ "		 FROM (SELECT cs.cash_no cashNo"
				+ "					, cs.cash_date cashDate"
				+ "					, cs.cash_price cashPrice"
				+ "					, cg.category_kind categoryKind"
				+ "					, cs.member_id memberId"
				+ "		 FROM cash cs INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
				+ "		 WHERE t2.memberId = ?"
				+ "		 GROUP BY YEAR(t2.cashDate)"
				+ "		 ORDER BY YEAR(t2.cashDate) ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("countIncome", rs.getInt("countIncome"));
			m.put("sumIncome", rs.getInt("sumIncome"));
			m.put("avgIncome", rs.getInt("avgIncome"));
			m.put("countExport", rs.getInt("countExport"));
			m.put("sumExport", rs.getInt("sumExport"));
			m.put("avgExport", rs.getInt("avgExport"));
			m.put("year", rs.getInt("year"));
			list.add(m);
		}
		stmt.close();
		rs.close();
		return list;
	}
	
	// 사용자별 년도를(페이징) 매개값으로 입력받아 월별(수입/지출) sum,avg
	public ArrayList<HashMap<String, Object>> cashListByMonth (String memberId, int year) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT MONTH(t2.cashDate) month"
				+ ", COUNT(t2.importCash) countIncome" //수입카운트
				+ ", IFNULL(SUM(t2.importCash), 0) sumIncome" //수입합계
				+ ", IFNULL(ROUND(AVG(t2.importCash)), 0) avgIncome" //수입평균
				+ ", COUNT(t2.exportCash) countExport" //지출카운트
				+ ", IFNULL(SUM(t2.exportCash), 0) sumExport" //지출합계
				+ ", IFNULL(ROUND(AVG(t2.exportCash)), 0) avgExport" //지출평균
				+ " FROM (SELECT memberId, cashNo, cashDate"
				+ ", IF(categoryKind = '수입', cashPrice, null) importCash"
				+ ", IF(categoryKind = '지출', cashPrice, null) exportCash"
				+ " FROM (SELECT cs.cash_no cashNo, cs.cash_date cashDate"
				+ ", cs.cash_price cashPrice"
				+ ", cg.category_kind categoryKind"
				+ ", cs.member_id memberId"
				+ " FROM cash cs"
				+ " INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
				+ " WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ?"
				+ " GROUP BY MONTH(t2.cashDate)	ORDER BY MONTH(t2.cashDate) ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("countIncome", rs.getInt("countIncome"));
			m.put("sumIncome", rs.getInt("sumIncome"));
			m.put("avgIncome", rs.getInt("avgIncome"));
			m.put("countExport", rs.getInt("countExport"));
			m.put("sumExport", rs.getInt("sumExport"));
			m.put("avgExport", rs.getInt("avgExport"));
			m.put("month", rs.getInt("month"));
			list.add(m);
		}
		stmt.close();
		rs.close();
		return list;
	}
	// 최소, 최대년도
	public HashMap<String, Object> selectMaxMinYear() throws Exception {
		HashMap<String, Object> map = null;		

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT"
					+ "	(SELECT MIN(YEAR(cash_date)) FROM cash) minYear"
					+ ", (SELECT MAX(YEAR(cash_date))FROM cash) maxYear"
					+ " FROM DUAL";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			map = new HashMap<String, Object>();
			map.put("minYear", rs.getInt("minYear"));
			map.put("maxYear", rs.getInt("maxYear"));
			
		}
		stmt.close();
		rs.close();
		return map;
	}
}