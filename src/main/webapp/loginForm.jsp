<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%
	//페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;
	int cnt = 0;	// 전체 행 개수
	
	// 모델
	NoticeDao noticeDao = new NoticeDao();
	int lastPage = noticeDao.selectNoticeCount() / rowPerPage;
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<!-- 공지(5개)목록 페이징 -->
	<div>
		<h1>공지사항</h1>
		<table border="1" class="table">
			<tr>
				<th>공지번호</th>
				<th>공지내용</th>
				<th>날짜</th>
			</tr>
			<%
				for(Notice n : list) {
			%>
					<tr>
						<td><%=n.getNoticeNo()%></td>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
					</tr>
			<%		
				}
			%>
		</table>
		<!-- 페이징코드 -->
		<nav aria-label="pagiantion">
  			<ul class="pagination justify-content-center mt-3">		
	  			<li class="page-item">
					<a id=pnav1 class="page-link" href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1%>">처음으로</a>
				</li>
				<%
					if(currentPage > 1) {
				%>
					<li class="page-item">
						<a id=pnav2 class="page-link" href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">이전</a>		
					</li>
				<%
					}
					if(currentPage < lastPage) {
				%>
					<li class="page-item">
						<a id=pnav3 class="page-link" href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">다음</a>		
					</li>
				<%
					}
				%>
				<li class="page-item">
					<a id=pnav4 class="page-link" href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">마지막</a>
				</li>
			</ul>
		</nav>
	</div>
	
	<!-- msg parameter값이 있으면 출력 -->
	<%
		String msg = request.getParameter("msg");
		if(msg != null) {
	%>
			<div class="text-red text-center" id="msg"><%=msg%></div> <!-- 제목을 입력하시오, 내용을 입력하시오 -->
	<%
		}
	%>
	<h1 class="text-center mt-3">로그인</h1>
	<div class="container">
		<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
			<table class = "table">
				<tr>
					<td>아이디</td>
					<td><input type="text" class="form-control" name="memberId"></td>
				</tr>
				<tr>
					<td>패스워드</td>
					<td><input type="password" class="form-control" name="memberPw"></td>
				</tr>
			</table>
			<a type="btn" class="btn btn-dark" href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
			<button type="submit" class="btn btn-secondary">로그인</button>
		</form>
	</div>
	
</body>
</html>