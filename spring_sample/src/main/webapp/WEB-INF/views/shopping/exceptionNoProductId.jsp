<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/bootstrap.min.css" />
<title></title>
</head>
<body>

	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<!-- container : 이 안에 내용있다 -->
		<div class="container">
			<h1 class="display-3">해당 상품이 존재하지 않습니다.</h1>
		</div>
	</div>
	
	<!-- ----------------오류 처리 내용 시작 ----------------------- -->
	<div class="container">
		<!-- getRequestURL() : http://localhost/product.jsp -->
		<!-- getQueryString() : id=P1234 -->
		<p><%=request.getRequestURL()%>?<%=request.getQueryString()%></p>
		<p><a href="products.jsp" class="btn btn-secondary">상품 목록&raquo;</a>
	</div>
	<!-- ----------------오류 처리 내용 끝 ----------------------- -->
	
	<jsp:include page="footer.jsp" />

</body>
</html>




