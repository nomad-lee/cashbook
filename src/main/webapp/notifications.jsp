<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.time.*" %>
<%@ page import = "java.time.format.*" %>
<%
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/mainPage.jsp?msg="+msg);
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	System.out.println(loginMember.getMemberLevel()+"Form레벨");
	
	int helpNo = 0;
	String memberId = loginMember.getMemberId();
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(memberId);
	
	// 오늘 날짜 포맷
	LocalDateTime currentDate = LocalDateTime.now();  
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd HH:mm");
	String formatted = currentDate.format(formatter);
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	

    <!-- Bootstrap core CSS     -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Animation library for notifications   -->
    <link href="assets/css/animate.min.css" rel="stylesheet"/>

    <!--  Paper Dashboard core CSS    -->
    <link href="assets/css/paper-dashboard.css" rel="stylesheet"/>

    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="assets/css/demo.css" rel="stylesheet" />

    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
    <link href="assets/css/themify-icons.css" rel="stylesheet">
    
    <!-- Chat CSS -->
    <link rel="stylesheet" href="assets/css/chatStyle.css">

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
                <li>
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
                <li class="active">
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
                    <a class="navbar-brand" href="#">Notifications</a>
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
								<p><b>관리자 페이지</b></p>
                            </a>
                        </li>
                        <%
                        	}
                        %>
                    </ul>

                </div>
            </div>
        </nav>        
        
		<!-- chat -->
        <div class="content">
			<section class="msger">
				<header class="msger-header">
					<div class="msger-header-title">
						<i class="fas fa-comment-alt"></i> 고객센터
					</div>
				</header>
				
				<main class="msger-chat"> <!-- helpList -->
					<table>
			        </table>
			        <%
						for(HashMap<String, Object> m : list) {
							if(m.get("helpMemberId") == null || m.get("helpMemo") == null){
								continue;
							} else { // helpNo 같으면 패스 m.get helpNO i=0; i++ i>1 continue
								
								if(helpNo == (int)m.get("helpNo")){
									
								} else {
					%>
									<div class="msg right-msg">
										<div class="msg-img" style="background-image: url(https://image.flaticon.com/icons/svg/145/145867.svg)"></div>
											
										<div class="msg-bubble">
											<div class="msg-info">
												<div class="msg-info-name"><%=m.get("helpMemberId")%></div>
												<div class="msg-info-time"><%=m.get("helpCreatedate")%></div>
											</div>
											
											<div class="msg-text">
												<%=m.get("helpMemo")%>
											</div>
										</div>
									</div>
					<%
								}
								helpNo = (int)m.get("helpNo");
								
								if(m.get("commentMemberId") == null || m.get("commentMemo") == null){
									continue;
								} else {
					%>
									<div class="msg left-msg">
										<div class="msg-img" style="background-image: url(https://image.flaticon.com/icons/svg/327/327779.svg)"></div>
										
										<div class="msg-bubble">
											<div class="msg-info">
												<div class="msg-info-name"><%=m.get("commentMemberId")%></div>
												<div class="msg-info-time"><%=m.get("commentCreatedate")%></div>
											</div>
											
											<div class="msg-text">
												<%=m.get("commentMemo")%>
											</div> 
										</div>
									</div>			
					<%
								}
							}
						}
					%>
				</main>
				
				<form class="msger-inputarea"  action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post"> <!-- insertHelpAction -->
					<input type="text" class="msger-input" placeholder="Enter your message...">
					<button type="submit" class="msger-send-btn">Send</button>
				</form>
			</section>
		</div>
		<!-- chat -->
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

	<!-- Chat -->
	<script src='https://use.fontawesome.com/releases/v5.0.13/js/all.js'></script>
	<script src="assets/js/chatScript.js"></script>

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
