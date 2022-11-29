<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	// 컨트롤러	
	request.setCharacterEncoding("utf-8");

	if(request.getParameter("memberId") == null
	|| request.getParameter("memberPw") == null 
	|| request.getParameter("memberId") == "" 
	|| request.getParameter("memberPw") == "") {
	String msg = URLEncoder.encode("아이디와 패스워드를 입력해주세요", "utf-8");
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
	}
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	System.out.println(memberId+""+memberPw);
	
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	// 분리된 모델 호출
	MemberDao memberDao = new MemberDao();
	Member resultMember = memberDao.login(paramMember);
	
	String redirectUrl = "/loginForm.jsp";
	
	if(resultMember != null) {
		session.setAttribute("loginMember", resultMember); //session안에 로그인 아이디 & 이름을 저장
		redirectUrl = "/cash/cashList.jsp";
	}
	
	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>