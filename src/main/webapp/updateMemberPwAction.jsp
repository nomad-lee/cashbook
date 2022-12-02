<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import= "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		String msg = URLEncoder.encode("잘못된 접근입니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	System.out.println(loginMember.getMemberLevel()+"Form레벨");

	//인코딩 (한글)
	request.setCharacterEncoding("utf-8");
	String memberPw = request.getParameter("memberPw");
	String newMemberPw = request.getParameter("newmemberPw");
	String newMemberPw2 = request.getParameter("newmemberPw2");
	System.out.println(memberPw+""+newMemberPw+""+newMemberPw2);
	
	if(memberPw == null || newMemberPw == null || newMemberPw2 == null || memberPw == "" || newMemberPw == "" || newMemberPw2 == "") {
		String msg = URLEncoder.encode("모든 정보를 입력하세요", "utf-8"); //미입력 방지, get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
		return;
	}  else if(!newMemberPw.equals(newMemberPw2)){
		String msgPwError = URLEncoder.encode("비밀번호를 확인해주세요", "utf-8"); //미입력 방지, get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msgPwError);
		return;
	}
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/cashbook","root","java1234");
	
	String newPwSql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ?";
	PreparedStatement newPwStmt = conn.prepareStatement(newPwSql);
	newPwStmt.setString(1, newMemberPw);
	newPwStmt.setString(2, loginMember.getMemberId());
	System.out.println(loginMember.getMemberId());
	
	int row = newPwStmt.executeUpdate(); // 반환되는 데이터가 0 or 1이라 row가 변경 되었는지 확인
	if(row == 1) {
		System.out.println("수정성공");
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp");
	} else {
		System.out.println("수정실패");
		String msg = URLEncoder.encode("ERROR", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
	}
	
	newPwStmt.close();
	conn.close();
%>
<!-- 
아이디 넣어서 비번출력 현재 비번과 맞다면 -> 새로운 비번, 비번확인 후 -> 삽입 
 -->