<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Implicit Objects</title>
</head>
<body>
	<!-- *** 웹 브라우저의 IP 주소를 가져옴 -->
	<p>클라이언트 IP : <%=request.getRemoteAddr() %></p>
	<p>요청 정보 길이 : <%=request.getContentLength() %></p>
	<p>요청 정보 인코딩 : <%=request.getCharacterEncoding() %></p>
	<p>요청 정보 콘텐츠 유형 : <%=request.getContentType() %></p>
	<p>요청 정보 프로토콜 : <%=request.getProtocol() %></p>
	<p>요청 정보 전송방식 : <%=request.getMethod() %></p>
	<!-- 웹페이지를 요청한 URI를 가져옴 -->
	<p>요청 URI : <%=request.getRequestURI() %></p>
	<!--  ******* 현재 JSP 페이지의 웹 애플리케이션 콘텍스트 경로를 가져옴 -->
	<p>컨텍스트 경로 : <%=request.getContextPath() %></p>
	<p>서버 이름 : <%=request.getServerName() %></p>
	<p>서버 포트 : <%=request.getServerPort() %></p>
	<p>쿼리문 : <%=request.getQueryString() %></p>
</body>
</html>