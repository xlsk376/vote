<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

Connection conn = null;

String url = "jdbc:oracle:thin:@localhost:1521:xe";
String id = "system";
String pw = "1234";
try {
	Class.forName("oracle.jdbc.OracleDriver");
	conn = DriverManager.getConnection(url, id, pw);
	System.out.println("Connected");
} catch (Exception e) {
	e.printStackTrace();
}


	request.setCharacterEncoding("UTF-8");
	String sql = "insert into tbl_vote_202005 values (?, ?, ?, ?, ?, ?)";

	PreparedStatement pstmt = conn.prepareStatement(sql);

	pstmt.setString(1, request.getParameter("v_jumin"));
	pstmt.setString(2, request.getParameter("v_name"));
	pstmt.setString(3, request.getParameter("m_no"));
	pstmt.setString(4, request.getParameter("v_time"));
	pstmt.setString(5, request.getParameter("v_area"));
	pstmt.setString(6, request.getParameter("v_confirm"));
	
	pstmt.executeUpdate();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:forward page="index.jsp"></jsp:forward>
</body>
</html>