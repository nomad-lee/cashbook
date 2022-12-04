<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	// 컨트롤러	
	request.setCharacterEncoding("utf-8");

	if(request.getParameter("memberId_in") == null
	|| request.getParameter("memberPw_in") == null 
	|| request.getParameter("memberId_in") == "" 
	|| request.getParameter("memberPw_in") == "") {
	String msg = URLEncoder.encode("아이디와 패스워드를 입력해주세요", "utf-8");
	response.sendRedirect(request.getContextPath()+"/mainPage.jsp?msg="+msg);
	return;
	}
	
	String memberId = request.getParameter("memberId_in");
	String memberPw = request.getParameter("memberPw_in");
	System.out.println(memberId+""+memberPw);
	
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	// 분리된 모델 호출
	MemberDao memberDao = new MemberDao();
	Member resultMember = memberDao.login(paramMember);
	
	String redirectUrl = "/mainPage.jsp";
	
	if(resultMember != null) {
		session.setAttribute("loginMember", resultMember); //session안에 로그인 아이디 & 이름을 저장
		redirectUrl = "/cash/cashList.jsp";
	}
	
	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>