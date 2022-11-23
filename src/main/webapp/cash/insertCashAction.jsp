<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");

	Cash paramCash = new Cash();
	paramCash.setMemberId(request.getParameter("memberId"));
	paramCash.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
	paramCash.setCashPrice(Long.parseLong(request.getParameter("cashPrice")));
	paramCash.setCashDate(request.getParameter("cashDate"));
	paramCash.setCashMemo(request.getParameter("cashMemo"));
	
	int year = 0;
	int month = 0;
	int date = 0;

	if ((request.getParameter("year") == null) || (request.getParameter("month") == null) || (request.getParameter("date") == null)) {
		System.out.println("action 값 없음");
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		date = Integer.parseInt(request.getParameter("date"));
		System.out.println(year+"-"+month+"-"+date+"action");
	}
	
	// 분리된 모델 호출
	CashDao cashDao = new CashDao();
	Cash resultRow = cashDao.insertCash(paramCash);	

	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?"+"year="+year+"&month="+month+"&date="+date);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>