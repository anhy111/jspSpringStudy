<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Form Processing</title>
</head>
<body>
	<%
		// 폼 페이지에서 입력된 데이터를 서버로 전송 시 한글이 깨지지 않도록
		// 문자 인코딩 유형을 UTF-8로 함
		request.setCharacterEncoding("utf-8");
		// request 내장 객체는 웹 브라우저가 서버로 보낸 요청에 대한 정보를 담고있음
		// getParameter() 메서드를 이용하여 요청 파라미터의 값을 얻을 수 있다.
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		String name = request.getParameter("name");
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		String gender = request.getParameter("gender");
		String[] hobby = request.getParameterValues("hobby");
		String comment = request.getParameter("comment");
	%>
	<p>아이디:<%=id %></p>
	<p>비밀번호:<%=passwd %></p>
	<p>이름:<%=name %></p>
	<p>연락처:<%=phone1 %>-<%=phone2 %>-<%=phone3 %></p>
	<p>성별:<%=gender %></p>
	<p>취미:
		<%
			if(hobby != null){
				for(String str : hobby){
					out.print(" " + str);
				}
			}
		%>
	</p>
	<p>가입인사:<%=comment %></p>
</body>        
</html>