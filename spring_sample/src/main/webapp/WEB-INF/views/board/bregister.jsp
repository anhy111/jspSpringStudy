<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>BOARD REGISTER</title>
</head>
<body>
<h2>BOARD REGISTER : access to member</h2>
<form action="/logout" method="post">
	<button type="submit">로그아웃</button>
	<sec:csrfInput/>
</form>
</body>
</html>