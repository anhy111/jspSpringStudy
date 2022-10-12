<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<title>Exception</title>
</head>
<body>
<div style="width: 100%; text-align: center;">
	<img src="/resources/images/500.png" style="width: 50%" />
	<p>예외 정보 : <%=exception %></p>
	<p>예외 객체 타입 : <%=exception.toString() %></p>
	<p>예외 객체 타입 : <%=exception.getClass().getName() %></p>
	<p>오류 메시지 : <%=exception.getMessage() %></p>
</div>
</body>
</html>