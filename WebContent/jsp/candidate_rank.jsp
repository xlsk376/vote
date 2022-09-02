<%@page import="java.util.*"%>
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


	String sql = "select m.m_no m_no, m.m_name m_name, count(*) rank "
			+	 " from tbl_member_202005 m, tbl_vote_202005 v "
			+	 " where m.m_no=v.m_no and v_confirm = 'Y' "
			+	 " group by m.m_no, m.m_name "
			+	 " order by rank desc ";	

	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	ArrayList<String[]> viewList = new ArrayList<>();
	
	while(rs.next()){
		String view [] = new String[3];
		view[0] = rs.getString(1);
		view[1] = rs.getString(2);
		view[2] = rs.getString(3);
		viewList.add(view);
	}
	conn.close();
	pstmt.close();
	rs.close();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/nav.jsp"></jsp:include>
	
	<section id="section">
		<h2>후보자등수</h2>
	
		<table>
			<thead>
				<tr>
					<th>후보번호</th>
					<th>성명</th>
					<th>총투표건수</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(int i = 0; i < viewList.size(); i++){		
				%>
				<tr>
					<td><%= viewList.get(i)[0] %></td>
					<td><%= viewList.get(i)[1]  %></td>
					<td><%= viewList.get(i)[2]  %></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</section>
	
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>