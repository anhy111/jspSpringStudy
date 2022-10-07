<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Validation</title>
</head>
<body>
	<h3>입력 성공!</h3>
	<%
		// request : JSP와 톰켓과 서블릿에서 제공해주는 내장 객체
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
	%>
	<p>아이디 : <%=id %></p>
	<p>비밀번호 : <%=passwd %></p>
</body>
</html>