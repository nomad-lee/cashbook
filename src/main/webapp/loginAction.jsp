<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8");

	if(request.getParameter("memberId") == null
	|| request.getParameter("memberPw") == null 
	|| request.getParameter("memberId") == "" 
	|| request.getParameter("memberPw") == "") {
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
	}
	
	//1 컨트롤러	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	System.out.println(memberId+""+memberPw);
	
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	// 분리된 모델 호출
	MemberDao memberDao = new MemberDao();
	Member resultMember = memberDao.login(paramMember);
	System.out.println(resultMember+"넘긴 값");
	
	String redirectUrl = "/loginForm.jsp";
	
	if(resultMember != null) {
		redirectUrl = "/cash/cashList.jsp";
		session.setAttribute("loginMember", resultMember); //session안에 로그인 아이디 & 이름을 저장
	}
	
	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
	/*
	//2 모델
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost/cashbook","root","java1234"); //dbUrl, dbUser, dbPw
	
	String sql = "SELECT member_id memberId, member_name memberName, member_pw memberPW FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	// getter 사용
	stmt.setString(1, member.getMemberId());
	stmt.setString(2, member.getMemberPw());
	
	ResultSet rs = stmt.executeQuery();
	String targetUrl = "/loginForm.jsp";
	if(rs.next()) {
		// 로그인 성공!
		Member loginMem = new Member();
		loginMem.setMemberId(rs.getString("memberId"));
		loginMem.setMemberPw(rs.getString("memberPw"));
		session.setAttribute("loginMem", loginMem); // 키 : "loginEmp", 값 :Object object = loginEmp;
		targetUrl = "/cash/cashList.jsp";
	}
	rs.close();
	stmt.close();
	conn.close();
	response.sendRedirect(request.getContextPath()+targetUrl);
	*/
	
	//3 뷰
%>