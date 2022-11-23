<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import= "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	Cash updateCash = new Cash();
	updateCash.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
	updateCash.setCashPrice(Long.parseLong(request.getParameter("cashPrice")));
	updateCash.setCashDate(request.getParameter("cashDate"));
	updateCash.setCashMemo(request.getParameter("cashMemo"));
	updateCash.setCashNo(Integer.parseInt(request.getParameter("cashNo")));
	System.out.println(request.getParameter("cashNo")+"수정cash action");
	
	// 분리된 모델 호출
	CashDao cashDao = new CashDao();	
	Cash resultCash = cashDao.updateCash(updateCash);
		
	if(resultCash != null){
		//session.setAttribute("loginMember", loginMember); null 버그 주범
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp"); //?year="+year+"&month="+month+"&date="+date
		System.out.println(resultCash+"수정완");
		
	} else {
		response.sendRedirect(request.getContextPath()+"/cash/updateCashForm.jsp");
		System.out.println("수정실패");
	}	
%>