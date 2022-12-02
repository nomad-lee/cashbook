<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.*" %>
<%
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	System.out.println(loginMember.getMemberLevel()+"Form레벨");
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
	<h1 class="text-center mt-3">비밀번호 수정</h1>
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
		<form action="<%=request.getContextPath()%>/updateMemberPwAction.jsp" method="post">
			<table class = "table">
				<tr>
					<td>현재 비밀번호</td>
					<td><input type="password" class="form-control" name="memberPw" id="memberPw"></td>
				</tr>
				<tr>
					<td>새로운 비밀번호</td>
					<td><input type="password" class="form-control" name="newmemberPw" id="newmemberPw"></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" class="form-control" name="newmemberPw2" id="newmemberPw2"></td>
				</tr>		
			</table>
			<button type="submit" class="btn btn-dark">수정완료</button>
		</form>
	</div>

</body>
</html>