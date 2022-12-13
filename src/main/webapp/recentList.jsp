<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.util.*" %>
<%
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/mainPage.jsp?msg="+msg);
		return;
	}
	// 월별 검색 년도 계산
	int year = 0;
	if(request.getParameter("year") == null) {
		Calendar c = Calendar.getInstance();
		year = c.get(Calendar.YEAR);
	} else {
		year = Integer.parseInt(request.getParameter("year"));
	}
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	System.out.println(loginMember.getMemberLevel()+"Form레벨");
	
	CashDao cashDao = new CashDao();
	CashDao cashDao2 = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.cashListByYear(memberId);
	ArrayList<HashMap<String, Object>> list2 = cashDao2.cashListByMonth(memberId, year);
	System.out.println(loginMember.getMemberId()+"로그인된 아이디"+list);
	
	// 페이징 사용할 최소년도와 최대년도
	HashMap<String, Object> map = cashDao.selectMaxMinYear();
	int minYear = (Integer)(map.get("minYear"));
	int maxYear = (Integer)(map.get("maxYear"));
%>
<!Doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="assets/img/favicon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>Cashplan</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


    <!-- Bootstrap core CSS     -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Animation library for notifications   -->
    <link href="assets/css/animate.min.css" rel="stylesheet"/>

    <!--  Paper Dashboard core CSS    -->
    <link href="assets/css/paper-dashboard.css" rel="stylesheet"/>

    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="assets/css/demo.css" rel="stylesheet" />

    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
    <link href="assets/css/themify-icons.css" rel="stylesheet">

</head>
<body>

<div class="wrapper">
	<div class="sidebar" data-background-color="black" data-active-color="warning">

    <!--
		Tip 1: you can change the color of the sidebar's background using: data-background-color="white | black"
		Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
	-->

    	<div class="sidebar-wrapper">
            <div class="logo">
                <a href="" class="simple-text">
                    Cashplan
                </a>
                <a href="user.jsp">
               		<i class="ti-user">me</i>
               	</a>
            </div>

            <ul class="nav">
                <li>
                    <a href="dashboard.jsp">
                        <i class="ti-panel"></i>
                        <p>종합 보고서</p>
                    </a>
                </li>
                <li class="active">
                    <a href="recentList.jsp">
                        <i class="ti-user"></i>
                        <p>최근 내역</p>
                    </a>
                </li>
                <li>
                    <a href="table.jsp">
                        <i class="ti-view-list-alt"></i>
                        <p>달력</p>
                    </a>
                </li>
                <li>
                    <a href="notifications.jsp">
                        <i class="ti-bell"></i>
                        <p>고객센터</p>
                    </a>
                </li>
				<li class="active-pro">
                    <a href="logout.jsp">
                        <i class="ti-export"></i>
                        <p>로그아웃</p>
                    </a>
                </li>
            </ul>
    	</div>
    </div>

    <div class="main-panel">
		<nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar bar1"></span>
                        <span class="icon-bar bar2"></span>
                        <span class="icon-bar bar3"></span>
                    </button>
                    <a class="navbar-brand" href="#">Recent List</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="ti-panel"></i>
								<p>Stats</p>
                            </a>
                        </li>
                        <%
                        	if(loginMember.getMemberLevel() == 1) {
                        %>
						<li>
                            <a href="<%=request.getContextPath()%>/admin/adminMain.jsp">
								<i class="ti-settings"></i>
								<p>관리자 페이지</p>
                            </a>
                        </li>
                        <%
                        	}
                        %>
                    </ul>

                </div>
            </div>
        </nav>


        <div class="content">
            <div class="container-fluid">
                
				<!-- 년도별 수입/지출 -->
				<h4> 년도별 수입/지출 </h4>
				<table border="1" class="table">
					<tr>
						<th>년도</th>
						<th>수입카운트</th>
						<th>수입합계</th>
						<th>수입평균</th>
						<th>지출카운트</th>
						<th>지출합계</th>
						<th>지출평균</th>
					</tr>			
						<%
							for(HashMap<String, Object> m : list) {
								System.out.println(m.get("year")+"년도");
						%>
							<tr>					
								<td><%=m.get("year")%></td>
								<td><%=m.get("countIncome")%></td>
								<td><%=m.get("sumIncome")%>원</td>
								<td><%=m.get("avgIncome")%>원</td>
								<td><%=m.get("countExport")%></td>
								<td><%=m.get("sumExport")%>원</td>
								<td><%=m.get("avgExport")%>원</td>
							</tr>
						<%
							}				
						%>
				</table>
				<!-- 년도별 수입/지출 -->
				
				<!-- 월별 수입/지출 -->
				<h4><%=year%>년 월별 수입/지출 </h4>
				<table border="1" class="table">
					<tr>
						<th>월</th>
						<th>수입카운트</th>
						<th>수입합계</th>
						<th>수입평균</th>
						<th>지출카운트</th>
						<th>지출합계</th>
						<th>지출평균</th>
					</tr>			
						<%
							for(HashMap<String, Object> m : list2) {
								System.out.println(m.get("year")+"년도2");
						%>
							<tr>					
								<td><%=m.get("month")%></td>
								<td><%=m.get("countIncome")%></td>
								<td><%=m.get("sumIncome")%>원</td>
								<td><%=m.get("avgIncome")%>원</td>
								<td><%=m.get("countExport")%></td>
								<td><%=m.get("sumExport")%>원</td>
								<td><%=m.get("avgExport")%>원</td>
							</tr>
						<%
							}				
						%>
				</table>
				<%
					if(year > minYear) {
				%>
						<a href="<%=request.getContextPath()%>/recentList.jsp?&year=<%=year-1%>">이전</a>
				<%		
					}
				
					if(year < maxYear) {
				%>
						<a href="<%=request.getContextPath()%>/recentList.jsp?&year=<%=year+1%>">다음</a>	
				<%		
					}
				%>
				<!-- 월별 수입/지출 -->
            </div>
        </div>


        <footer class="footer">
            <div class="container-fluid">
                <nav class="pull-left">
                    <ul>

                        <li>
                            <a href="http://www.creative-tim.com">
                                Our Team
                            </a>
                        </li>
                        <li>
                            <a href="http://blog.creative-tim.com">
                               Blog
                            </a>
                        </li>
                        <li>
                            <a href="http://www.creative-tim.com/license">
                                Licenses
                            </a>
                        </li>
                    </ul>
                </nav>
				<div class="copyright pull-right">
                    &copy; <script>document.write(new Date().getFullYear())</script>, made with <i class="fa fa-heart heart"></i> <a href="http://www.creative-tim.com">Goodee Academy</a>
                </div>
            </div>
        </footer>

    </div>
</div>


</body>

    <!--   Core JS Files   -->
    <script src="assets/js/jquery-1.10.2.js" type="text/javascript"></script>
	<script src="assets/js/bootstrap.min.js" type="text/javascript"></script>

	<!--  Checkbox, Radio & Switch Plugins -->
	<script src="assets/js/bootstrap-checkbox-radio.js"></script>

	<!--  Charts Plugin -->
	<script src="assets/js/chartist.min.js"></script>

    <!--  Notifications Plugin    -->
    <script src="assets/js/bootstrap-notify.js"></script>

    <!--  Google Maps Plugin    -->
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script>

    <!-- Paper Dashboard Core javascript and methods for Demo purpose -->
	<script src="assets/js/paper-dashboard.js"></script>

	<!-- Paper Dashboard DEMO methods, don't include it in your project! -->
	<script src="assets/js/demo.js"></script>

</html>
