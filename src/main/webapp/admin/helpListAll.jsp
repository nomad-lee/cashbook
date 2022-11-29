<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.util.*" %>
<%
	Member loginMember = (Member)session.getAttribute("login");
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
	
	HelpDao helpDao = new HelpDao();	
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
	//int helpCount = helpDao.selecthelpCount(); // --> lastPage
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>helpListAll</title>
</head>
<body>
	<!-- header -->	
	
	<!-- 고객센터 문의 목록 -->
	<table>
		<tr>
			<th>문의내용</th>
			<th>회원ID</th>
			<th>문의날짜</th>
			<th>답변내용</th>
			<th>답변날짜</th>
			<th>답변추가 / 수정 / 삭제</th>
		</tr>
		<%
			for(HashMap<String, Object> m : list)
		%>
				<tr>
					<td><%=m.get("helpMemo")%></td>
					<td><%=m.get("memberId")%></td>
					<td><%=m.get("helpCreatedate")%></td>
					<td><%=m.get("commentMemo")%></td>
					<td><%=m.get("commentCreatedate")%></td>
					<td>
						<%
							if(m.get("commentMemo") == null) {
						%>
								<a href="<%=request.getContextPath()%>/admin/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>">답변입력</a>
						<%
							} else {
						%>
								<a href="<%=request.getContextPath()%>/admin/updateCommentForm.jsp?helpNo=<%=m.get("helpNo")%>"></a>
								<a href="<%=request.getContextPath()%>/admin/deleteCommentForm.jsp?helpNo=<%=m.get("helpNo")%>"></a>
						<%
						
						%>
					</td>
				</tr>
		<%
		
		%>
	</table>
	
	<!-- footer -->
</body>
</html>