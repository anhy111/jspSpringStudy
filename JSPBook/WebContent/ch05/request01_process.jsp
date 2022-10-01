<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Implicit Objects</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String userId = request.getParameter("name");
	String password = request.getParameter("passwd");
%>
	<p>아이디 : <%=userId%></p>
	<p>비밀번호 : <%=password%></p>
</body>
</html>