<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	// 컨트롤러
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
	
	request.setCharacterEncoding("utf-8");
	
	String helpMemo = request.getParameter("helpMemo");
	String createdate = request.getParameter("createdate");
	
	Help help= new Help();
	help.setHelpMemo(helpMemo);
	help.setCreatedate(createdate);
	help.setMemberId(loginMember.getMemberId());

	System.out.println(helpMemo+"넘어온 질문 값");	
	if(helpMemo == null || helpMemo == "") {
		String msg = URLEncoder.encode("모든 정보를 입력하세요", "utf-8"); //미입력 방지, get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/admin/insertHelpForm.jsp?msg="+msg); //admin/insertHelpForm.jsp?msg="+msg
		return;
	}
	// 분리된 모델 호출
	HelpDao helpDao = new HelpDao();
	int resultInsert = helpDao.insertHelp(help);
	System.out.println(resultInsert+"공지추가 값");
	if(resultInsert == 0) {
		System.out.println("질문 추가 실패");
		response.sendRedirect(request.getContextPath()+"/help/insertHelpForm.jsp"); //help/insertHelpForm.jsp
	} else {
		System.out.println("질문 추가 완료");
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp"); //help/helpList.jsp
	}
	return;
%>