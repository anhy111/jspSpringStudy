<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Filter</title>
</head>
<body>
	<form action="loginForm_process.jsp" method="post">
		<p>아 이 디 : <input type="text" name="id"></p>
		<p>비밀번호 : <input type="text" name="pw"></p>
		<p><input type="submit" value="전송"></p>
	</form>
</body>
</html>