<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");

	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	paramMember.setMemberName(memberName);
	
	// 분리된 모델 호출
	MemberDao memberDao = new MemberDao();
	Member resultRow = memberDao.insertMember(paramMember);
	

	int row = stmt.executeUpdate();
	if(row ==1) {
		System.out.println("입력성공");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	} else {
		System.out.println("입력실패");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>