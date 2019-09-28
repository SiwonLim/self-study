<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<!-- 자바스크립트 사용위해서 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
$(function()
{
	$('#button').click(function(){
		var id= $('#id').val();
		var pwd= $('#pwd').val();
		var name= $('#name').val();
		var mdate= $('#mdate').val();
		$.ajax({
			type : "POST",
			url : "signIn",
			data : {"id":id,"pwd":pwd,"name":name,"mdate":mdate},
			success : function(data)
			{
				console.log(data);
				if(data=="ok")
					alert("성공");
				else
					alert("실패");
			}
		})
	});
});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	ID <input type="text" name="id" id="id"><br>
	PWD <input type="text" name="pwd" id="pwd"><br>
	NAME <input type="text" name="name" id="name"><br>
	DATE <input type="text" name="mdate" id="mdate"><br>
	<button type="button" id="button">회원 가입</button>
</body>
</html>