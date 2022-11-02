<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
</head>
<body>
	<h2>load된 사진</h2>
	<c:forEach var="img" items="${data}">
		<img alt="" src="/resources/upload/${img.filename}.png"><br>
	</c:forEach>
</body>
</html>