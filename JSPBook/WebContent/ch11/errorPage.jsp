<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@ page errorPage="errorPage_error.jsp" %> --%>
<!-- errorPage.jsp 가 실행 중 오류 발생 시 errorPage_error.jsp를 요청 -->
<!DOCTYPE html>
<html>
<head>
<title>Exception</title>
</head>
<body>
	name : <%=request.getParameter("name").toUpperCase() %>
</body>
</html>