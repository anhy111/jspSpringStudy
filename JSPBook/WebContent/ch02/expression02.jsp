<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%!
		int a = 10,
			b = 20,
			c = 30;
	%>
	<!-- 스크립틀릿 태그에 선언한 변수a(10), b(20), c(30)
		의 값을 출력하도록 표현문 태그를 작성함 -->
	<%= a + b + c %>
	
</body>
</html>