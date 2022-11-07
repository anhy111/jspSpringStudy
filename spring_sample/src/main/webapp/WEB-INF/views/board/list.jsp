<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>list</title>
</head>
<body>
	 <a href="/board/update">개똥이</a>
	 <form action="/board/update" method="post">
	 	<input type="text" name="title" value="개똥이" />
	 	<button type="submit">변경</button>
	 </form>
	 <p><a href="/board/get?register">Register</a></p>
	 <p>
	 	<!-- /board/post?register -->
	 	<form action="/board/post" method="post">
	 		<button type="submit" name="register">Register</button>
	 	</form>
	 </p>
</body>
</html>






