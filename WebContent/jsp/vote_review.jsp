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
	String sql2 = "select v_name, v_jumin, to_char(sysdate, 'yyyy') this_year, m_no, v_time, v_confirm ";
		   sql2 += " from tbl_vote_202005 ";

	PreparedStatement pstmt = conn.prepareStatement(sql2);
	ResultSet rs = pstmt.executeQuery();
	ArrayList<String[]> viewList = new ArrayList<String[]>();
	while(rs.next()){
		String[] view = new String[7];
		view[0] =  rs.getString(1);
		String jumin = rs.getString(2);
		String birth = "19" + jumin.substring(0, 2);
		birth += "년";
		birth += jumin.substring(2,4);
		birth += "월";
		birth += jumin.substring(4, 6);
		birth += "일생";
		
		view[1] = birth;
		
		String thisyear =  rs.getString(3);
		String myyear = "19" + jumin.substring(0, 2);
		int age = Integer.parseInt(thisyear) - Integer.parseInt(myyear);
		view[2] =  age + "";
		
		String gender = jumin.substring(6, 7);
		if(gender.equals("1")){
			gender = "남";
		}else if(gender.equals("2")){
			gender = "여";
		}
		view[3] = gender;
		
		view[4] = rs.getString(4);
		String time = rs.getString(5);
		view[5] =  time.substring(0, 2) + ":" + time.substring(2, time.length());
		
		String confirm = rs.getString(6);
		if(confirm.equals("Y")){
			confirm = "확인";
		}else{
			confirm = "미확인";
		}
		view[6] =  confirm;
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
		<h2>투표검수조회</h2>
	
		<table>
			<thead>
				<tr>
					<th>성명</th>
					<th>생년월일</th>
					<th>나이</th>
					<th>성별</th>
					<th>후보번호</th>
					<th>투표시간</th>
					<th>유권자확인</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(int i = 0; i < viewList.size(); i++) {				
				%>
				<tr>
				
					<td><%= viewList.get(i)[0] %></td>
					<td><%= viewList.get(i)[1] %></td>
					<td><%= viewList.get(i)[2]%></td>
					<td><%= viewList.get(i)[3]%></td>
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