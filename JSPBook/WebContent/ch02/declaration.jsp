<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Scripting Tag</title>
</head>
<body>
	<%! 
		String str = "Hello, Java Server Pages";
		
		String getString(){
			return str;
		}
		
	%>
	<%=getString() %>
	
</body>
</html>