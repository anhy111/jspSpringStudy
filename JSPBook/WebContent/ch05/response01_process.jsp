<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Implicit Objects</title>
</head>
<body>
	<% 
		//1) 폼 페이지에서 입력한 한글을 처리해보자
		request.setCharacterEncoding("UTF-8");
		//2) 입력된 아이디와 비밀번호를 폼 문으로부터 전송받음(request객체)
		String userid = request.getParameter("id");
		String password = request.getParameter("passwd"); 
		//3) 폼 문으로부터 전송받은 아이디와 비밀번호가 일치시 response01_success.jsp로 이동
		if(userid.equals("개똥이") && password.equals("1234")){
			response.sendRedirect("response01_success.jsp");
		} else{
		//4) 불일치시 -> response01_failed.jsp로 이동
			response.sendRedirect("response01_failed.jsp");
		}
	%>
</body>
</html>