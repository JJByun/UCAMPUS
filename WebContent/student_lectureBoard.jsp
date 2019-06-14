<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�л� �����ڷ��</title>
	<style>
        .head {position: fixed; top: 20px; left: 500px; font-size: 32px;}
        aside{ position: fixed; top: 170px; width:200px; border:3px solid black; float:left;
                  padding : 5px
        }
        .select {position: fixed; top: 150px; left: 490px;  border:3px solid black; float:left;
                  padding : 5px}
        .board  {position: fixed; top: 250px; left: 300px; width: 600px; border:3px solid black; float:left;
                  padding : 5px}
        .btn{poasition: fixed; top:20px; left:900px;}
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
	//�л��̸� ����
	String sName="";
	Connection conn=null;
	Statement stmt=null;
	String driver="oracle.jdbc.driver.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:orcl";
	Boolean connect=false;
	ResultSet rs=null;
	request.setCharacterEncoding("euc-kr"); 
	sql="select * from STUDENT";
	String str_id;//�л���ȣ ���� ����
	//�л���ȣ
	String num=request.getParameter("member_no"); 
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
			str_id=rs.getString("S_ID");
			if(str_id.equals(num))
			{
				sName=rs.getString("S_Name");
				break;
			}
		}
	}catch(Exception e)
	{
		
	}

%>
	<p class="head">���� �ڷ�</p>
	<!-- �ڷΰ��� ��ư -->
	<form action="index.html" method="get">
		<input class="btn" type="button" value="�α׾ƿ�">
	</form>	
    <aside>
        <p>
            �̸�      : <%= sName %>
            <br /><br />
            �л� ��ȣ : <%= num %>

        </p>
    </aside>

    <p class="select">
        ���� ���� :
        <select name="professor" onchange="javascript:changeClassID(this)" >
        <%
        	//����� �������
       		sql="select * from S_HAS_C, CLASS where S_ID='"+num+"' and S_HAS_C.C_ID = CLASS.C_ID";
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

        <table border="1" class="board" id ="listBoard">
            <tr>
                <th> No</th>
                <th> ����</th>
                <th>�����</th>
                <th>��ȸ��</th>
                <th>�ڼ�������</th>                
            </tr>
            <!-- ������� �Խ��� ä���ָ� �� -->
            
            <%
            	//���� �Խ��� ��������
            	sql="select * from CLASS c, LECTURE_BOARD l where c.C_ID = l.C_ID and c.C_ID='"+selectClassID+"'";
            	rs=stmt.executeQuery(sql);
            	while(rs.next())
            	{
            		String index=rs.getString("L_INDEX"); //�ε��� �������
            		String title=rs.getString("L_TITLE"); //���� �������
            		String date=rs.getString("L_DATE"); //��¥ �������
            		String cnt=rs.getString("L_CNT"); //��ȸ�� �������
            		String file=rs.getString("L_FILE"); //���� �����
					//���̺� ������ֱ�
            		%>
            		<tr>
            			<th><%=index %></th>
                		<th><%=title %></th>
                		<th><%=date %></th>
                		<th><%=cnt %></th>
                		<th>
                    		<a href="student_lecture_board_detail.html">����</a>
                		</th>
                	</tr>
            		<% 
            	}
            %>
                
            
        </table>
</body>
</html>