<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>formHome</title>
</head>
<body>
	<!-- form 태그의 기본 method는 get -->
 <form action="/board/register">
 	<input type="submit" value="register(GET)" />
 </form>
 <form action="/board/register" method="post">
 	<input type="submit" value="register(POST)" />
 </form>
</body>
</html>




