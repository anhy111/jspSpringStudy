<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Session</title>
</head>
<body>
	<%
		// long 타입의 시간 값을 date로 변환
		Date time = new Date();
		// Date 객체의 시간 값을 지정한 양식으로 출력하기 위해 포맷형식 지정
		DateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	%>
	<p>세션id : <%=session.getId() %></p>
	<%
		time.setTime(session.getCreationTime());
	%>
	<p>세션생성시간 : <%=formatter.format(time) %></p>
	<%
		time.setTime(session.getLastAccessedTime());
	%>
	<p>최근접근시간 : <%=formatter.format(time) %>
</body>
</html>