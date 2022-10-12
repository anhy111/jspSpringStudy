<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Security</title>
</head>
<body>
	<h3>프로그래밍적 시큐리티 처리</h3>
	<p>
		웹 어플리케이션 (JSPBook 프로젝트)의 보안을 위해 코드를 작성하여
		사용자의 권한 부여를 처리하는 방식
	</p>
	<p>
		선언적 시큐리티(tomcat-users.xml + web.xml)의 보안으로 
		충분하지 않을 때 request 내장 객체의 메소드를 사용하여 사용자를 승인
	</p>
	<p>사용자 ID : <%=request.getRemoteUser() %></p>
	<!-- .getAuthType() : BASIC / FORM -->
	<p>인증방법 : <%=request.getAuthType() %></p>
	<p>인증한 사용자가 tomcat role에 속하는지?
		<%=request.isUserInRole("tomcat") %>
		<%
		if(request.isUserInRole("tomcat")){
			out.print("<a href='/ch06/addProduct.jsp'>상품등록</a>");
		}
		%>
	</p>
	<p>인증한 사용자가 role1  role에 속하는지?
		<%=request.isUserInRole("role1") %>
	</p>
</body>
</html>