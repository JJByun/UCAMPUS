<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� �����ڷ��</title>
	<style>
        .head {position: fixed; top: 20px; left: 500px; font-size: 32px;}
        aside{ position: fixed; top: 170px; width:200px; border:3px solid black; float:left;
                  padding : 5px
        }
        aside2{position:fixed; top:500px; width:100px; padding:5px}
        .select {position: fixed; top: 150px; left: 490px;  border:3px solid black; float:left;
                  padding : 5px}
        .board  {position: fixed; top: 250px; left: 300px; width: 600px; border:3px solid black; float:left;
                  padding : 5px}
        .btn{poasition: fixed; top:20px; left:900px;}
        .input_form{position: fixed; top:210px; left:300px; width:500px; border:3px solid black; padding:5px;}
    </style>
    
    <script type="text/javascript">
    	//����Ʈ�ڽ� ���� �̺�Ʈ �ڵ鷯
    	function changeClassID(obj){
			var selectedID=obj.value;
    		//�����Ű��
    		var getTable=document.getElementById("listBoard");
    		getTable.innerHTML();
    	}
    </script>
</head>

<!-- body(����) -->
<body>
<%!
	String selectClassName="";
	String selectClassID="";
	String sql="";
%>
<%
	//����//////////////////////////
	//�����̸� ����
	String pName="";
	Connection conn=null;
	Statement stmt=null;
	String driver="oracle.jdbc.driver.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:orcl";
	Boolean connect=false;
	ResultSet rs=null;
	request.setCharacterEncoding("euc-kr"); 	
	String str_id;//�л���ȣ ���� ����
	//������ȣ
	String num=request.getParameter("member_no"); 
	sql="select * from P_HAS_C pc, PROFESSOR p where pc.P_ID='"+num+ "'"+ " and pc.p_ID=p.P_ID" ;
	//����/////////////////////////////////////
	
	try{
		Class.forName(driver); //����̹� ��������
		 //DB ����
		conn=DriverManager.getConnection(url,"hr2","1234");
		connect=true;	
		stmt=conn.createStatement(); //stateMent ����
		
		rs=stmt.executeQuery(sql);
		//��ȸ�ϸ鼭 �ش� ���� ã��
		while(rs.next())
		{
			str_id=rs.getString("P_ID");
			if(str_id.equals(num))
			{
				pName=rs.getString("P_NAME");
				break;
			}
		}
	}catch(Exception e)
	{
		
	}

%>
	<p class="head">�н�������</p>
	<!-- �ڷΰ��� ��ư -->
	<form action="index.html" method="get">
		<input class="btn" type="button" value="�α׾ƿ�">
	</form>	
    <aside>
        <p>
            �̸�      : <%= pName %>
            <br /><br />
            ���� ��ȣ : <%= num %>

        </p>
    </aside>
	
    <p class="select">
        ���� ���� :
        <select name="professor" onchange="javascript:changeClassID(this)" >
        <%
        	//����� �������
       		sql="select * from P_HAS_C pc, class c where pc.P_ID='"+num+ "'"+ " and pc.C_ID=c.C_ID" ;
			rs=stmt.executeQuery(sql);
			while(rs.next())
        	{
        		selectClassName=rs.getString("C_NAME");
        		selectClassID=rs.getString("C_ID");
        		%>
        		<option value=<%=selectClassID %> selected><%=selectClassName%></option>	 <!--  ����Ʈ�ڽ� ������ֱ�-->
        	<%}
        %>            
        </select>
    </p>
    <!-- �Է� ������ ���� -->
    <div class="input_form">
    	<form action="save.jsp" method="get">
			����:
				<input type="text" name="title"><br/>
			���� ����:<br/>
				<textarea rows="10" cols="25" name="text"></textarea><br/><br/>
			���� ����:
				<input type="file" name="file"><br/>
				<input type="submit" value="�ø���" name="file">
				<input type="hidden" name="C_ID" value=<%=selectClassID %>>
				<input type="hidden" name="P_ID" value=<%=num %>>
		</form>
    </div>
	
        
</body>
</html>