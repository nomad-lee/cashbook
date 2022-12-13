<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/mainPage.jsp?msg="+msg);
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	System.out.println(loginMember.getMemberLevel()+"Form레벨");
	

	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	int year = 2022;
	int month = 11;
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
	<link rel="icon" type="image/png" sizes="96x96" href="assets/img/favicon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>Cashplan</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />
    
    <!-- Calendar -->
	<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.4.0/fullcalendar.min.css'>
	<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css'>
	<link rel="stylesheet" href="assets/css/calendarStyle.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js"></script>
    
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
                <li>
                    <a href="recentList.jsp">
                        <i class="ti-user"></i>
                        <p>최근 내역</p>
                    </a>
                </li>
                <li class="active">
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
                    <a class="navbar-brand" href="#">Table List</a>
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
<!-- calendar part -->
		<div class="content">
        	<div id='calendar-container'>        	
        	
				<!-- partial:index.partial.html -->
				<div class="site-header autocomplete">
					<div class="dialog">
					</div>
				</div>
			
				<div id='calendar'></div>
			
				<div id="calendar-popup">
					<form id="event-form">
						<div class='calander_popip_title'>
							<i class="fa fa-calendar" aria-hidden="true"></i>
							Add Event
						</div>
						<ul>
							<li>
								<label for="event-start"><i class="fa fa-bell-o" aria-hidden="true"></i>
									cashDate
								</label>
								<input id="event-start"  class='form-control' type="datetime-local" name="cashDate"/>
							</li>
							<li>
								<label for="event-title"><i class="fa fa-bell-slash" aria-hidden="true"></i>
									categoryNo
								</label>								
								<select id="event-title" class='form-control' name = "categoryNo">
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
							</li>
							<li>
								<label for="event-location"><i class="fa fa-calendar-minus-o" aria-hidden="true"></i>
									cashPrice
								</label>
								<input id="event-location"  class='form-control' type="number" name="cashPrice"/>
							</li>
							<li>
			 					<label for="event-details"><i class="fa fa-info-circle" aria-hidden="true"></i>
									cashMemo
								</label>
								<textarea rows="3" id="event-details"  class='form-control' name="cashMemo"></textarea>
							</li>
							<div class="button">
								<input type="submit" class='form-control submit_btn'/>
							</div>
						</ul>
					</form>
			  
					<div id="event">
					<header></header>
						<ul>
							<li class="start-time"> 
								<p>Start at</p>
								<time></time>
							</li>
							<li class="end-time">
								<p>End</p>
								<time></time>
							</li>
							<li>
								<p><i class="fa fa-map-marker" aria-hidden="true"></i>Location</p>
								<p class="location"></p>
							</li>
							<li>
								<p><i class="fa fa-info" aria-hidden="true"></i>Details:</p>
								<p class="details"></p>
							</li>
						</ul>
					</div>
			
					<div class="prong">
						<div class="bottom-prong-dk"></div>
						<div class="bottom-prong-lt"></div>
					</div>
				</div>
			
				<div class='modle' id='simplemodal'>
					<div class='modle-continer'>
						<form id="edit-form">
							<div class='modal-header'>
								<span class='close-btn' id='close-btnid'>&times</span>
								<h2>Edit Event</h2>
							</div>
							
							<div class='modal-body'>  
								<lable for='eventname'>Event Name</lable>
								<input type='text' name='eventname' id='eventname' class='form-control'>
								<lable for='location'>Location</lable>
								<input type='text' name='location' id='location' class='form-control'>     
								<label for="event-start">From</label>
								<input id="eventstart" type="datetime-local" name="start" class='form-control'/>     
								<label for="event-end">To</label>
								<input id="eventend" type="datetime-local" name="end" class='form-control'/>
								<label for="event-details">Details</label>
								<textarea id="eventdetails" type='text' name="details"  class='form-control'></textarea>    
							</div>
							
							<div class='modal-footer'>
								<button type='submit' class='btn btn-info'>save</button>
								<button class='btn btn-dafault'>cancel</button>      
							</div>
						</form>
					</div>  
				</div>            
            
            </div>
        </div>
<!-- calendar part -->
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
	<!-- Calendar -->
	<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/moment.min.js'></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.2.0/fullcalendar.min.js'></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js'></script>
	<script  src="assets/js/calendarScript.js"></script>

    <!--   Core JS Files   -->
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