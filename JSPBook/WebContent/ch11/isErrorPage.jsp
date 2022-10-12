<%@ page contentType="text/html; charset=UTF-8"%>
<%-- <%@page errorPage="isErrorPage_error.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
<title>Exception</title>
</head>
<body>
	name : <%= request.getParameter("name").toUpperCase() %>
</body>
</html>