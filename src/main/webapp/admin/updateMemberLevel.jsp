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

	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int memberLevel = Integer.parseInt(request.getParameter("memberLevel"));
	if (memberLevel == 0) {
		memberLevel = 1;
	} else {
		memberLevel =0;
	}
	
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberLevel(memberLevel);
	
	// 분리된 모델 호출
	MemberDao memberDao = new MemberDao();
	int resultrow = memberDao.updateMemberLevel(member);
	System.out.println(resultrow+"공지수정 값");
	if(resultrow == 0) {
		System.out.println("레벨 수정 실패");
	} else {
		System.out.println("레벨 수정 완료");
	}
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
	return;
%>