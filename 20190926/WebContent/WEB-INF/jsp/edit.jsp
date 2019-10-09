<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>정보수정</title>
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
//안됨
$('#item_3').text('${data[5]}');
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