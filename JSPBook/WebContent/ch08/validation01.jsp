<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Validation</title>
<script type="text/javascript">
	function CheckForm() {
		let id = document.loginForm.id.value;
		let passwd = document.loginForm.passwd.value;
		
		console.log("id : " + id);
		console.log("passwd : " + passwd);
	}	
</script>
</head>
<body>
	<form name="loginForm">
		<p>아이디:<input type="text" name="id" /></p>
		<p>비밀번호 : <input type="password" name="passwd" /></p>
		<!-- CheckForm() : 핸들러 함수 -->
		<p><input type="button" value="전송" onclick="CheckForm()" /></p>
	</form>
</body>
</html>