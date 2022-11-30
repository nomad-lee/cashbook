package dao;

import java.awt.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Category;

public class CategoryDao {
	// cashDateList 카테고리 값
	public ArrayList<Category> selectCategoryList() throws Exception {
		ArrayList<Category> categoryList = new ArrayList<Category>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName from category ORDER BY category_kind ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();		
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryKind(rs.getString("categoryKind"));
			category.setCategoryName(rs.getString("categoryName"));			
			categoryList.add(category);
		}
		return categoryList;
	}
	
	// admin -> 카테고리관리 -> 카테고리목록
	public ArrayList<Category> selectCategoryListByAdmin(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Category> list = new ArrayList<Category>();
		
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName, updatedate, createdate FROM category LIMIT ?, ?";
		
		DBUtil dbUtil = new DBUtil();
		
		// db자원(jdbc api자원) 초기화
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery(); // stmt.executeUpdate(); // 반환
		
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo")); // 조회 정렬 순서
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setUpdatedate(rs.getString("updatedate")); //날짜 타입이나 자바단에서 문자열 타입으로 받음
			c.setCreatedate(rs.getString("createdate"));
			list.add(c);
		}		
		// db자원(jdbc api자원) 반납
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	// admin ->insertCategory	
	public int insertCategory(Category category) throws Exception {
		int row = 0;
		
		String sql = "INSERT category(category_kind, category_name, updatedate, createdate) VALUES(?, ?, CURDATE(), CURDATE())";
	
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryKind());
		stmt.setString(2, category.getCategoryName());
		row= stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return row;	
	}
	// admin ->updateCategoryForm	
	public Category selectCategoryOne(int categoryNo) throws Exception {
		Category category = null;
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category WHERE category_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		rs = stmt.executeQuery();
		if(rs.next()) {
			category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryKind(rs.getString("categoryKind"));
			category.setCategoryName(rs.getString("categoryName"));
		}
		
		dbUtil.close(rs, stmt, conn);
		return category;	
	}
	// admin ->updateCategoryAction
	public int updateCategoryName(Category category) throws Exception {
		int row = 0;
		String sql = "UPDATE category SET category_kind = ?, category_name = ? WHERE category_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryKind());
		stmt.setString(2, category.getCategoryName());
		stmt.setInt(3, category.getCategoryNo());
		
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	// admin ->deleteCategory	
	public int deleteCategory(Category category) throws Exception {
		int row = 0;
		
		String sql = "DELETE FROM category WHERE category_no = ?";
	
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, category.getCategoryNo());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		
		return row;	
	}
	//마지막 페이지를 구하기위한 메소드
	public int selectCategoryCount() throws Exception {
		int count = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql ="SELECT COUNT(*) FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			count = rs.getInt("COUNT(*)");
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return count;
	}
}