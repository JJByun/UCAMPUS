<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%  
	Connection conn=null;
	Statement stmt=null;
	String driver="oracle.jdbc.driver.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:orcl";
	Boolean connect=false;
	ResultSet rs=null;
	request.setCharacterEncoding("euc-kr"); 
    String num=request.getParameter("member_no");
    String pw=request.getParameter("password");
	String select_code=request.getParameter("gubun_code"); 
	try{
		Class.forName(driver); //드라이버 가져오기
		conn=DriverManager.getConnection(url,"hr2","1234"); //DB 연결
		connect=true;	
		stmt=conn.createStatement(); //stateMent 생성
		String sql="";
		if(select_code.equals("11")) //학생 로그인
		{
			sql="select * from STUDENT";
		}
		else if(select_code.equals("21")) //교수 로그인
		{
			sql="select * from PROFESSOR";
		}
		 
		String result="";
		rs=stmt.executeQuery(sql);
		while(rs.next()){ 
			String str_id=""; 
			String str_pw="";
			if(select_code.equals("11")) //학생
			{
				str_id=rs.getString("S_ID");
				str_pw=rs.getString("S_PW");
				if(num.equals(str_id)&& pw.equals(str_pw))
				{
					result="로그인 성공!";%>
					<jsp:forward page="student_lectureBoard.jsp"/>
					<% break;
				}

			}
			else if(select_code.equals("21")) //교수
			{
				str_id=rs.getString("P_ID");
				str_pw=rs.getString("P_PW");
				if(num.equals(str_id)&& pw.equals(str_pw))
				{
					result="로그인 성공!";%>
					<jsp:forward page="professor_lectureBoard.jsp"/>
					<%break;
				}

			}

		%>		
		<%}
		
	}catch(Exception e){
		connect=false;
		e.printStackTrace();
	}
%>
	<script type="text/javascript">
			alert("일치하는 아이디가 없습니다");
			
	</script>

</body> 
</html>