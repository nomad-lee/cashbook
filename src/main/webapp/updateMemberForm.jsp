<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateMemberPwForm</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1 class="text-center mt-3">내정보 수정</h1>
	<div class="container">
		<form action="<%=request.getContextPath()%>/updateMemberAction.jsp" method="post">
			<table class = "table">
				<tr>
					<td>아이디</td>
					<td><input type="text" class="form-control" name="memberId" value="<%=loginMember.getMemberId()%>" readonly></td> <!-- 객체에 여러 값을 넣고 분리해서 호출가능 -->
				</tr> 
				<tr>
					<td>이름</td>
					<td><input type="text" class="form-control" name="memberName" value="<%=loginMember.getMemberName()%>"></td>
				</tr>
			</table>
			<button type="submit" class="btn btn-dark">수정완료</button>
		</form>
	</div>
</body>
</html>