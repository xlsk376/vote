<%@page import="java.util.ArrayList"%>
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

String sql2 = "select m_no, m_name, p_name, p_school, m_jumin, m_city, p_tel1, p_tel2, p_tel3 ";
	sql2 +=	" from tbl_member_202005 m, tbl_party_202005 p where m.p_code =  p.p_code"; 
	
	
	//String sql2 = "select * from tbl_member_202005";

	PreparedStatement pstmt = conn.prepareStatement(sql2);
	ResultSet rs = pstmt.executeQuery();
	
	ArrayList<String[]> viewList = new ArrayList<>();
	
	while(rs.next()){
		String view[] = new String[7];	
		view[0] = rs.getString(1);
		view[1] = rs.getString(2);
		view[2] = rs.getString(3);
		String school = rs.getString(4);
		
		if(school.equals("1")){
			school = "고졸";
		}
		else if(school.equals("2")){
			school = "학사";
		}
		else if(school.equals("3")){
			school = "석사";
		}
		
		view[3] = school;
		String jumin = rs.getString(5);
		jumin = jumin.substring(0, 7) + "-" + jumin.substring(6, jumin.length());
		
		view[4] = jumin;
		view[5] = rs.getString(6);
		
		String tel = rs.getString(7);
		tel += "-";
		tel += rs.getString(8);
		tel += rs.getString(9);
		view[6] = tel;
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
		<h2>후보조회</h2>
	
		<table>
			<thead>
				<tr>
					<th>후보번호</th>
					<th>성명</th>
					<th>소속정당</th>
					<th>학력</th>
					<th>주민번호</th>
					<th>지역구</th>
					<th>대표전화</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(int i = 0; i < viewList.size(); i++){
				%>
				<tr>
					<td><%= viewList.get(i)[0] %></td>
					<td><%= viewList.get(i)[1] %></td>
					<td><%= viewList.get(i)[2] %></td>
					<td><%= viewList.get(i)[3] %></td>
					<td><%= viewList.get(i)[4] %></td>
					<td><%= viewList.get(i)[5] %></td>
					<td><%= viewList.get(i)[6] %></td>
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