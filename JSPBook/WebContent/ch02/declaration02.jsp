<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Scripting Tag</title>
</head>
<body>
	<%!	// 선언문
		// 전역 메서드
		// a, b : 매게변수(파라미터를 받는 변수)
		int sum(int a, int b){
		return a + b;
	}
	%>
	
	<%	// 스크립틀릿 태그
		// 여기서 선언된 sum() 메서드는 선언문 태그에 선언된 전역 메서드인
		// sum()을 호출
		out.println("2 + 3 = " + sum(2,3));
	%>
</body>
</html>