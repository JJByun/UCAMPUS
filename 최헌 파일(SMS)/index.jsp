<%@ page contentType="text/html; charset=UTF-8" %>

<html>

<head>
  <title>sms 보내기 </title>
</head>

<body onload="loadJSON()">
<form method="post" name="smsForm" action="smssend.jsp">
  <input type="hidden" name="action" value="go">
  <textarea name="msg" cols="30" rows="10" style="width:455px;" placeholder="보낼 내용"></textarea>
  <br>
  <br />받는 번호
  <input type="hidden" name="sphone1" value="010">
  <input type="hidden" name="sphone2" value="7310">
  <input type="hidden" name="sphone3" value="1995">
  <input type="submit" value="전송">
  <br/>
</form>
</body>

</html>
