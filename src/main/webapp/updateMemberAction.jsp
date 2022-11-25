<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import= "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
	request.setCharacterEncoding("utf-8");
	
	// 컨트롤러
	Member updateMember = new Member();
	updateMember.setMemberId(request.getParameter("memberId"));
	updateMember.setMemberName(request.getParameter("memberName"));
	System.out.println(request.getParameter("memberId")+""+request.getParameter("memberName")+"수정 action");
	
	if(request.getParameter("memberId") == null || request.getParameter("memberName") == null
		|| request.getParameter("memberId") == "" || request.getParameter("memberName") == "") {
		String msg = URLEncoder.encode("모든 정보를 입력하세요", "utf-8"); //미입력 방지, get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+msg);
		return;
	}
	
	// 분리된 모델 호출
	MemberDao memberDao = new MemberDao();
	Member loginMember = memberDao.updateMember(updateMember);
		
	if(loginMember != null){
		session.setAttribute("loginMember", updateMember);
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		System.out.println(updateMember+"수정완");
		
	} else {
		response.sendRedirect(request.getContextPath()+"/cash/updateMemberForm.jsp");
		System.out.println("수정실패");
	}
%>