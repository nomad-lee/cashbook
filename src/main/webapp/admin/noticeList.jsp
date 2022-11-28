<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.util.*" %>
<%
	// 컨트롤러
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	System.out.println(loginMember.getMemberLevel()+"+"+loginMember.getMemberId());
	
	//페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1)*rowPerPage;
	int cnt = 0;	// 전체 행 개수
	// int lastPage = 0;	
	
	// 모델 : notice list
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	int noticeCount = noticeDao.selectNoticeCount(); // -> lastPage	
	
	// 뷰
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeList</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a></li>
	</ul>
	<div>
		<!-- noticeList contents... -->
		<h1>공지</h1>
		<a href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp">공지입력</a>
		<table class="table">
			<tr>
				<th>공지번호</th>
				<th>공지내용</th>
				<th>공지날짜</th>
				<th>수정</th>
				<th>삭제</th>	
			</tr>
			<%
				for(Notice n : list) {
			%>
					<tr>
						<td><%=n.getNoticeNo()%></td>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
						<td><a class="btn" href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>&createdate=<%=n.getCreatedate()%>&noticeMemo=<%=n.getNoticeMemo()%>">✏️</a></td>
						<td><a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo()%>&createdate=<%=n.getCreatedate()%>">X</a></td>
					</tr>
			<%
				}
			%>
		</table>
	</div>
</body>
</html>