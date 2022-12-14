<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>가계부</title>
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css'>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/mainPageStyle.css">

</head>
<body>
<!-- partial:index.partial.html -->
<main class="main">
  <section class="home">
    <h1>Welcome to the <span>Cashplan</span></h1>
    <button id="sign-up" class="btn">회원가입</button>
    <button id="sign-in" class="btn">로그인</button>
    <p><a class="link-copy" href="http://collectui.com/designers/dnes/sign-up" target="_blank">©Copyright 2022</a></p>
  </section>

  <section class="sign-up">
    <article class="signup-left">
      <h1>Cashplan</h1>
      <div class="wc_message">
        <h3>환영합니다 !</h3>
        <p>당신의 소비 계획을 도울</p>
        <p>간편하고 쉬운 가계부 Cashplan입니다</p>
      </div>
      <div class="btn-back">
        <i class="fas fa-2x fa-angle-left angle-left-color"></i>
        HOME
      </div>
    </article>

    <article class="form-area">
      <!-- Form area Sign Up -->
      <div class="organize-form form-area-signup">
        <h2>Sign Up</h2>
        <form class="form" action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
          <div class="form-field">
            <label for="memberName">별명</label>
            <input type="text" name="memberName" id="memberName" />
          </div>

          <div class="form-field">
            <label for="memberId">아이디</label>
            <input type="text" name="memberId" id="memberId" />
          </div>

          <div class="form-field">
            <label for="memberPw">비밀번호</label>
            <input type="text" name="memberPw" id="memberPw" />
          </div>

          <button class="btn-sign btn-up" id="signinBtn">회원가입 완료</button>
        </form>
          <!-- msg parameter값이 있으면 출력 -->
	 	  <%
			String msg = request.getParameter("msg");
			if(msg != null) {
		  %>
			<div class="text-red text-center" id="msg"><%=msg%></div>
		  <%
			}
		  %>
        <p>계정이 있으신가요? <a href="#" class="link-in">로그인</a></p>

      </div>

      <!-- Form area Sign In -->
      <div class="organize-form form-area-signin">
        <h2>Login</h2>
        <form class="form" action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
          <div class="form-field">
            <label for="memberId_in">아이디</label>
            <input type="text" name="memberId_in" id="memberId_in" />
          </div>

          <div class="form-field">
            <label for="memberPw_in">비밀번호</label>
            <input type="password" name="memberPw_in" id="memberPw_in" />
          </div>

          <button class="btn-sign btn-in">로그인</button>
        </form>        
          <!-- msg parameter값이 있으면 출력 -->
	 	  <%
			msg = request.getParameter("msg");
			if(msg != null) {
		  %>
			<div class="text-red text-center" id="msg"><%=msg%></div>
		  <%
			}
		  %>
        <p>계정이 없나요? <a href="#" class="link-up">회원가입</a></p>
      </div>
    </article>

    <article class="signup-right">
      <i class="fas fa-2x fa-bars bars-style"></i>
      <p><a class="link-copy" href="http://collectui.com/designers/dnes/sign-up" target="_blank">©Copyright 2022</a></p>

    </article>
  </section>
</main>
<!-- partial -->
  <script src="<%=request.getContextPath()%>/assets/js/mainPageScript.js"></script>
  <script>
	let signinBtn = document.querySelector('#signinBtn');

	signinBtn.addEventListener('click', function(){
		// 디버깅
		console.log('siginBtn clik!');
		
		// ID 폼 유효성 검사
		let memberId = document.querySelector('#memberId');
		if(memberId.value == '') {
			alert('id를 입력하세요');
			memberId.focus(); // 브라우저의 커스를 id태그로 이동
			return;
		}
	});
  </script>

</body>
</html>
