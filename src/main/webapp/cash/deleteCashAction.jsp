<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>

<% 
	request.setCharacterEncoding("utf-8");

	Cash paramCash = new Cash();
	paramCash.setCashNo(Integer.parseInt(request.getParameter("cashNo")));
	paramCash.setMemberId(request.getParameter("memberId"));

	int year = 0;
	int month = 0;
	int date = 0;

	if ((request.getParameter("year") == null) || (request.getParameter("month") == null) || (request.getParameter("date") == null)) {
		System.out.println(year+"-"+month+"-"+date+"action 값 없음");
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		date = Integer.parseInt(request.getParameter("date"));
		System.out.println(year+"-"+month+"-"+date+"action");
	}
	
	// 분리된 모델 호출
	CashDao cashDao = new CashDao();
	Cash resultRow = cashDao.deleteCash(paramCash);	

	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?"+"year="+year+"&month="+month+"&date="+date);

%>