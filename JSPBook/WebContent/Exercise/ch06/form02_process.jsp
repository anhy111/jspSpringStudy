<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		Enumeration values = request.getParameterNames();
		StringBuffer sb = new StringBuffer();
		while(values.hasMoreElements()){
			String paramName = (String)values.nextElement();
			String paramValue = request.getParameter(paramName); 
			sb.append("<p>");
			sb.append(paramName + ":");
			sb.append(paramValue);
			sb.append("</p>");
		}
	%>
	
	<%=sb.toString() %>
</body>
</html>