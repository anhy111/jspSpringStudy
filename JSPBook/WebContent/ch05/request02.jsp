<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Implicit Objects</title>
</head>
<body>
	<%
		// 모든 헤더에 들어있는 이름을 가져오는 메서드
		Enumeration en = request.getHeaderNames();
	
		// Enumeration 객체 타입의 변수 en의
		// hasMoreElements() 메서드를 통해
		// 저장된 헤더 이름이 있을 떄까지 반복
		while(en.hasMoreElements()){
			// 헤더 이름을 가져옴
			String headerName = (String)en.nextElement();
			// 헤더 이름에 매핑되어 있는 값을 가져옴
			String headerValue = request.getHeader(headerName);
			
			out.print(headerName + " : " + headerValue + "<br>");
		} // end while
	%>
</body>
</html>