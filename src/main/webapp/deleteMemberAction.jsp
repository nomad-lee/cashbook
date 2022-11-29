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
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	
	// 분리된 모델 호출
	MemberDao memberDao = new MemberDao();
	Member resultRow = memberDao.deleteMember(member);

	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>