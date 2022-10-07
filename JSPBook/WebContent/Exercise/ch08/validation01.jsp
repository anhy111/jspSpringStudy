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
		let pw = form.passwd.value;
		
		if(id.length == 0){
			alert("아이디를 입력해주세요")
			return;
		}
		if(pw.indexOf(id) != -1){
			alert("비밀번호는 ID를 포함할 수 없습니다.")
			return;
		}
		
		form.submit();
	}
</script>
</head>
<body>
	<form name="loginForm" action="validation01_process.jsp">
		<p>아이디 : <input type="text" name="id"></p>
		<p>비밀번호 : <input type="text" name="passwd"></p>
		<input type="button" value="전송" onclick="f_loginCheck()">
	</form>
</body>
</html>