<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
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
%>
<!Doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, width=device-width">
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

    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
    <link href="assets/css/themify-icons.css" rel="stylesheet">

	<!-- Chat  -->
	<link rel="stylesheet" href="assets/css/chatStyle.css">
    <link href="//code.ionicframework.com/1.0.0-beta.14/css/ionic.min.css" rel="stylesheet">
    <script src="//code.ionicframework.com/1.0.0-beta.14/js/ionic.bundle.min.js"></script> 
    <!-- Chat - moment -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.8.4/moment.min.js"></script>
    <!-- Chat - angular moment -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/angular-moment/0.8.2/angular-moment.min.js"></script>
</head>
<body ng-app="elastichat">

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
                    <a href="user.jsp">
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

        <div class="content">
		    <ion-nav-bar class="bar-positive" no-tap-scroll="false">
			    <ion-nav-back-button class="button-icon ion-arrow-left-c">
			    </ion-nav-back-button>
		    </ion-nav-bar>
		    <!--
		      The views will be rendered in the <ion-nav-view> directive below
		      Templates are in the /templates folder (but you could also
		      have templates inline in this html file if you'd like).
		      -->
		    <ion-nav-view></ion-nav-view>
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
	<script id="templates/UserMessages.html" type="text/ng-template">
      <ion-view id="userMessagesView"
          cache-view="false" 
          view-title="<i class='icon ion-chatbubble user-messages-top-icon'></i> <div class='msg-header-username'>{{toUser.username}}</div>">
        
        <div class="loader-center" ng-if="!doneLoading">
            <div class="loader">
              <i class="icon ion-loading-c"></i>
            </div>
        </div>
      
          <ion-content has-bouncing="true" class="has-header has-footer" 
              delegate-handle="userMessageScroll">
            
              <div ng-repeat="message in messages" class="message-wrapper"
                  on-hold="onMessageHold($event, $index, message)">
      
                  <div ng-if="user._id !== message.userId">
                      
                    <img ng-click="viewProfile(message)" class="profile-pic left" 
                          ng-src="{{toUser.pic}}" onerror="onProfilePicError(this)" />
      
                      <div class="chat-bubble left">
      
                          <div class="message" ng-bind-html="message.text | nl2br" autolinker>
                          </div>
      
                          <div class="message-detail">
                              <span ng-click="viewProfile(message)" 
                                  class="bold">{{toUser.username}}</span>,
                              <span am-time-ago="message.date"></span>
                          </div>
      
                      </div>
                  </div>
      
                  <div ng-if="user._id === message.userId">
                    
                       <img ng-click="viewProfile(message)" class="profile-pic right" 
                          ng-src="{{user.pic}}" onerror="onProfilePicError(this)" />
                    
                      <div class="chat-bubble right">
      
                          <div class="message" ng-bind-html="message.text | nl2br" autolinker>
                          </div>
      
                          <div class="message-detail">
                              <span ng-click="viewProfile(message)" 
                                  class="bold">{{user.username}}</span>, 
                              <span am-time-ago="message.date"></span>
                          </div>
      
                      </div>
                    
                  </div>
      
                  <div class="cf"></div>
      
              </div>
          </ion-content>
		
          <form name="sendMessageForm" ng-submit="sendMessage(sendMessageForm)" novalidate>
              <ion-footer-bar class="bar-stable item-input-inset message-footer" keyboard-attach>
                  <label class="item-input-wrapper">
                      <textarea ng-model="input.message" value="" placeholder="Send {{toUser.username}} a message..." required minlength="1" maxlength="1500" msd-elastic></textarea>
                  </label>
                  <div class="footer-btn-wrap">
                    <button class="button button-icon icon ion-android-send footer-btn" type="submit"
                        ng-disabled="!input.message || input.message === ''">
                    </button>
                  </div>
              </ion-footer-bar>
          </form>
          
      </ion-view>
    </script>
	<script src='//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
	<script  src="assets/js/chatScript.js"></script>

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
