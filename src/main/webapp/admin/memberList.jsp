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
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1)*rowPerPage;
	int cnt = 0;	// 전체 행 개수
	// int lastPage = 0;		
	
	// 모델
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	int memberCount = memberDao.selectMemberCount(); // --> lastPage
	
	// 뷰
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberList</title>
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
		<!-- memberList contents... -->
		<h1>멤버목록</h1>
		<table class="table">
			<tr>
				<th>멤버번호</th>
				<th>아이디</th>
				<th>레벨</th>
				<th>이름</th>
				<th>마지막수정일</th>
				<th>생성일자</th>
				<th>레벨수정</th>
				<th>강제탈퇴</th>
			</tr>
			<%
				for(Member m : list) {
			%>
					<tr>
						<td><%=m.getMemberNo()%></td>
						<td><%=m.getMemberId()%></td>
						<td><%=m.getMemberLevel()%></td>
						<td><%=m.getMemberName()%></td>
						<td><%=m.getUpdatedate()%></td>
						<td><%=m.getCreatedate()%></td>
						<td><a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/updateMemberLevel.jsp?memberNo=<%=m.getMemberNo()%>&memberLevel=<%=m.getMemberLevel()%>">0 OR 1</a></td>
						<td><a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/kickMemberAction.jsp?memberNo=<%=m.getMemberNo()%>">X</a></td>
					</tr>
			<%					
				}
			%>
		</table>
	</div>
</body>
</html>