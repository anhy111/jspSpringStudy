<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Implicit Objects</title>
</head>
<body>
	<%
		response.setHeader("Refresh", "5");
		SimpleDateFormat sdf = 
					new SimpleDateFormat("h:mm:ss a", Locale.ENGLISH);

	%>
	<p>현재 시간은 <%=sdf.format(Calendar.getInstance().getTime())%></p>
	<p><a href="response_data.jsp">Google 홈페이지로 이동하기</a></p>
</body>
</html>