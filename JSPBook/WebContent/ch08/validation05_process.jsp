<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Validation</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	%>
	<p>아이디: <%=request.getParameter("id") %></p>
	<p>비밀번호: <%=request.getParameter("passwd") %></p>
	<p>이름: <%=request.getParameter("name") %></p>
	<p>연락처: <%=request.getParameter("phone1") %> -
			<%=request.getParameter("phone2")%> -
			<%=request.getParameter("phone3") %></p>
	<p>이메일: <%=request.getParameter("email") %></p>
</body>
</html>