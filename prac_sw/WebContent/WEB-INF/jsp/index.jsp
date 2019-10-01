<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" charset="UTF-8">
$(function() {
	$('#btn').click(function(){
		alert("!");
		$.ajax({
			url:'getData',
			success : function(data){
				console.log(data);
				//console.log(Object.keys(data)[0]);
			},error : function(){
				alert("error");
			}
		});
	});
});
</script>
</head>
<body>
index...
<button id="btn">값 가져오기</button>
</body>
</html>