<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<!--	scope : 영역
		page(동일 jsp)(기본), request(동일 요청), session(동일 웹브라우저), application(모든 웹브라우저) 

 -->
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 목록</title>
</head>
<body>
<!-- 머리글에 해당하는 menu.jsp파일의 내용을 포함하도록 include 액션태그 작성 -->
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품목록</h1>
		</div>
	</div>
<!-- ========================= 상품목록 시작 =================================== -->
	<div class="container">
		<div class="row" style="justify-content: right;margin:0 0 30px 0;"> 
			<a href="/addProduct" class="btn btn-primary">상품추가</a>
		</div>
		<div class="row" align="center">
			<!-- List<ProductVO> 한 행을 꺼내오면 ProductVO -->
				<div class="col-md-4">
					<h3></h3>
					<p></p>
					<p></p>
					<!-- 상품 아이디에 대한 상세 정보 페이지가 연결되도록 상세 정보 버튼 작성 -->
					<p><a href="" class="btn btn-secondary" role="button">상세 정보&raquo;</a></p>
				</div>
		</div>
	</div>
	<!-- ========================= 상품목록 끝 ================================= -->
	<jsp:include page="footer.jsp"/>
</body>
</html>