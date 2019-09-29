<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>회원가입</title>
<!-- 자바스크립트 사용위해서 -->
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- MATERIAL DESIGN ICONIC FONT -->
<link rel="stylesheet"
	href="././resources/fonts/material-design-iconic-font/css/material-design-iconic-font.min.css">
<!-- STYLE CSS -->
<link rel="stylesheet" href="././resources/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" charset="UTF-8">
var items = {//enum
	'firstname' : 0,'lastname' : 1,'username' : 2,
	'email' : 3,'gender' : 4,'pwd' : 5,
	'cpwd' : 6
};
var size = Number(Object.keys(items).length);//enum size
var obj = null;
function listToObj(array){
	obj={};
	for(let i = 0; i < size; i++){
		obj[Object.keys(items)[i]]=array[i].val();
		console.log(Object.keys(obj)[i]+" , "+Object.values(obj)[i]);
	}
}
function insertToDB(obj){
	console.log(obj);
	if(obj != null){
		$.ajax({
			type : 'POST',
			url : 'insert',
			data : obj,
			success :function(data){
				switch(data)
				{
				case 'ok':
					alert("회원가입이 완료되었습니다!");
					location.reload();
					obj=null;
					break;
				case 'dup_username':
					alert("username 중복입니다.");
					break;
				case 'dup_email':
					alert("email 중복입니다.");
					break;
				default:
					alert("예기치 못한 오류입니다.");
				}
			}
		})
	}
}
$(function() {
	$('#btn').click(function() {
		var arr = new Array();
		for (let i = 0; i < size; i++) {
			arr[i] = $('#item_' + i);
			//빈칸이 있는지
			if(arr[i].val() =='' || arr[i].val() ==null){
				alert(arr[i].attr('placeholder')+' 항목을 입력해 주세요.');
				return false;
			}
			//@를 포함하는지
			if(i==items.email && !arr[i].val().includes('@')){
				alert('Email은 mail@xxx.xxx 형식으로 입력해 주세요.');
				return false;
			}
		}
		//비밀번호 재확인이 틀리다면
		if (arr[items.pwd].val() != arr[items.cpwd].val()) {
			alert("Confirm Password 패스워드가 틀립니다.");
			return false;
		} else {
			alert("ajax로 값 저장");
			listToObj(arr);
			insertToDB(obj);
			//회원가입 완료. 메인페이지로 넘어가던가 마이페이지로 넘어가기
		}
	});
});
</script>
</head>
<div class="wrapper"
	style="background-image: url('././resources/images/bg-registration-form-1.jpg');">
	<div class="inner">
		<div class="image-holder">
			<img src="././resources/images/registration-form-1.jpg" alt="">
		</div>
		<form id="f" method="post" onsubmit="return false;">
			<h3>Registration Form</h3>
			<div class="form-group">
				<input type="text" name="fisrtname" id="item_0"
					placeholder="First Name" class="form-control"> <input
					type="text" name="lastname" id="item_1" placeholder="Last Name"
					class="form-control">
			</div>
			<div class="form-wrapper">
				<input type="text" name="username" id="item_2"
					placeholder="Username" class="form-control"> <i
					class="zmdi zmdi-account"></i>
			</div>
			<div class="form-wrapper">
				<input type="text" name="email" id="item_3"
					placeholder="Email Address" class="form-control"> <i
					class="zmdi zmdi-email"></i>
			</div>
			<div class="form-wrapper">
				<select placeholder="Gender" name="gender" id="item_4" class="form-control">
					<option value="" disabled selected>Gender</option>
					<option value="male">Male</option>
					<option value="femal">Female</option>
					<option value="other">Other</option>
				</select> <i class="zmdi zmdi-caret-down" style="font-size: 17px"></i>
			</div>
			<div class="form-wrapper">
				<input type="password" name="pwd" id="item_5" placeholder="Password"
					class="form-control"> <i class="zmdi zmdi-lock"></i>
			</div>
			<div class="form-wrapper">
				<input type="password" name="cpwd" id="item_6"
					placeholder="Confirm Password" class="form-control"> <i
					class="zmdi zmdi-lock"></i>
			</div>
			<button id="btn">
				Register <i class="zmdi zmdi-arrow-right"></i>
			</button>
		</form>
	</div>
</div>

</body>
<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>