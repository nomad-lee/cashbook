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
	
	// 모델
	HelpDao helpDao = new HelpDao();	
	int cnt = helpDao.selectHelpCount(); // 전체 행 개수
	int lastPage = cnt / rowPerPage;
	if(cnt % rowPerPage != 0) {
		lastPage++;
	}
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>helpListAll</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<!-- header -->	
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">고객센터 관리</a></li>
	</ul>
	
	<!-- 고객센터 문의 목록 -->
	<table class="table">
		<tr>
			<th>문의내용</th>
			<th>회원ID</th>
			<th>문의날짜</th>
			<th>답변내용</th>
			<th>답변날짜</th>
			<th>답변추가 / 수정 / 삭제</th>
		</tr>
		<%
			for(HashMap<String, Object> m : list) {
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
								<a href="<%=request.getContextPath()%>/admin/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>&helpMemo=<%=m.get("helpMemo")%>&memberId=<%=m.get("memberId")%>">답변입력</a>
						<%
							} else {
						%>
								<a href="<%=request.getContextPath()%>/admin/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>">수정</a>
								<a href="<%=request.getContextPath()%>/admin/deleteCommentAction.jsp?commentNo=<%=m.get("commentNo")%>">삭제</a>
						<%
							}
						%>
					</td>
				</tr>
		<%
			}
		%>
	</table>
	<!-- 페이징코드 -->
	<nav aria-label="pagiantion">
 			<ul class="pagination justify-content-center mt-3">		 
  			<li class="page-item">
				<a id=pnav1 class="page-link" href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1%>">처음으로</a>
			</li>
			<%
				if(currentPage > 1) {
			%>
				<li class="page-item">
					<a id=pnav2 class="page-link" href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1%>">이전</a>		
				</li>
			<%
				}
				if(currentPage < lastPage) {
			%>
				<li class="page-item">
					<a id=pnav3 class="page-link" href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1%>">다음</a>		
				</li>
			<%
				}
			%>
			<li class="page-item">
				<a id=pnav4 class="page-link" href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>">마지막</a>
			</li>
		</ul>
	</nav>
	<!-- footer -->
</body>
</html>