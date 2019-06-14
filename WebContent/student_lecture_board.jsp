<!DOCTYPE html>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <title>강의자료</title>
    <style>
        .head {position: fixed; top: 50px; left: 500px; font-size: 32px;}
        aside{ position: fixed; top: 250px; width:200px; border:3px solid black; float:left;
                  padding : 5px
        }
        .select {position: fixed; top: 250px; left: 490px;  border:3px solid black; float:left;
                  padding : 5px}
        .board  {position: fixed; top: 350px; left: 300px; width: 600px; border:3px solid black; float:left;
                  padding : 5px}
    </style>
</head>
<body>
    <p class="head">강의 자료</p>

    <aside>
        <p>
            이름      : 최헌
            <br /><br />
            학생 번호 : 2014726080

        </p>
    </aside>

    <p class="select">
        교수 선택 :
        <select name="professor" >
            <option value="" selected>교수 선택</option>

        </select>
    </p>

    
        <table border="1" class="board">
            <tr>
                <th> No</th>
                <th> 제목</th>
                <th>등록일</th>
                <th>조회수</th>
                <th>자세히보기</th>                
            </tr>
            <tr>
                <th>1</th>
                <th> chapter1</th>
                <th>2019.01.03</th>
                <th>32</th>
                <th>
                    <a href="student_lecture_board_detail.html">다운로드</a>
                </th>
                
            </tr>
        </table>

</body>
</html>