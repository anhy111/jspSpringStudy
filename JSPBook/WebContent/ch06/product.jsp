<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@page import="ch04.vo.ProductVO"%>
<%@page import="java.util.List"%>
<%@page import="ch04.dao.ProductRepository"%>
<!DOCTYPE html>
<%	
	String id = request.getParameter("id");
	ProductRepository productRepository = ProductRepository.getInstance();
	ProductVO productVO = productRepository.getProductById(id);
%>
<c:set var="productVO" value="<%=productVO%>" scope="page" />
<html>
<head>
<link rel="stylesheet" 
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 목록</title>
</head>
<body>
<jsp:include page="../ch06/menu.jsp"/>
<div class="jumbotron">
	<div class="container">
		<h1 class="display-3">상품목록</h1>
	</div>
</div>
<!-- ======================= 상품 상세 시작 ======================= -->
<div class="container">
	<div class="row" align="center">
		<div class="col-md-6">
			<h3>${productVO.pname }</h3>
			<p>
				<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhIDxF9Dyj9c6K7DVThI-y8wC0JmyDy8GZMQ&usqp=CAU">
			</p>
			<p>${productVO.description }</p>
			<p>
				<b>상품 코드 : </b>
				<span class="badge badge-danger">${productVO.productId}</span>
			</p>
			<p>
				<b>제조사 :</b> ${productVO.manufacturer }
			</p>
			<p>
				<b>분류 :</b> ${productVO.category}
			</p>
			<p>
				<b>재고 수 :</b> ${productVO.unitsInStock}
			</p>
			<h4>${productVO.unitsInStock}</h4>
			<p>
				<a href="#" class="btn btn-info">상품주문&raquo;</a>
				<a href="../ch06/products.jsp" class="btn btn-secondary">상품목록&raquo;</a>
			</p>
		</div>
	</div>
</div>
<!-- ==================== 상품 상세 끝 ==================== -->
<jsp:include page="../ch06/footer.jsp"/>
</body>
</html>