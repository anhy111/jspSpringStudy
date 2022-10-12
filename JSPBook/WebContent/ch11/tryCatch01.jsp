<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%
		try{
		int num = 10 / 0;
		} catch(NumberFormatException e){
			RequestDispatcher dispatcher = 
				request.getRequestDispatcher("/errorBullPointer.jsp");
			// tryCatch01.jsp 실행을 멈추고, errorNullPointer.jsp를 요청
			dispatcher.forward(request, response);
		}
	%>
</body>
</html>