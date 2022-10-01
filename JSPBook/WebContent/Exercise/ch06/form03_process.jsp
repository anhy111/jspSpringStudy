<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String[] fruits = request.getParameterValues("fruit");
		String str = "";
		if(fruits != null){
			for(int i=0; i<fruits.length; i++){
				str += fruits[i] + " ";
			}
		}
	%>
	
	<h4>선택한 과일</h4>
	<p>
		<%=str %>
	</p>
</body>
</html>