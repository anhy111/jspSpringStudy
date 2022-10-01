<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<%@include file="header.jsp" %>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	현재 시간 : <%=Calendar.getInstance().getTime() %>
</body>
</html>