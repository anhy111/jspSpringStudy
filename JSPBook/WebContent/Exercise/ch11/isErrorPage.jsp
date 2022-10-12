<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<table border="1px" style="text-align: left;">
		<tr>
			<th>Error:</th>
			<td><%=exception.toString() + ": 오류 발생!!!" %></td>
		</tr>
		<tr>
			<th>URI:</th>
			<td><%=request.getRequestURL() %></td>
		</tr>
		<tr>
			<th>Status code:</th>
			<td><%=response.getStatus() %></td>
		</tr>
	</table>
</body>
</html>