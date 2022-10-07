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
		
	
		var regExpSpc = /[?=.*[!@#$%^*+=-]+/;
		var regExpEng = /[a-zA-z]+/;
		var regExpNum = /[0-9]+/;
		
		if(pw.length <= 8){
			alert("영문+숫자+특수기호 8자리 이상으로 구성하여야 합니다.");
			return;
		}
		
		if(!regExpSpc.test(pw) || !regExpEng.test(pw) || !regExpNum.test(pw)){
			alert("영문+숫자+특수기호 8자리 이상으로 구성하여야 합니다.");
			return;
		}
 		alert("성공");
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