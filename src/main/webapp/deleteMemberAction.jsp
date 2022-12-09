<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<% 
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/mainPage.jsp?msg="+msg);
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");

	request.setCharacterEncoding("utf-8");

	// 컨트롤러
	int memberNo = loginMember.getMemberNo();
	String memberId = loginMember.getMemberId();
	String memberPw = request.getParameter("memberPw");
	System.out.println(memberNo+"NO"+memberId+"ID"+memberPw+"PW");
	
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	
	// 분리된 모델 호출
	MemberDao memberDao = new MemberDao();
	int resultRow = memberDao.deleteMember(member);	
	System.out.println(resultRow+"resultRow");
	
	if(resultRow == 0) {
		String msg = URLEncoder.encode("패스워드를 다시 입력해주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp?msg="+msg);
		return;
	} else {
	response.sendRedirect(request.getContextPath()+"/mainPage.jsp");
	}
%>