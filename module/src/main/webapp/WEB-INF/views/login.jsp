<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Login</title>
</head>
<body>
	<form action="/login" method="post">
		<input type="text" name="name" />
		<input type="submit" value="로그인 시도">
	</form>
</body>
</html>