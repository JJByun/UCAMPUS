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
		//���� 
		String title=request.getParameter("title");
		//����
		String text=request.getParameter("text");
		//����
		String file=request.getParameter("file");
		//Ŭ���� �̸�
		String C_ID=request.getParameter("C_ID");
		//�����̸�
		String P_ID=request.getParameter("P_ID");
		try{
			Class.forName(driver); //����̹� ��������
			 //DB ����
			conn=DriverManager.getConnection(url,"hr2","1234");
			connect=true;	
			stmt=conn.createStatement(); //stateMent ����
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
	alert("����Ϸ�");
</script>
</body>
</html>