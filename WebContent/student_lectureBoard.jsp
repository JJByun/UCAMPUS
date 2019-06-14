<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>학생 강의자료실</title>
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
	//학생이름 변수
	String sName="";
	Connection conn=null;
	Statement stmt=null;
	String driver="oracle.jdbc.driver.OracleDriver";
	String url="jdbc:oracle:thin:@localhost:1521:orcl";
	Boolean connect=false;
	ResultSet rs=null;
	request.setCharacterEncoding("euc-kr"); 
	sql="select * from STUDENT";
	String str_id;//학생번호 저장 변수
	//학생번호
	String num=request.getParameter("member_no"); 
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
	<p class="head">강의 자료</p>
	<!-- 뒤로가기 버튼 -->
	<form action="index.html" method="get">
		<input class="btn" type="button" value="로그아웃">
	</form>	
    <aside>
        <p>
            이름      : <%= sName %>
            <br /><br />
            학생 번호 : <%= num %>

        </p>
    </aside>

    <p class="select">
        교수 선택 :
        <select name="professor" onchange="javascript:changeClassID(this)" >
        <%
        	//과목명 갖고오기
       		sql="select * from S_HAS_C, CLASS where S_ID='"+num+"' and S_HAS_C.C_ID = CLASS.C_ID";
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

        <table border="1" class="board" id ="listBoard">
            <tr>
                <th> No</th>
                <th> 제목</th>
                <th>등록일</th>
                <th>조회수</th>
                <th>자세히보기</th>                
            </tr>
            <!-- 여기부터 게시판 채워주면 됨 -->
            
            <%
            	//과목 게시판 가져오기
            	sql="select * from CLASS c, LECTURE_BOARD l where c.C_ID = l.C_ID and c.C_ID='"+selectClassID+"'";
            	rs=stmt.executeQuery(sql);
            	while(rs.next())
            	{
            		String index=rs.getString("L_INDEX"); //인덱스 갖고오기
            		String title=rs.getString("L_TITLE"); //제목 갖고오기
            		String date=rs.getString("L_DATE"); //날짜 갖고오기
            		String cnt=rs.getString("L_CNT"); //조회수 갖고오기
            		String file=rs.getString("L_FILE"); //파일 갖고오
					//테이블 만들어주기
            		%>
            		<tr>
            			<th><%=index %></th>
                		<th><%=title %></th>
                		<th><%=date %></th>
                		<th><%=cnt %></th>
                		<th>
                    		<a href="student_lecture_board_detail.html">보기</a>
                		</th>
                	</tr>
            		<% 
            	}
            %>
                
            
        </table>
</body>
</html>