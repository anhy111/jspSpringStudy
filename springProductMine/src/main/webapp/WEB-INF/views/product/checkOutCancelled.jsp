<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/bootstrap.min.css" />
<title>주문 취소</title>
</head>
<body>
	<!-- include 액션 태그 -->
	<jsp:include page="menu.jsp" />
	
	<div class="jumbotron">
		<!-- container : 이 안에 내용있다 -->
		<div class="container">
			<h1 class="display-3">주문 취소</h1>
		</div>
	</div>
	
	<!-- -----------주문 취소 내용 시작 ------------------- -->
	<%
	//기존 세션 제거 후 새로 생성
	session.invalidate();
	%>
	<div class="container">
		<h2 class="alert alert-danger">주문이 취소되었습니다.</h2>
	</div>
	<div class="container">
		<p><a href="/products" class="btn btn-secondary">&laquo;상품 목록</a></p>
	</div>
	
	<!-- -----------주문 취소 내용 끝 ------------------- -->
	
	<jsp:include page="footer.jsp" />
</body>
</html>



