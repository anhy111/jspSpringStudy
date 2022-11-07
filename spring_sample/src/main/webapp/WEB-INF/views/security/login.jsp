<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>Login</title>
</head>
<body>

<h1>Login</h1>

<!-- security에서 제공해주는 로그인 서비스를 사용하려면
	action 속성의 값은 /login
 -->
<form action="/login" method="post">
	<div>
		<input type="text" name="username" value="" />
	</div>
	<div>
		<input type="password" name="password" value="" />
	</div>
	<div>
		<input type="submit" value="로그인" />
	</div>
	
	<sec:csrfInput />
</form>

</body>
</html>





