<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
	
	request.setCharacterEncoding("utf-8");

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeMemo = request.getParameter("noticeMemo");
	
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeMemo(noticeMemo);
	
	if(noticeMemo == null || noticeMemo == "") {
		String msg = URLEncoder.encode("모든 정보를 입력하세요", "utf-8"); //미입력 방지, get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/admin/updateNoticeForm.jsp?msg="+msg);
		return;
	}
	// 분리된 모델 호출
	NoticeDao noticeDao = new NoticeDao();
	int resultInsert = noticeDao.updateNotice(notice);
	System.out.println(resultInsert+"공지수정 값");
	if(resultInsert == 0) {
		System.out.println("공지 수정 실패");
		response.sendRedirect(request.getContextPath()+"/admin/updateNoticeForm.jsp");
	} else {
		System.out.println("공지 수정 완료");
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
	}
	return;
%>