<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/mainPage.jsp?msg="+msg);
		return;
	}
	
	request.setCharacterEncoding("utf-8");
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = request.getParameter("memberId");
	String memberName = request.getParameter("memberName");
	String memberMemo = request.getParameter("memberMemo");
	//memberMemo=memberMemo.replace("\r\n","<br>");
	String memberPw = request.getParameter("memberPw");
	String memberPw2 = request.getParameter("memberPw2");
	
	// 컨트롤러
	loginMember.setMemberId(memberId);
	loginMember.setMemberName(memberName);
	loginMember.setMemberMemo(memberMemo);
	loginMember.setMemberPw(memberPw);
	System.out.println(request.getParameter("memberId")+""+request.getParameter("memberName")+"수정 action");

	// 분리된 모델 호출
	MemberDao memberDao = new MemberDao();
	Member updateMember = null;
	
	if(memberId == null || memberName == null
		|| memberId == "" || memberName == "") {
		String msg = URLEncoder.encode("모든 정보를 입력하세요", "utf-8"); //미입력 방지, get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/user.jsp?msg="+msg+"&memberId="+memberId);
		return;
	} else if((memberPw == null || "".equals(memberPw)) && (memberPw2 == null || "".equals(memberPw2))) {
		// 비밀번호 변경 시
		updateMember = memberDao.updateMember(loginMember);		
		System.out.println("비번 미변경");
	} else if((memberPw != null && memberPw2 == null) || (memberPw == null && memberPw2 != null) || !memberPw.equals(memberPw2)){
		String msg = URLEncoder.encode("비밀번호를 확인해주세요", "utf-8"); //미입력 방지, get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/user.jsp?msg="+msg);
		return;
	} else {
		// 비밀번호 미 변경
		updateMember = memberDao.updateMemberPw(loginMember);
		System.out.println("비번 변경");
	}	
		
	if(updateMember != null){
		session.setAttribute("loginMember", loginMember);
		response.sendRedirect(request.getContextPath()+"/user.jsp");
		System.out.println(loginMember+"수정완");
		
	} else {
		response.sendRedirect(request.getContextPath()+"/user.jsp");
		System.out.println("수정실패");
	}
	System.out.println(updateMember.getMemberLevel()+"Action레벨");
%>