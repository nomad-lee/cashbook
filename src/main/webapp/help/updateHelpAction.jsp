<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
	
	request.setCharacterEncoding("utf-8");

	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String helpMemo = request.getParameter("helpMemo");
	String updatedate = request.getParameter("updatedate");
	
	Help help= new Help();
	help.setHelpNo(helpNo);
	help.setHelpMemo(helpMemo);
	help.setUpdatedate(updatedate);
	
	if(helpMemo == null || updatedate == null || helpMemo == "" || updatedate == "") {
		String msg = URLEncoder.encode("모든 정보를 입력하세요", "utf-8"); //미입력 방지, get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/help/updateHelpForm.jsp?msg="+msg);
		return;
	}
	// 분리된 모델 호출
	HelpDao helpDao = new HelpDao();
	int resultupdate = helpDao.updateHelp(help);
	System.out.println(resultupdate+"질문수정 값");
	if(resultupdate == 0) {
		System.out.println("질문 수정 실패");
		response.sendRedirect(request.getContextPath()+"/help/updateHelpForm.jsp");
	} else {
		System.out.println("질문 수정 완료");
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
	}
	return;
%>