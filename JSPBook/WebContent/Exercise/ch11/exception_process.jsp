<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page errorPage="exception_error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Exception</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		if(id.equals("") || pw.equals("")){
			throw new ServletException("요청 파라미터 값이 없습니다.");
		}
	%>
	<p>아이디:<%=id%></p>
</body>
</html>