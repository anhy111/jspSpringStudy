<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Cookie</title>
</head>
<body>
	<%
		Cookie[] cookies = request.getCookies();
		for(Cookie cookie : cookies){
			String name = cookie.getName();
			if(name.equals("userID")){
				String value = cookie.getValue();
				if(value == null || value.equals("")){
					response.sendRedirect("cookie_out.jsp");
					return;
				}else{
					out.print("<p>"+value+"님 반갑습니다.</p>");					
				}
			}
		}
	%>
	
	<p><a href="cookie_out.jsp">로그아웃</a></p>
</body>
</html>