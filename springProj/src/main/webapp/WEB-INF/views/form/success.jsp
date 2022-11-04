<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>요청 처리</title>
</head>
<body>
	<h2>성공!</h2>
	<c:forEach var="hobby" items="${hobbyList}">
		${hobby}&nbsp;
	</c:forEach>
</body>
</html>