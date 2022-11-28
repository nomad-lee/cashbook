<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	// 컨트롤러
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
	
	request.setCharacterEncoding("utf-8");
	
	String noticeMemo = request.getParameter("noticeMemo");
	
	Notice notice = new Notice();
	notice.setNoticeMemo(noticeMemo);
	
	if(noticeMemo == null || noticeMemo == "") {
		String msg = URLEncoder.encode("모든 정보를 입력하세요", "utf-8"); //미입력 방지, get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/admin/insertNoticeForm.jsp?msg="+msg);
		return;
	}
	// 분리된 모델 호출
	NoticeDao noticeDao = new NoticeDao();
	int resultInsert = noticeDao.insertNotice(notice);
	System.out.println(resultInsert+"공지추가 값");
	if(resultInsert == 0) {
		System.out.println("공지 추가 실패");
		response.sendRedirect(request.getContextPath()+"/admin/insertNoticeForm.jsp");
	} else {
		System.out.println("공지 추가 완료");
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
	}
	return;
%>