<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%	
	//C
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	int year = 0;
	int month = 0;
	int date = 0;
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));

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
	
	//M	
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
	<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post" class="form">
		<input type="hidden" name="memberId" value="<%= loginMember.getMemberId()%>">
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
		<button type="submit">수정완료</button>
	</form>
</body>
</html>