<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Session</title>
</head>
<body>
	<!-- 
		session기본(내장) 객체
		1. 세션을 사용한다는 것은 session 기본 객체를 사용한다는 의미
		2. session 객체는 속성(attribute)을 제공함
			- setAttribute() : 속성에 값 set 메서드
			- getAttribute() : 속성의 값 get 메서드
		3. 웹 브라우저(크롬, 엣지, 파이어폭스, 웨일, 오페라)마다 별도의 세션을 갖는다.
		4. 웹 브라우저마다 각 세션을 구분하기 위해 세션마다 고유 ID를 할당(세션ID)
			- session.getId() : 세션의 고유 ID를 구함
		5.
			1) 웹 서버(톰캣)는 웹 브라우저(크롬)에 세션ID를 전송
			2) 웹 브라우저는 웹 서버에 요청시 마다 매번 세션ID를 보내서(쿠키에 넣어서)
				웹 서버(톰캣)가 어떤 세션(웹 브라우저)를 사용할지 판단할 수 있게 함
		6. 웹 서버(톰캣)는 세션ID를 이용하여 웹 브라우저를 위한 세션을 찾음
			세션ID를 공유하기 위해 쿠키를 사용함(JSESSIONID)
			JSESSIONID 쿠키가 세션 ID를 공유할 때 사용하는 쿠키임
	 -->
	<%
		String name;
		String value;
		
		Enumeration en = session.getAttributeNames();
		int i = 0;
		
		while(en.hasMoreElements()){
			i++;
			name = en.nextElement().toString();
			value = session.getAttribute(name).toString();
			
			out.println("설정된 세션의 속성 이름 [ " +  i + " ] : " + name + "<br>");
			out.println("설정된 세션의 속성 값 [ " +  i + "] : " + value + "<br>");
		}
		
	%>
</body>
</html>