<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import= "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	Member updateMember = new Member();
	updateMember.setMemberId(request.getParameter("memberId"));
	updateMember.setMemberName(request.getParameter("memberName"));
	System.out.println(request.getParameter("memberId")+""+request.getParameter("memberName")+"수정 action");
	
	// 분리된 모델 호출
	MemberDao memberDao = new MemberDao();	
	Member loginMember = memberDao.updateMember(updateMember);
		
	if(loginMember != null){
		session.setAttribute("loginMember", loginMember);	
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp"); //?year="+year+"&month="+month+"&date="+date
		System.out.println(loginMember+"수정완");
		
	} else {
		response.sendRedirect(request.getContextPath()+"/cash/updateMemberForm.jsp");
		System.out.println("수정실패");
	}	
%>