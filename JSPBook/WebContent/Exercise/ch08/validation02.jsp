<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Validation</title>
<script type="text/javascript">
	function f_loginCheck() {
		let form = document.loginForm;
		let id = form.id.value;
		let pw = form.pw.value;
		let pwCheck = form.pwCheck.value;
		
		var regExpPw = /(.)\1{2}/;
		if(regExpPw.test(pw)){
			alert("영문, 숫자는 3자 이상 연속 입력할 수 없습니다.");
			return;
		}
// 		form.submit();
	}
</script>
</head>
<body>
	<form name="loginForm" >
		<p>아이디 : <input type="text" name="id"></p>
		<p>비밀번호 : <input type="text" name="pw"></p>
		<p>비밀번호 확인 : <input type="text" name="pwCheck"></p>
		<input type="button" value="전송" onclick="f_loginCheck()">
	</form>
</body>
</html>