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

	String sql = "select m_no, m_name from tbl_member_202005";

	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	ArrayList<String[]> viewList = new ArrayList<String[]>();
	while(rs.next()){
		String [] view = new String[2];
		view[0] = rs.getString(1);
		view[1] = rs.getString(2);
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
<link rel="stylesheet" href="../css/style.css?ver=1">
<script type="text/javascript">
	function chkVal() {
		var form = document.vData;
		
		if(!form.v_jumin.value) {
			alert("주민번호가 입력되지 않았습니다!");
			form.v_jumin.focus();
			return false;
		} else if(!form.v_name.value) {
			alert("성명이 입력되지 않았습니다!");
			form.v_name.focus();
			return false;
		} else if(form.m_no.value=="none") {
			alert("후보번호가 선택되지 않았습니다!");
			form.m_no.focus();
			return false;
		} else if(!form.v_time.value) {
			alert("투표시간이 입력되지 않았습니다!");
			form.v_time.focus();
			return false;
		} else if(!form.v_area.value) {
			alert("투표장소가 입력되지 않았습니다!");
			form.v_area.focus();
			return false;
		} else if(document.getElementsByName("v_confirm")[0].checked != true && 
				document.getElementsByName("v_confirm")[1].checked != true) {
			alert("유권자확인이 선택되지 않았습니다!");
			return false;
		}
		
		alert("투표하기 정보가 정상적으로 등록 되었습니다!");
	}
	
	function re() {
		alert("정보를 지우고 처음부터 다시 입력합니다!");

		document.vData.v_jumin.value='';
		document.vData.v_name.value='';
		document.vData.m_no.value='none';
		document.vData.v_time.value='';
		document.vData.v_area.value='';
		document.getElementsByName("v_confirm")[0].checked = false;
		document.getElementsByName("v_confirm")[1].checked = false;
		
		document.vData.v_jumin.focus();
	}
</script>
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/nav.jsp"></jsp:include>
	
	<section id="section">
		<h2>투표 하기</h2>

		<form name="vData" action="to_vote_insert.jsp" method="post" onsubmit="return chkVal()">
			<table class="in_table">
				<tr>
					<th>주민번호</th>
					<td>
						<input type="text" name="v_jumin" size="30">
						<span>예 : 8906153154726</span>
					</td>
				</tr>
				<tr>
					<th>성명</th>
					<td><input type="text" name="v_name" size="20"></td>
				</tr>
				<tr>
					<th>후보번호</th>
					<td>
						<select name="m_no">
							<option value="none">후보선택</option>
							<%
								for(int i = 0; i < viewList.size(); i++){
							%>
							<option value="<%= viewList.get(i)[0]%>">[<%= viewList.get(i)[0]%>] 
							<%= viewList.get(i)[1]%></option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<th>투표시간</th>
					<td><input type="text" name="v_time" size="20"></td>
				</tr>
				<tr>
					<th>투표장소</th>
					<td>
						<input type="text" name="v_area" size="20">
					</td>
				</tr>				
				<tr>
					<th>유권자확인</th>
					<td>
						<input type="radio" name="v_confirm" value="Y"> 예
						<input type="radio" name="v_confirm" value="N"> 아니오
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="투표하기">
						<input type="button" value="다시하기" onclick="re()">
					</td>
				</tr>
			</table>
		</form>
	</section>
	
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>