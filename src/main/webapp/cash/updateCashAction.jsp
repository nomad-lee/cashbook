<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
	request.setCharacterEncoding("utf-8");
	
	// 컨트롤러
	String categoryNo = request.getParameter("categoryNo");
	String cashPrice = request.getParameter("cashPrice");
	String cashDate = request.getParameter("cashDate");
	String cashMemo = request.getParameter("cashMemo");
	String cashNo = request.getParameter("cashNo");	

	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String date = request.getParameter("date");
	
	if(request.getParameter("categoryNo") == null || request.getParameter("cashPrice") == null || request.getParameter("cashDate") == null || request.getParameter("cashMemo") == null || request.getParameter("cashNo") == null
		|| request.getParameter("categoryNo") == "" || request.getParameter("cashPrice") == "" || request.getParameter("cashDate") == "" || request.getParameter("cashMemo") == "" || request.getParameter("cashNo") == "") {
		String msg = URLEncoder.encode("모든 정보를 입력하세요", "utf-8"); //미입력 방지, get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/cash/updateCashForm.jsp?cashNo="+cashNo+"&msg="+msg+"&year="+year+"&month="+month+"&date="+date);
		return;
	}
	
	Cash updateCash = new Cash();
	updateCash.setCategoryNo(Integer.parseInt(categoryNo));
	updateCash.setCashPrice(Long.parseLong(cashPrice));
	updateCash.setCashDate(cashDate);
	updateCash.setCashMemo(cashMemo);
	updateCash.setCashNo(Integer.parseInt(cashNo));
	System.out.println(request.getParameter("cashNo")+"수정cash action");	
	
	
	// 분리된 모델 호출
	CashDao cashDao = new CashDao();	
	Cash resultCash = cashDao.updateCash(updateCash);
		
	if(resultCash != null){
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
		System.out.println(resultCash+"수정완");
		
	} else {
		response.sendRedirect(request.getContextPath()+"/cash/updateCashForm.jsp");
		System.out.println("수정실패");
	}
%>