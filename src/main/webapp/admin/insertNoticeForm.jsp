<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.time.*" %>
<%@ page import = "java.time.format.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}	

	LocalDateTime currentDate = LocalDateTime.now();  
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	String formatted = currentDate.format(formatter);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertNotice</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1 class="text-center mt-3">공지추가</h1>
	<!-- msg parameter값이 있으면 출력 -->
	<%
		String msg = request.getParameter("msg");
		if(msg != null) {
	%>
			<div class="text-red text-center" id="msg"><%=msg%></div> <!-- 제목을 입력하시오, 내용을 입력하시오 -->
	<%
		}
	%>
	<div class="container">
		<form action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp" method="post">
			<table class = "table">
				<tr>
					<td>공지내용</td>
					<td><input type="text" class="form-control" name="noticeMemo"></td>
				</tr>
				<tr>
					<td>공지일</td>
					<td><input type="text" class="form-control" name="createdate" value="<%=formatted%>" readonly></td>
				</tr>
			</table>
			<button type="submit" class="btn btn-secondary">추가완료</button>
		</form>
	</div>
</body>
</html>