<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	// 컨트롤러
	request.setCharacterEncoding("utf-8");
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	paramMember.setMemberName(memberName);
	
	if(request.getParameter("memberId") == null	|| request.getParameter("memberPw") == null	|| request.getParameter("memberName") == null
		|| request.getParameter("memberId") == "" || request.getParameter("memberPw") == ""	|| request.getParameter("memberName") == "") {
		String msg = URLEncoder.encode("모든 정보를 입력하세요", "utf-8"); //미입력 방지, get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}
	// 분리된 모델 호출
	MemberDao memberDao = new MemberDao();
	if(memberDao.selectMemberIdCk(memberId)) {
		System.out.println("중복 아이디");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
		return;
	}
	Member resultRow = memberDao.insertMember(paramMember);
	System.out.println(resultRow + " <-- insertMemberAction.jsp");
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>