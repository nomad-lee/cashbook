<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import = "java.util.*" %> <!-- Calendar Arraylist -->
<%@ page import = "java.net.*" %>
<%
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
	// 컨트롤러 : session, request
	// session에 저장된 멤버(현재 로그인 된 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// request 년 + 월
	int year = 0;
	int month = 0;
	
	if ((request.getParameter("year") == null) || (request.getParameter("month") == null)) {
		Calendar today = Calendar.getInstance();
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		//month -> -1, month -> 12 일 경우
		if(month == -1) {
			month = 11;
			year -= 1;
		}
		if(month == 12) {
			month = 0;
			year += 1;
		}
	}	
	
	// 출력하고자 하는 년,월과 월의 1일의 요일(일 1, 월 2, 화 3, ...)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	// fisrtDay는 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK);
	// begin blank 개수는 firstDay -1
	
	//마지막날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);
	
	// 달력 출력테이블의 시작 공백셀(td)과 마지막 공백셀(td)의 개수
	int beginBlank = firstDay - 1;
	int endBlank = 0; //beginBlank + lastDate + ? -> 7로 나누어 떨어진다
	if((beginBlank + lastDate) % 7 != 0 ) {
		endBlank = 7 - ((beginBlank + lastDate) % 7);
	}
	
	//전체 td의 개수 : 7로 나누어 떨어져야 한다
	int totalTd = beginBlank + lastDate + endBlank;
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);
	
	// View : 달력출력 + 일별 cash 목록 출력
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cashList</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div>
		<!-- 로그인 정보(세션 loginMember 변수) 출력 -->
		<%=loginMember.getMemberName()%>님 반갑습니다.
		<a type="btn" class="btn btn-info" href="<%=request.getContextPath()%>/updateMemberForm.jsp">내정보</a>
		<a type="btn" class="btn btn-danger" href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
		<a type="btn" class="btn btn-danger" href="<%=request.getContextPath()%>/deleteMemberForm.jsp">회원탈퇴</a>
		<%
			System.out.println(loginMember.getMemberLevel()+"레벨");
			if(loginMember.getMemberLevel() > 0) {
		%>
				<a type="btn" class="btn btn-dark" href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자 페이지</a>
		<%	
			}
		%>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>">[이전달]</a>
		<%=year%><%=month+1%> 월
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>">[다음달]</a>
	</div>
	<div>
		<!-- 달력 -->
		<table class="table">
			<tr>
				<th>일</th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th>토</th>
			</tr>
			<tr>
				<%
					for(int i=1; i<=totalTd; i++) {
				%>
						<td>
				<%
							int date = i-beginBlank;
							if(date > 0 && date <= lastDate) {
				%>
								<div>
									<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
									<%=date%>
									</a>
								</div>
								<div>
									<%
										for(HashMap<String, Object> m : list) {
											String cashDate = (String)(m.get("cashDate"));
											if(Integer.parseInt(cashDate.substring(8)) == date) {	
									%>
												[<%=(String)(m.get("categoryKind"))%>]
												<%=(String)(m.get("categoryName"))%>
												&nbsp;
												<%=(Long)(m.get("cashPrice"))%>원
												<br>
									<%
											}							
										}									
									%>	
								</div>
				<%				
							}
				%>
						</td>
				<%
						
						if(i%7 == 0 && i != totalTd) {
				%>
							</tr><tr> <!-- td7개 만들고 테이블 줄바꿈 -->
				<%			
						}
					}
				%>
			</tr>
		</table>
	</div>
</body>
</html>