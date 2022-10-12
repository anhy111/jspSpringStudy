<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Security</title>
</head>
<body>
	<!-- j_security_check : 우리는 목적지가 이미 있음 . 
		폼 기반 인증 처리(로그인) 처리 action 속성 값 
		로그인 인증
		권한이 있는가
		-->
	<form name="loginForm" action="j_security_check" method="post">
		<p>사용자명 : <input type="text" name="j_username"/></p>
		<p>비밀번호 : <input type="password" name="j_password"></p>
		<p><input type="submit" value="전송"></p>		
	</form>
</body>
</html>