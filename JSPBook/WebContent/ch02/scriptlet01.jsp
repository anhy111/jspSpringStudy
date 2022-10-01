<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Scripting Tag</title>
</head>
<body>
	<%	// 스크립틀릿
		int a = 2;
		int b = 3;
		int sum = a + b;
		out.println("2 + 3 = " + sum);
	%>
	<hr>
	<%
		// 지역변수 a, b를 1씩 증가시킴
		a++;
		b++;
		sum = a + b;
		out.println("3 + 4 = " + sum);
	%>
</body>
</html>