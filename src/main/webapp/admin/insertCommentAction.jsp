<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	// 컨트롤러
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
	
	request.setCharacterEncoding("utf-8");

	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String helpMemo = request.getParameter("helpMemo");
	String memberId = request.getParameter("memberId");
	String commentMemo = request.getParameter("commentMemo");
	System.out.println(helpNo+"Action helpNo");
	
	if(commentMemo == null || commentMemo == "") {
		String msg = URLEncoder.encode("모든 정보를 입력하세요", "utf-8"); //미입력 방지, get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/admin/insertCommentForm.jsp?msg="+msg+"&helpNo="+helpNo+"&helpMemo="+URLEncoder.encode(helpMemo));
		return;
	}
	
	Comment comment= new Comment();
	comment.setHelpNo(helpNo);
	comment.setCommentMemo(commentMemo);
	comment.setMemberId(memberId);
	System.out.println(commentMemo+"Action commentMemo");

	// 분리된 모델 호출
	CommentDao commentDao = new CommentDao();
	int resultInsert = commentDao.insertComment(comment);
	System.out.println(resultInsert+"공지추가 값");
	if(resultInsert == 0) {
		System.out.println("공지 추가 실패");
		response.sendRedirect(request.getContextPath()+"/admin/insertCommentForm.jsp?helpNo="+helpNo);
	} else {
		System.out.println("공지 추가 완료");
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
	}
	return;
%>