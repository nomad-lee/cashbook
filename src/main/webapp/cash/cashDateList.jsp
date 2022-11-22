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
	
	/* 
	if ((request.getParameter("year") == null) || (request.getParameter("month") == null) || (request.getParameter("date") == null)) {
		Calendar today = Calendar.getInstance();
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
		date = today.get(Calendar.DATE);
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		date = Integer.parseInt(request.getParameter("date"));
		System.out.println(year+"-"+month+"-"+date);
	} */
	
	//M
	
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	CashDao cashDao = new CashDao(); 
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashDateList</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<!-- cash 입력 폼 -->
	<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%= loginMember.getMemberId() %>">
		<table border="1">
			<tr>
				<td>categoryNo</td>
				<td>
					<select name = "categoryNo">
						<%	
							for(Category c : categoryList) {
						%>
								<option value="<%=c.getCategoryNo()%>">
									<%=c.getCategoryKind()%> <%=c.getCategoryName() %>
								</option>
						<%
							}
						%>
					</select>
				</td>			
			</tr>
			<tr>
				<td>cashDate</td>
				<input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
			</tr>
			<tr>
				<td>cashMemo</td>
				<td>
					<textarea rows="3" cols="50" name="cashMemo"></textarea>
				</td>
			</tr>
		</table>
		<button type="submit"></button>
	</form>	
	<!-- cash 목록 출력 -->
	<table border="1" class="table">
		<tr>
			<th>수입/지출</th>
			<th>항목</th>
			<th>금액</th>
			<th>결제일</th>
			<th>메모</th>
			<th>수정</th> <!-- /cash/updateCashForm.jsp?cashNo= -->
			<th>삭제</th> <!-- /cash/deleteCash.jsp?cashNo= -->
		</tr>
			<%
				for(HashMap<String, Object> m : list) {
					String cashDate = (String)(m.get("cashDate"));
					System.out.println(cashDate+"cashDate");
					if(Integer.parseInt(cashDate.substring(8)) == date) {
			%>
				<tr>
					<td><%=(String)(m.get("categoryKind"))%></td>
					<td><%=(String)(m.get("categoryName"))%></td>
					<td><%=(Long)(m.get("cashPrice"))%>원</td>
					<td><%=(String)(m.get("cashDate"))%></td>
					<td><%=(String)(m.get("cashMemo"))%></td>
					<td><a class="btn btn-green" href="<%=request.getContextPath()%>/cash/deleteCashDate.jsp">✏️</a></td>
					<td><a class="btn btn-danger" href="<%=request.getContextPath()%>/cash/deleteCashDate.jsp">X</a></td>
				</tr>
			<%
					}
				}
			%>
	</table>
</body>
</html>