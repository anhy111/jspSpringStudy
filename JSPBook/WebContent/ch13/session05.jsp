<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Session</title>
</head>
<body>
	<%
		String name;
		String value;
		
		Enumeration en = session.getAttributeNames();
		int i = 0;
		
		while(en.hasMoreElements()){
			i++;
			name = en.nextElement().toString();
			value = session.getAttribute(name).toString();
			out.println("설정된 세션의 속성 이름 [ " +  i + " ] : " + name + "<br>");
			out.println("설정된 세션의 속성 값 [ " +  i + "] : " + value + "<br>");
		}
		
		session.removeAttribute("userID");
	%>
	<h4>-------- 세션을 삭제한 후 -------</h4>
	<%
		en = session.getAttributeNames();
	
		i = 0;
		
		while(en.hasMoreElements()){
			i++;
			name = en.nextElement().toString();
			value = session.getAttribute(name).toString();
			out.println("설정된 세션의 속성 이름 [ " +  i + " ] : " + name + "<br>");
			out.println("설정된 세션의 속성 값 [ " +  i + "] : " + value + "<br>");
	}
		
	%>
</body>
</html>