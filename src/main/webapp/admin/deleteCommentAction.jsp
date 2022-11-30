<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<% 
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	request.setCharacterEncoding("utf-8");

	// 컨트롤러
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));

	Comment comment = new Comment();
	comment.setCommentNo(commentNo);
	
	// 분리된 모델 호출
	CommentDao commentDao = new CommentDao();
	int resultRow = commentDao.deleteComment(comment);	

	response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
%>