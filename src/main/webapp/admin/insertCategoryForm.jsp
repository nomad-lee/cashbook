<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.time.*" %>
<%@ page import = "java.time.format.*" %>
<%
	// 컨트롤러
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}	

	LocalDate currentDate = LocalDate.now();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1 class="text-center mt-3">카테고리 추가</h1>	
	<!-- msg parameter값이 있으면 출력 -->
	<%
		String msg = request.getParameter("msg");
		if(msg != null) {
	%>
			<div class="text-red text-center" id="msg"><%=msg%></div> <!-- 제목을 입력하시오, 내용을 입력하시오 -->
	<%
		}
	%>
	<form action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" method="post">
		<table class = "table">
			<tr>
				<td>수입/지출</td>
				<td>
					<input type="radio" name="categoryKind" value="수입">수입
					<input type="radio" name="categoryKind" value="지출">지출
				</td>
			</tr>
			<tr>
				<td>항목명</td>
				<td><input type="text" class="form-control" name="categoryName"></td>
			</tr>
			<tr>
				<td>생성일</td>
				<td><input type="text" class="form-control" name="createdate" value="<%=currentDate%>" readonly></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-secondary">추가완료</button>
	</form>
</body>
</html>