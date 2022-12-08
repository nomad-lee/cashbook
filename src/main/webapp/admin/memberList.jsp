<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.util.*" %>
<%
	// 컨트롤러
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/mainPage.jsp");
		return;
	}	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1)*rowPerPage;
	
	// 모델
	MemberDao memberDao = new MemberDao();
	int cnt = memberDao.selectMemberCount(); // 전체 행 개수
	int lastPage = cnt / rowPerPage;
	if(cnt % rowPerPage != 0) {
		lastPage++;
	}
	ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	int memberCount = memberDao.selectMemberCount(); // --> lastPage
	
	// 뷰
%>
<!Doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="assets/img/favicon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>Paper Dashboard by Creative Tim</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />

	<!-- Bootstrap core CSS     -->
    <link href="<%=request.getContextPath()%>/assets/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Animation library for notifications   -->
    <link href="<%=request.getContextPath()%>/assets/css/animate.min.css" rel="stylesheet"/>

    <!--  Paper Dashboard core CSS    -->
    <link href="<%=request.getContextPath()%>/assets/css/paper-dashboard.css" rel="stylesheet"/>

    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="<%=request.getContextPath()%>/assets/css/demo.css" rel="stylesheet" />

    <!--  Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
    <link href="<%=request.getContextPath()%>/assets/css/themify-icons.css" rel="stylesheet">

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
                    <a href="<%=request.getContextPath()%>/admin/adminMain.jsp">
                        <i class="ti-panel"></i>
                        <p>종합 현황</p>
                    </a>
                </li>
                <li>
                    <a href="<%=request.getContextPath()%>/admin/noticeList.jsp">
                        <i class="ti-text"></i>
                        <p>공지 관리</p>
                    </a>
                </li>
                <li>
                    <a href="<%=request.getContextPath()%>/admin/categoryList.jsp">
                        <i class="ti-view-list-alt"></i>
                        <p>카테고리 관리</p>
                    </a>
                </li>
                <li class="active">
                    <a href="<%=request.getContextPath()%>/admin/memberList.jsp">
                        <i class="ti-user"></i>
                        <p>멤버관리</p>
                    </a>
                </li>
                <li>
                    <a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">
                        <i class="ti-bell"></i>
                        <p>고객센터 관리</p>
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
                    <a class="navbar-brand" href="#">Dashboard</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="ti-panel"></i>
								<p>Stats</p>
                            </a>
                        </li>
                        <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <i class="ti-bell"></i>
                                    <p class="notification">5</p>
									<p>Notifications</p>
									<b class="caret"></b>
                              </a>
                              <ul class="dropdown-menu">
                                <li><a href="#">Notification 1</a></li>
                                <li><a href="#">Notification 2</a></li>
                                <li><a href="#">Notification 3</a></li>
                                <li><a href="#">Notification 4</a></li>
                                <li><a href="#">Another notification</a></li>
                              </ul>
                        </li>
                        <%
                        	if(loginMember.getMemberLevel() == 1) {
                        %>
						<li>
                            <a href="<%=request.getContextPath()%>/dashboard.jsp">
								<i class="ti-settings"></i>
								<p>사용자 페이지</p>
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
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">멤버 목록</h4>
                                <p class="category">Created using <a href="https://www.google.com/fonts/specimen/Muli">Muli</a> Font Family</p>
                            </div>
                            <div class="content">
                            	<div>
									<!-- memberList contents... -->
									<h1>멤버목록</h1>
									<table class="table">
										<tr>
											<th>멤버번호</th>
											<th>아이디</th>
											<th>레벨</th>
											<th>이름</th>
											<th>마지막수정일</th>
											<th>생성일자</th>
											<th>레벨수정</th>
											<th>강제탈퇴</th>
										</tr>
										<%
											for(Member m : list) {
										%>
												<tr>
													<td><%=m.getMemberNo()%></td>
													<td><%=m.getMemberId()%></td>
													<td><%=m.getMemberLevel()%></td>
													<td><%=m.getMemberName()%></td>
													<td><%=m.getUpdatedate()%></td>
													<td><%=m.getCreatedate()%></td>
													<td><a class="btn btn-dark" href="<%=request.getContextPath()%>/admin/updateMemberLevel.jsp?memberNo=<%=m.getMemberNo()%>&memberLevel=<%=m.getMemberLevel()%>">0 OR 1</a></td>
													<td><a class="btn btn-danger" href="<%=request.getContextPath()%>/admin/kickMemberAction.jsp?memberNo=<%=m.getMemberNo()%>">X</a></td>
												</tr>
										<%					
											}
										%>
									</table>
									<!-- 페이징코드 -->
									<nav aria-label="pagiantion">
							  			<ul class="pagination justify-content-center mt-3">		
								  			<li class="page-item">
												<a id=pnav1 class="page-link" href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1%>">처음으로</a>
											</li>
											<%
												if(currentPage > 1) {
											%>
												<li class="page-item">
													<a id=pnav2 class="page-link" href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>">이전</a>		
												</li>
											<%
												}
												if(currentPage < lastPage) {
											%>
												<li class="page-item">
													<a id=pnav3 class="page-link" href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>">다음</a>		
												</li>
											<%
												}
											%>
											<li class="page-item">
												<a id=pnav4 class="page-link" href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>">마지막</a>
											</li>
										</ul>
									</nav>
								</div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>


        <footer class="footer">
            <div class="container-fluid">
                <nav class="pull-left">
                    <ul>

                        <li>
                            <a href="http://www.creative-tim.com">
                                Creative Tim
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
                    &copy; <script>document.write(new Date().getFullYear())</script>, made with <i class="fa fa-heart heart"></i> by <a href="http://www.creative-tim.com">Creative Tim</a>
                </div>
            </div>
        </footer>

    </div>
</div>


</body>
	
    <!--   Core JS Files   -->
    <script src="<%=request.getContextPath()%>/assets/js/jquery-1.10.2.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/assets/js/bootstrap.min.js" type="text/javascript"></script>

	<!--  Checkbox, Radio & Switch Plugins -->
	<script src="<%=request.getContextPath()%>/assets/js/bootstrap-checkbox-radio.js"></script>

	<!--  Charts Plugin -->
	<script src="<%=request.getContextPath()%>/assets/js/chartist.min.js"></script>

    <!--  Notifications Plugin    -->
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-notify.js"></script>

    <!--  Google Maps Plugin    -->
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script>

    <!-- Paper Dashboard Core javascript and methods for Demo purpose -->
	<script src="<%=request.getContextPath()%>/assets/js/paper-dashboard.js"></script>

	<!-- Paper Dashboard DEMO methods, don't include it in your project! -->
	<script src="<%=request.getContextPath()%>/assets/js/demo.js"></script>

</html>
