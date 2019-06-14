<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>교수 강의자료실</title>
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
    	//셀렉트박스 변경 이벤트 핸들러
    	function changeClassID(obj){
			var selectedID=obj.value;
    		//변경시키기
    		var getTable=document.getElementById("listBoard");
    		getTable.innerHTML();
    	}
    </script>
</head>

<!-- body(본문) -->
<body>
<%!
	String selectClassName="";
	String selectClassID="";
	String sql="";
%>
<%
	//변수//////////////////////////
	//교수이름 변수
	String pName="";
	Connection conn=null;
	Statement stmt=null;
	String driver="oracle.jdbc.driver.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:orcl";
	Boolean connect=false;
	ResultSet rs=null;
	request.setCharacterEncoding("euc-kr"); 	
	String str_id;//학생번호 저장 변수
	//교수번호
	String num=request.getParameter("member_no"); 
	sql="select * from P_HAS_C pc, PROFESSOR p where pc.P_ID='"+num+ "'"+ " and pc.p_ID=p.P_ID" ;
	//변수/////////////////////////////////////
	
	try{
		Class.forName(driver); //드라이버 가져오기
		 //DB 연결
		conn=DriverManager.getConnection(url,"hr2","1234");
		connect=true;	
		stmt=conn.createStatement(); //stateMent 생성
		
		rs=stmt.executeQuery(sql);
		//순회하면서 해당 정보 찾기
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
	<p class="head">학습지원실</p>
	<!-- 뒤로가기 버튼 -->
	<form action="index.html" method="get">
		<input class="btn" type="button" value="로그아웃">
	</form>	
    <aside>
        <p>
            이름      : <%= pName %>
            <br /><br />
            교수 번호 : <%= num %>

        </p>
    </aside>
	
    <p class="select">
        과목 선택 :
        <select name="professor" onchange="javascript:changeClassID(this)" >
        <%
        	//과목명 갖고오기
       		sql="select * from P_HAS_C pc, class c where pc.P_ID='"+num+ "'"+ " and pc.C_ID=c.C_ID" ;
			rs=stmt.executeQuery(sql);
			while(rs.next())
        	{
        		selectClassName=rs.getString("C_NAME");
        		selectClassID=rs.getString("C_ID");
        		%>
        		<option value=<%=selectClassID %> selected><%=selectClassName%></option>	 <!--  셀렉트박스 만들어주기-->
        	<%}
        %>            
        </select>
    </p>
    <!-- 입력 데이터 저장 -->
    <div class="input_form">
    	<form action="save.jsp" method="get">
			제목:
				<input type="text" name="title"><br/>
			본문 내용:<br/>
				<textarea rows="10" cols="25" name="text"></textarea><br/><br/>
			파일 저장:
				<input type="file" name="file"><br/>
				<input type="submit" value="올리기" name="file">
				<input type="hidden" name="C_ID" value=<%=selectClassID %>>
				<input type="hidden" name="P_ID" value=<%=num %>>
		</form>
    </div>
	
        
</body>
</html>