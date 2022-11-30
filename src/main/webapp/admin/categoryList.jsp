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
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
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
	CategoryDao categoryDao = new CategoryDao();
	int cnt = categoryDao.selectCategoryCount(); // 전체 행 개수
	int lastPage = cnt / rowPerPage;
	if(cnt % rowPerPage != 0) {
		lastPage++;
	}
	ArrayList<Category> list = categoryDao.selectCategoryListByAdmin(beginRow, rowPerPage);
	// 뷰
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>categoryList</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">고객센터 관리</a></li>
	</ul>
	<div>
		<!-- categoryList contents... -->
		<h1>카테고리 목록</h1>
		<a href="<%=request.getContextPath()%>/admin/insertCategoryForm.jsp">카테고리 추가</a>
		<table class="table">
			<tr>
				<th>번호</th>
				<th>수입/지출</th>
				<th>이름</th>
				<th>마지막 수정 날짜</th>
				<th>생성날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<!-- 모델데이터 categoryList 출력 -->
			<%
				for(Category c : list) {
			%>
					<tr>
						<td><%=c.getCategoryNo()%></td>
						<td><%=c.getCategoryKind()%></td>
						<td><%=c.getCategoryName()%></td>
						<td><%=c.getUpdatedate()%></td>
						<td><%=c.getCreatedate()%></td>
						<td><a class="btn" href="<%=request.getContextPath()%>/admin/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>&updatedate=<%=c.getUpdatedate()%>">✏️</a></td>
						<td><a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">X</a></td>
					</tr>
			<%					
				}
			%>
		</table>
		<!-- 페이징코드 -->
		<nav aria-label="pagiantion">
  			<ul class="pagination justify-content-center mt-3">		
	  			<li class="page-item">
					<a id=pnav1 class="page-link" href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=1%>">처음으로</a>
				</li>
				<%
					if(currentPage > 1) {
				%>
					<li class="page-item">
						<a id=pnav2 class="page-link" href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=currentPage-1%>">이전</a>		
					</li>
				<%
					}
					if(currentPage < lastPage) {
				%>
					<li class="page-item">
						<a id=pnav3 class="page-link" href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=currentPage+1%>">다음</a>		
					</li>
				<%
					}
				%>
				<li class="page-item">
					<a id=pnav4 class="page-link" href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=lastPage%>">마지막</a>
				</li>
			</ul>
		</nav>
	</div>
</body>
</html>