<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script type="text/javascript">
	function checkLogin() {
		const form = document.loginForm;
		
		console.log("form의 타입 : " + typeof(form));
		if(form.id.value == ""){
			alert("아이디를 입력해주세요");
			return false;
		} else if(form.passwd.value == ""){
			alert("비밀번호를 입력해 주세요");
			form.passwd.focus();
			return false;
		}
		form.submit();
	}
</script>
</head>
<body>
	<form action="validation02_process.jsp" name="loginForm" method="post">
		<p>아이디 : <input type="text" name="id"></p>
		<p>비밀번호 : <input type="password" name="passwd"></p>
		<p><input type="button" value="전송" onclick="checkLogin()"></p>
	</form>
</body>
</html>