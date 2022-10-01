<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Scripting Tag</title>
</head>
<body>
	<%!	// 선언문
		// 변수 data에 50을 할당(저장)
		int data = 50;
	%>
	
	<%	// 스크립틀릿 태그
		// out : JSP 내장 객체(그냥 주어짐).
		// 변수 data는 선언문 태그에 선언된 전역변수 값 50에 해당함.
		out.println("Value of the variable is : " + data);
	%>
</body>
</html>