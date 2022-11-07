<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>
	<a href="/board/insert">목록</a>
 	<form action="/board/insert" method="post">
	 	<input type="text" name="title" value="개똥이" />
	 	<input type="submit" value="입력" />
	</form>
</body>
</html>