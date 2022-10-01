<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Scripting Tag</title>
</head>
<body>
	<%!	// 선언문 태그
		String makeItLower(String arg){
			return arg.toLowerCase();
	}
	%>
	
	<%	// 스크립틀릿 태그
		// 선언된 전역메서드인 makeItLower()를 호출해 소문자 출력 
		out.println(makeItLower("Hello World"));
	%>
</body>
</html>