<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>페이지 오류</title>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
</head>
<body>
	<!-- 상품이 없을 때 보여줄 오류 페이지 -->
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h2 class="alert alert-danger">요청하신 페이지를 찾을 수 없습니다.</h2>
		</div>
	</div>
	<div class="container">
		<p><%=request.getRequestURL() %>?<%=request.getQueryString() %></p>
		<p> <a href="books.jsp" class="btn btn-secondary"> 도서 목록
			&raquo;</a></p>
	</div>
	<jsp:include page="footer.jsp"/>
</body>
</html>