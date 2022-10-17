<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Session</title>
<script type="text/javascript">
</script>
</head>
<body>
	<%
		String id = (String)session.getAttribute("userID");
	
		if(id == null || id.trim().equals("")){
			response.sendRedirect("session_out.jsp");
		}
	%>
	<p><%=id%>님 반갑습니다.</p>
	<a href="session.jsp">로그아웃</a>
</body>
</html>