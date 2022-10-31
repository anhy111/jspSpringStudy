<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<title>상품 목록</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<!-- --------------------상품목록 시작-------------------- -->
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 목록</h1>
		</div>
	</div>
<!-- ========================= 상품목록 시작 =================================== -->
	<div class="container">
		<div class="row" >
			<form class="text-center">
				<input type="text" placeholder="검색어를 입력하세요" name="keyword"
					value="${param.keyword}" />
				<input type="submit" class="btn btn-info" value="검색" />
			</form>
		</div>
		<div class="row" align="center">
			<c:forEach var="product" items="${data}">
				<div class="col-md-4">
					<img src="/resources/upload${product.filename}"
					style="width:100%;" alt="${product.pname}" title="${product.pname}" />
					<h3>${product.pname}</h3>
					<p>${product.description}</p>
					<p>${product.unitPrice}원</p>	
					<p><a href="/detail?productId=${product.productId}"
						class="btn btn-secondary" role="button">
						상세정보&raquo;></a></p>			
				</div>
			</c:forEach>
		</div>
		<div class="form-group row">
			<div class="col-sm-offset-2 col-sm-10">
				<input type="button" class="btn btn-primary" value="상품등록"
				onclick="location.href='/addProduct'" />
			</div>
		</div>
	</div>
	<!-- --------------------상품목록 끝-------------------- -->
	
	<jsp:include page="footer.jsp" />
</body>
</html>










