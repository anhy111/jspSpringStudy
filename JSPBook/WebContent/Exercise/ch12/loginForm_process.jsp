<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Filter</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		if(id.equals("admin") && pw.equals("admin1234")){
			response.sendRedirect("/Exercise/ch12/loginForm_success.jsp");
		} else{
			out.write("로그인 실패");
		}
	%>
</body>
</html>