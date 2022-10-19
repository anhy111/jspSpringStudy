<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Cookie</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		if(id.equals("admin") && pw.equals("admin1234")){
			Cookie cookie = new Cookie("userID",id);
			response.addCookie(cookie);
		} else {
			Cookie cookie = new Cookie("userID",null);
			response.addCookie(cookie);
		}
		response.sendRedirect("welcome.jsp");
	%>
</body>
</html>