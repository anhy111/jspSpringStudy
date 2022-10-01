<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Implicit Objects</title>
</head>
<body>
<%
	// 문자 인코딩 설정
	response.setCharacterEncoding("UTF-8");
	// 콘텐츠 유형 설정
	response.setContentType("text/html; charset=utf-8");
	
	// 404코드 응답
	response.sendError(404,"개똥이 오류!");
%>
	<p>문자 인코딩 : <%=response.getCharacterEncoding() %></p>
	<p>콘텐츠 유형 : <%=response.getContentType() %></p>
</body>
</html>