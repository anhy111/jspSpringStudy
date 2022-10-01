<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		String addr = request.getParameter("address");
		String email = request.getParameter("email");		
		StringBuffer sb = new StringBuffer();
		sb.append("<p>아이디:" + name + "</p>");
		sb.append("<p>주소:" + addr + "</p>");
		sb.append("<p>이메일:" + email + "</p>");
	%>
	
	<%=sb.toString() %>
</body>
</html>