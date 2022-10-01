<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Scripting Tag</title>
</head>
<body>
	<%	// 스크립틀릿
		// 0부터 10까지의 짝수를 출력하도록 스크립틀릿 태그를 작성해보자
		for(int i=0; i<=10; i++){
			if(i % 2 == 0){
				// out : 내장 객체
				// println() 메서드 => 개행 잘 안됨
				out.println(i + "<br />");
			}
		}
	%>
	
</body>
</html>