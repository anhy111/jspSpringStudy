<%@page import="java.io.PrintWriter"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page isErrorPage="true" %>
<!-- 현재 JSP 페이지에 오류가 발생 시 오류 페이지로 이동 -->
<!DOCTYPE html>
<html>
<head>
<title>Directives Tag</title>
</head>
<body>
	<h4>errorPage 디렉티브 태그</h4>
	에러가 발생했습니다.
	<%= exception %>
</body>
</html>