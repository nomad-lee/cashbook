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
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String today = request.getParameter("updatedate");
	System.out.println(request.getParameter("updatedate"));
	
	CategoryDao categoryDao = new CategoryDao();
	Category resultcategory = categoryDao.selectCategoryOne(categoryNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCategoryForm</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1 class="text-center mt-3">카테고리 수정</h1>	
	<!-- msg parameter값이 있으면 출력 -->
	<%
		String msg = request.getParameter("msg");
		if(msg != null) {
	%>
			<div class="text-red text-center" id="msg"><%=msg%></div> <!-- 제목을 입력하시오, 내용을 입력하시오 -->
	<%
		}
	%>
	<form action="<%=request.getContextPath()%>/admin/updateCategoryAction.jsp" method="post">
		<table class = "table">
			<tr>
				<td>수입/지출</td>
				<td>
					<%
						if(resultcategory.getCategoryKind().equals("수입")){
					%>
						<input type="radio" name="categoryKind" value="수입" checked>수입
						<input type="radio" name="categoryKind" value="지출">지출
					<%
						} else {
					%>
						<input type="radio" name="categoryKind" value="수입">수입
						<input type="radio" name="categoryKind" value="지출" checked>지출
					<%
						}
					%>				
				</td>
			</tr>
			<tr>
				<td>항목명</td>
				<td><input type="text" class="form-control" name="categoryName" value="<%=resultcategory.getCategoryName()%>"></td>
			</tr>
			<tr>
				<td>수정일</td>
				<td><input type="text" class="form-control" name="createdate" value="<%=today%>" readonly></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-secondary">수정완료</button>
	</form>
</body>
</html>