<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%	
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
	//컨트롤러
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	int year = 0;
	int month = 0;
	int date = 0;
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	System.out.println(cashNo+" updateCashForm");

	if ((request.getParameter("year") == null) || (request.getParameter("month") == null) || (request.getParameter("date") == null)) {
		Calendar today = Calendar.getInstance();
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
		date = today.get(Calendar.DATE);
		System.out.println(year+"-"+month+"-"+date+"날짜없음");
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		date = Integer.parseInt(request.getParameter("date"));
		System.out.println(year+"-"+month+"-"+date+"날짜있음");
	}
	
	// 분리된 모델 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	CashDao cashDao = new CashDao(); 
	HashMap<String, Object> m = cashDao.selectCashListByCashNo(cashNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCashForm</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post" class="form">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<input type="hidden" name="cashNo" value="<%=cashNo%>">
		<input type="hidden" name="year" value="<%=year%>"> 
		<input type="hidden" name="month" value="<%=month%>"> 
		<input type="hidden" name="date" value="<%=date%>"> 
		<table border="1" class="table">
			<tr>
				<td>categoryNo</td>
				<td>
					<select name = "categoryNo">
					<%	
						for(Category c : categoryList) {
					%>
							<option value="<%=c.getCategoryNo()%>">
								[<%=c.getCategoryKind()%>] <%=c.getCategoryName() %>
							</option>
					<%
						}
					%>
					</select>
				</td>			
			</tr>
			<tr>
				<td>cashPrice</td>
				<td><input type="number" name="cashPrice" value="<%=m.get("cashPrice")%>">원</td>
			</tr>
			<tr>
				<td>cashDate</td>
				<td><input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>cashMemo</td>
				<td>
					<textarea rows="3" cols="50" name="cashMemo"><%=m.get("cashMemo")%></textarea>
				</td>
			</tr>
		</table>
		<!-- msg parameter값이 있으면 출력 -->
		<%
			String msg = request.getParameter("msg");
			if(msg != null) {
		%>
				<div class="text-red text-center" id="msg"><%=msg%></div> <!-- 제목을 입력하시오, 내용을 입력하시오 -->
		<%
			}
		%>
		<button type="submit">수정완료</button>
	</form>
</body>
</html>