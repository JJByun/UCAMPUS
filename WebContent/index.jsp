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
		Class.forName(driver); //����̹� ��������
		conn=DriverManager.getConnection(url,"hr2","1234"); //DB ����
		connect=true;	
		stmt=conn.createStatement(); //stateMent ����
		String sql="";
		if(select_code.equals("11")) //�л� �α���
		{
			sql="select * from STUDENT";
		}
		else if(select_code.equals("21")) //���� �α���
		{
			sql="select * from PROFESSOR";
		}
		 
		String result="";
		rs=stmt.executeQuery(sql);
		while(rs.next()){ 
			String str_id=""; 
			String str_pw="";
			if(select_code.equals("11")) //�л�
			{
				str_id=rs.getString("S_ID");
				str_pw=rs.getString("S_PW");
				if(num.equals(str_id)&& pw.equals(str_pw))
				{
					result="�α��� ����!";%>
					<jsp:forward page="student_lectureBoard.jsp"/>
					<% break;
				}

			}
			else if(select_code.equals("21")) //����
			{
				str_id=rs.getString("P_ID");
				str_pw=rs.getString("P_PW");
				if(num.equals(str_id)&& pw.equals(str_pw))
				{
					result="�α��� ����!";%>
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
			alert("��ġ�ϴ� ���̵� �����ϴ�");
			
	</script>

</body> 
</html>