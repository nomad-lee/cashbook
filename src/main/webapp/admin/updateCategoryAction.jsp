<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
	
	request.setCharacterEncoding("utf-8");

	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	String updatedate = request.getParameter("updatedate");
	
	Category category = new Category();
	category.setCategoryNo(categoryNo);
	category.setCategoryKind(categoryKind);
	category.setCategoryName(categoryName);
	category.setUpdatedate(updatedate);
	
	if(categoryKind == null || categoryName == null || updatedate == null
			|| categoryKind == ""|| categoryName == ""|| updatedate == "") {
		String msg = URLEncoder.encode("모든 정보를 입력하세요", "utf-8"); //미입력 방지, get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/admin/updateCategoryForm.jsp?msg="+msg);
		return;
	}
	// 분리된 모델 호출
	CategoryDao categoryDao = new CategoryDao();
	int resultrow = categoryDao.updateCategoryName(category);
	System.out.println(resultrow+"공지수정 값");
	if(resultrow == 0) {
		System.out.println("카테고리 수정 실패");
		response.sendRedirect(request.getContextPath()+"/admin/updateCategoryForm.jsp");
	} else {
		System.out.println("카테고리 수정 완료");
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
	}
	return;
%>