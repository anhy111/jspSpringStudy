<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Form Processing</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>요청 파라미터 이름</th>
			<th>요청 파라미터 값</th>
		</tr>
		<%!
			String arrToStr(String[] arr){
				String str = "";
				if(arr != null){
					for(String s : arr){
						str += " " + s;
					}
				}
				return str;
			}
		%>
		<%
			request.setCharacterEncoding("utf-8");
			
			// getParameterNames() : 모든 입력 양식의 요청 파라미터 이름을
			// 순서에 상관없이 Enumeration(열거형) 형태로 전달받음
			Enumeration paramNames = request.getParameterNames();
			
			while(paramNames.hasMoreElements()){
				// nextElement() : 열거형 요소를 반환해줌
				// 폼 페이지에서 전송된 요청 파라미터의 이름을 가져옴
				String name = (String)paramNames.nextElement();
				// 취미의 경우 String[] 형태로 처리해야 함
				String paramValue = "";
				if(name.equals("hobby")){
					String[] paramVales = request.getParameterValues(name);
					paramValue = arrToStr(paramVales);
				} else {
					paramValue = request.getParameter(name);					
				}
				
				out.print("<tr><td>" + name + "</td><td>"+paramValue+"</td></tr>");
			}
		%>
	</table>
</body>
</html>