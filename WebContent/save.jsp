<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.sql.*" %>
<%@page import = "java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title></title>
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
		//제목 
		String title=request.getParameter("title");
		//본문
		String text=request.getParameter("text");
		//파일
		String file=request.getParameter("file");
		//클래스 이름
		String C_ID=request.getParameter("C_ID");
		//교수이름
		String P_ID=request.getParameter("P_ID");
		try{
			Class.forName(driver); //드라이버 가져오기
			 //DB 연결
			conn=DriverManager.getConnection(url,"hr2","1234");
			connect=true;	
			stmt=conn.createStatement(); //stateMent 생성
			String sql="insert into lecture_board values(";
			sql+="(Select NVL(MAX(L_INDEX,0)+1 FROM LECTURE_BOARD)),";
			sql+=C_ID+",";
			sql+=title+",";
			sql+=text+",";
			sql+=P_ID+",";
			Date currentDate=new Date();
			SimpleDateFormat sf= new SimpleDateFormat("yyyy.mm.dd");
			String nowDate=sf.format(currentDate);
			sql+=nowDate+",";
			sql+="1,";
			sql+=file+");";			
			stmt.executeUpdate(sql);
			%>
			<h1><%= sql %></h1>
			<% 
		}catch(Exception e)
		{
			
		}
	%>
<script type="text/javascript">
	alert("저장완료");
</script>
</body>
</html>